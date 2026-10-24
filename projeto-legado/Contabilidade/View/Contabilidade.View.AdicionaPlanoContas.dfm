inherited frmAdicionaPlanoContas: TfrmAdicionaPlanoContas
  Width = 694
  Height = 322
  Caption = 'Configura Conta Cont'#225'bil'
  OnDestroy = FormDestroy
  ExplicitWidth = 694
  ExplicitHeight = 322
  PixelsPerInch = 96
  TextHeight = 14
  object Label17: TLabel [0]
    Left = 8
    Top = 8
    Width = 69
    Height = 14
    Caption = 'Conta Cont'#225'bil'
  end
  inherited pnlBotoes: TPanel
    Top = 251
    Width = 688
    TabOrder = 3
    ExplicitTop = 251
    ExplicitWidth = 688
    inherited FlwBotoes: TFlowPanel
      Width = 684
      ExplicitWidth = 684
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 608
      ExplicitLeft = 608
    end
  end
  inherited pnlStatus: TPanel
    Top = 277
    Width = 688
    TabOrder = 4
    ExplicitTop = 277
    ExplicitWidth = 688
    inherited pnlNomeForm: TPanel
      Left = 517
      ExplicitLeft = 517
    end
    inherited pnlInfo: TPanel
      Width = 517
      ExplicitWidth = 517
    end
  end
  object edtPlanco: TEditFocus [3]
    Tag = 99
    Left = 8
    Top = 28
    Width = 109
    Height = 22
    Alignment = taLeftJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 0
    OnKeyPress = edtPlancoKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtDesPlanco: TEditFocus [4]
    Left = 119
    Top = 28
    Width = 335
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 5
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object btnAdicionar: TBitBtnLocked [5]
    Left = 460
    Top = 27
    Width = 109
    Height = 25
    Caption = 'Incluir'
    TabOrder = 1
    OnClick = btnAdicionarClick
  end
  object GridPlanco: TcxGridCitel [6]
    Left = 8
    Top = 64
    Width = 672
    Height = 181
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object GridPlancoView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsPlanco
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.CancelOnExit = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object GridPlancoViewCODCON: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODCON'
        Width = 122
      end
      object GridPlancoViewDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRI'
        Width = 512
      end
      object GridPlancoViewTPLACO: TcxGridDBColumn
        DataBinding.FieldName = 'TPLACO'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object GridPlancoLevel: TcxGridLevel
      GridView = GridPlancoView
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 184
    Top = 0
  end
  object dsPlanco: TDataSource
    AutoEdit = False
    Left = 632
    Top = 16
  end
end
