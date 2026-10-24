inherited frmExportaTintometricosTerceiros: TfrmExportaTintometricosTerceiros
  Width = 774
  Height = 575
  Caption = 'Exporta'#231#227'o Tintom'#233'tricos para Terceiros'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 774
  ExplicitHeight = 575
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 500
    Width = 768
    Height = 30
    Enabled = True
    Visible = True
    ExplicitTop = 500
    ExplicitWidth = 768
    ExplicitHeight = 30
    inherited FlwBotoes: TFlowPanel
      Width = 764
      Height = 26
      ExplicitWidth = 764
      ExplicitHeight = 26
    end
    inherited btnSair: TBitBtnLocked
      Left = 687
      Top = 3
      TabOrder = 3
      ExplicitLeft = 687
      ExplicitTop = 3
    end
    object btnExportar: TBitBtnLocked
      Left = 1
      Top = 2
      Width = 77
      Height = 22
      Caption = '&Exportar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnExportarClick
    end
    object btnMarDes: TBitBtnLocked
      Left = 133
      Top = 3
      Width = 113
      Height = 22
      Caption = 'Marcar / Desmarcar'
      TabOrder = 2
      OnClick = btnMarDesClick
    end
  end
  inherited pgcDados: TPageControl
    Width = 768
    Height = 500
    ExplicitWidth = 768
    ExplicitHeight = 500
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 760
      ExplicitHeight = 468
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 768
    Height = 500
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object dbgTintas: TcxGrid
      Left = 1
      Top = 1
      Width = 385
      Height = 498
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgTintasDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsTintas
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.HideSelection = True
        OptionsView.GroupByBox = False
        object dbgTintasDBTableView1NOME: TcxGridDBColumn
          Caption = 'Tinta'
          DataBinding.FieldName = 'NOME'
          Options.Editing = False
          Width = 300
        end
        object dbgTintasDBTableView1EXPORTAR: TcxGridDBColumn
          Caption = 'Exportar'
          DataBinding.FieldName = 'EXPORTAR'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 'S'
          Properties.ValueUnchecked = 'N'
          Width = 55
        end
        object dbgTintasDBTableView1IDEPRO: TcxGridDBColumn
          DataBinding.FieldName = 'IDEPRO'
          Visible = False
        end
      end
      object dbgTintasLevel1: TcxGridLevel
        GridView = dbgTintasDBTableView1
      end
    end
    object pnlProgTintas: TPanel
      Left = 386
      Top = 1
      Width = 381
      Height = 498
      Align = alRight
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object ScrProgTintas: TScrollBox
        Left = 1
        Top = 1
        Width = 379
        Height = 496
        VertScrollBar.Visible = False
        Align = alClient
        AutoScroll = False
        BorderStyle = bsNone
        TabOrder = 0
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 530
    Width = 768
    ExplicitTop = 530
    ExplicitWidth = 768
    inherited pnlNomeForm: TPanel
      Left = 597
      ExplicitLeft = 597
    end
    inherited pnlInfo: TPanel
      Width = 597
      ExplicitWidth = 597
    end
  end
  object cdsTintas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 104
    object cdsTintasNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object cdsTintasEXPORTAR: TStringField
      FieldName = 'EXPORTAR'
      Size = 1
    end
    object cdsTintasIDEPRO: TStringField
      FieldName = 'IDEPRO'
      Size = 3
    end
  end
  object dtsTintas: TDataSource
    DataSet = cdsTintas
    Left = 336
    Top = 120
  end
  object Timer: TTimer
    Interval = 120000
    OnTimer = TimerTimer
    Left = 567
    Top = 105
  end
end
