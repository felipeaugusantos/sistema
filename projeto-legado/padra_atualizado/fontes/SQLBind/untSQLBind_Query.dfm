object frmSQLBind_Query: TfrmSQLBind_Query
  Left = 0
  Top = 0
  Caption = 'SQL Bind'
  ClientHeight = 566
  ClientWidth = 897
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object mmoErr: TMemo
    Left = 0
    Top = 479
    Width = 897
    Height = 66
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'Error Message')
    ParentFont = False
    TabOrder = 2
    Visible = False
    OnKeyDown = memSQLKeyDown
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 647
    Height = 402
    Align = alClient
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 324
      Width = 645
      Height = 6
      Cursor = crVSplit
      Align = alBottom
      ResizeStyle = rsLine
      ExplicitLeft = -11
      ExplicitTop = 413
    end
    object memSQL: TMemo
      Left = 1
      Top = 26
      Width = 645
      Height = 298
      Align = alClient
      Color = 16776176
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 1
      OnKeyDown = memSQLKeyDown
    end
    object GridBind: TcxGrid
      Left = 1
      Top = 330
      Width = 645
      Height = 71
      Align = alBottom
      TabOrder = 2
      LookAndFeel.ScrollbarMode = sbmClassic
      object GridBindDBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
      end
      object GridBindLevel1: TcxGridLevel
        GridView = GridBindDBTableView
      end
    end
    object pnlButtons: TPanel
      Left = 1
      Top = 1
      Width = 645
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object btnRestaurar: TBitBtn
        Left = 0
        Top = 0
        Width = 152
        Height = 25
        Align = alLeft
        Caption = '[F5] Restaurar SQL Original'
        Style = bsNew
        TabOrder = 0
        OnClick = btnRestaurarClick
      end
      object btnShowHideParam: TBitBtn
        Left = 392
        Top = 0
        Width = 144
        Height = 25
        Align = alLeft
        Caption = '[F10] Esconder Parametros'
        Style = bsNew
        TabOrder = 3
        OnClick = btnShowHideParamClick
      end
      object btnSQLBound: TBitBtn
        Left = 152
        Top = 0
        Width = 128
        Height = 25
        Align = alLeft
        Caption = '[F6] SQL Com Valores'
        Style = bsNew
        TabOrder = 1
        OnClick = btnSQLBoundClick
      end
      object btnExecutar: TBitBtn
        Left = 280
        Top = 0
        Width = 112
        Height = 25
        Align = alLeft
        Caption = '[F8] Executar SQL'
        Style = bsNew
        TabOrder = 2
        OnClick = btnExecutarClick
      end
      object btnIdentar: TBitBtn
        Left = 536
        Top = 0
        Width = 97
        Height = 25
        Align = alLeft
        Caption = '[F11] Identar SQL'
        Style = bsNew
        TabOrder = 4
        OnClick = btnIdentarClick
      end
    end
  end
  object pnlSlider: TPanel
    Left = 647
    Top = 0
    Width = 250
    Height = 402
    Align = alRight
    TabOrder = 1
    object GridParams: TcxGrid
      Left = 1
      Top = 26
      Width = 248
      Height = 375
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object GridParamsView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsParams
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridParamsViewParam: TcxGridDBColumn
          DataBinding.FieldName = 'Param'
          Options.Editing = False
          Width = 100
        end
        object GridParamsViewValue: TcxGridDBColumn
          DataBinding.FieldName = 'Value'
          Width = 125
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = GridParamsView
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 248
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object btnRestaurarParam: TBitBtn
        Left = 0
        Top = 0
        Width = 144
        Height = 25
        Align = alLeft
        Caption = 'Restaurar Parametros'
        Style = bsNew
        TabOrder = 0
        OnClick = btnRestaurarParamClick
      end
    end
  end
  object stb: TPanel
    Left = 0
    Top = 545
    Width = 897
    Height = 21
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    Caption = 'HOST: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Padding.Left = 10
    ParentFont = False
    TabOrder = 3
  end
  object mmoCol: TMemo
    Left = 0
    Top = 402
    Width = 897
    Height = 77
    Align = alBottom
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
    Visible = False
  end
  object dtsParams: TDataSource
    DataSet = cdsParams
    Left = 576
    Top = 48
  end
  object cdsParams: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 608
    Top = 48
    object cdsParamsParam: TStringField
      FieldName = 'Param'
    end
    object cdsParamsValue: TStringField
      FieldName = 'Value'
      Size = 255
    end
    object cdsParamsType: TIntegerField
      FieldName = 'Type'
    end
  end
end
