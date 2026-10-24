inherited frmCadastroCartaoTefConferencia: TfrmCadastroCartaoTefConferencia
  Width = 1106
  Height = 628
  Caption = 'Confer'#234'ncia Dados TEF'
  ExplicitWidth = 1106
  ExplicitHeight = 628
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 557
    Width = 1100
    ExplicitTop = 557
    ExplicitWidth = 1100
    inherited FlwBotoes: TFlowPanel
      Width = 1096
      ExplicitWidth = 1096
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1020
      ExplicitLeft = 1020
    end
  end
  inherited pnlStatus: TPanel
    Top = 583
    Width = 1100
    ExplicitTop = 583
    ExplicitWidth = 1100
    inherited pnlNomeForm: TPanel
      Left = 929
      ExplicitLeft = 929
    end
    inherited pnlInfo: TPanel
      Width = 929
      ExplicitWidth = 929
    end
  end
  object pgConferencia: TPageControl [2]
    Left = 0
    Top = 0
    Width = 1100
    Height = 557
    ActivePage = tsBandeira
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 2
    object tsBandeira: TTabSheet
      Caption = 'Bandeiras'
      object GridBandeira: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1092
        Height = 525
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object GridBandeiraTableView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditing = GridBandeiraTableViewEditing
          DataController.DataSource = dsBandeira
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsCustomize.ColumnMoving = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object GridBandeiraTableViewAUTOINCREM: TcxGridDBColumn
            DataBinding.FieldName = 'AUTOINCREM'
            Visible = False
            Options.Editing = False
            VisibleForCustomization = False
            Width = 91
          end
          object GridBandeiraTableViewBAN_CODBAN: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'BAN_CODBAN'
            Options.Editing = False
            Width = 93
          end
          object GridBandeiraTableViewBAN_NOMBAN: TcxGridDBColumn
            Caption = 'Bandeira'
            DataBinding.FieldName = 'BAN_NOMBAN'
            Options.Editing = False
            Width = 282
          end
          object GridBandeiraTableViewAUXILI: TcxGridDBColumn
            Caption = 'Sugest'#227'o'
            DataBinding.FieldName = 'AUXILI'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsEditFixedList
            Properties.OnEditValueChanged = GridBandeiraTableViewAUXILIPropertiesEditValueChanged
            Width = 147
          end
          object GridBandeiraTableViewSTATUS: TcxGridDBColumn
            Caption = 'Status'
            DataBinding.FieldName = 'STATUS'
            Options.Editing = False
            Width = 150
          end
          object GridBandeiraTableViewTEMTEF: TcxGridDBColumn
            DataBinding.FieldName = 'TEMTEF'
            Visible = False
            Options.Editing = False
            VisibleForCustomization = False
            Width = 106
          end
        end
        object GridBandeiraLevel: TcxGridLevel
          GridView = GridBandeiraTableView
        end
      end
    end
    object tsAdquirente: TTabSheet
      Caption = 'Adquirentes'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GridAdquirente: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1092
        Height = 525
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object GridAdquirenteTableView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditing = GridAdquirenteTableViewEditing
          DataController.DataSource = dsAdquirente
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsCustomize.ColumnMoving = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object GridAdquirenteTableViewAUTOINCREM: TcxGridDBColumn
            DataBinding.FieldName = 'AUTOINCREM'
            Visible = False
            Options.Editing = False
            VisibleForCustomization = False
            Width = 89
          end
          object GridAdquirenteTableViewADQ_CODADQ: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'ADQ_CODADQ'
            Options.Editing = False
            Width = 91
          end
          object GridAdquirenteTableViewADQ_NOMADQ: TcxGridDBColumn
            Caption = 'Adquirente'
            DataBinding.FieldName = 'ADQ_NOMADQ'
            Options.Editing = False
            Width = 245
          end
          object GridAdquirenteTableViewAUXILI: TcxGridDBColumn
            Caption = 'Sugest'#227'o'
            DataBinding.FieldName = 'AUXILI'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsEditFixedList
            Properties.OnEditValueChanged = GridAdquirenteTableViewAUXILIPropertiesEditValueChanged
            Width = 167
          end
          object GridAdquirenteTableViewSTATUS: TcxGridDBColumn
            Caption = 'Status'
            DataBinding.FieldName = 'STATUS'
            Options.Editing = False
            Width = 139
          end
          object GridAdquirenteTableViewTEMTEF: TcxGridDBColumn
            DataBinding.FieldName = 'TEMTEF'
            Visible = False
            Options.Editing = False
            VisibleForCustomization = False
            Width = 119
          end
        end
        object GridAdquirenteLevel: TcxGridLevel
          GridView = GridAdquirenteTableView
        end
      end
    end
  end
  object dsBandeira: TDataSource
    Left = 516
    Top = 36
  end
  object dsAdquirente: TDataSource
    Left = 652
    Top = 44
  end
  object GridPopupBandeira: TcxGridPopupMenu
    Grid = GridBandeira
    PopupMenus = <>
    Left = 492
    Top = 252
  end
  object GridPopupAdquirente: TcxGridPopupMenu
    Grid = GridAdquirente
    PopupMenus = <>
    Left = 492
    Top = 308
  end
end
