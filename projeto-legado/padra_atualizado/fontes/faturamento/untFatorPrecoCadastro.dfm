inherited frmFatorPrecoCadastro: TfrmFatorPrecoCadastro
  Width = 427
  Height = 305
  Caption = 'Cadastro de Fatores de Pre'#231'o'
  OnKeyPress = FormKeyPress
  ExplicitWidth = 427
  ExplicitHeight = 305
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 234
    Width = 421
    ExplicitTop = 234
    ExplicitWidth = 421
    inherited FlwBotoes: TFlowPanel
      Width = 340
      ExplicitWidth = 340
      inherited btnConfirma: TBitBtnLocked
        Width = 109
        Caption = '[F10] Confirma'
        ExplicitWidth = 109
      end
      object btnMarDes: TBitBtnLocked
        Left = 109
        Top = 0
        Width = 160
        Height = 22
        Caption = '[F9] Marcar / Desmarcar Todas'
        TabOrder = 1
        OnClick = btnMarDesClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 342
      Top = 2
      Align = alRight
      ExplicitLeft = 342
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 260
    Width = 421
    ExplicitTop = 260
    ExplicitWidth = 421
    inherited pnlNomeForm: TPanel
      Left = 250
      ExplicitLeft = 250
    end
    inherited pnlInfo: TPanel
      Width = 250
      ExplicitWidth = 250
    end
  end
  object cxGrid: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 421
    Height = 218
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridTableView: TcxGridDBTableView
      OnDblClick = cxGridTableViewDblClick
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGridTableViewCustomDrawCell
      DataController.DataSource = dtsFatPre
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxGridNumFat: TcxGridDBColumn
        Caption = 'TABELA DE PRE'#199'O'
        DataBinding.FieldName = 'FAT_NUMFAT'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        Options.Sorting = False
        Styles.Content = cxStyle1
        Width = 147
      end
      object cxGridValFat: TcxGridDBColumn
        Caption = 'FATOR'
        DataBinding.FieldName = 'FAT_VALFAT'
        HeaderAlignmentHorz = taCenter
        Options.Moving = False
        Options.Sorting = False
        Width = 198
      end
      object cxGridTableViewColumn1: TcxGridDBColumn
        Caption = 'ATIVO'
        DataBinding.FieldName = 'FAT_ATIVO_'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Width = 41
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridTableView
    end
  end
  object prgProgresso: TProgressBar [3]
    Left = 0
    Top = 218
    Width = 421
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 3
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
  end
  object dtsFatPre: TDataSource
    DataSet = cdsFatPre
    Left = 144
    Top = 72
  end
  object cdsFatPre: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dtpFatPre'
    BeforePost = cdsFatPreBeforePost
    Left = 104
    Top = 72
  end
  object dtpFatPre: TUniDataSetProvider
    Options = []
    Left = 72
    Top = 72
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
