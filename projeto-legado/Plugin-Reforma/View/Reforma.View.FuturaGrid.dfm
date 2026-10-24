object frameFuturaGrid: TframeFuturaGrid
  Left = 0
  Top = 0
  Width = 1000
  Height = 560
  Align = alClient
  Color = 16770261
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = 14
  Font.Name = 'Arial'
  Font.Pitch = fpVariable
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  object pnlCusto: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 260
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlCusto'
    ParentColor = True
    ShowCaption = False
    TabOrder = 1
    object cxdPrecosCompra: TcxDBVerticalGrid
      Left = 0
      Top = 0
      Width = 313
      Height = 255
      BorderStyle = cxcbsNone
      Align = alLeft
      LookAndFeel.ScrollbarMode = sbmClassic
      OptionsView.ScrollBars = ssNone
      OptionsView.BandsInterval = 0
      OptionsView.RowHeaderWidth = 210
      OptionsView.RecordsInterval = 10
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.GoToNextCellOnTab = True
      OptionsBehavior.BandSizing = False
      OptionsBehavior.HeaderSizing = False
      OptionsBehavior.AllowChangeRecord = False
      OptionsData.Appending = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      Navigator.Buttons.CustomButtons = <>
      Styles.Background = cxsColunaFixa
      Styles.OnGetContentStyle = pGetContentStyle
      TabOrder = 0
      OnKeyDown = pCompraKeyDown
      DataController.GridMode = True
      Version = 1
      object cxdPrecosCompraCatPreCom: TcxCategoryRow
        Options.ShowExpandButton = False
        Options.TabStop = False
        Properties.Caption = 'Pre'#231'o de Compra L'#237'quido'
        Styles.Header = cxsTituloBlue
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxdPrecosCompraPREDOL: TcxDBEditorRow
        Properties.Caption = 'Pre'#231'o em D'#243'lar  '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
        Properties.EditProperties.ImmediatePost = True
        Properties.EditProperties.ValueChecked = 'S'
        Properties.EditProperties.ValueUnchecked = 'N'
        Properties.DataBinding.FieldName = 'ITE_PREDOL'
        Styles.Header = cxsColunaFixa
        ID = 1
        ParentID = 0
        Index = 0
        Version = 1
      end
      object cxdPrecosCompraPRECOM: TcxDBEditorRow
        Properties.Caption = 'Pre'#231'o de Compra  '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_PRECOM'
        Properties.OnGetDisplayText = pGetDisplayTextValor
        Styles.Header = cxsColunaFixa
        ID = 2
        ParentID = 0
        Index = 1
        Version = 1
      end
      object cxdPrecosCompraDESF01: TcxDBEditorRow
        Properties.Caption = 'Desconto 01 (-)  '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_DESF01'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 3
        ParentID = 0
        Index = 2
        Version = 1
      end
      object cxdPrecosCompraDESF02: TcxDBEditorRow
        Properties.Caption = 'Desconto 02 (-)  '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_DESF02'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 4
        ParentID = 0
        Index = 3
        Version = 1
      end
      object cxdPrecosCompraDESF03: TcxDBEditorRow
        Properties.Caption = 'Desconto 03 (-)  '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_DESF03'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 5
        ParentID = 0
        Index = 4
        Version = 1
      end
      object cxdPrecosCompraDESF04: TcxDBEditorRow
        Properties.Caption = 'Desconto 04 (-)  '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_DESF04'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 6
        ParentID = 0
        Index = 5
        Version = 1
      end
      object cxdPrecosCompraDESF05: TcxDBEditorRow
        Properties.Caption = 'Desconto 05 (-)  '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_DESF05'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 7
        ParentID = 0
        Index = 6
        Version = 1
      end
      object cxdPrecosCompraDESF06: TcxDBEditorRow
        Properties.Caption = 'Desconto 06 (-)  '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_DESF06'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 8
        ParentID = 0
        Index = 7
        Version = 1
      end
      object cxdPrecosCompraCOMLIQ: TcxDBEditorRow
        Options.TabStop = False
        Properties.Caption = 'Pre'#231'o de Compra L'#237'quido  '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 4
        Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
        Properties.DataBinding.FieldName = 'COMLIQ'
        Properties.Options.Editing = False
        Properties.OnGetDisplayText = pGetDisplayTextValor
        Styles.Header = cxsColunaFixaDestaque
        Styles.Content = cxsColunaFixaDestaque
        ID = 9
        ParentID = 0
        Index = 8
        Version = 1
      end
    end
    object cxdPrecosCusto: TcxDBVerticalGrid
      Left = 313
      Top = 0
      Width = 313
      Height = 255
      BorderStyle = cxcbsNone
      Align = alLeft
      LookAndFeel.ScrollbarMode = sbmClassic
      OptionsView.ScrollBars = ssNone
      OptionsView.BandsInterval = 0
      OptionsView.RowHeaderWidth = 210
      OptionsView.RecordsInterval = 10
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.GoToNextCellOnTab = True
      OptionsBehavior.BandSizing = False
      OptionsBehavior.HeaderSizing = False
      OptionsBehavior.AllowChangeRecord = False
      OptionsData.Appending = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      Navigator.Buttons.CustomButtons = <>
      Styles.Background = cxsColunaFixa
      Styles.OnGetContentStyle = pGetContentStyle
      TabOrder = 1
      OnKeyDown = pCustoKeyDown
      DataController.GridMode = True
      Version = 1
      object cxCategoryRow7: TcxCategoryRow
        Options.ShowExpandButton = False
        Options.TabStop = False
        Properties.Caption = 'Pre'#231'o de Custo'
        Styles.Header = cxsTituloBlue
        ID = 0
        ParentID = -1
        Index = 1
        Version = 1
      end
      object cxdPrecosCustoICMENT: TcxDBEditorRow
        Properties.Caption = 'ICMS de Entrada (-)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 2
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_ICMENT'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 1
        ParentID = 0
        Index = 9
        Version = 1
      end
      object cxdPrecosCustoIPIENT: TcxDBEditorRow
        Properties.Caption = 'IPI Entrada (+)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 2
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_IPIENT'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 7
        ParentID = 0
        Index = 10
        Version = 1
      end
      object cxdPrecosCustoFREENT: TcxDBEditorRow
        Properties.Caption = 'Frete (+)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 2
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_FREENT'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 8
        ParentID = 0
        Index = 11
        Version = 1
      end
      object cxdPrecosCustoVALFRE: TcxDBEditorRow
        Properties.Caption = 'Valor do Frete (+)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 4
        Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
        Properties.DataBinding.FieldName = 'ITE_VALFRE'
        Properties.OnGetDisplayText = pGetDisplayTextValor
        Styles.Header = cxsColunaFixa
        ID = 9
        ParentID = 0
        Index = 12
        Version = 1
      end
      object cxdPrecosCustoACRFIN: TcxDBEditorRow
        Properties.Caption = 'Acr'#233'scimo Financeiro (+)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 2
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_ACRFIN'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 10
        ParentID = 0
        Index = 13
        Version = 1
      end
      object cxdPrecosCustoSUBSTI: TcxDBEditorRow
        Properties.Caption = 'Substitui'#231#227'o Tribut'#225'ria (+)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 2
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_SUBSTI'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 11
        ParentID = 0
        Index = 14
        Version = 1
      end
      object cxdPrecosCustoDESADB: TcxDBEditorRow
        Properties.Caption = 'Descontos Adicionais (-)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 2
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_DESADB'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 12
        ParentID = 0
        Index = 15
        Version = 1
      end
      object cxdPrecosCustoPRECUS: TcxDBEditorRow
        Options.TabStop = False
        Properties.Caption = 'Pre'#231'o de Custo   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 4
        Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
        Properties.DataBinding.FieldName = 'ITE_PRECUS'
        Properties.Options.Editing = False
        Properties.OnGetDisplayText = pGetDisplayTextValor
        Styles.Header = cxsColunaFixaDestaque
        Styles.Content = cxsColunaFixaDestaque
        ID = 13
        ParentID = 0
        Index = 16
        Version = 1
      end
    end
    object cxdPrecosCustoReal: TcxDBVerticalGrid
      Left = 626
      Top = 0
      Width = 313
      Height = 255
      BorderStyle = cxcbsNone
      Align = alLeft
      LookAndFeel.ScrollbarMode = sbmClassic
      OptionsView.ScrollBars = ssNone
      OptionsView.BandsInterval = 0
      OptionsView.RowHeaderWidth = 210
      OptionsView.RecordsInterval = 10
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.GoToNextCellOnTab = True
      OptionsBehavior.BandSizing = False
      OptionsBehavior.HeaderSizing = False
      OptionsBehavior.AllowChangeRecord = False
      OptionsData.Appending = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      Navigator.Buttons.CustomButtons = <>
      Styles.Background = cxsColunaFixa
      Styles.OnGetContentStyle = pGetContentStyle
      TabOrder = 2
      OnKeyDown = pCustoRealKeyDown
      DataController.GridMode = True
      Version = 1
      object cxCategoryRow3: TcxCategoryRow
        Options.ShowExpandButton = False
        Options.TabStop = False
        Properties.Caption = 'Pre'#231'o de Custo Real'
        Styles.Header = cxsTituloBlue
        ID = 0
        ParentID = -1
        Index = 2
        Version = 1
      end
      object cxdPrecosCustoRealTCIFCU: TcxDBEditorRow
        Properties.Caption = 'TCIF (+)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 6
        Properties.EditProperties.DisplayFormat = '#,##0.000000;-#,##0.000000'
        Properties.DataBinding.FieldName = 'ITE_TCIFCU'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 1
        ParentID = 0
        Index = 17
        Version = 1
      end
      object cxdPrecosCustoRealTSCUST: TcxDBEditorRow
        Properties.Caption = 'TS (+)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 6
        Properties.EditProperties.DisplayFormat = '#,##0.000000;-#,##0.000000'
        Properties.DataBinding.FieldName = 'ITE_TSCUST'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 2
        ParentID = 0
        Index = 18
        Version = 1
      end
      object cxdPrecosCustoRealDEPICO: TcxDBEditorRow
        Properties.Caption = 'Desconto PIS/COFINS (-)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_DEPICO'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 3
        ParentID = 0
        Index = 19
        Version = 1
      end
      object cxdPrecosCustoRealDEICMS: TcxDBEditorRow
        Properties.Caption = 'Desconto ICMS (-)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_DEICMS'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 4
        ParentID = 0
        Index = 20
        Version = 1
      end
      object cxdPrecosCustoRealFATREG: TcxDBEditorRow
        Properties.Caption = 'Fator regional (+)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_FATREG'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 5
        ParentID = 0
        Index = 21
        Version = 1
      end
      object cxdPrecosCustoRealOUTVAL: TcxDBEditorRow
        Properties.Caption = 'Outros Valores (+)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 4
        Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
        Properties.DataBinding.FieldName = 'ITE_OUTVAL'
        Properties.OnGetDisplayText = pGetDisplayTextValor
        Styles.Header = cxsColunaFixa
        ID = 6
        ParentID = 0
        Index = 22
        Version = 1
      end
      object cxdPrecosCustoRealICMSAI: TcxDBEditorRow
        Properties.Caption = 'ICMS Sa'#237'da (+)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 2
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_ICMSAI'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 7
        ParentID = 0
        Index = 23
        Version = 1
      end
      object cxdPrecosCustoRealDESOPE: TcxDBEditorRow
        Properties.Caption = 'Despesas Operacionais (+)   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 2
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_DESOPE'
        Properties.OnGetDisplayText = pGetDisplayTextPercencual
        Styles.Header = cxsColunaFixa
        ID = 9
        ParentID = 0
        Index = 24
        Version = 1
      end
      object cxdPrecosCustoRealCUSREA: TcxDBEditorRow
        Options.TabStop = False
        Properties.Caption = 'Pre'#231'o de Custo Real   '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 4
        Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
        Properties.DataBinding.FieldName = 'CUSREA'
        Properties.Options.Editing = False
        Properties.OnGetDisplayText = pGetDisplayTextValor
        Styles.Header = cxsColunaFixaDestaque
        Styles.Content = cxsColunaFixaDestaque
        ID = 10
        ParentID = 0
        Index = 25
        Version = 1
      end
      object cxdPrecosCustoRealCategoryREDTAR: TcxCategoryRow
        Options.ShowExpandButton = False
        Properties.Caption = 'Redu'#231#227'o TARE'
        Styles.Header = cxsTituloBlue
        ID = 11
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxdPrecosCustoRealREDTAR: TcxDBEditorRow
        Properties.Caption = 'Redu'#231#227'o TARE  '
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
        Properties.DataBinding.FieldName = 'ITE_REDTAR'
        Properties.OnGetDisplayText = pGetDisplayTextValor
        Styles.Header = cxsColunaFixa
        ID = 12
        ParentID = 11
        Index = 0
        Version = 1
      end
    end
    object pnlSeparador: TPanel
      Left = 0
      Top = 255
      Width = 451
      Height = 5
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlSeparador'
      Color = 15132390
      ParentBackground = False
      ShowCaption = False
      TabOrder = 3
    end
  end
  object cxdPrecos: TcxDBVerticalGrid
    Left = 0
    Top = 286
    Width = 451
    Height = 19
    BorderStyle = cxcbsNone
    Align = alClient
    LayoutStyle = lsMultiRecordView
    LookAndFeel.ScrollbarMode = sbmClassic
    OptionsView.ScrollBars = ssVertical
    OptionsView.BandsInterval = 0
    OptionsView.RowHeaderWidth = 210
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
    Styles.OnGetContentStyle = pGetContentStyle
    TabOrder = 2
    OnKeyDown = pPrecosKeyDown
    DataController.GridMode = True
    Version = 1
    object cxdPrecosTABELA: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Tabela   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taCenter
      Properties.DataBinding.FieldName = 'ITE_NROTAB'
      Properties.Options.Editing = False
      Styles.Header = cxsColunaFixa
      Styles.Content = cxsColunaFixa
      ID = 0
      ParentID = -1
      Index = 0
      Version = 1
    end
    object cxdPrecosCatPreCom: TcxCategoryRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Compra L'#237'quido'
      Styles.Header = cxsTituloBlue
      ID = 1
      ParentID = -1
      Index = 1
      Version = 1
    end
    object cxdPrecosPREDOL: TcxDBEditorRow
      Properties.Caption = 'Pre'#231'o em D'#243'lar  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
      Properties.EditProperties.ImmediatePost = True
      Properties.EditProperties.ValueChecked = 'S'
      Properties.EditProperties.ValueUnchecked = 'N'
      Properties.DataBinding.FieldName = 'ITE_PREDOL'
      Styles.Header = cxsColunaFixa
      ID = 2
      ParentID = 1
      Index = 0
      Version = 1
    end
    object cxdPrecosPRECOM: TcxDBEditorRow
      Properties.Caption = 'Pre'#231'o de Compra  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_PRECOM'
      Properties.OnGetDisplayText = pGetDisplayTextValor
      Styles.Header = cxsColunaFixa
      ID = 3
      ParentID = 1
      Index = 1
      Version = 1
    end
    object cxdPrecosDESF01: TcxDBEditorRow
      Properties.Caption = 'Desconto 01 (-)  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_DESF01'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 4
      ParentID = 1
      Index = 2
      Version = 1
    end
    object cxdPrecosDESF02: TcxDBEditorRow
      Properties.Caption = 'Desconto 02 (-)  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_DESF02'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 5
      ParentID = 1
      Index = 3
      Version = 1
    end
    object cxdPrecosDESF03: TcxDBEditorRow
      Properties.Caption = 'Desconto 03 (-)  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_DESF03'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 6
      ParentID = 1
      Index = 4
      Version = 1
    end
    object cxdPrecosDESF04: TcxDBEditorRow
      Properties.Caption = 'Desconto 04 (-)  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_DESF04'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 7
      ParentID = 1
      Index = 5
      Version = 1
    end
    object cxdPrecosDESF05: TcxDBEditorRow
      Properties.Caption = 'Desconto 05 (-)  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_DESF05'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 8
      ParentID = 1
      Index = 6
      Version = 1
    end
    object cxdPrecosDESF06: TcxDBEditorRow
      Properties.Caption = 'Desconto 06 (-)  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_DESF06'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 9
      ParentID = 1
      Index = 7
      Version = 1
    end
    object cxdPrecosCOMLIQ: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Compra L'#237'quido  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 4
      Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
      Properties.DataBinding.FieldName = 'COMLIQ'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = pGetDisplayTextValor
      Styles.Header = cxsColunaFixaDestaque
      Styles.Content = cxsColunaFixaDestaque
      ID = 10
      ParentID = 1
      Index = 8
      Version = 1
    end
    object cxdPrecosCatPreCus: TcxCategoryRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Custo'
      Styles.Header = cxsTituloBlue
      ID = 11
      ParentID = -1
      Index = 2
      Version = 1
    end
    object cxdPrecosICMENT: TcxDBEditorRow
      Properties.Caption = 'ICMS de Entrada (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_ICMENT'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 12
      ParentID = 11
      Index = 0
      Version = 1
    end
    object cxdPrecosIPIENT: TcxDBEditorRow
      Properties.Caption = 'IPI Entrada (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_IPIENT'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 18
      ParentID = 11
      Index = 1
      Version = 1
    end
    object cxdPrecosFREENT: TcxDBEditorRow
      Properties.Caption = 'Frete (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_FREENT'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 19
      ParentID = 11
      Index = 2
      Version = 1
    end
    object cxdPrecosVALFRE: TcxDBEditorRow
      Properties.Caption = 'Valor do Frete (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 4
      Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
      Properties.DataBinding.FieldName = 'ITE_VALFRE'
      Properties.OnGetDisplayText = pGetDisplayTextValor
      Styles.Header = cxsColunaFixa
      ID = 20
      ParentID = 11
      Index = 3
      Version = 1
    end
    object cxdPrecosACRFIN: TcxDBEditorRow
      Properties.Caption = 'Acr'#233'scimo Financeiro (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_ACRFIN'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 21
      ParentID = 11
      Index = 4
      Version = 1
    end
    object cxdPrecosSUBSTI: TcxDBEditorRow
      Properties.Caption = 'Substitui'#231#227'o Tribut'#225'ria (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_SUBSTI'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 22
      ParentID = 11
      Index = 5
      Version = 1
    end
    object cxdPrecosDESADB: TcxDBEditorRow
      Properties.Caption = 'Descontos Adicionais (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_DESADB'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 23
      ParentID = 11
      Index = 6
      Version = 1
    end
    object cxdPrecosPRECUS: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Custo   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 4
      Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
      Properties.DataBinding.FieldName = 'ITE_PRECUS'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = pGetDisplayTextValor
      Styles.Header = cxsColunaFixaDestaque
      Styles.Content = cxsColunaFixaDestaque
      ID = 24
      ParentID = 11
      Index = 7
      Version = 1
    end
    object cxdPrecosCatCusRea: TcxCategoryRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Custo Real'
      Styles.Header = cxsTituloBlue
      ID = 25
      ParentID = -1
      Index = 3
      Version = 1
    end
    object cxdPrecosTCIFCU: TcxDBEditorRow
      Properties.Caption = 'TCIF (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 6
      Properties.EditProperties.DisplayFormat = '#,##0.000000;-#,##0.000000'
      Properties.DataBinding.FieldName = 'ITE_TCIFCU'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 26
      ParentID = 25
      Index = 0
      Version = 1
    end
    object cxdPrecosTSCUST: TcxDBEditorRow
      Properties.Caption = 'TS (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 6
      Properties.EditProperties.DisplayFormat = '#,##0.000000;-#,##0.000000'
      Properties.DataBinding.FieldName = 'ITE_TSCUST'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 27
      ParentID = 25
      Index = 1
      Version = 1
    end
    object cxdPrecosDEPICO: TcxDBEditorRow
      Properties.Caption = 'Desconto PIS/COFINS (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_DEPICO'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 28
      ParentID = 25
      Index = 2
      Version = 1
    end
    object cxdPrecosDEICMS: TcxDBEditorRow
      Properties.Caption = 'Desconto ICMS (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_DEICMS'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 29
      ParentID = 25
      Index = 3
      Version = 1
    end
    object cxdPrecosFATREG: TcxDBEditorRow
      Properties.Caption = 'Fator regional (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_FATREG'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 30
      ParentID = 25
      Index = 4
      Version = 1
    end
    object cxdPrecosOUTVAL: TcxDBEditorRow
      Properties.Caption = 'Outros Valores (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 4
      Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
      Properties.DataBinding.FieldName = 'ITE_OUTVAL'
      Properties.OnGetDisplayText = pGetDisplayTextValor
      Styles.Header = cxsColunaFixa
      ID = 31
      ParentID = 25
      Index = 5
      Version = 1
    end
    object cxdPrecosICMSAI: TcxDBEditorRow
      Properties.Caption = 'ICMS Sa'#237'da (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_ICMSAI'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 32
      ParentID = 25
      Index = 6
      Version = 1
    end
    object cxdPrecosDESOPE: TcxDBEditorRow
      Properties.Caption = 'Despesas Operacionais (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_DESOPE'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 34
      ParentID = 25
      Index = 7
      Version = 1
    end
    object cxdPrecosCUSREA: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Custo Real   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 4
      Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
      Properties.DataBinding.FieldName = 'CUSREA'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = pGetDisplayTextValor
      Styles.Header = cxsColunaFixaDestaque
      Styles.Content = cxsColunaFixaDestaque
      ID = 35
      ParentID = 25
      Index = 8
      Version = 1
    end
    object cxdPrecosCatPreVen: TcxCategoryRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Venda'
      Styles.Header = cxsTituloRed
      ID = 36
      ParentID = -1
      Index = 4
      Version = 1
    end
    object cxdPrecosREDTAR: TcxDBEditorRow
      Properties.Caption = 'Redu'#231#227'o TARE  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.DataBinding.FieldName = 'REDTAR'
      Properties.OnGetDisplayText = pGetDisplayTextValor
      Styles.Header = cxsColunaFixa
      ID = 37
      ParentID = 36
      Index = 0
      Version = 1
    end
    object cxdPrecosUSATAR: TcxDBEditorRow
      Properties.Caption = 'Utiliza Redu'#231#227'o TARE  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
      Properties.EditProperties.ImmediatePost = True
      Properties.EditProperties.ValueChecked = 'S'
      Properties.EditProperties.ValueUnchecked = 'N'
      Properties.DataBinding.FieldName = 'ITE_USATAR'
      Styles.Header = cxsColunaFixa
      ID = 38
      ParentID = 36
      Index = 1
      Version = 1
    end
    object cxdPrecosMARBRU: TcxDBEditorRow
      Properties.Caption = 'Margem   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 8
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_MARBRU'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsMargem
      ID = 39
      ParentID = 36
      Index = 2
      Version = 1
    end
    object cxdPrecosMARMK3: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Margem   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.Options.Editing = False
      Styles.Header = cxsColunaFixa
      Styles.Content = cxsColunaFixa
      Visible = False
      ID = 40
      ParentID = 36
      Index = 3
      Version = 1
    end
    object cxdPrecosCOMISS: TcxDBEditorRow
      Properties.Caption = 'Comiss'#227'o   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_COMTBL'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 41
      ParentID = 36
      Index = 4
      Version = 1
    end
    object cxdPrecosPREVEN: TcxDBEditorRow
      Properties.Caption = 'Pre'#231'o de Venda   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 4
      Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
      Properties.DataBinding.FieldName = 'ITE_PREVEN'
      Properties.OnGetDisplayText = pGetDisplayTextValor
      Styles.Header = cxsPreco
      Styles.Content = cxsNegrito
      ID = 42
      ParentID = 36
      Index = 5
      Version = 1
    end
    object cxdPrecosFATPRE: TcxDBEditorRow
      Properties.Caption = 'Fator Tabela   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 4
      Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
      Properties.DataBinding.FieldName = 'FATPRE'
      Properties.OnGetDisplayText = pGetDisplayTextFator
      Styles.Header = cxsColunaFixa
      ID = 43
      ParentID = 36
      Index = 6
      Version = 1
    end
    object cxdPrecosCUSVEN: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Custo da Venda   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 4
      Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
      Properties.DataBinding.FieldName = 'CUSVEN'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = pGetDisplayTextValor
      Styles.Header = cxsColunaFixa
      Styles.Content = cxsColunaFixa
      ID = 44
      ParentID = 36
      Index = 7
      Version = 1
    end
    object cxdPrecosCBS: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'CBS   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'CBS'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 45
      ParentID = 36
      Index = 8
      Version = 1
    end
    object cxdPrecosIBS: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'IBS   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'IBS'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 46
      ParentID = 36
      Index = 9
      Version = 1
    end
    object cxdPrecosISVAL: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'IS   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ISVAL'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixa
      ID = 47
      ParentID = 36
      Index = 10
      Version = 1
    end
    object cxdPrecosPREIMP: TcxDBEditorRow
      Properties.Caption = 'Pre'#231'o de Venda c/ Impostos   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 4
      Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
      Properties.DataBinding.FieldName = 'PREIMP'
      Properties.OnGetDisplayText = pGetDisplayTextValor
      Styles.Header = cxsPreco
      ID = 48
      ParentID = 36
      Index = 11
      Version = 1
    end
    object cxdPrecosPREVEI: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Venda+(IPI+ST)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 4
      Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
      Properties.DataBinding.FieldName = 'PREVEI'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = pGetDisplayTextValor
      Styles.Header = cxsColunaFixa
      Styles.Content = cxsColunaFixa
      Visible = False
      ID = 49
      ParentID = 36
      Index = 12
      Version = 1
    end
    object cxdPrecosPRCDOL: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Venda US$   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 4
      Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
      Properties.DataBinding.FieldName = 'PREDOL'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = pGetDisplayTextValor
      Styles.Header = cxsPreco
      Styles.Content = cxsColunaFixa
      ID = 50
      ParentID = 36
      Index = 13
      Version = 1
    end
    object cxdPrecosMARKUP: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Hint MARKUP'
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 4
      Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
      Properties.DataBinding.FieldName = 'MARKUP'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsColunaFixaDestaque
      Styles.Content = cxsColunaFixaDestaque
      Visible = False
      ID = 51
      ParentID = 36
      Index = 14
      Version = 1
    end
    object cxdPrecosCatMarIde: TcxCategoryRow
      Options.TabStop = False
      Properties.Caption = 'Margem Ideal'
      Styles.Header = cxsTituloRed
      ID = 52
      ParentID = -1
      Index = 5
      Version = 1
    end
    object cxdPrecosMARIDE: TcxDBEditorRow
      Properties.Caption = 'Margem Ideal   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 8
      Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.DataBinding.FieldName = 'ITE_MARIDE'
      Properties.OnGetDisplayText = pGetDisplayTextPercencual
      Styles.Header = cxsMargem
      ID = 53
      ParentID = 52
      Index = 0
      Version = 1
    end
    object cxdPrecosPREIDE: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o Venda Ideal   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 4
      Properties.EditProperties.DisplayFormat = '#,##0.0000;-#,##0.0000'
      Properties.DataBinding.FieldName = 'PREIDE'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = pGetDisplayTextValor
      Styles.Header = cxsPreco
      Styles.Content = cxsColunaFixa
      ID = 54
      ParentID = 52
      Index = 1
      Version = 1
    end
    object cxdPrecosIMPPRE: TcxDBEditorRow
      Properties.Caption = 'Hint Pre'#231'o de Venda + Impostos'
      Properties.DataBinding.FieldName = 'IMPPRE'
      Visible = False
      ID = 55
      ParentID = -1
      Index = 6
      Version = 1
    end
  end
  object pnlValidacaoFut: TPanel
    Left = 0
    Top = 0
    Width = 120
    Height = 40
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 3
    Visible = False
    object pnlCamposSuframaFut: TPanel
      Left = 0
      Top = 0
      Width = 60
      Height = 20
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
    end
    object dbePreComFut: TDBEditFocus
      Left = 0
      Top = 0
      Width = 60
      Height = 21
      DataField = 'ITE_PRECOM'
      DataSource = dtsCalculadora
      TabOrder = 19
      Visible = False
    end
    object dbeDesF01Fut: TDBEditFocus
      Left = 0
      Top = 21
      Width = 60
      Height = 21
      DataField = 'ITE_DESF01'
      DataSource = dtsCalculadora
      TabOrder = 29
      Visible = False
    end
    object dbeDesF02Fut: TDBEditFocus
      Left = 0
      Top = 42
      Width = 60
      Height = 21
      DataField = 'ITE_DESF02'
      DataSource = dtsCalculadora
      TabOrder = 9
      Visible = False
    end
    object dbeDesF03Fut: TDBEditFocus
      Left = 0
      Top = 63
      Width = 60
      Height = 21
      DataField = 'ITE_DESF03'
      DataSource = dtsCalculadora
      TabOrder = 19
      Visible = False
    end
    object dbeDesF04Fut: TDBEditFocus
      Left = 0
      Top = 84
      Width = 60
      Height = 21
      DataField = 'ITE_DESF04'
      DataSource = dtsCalculadora
      TabOrder = 29
      Visible = False
    end
    object dbeDesF05Fut: TDBEditFocus
      Left = 0
      Top = 105
      Width = 60
      Height = 21
      DataField = 'ITE_DESF05'
      DataSource = dtsCalculadora
      TabOrder = 9
      Visible = False
    end
    object dbeDesF06Fut: TDBEditFocus
      Left = 0
      Top = 126
      Width = 60
      Height = 21
      DataField = 'ITE_DESF06'
      DataSource = dtsCalculadora
      TabOrder = 19
      Visible = False
    end
    object dbeIcmEntFut: TDBEditFocus
      Left = 0
      Top = 147
      Width = 60
      Height = 21
      DataField = 'ITE_ICMENT'
      DataSource = dtsCalculadora
      TabOrder = 29
      Visible = False
    end
    object dbeIpiEntFut: TDBEditFocus
      Left = 0
      Top = 168
      Width = 60
      Height = 21
      DataField = 'ITE_IPIENT'
      DataSource = dtsCalculadora
      TabOrder = 9
      Visible = False
    end
    object dbeFreEntFut: TDBEditFocus
      Left = 0
      Top = 189
      Width = 60
      Height = 21
      DataField = 'ITE_FREENT'
      DataSource = dtsCalculadora
      TabOrder = 19
      Visible = False
    end
    object dbeValFreFut: TDBEditFocus
      Left = 0
      Top = 210
      Width = 60
      Height = 21
      DataField = 'ITE_VALFRE'
      DataSource = dtsCalculadora
      TabOrder = 29
      Visible = False
    end
    object dbeAcrFinFut: TDBEditFocus
      Left = 0
      Top = 231
      Width = 60
      Height = 21
      DataField = 'ITE_ACRFIN'
      DataSource = dtsCalculadora
      TabOrder = 9
      Visible = False
    end
    object dbeSubstiFut: TDBEditFocus
      Left = 0
      Top = 252
      Width = 60
      Height = 21
      DataField = 'ITE_SUBSTI'
      DataSource = dtsCalculadora
      TabOrder = 19
      Visible = False
    end
    object dbeDesAdbFut: TDBEditFocus
      Left = 0
      Top = 273
      Width = 60
      Height = 21
      DataField = 'ITE_DESADB'
      DataSource = dtsCalculadora
      TabOrder = 29
      Visible = False
    end
    object dbeTCIFFut: TDBEditFocus
      Left = 0
      Top = 294
      Width = 60
      Height = 21
      DataField = 'ITE_TCIFCU'
      DataSource = dtsCalculadora
      TabOrder = 9
      Visible = False
    end
    object dbeTSFut: TDBEditFocus
      Left = 0
      Top = 315
      Width = 60
      Height = 21
      DataField = 'ITE_TSCUST'
      DataSource = dtsCalculadora
      TabOrder = 19
      Visible = False
    end
    object dbeDePiCoFut: TDBEditFocus
      Left = 0
      Top = 336
      Width = 60
      Height = 21
      DataField = 'ITE_DEPICO'
      DataSource = dtsCalculadora
      TabOrder = 29
      Visible = False
    end
    object dbeDeICMSFut: TDBEditFocus
      Left = 0
      Top = 357
      Width = 60
      Height = 21
      DataField = 'ITE_DEICMS'
      DataSource = dtsCalculadora
      TabOrder = 9
      Visible = False
    end
    object dbeFatRegFut: TDBEditFocus
      Left = 0
      Top = 378
      Width = 60
      Height = 21
      DataField = 'ITE_FATREG'
      DataSource = dtsCalculadora
      TabOrder = 19
      Visible = False
    end
    object dbeOutValFut: TDBEditFocus
      Left = 0
      Top = 399
      Width = 60
      Height = 21
      DataField = 'ITE_OUTVAL'
      DataSource = dtsCalculadora
      TabOrder = 29
      Visible = False
    end
    object dbeIcmSaiFut: TDBEditFocus
      Left = 0
      Top = 420
      Width = 60
      Height = 21
      DataField = 'ITE_ICMSAI'
      DataSource = dtsCalculadora
      TabOrder = 9
      Visible = False
    end
    object dbeDesOpeFut: TDBEditFocus
      Left = 0
      Top = 441
      Width = 60
      Height = 21
      DataField = 'ITE_DESOPE'
      DataSource = dtsCalculadora
      TabOrder = 19
      Visible = False
    end
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 448
    Top = 320
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
      Color = 15132390
      TextColor = clBlue
    end
    object cxsTituloRed: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 15132390
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
    object cxsInfoback: TcxStyle
      AssignedValues = [svColor]
      Color = clInfoBk
    end
    object cxsTituloBlack: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxsCategoriaBlack: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 15132390
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clBlack
    end
  end
  object dtsCalculadora: TDataSource
    Left = 940
    Top = 8
  end
  object dtsCusto: TDataSource
    Left = 940
    Top = 56
  end
  object dtsTabelas: TDataSource
    Left = 940
    Top = 104
  end
end
