inherited frmTicketBalancaQbit: TfrmTicketBalancaQbit
  Width = 545
  Height = 491
  Caption = 'Integra'#231#227'o Balan'#231'a Qbit - Tickets'
  OnDestroy = FormDestroy
  ExplicitWidth = 545
  ExplicitHeight = 491
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 420
    Width = 539
    TabOrder = 2
    ExplicitTop = 420
    ExplicitWidth = 539
    inherited FlwBotoes: TFlowPanel
      Width = 535
      ExplicitWidth = 535
    end
    inherited btnSair: TBitBtnLocked
      Left = 459
      ExplicitLeft = 459
    end
  end
  inherited pnlStatus: TPanel
    Top = 446
    Width = 539
    TabOrder = 3
    ExplicitTop = 446
    ExplicitWidth = 539
    inherited pnlNomeForm: TPanel
      Left = 368
      ExplicitLeft = 368
    end
    inherited pnlInfo: TPanel
      Width = 368
      ExplicitWidth = 368
    end
  end
  object gpbFiltros: TGroupBox [2]
    Left = 0
    Top = 0
    Width = 539
    Height = 56
    Align = alTop
    Caption = 'Consulta Ticket'
    TabOrder = 0
    object lblDtaFin: TLabel
      Left = 307
      Top = 29
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
    end
    object lblDtaIni: TLabel
      Left = 175
      Top = 29
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicial:'
    end
    object lblTicket: TLabel
      Left = 9
      Top = 29
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ticket:'
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 363
      Top = 24
      Width = 60
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtTicket: TEditFocus
      Left = 42
      Top = 24
      Width = 120
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 235
      Top = 24
      Width = 61
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object btnConsultar: TBitBtnLocked
      Left = 445
      Top = 21
      Width = 82
      Height = 25
      Caption = '[F10] Consultar'
      TabOrder = 3
      OnClick = btnConsultarClick
    end
  end
  object cgxTickets: TcxGridCitel [3]
    Left = 0
    Top = 56
    Width = 539
    Height = 364
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cgxTicketsDBTableViewCitel1: TcxGridDBTableViewCitel
      OnDblClick = cgxTicketsDBTableViewCitel1DblClick
      OnKeyDown = cgxTicketsDBTableViewCitel1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cgxTicketsDBTableViewCitel1CustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object MARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
      object TCK_TICKET: TcxGridDBColumn
        Caption = 'Ticket'
        DataBinding.FieldName = 'TCK_TICKET'
        Width = 84
      end
      object TCK_NOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'TCK_NOMCLI'
        Width = 285
      end
      object TCK_PLACA_: TcxGridDBColumn
        Caption = 'Placa'
        DataBinding.FieldName = 'TCK_PLACA_'
        Width = 73
      end
      object TCK_PESCAR: TcxGridDBColumn
        Caption = 'Peso'
        DataBinding.FieldName = 'TCK_PESCAR'
        Width = 76
      end
    end
    object cgxTicketsLevel1: TcxGridLevel
      GridView = cgxTicketsDBTableViewCitel1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 744
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 696
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 632
    Top = 144
  end
end
