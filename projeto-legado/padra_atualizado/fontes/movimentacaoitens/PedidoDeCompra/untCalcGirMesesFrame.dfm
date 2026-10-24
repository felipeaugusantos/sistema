object fraCalcGirMesesFrame: TfraCalcGirMesesFrame
  Left = 0
  Top = 0
  Width = 987
  Height = 335
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object gpbCalcGir: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    Caption = 'C'#225'lculo do Giro:'
    ParentFont = False
    Style.BorderColor = clBlack
    Style.BorderStyle = ebsUltraFlat
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = 14
    Style.Font.Name = 'Arial'
    Style.Font.Pitch = fpVariable
    Style.Font.Style = []
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.LookAndFeel.NativeStyle = False
    Style.Shadow = True
    Style.IsFontAssigned = True
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleDisabled.LookAndFeel.NativeStyle = False
    TabOrder = 0
    Height = 285
    Width = 987
    object pnlFixo: TPanel
      Left = 2
      Top = 19
      Width = 980
      Height = 260
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object lblDiaComGer: TLabel
        Left = 74
        Top = 212
        Width = 93
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dias Compra Geral:'
      end
      object lblPerConGer: TLabel
        Left = 14
        Top = 233
        Width = 153
        Height = 14
        Alignment = taRightJustify
        Caption = '% Eleva'#231#227'o Consum'#237'veis Geral:'
      end
      object cxGroupBox9: TcxGroupBox
        Left = 13
        Top = 0
        Caption = 'Op'#231#227'o de Giro:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = False
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        TabOrder = 0
        Height = 169
        Width = 306
        object lblSelMes: TLabel
          Left = 111
          Top = 64
          Width = 180
          Height = 14
          Cursor = crHandPoint
          Caption = 'Clique aqui para selecionar os meses'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = lblSelMesClick
        end
        object rdgOpcGir: TRadioGroup
          Left = 11
          Top = 19
          Width = 280
          Height = 37
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            '3 meses'
            '6 meses'
            '12 meses')
          TabOrder = 0
          OnClick = rdgOpcGirClick
        end
        object chkInfMes: TCheckBox
          Left = 12
          Top = 64
          Width = 97
          Height = 17
          Caption = 'Informar meses'
          TabOrder = 1
          OnClick = chkInfMesClick
        end
        object rdgTipMed: TRadioGroup
          Left = 11
          Top = 90
          Width = 280
          Height = 68
          Caption = 'Para o c'#225'lculo da sugest'#227'o considerar:'
          ItemIndex = 0
          Items.Strings = (
            'M'#233'dia Integral (considera todos os meses)'
            'M'#233'dia Ajustada (despreza o maior e o menor m'#234's)')
          TabOrder = 2
        end
      end
      object chkMesAtu: TCheckBox
        Left = 15
        Top = 183
        Width = 215
        Height = 13
        Caption = 'Considerar m'#234's atual no c'#225'lculo do giro'
        TabOrder = 1
      end
      object edtDiaComGer_: TEditFocus
        Tag = 99
        Left = 168
        Top = 205
        Width = 43
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 4
        TabOrder = 2
        Text = '30'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object grbBasGir: TcxGroupBox
        Left = 696
        Top = 0
        Caption = 'Base para C'#225'lculo do Giro (M'#234's/Ano): '
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = False
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        TabOrder = 3
        Height = 113
        Width = 270
        object lstBasGir: TCheckListBox
          Tag = 99
          Left = 9
          Top = 16
          Width = 251
          Height = 84
          OnClickCheck = lstBasGirClickCheck
          Columns = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ItemHeight = 14
          ParentFont = False
          TabOrder = 0
          OnKeyDown = lstBasGirKeyDown
        end
      end
      object grbNivel: TcxGroupBox
        Left = 325
        Top = 0
        Caption = 'N'#237'vel de Giro e Criticidade'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = False
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        TabOrder = 4
        Height = 260
        Width = 365
        object cmbTipNiv: TComboBoxFocus
          Left = 13
          Top = 24
          Width = 238
          Height = 22
          AutoCloseUp = True
          Style = csDropDownList
          TabOrder = 0
          OnChange = cmbTipNivChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object cxgNivel: TcxGridCitel
          Left = 13
          Top = 52
          Width = 338
          Height = 197
          TabOrder = 1
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxvNivel: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            OnEditKeyDown = cxvNivelEditKeyDown
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object cxvNivelNIVGIR: TcxGridDBColumn
              Caption = 'N'#237'vel'
              DataBinding.FieldName = 'NIVGIR'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 65
            end
            object cxvNivelUSANIV: TcxGridDBColumn
              Caption = 'Calcular'
              DataBinding.FieldName = 'USANIV'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ImmediatePost = True
              Properties.ValueChecked = 'S'
              Properties.ValueUnchecked = 'N'
              HeaderAlignmentHorz = taCenter
              Width = 65
            end
            object cxvNivelQTDDIA: TcxGridDBColumn
              Caption = 'Dias de Compra'
              DataBinding.FieldName = 'QTDDIA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DecimalPlaces = 0
              Properties.DisplayFormat = '0;-0'
              Properties.OnValidate = cxvNivelQTDDIAPropertiesValidate
              HeaderAlignmentHorz = taRightJustify
              Width = 90
            end
            object cxvNivelPERCON: TcxGridDBColumn
              Caption = '% Eleva'#231#227'o Consum'#237'veis'
              DataBinding.FieldName = 'PERCON'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              Width = 137
            end
          end
          object cxgNivelLevel1: TcxGridLevel
            GridView = cxvNivel
          end
        end
      end
      object edtPerConGer: TEditFocus
        Tag = 99
        Left = 168
        Top = 229
        Width = 43
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 4
        TabOrder = 5
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 285
    Width = 987
    Height = 50
    Align = alClient
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 1
    object grbOpcGir: TcxGroupBox
      Left = 15
      Top = 0
      Caption = 'Itens:'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = 14
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = []
      Style.Shadow = True
      Style.IsFontAssigned = True
      TabOrder = 0
      Height = 45
      Width = 199
      object ColorLabel4: TColorLabel
        Left = 28
        Top = 18
        Width = 168
        Height = 13
        AutoSize = False
        Caption = '(C)om Giro (S)em Giro (T)odos'
        Transparent = True
        CorDestaque = clRed
      end
      object edtFilGir: TEditFocus
        Tag = 99
        Left = 7
        Top = 14
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'C'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object chkExibItens: TCheckBox
      Left = 238
      Top = 18
      Width = 239
      Height = 17
      Caption = 'Exibir itens sem necessidade de compra'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chkEmbala: TCheckBox
      Left = 519
      Top = 18
      Width = 363
      Height = 17
      Caption = 
        'Converter quantidade sugerida para embalagem principal de compra' +
        's'
      TabOrder = 2
    end
  end
end
