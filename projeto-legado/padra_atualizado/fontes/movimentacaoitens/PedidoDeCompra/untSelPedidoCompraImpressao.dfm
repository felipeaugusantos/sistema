inherited frmSelPedidoCompraImpressao: TfrmSelPedidoCompraImpressao
  Width = 326
  Height = 395
  Caption = 'Selecione os Pedidos que Ser'#227'o Impressos'
  ExplicitWidth = 326
  ExplicitHeight = 395
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 324
    Width = 320
    ExplicitTop = 324
    ExplicitWidth = 320
    inherited FlwBotoes: TFlowPanel
      Width = 316
      ExplicitWidth = 316
      inherited btnConfirma: TBitBtnLocked
        Width = 90
        ModalResult = 0
        ExplicitWidth = 90
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 226
      Top = 2
      Width = 90
      ExplicitLeft = 226
      ExplicitTop = 2
      ExplicitWidth = 90
    end
  end
  inherited pnlStatus: TPanel
    Top = 350
    Width = 320
    ExplicitTop = 350
    ExplicitWidth = 320
    inherited pnlNomeForm: TPanel
      Left = 149
      ExplicitLeft = 149
    end
    inherited pnlInfo: TPanel
      Width = 149
      ExplicitWidth = 149
    end
  end
  object cxPedidos: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 320
    Height = 277
    Align = alClient
    TabOrder = 3
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = True
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxPedidosTbl: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FilterBox.CustomizeDialog = False
      OnCustomDrawCell = cxPedidosTblCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados...'
      OptionsView.GroupByBox = False
      object cxPedidosSELECI: TcxGridDBColumn
        Caption = 'Imprimir'
        DataBinding.FieldName = 'SELECI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = '1'
        Properties.ValueGrayed = '-1'
        Properties.ValueUnchecked = '0'
        Properties.OnChange = cxPedidosSELECIPropertiesChange
        Width = 51
      end
      object cxPedidosCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        Options.Editing = False
        Width = 50
      end
      object cxPedidosNUMPED: TcxGridDBColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'NUMPED'
        Options.Editing = False
        Width = 138
      end
      object ERR_CONFIG: TcxGridDBColumn
        DataBinding.FieldName = 'ERR_CONFIG'
        Visible = False
      end
    end
    object cxPedidosLvl: TcxGridLevel
      GridView = cxPedidosTbl
    end
  end
  object pnlErr: TPanel [3]
    Left = 0
    Top = 277
    Width = 320
    Height = 47
    Align = alBottom
    TabOrder = 2
    Visible = False
    object lblErr: TLabel
      Left = 1
      Top = 1
      Width = 24
      Height = 14
      Align = alClient
      Caption = 'lblErr'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 232
  end
  object popAcao: TPopupMenu
    Left = 96
    Top = 56
    object mnuSeleciona: TMenuItem
      Caption = 'Marcar &Todos'
      OnClick = mnuSelecionaClick
    end
    object mnuDeseleciona: TMenuItem
      Caption = '&Desmarcar Todos'
      OnClick = mnuDeselecionaClick
    end
    object mnuEmpresaLogada: TMenuItem
      Caption = 'Marcar &Apenas Empresa Atual'
      OnClick = mnuEmpresaLogadaClick
    end
  end
  object dtsDados: TDataSource
    Left = 32
    Top = 40
  end
end
