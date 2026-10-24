inherited frmChartRelatorioResult: TfrmChartRelatorioResult
  Width = 1082
  Height = 626
  BorderStyle = bsSizeable
  Caption = 'Gr'#225'fico'
  Color = 15263976
  StyleElements = [seFont, seBorder]
  OnResize = FormResize
  ExplicitWidth = 1082
  ExplicitHeight = 626
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 543
    Width = 1066
    ExplicitTop = 543
    ExplicitWidth = 1066
    inherited FlwBotoes: TFlowPanel
      Width = 1062
      ExplicitWidth = 1062
    end
    inherited btnSair: TBitBtnLocked
      Left = 986
      Caption = 'Sair'
      ExplicitLeft = 986
    end
  end
  inherited pnlStatus: TPanel
    Top = 571
    Width = 1066
    ExplicitTop = 571
    ExplicitWidth = 1066
    inherited pnlNomeForm: TPanel
      Left = 895
      ExplicitLeft = 895
    end
    inherited pnlInfo: TPanel
      Width = 895
      ExplicitWidth = 895
    end
  end
  object pnlMolduraSuperior: TPanel [2]
    Left = 0
    Top = 0
    Width = 1066
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlMolduraSuperior'
    Color = 15263976
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    StyleElements = [seFont, seBorder]
  end
  object pnlMolduraInferior: TPanel [3]
    Left = 0
    Top = 508
    Width = 1066
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = 15263976
    ParentBackground = False
    ShowCaption = False
    TabOrder = 3
    StyleElements = [seFont, seBorder]
  end
  object pnlMolduraEsquerda: TPanel [4]
    Left = 0
    Top = 35
    Width = 35
    Height = 473
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = 15263976
    ParentBackground = False
    ShowCaption = False
    TabOrder = 4
    StyleElements = [seFont, seBorder]
  end
  object pnlMolduraDireita: TPanel [5]
    Left = 1031
    Top = 35
    Width = 35
    Height = 473
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = 15263976
    ParentBackground = False
    ShowCaption = False
    TabOrder = 5
    StyleElements = [seFont, seBorder]
  end
  object Panel5: TPanel [6]
    Left = 35
    Top = 35
    Width = 996
    Height = 473
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel5'
    Color = 15263976
    ParentBackground = False
    TabOrder = 6
    DesignSize = (
      996
      473)
    object shpGrafico: TShape
      Left = 0
      Top = 0
      Width = 996
      Height = 473
      Align = alClient
      Pen.Style = psClear
      ExplicitLeft = 6
      ExplicitTop = -4
      ExplicitWidth = 781
      ExplicitHeight = 459
    end
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 10
      Height = 10
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000000A
        0000000A0802000000025058EA000000017352474200AECE1CE9000000046741
        4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
        0000434944415428538DCDD10900200845516B09F7DFCE2DEC8552560A9D9F84
        4BDA44841ECC6C43B7275A0D8E8C101BEC7C05E3396D90DC8E66AEBE4253551F
        331FCB4B4403FAA107AB2DD58AAA0000000049454E44AE426082}
    end
    object Image2: TImage
      Left = 985
      Top = 0
      Width = 10
      Height = 10
      Anchors = [akTop, akRight]
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000000A
        0000000A0802000000025058EA000000017352474200AECE1CE9000000046741
        4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
        00004349444154285363FCFFFF3F0318BC7CF912C240064C509A81415C5C1CCA
        420208DD70806C0C42371C201B83451A08E02AB04BC3014E698801589C860CC8
        351C04181800F6D40F93759654D70000000049454E44AE426082}
    end
    object Image3: TImage
      Left = 0
      Top = 462
      Width = 10
      Height = 10
      Anchors = [akLeft, akBottom]
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000000A
        0000000A0802000000025058EA000000017352474200AECE1CE9000000046741
        4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
        00003649444154285363FCFFFF3F036EC004A5710042D22F5FBE8432B101906E
        3C2A88B31B970108DD5855A0180E5481A6088BDD08150C0C001839162E94ECBA
        750000000049454E44AE426082}
    end
    object Image4: TImage
      Left = 985
      Top = 462
      Width = 10
      Height = 10
      Anchors = [akRight, akBottom]
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000000A
        0000000A0802000000025058EA000000017352474200AECE1CE9000000046741
        4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
        00003749444154285363FCFFFF3F036EC004A571000AA45FBE7C89531A280724
        C9321CA21508B048C3E58000C5DFC8121080D08D29C7C0C00000A454166F77F2
        649E0000000049454E44AE426082}
    end
    object cxgGrafico: TcxGrid
      Left = 34
      Top = 25
      Width = 943
      Height = 422
      BorderStyle = cxcbsNone
      TabOrder = 0
      LookAndFeel.Kind = lfUltraFlat
      object cxvGrafico: TcxGridDBChartView
        Categories.DataBinding.FieldName = 'legenda'
        DataController.DataSource = dtsGrafigo
        DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
        DiagramArea.Legend.Position = cppNone
        DiagramArea.Transparency = 70
        DiagramBar.AxisCategory.GridLines = False
        DiagramBar.Values.VaryColorsByCategory = True
        DiagramColumn.Active = True
        DiagramColumn.Legend.Position = cppNone
        DiagramColumn.AxisCategory.GridLines = False
        DiagramColumn.Values.VaryColorsByCategory = True
        DiagramColumn.Values.CaptionPosition = cdvcpOutsideEnd
        DiagramLine.Legend.Position = cppNone
        DiagramPie.SeriesSites = True
        DiagramPie.Values.CaptionPosition = pdvcpOutsideEndWithLeaderLines
        DiagramPie.Values.CaptionItems = [pdvciPercentage]
        DiagramStackedArea.Legend.Position = cppNone
        Legend.Border = lbNone
        Title.Alignment = cpaStart
        ToolBox.Border = tbNone
        object cxvGraficoSeries1: TcxGridDBChartSeries
          DataBinding.FieldName = 'VALOR'
          ValueCaptionFormat = '#,###.00'
        end
      end
      object cxgGraficoLevel1: TcxGridLevel
        GridView = cxvGrafico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 320
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 248
    Top = 344
  end
  object dtsGrafigo: TDataSource
    Left = 500
    Top = 401
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 792
    Top = 112
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 8454143
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsItalic]
      TextColor = clFuchsia
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clYellow
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clLime
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      TextColor = clMaroon
    end
  end
end
