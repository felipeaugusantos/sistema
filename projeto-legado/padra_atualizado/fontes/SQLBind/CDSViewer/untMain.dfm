object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'ClientDataSet Viewer'
  ClientHeight = 661
  ClientWidth = 934
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GridCDS: TcxGrid
    Left = 0
    Top = 97
    Width = 934
    Height = 564
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object GridCDSDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = GridCDSDBTableViewCustomDrawCell
      DataController.DataSource = dtsCDS
      DataController.Filter.Options = [fcoCaseInsensitive, fcoSoftCompare]
      DataController.Filter.Active = True
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Filtering.MRUItemsList = False
      Filtering.ColumnMRUItemsList = False
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
    end
    object GridCDSLevel1: TcxGridLevel
      GridView = GridCDSDBTableView
    end
  end
  object pnlCab: TPanel
    Left = 0
    Top = 0
    Width = 934
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      934
      97)
    object lblBus: TLabel
      Left = 8
      Top = 7
      Width = 38
      Height = 13
      Caption = 'Coluna'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblRes: TLabel
      Left = 8
      Top = 81
      Width = 785
      Height = 13
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = '...'
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object edtBus: TEdit
      Left = 8
      Top = 25
      Width = 121
      Height = 21
      TabOrder = 0
      OnChange = edtBusChange
      OnKeyDown = edtBusKeyDown
    end
    object ckbFil: TCheckBox
      Left = 144
      Top = 27
      Width = 110
      Height = 17
      Caption = 'Filtrado > Filtro:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Visible = False
      OnClick = ckbFilClick
    end
    object mmoFil: TMemo
      Left = 258
      Top = 15
      Width = 321
      Height = 40
      Anchors = [akLeft, akTop, akRight]
      Lines.Strings = (
        '')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
      Visible = False
    end
    object mmoCol: TMemo
      Left = 596
      Top = 7
      Width = 329
      Height = 84
      Anchors = [akTop, akRight]
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 3
      Visible = False
    end
  end
  object dtsCDS: TDataSource
    Left = 510
    Top = 90
  end
end
