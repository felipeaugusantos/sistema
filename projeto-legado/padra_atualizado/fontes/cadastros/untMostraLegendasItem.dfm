inherited frmMostraLegendasItem: TfrmMostraLegendasItem
  Width = 380
  Height = 410
  BorderStyle = bsSingle
  Caption = 'Legendas do Item'
  ExplicitWidth = 380
  ExplicitHeight = 410
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 337
    Width = 374
    ExplicitTop = 337
    ExplicitWidth = 374
    object lblLegendaCor: TLabel [0]
      Left = 8
      Top = 6
      Width = 246
      Height = 13
      Caption = '* Clique duplo na legenda para trocar a cor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 0
      Align = alNone
      ExplicitWidth = 0
    end
    inherited btnSair: TBitBtnLocked
      Left = 291
      Caption = 'Sair'
      ExplicitLeft = 291
    end
  end
  inherited pnlStatus: TPanel
    Top = 365
    Width = 374
    ExplicitTop = 365
    ExplicitWidth = 374
    inherited pnlNomeForm: TPanel
      Left = 203
      ExplicitLeft = 203
    end
    inherited pnlInfo: TPanel
      Width = 203
      ExplicitWidth = 203
    end
  end
  object cxgLegendas: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 374
    Height = 337
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgLegendasView: TcxGridDBBandedTableView
      OnDblClick = cxgLegendasViewDblClick
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glNone
      OptionsView.GroupByBox = False
      OptionsView.Header = False
      OptionsView.BandHeaders = False
      Bands = <
        item
          Caption = 'Legendas do Item'
          Width = 255
        end>
      object cxgLegendasViewColumn1: TcxGridDBBandedColumn
        Caption = 'Cor'
        DataBinding.FieldName = 'SIT_CORSIT'
        OnCustomDrawCell = cxgLegendasViewColumn1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 38
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgLegendasViewColumn2: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'SIT_DESCRI'
        Styles.OnGetContentStyle = cxgLegendasViewColumn2StylesGetContentStyle
        Width = 256
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
    end
    object cxgLegendasLevel1: TcxGridLevel
      GridView = cxgLegendasView
    end
  end
end
