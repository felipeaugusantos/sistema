inherited frmRelEstatAnalResultGraficos: TfrmRelEstatAnalResultGraficos
  Width = 800
  Height = 600
  Caption = 'An'#225'lise de Resultados / DRE - Gr'#225'ficos'
  Position = poMainFormCenter
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 526
    Width = 794
    Height = 30
    Enabled = True
    Visible = True
    ExplicitTop = 526
    ExplicitWidth = 794
    ExplicitHeight = 30
    DesignSize = (
      794
      30)
    object lblDespesas: TLabel [0]
      Left = 2
      Top = 2
      Width = 314
      Height = 26
      Align = alLeft
      Caption = 'Total das Despesas: 99.999.999,99 '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      ExplicitHeight = 23
    end
    inherited btnSair: TBitBtnLocked
      Left = 712
      Top = 4
      Cancel = True
      TabOrder = 1
      ExplicitLeft = 712
      ExplicitTop = 4
    end
    object btnImprimir: TBitBtnLocked
      Left = 634
      Top = 4
      Width = 76
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '&Imprimir'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
        8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
        93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
        9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
        678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
        8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
        E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
        8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
        EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
        C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
        C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
        D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
        9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
        B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
        BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
        C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
        C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
        AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnImprimirClick
    end
  end
  inherited pgcDados: TPageControl
    Width = 794
    Height = 526
    Style = tsTabs
    OnChange = pgcDadosChange
    ExplicitWidth = 794
    ExplicitHeight = 526
    inherited tbsGeral: TTabSheet
      Caption = '[ F1 ] - &Resultados / DRE'
      ExplicitLeft = 4
      ExplicitTop = 25
      ExplicitWidth = 786
      ExplicitHeight = 497
      object dbchAnalise: TDBChart
        Left = 0
        Top = 0
        Width = 786
        Height = 497
        BackWall.Brush.Gradient.Visible = True
        BackWall.Transparent = False
        BottomWall.Brush.Gradient.EndColor = clBlue
        BottomWall.Brush.Gradient.Visible = True
        Gradient.Direction = gdBottomTop
        Gradient.EndColor = clSilver
        Gradient.MidColor = clWhite
        LeftWall.Brush.Gradient.Visible = True
        RightWall.Brush.Gradient.Visible = True
        Title.Bevel = bvLowered
        Title.Font.Color = clBlack
        Title.Font.Height = -19
        Title.Font.Style = [fsBold]
        Title.Font.InterCharSize = 2
        Title.Font.Shadow.HorizSize = 2
        Title.Text.Strings = (
          'Gr'#225'fico de Resultado / DRE')
        BottomAxis.Labels = False
        BottomAxis.LabelsFormat.Visible = False
        BottomAxis.LabelsSeparation = 1
        BottomAxis.MinorGrid.Visible = True
        BottomAxis.Visible = False
        LeftAxis.AxisValuesFormat = '#,##0.##'
        LeftAxis.GridCentered = True
        LeftAxis.TickLength = 17
        LeftAxis.Title.Caption = 'Valores'
        LeftAxis.Title.Font.Height = -16
        LeftAxis.Title.Font.Style = [fsBold]
        LeftAxis.Title.Font.Shadow.VertSize = -2
        Legend.DividingLines.Visible = True
        Legend.Visible = False
        RightAxis.Visible = False
        TopAxis.Title.Angle = 90
        TopAxis.Title.Caption = 'An'#225'lise de Resultados / DRE'
        TopAxis.Title.Font.Height = -19
        TopAxis.Title.Font.Style = [fsBold]
        TopAxis.Title.Font.Shadow.HorizSize = 2
        TopAxis.Visible = False
        Align = alClient
        Color = 16770261
        TabOrder = 0
        OnKeyDown = FormKeyDown
        DefaultCanvas = 'TGDIPlusCanvas'
        PrintMargins = (
          15
          22
          15
          22)
        ColorPaletteIndex = 13
        object brsrsSerieAnalise: TBarSeries
          Marks.Style = smsLabelValue
          ValueFormat = '#,##0.##'
          XLabelsSource = 'LEGENDAS'
          BarStyle = bsRectGradient
          BarWidthPercent = 65
          MultiBar = mbNone
          XValues.Name = 'X'
          XValues.Order = loNone
          XValues.ValueSource = 'VALORESX'
          YValues.Name = 'Bar'
          YValues.Order = loNone
          YValues.ValueSource = 'VALORESY'
          Data = {0000000000}
        end
      end
    end
    object tbsAvaliacao: TTabSheet
      Caption = '[ F2 ] - &Avalia'#231#227'o'
      ImageIndex = 1
      object dbchAvaliacao: TDBChart
        Left = 0
        Top = 0
        Width = 786
        Height = 497
        BackWall.Brush.Gradient.Visible = True
        BackWall.Transparent = False
        BottomWall.Brush.Gradient.EndColor = clBlue
        BottomWall.Brush.Gradient.Visible = True
        Gradient.Direction = gdBottomTop
        Gradient.EndColor = clSilver
        Gradient.MidColor = clWhite
        LeftWall.Brush.Gradient.Visible = True
        RightWall.Brush.Gradient.Visible = True
        Title.Bevel = bvLowered
        Title.Font.Color = clBlack
        Title.Font.Height = -19
        Title.Font.Style = [fsBold]
        Title.Font.InterCharSize = 2
        Title.Font.Shadow.HorizSize = 2
        Title.Text.Strings = (
          'Gr'#225'fico de Avalia'#231#227'o')
        BottomAxis.Labels = False
        BottomAxis.LabelsFormat.Visible = False
        BottomAxis.LabelsSeparation = 1
        BottomAxis.MinorGrid.Visible = True
        BottomAxis.Visible = False
        LeftAxis.AxisValuesFormat = '#,##0.##'
        LeftAxis.GridCentered = True
        LeftAxis.TickLength = 17
        LeftAxis.Title.Caption = 'Valores'
        LeftAxis.Title.Font.Height = -16
        LeftAxis.Title.Font.Style = [fsBold]
        LeftAxis.Title.Font.Shadow.VertSize = -2
        Legend.DividingLines.Visible = True
        Legend.Visible = False
        RightAxis.Visible = False
        TopAxis.Title.Angle = 90
        TopAxis.Title.Caption = 'An'#225'lise de Resultados / DRE'
        TopAxis.Title.Font.Height = -19
        TopAxis.Title.Font.Style = [fsBold]
        TopAxis.Title.Font.Shadow.HorizSize = 2
        TopAxis.Visible = False
        Align = alClient
        Color = 16770261
        TabOrder = 0
        OnKeyDown = FormKeyDown
        DefaultCanvas = 'TGDIPlusCanvas'
        PrintMargins = (
          15
          22
          15
          22)
        ColorPaletteIndex = 13
        object brsrsAvaliacao: TBarSeries
          ColorEachPoint = True
          Marks.Style = smsLabelValue
          Title = 'Avaliacao'
          ValueFormat = '#,##0.##'
          XLabelsSource = 'LEGENDAS'
          BarStyle = bsRectGradient
          BarWidthPercent = 65
          MultiBar = mbNone
          XValues.Name = 'X'
          XValues.Order = loNone
          XValues.ValueSource = 'VALORESX'
          YValues.Name = 'Bar'
          YValues.Order = loNone
          YValues.ValueSource = 'VALORESY'
          Data = {0000000000}
        end
      end
    end
    object tbsContasResultado: TTabSheet
      Caption = '[ F3 ] - &Contas de Resultado / DRE'
      ImageIndex = 2
      object dbchContas: TDBChart
        Left = 0
        Top = 0
        Width = 786
        Height = 497
        BackWall.Brush.Gradient.Visible = True
        BackWall.Transparent = False
        BottomWall.Brush.Gradient.EndColor = clBlue
        BottomWall.Brush.Gradient.Visible = True
        Gradient.Direction = gdBottomTop
        Gradient.EndColor = clSilver
        Gradient.MidColor = clWhite
        LeftWall.Brush.Gradient.Visible = True
        RightWall.Brush.Gradient.Visible = True
        Title.Bevel = bvLowered
        Title.Font.Color = clBlack
        Title.Font.Height = -19
        Title.Font.Style = [fsBold]
        Title.Font.InterCharSize = 2
        Title.Font.Shadow.HorizSize = 2
        Title.Text.Strings = (
          'Gr'#225'fico de Contas de Resultado / DRE')
        BottomAxis.Labels = False
        BottomAxis.LabelsFormat.Visible = False
        BottomAxis.LabelsSeparation = 1
        BottomAxis.MinorGrid.Visible = True
        BottomAxis.Visible = False
        Chart3DPercent = 25
        LeftAxis.AxisValuesFormat = '#,##0.##'
        LeftAxis.GridCentered = True
        LeftAxis.TickLength = 17
        LeftAxis.Title.Caption = 'Valores'
        LeftAxis.Title.Font.Height = -16
        LeftAxis.Title.Font.Style = [fsBold]
        LeftAxis.Title.Font.Shadow.VertSize = -2
        Legend.DividingLines.Visible = True
        Legend.Visible = False
        RightAxis.Visible = False
        TopAxis.Title.Angle = 90
        TopAxis.Title.Caption = 'An'#225'lise de Resultados / DRE'
        TopAxis.Title.Font.Height = -19
        TopAxis.Title.Font.Style = [fsBold]
        TopAxis.Title.Font.Shadow.HorizSize = 2
        TopAxis.Visible = False
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        View3DOptions.VertOffset = 14
        View3DOptions.Zoom = 106
        Align = alClient
        Color = 16770261
        TabOrder = 0
        OnKeyDown = FormKeyDown
        DefaultCanvas = 'TGDIPlusCanvas'
        PrintMargins = (
          15
          18
          15
          18)
        ColorPaletteIndex = 13
        object lbl2: TLabel
          Left = 424
          Top = 464
          Width = 30
          Height = 14
          Caption = 'Zoom:'
        end
        object lbla: TLabel
          Left = 215
          Top = 464
          Width = 47
          Height = 14
          Caption = 'Eleva'#231#227'o:'
        end
        object lbl1: TLabel
          Left = 11
          Top = 465
          Width = 43
          Height = 14
          Caption = 'Rota'#231#227'o:'
        end
        object chkAtivarRotacao: TCheckBox
          Left = 619
          Top = 462
          Width = 105
          Height = 17
          BiDiMode = bdRightToLeft
          Caption = 'Animar o gr'#225'fico'
          ParentBiDiMode = False
          TabOrder = 3
          OnKeyDown = FormKeyDown
        end
        object trkbRotacao: TTrackBar
          Left = 56
          Top = 459
          Width = 150
          Height = 29
          Max = 360
          Frequency = 36
          TabOrder = 0
          OnChange = trkbRotacaoChange
          OnKeyDown = FormKeyDown
        end
        object trkbElevacao: TTrackBar
          Left = 264
          Top = 459
          Width = 150
          Height = 29
          Max = 360
          Min = 270
          Frequency = 10
          Position = 270
          TabOrder = 1
          OnChange = trkbElevacaoChange
          OnKeyDown = FormKeyDown
        end
        object trkbZoom: TTrackBar
          Left = 456
          Top = 459
          Width = 150
          Height = 29
          Max = 500
          Min = 1
          Frequency = 50
          Position = 1
          TabOrder = 2
          OnChange = trkbZoomChange
          OnKeyDown = FormKeyDown
        end
        object pSerContas: TPieSeries
          Marks.Style = smsLabelValue
          Marks.Callout.Length = 20
          DataSource = cdsContas
          Title = 'Avaliacao'
          ValueFormat = '#,##0.##'
          XLabelsSource = 'LEGENDAS'
          XValues.Order = loAscending
          YValues.Name = 'Pie'
          YValues.Order = loNone
          YValues.ValueSource = 'VALORES'
          Frame.InnerBrush.BackColor = clRed
          Frame.InnerBrush.Gradient.EndColor = clGray
          Frame.InnerBrush.Gradient.MidColor = clWhite
          Frame.InnerBrush.Gradient.StartColor = 4210752
          Frame.InnerBrush.Gradient.Visible = True
          Frame.MiddleBrush.BackColor = clYellow
          Frame.MiddleBrush.Gradient.EndColor = 8553090
          Frame.MiddleBrush.Gradient.MidColor = clWhite
          Frame.MiddleBrush.Gradient.StartColor = clGray
          Frame.MiddleBrush.Gradient.Visible = True
          Frame.OuterBrush.BackColor = clGreen
          Frame.OuterBrush.Gradient.EndColor = 4210752
          Frame.OuterBrush.Gradient.MidColor = clWhite
          Frame.OuterBrush.Gradient.StartColor = clSilver
          Frame.OuterBrush.Gradient.Visible = True
          Frame.Width = 4
          OtherSlice.Legend.Visible = False
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 556
    Width = 794
    ExplicitTop = 556
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 536
    Top = 288
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 504
    Top = 288
  end
  object cdsContas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 8
    Top = 424
    object cdsContasLEGENDAS: TStringField
      FieldName = 'LEGENDAS'
      Size = 50
    end
    object cdsContasVALORES: TFloatField
      FieldName = 'VALORES'
      DisplayFormat = '##,#0.00'
      EditFormat = '##,#0.00'
    end
  end
  object tmrRotacao: TTimer
    Enabled = False
    OnTimer = tmrRotacaoTimer
    Left = 568
    Top = 288
  end
  object dlgImprimir: TPrinterSetupDialog
    Left = 600
    Top = 288
  end
end
