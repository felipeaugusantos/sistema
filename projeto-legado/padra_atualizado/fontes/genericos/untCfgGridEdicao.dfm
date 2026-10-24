inherited frmCfgGridEdicao: TfrmCfgGridEdicao
  Width = 661
  Height = 544
  BorderStyle = bsSizeable
  Caption = 'Configura'#231#227'o do Grid'
  ExplicitWidth = 661
  ExplicitHeight = 544
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 463
    Width = 645
    ExplicitTop = 463
    ExplicitWidth = 645
    inherited FlwBotoes: TFlowPanel
      Width = 564
      ExplicitWidth = 641
    end
    inherited btnSair: TBitBtnLocked
      Left = 566
      Top = 2
      Align = alRight
      ExplicitLeft = 562
    end
  end
  inherited pnlStatus: TPanel
    Top = 489
    Width = 645
    ExplicitTop = 489
    ExplicitWidth = 645
    inherited pnlNomeForm: TPanel
      Left = 474
      ExplicitLeft = 474
    end
    inherited pnlInfo: TPanel
      Width = 474
      ExplicitWidth = 474
    end
  end
  object pnlTitulo: TPanel [3]
    Left = 0
    Top = 0
    Width = 645
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
  end
  object cxgColunas: TcxGrid [4]
    Left = 0
    Top = 33
    Width = 645
    Height = 430
    Align = alClient
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvColunas: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxStyle1
      object cxvColunasNOMBAN: TcxGridDBColumn
        Caption = 'Banda'
        DataBinding.FieldName = 'NOMBAN'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.CellMerging = True
        Styles.Content = cxStyle2
        Width = 266
      end
      object cxvColunasNOMCOL: TcxGridDBColumn
        Caption = 'Coluna'
        DataBinding.FieldName = 'NOMCOL'
        Options.Editing = False
        Width = 290
      end
      object cxvColunasVISIVE: TcxGridDBColumn
        Caption = 'Vis'#237'vel'
        DataBinding.FieldName = 'CFG_VISIVE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 65
      end
      object cxvColunasBANIND: TcxGridDBColumn
        DataBinding.FieldName = 'BANIND'
        Visible = False
        SortIndex = 0
        SortOrder = soAscending
      end
      object cxvColunasCOLIND: TcxGridDBColumn
        DataBinding.FieldName = 'COLIND'
        Visible = False
        SortIndex = 1
        SortOrder = soAscending
      end
    end
    object cxgColunasLevel1: TcxGridLevel
      GridView = cxvColunas
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 520
    Top = 192
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 552
    Top = 96
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 464
    Top = 264
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 72
    Top = 144
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = clWhite
    end
  end
end
