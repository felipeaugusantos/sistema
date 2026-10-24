inherited frmConsDuplicSelec: TfrmConsDuplicSelec
  Left = 352
  Top = 341
  Width = 802
  Height = 405
  Caption = 'Consulta Duplicatas Selecionadas'
  Position = poMainFormCenter
  ExplicitWidth = 802
  ExplicitHeight = 405
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 332
    Width = 796
    ExplicitTop = 332
    ExplicitWidth = 796
    inherited FlwBotoes: TFlowPanel
      Width = 792
      ExplicitWidth = 792
      object btnImprimir: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 119
        Height = 21
        Caption = '[ F10 ] Imprimir'
        Spacing = 2
        TabOrder = 0
        Visible = False
        OnClick = btnImprimirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 713
      ExplicitLeft = 713
    end
  end
  inherited pnlStatus: TPanel
    Top = 360
    Width = 796
    ExplicitTop = 360
    ExplicitWidth = 796
    inherited pnlNomeForm: TPanel
      Left = 625
      ExplicitLeft = 625
    end
    inherited pnlInfo: TPanel
      Width = 625
      ExplicitWidth = 625
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 796
    Height = 332
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object GroupBox1: TGroupBox
      Left = 1
      Top = 299
      Width = 794
      Height = 32
      Align = alBottom
      TabOrder = 0
      object Label1: TLabel
        Left = 9
        Top = 12
        Width = 91
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Selecionadas:'
      end
      object lblValorTotal: TLabel
        Left = 668
        Top = 12
        Width = 95
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblQtdeTotal: TLabel
        Left = 105
        Top = 12
        Width = 65
        Height = 14
        Caption = 'lblQtdeTotal'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblJurosTotal: TLabel
        Left = 531
        Top = 12
        Width = 83
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDescontoTotal: TLabel
        Left = 430
        Top = 12
        Width = 93
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblVendorTotal: TLabel
        Left = 625
        Top = 12
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object dbgDuplicatas: TcxGrid
      Left = 1
      Top = 1
      Width = 794
      Height = 298
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgDuplicatasDBTableView1: TcxGridDBTableView
        OnKeyDown = dbgDuplicatasDBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgDuplicatasDBTableView1CustomDrawCell
        DataController.DataSource = dtsConsulta
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.GroupByBox = False
      end
      object dbgDuplicatasLevel1: TcxGridLevel
        GridView = dbgDuplicatasDBTableView1
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 376
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 184
    Top = 24
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 528
    Top = 48
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 64
  end
end
