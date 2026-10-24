inherited frmEstruturasIndustrialSubsCompSelec: TfrmEstruturasIndustrialSubsCompSelec
  Width = 997
  Height = 509
  Caption = 'Substitui'#231#227'o de Componentes - Sele'#231#227'o de Estruturas'
  ExplicitWidth = 997
  ExplicitHeight = 509
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 438
    Width = 991
    TabOrder = 1
    ExplicitTop = 438
    ExplicitWidth = 991
    object Label1: TLabel [0]
      Left = 389
      Top = 8
      Width = 208
      Height = 14
      Caption = '[ENTER] - Marcar/Desmarcar Registro Atual'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 910
      ExplicitWidth = 910
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 100
        Height = 22
        Align = alLeft
        Caption = '&Marcar Todos'
        TabOrder = 1
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 175
        Top = 0
        Width = 100
        Height = 22
        Align = alLeft
        Caption = '&Desmarcar Todos'
        TabOrder = 2
        OnClick = btnDesmarcaTodosClick
      end
      object btnInverte: TBitBtnLocked
        Left = 275
        Top = 0
        Width = 100
        Height = 22
        Align = alLeft
        Caption = '&Inverter Sele'#231#227'o'
        TabOrder = 3
        OnClick = btnInverteClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 912
      Top = 2
      Align = alRight
      ExplicitLeft = 912
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 464
    Width = 991
    TabOrder = 2
    ExplicitTop = 464
    ExplicitWidth = 991
    inherited pnlNomeForm: TPanel
      Left = 820
      ExplicitLeft = 820
    end
    inherited pnlInfo: TPanel
      Width = 820
      ExplicitWidth = 820
    end
  end
  object cxgFormulacao: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 991
    Height = 438
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgFormulacaoTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsSource
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgFormulacaoTableViewFORSEL: TcxGridDBColumn
        Caption = 'Subst.'
        DataBinding.FieldName = 'FORSEL'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Width = 46
      end
      object cxgFormulacaoTableViewCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'GMT_CODITE'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxgFormulacaoTableViewDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 263
      end
      object cxgFormulacaoTableViewCODCOR: TcxGridDBColumn
        Caption = 'C'#243'd. Cor'
        DataBinding.FieldName = 'GMT_CODCOR'
        Options.Editing = False
        Options.Focusing = False
        Width = 71
      end
      object cxgFormulacaoTableViewDESCOR: TcxGridDBColumn
        Caption = 'Cor'
        DataBinding.FieldName = 'COR_DESCOR'
        Options.Editing = False
        Options.Focusing = False
        Width = 185
      end
      object cxgFormulacaoTableViewFORMUL: TcxGridDBColumn
        Caption = 'C'#243'd. F'#243'rmula'
        DataBinding.FieldName = 'GMT_FORMUL'
        Options.Editing = False
        Options.Focusing = False
        Width = 83
      end
      object cxgFormulacaoTableViewPESREA: TcxGridDBColumn
        Caption = 'Peso Real'
        DataBinding.FieldName = 'GMT_PESREA'
        Options.Editing = False
        Options.Focusing = False
        Width = 81
      end
      object cxgFormulacaoTableViewREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'GMT_REFERE'
        Options.Editing = False
        Options.Focusing = False
        Width = 166
      end
    end
    object cxgFormulacaoLevel: TcxGridLevel
      GridView = cxgFormulacaoTableView
    end
  end
  object dtsSource: TDataSource
    Left = 792
    Top = 120
  end
end
