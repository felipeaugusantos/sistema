inherited frmConfirmaGlobalClientes: TfrmConfirmaGlobalClientes
  Left = 169
  Top = 161
  Width = 1043
  Height = 622
  BorderStyle = bsSizeable
  Caption = 'Clientes a serem alterados'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1043
  ExplicitHeight = 622
  PixelsPerInch = 96
  TextHeight = 14
  object pgbProgresso: TProgressBar [0]
    Left = 0
    Top = 556
    Width = 1027
    Height = 11
    Align = alBottom
    Smooth = True
    TabOrder = 6
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 567
    Width = 1027
    TabOrder = 3
    ExplicitTop = 567
    ExplicitWidth = 1027
    DesignSize = (
      1027
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1023
      ExplicitWidth = 1023
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 567
    Width = 1027
    TabOrder = 2
    ExplicitTop = 567
    ExplicitWidth = 1027
    inherited pnlNomeForm: TPanel
      Left = 887
      Width = 140
      ExplicitLeft = 887
      ExplicitWidth = 140
    end
    inherited pnlInfo: TPanel
      Width = 887
      ExplicitWidth = 887
    end
  end
  inherited pgcDados: TPageControl
    Width = 1027
    Height = 496
    TabOrder = 1
    Visible = False
    ExplicitWidth = 1027
    ExplicitHeight = 496
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1019
      ExplicitHeight = 464
    end
  end
  object pnlBotoesEnt: TPanel [4]
    Left = 0
    Top = 532
    Width = 1027
    Height = 24
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 111
      Height = 20
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnMarTod: TBitBtnLocked
      Left = 113
      Top = 2
      Width = 114
      Height = 20
      Align = alLeft
      Caption = '[ F3 ] Marca Todos'
      TabOrder = 1
      OnClick = btnMarTodClick
    end
    object btnDesTod: TBitBtnLocked
      Left = 227
      Top = 2
      Width = 114
      Height = 20
      Align = alLeft
      Caption = '[ F4] Desmarca Todos'
      TabOrder = 2
      OnClick = btnDesTodClick
    end
    object btnVoltar: TBitBtnLocked
      Left = 914
      Top = 2
      Width = 111
      Height = 20
      Align = alRight
      Caption = '[ Esc ] Voltar'
      TabOrder = 3
      OnClick = btnVoltarClick
    end
  end
  object cxgItens: TcxGridCitel [5]
    Left = 0
    Top = 0
    Width = 1027
    Height = 496
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvItens: TcxGridDBTableViewCitel
      OnKeyDown = cxvItensKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellClick = cxvItensCellClick
      OnCellDblClick = cxvItensCellDblClick
      OnCustomDrawCell = cxvItensCustomDrawCell
      DataController.DataSource = dtsClientes
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.OnChanged = cxvItensDataControllerFilterChanged
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      DataController.OnSortingChanged = cxvItensDataControllerSortingChanged
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum dado para exibir>'
      OptionsView.CellAutoHeight = True
      OptionsView.GroupByBox = False
      Styles.Selection = cxsBlue
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvItensMarcado: TcxGridDBColumn
        Caption = 'Marcado'
        DataBinding.FieldName = 'CLI_MARDES'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'M'
        Properties.ValueUnchecked = 'D'
        Options.Editing = False
        Width = 55
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  object Panel1: TPanel [6]
    Left = 0
    Top = 496
    Width = 1027
    Height = 36
    Align = alBottom
    TabOrder = 5
    object lblLegendaAzul: TLabel
      Left = 5
      Top = 2
      Width = 292
      Height = 18
      AutoSize = False
      Caption = '- Os itens com a cor da fonte azul ser'#227'o atualizados.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 208
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 176
    Top = 160
  end
  object dtsClientes: TDataSource
    Left = 144
    Top = 160
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 88
    Top = 16
    PixelsPerInch = 96
    object cxsMoney: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxsBlue: TcxStyle
      AssignedValues = [svColor]
      Color = 16767411
    end
    object cxStyle1: TcxStyle
    end
    object cxBlackBold: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
end
