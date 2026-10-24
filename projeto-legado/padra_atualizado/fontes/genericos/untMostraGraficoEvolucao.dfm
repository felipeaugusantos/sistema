inherited frmMostraGraficoEvolucao: TfrmMostraGraficoEvolucao
  Caption = 'Relat'#243'rio de Evolu'#231#227'o'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 431
    Height = 30
    Enabled = True
    Visible = True
    ExplicitTop = 431
    ExplicitHeight = 30
    DesignSize = (
      769
      30)
    inherited btnSair: TBitBtnLocked
      Left = 687
      Top = 4
      Cancel = True
      TabOrder = 1
      ExplicitLeft = 687
      ExplicitTop = 4
    end
    object btnImprimir: TBitBtnLocked
      Left = 609
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
    Height = 431
    ExplicitHeight = 431
    inherited tbsGeral: TTabSheet
      Caption = 'Gr'#225'fico'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 399
    end
  end
  object dbchEvolucao: TDBChart [3]
    Left = 0
    Top = 0
    Width = 769
    Height = 431
    BackWall.Color = clWhite
    BackWall.Transparent = False
    BottomWall.Brush.Gradient.EndColor = clBlue
    BottomWall.Color = clSilver
    Gradient.Direction = gdBottomTop
    Gradient.EndColor = clSilver
    Gradient.MidColor = clWhite
    LeftWall.Color = clSilver
    MarginBottom = 5
    MarginLeft = 5
    MarginRight = 5
    MarginTop = 5
    PrintProportional = False
    RightWall.Brush.Gradient.Visible = True
    Title.Bevel = bvLowered
    Title.Font.Color = clBlack
    Title.Font.Height = -19
    Title.Font.Style = [fsBold]
    Title.Font.InterCharSize = 2
    Title.Font.Shadow.HorizSize = 2
    Title.Text.Strings = (
      'Gr'#225'fico de Evolu'#231#227'o')
    BottomAxis.LabelsAlternate = True
    BottomAxis.LabelsMultiLine = True
    BottomAxis.LabelsSeparation = 0
    BottomAxis.LabelsSize = 5
    BottomAxis.MinorGrid.Visible = True
    BottomAxis.MinorTickCount = 0
    BottomAxis.MinorTickLength = 0
    BottomAxis.TickLength = 0
    LeftAxis.AxisValuesFormat = '#,##0.##'
    LeftAxis.GridCentered = True
    LeftAxis.TickLength = 17
    LeftAxis.Title.Caption = 'Valores'
    LeftAxis.Title.Font.Height = -16
    LeftAxis.Title.Font.Style = [fsBold]
    LeftAxis.Title.Font.Shadow.VertSize = -2
    LeftAxis.Title.Visible = False
    Legend.DividingLines.Visible = True
    Legend.Visible = False
    RightAxis.Visible = False
    TopAxis.Title.Angle = 90
    TopAxis.Title.Caption = 'An'#225'lise de Resultados'
    TopAxis.Title.Font.Height = -19
    TopAxis.Title.Font.Style = [fsBold]
    TopAxis.Title.Font.Shadow.HorizSize = 2
    TopAxis.Visible = False
    Align = alClient
    Color = 16770261
    TabOrder = 3
    OnKeyDown = FormKeyDown
    DefaultCanvas = 'TGDIPlusCanvas'
    PrintMargins = (
      4
      5
      4
      5)
    ColorPaletteIndex = 13
    object brsrsEvolucao: TBarSeries
      ColorEachPoint = True
      Marks.Shadow.Smooth = False
      Marks.Style = smsValue
      Marks.AutoPosition = False
      Marks.BackColor = 15269887
      Marks.Callout.ArrowHeadSize = 0
      Marks.Callout.Length = 13
      Marks.MultiLine = True
      Marks.Color = 15269887
      DataSource = cdsEvolucao
      ValueFormat = '#,##0.##'
      XLabelsSource = 'MESANO'
      XValues.Name = 'X'
      XValues.Order = loNone
      XValues.ValueSource = 'VAL_EIXO_X'
      YValues.Name = 'Bar'
      YValues.Order = loNone
      YValues.ValueSource = 'TOTMES'
    end
    object brsrsSeries1: TBarSeries
      ColorEachPoint = True
      Marks.Style = smsValue
      Marks.AutoPosition = False
      Marks.BackColor = 15269887
      Marks.Callout.ArrowHeadSize = 0
      Marks.Callout.Length = 13
      Marks.Clip = True
      Marks.MultiLine = True
      Marks.Color = 15269887
      DataSource = cdsEvolucao2
      Title = 'brsrsEvolucao2'
      ValueFormat = '#,##0.##'
      XLabelsSource = 'MESANO'
      XValues.Name = 'X'
      XValues.Order = loNone
      XValues.ValueSource = 'VAL_EIXO_X'
      YValues.Name = 'Bar'
      YValues.Order = loNone
      YValues.ValueSource = 'TOTMES'
    end
  end
  inherited pnlStatus: TPanel
    inherited pnlInfo: TPanel
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 80
  end
  object cdsEvolucao: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 80
    object cdsEvolucaoVAL_EIXO_X: TIntegerField
      FieldName = 'VAL_EIXO_X'
    end
    object cdsEvolucaoMESANO: TStringField
      DisplayWidth = 20
      FieldName = 'MESANO'
    end
    object cdsEvolucaoTOTMES: TFloatField
      FieldName = 'TOTMES'
    end
  end
  object dlgImprimir: TPrinterSetupDialog
    Left = 352
    Top = 80
  end
  object cdsEvolucao2: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 112
    object cdsEvolucao2VAL_EIXO_X: TIntegerField
      FieldName = 'VAL_EIXO_X'
    end
    object cdsEvolucao2MESANO: TStringField
      DisplayWidth = 20
      FieldName = 'MESANO'
    end
    object cdsEvolucao2TOTMES: TFloatField
      FieldName = 'TOTMES'
    end
  end
end
