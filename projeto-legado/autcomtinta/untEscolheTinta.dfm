inherited frmEscolheTinta: TfrmEscolheTinta
  Left = 218
  Top = 219
  Width = 635
  Height = 379
  BorderIcons = [biSystemMenu]
  Caption = 'Tintas de m'#225'quina'
  Position = poScreenCenter
  ExplicitWidth = 635
  ExplicitHeight = 379
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 306
    Width = 629
    ExplicitTop = 306
    ExplicitWidth = 629
    DesignSize = (
      629
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 625
      ExplicitWidth = 625
    end
    inherited btnSair: TBitBtnLocked
      Left = 547
      TabOrder = 2
      ExplicitLeft = 547
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirma'
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
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 334
    Width = 629
    ExplicitTop = 334
    ExplicitWidth = 629
    inherited pnlNomeForm: TPanel
      Left = 458
      ExplicitLeft = 458
    end
    inherited pnlInfo: TPanel
      Width = 458
      ExplicitWidth = 458
    end
  end
  object dbgTintasDisponiveis: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 354
    Height = 306
    Align = alClient
    TabOrder = 2
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = True
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgViewTintasDisponiveis: TcxGridDBTableView
      OnKeyPress = dbgViewTintasDisponiveisKeyPress
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsTintasDisponiveis
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = dbgViewTintasDisponiveisDESCRI
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnHorzSizing = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhuma tinta disponivel>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glNone
      OptionsView.GroupByBox = False
      OptionsView.Header = False
      OptionsView.HeaderHeight = 20
      object dbgViewTintasDisponiveisIDEPRO: TcxGridDBColumn
        Caption = 'Identificador'
        DataBinding.FieldName = 'IDEPRO'
        Visible = False
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Options.Moving = False
        Options.Sorting = False
      end
      object dbgViewTintasDisponiveisDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRI'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Options.Moving = False
        Options.Sorting = False
        SortIndex = 0
        SortOrder = soAscending
        Styles.Content = cxstylFonte
        Width = 265
      end
      object dbgViewTintasDisponiveisVERDTA: TcxGridDBColumn
        Caption = 'Versao e Data'
        DataBinding.FieldName = 'VERDTA'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Options.Moving = False
        Options.Sorting = False
      end
    end
    object dbgLvlTintasDisponiveis: TcxGridLevel
      GridView = dbgViewTintasDisponiveis
    end
  end
  object pnlImagem: TPanel [3]
    Left = 354
    Top = 0
    Width = 275
    Height = 306
    Align = alRight
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object imgLogo: TImage
      Left = 6
      Top = 97
      Width = 262
      Height = 115
      Center = True
      Stretch = True
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 438
    Top = 20
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 570
    Top = 20
  end
  object cdsTintasDisponiveis: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'IDEPRO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DESCRI'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'IMAGEM'
        DataType = ftBlob
      end
      item
        Name = 'VERDTA'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <
      item
        Name = 'IDX_DESCRI'
        Fields = 'DESCRI'
        Options = [ixPrimary]
      end>
    IndexName = 'IDX_DESCRI'
    Params = <>
    StoreDefs = True
    AfterScroll = cdsTintasDisponiveisAfterScroll
    Left = 471
    Top = 20
    object cdsTintasDisponiveisIDEPRO: TStringField
      FieldName = 'IDEPRO'
    end
    object cdsTintasDisponiveisDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 50
    end
    object cdsTintasDisponiveisVERDTA: TStringField
      FieldName = 'VERDTA'
      Size = 50
    end
  end
  object dtsTintasDisponiveis: TDataSource
    DataSet = cdsTintasDisponiveis
    Left = 537
    Top = 20
  end
  object cxstylrpstryFonte: TcxStyleRepository
    Left = 504
    Top = 20
    PixelsPerInch = 96
    object cxstylFonte: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
  end
end
