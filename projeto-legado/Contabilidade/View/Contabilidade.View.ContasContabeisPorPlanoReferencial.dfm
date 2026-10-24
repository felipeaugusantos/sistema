inherited frmContasContabeisPorPlanoReferencial: TfrmContasContabeisPorPlanoReferencial
  Width = 1022
  Height = 540
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeable
  Caption = 'Plano Cont'#225'bil'
  OnDestroy = FormDestroy
  ExplicitWidth = 1022
  ExplicitHeight = 540
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 459
    Width = 1006
    TabOrder = 1
    ExplicitTop = 459
    ExplicitWidth = 1006
    inherited FlwBotoes: TFlowPanel
      Width = 1002
      ExplicitWidth = 1002
    end
    inherited btnSair: TBitBtnLocked
      Left = 923
      ExplicitLeft = 923
    end
  end
  inherited pnlStatus: TPanel
    Top = 485
    Width = 1006
    TabOrder = 2
    ExplicitTop = 485
    ExplicitWidth = 1006
    inherited pnlNomeForm: TPanel
      Left = 787
      Width = 219
      ExplicitLeft = 787
      ExplicitWidth = 219
    end
    inherited pnlInfo: TPanel
      Width = 787
      ExplicitWidth = 787
    end
  end
  object GridCitel: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1006
    Height = 418
    Align = alClient
    TabOrder = 0
    object Gridtab: TcxGridDBTableViewCitel
      OnKeyPress = GridtabKeyPress
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsConsulta
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsSelection.MultiSelect = True
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Styles.OnGetContentStyle = GridtabStylesGetContentStyle
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object GridtabNCO_CODCON: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'NCO_CODCON'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Options.Editing = False
        Width = 109
      end
      object GridtabNCO_DESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'NCO_DESCRI'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Options.Editing = False
        Width = 337
      end
      object GridtabNCO_CTAREF: TcxGridDBColumn
        DataBinding.FieldName = 'NCO_CTAREF'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object GridCitelLevel1: TcxGridLevel
      GridView = Gridtab
    end
  end
  object pnlInfoCores: TPanel [3]
    Left = 0
    Top = 418
    Width = 1006
    Height = 41
    Align = alBottom
    TabOrder = 3
    object teOrigemPlanco: TcxTextEdit
      Left = 5
      Top = 9
      TabStop = False
      Properties.AutoSelect = False
      Properties.ReadOnly = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Width = 121
    end
    object lbOrigemPlanco: TcxLabel
      Left = 132
      Top = 11
      Caption = 
        'Registro configurado no Plano de Contas, com Plano de Contas Ref' +
        'erencial'
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = 14
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
  end
  object dsConsulta: TDataSource
    DataSet = FDMemPlanco
    Left = 112
    Top = 104
  end
  object FDMemPlanco: TFDMemTable
    AfterScroll = FDMemPlancoAfterScroll
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 392
    Top = 56
    object FDMemPlancoNCO_CODCON: TStringField
      FieldName = 'NCO_CODCON'
    end
    object FDMemPlancoNCO_DESCRI: TStringField
      FieldName = 'NCO_DESCRI'
      Size = 100
    end
    object FDMemPlancoNCO_CTAREF: TStringField
      FieldName = 'NCO_CTAREF'
    end
  end
  object StyleRepository: TcxStyleRepository
    Left = 608
    Top = 209
    PixelsPerInch = 96
    object EstiloTemContaRef: TcxStyle
      AssignedValues = [svColor]
      Color = clSkyBlue
    end
  end
end
