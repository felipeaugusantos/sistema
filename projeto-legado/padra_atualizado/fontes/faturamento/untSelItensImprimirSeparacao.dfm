inherited frmSelItensImprimirSeparacao: TfrmSelItensImprimirSeparacao
  Width = 724
  Height = 340
  Caption = 'Imprimir Separa'#231#227'o'
  ExplicitWidth = 724
  ExplicitHeight = 340
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 269
    Width = 718
    TabOrder = 1
    ExplicitTop = 269
    ExplicitWidth = 718
    inherited FlwBotoes: TFlowPanel
      Width = 714
      ExplicitWidth = 714
      inherited btnConfirma: TBitBtnLocked
        Width = 110
        Caption = '[F10] &Confirma'
        ExplicitWidth = 110
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 110
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F5] Marcar Todos'
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 230
        Top = 0
        Width = 136
        Height = 22
        Caption = '[F6] Desmarcar Todos'
        TabOrder = 2
        OnClick = btnDesmarcarTodosClick
      end
      object btnReimprimir: TBitBtnLocked
        Left = 366
        Top = 0
        Width = 95
        Height = 22
        Caption = '[F7] Reimprimir'
        TabOrder = 3
        OnClick = btnReimprimirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 635
      ExplicitLeft = 635
    end
  end
  inherited pnlStatus: TPanel
    Top = 295
    Width = 718
    TabOrder = 2
    ExplicitTop = 295
    ExplicitWidth = 718
    inherited pnlNomeForm: TPanel
      Left = 547
      ExplicitLeft = 547
    end
    inherited pnlInfo: TPanel
      Width = 547
      ExplicitWidth = 547
    end
  end
  object pnlLegendas: TPanel [2]
    Left = 0
    Top = 248
    Width = 718
    Height = 21
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object shpEditavel: TShape
      Left = 13
      Top = 6
      Width = 10
      Height = 10
      Brush.Color = clYellow
    end
    object lblEditavel: TLabel
      Left = 27
      Top = 4
      Width = 85
      Height = 14
      Caption = 'Campos edit'#225'veis'
    end
  end
  object cxgItens: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 718
    Height = 248
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensDBTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensDBTableViewCustomDrawCell
      DataController.DataSource = dtsItens
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
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 60
      end
      object cxgItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 400
      end
      object cxgItensQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 78
      end
      object cxgItensSEPARA: TcxGridDBColumn
        Caption = 'Qtd Separada'
        DataBinding.FieldName = 'SEPARA'
        Options.Editing = False
        Width = 78
      end
      object cxgItensQTDSEP: TcxGridDBColumn
        Caption = 'Qtd Separar'
        DataBinding.FieldName = 'QTDSEP'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Properties.OnEditValueChanged = cxgItensQTDSEPPropertiesEditValueChanged
        Width = 78
      end
    end
    object cxgItensLevel: TcxGridLevel
      GridView = cxgItensDBTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 16
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 16
  end
  object dtsItens: TDataSource
    Left = 392
    Top = 16
  end
end
