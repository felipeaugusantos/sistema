inherited frmEditorLayoutPedidoCompra: TfrmEditorLayoutPedidoCompra
  Width = 442
  Height = 632
  Caption = 'Editor: Layout de Importa'#231#227'o do Pedido de Compra'
  ExplicitWidth = 442
  ExplicitHeight = 632
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 561
    Width = 436
    ExplicitTop = 561
    ExplicitWidth = 436
    inherited FlwBotoes: TFlowPanel
      Width = 432
      ExplicitWidth = 432
    end
    inherited btnSair: TBitBtnLocked
      Left = 353
      ExplicitLeft = 353
    end
  end
  inherited pnlStatus: TPanel
    Top = 587
    Width = 436
    ExplicitTop = 587
    ExplicitWidth = 436
    inherited pnlNomeForm: TPanel
      Left = 229
      Width = 207
      ExplicitLeft = 229
      ExplicitWidth = 207
    end
    inherited pnlInfo: TPanel
      Width = 229
      ExplicitWidth = 229
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 436
    Height = 49
    Align = alTop
    TabOrder = 3
    object Label1: TLabel
      Left = 2
      Top = 4
      Width = 81
      Height = 14
      Caption = 'Nome do Layout:'
    end
    object Label2: TLabel
      Left = 291
      Top = 4
      Width = 130
      Height = 14
      Caption = 'Inicio dos Itens No Arquivo:'
    end
  end
  object cxCampos: TcxGrid [4]
    Left = 0
    Top = 49
    Width = 436
    Height = 486
    Align = alClient
    TabOrder = 4
    ExplicitHeight = 512
    object cxCamposDB: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCanFocusRecord = cxCamposDBCanFocusRecord
      OnCustomDrawCell = cxCamposDBCustomDrawCell
      DataController.DataSource = dtsCampos
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxCamposDBColumn1: TcxGridDBColumn
        Caption = 'Campo'
        DataBinding.FieldName = 'LAY_DESCAM'
        Options.Editing = False
        Width = 339
      end
      object cxCamposDBColuna: TcxGridDBColumn
        Caption = 'Coluna Excel'
        DataBinding.FieldName = 'LAY_POSLAY'
        HeaderAlignmentHorz = taCenter
        Width = 81
      end
    end
    object cxCamposLvl: TcxGridLevel
      GridView = cxCamposDB
    end
  end
  object edtNomLayout: TEdit [5]
    Tag = 99
    Left = 2
    Top = 19
    Width = 307
    Height = 22
    CharCase = ecUpperCase
    TabOrder = 5
  end
  object edtPosIniArquiv: TSpinEdit [6]
    Tag = 99
    Left = 376
    Top = 19
    Width = 45
    Height = 23
    MaxValue = 0
    MinValue = 0
    TabOrder = 6
    Value = 0
  end
  object pnlHintCodigo: TPanel [7]
    Left = 0
    Top = 535
    Width = 436
    Height = 26
    Align = alBottom
    TabOrder = 7
    ExplicitTop = 534
    object Label3: TLabel
      Left = 1
      Top = 6
      Width = 434
      Height = 14
      Caption = 
        'Para importar C'#243'digo do Item ou C'#243'digo de F'#225'brica, selecione na ' +
        'tela de Pedido de Compra'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 116
    Top = 308
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 340
    Top = 152
  end
  object dtsCampos: TDataSource
    Left = 400
    Top = 228
  end
  object fsScript1: TfsScript
    SyntaxType = 'PascalScript'
    Left = 140
    Top = 204
  end
end
