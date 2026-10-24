object frmQckSantander: TfrmQckSantander
  Left = 126
  Top = 3
  Width = 988
  Height = 788
  AutoScroll = True
  Caption = 'frmQckSantander'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object QckBoleto: TQuickRep
    Left = 8
    Top = 2
    Width = 952
    Height = 1347
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      100.000000000000000000
      2970.000000000000000000
      50.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      100.000000000000000000
      0.000000000000000000)
    PrinterSettings.Copies = 1
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.UseStandardprinter = False
    PrinterSettings.UseCustomBinCode = False
    PrinterSettings.CustomBinCode = 0
    PrinterSettings.ExtendedDuplex = 0
    PrinterSettings.UseCustomPaperCode = False
    PrinterSettings.CustomPaperCode = 0
    PrinterSettings.PrintMetaFile = False
    PrinterSettings.PrintQuality = 0
    PrinterSettings.Collate = 0
    PrinterSettings.ColorOption = 0
    PrintIfEmpty = True
    ShowProgress = False
    SnapToGrid = True
    Units = MM
    Zoom = 120
    PrevFormStyle = fsNormal
    PreviewInitialState = wsNormal
    PrevInitialZoom = qrZoomToFit
    PreviewDefaultSaveType = stQRP
    PreviewLeft = 0
    PreviewTop = 0
    object TitleBand1: TQRBand
      Left = 45
      Top = 23
      Width = 861
      Height = 1178
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        2597.326388888889000000
        1898.385416666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object LinhaHorizontal6: TQRShape
        Left = 4
        Top = 270
        Width = 853
        Height = 2
        Size.Values = (
          3.307291666666670000
          9.921875000000000000
          595.312500000000000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal5: TQRShape
        Left = 3
        Top = 155
        Width = 853
        Height = 2
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          340.651041666667000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal4: TQRShape
        Left = 3
        Top = 124
        Width = 853
        Height = 2
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          274.505208333333000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal3: TQRShape
        Left = 4
        Top = 94
        Width = 853
        Height = 4
        Size.Values = (
          9.921875000000000000
          9.921875000000000000
          208.359375000000000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal1: TQRShape
        Left = 4
        Top = 29
        Width = 853
        Height = 14
        Size.Values = (
          29.765625000000000000
          9.921875000000000000
          62.838541666666700000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal2: TQRShape
        Left = 4
        Top = 66
        Width = 853
        Height = 2
        Size.Values = (
          3.307291666666670000
          9.921875000000000000
          145.520833333333000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaVertical1: TQRShape
        Left = 191
        Top = 11
        Width = 12
        Height = 24
        Size.Values = (
          52.916666666666700000
          420.026041666667000000
          23.151041666666700000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LinhaHorizontal7: TQRShape
        Left = 4
        Top = 324
        Width = 853
        Height = 4
        Size.Values = (
          9.921875000000000000
          9.921875000000000000
          714.375000000000000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNrBanco: TQRLabel
        Left = 200
        Top = 11
        Width = 83
        Height = 24
        Size.Values = (
          52.916666666666700000
          439.869791666667000000
          23.151041666666700000
          181.901041666667000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '353-7'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNrBancoPrint
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 12
      end
      object LabelVencimento: TQRLabel
        Left = 672
        Top = 37
        Width = 48
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          81.579861111111110000
          105.833333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Vencimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LinhaVertical2: TQRShape
        Left = 281
        Top = 11
        Width = 11
        Height = 24
        Size.Values = (
          52.916666666666700000
          618.463541666667000000
          23.151041666666700000
          23.151041666666700000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelLocalPagamento: TQRLabel
        Left = 5
        Top = 37
        Width = 82
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          81.579861111111110000
          180.798611111111100000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Local de Pagamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelCedente: TQRLabel
        Left = 5
        Top = 70
        Width = 49
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          154.340277777777800000
          108.038194444444400000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Benefici'#225'rio'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelNomeCedente: TQRLabel
        Left = 57
        Top = 73
        Width = 603
        Height = 18
        Size.Values = (
          39.687500000000000000
          125.677083333333300000
          160.954861111111100000
          1329.531250000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nome do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNomeCedentePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object LabelAgenciaCodigoCedente: TQRLabel
        Left = 672
        Top = 70
        Width = 89
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          154.340277777777800000
          196.232638888888900000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Ag'#234'ncia/C'#243'd. Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelDataDocumento: TQRLabel
        Left = 5
        Top = 98
        Width = 78
        Height = 10
        Size.Values = (
          22.048611111111110000
          11.024305555555560000
          216.076388888888900000
          171.979166666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelNrDocumento: TQRLabel
        Left = 145
        Top = 98
        Width = 70
        Height = 10
        Size.Values = (
          22.048611111111110000
          319.704861111111100000
          216.076388888888900000
          154.340277777777800000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'N'#186' do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelEspecieDoc: TQRLabel
        Left = 335
        Top = 98
        Width = 54
        Height = 10
        Size.Values = (
          22.048611111111110000
          738.628472222222200000
          216.076388888888900000
          119.062500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Esp'#233'cie Doc.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelAceite: TQRLabel
        Left = 415
        Top = 98
        Width = 26
        Height = 10
        Size.Values = (
          22.048611111111110000
          915.017361111111100000
          216.076388888888900000
          57.326388888888890000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Aceite'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelDataProcessamento: TQRLabel
        Left = 475
        Top = 98
        Width = 96
        Height = 10
        Size.Values = (
          22.048611111111110000
          1047.309027777778000000
          216.076388888888900000
          211.666666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data do Processamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelNossoNumero: TQRLabel
        Left = 672
        Top = 98
        Width = 84
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          216.076388888888900000
          185.208333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cart./ Nosso N'#250'mero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelUsoBanco: TQRLabel
        Left = 5
        Top = 127
        Width = 56
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          280.017361111111100000
          123.472222222222200000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Uso do Banco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelCarteira: TQRLabel
        Left = 169
        Top = 127
        Width = 20
        Height = 13
        Size.Values = (
          28.663194444444440000
          372.621527777777800000
          280.017361111111100000
          44.097222222222220000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cart.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelEspecie: TQRLabel
        Left = 227
        Top = 127
        Width = 44
        Height = 11
        Size.Values = (
          24.253472222222220000
          500.503472222222200000
          280.017361111111100000
          97.013888888888890000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Esp Moeda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelReal: TQRLabel
        Left = 230
        Top = 137
        Width = 75
        Height = 18
        Size.Values = (
          39.687500000000000000
          506.015625000000000000
          300.963541666667000000
          165.364583333333000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'R$'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object LabelQuantidade: TQRLabel
        Left = 317
        Top = 127
        Width = 46
        Height = 13
        Size.Values = (
          28.663194444444440000
          698.940972222222200000
          280.017361111111100000
          101.423611111111100000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Quantidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelValor: TQRLabel
        Left = 589
        Top = 127
        Width = 41
        Height = 13
        Size.Values = (
          28.663194444444440000
          1298.663194444444000000
          280.017361111111100000
          90.399305555555560000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Vr. Moeda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelX: TQRLabel
        Left = 576
        Top = 127
        Width = 10
        Height = 19
        Size.Values = (
          41.892361111111110000
          1270.000000000000000000
          280.017361111111100000
          22.048611111111110000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'x'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 9
      end
      object LabelValorDocumento: TQRLabel
        Left = 672
        Top = 127
        Width = 94
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          280.017361111111100000
          207.256944444444400000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(=) Valor do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel1: TQRLabel
        Left = 5
        Top = 156
        Width = 43
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          343.958333333333300000
          94.809027777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Instru'#231#245'es'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelDesconto: TQRLabel
        Left = 672
        Top = 157
        Width = 95
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          346.163194444444400000
          209.461805555555600000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(-) Desconto/Abatimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelMoraMulta: TQRLabel
        Left = 672
        Top = 205
        Width = 55
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          451.996527777777800000
          121.267361111111100000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(+) Mora/Multa'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelValorCobrado: TQRLabel
        Left = 672
        Top = 252
        Width = 71
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          555.625000000000000000
          156.545138888888900000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(=) Valor Cobrado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelSacado: TQRLabel
        Left = 7
        Top = 273
        Width = 38
        Height = 13
        Size.Values = (
          28.663194444444440000
          15.434027777777780000
          601.927083333333300000
          83.784722222222220000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Pagador:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelSacadorAvalista: TQRLabel
        Left = 1
        Top = 313
        Width = 74
        Height = 12
        Size.Values = (
          26.458333333333330000
          2.204861111111111000
          690.121527777777800000
          163.159722222222200000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Sacador/Avalista:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelCodigoBaixa: TQRLabel
        Left = 683
        Top = 312
        Width = 74
        Height = 13
        Size.Values = (
          28.663194444444440000
          1505.920138888889000000
          687.916666666666700000
          163.159722222222200000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'C'#243'digo de Baixa'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object LabelAutenticacaoMecanica: TQRLabel
        Left = 707
        Top = 328
        Width = 53
        Height = 12
        Size.Values = (
          26.458333333333330000
          1558.836805555556000000
          723.194444444444400000
          116.857638888888900000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Autentica'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape2: TQRShape
        Left = 668
        Top = 202
        Width = 189
        Height = 2
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          446.484375000000000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 668
        Top = 222
        Width = 189
        Height = 6
        Size.Values = (
          13.229166666666700000
          1471.744791666670000000
          489.479166666667000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNomeTitular: TQRLabel
        Left = 60
        Top = 274
        Width = 372
        Height = 14
        Size.Values = (
          29.765625000000000000
          132.291666666667000000
          605.234375000000000000
          820.208333333334000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'LabelNomeTitular'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNomeTitularPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object LabelEndereco: TQRLabel
        Left = 60
        Top = 288
        Width = 372
        Height = 14
        Size.Values = (
          29.765625000000000000
          132.291666666667000000
          635.000000000000000000
          820.208333333334000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'LabelEndereco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelEnderecoPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object LabelCidade: TQRLabel
        Left = 60
        Top = 300
        Width = 372
        Height = 14
        Size.Values = (
          29.765625000000000000
          132.291666666667000000
          661.458333333333000000
          820.208333333334000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'LabelCidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelCidadePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRShape1: TQRShape
        Left = 666
        Top = 34
        Width = 4
        Height = 236
        Size.Values = (
          519.244791666667000000
          1468.437500000000000000
          76.067708333333300000
          9.921875000000000000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelInformacao1: TQRLabel
        Left = 6
        Top = 51
        Width = 652
        Height = 14
        Size.Values = (
          29.765625000000000000
          13.229166666666700000
          112.447916666667000000
          1438.671875000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'EM QUALQUER AG'#202'NCIA, AP'#211'S O VENCTO NAS AG. DO BANESPA SANTANDER ' +
          'OU DE ACORDO COM AS INSTRU'#199#213'ES DA FICHA DE COMPENSA'#199#195'O'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel2: TQRLabel
        Left = 227
        Top = 38
        Width = 292
        Height = 10
        Size.Values = (
          22.048611111111100000
          500.503472222222000000
          83.784722222222200000
          643.819444444444000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pag'#225'vel preferencialmente nas Ag'#234'ncias do Banespa Santander'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape4: TQRShape
        Left = 142
        Top = 96
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          314.192708333333000000
          211.666666666667000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 330
        Top = 96
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          727.604166666667000000
          211.666666666667000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape6: TQRShape
        Left = 412
        Top = 96
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          909.505208333333000000
          211.666666666667000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape8: TQRShape
        Left = 165
        Top = 126
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          363.802083333333000000
          277.812500000000000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 220
        Top = 126
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          486.171875000000000000
          277.812500000000000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape12: TQRShape
        Left = 579
        Top = 126
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          1276.614583333330000000
          277.812500000000000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape16: TQRShape
        Left = 668
        Top = 246
        Width = 187
        Height = 6
        Size.Values = (
          13.229166666666700000
          1471.744791666670000000
          542.395833333333000000
          413.411458333333000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape17: TQRShape
        Left = 312
        Top = 126
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          687.916666666667000000
          277.812500000000000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object lblCidade: TQRLabel
        Left = 9
        Top = 137
        Width = 146
        Height = 18
        Size.Values = (
          39.687500000000000000
          19.843750000000000000
          300.963541666667000000
          320.807291666667000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Cidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblCidadePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRShape25: TQRShape
        Left = 468
        Top = 96
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          1031.875000000000000000
          211.666666666667000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object lblAceite: TQRLabel
        Left = 444
        Top = 107
        Width = 10
        Height = 17
        Size.Values = (
          37.482638888888890000
          978.958333333333300000
          235.920138888888900000
          22.048611111111110000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'N'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblAceitePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel3: TQRLabel
        Left = 633
        Top = 1125
        Width = 180
        Height = 27
        Size.Values = (
          59.531250000000000000
          1395.677083333333000000
          2480.468750000000000000
          396.875000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Ficha de Compensa'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRShape9: TQRShape
        Left = 3
        Top = 758
        Width = 853
        Height = 6
        Size.Values = (
          13.229166666666700000
          6.614583333333330000
          1670.182291666670000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRImage2: TQRImage
        Left = 7
        Top = 5
        Width = 149
        Height = 29
        Size.Values = (
          63.940972222222200000
          15.434027777777800000
          11.024305555555600000
          328.524305555556000000)
        XLColumn = 0
        AutoSize = True
        Picture.Data = {
          07544269746D61707A520000424D7A520000000000003600000028000000B400
          0000270000000100180000000000445200000000000000000000000000000000
          00000101FF0101FF0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE
          0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102
          FE0102FE0102FE0102FE0102FE0102FE0001FD0001FD0001FD0102FE0102FE01
          02FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE
          0103FC0103FC0103FC0103FC0103FC0302FC0302FC0302FC0302FC0302FC0302
          FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0403FD0403FD04
          03FD0403FD0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC
          0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303
          FB0303FB0303FB0404FC0404FC0404FC0405FA0405FA0405FA0304F90304F903
          04F90304F90304F90304F90304F90304F90304F90304F90304F90304F90304F9
          0304F90304F90405FA0405FA0405F90405F90405F90405F90405F90405F90405
          F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F904
          05F90405F90405F90405F90405F90405F90405F90406F80406F80406F80406F8
          0406F80406F80406F80406F80406F80406F80406F80406F80506F80506F80506
          F80506F80506F80506F80506F80506F80508F70508F70508F70508F70508F705
          08F70508F70508F70607F70607F70607F70607F70607F70607F70607F70607F7
          0506F60506F60506F60506F60607F70607F70607F70607F70608F60608F60101
          FF0101FF0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE01
          02FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE
          0102FE0102FE0102FE0102FE0001FD0001FD0001FD0102FE0102FE0102FE0102
          FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0103FC01
          03FC0103FC0103FC0103FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC
          0302FC0302FC0302FC0302FC0302FC0302FC0302FC0403FD0403FD0403FD0403
          FD0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0303FB03
          03FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB
          0303FB0404FC0404FC0404FC0405FA0405FA0405FA0304F90304F90304F90304
          F90304F90304F90304F90304F90304F90304F90304F90304F90304F90304F903
          04F90405FA0405FA0405F90405F90405F90405F90405F90405F90405F90405F9
          0405F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405
          F90405F90405F90405F90405F90405F90406F80406F80406F80406F80406F804
          06F80406F80406F80406F80406F80406F80406F80506F80506F80506F80506F8
          0506F80506F80506F80506F80508F70508F70508F70508F70508F70508F70508
          F70508F70607F70607F70607F70607F70607F70607F70607F70607F70506F605
          06F60506F60506F60607F70607F70607F70607F70608F60608F60101FF0101FF
          0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102
          FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE01
          02FE0102FE0102FE0001FD0001FD0001FD0102FE0102FE0102FE0102FE0102FE
          0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0103FC0103FC0103
          FC0103FC0103FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC03
          02FC0302FC0302FC0302FC0302FC0302FC0403FD0403FD0403FD0403FD0302FC
          0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0303FB0303FB0303
          FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB04
          04FC0404FC0404FC0405FA0405FA0405FA0304F90304F90304F90304F90304F9
          0304F90304F90304F90304F90304F90304F90304F90304F90304F90304F90405
          FA0405FA0405F90405F90405F90405F90405F90405F90405F90405F90405F904
          05F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F9
          0405F90405F90405F90405F90406F80406F80406F80406F80406F80406F80406
          F80406F80406F80406F80406F80406F80506F80506F80506F80506F80506F805
          06F80506F80506F80508F70508F70508F70508F70508F70508F70508F70508F7
          0607F70607F70607F70607F70607F70607F70607F70607F70506F60506F60506
          F60506F60607F70607F70607F70607F70608F60608F60101FF0101FF0102FE01
          02FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE
          0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102
          FE0102FE0001FD0001FD0001FD0102FE0102FE0102FE0102FE0102FE0102FE01
          02FE0102FE0102FE0102FE0102FE0102FE0102FE0103FC0103FC0103FC0103FC
          0103FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302
          FC0302FC0302FC0302FC0302FC0403FD0403FD0403FD0403FD0302FC0302FC03
          02FC0302FC0302FC0302FC0302FC0302FC0302FC0303FB0303FB0303FB0303FB
          0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0404FC0404
          FC0404FC0405FA0405FA0405FA0304F90304F90304F90304F90304F90304F903
          04F90304F90304F90304F90304F90304F90304F90304F90304F90405FA0405FA
          0405F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405
          F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F904
          05F90405F90405F90406F80406F80406F80406F80406F80406F80406F80406F8
          0406F80406F80406F80406F80506F80506F80506F80506F80506F80506F80506
          F80506F80508F70508F70508F70508F70508F70508F70508F70508F70607F706
          07F70607F70607F70607F70607F70607F70607F70506F60506F60506F60506F6
          0607F70607F70607F70607F70608F60608F60101FF0101FF0102FE0102FE0102
          FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE01
          02FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE
          0001FD0001FD0001FD0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102
          FE0102FE0102FE0102FE0102FE0102FE0103FC0103FC0103FC0103FC0103FC03
          02FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC
          0302FC0302FC0302FC0403FD0403FD0403FD0403FD0302FC0302FC0302FC0302
          FC0302FC0302FC0302FC0302FC0302FC0303FB0303FB0303FB0303FB0303FB03
          03FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0404FC0404FC0404FC
          0405FA0405FA0405FA0304F90304F90304F90304F90304F90304F90304F90304
          F90304F90304F90304F90304F90304F90304F90304F90405FA0405FA0405F904
          05F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F9
          0405F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405
          F90405F90406F80406F80406F80406F80406F80406F80406F80406F80406F804
          06F80406F80406F80506F80506F80506F80506F80506F80506F80506F80506F8
          0508F70508F70508F70508F70508F70508F70508F70508F70607F70607F70607
          F70607F70607F70607F70607F70607F70506F60506F60506F60506F60607F706
          07F70607F70607F70608F60608F60101FF0101FF0005FC0001F00200FE090AFC
          0402FF0001FF0004F60005FF0003FF0402FF0904EF382FFF584EFF7F78FF8E8E
          F2B6BBFFC4C3F5B4BFFFB9BDFFB8C6FFC5BEFF7E7EFF8182FC5B55F62C2BFF0C
          06F70400FF0003FC0004F30307F90200FA0A02FF0300FE0E06FB0400F8000EED
          0002FE0102FE0502FF0007F50000FE0000FD0A05FB0401F10002FF0001FD0308
          FF1100F60100FD0902FD0600FF0000FB0407FC0601F00500FD0005FF0000FC00
          03FF0004FC0006FF0003FF0008F60003FF0003FA0006FF0000F90C04FF0009E9
          0000FE0000FD0709FB0002F50C04F90002FF0002FE0003FF0A02FF0003FC0001
          FE0005FD0E06FF0107EA0000FD0000FE0409FF0000FA0011F20003FE0007F507
          04FA0002FE0002FA0D09FC0000FC0503FF0004FC0E03FF0003FA0005F80701FF
          0709EA0008FF0001FE0901FF0108F9000AF00F01FF0005FF0709F10101F5000B
          FC0006FA000BEF0005FD0901FF0504FA0303FF0902F7000CEF0601FC0703F605
          03FD0509F40507F50408F30408FA0103FB0108F20704FF0000FC0407F60705F8
          0006FA020BEE0905F80007F1000CEE0005F90C00FF1003FF0603FF0006FB0A02
          FB000CF9000BF40002F5050AFF0307E80D09F50704FA080BEF0401FE0B05F811
          06F00F04FA0009F30007FF0200FB100BF00A07F61103F50005FC0707FB160AF0
          0702F8030AF90509F4010DEF020AF1000AF60707FF0A03F40D08F70508FD0307
          F90B06F50608F60608F60101FF0101FF0300FE0301FF0407FC0000F70007F300
          00F60D00FF2A0FF96F62EEACAEFFDDEFFFF1FFF8F4FFFDFBFAFFF9F6FFFFFEFF
          FFFEFFFBFBFFFFFFF7FBFDFDFFFFFBF8FFF8F9FDFEF3F9FFFDFFFCE6EEFBADB1
          FF5F56FF1B10FF0000FE0005FF0001FC0003F90202FF0903FF0000F90005FF00
          00FC0000F80304F90603F90207FF0006F30402F6090AFC0001FF0A0DFB3A43FF
          3B46F44242FA2E2BFD0707FF0000F20408FA0800FE0506F00900FE0609F40004
          FD0000F40C06F71402F5453DFF3D32FA1500F80B08FE0003F41725EF1816FC07
          04FA0102F60705FF0002FF0009ED0803FE0603F20D07F00B00F90C01FF0203F7
          0001F70207FF0404F80800F90A06F20E09F80502F20B00FF0707EF0402FC070F
          F60101FF0801F60B06EB0703FC0703FC0500F2080AFC0004F70402FF0402FF03
          04F9070AEE3844F6231EFD1402F92300F80000F5212BFF1B13FF0801F60105F8
          0504FE0006F90701F20808FF0009EB0D08FD0204FC0D05F20C04FB0004FF000A
          FA0101F50B02F90605F50A05FF0C00FD0305ED1408FF0400F30713E30C00FE0B
          0BF3000AF60806FF2710FE3D46FB3C51E80701F40907F3000FEA2F27FE0A13F6
          1001FC0C07FC0004F6060DFC0002F70000FB0407F60209F80003FE090AF43638
          FB3E49F7292DF71611F6070BF30007F80B0CF0000FF70004F80D0AF30604F808
          08FC0901FF0109F01707F50904F30404F80A08FB0709FB0000F10108F21311ED
          0608F60608F60101FF0101FF0C00FE0206FF0000FA0505FF0C04FF271CFE9CA2
          FFF8FFFFFDFFFFFFFDFFFFFBFFFFF9FFFFFAFFFFFEFFFFFFFAFFFFF9FBFDFEFF
          FFF8FFFEFCFBF7FDFFFAFFF8F9F7FFFDFFFFFBFFFFFFF8FFFBFFFFF8F8FFFFF0
          EFFBFF98A1FF3F46FF0007F00006FF0000F80708FF0908F20501FF0004F30102
          FE0800FF0505F90000FD0002F76B5EFFBDBAF2F6FFFEFBFFF8FEFDFFF4FFFCFD
          FFF1FBFEFCF1FFFFABB4F44E3FF51005FC0000FC0108F10000F40005FB1106FF
          675CFEE3F0F8FDFFFEFFFEFFF2F5FF929BFF2A1DFFC2DFF4F6FFFFB19CFF5243
          F90900FB1700FDE9FFFDFFFEFFFFFDFEFAFFFEFAFFFFFAFFF8FBFFF94B3FFF81
          7FF7ECFFFBF8FFFEFFF9FFFFFAFFFFFFF1FFFFFEF3FFFF0A02F60B03FC0003FC
          0006F48681FFE2E8F5F8FFF5F4F2F87460F90802FB000BFD0000FA6B67F6E6EE
          FBFDFFFCFFFFFBDBEDFEA4A6FF231AF3CDD9FBF4EEFFABA4FF343CF40003FA19
          07F4F3FFFFFBFFF0FBFFFEF7FEF9F1F8FFF8FFFEEFFFF84E3AFE4F4BF1E5F9FF
          FDFFF9FBFBFFFCFDFFFFFEFBFFFEFFE6FCF71702FF0001FE0000FE1408FC5654
          F4C2CAFFF8FEFFFDFBFFFFFDFFF3FBFF979FFC332DF0D8CCFEFFFFF79B9EFF50
          48F31600F60B06FC000AF30201FB140CF3413BFEA9B0F9F1FDFFFDFBFFFEF9FF
          FFFFF9EFF4F3B1B0F0593CFF0803F80000FD1511F3B1BBFBF4FFFFFCFAF2FFFF
          F4FBFDFFFDFAFFE7FFF77D8BF51504F50707EF0614F60606FF0902F30608F606
          08F60101FF0101FF1004F60004F40005FF1D16FB888BF7EAFFFFF3FBFFFFFFF7
          FFFFF8FEFFF7FFFFF9FFFFFBFFFFFEFCFFFDF9FFFBF6FFF7F6FDFFFBFFF9FFFD
          FCFBFEFFFAFEFFF7FDFFFDFFFCFCFFFDF8FAFFFDFFFCFFFEF9FFFDFFFFFDFFFD
          FFFFF1F5FFB8B5F31E19F00203F70003F70403FB0404F2000AF80000FB0802FF
          0400FF0003FB0204FFB1B9FCFFFFF5FFFFFBFAFCFFBEBBFF7274FE5539FE8E7B
          FFDADBFDFFFEFFFFFFFF898BFF030AF90300FC0606FF0400FF3221F4EDFBFFFF
          FFFBFBFFFEEEFFFBF3FDFDF3FEFBECF6FFFAF8FFF9F9FFFFFCFEF3FFFFD6E4FF
          3940FB2E26F56F70FFF3FFFEFDF9FFFFFFFE9FA0FA3A32F40000FD0B00F94038
          F7ACB3FFF9FFF7FAFFFFF8FCFD806FFF1411FF0300FE0202FF0602FBA0A4F3F8
          F7FFF3FDFFFFFCFFFBFFF2EDF3FF898FF80A00F34E44FFF4FCF5FFFEF9FFF8FF
          F4FDFFF2FFFFFDFCFEF6FFFFFFFFEEFBFFFFFBFCFAF8FAFFC5D2FE5044FF2F2B
          EF5E6CFFEFFEFFFFFEFFFFF8FFB7AEFF3B32F40B05FE0404FF3B35F8A6A3F8F6
          FFFBFAFCFFFBFFFE877BFD2823FB0008FB0003F40E08FF95A0F0FEFFFBFFFFF5
          FFFFF9FBFFFFFBFFF6FBFFFEFDFCFFE3E8FDFFFFF9FDFDFFF3FFFBE8FEFFC8CC
          FF4747ED0006F70E0CF26862EFF8FFFCFFFDFCFFF7FFFCFBF1FAFFF7F8FBFFF7
          F8FFFAFBFFF7FDFFBAC8FF2020F60000FD1A19F8524CF9ECF5FFFFFFF4FFF7FD
          D5DCFF5549F50E07EC0907F30604FF0000FC050BF80C07F20608F60608F60101
          FF0101FF0002F90001FD3535FFBAC2FFFBFFFCFEFEF0FFFBFFFFFDFFFFF8FFFF
          FDFFFFFFF8FFFEF6FFFCFFFFF9FFFFFBFFFEFEFEFFFBFFFFF9FFFFFFF4FFFBFC
          FCFCFCFFFFF9FCFDF9FFFFF9FBFCFFFDFEFFFEFFFBFFFFF7FFFFFCFFF7FFFFFB
          FFFFFFFEDAE5FF4235FF0003F50000FA0806FF0003F70008F40002FF0208EF00
          04FF0003EBBFC2FFFFFFFBCBE6FF4444F60208F50000FC0001F90004FF0E04F8
          969DF4FAFDFFF1FAFF8681FC0701FF0001F90907ED8583FFFFFFFBFFFFFBD9EB
          FC3B37FB0502F83929F9AAABFCFFFDFAFFFFF8FBFFF97E7CFF5C64F75466F905
          05FF0000EDF1FFFFFFFFF9F5F5FB4042FB0207FF0008FA0106FD0000FA4448F4
          FBFEFFF6FFF9F4FFFC0A02F70002F60D0DFB0000F9363AF7F2FBFFFFFFFFF5FD
          F3BFB4F23447F67573FFAEB6FF6662FE8584FCF5FFFEFBFFFFE0ECFF3C35F012
          06F2382DFFA3AFFFFFFFFCFFFBFFFBFFF78184F76960F75263F90704FA0D07EE
          FEFCFFFFF4FFFFFFFB3F43F50602FF0204FF0005F50305F75346F6F8FCFFFCFD
          F4F6FFF90802F50010FD0009F40D09EA858AF7F8FDFEFFFCFFFFFAFBF5EDF85D
          51FD070CF50000FB4C45FABBC5FFFFFDFEF7FEFBFDFFFE9E9FFA8476F36168FF
          0606FF483DFDF0FFFDFFFDFEFFFFF2E1F1FF626AFA1515F10906EF1003F94B46
          FF8FA5F3F9FFFA4C47F00505FD0006FE0E0BFAB3C4FDFAFBFFF8FEFF7686F114
          10F20204FD0308F10306F1020BEE050CF60D09FC0608F60608F60101FF0101FF
          0004FF2116FFCCD9F9FFFFFBFFF9FFFFFFF1FFFFFEFCFAFFFAFEFFFAFCFFFDFE
          FFFFFFFEFFFFF9FBFAF6FFFAFFFFF8FFFFFFF1FBFFFFE5EEFFFFFFF8FFFFFCFC
          FDF3FAFFF7FFF7FFFDFFF9FDFCFEFFFBFFFFFDFFFFFFF9FFFFF8FBFFFEF6F9FF
          FFFFF6D9EEFD3934FF0503FF0000FD0001FE000AF20000FB0002F90206FF0400
          FFC5C2FAFDFCFF4D42FD1300FF0303FF0400FF0701FA0307F20205FA1603FFB1
          BCFFF8FFF7FCFEFE1E1AFF0008F90001F38087F4FFFBFFFFF8F8988BFF0500FB
          0A07F70002FF0101FFFAFFFFFFFEFFF6FDFF1F15FB0500FD0C00FF0305F31108
          F9FFF6FFFFFEFFF3FFFB3F53EE0300F80200F40A02FF0301FE434AF5FFFFFBFF
          FBFFF6F5FF0309F60702F8000AF60B03FF9279FFFDFFFBFFFBFFFCF1FF1D14F1
          0204FD0A02FB0A04FD0B05F68083FDFAFFFFEEFDEF8486FF0003FF000AF6000C
          EF3A40FFFBFFF7FFFEFCF6FEF70401FE040AFD0000FD0A02FF1109F6F7FFFAFD
          FFFBF8FCF74A49FF070CF50200EF0D0FFD0201F74D3CFDFFFAFFFFFFF9FCFBF7
          1707F80800F80000FC1F1BF0E0ECFFFFFFF7FDFCFFEFF1FC3134FF0805FF0101
          ED0608F60B05F4281AFFF1F6F7FAFFF4FCF9FF3020FF1108E50203F30A0CF4BB
          C1FCFBFEFFFFFAFDF0FBFF4131F00705F8000CFA0001FC020DF90205F30E0CEE
          3227F91625F0040CFF0007F01409F3BBBFFFFFFFF9F7FBFF7B85FF0900F70202
          FF0A07F60F01FF0B09FD0105F80209F30608F60608F60101FF0101FF0005F198
          A1F8FFFFFBFFFAFFFEFFF8FEFCFBFFFFFEFBFFFBF7FFF6FAFFFBF9FEFDFBFEFF
          FBFFFFFBFFFEFAFFFCF5FFF8F9FEFCB6BFFF5D5AFDF6FFFFF8F8FEFDFFFFF3FF
          F7FFF8FFFFFCF7FFFFFEFBFEFFF2FAFFF8FFFFFAFFFBFEFBF7FFFCFFFFFDFFFD
          FFF1BBC9FD1102F70003FE0002FF0001FF0101FF0000FE0400FC0604FEB6B8FF
          A8A7FD0005FA0100FD0002F50007FB0100FC0306F50000FC0906F56965F4F2FF
          FDFFF7FF7772F50F04F40006F95D64FFEEF9FFFFFDFF9D9DFF0702F80001FE00
          04FF0B05F8FFFCFEFFFEF7F4FFFA0B0CF00000F80E03FF0108F90002F1FDFFFC
          FFFEF7FFFEFE3939FF0006FF0503FF0A06F9030AF3383EFBFFFFFBF7F9FAFFF9
          FF0000FD0207FF0008E5070CF58084FBFFFFF8FDFCFF9AABFF0007FB0901F604
          02FF0008F80000F76959FEFFFBFFFDFFF79BA0FD0E02FF0200FB0005FF3C46F1
          FFFFFFFFF7FEFBFBFF050AF30D03F01109FF0303F10701FAFAFEFFFFFEFFFFFF
          FE343EFD0107FA0908FE0208EF0606FA483CFFF1FFFFFFFCF7FFFEFF0004FC00
          07FD0009F75154FFF5FBFFFFFFF9ECFFFF817AFF0000FD000AF0040EF50005FE
          0004F50501FAF3FFFFF8FCFFFFFCFF0302FA050CF50004FF2423FDF8FBFFFFFF
          F8FAFFFF9CA2FF180FF20004F70311E50704FA0403FD030CF00504FA1406F208
          0DF2000AE8050EF10C06F5B7BEFDFFF8FFFFFFF26D88FF0005F8000BF7000DE9
          0806F90709F70105F7040AF10608F60608F60101FF0101FF1401FCEDFDFFFFFC
          FFFDF9FFF6FFFAFFFDFFFFF9FFF6FFFCFFFAFFFFFCFFFFF9FFFFFEFFFFFFFCFF
          FFFAFDFEFAFDFFFEFAFFF96663FC0C00FCF6FCFFFFFBFFFFFFF7F2FBFEFFFFF8
          FBFFFEFDFCFFFFF8FFFFFCFFFFFDFFFFFEFFFFFEFFF7FBFCFCF6FFFFFFF5F8F9
          FF4C43F70004F70006F80403FD0500FE0408FA0500FC0104F9B6C2FF6562FB00
          01F90709FF0D03F70601F70702FF0005F30005FF0600FD6F66F3F8FAFFFFFFF6
          A19AFF0E05F6000AF90200FDA69CFFFFFFF8F8FFF09BA0FF1F22FF0300F80809
          FBF7FFFEF6F7FFFBFDFF0900FD0006FF0007F50002F10501FFFBFFFFFFFFFFFF
          FDF84749FB0002FB0004FF0400EF0601FC3E40FFFFFFF4FAFFFFFFFCFB060AF3
          0C00FD0207FF0300FA7A83FFFBFFF9FFFFFC8588FB0C00FA0805FB0607F70007
          F00007FB1005FB9F9BFFFCFDFFFFFDFF8696F72929F10105F84947F7FFFDFFFB
          FFFEF1FDFF0706F00008F50003FF030CF00004FBF3FFFFF6FCF7FFFFF44F3CFF
          0006F30303FF0005F20A0BF54742FCE2FFFDFBFFFEFFFBFF1004F80001FD0C07
          F28882F9FDFFFBFFFAFAF1FFFB3021FE0F09FC0104EF0806FA020AF10602FF0E
          08EFFDFFF9FFF7FFFFFFF70508F30A04FD060AF3434DF1FFFCFFFFFFFAFBFDFD
          5452FF0101F5000EFB0103F51103FF0904F30608F60907FA0006F90106FF0302
          F80806F90D03FDB6C9F4FCFDFFF6FFFF8B82F02006FE0A04FD0707ED0F07FC08
          0AF20206F8040AF70608F60608F60101FF0101FF0003F4F4FBFFFFFDFBFDFAFF
          FFFFF4FFF7FFFFFFF8FBFCFFFFFFFCFCF9F5FFFFF7FBFFFAF8FFF7F4FAF9FFFE
          FFFFFBFFBBBBFB0003FF0204FCFDFFFFFCFCFFFFFDFFF8FFF6FBFEFFF9FFF3FB
          FFFFFDFCFFFEFEFEFEFFF7FFFFF9FFFFFFFDFEFFFAFFFFFEFFFBF8FFFE8585F7
          0D01FF0001FD0001FE0104F90501FF0002F90003FE0000F70905FF0200F80301
          FF0000FD0605FF0001F7000EF00100FD1C08EFB4C0FFF0FFF5FFF9FFBEC0FF02
          06F10003F70904F90009F63448F9BEBDFFFFFBFFFFFEFAAEADFF5252FFFBFBFF
          EAFFF5FFFFFF0303EF0503FF0902FD0200FD0009F7FFFDFFFFF8FFFFFFF73842
          F40706FE0600FA1405F30501FF3E42F4FFFFF7FFFFFCFBF7FF0307FF0202FF00
          01FE0303F77F84FFF8FFF7F7FCFB8282FE0606FA0005FC0000FE0909F50001F3
          0D01FF0007F35354FCCAC4FBFFFEFFFFFAFDADB4F98781FEFFFFF8FBF9FFFAFA
          FF0009F30204F6000CF50D04FB0008FAFFFFFAFAFFFBF8FDFF503EFD0103F506
          07FF000BF30202FA4E45FAF4FFFCFFFFFBFAFCFF0003FE1208F50707FB837DFA
          FFFFFBFEF9FFF8FFFB0E00FF0307F90204FC0907F30402FF030CEF0600F9F6FF
          FFFFFDFFF7FFFB0B09FD0F00FC1907FF4345F7F1FBFFFBFFFCFDFFF81917F90B
          03FF0005F4000CF2000EF10404FF0601F70B06F5000CF20008FC070DF41101F9
          0B03FFB7C0FFFCFFFAFFFFF77E87FC0503F70D0AF40207F0000AF61209F30F0B
          F40602FB0608F60608F60101FF0101FF0901F8EFFBFFFFFFF5FAFBFFF4FFFBFD
          FFFCFFFFFBFDFEFFF2F5FFFFFFFCFFFAFFFBFEFFF9FCFFFFFEFFF9FFF0DFE9FF
          2918F10703FF231CFFF3FFFFFFFBFAFFFAFFFFFFFEFAFEF9FFFBFFFEFAFFFEFA
          FFFFF9FFFFFDFFFFFFF9FFFFF7FFFEFFFFFCFFFFFAFFF6FDFF635FFE0708F201
          01FF0100FC0308FF0301FF0200FE0406FE0402FF0003EE0405FF0003F60005FD
          0300F81106FF0400FB1719F490A0FFF6FFFFFFFFF2FFF7FF777FFF0201F9020D
          FE0200F91305FF0400F90A04F72223F59795EED4E3FFF2F8FFFFFFF5FFF9FFFF
          FAFF1104EE0003F90004F80202FF0006F7FFFFF5FBFBFFFDFCFE3845FB0000FE
          0104FF000AF30000F93C43FFF6FFFFFFFAFFC6C8FE0001F50006F2020FFF0601
          F6857AFFFFFFFCFFFDFF8082FE0007F70308F70800FA0908F20003FF0702FD06
          02FF0200FE0000F8251AFA9A94FFDBF8FCEDFCFEFFFFF5FCFFFAF6FDFF020BEE
          0B00FF0009F70400FD0004FDFFFFF5FFFCF9F6FFFF4244FC0409FF0000F70001
          FE0604FF4C46F7EFFBFFFFFDFFFFFFF70004FF0C05F00005F18388FFFFFFFBFF
          FBFFE6ECF9050CF5080BEF020BEF0400FF0105F70407F2120BF6FBFFF8FFFDFE
          FFFFFE0003F20B08FE0700FC454DEEF8FFFFFDFCFFFEFFFD7F85F6887CFF8A85
          FE7779FD8488F9897FF78C8EF27683FD8282FE6A62FC0F00EF0B04F90209F8B7
          BAFFFDFFF2F3FFFF8585F70606FA040AF70A04FF1106F60C00F20009FA0011EC
          0608F60608F60101FF0101FF0A00FFA9B4FEFFFEFEFFFDF9F4FFF7F8FFF5FBFD
          FEF8FFF9F4FFFEFBFAF6FFFEFFF8FBFFFFFFFFFFF7FFF0FFF74D43FF0000FD04
          00FD7A77F5F4FFFCFFFFF4FFFCFDFFFEFFFAFDFFFFFAFFFFFEFFFFFFFCFDFFFC
          FDFFFFFDFFFFFEFEFEFCFDFBFFFCFFFFFDFFEDFFFF2C23FF0000F80904F90A00
          FF0004F50305F70607F70300FD0000F60001FF010AFB0000F90000FE0C09F21A
          12F38583FFF1F2FFFFFEF9F7F9FFF9FCFFFFFFF7281FFC0D02F80004FF0301FF
          8D8EF69EA8F52626FF0000FC0006FF0303FF5B50F4FEF9FAFFFDFFF1F6FF0D05
          F90004F80004F50807FD0000F8FDFFFFF8FFF8FFFAFF4548F70007F80602FB01
          01FF0E0CF8403FF9F7FAFFFFFDFBBBC1FF0008F41409F30000FA0406F88387FD
          FFFEFEFFFCFF8784F20207F60203F70404F00008F1010BFF0507E89F9CF8A2A8
          FB2326FA0006FF0604F80301FB7074F8FFFFF8FFFDFEFAFFF80600F91003FF00
          08F10503FD0001FDFFFFF9FFFFFCF3FFFC3C3EFF0B03F00F07FB0303F70A04FF
          4A40F8F3FEFFFFF7F8FFFFFB0104F90B04F5000BF24440FDF8FCFDFFFEF6FAFD
          FF0008EC0103FF0008F90405FF0010EB0005FF0000FAF7FFF6FFFDFFFFFCFF01
          07F4000BF70408FB2B2AEEF2FCF6FFF9FFFFFDFCF2FFF5F5F8FCFFFFF9FFFCFF
          FDFAFFFEF9FFFFFFF7F9FFFAFFF5FFB5BFFF020CF30108F7000AF2B2C0FFFEFF
          F1FFF7FF7F7EFC0008FF020EE80A01F80809FE010AFB0008F90104F20608F606
          08F60101FF0101FF0007F8221DFADEEAFFFFFDFFFFFEFFFFFAFFFFFDF9F4FFF9
          F9FFF5FFFCFFFFFFF8FFFFFEFFFDFEFAFFF87674FC0100FD0003FB1912FDE4EA
          FFFEFFF8FFFFFBCDD5F3DFD5FFF6FDFFFDFFF4FBFFF6F7FBFCFAFBFFFAFCFFFB
          FFFFFCFEFEFFFCFFFFFFF5F8FFFF838BF60907FB0001FE0706FC0505F30206FF
          0402FF0407F50000FB0004FF0009F20000F51002FA271AEA8583FBDAEBFEF8FF
          FFFAF8F7FFFDFFFFFFF9F2FEFE978EFF0D02FF0A02F90004F70604FEE7F2FAFF
          FFFE93A0FC0E04FF0306F50000FC3738FEFFFDFFF9F9F9FBFFEE0303FF0006F8
          0807F10005FF0003F7FCF9FFFFFFF7FFFFFF3C42F90701FF0000FC0D0BFE0000
          EC767AFEFFFFFCFFFEFEBEBCFE000BF70100FD020CFA060AEB7A7FFFEFFBFFEF
          FBFF8285FF0800FF0807F10905FE0001FD0001FE0A03FEFDFFFFFEF9FA9596F8
          1100FE0B08F20005FB423FFFF9FAFFFFFAFFF6FFF90903FF070AE8000BF70A04
          F70905FFF4FBFFF2FBFEF8FFFB5346FC0C06F50703FF0006F60000FD5553ECF8
          FFFEFFFFF9FBFFFE0506FA0D01FF0007F40F10EED6DEFFFFFDFFFFFAFF4547F3
          0507FF0004EB0F06FD0608FA010CF80201F7FBFFFFFFFCFAFFF7FF020BF50005
          F30009EF110BFCC1C1FFF9FDFEFFFFF98787F94D4CF0413AF9544AFA4444EA44
          48FA8789F9FFFEFFFDFFF08A91FE0003FA070AF80906ECCCC4FFFFF8FBF8FFFF
          A4A3FF0005FE0004F50B0AFA0006ED0404FC0E10F10C06F30608F60608F60101
          FF0101FF0003FE0005F54134FFE3EAFDFFFEFFFFF8FFFFFEFCF7F9FFFFFCFFFD
          FCFFFBFCFFFFFAFFFDFFF0A4AEFF0B00FF0009F00700FE8993F8FFFCFFFFFFFC
          FFF5FF8085FF6B64EFFAFFFCFDFEFCFEF9FFFFFAFFFFFFFCFFFFF7FFFCFEFFFC
          FFFFFEFAFAFCFF9397FF120EF70001FD0004FB0002F80000FB0100FC0000FC00
          00FD0005FF0001FE0301FF2711FF8379FFE0F5F6FFFFF5FFF6FFF7F8FFFFFFF7
          FFFEFBF7FAFF9096F90700FE0002F30001FE0006F80B00FFD7E2FEFFFFFB9C9E
          FD0200FE0002FF0900F76664FAF5F7FFF4FFFFF3F7FC0702F10001FD0007F41A
          12F93E30FFFAFFF9F8FAFFFFFCFF96A6FF1202F30004FF0202F60E0BFAADBDFF
          F7F6FFFFFEFFBBC1FF0800FF0608FF0000FB0304F48283FBFFFFF7FFFFF57B88
          F20002FF0B03FF0000F7010AFF0A08F40706F6DEF1FEF4FFF49A8AFF000AF600
          06F0010CF66965FFF8FDFBFFFFFED0E0FF020AF10C01FF0004F92A24F73A32F5
          FFFFF9FFF9FFFFFDF99AA3FA1716EE050DF40007F20D0AFFA9AEFFFFFEF3FFFF
          F3CECCFF0301FB0A00FA0002FD0207F66262F6F5FFFFFFFFF2C0BAFF0A03F805
          03FF0606FE0008EF0000F71615F9EFF9F9FAFFFFFFFDFF060CF90003F80D10FF
          0000ED4736F9E8F7FFFFFFF9B5C1F71608FA0004FF0004F80006F90F0DF3AABB
          FAFFFDFFFAFAFF504AEB0101FF1B12FF2519F5E2DCFFFFFDFFFAFAFFFEFDF96A
          67FF0E08F50703EF2F14F3E3FDFF1405FA0307F90608F60608F60101FF0101FF
          0000F90005FF0100FC2D18FFA5AAFFF4FFFBFCFFE8FFFAFFFFFDF6FBFEFFFDFF
          FBFFFFFFCFDCFC1D15FC0000F70903FF6462FCF8FEFFFBF7FFF8FFF4F9FCFF44
          43FF191BFCFFFFF8FFFBFFFFFCFEFFFFF7FFFFF4FFFFF8FFFDFFFBFEFFF4FFFC
          8A83FF1106F60001FE0000FA0001FD0005FF0005FF0404F80503FF000CF50003
          FF0301FF3530EFBDCDFCF5FFFFFFFBFFFFFCF7FAFDFFFBF9FFFCFFF4DDE3FF47
          41F40606FA0000FA060AF50000FD010DF50903F65A4EFFEFFAFEF6FFF87776F4
          0705F91D15FCD7E2F6F8FFFFFAF9FF999DFF0E04F80804FD150DFFE3FFFFF4FF
          F7FFFFF8F7F1FFFFFFF1F4FDFFD6E1FD918EFF8583FEC2BBFFF6FFF5FAFFFFFF
          FDFC6976F80E03F90400F70A0BFF0F07FE7F79FFFAFFF8FBFFFE7D7CFC0501FF
          0701FA0A05FF0304F60600FD0D07FA6B5FF3FDFAFFFFFEF84D55FC1500FD3020
          FFCDDAF4FFFFF9FFFDFE8184F70002FE0005F40E06FFE2F6FBF1FEFFFFFFF9FA
          FDFFFFFCFEF6FFFFD5DAFF9691FA8683FFB2B6FFFFFFF4FFFDFAFBFFFC7F78FF
          090BF30804F70206F80000FE140DF8969EFFF2FEFFFAFFEC9E9FFF2411FF0802
          EB120BEE4734FFAFC5F9FFFCFFF3FFFFFBFEF50000FA100AFF0600F40008F411
          02FD6A6FF3ECF3FFF8FFFF9A9BFF1717ED090DFF2115F7A39FFEFAFCFFFFFFFC
          939DFF0A0AF80002EABBC4FFECFDFFF6FFF0FAFFFBFBFFF6FFFEFFFFFBFFA1A0
          F08890EDEFDAFFF8FFF30302F2030FEF0608F60608F60101FF0101FF0204FF06
          00FF0001F50003FF0400FB4136FFB9C7FFEAFDFAF8FCFFFAFCFFFFFFF2F3FCFF
          4B40FF0000F80707FB402CFFE5F4FDFFFFFBFFFEFFFDFFF5B5C0FF0000F61716
          F8FFFFFFFEFCFCFFFFFCFFFAFFFDF4FFFAFFF5EAFFF99CA7FF3826FB0E03F300
          02FF0005FF0301FF0504FC0004FF0000F70602FB0104F90008EE0001FF2313FA
          CFDEFFFDFFF0FFFFFEFBFAFCF3FFFFF8FEFFD8E3FF5961FB0303FF0000F90902
          FD0901FF0500F90203F70304F40707FB0402F6472CFFCDD0FDF3FFFBF4FFFCE1
          FFFFFFFEFFFBFFFBCFD7EE1C14F50003FA0A00FA1A02FA2B1CF49497FFFBF3F4
          FFFFF7EFFFFF8272FBDFDEF8F8FFF5F4FFF6FFFFF9FFF9FFEDFFFCCBD1FA060C
          ED0301FB666AF9DDFAFEF9FBFCFFF2FFFFFFF7FDFFF3FDFCFFFDFEFFF9FAFFFA
          FFF8D0E7F71307FB0000FB0006FF3E42F9C5E6FAFFFDFFFFFFF9F6FFFFFFFFF9
          F0FAFAD2D7FE2117F30001FF0F07FC0205FA2724F07C85FFDDEAF8FBFCFAFDFF
          FF6D71F8D3CDFFFAFCFFFFFFFBFFFFFEFFF9FAFDFCFFB9CFF91D1BF70806EC08
          06FF0612EE0002F70605FD0D00F77E83FFEAFFFFFDFFF7EFFFFBC0C3FFD7E5FF
          F4FBFFF2FEFFFFFBFEFFF6FFFFFFF90000FE0706F60E04F80309FF0405EF0704
          EE5A61E6E9EEFDF9FBFFF4FFFCBDBDF9F3FDFFFFFDFCFDFDFF9B8CF50A06F206
          0DF0080CF72316EE5763FFD1D8FFF7FFF4FDFEFF9597F6CCD2F7F6F9FFF5FCFF
          FFFDF3E8FDFF0306FB0B04F90608F60608F60101FF0101FF0002FE0E00F20F04
          FF0000F6000BFF0004FF0500F3462EFFA8A0FFECF2F1FFFCFFA09AFF0A00FF00
          08FF190FFCCBDFFFFFFFF9FAFDFFFFFAFFFBF2F51513F50000FE5952FFF4FCFC
          F4FFFEF7FFFDF7FFFEE1E5FF9188FD3221FA0200FD0005FB0005F70002FF0000
          FE0302FC090EF30000FA0707FB0602FB0000FE0002FF0803F97E7EFFFDF9FFFF
          FFF3FFF9FFF6FFFED1CEFC5042F40A05F40103FB0300FC0904FF0000F90008F6
          0002FF0802FF0E07F80000FA0009FE0006FF0704F35452FFB89CFFBFBEFFAAB3
          FC706EFF190DFF1003FF0001FB0407FC0004FE0008FF0000FC0A02F65A60FFA5
          B1FF3828FF0608FA6865FE9FA3FBBCC1FEB9ABFD6662FE1A00FF0004FC0006FF
          0F00FF3730EBB4BAFFFAFFFBFFFAF7FFF8FFBDC6F27C83F87B85FB8C86F1887C
          FF100EFF0A0CF40000FB040AF11402FF5C61FEA1A0FFBDBEF8BFABFF5E6CF40A
          00FE0005F80806FA0800FF0007F30004F90007FB0700FB5C55FFA9B5EB3F30FF
          0700FB5C5EECA19EF3BCBBFDB3B4FF7672F91B13FA0007F70D01FF0005F90009
          F10402FF040BEE040EF50807F1371DFD7F77ECBABDFFC2BBFFBEC4F98C8FF773
          7DF3FFFEFFFBFFFBFFFCFF0209F80409F20C01F80508FD0303EF020CFF0700FE
          1015F36A62FFBEABFFD1C4F0C1C4FB7C81FF2325F5060AF51006FA0004F50008
          F81402F90006F00B04F93F39F2A29FFF5F5EFF191DEE8681FFC9C1FDC4C2FD81
          84F70E08F90C09F20608F60608F60101FF0101FF0102FE0102FE0102FE0102FE
          0102FE0102FE0102FE0102FE0000FC0905FE2329FF3134FB0004FF0000FCBCB8
          F9FFF7FFFDFCFFFFFEFDE9EBFF3739F60002FB0A01FC98A0FEFFFEFDFFFCFF77
          7FFF1619FF0B02FD0101F50005F90104F90200FE0102FE0102FE0102FE0102FE
          0102FE0102FE0102FE0102FE0006FC0000FC0E01F1ACC5FFF0FCFFFFFBFFFFFC
          FFA9A2F30305F30901F80501FA0005FE0000FE0504EE0A06F90104F90302FC03
          02FC0302FC0403FD0403FD0403FD0403FD0302FC0302FC0302FC0302FC0302FC
          0302FC0302FC0302FC0302FC0303FB0303FB0303FB0303FB0303FB0303FB0303
          FB0303FB0303FB0303FB0303FB0303FB0303FB0404FC0404FC0404FC0005FC01
          09FC0500FC8793FFFAFFFEFFFEFD8682FF0002FF0304F90304F90304F90304F9
          0304F90304F90304F90304F90304F90304F90405FA0405FA0405F90405F90405
          F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F904
          05F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F9
          0406F80406F80406F80406F80306F4000BFD000EEA0505F10006F7493EFEFFFA
          FFF6FFF5FFFFFE0405FA0806F90506F60406F80406F80B05F80206F80508F705
          08F70508F70508F70508F70508F70508F70508F70607F70607F70607F70607F7
          0607F70607F70607F70607F70506F60506F60506F60506F60607F70607F70607
          F70607F70608F60608F60101FF0101FF0102FE0102FE0102FE0102FE0102FE01
          02FE0102FE0102FE0709FB0000F30C07FF0901F60407F63E40F8EFF6FFFFFAFF
          FFFDFEF8FFF66C67FE0000FC0C01FF2932F8F3FEFFFFFEFFFFFFF74242F20306
          FB0600F90503FF0005F90100FD0301FE0102FE0102FE0102FE0102FE0102FE01
          02FE0102FE0102FE0400FD000AF80802FFB1BAFFFFFFF0FFFFF9A3A7FF0E0AFD
          0005FF0007FB0002FF0000FC0004FC0007FF3734FCB6BBFF0302FC0302FC0302
          FC0403FD0403FD0403FD0403FD0302FC0302FC0302FC0302FC0302FC0302FC03
          02FC0302FC0302FC0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB
          0303FB0303FB0303FB0303FB0303FB0404FC0404FC0404FC0003FF0303F10E08
          FB150BF8939DEAF6FFFF8582F50109F60304F90304F90304F90304F90304F903
          04F90304F90304F90304F90304F90405FA0405FA0405F90405F90405F90405F9
          0405F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405
          F90405F90405F90405F90405F90405F90405F90405F90405F90405F90406F804
          06F80406F80406F80607F70001FA0203F80902FD000AF64B44FFFFFBFFF8FEF9
          FFFFFE0405FA0806F90506F60406F80406F80B05F80206F80508F70508F70508
          F70508F70508F70508F70508F70508F70607F70607F70607F70607F70607F706
          07F70607F70607F70506F60506F60506F60506F60607F70607F70607F70607F7
          0608F60608F60101FF0101FF0102FE0102FE0102FE0102FE0102FE0102FE0102
          FE0102FE0100FC0005F90503FD0600FF0700FBB9C8FFFBFFFBFCFCF6FFFFFA83
          85FF0100FD0A00FD0E11F5C6D0FFFAFFFFFFFDFAEFFFFF160FF20000FD0401F7
          0404FF0004F80300FE0504FE0102FE0102FE0102FE0102FE0102FE0102FE0102
          FE0102FE0E00FF0003FF0500FCB8C3FDFFFFF7F4FFFC5555FF0000F50000FB07
          05F80907ED0604FE0005FF0001F97B81F2FFFFF80302FC0302FC0302FC0403FD
          0403FD0403FD0403FD0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302
          FC0302FC0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB03
          03FB0303FB0303FB0303FB0404FC0404FC0404FC0307FA0F00FC0A00FF0000F7
          120AF7BDCFFF8183F90705F80304F90304F90304F90304F90304F90304F90304
          F90304F90304F90304F90405FA0405FA0405F90405F90405F90405F90405F904
          05F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F9
          0405F90405F90405F90405F90405F90405F90405F90405F90406F80406F80406
          F80406F80A08FB0A02FF0D05FF0A04FD000BEC4242F4FFFEFFFFFDFFFFFFFE04
          05FA0806F90506F60406F80406F80B05F80206F80508F70508F70508F70508F7
          0508F70508F70508F70508F70607F70607F70607F70607F70607F70607F70607
          F70607F70506F60506F60506F60506F60607F70607F70607F70607F70608F606
          08F60101FF0101FF0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE
          0400FD0008FF0003EE0000FE1100FCF8FFFCFBF6F7F8FFF7A9A9FF0703FF0000
          F40C06FF9CA6F4FAFFF7F9F9FFFFFFF8AEBDFF0700FE0006FF0202F60000FE00
          02F90600FF0205FA0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE
          0500FE0001FE0802FF9194EFFFFFFEFAFFFF5E5AFF000AF60609F70E00FD1204
          F60401FE0102F6260DF7F4F4FFFFFCFF0302FC0302FC0302FC0403FD0403FD04
          03FD0403FD0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC
          0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303
          FB0303FB0303FB0404FC0404FC0404FC0104F20D02FF0B09FC0002FE0007F840
          3EFF5051FF0901F80304F90304F90304F90304F90304F90304F90304F90304F9
          0304F90304F90405FA0405FA0405F90405F90405F90405F90405F90405F90405
          F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F904
          05F90405F90405F90405F90405F90405F90405F90406F80406F80406F80406F8
          0205F30A00FE0601F60409EE0010F14346FCFDFFFBFFF9FFFFFFFE0405FA0806
          F90506F60406F80406F80B05F80206F80508F70508F70508F70508F70508F705
          08F70508F70508F70607F70607F70607F70607F70607F70607F70607F70607F7
          0506F60506F60506F60506F60607F70607F70607F70607F70608F60608F60101
          FF0101FF0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0701FF00
          00FA0305FE010BFF403AFFFFFBFFFFFFFED2DCFF0F1AFE0500F90009FD5D60FE
          FFFDF4FDFCFFFBFFFFFFFEFE4A49F30000FD0003FF0103F50001FE0001FD0601
          FC0004F70102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0108F100
          04FF000AF82E1BFEEEE9FFFFFFF4CCCAFF1B0DFF0005FF0003FF0003FD0005FF
          2312F5C9D6F0FDF9FFFCFBFD0302FC0302FC0302FC0403FD0403FD0403FD0403
          FD0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0303FB03
          03FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB
          0303FB0404FC0404FC0404FC0002FA0811EE0000FA060EF50307FA0405FA0803
          FE0A07F60304F90304F90304F90304F90304F90304F90304F90304F90304F903
          04F90405FA0405FA0405F90405F90405F90405F90405F90405F90405F90405F9
          0405F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405
          F90405F90405F90405F90405F90405F90406F80406F80406F80406F8000AF20B
          03FF0407F50108F20004F8413DFFFAFFFEFDFFFFFFFFFE0405FA0806F90506F6
          0406F80406F80B05F80206F80508F70508F70508F70508F70508F70508F70508
          F70508F70607F70607F70607F70607F70607F70607F70607F70607F70506F605
          06F60506F60506F60607F70607F70607F70607F70608F60608F60101FF0101FF
          0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0508F70000FC0000
          FD0000FC322CFFFFFFF8FFFFFC615DFF0000FA0000FE3B37FAFBFEFFFFFEFFFF
          F4FFF2FFFA938CFF1002F40005FF0000FC0304F60005FC0101FF0803F80004FD
          0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0907FB0000F50002
          FE0002F55A52FFE1E7FAFEF9FFD6D4FF594EFF170CF62B21FF7171EDF0F1FFFF
          FFFEFBFBFFF7FFF80302FC0302FC0302FC0403FD0403FD0403FD0403FD0302FC
          0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0303FB0303FB0303
          FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB04
          04FC0404FC0404FC0609FE0005F10505FF0702F70600FF0005F30007FA0302FA
          0304F90304F90304F90304F90304F90304F90304F90304F90304F90304F90405
          FA0405FA0405F90405F90405F90405F90405F90405F90405F90405F90405F904
          05F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F9
          0405F90405F90405F90405F90406F80406F80406F80406F8000BEE0701FF0207
          FC0200FD0D0BF15249F3F8FBFFFAFFFBFFFFFE0405FA0806F90506F60406F804
          06F80B05F80206F80508F70508F70508F70508F70508F70508F70508F70508F7
          0607F70607F70607F70607F70607F70607F70607F70607F70506F60506F60506
          F60506F60607F70607F70607F70607F70608F60608F60101FF0101FF0102FE01
          02FE0102FE0102FE0102FE0102FE0102FE0102FE0002F70D05FF0001FA0004FF
          0F03FDE9F2FFF4FEF80B03FC0405FA0003F7DDDBFFFFFCFEFFFFFEFBFAFFBFCC
          F8170CFF0800FD0106FF0000FE0403F90004FD0200FE0803F90004FF0102FE01
          02FE0102FE0102FE0102FE0102FE0102FE0102FE0000FA0805FB0304FF0005F7
          0007FB2F2FF7ADB8FCF3FAFDFFFCFFF6FFFBF3FFF6FFFFFCFFFFF4F2FEF8D6DF
          FFA89EFF0302FC0302FC0302FC0403FD0403FD0403FD0403FD0302FC0302FC03
          02FC0302FC0302FC0302FC0302FC0302FC0302FC0303FB0303FB0303FB0303FB
          0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0404FC0404
          FC0404FC0000FC0307FA0809FE0100FA0803FF0408F30305FE0206F80304F903
          04F90304F90304F90304F90304F90304F90304F90304F90304F90405FA0405FA
          0405F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405
          F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F904
          05F90405F90405F90406F80406F80406F80406F8020BF50901F80005FA1812FF
          6C73FEAFB0FFFFFBFFF9FFFDFFFFFE0405FA0806F90506F60406F80406F80B05
          F80206F80508F70508F70508F70508F70508F70508F70508F70508F70607F706
          07F70607F70607F70607F70607F70607F70607F70506F60506F60506F60506F6
          0607F70607F70607F70607F70608F60608F60101FF0101FF0102FE0102FE0102
          FE0102FE0102FE0102FE0102FE0102FE0002FF0F00FF0002F70004FF0A03F89B
          8CFFF1FFF50003FF0303FF8E7DFFEFFFFCFFFEFFFFF8FBEFF0FF382FFB0005FC
          0705F90000F90602FF0602FB0001FE0301FF0801FC0001FE0102FE0102FE0102
          FE0102FE0102FE0102FE0102FE0102FE0005FF0004F80506F80C00F90900FE04
          04FF0001F12113FF4041FD7572FE7C70FE493EF93B3CFF0604F70204F60003FC
          0302FC0302FC0302FC0403FD0403FD0403FD0403FD0302FC0302FC0302FC0302
          FC0302FC0302FC0302FC0302FC0302FC0303FB0303FB0303FB0303FB0303FB03
          03FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0404FC0404FC0404FC
          0705FF0400F90403FB030FF10001FA0B03FF0300FA010BF30304F90304F90304
          F90304F90304F90304F90304F90304F90304F90304F90405FA0405FA0405F904
          05F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F9
          0405F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405
          F90405F90406F80406F80406F80406F80406F80E06F30107F42725FBB8D2F6F6
          FFF8FFFBFFFBFEFFFFFFFE0405FA0806F90506F60406F80406F80B05F80206F8
          0508F70508F70508F70508F70508F70508F70508F70508F70607F70607F70607
          F70607F70607F70607F70607F70607F70506F60506F60506F60506F60607F706
          07F70607F70607F70608F60608F60101FF0101FF0102FE0102FE0102FE0102FE
          0102FE0102FE0102FE0102FE0001FE0209F80000FE080EEF0200FB1917FD83AD
          FF0D05F90402FCE5E2F8FEFBFDFDFFFCF1F7FF606AFE0000FB0600FF0001FD00
          01FD0001FD0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE
          0102FE0102FE0102FE0102FE0103FC0103FC0103FC0103FC0103FC0302FC0302
          FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC03
          02FC0302FC0403FD0403FD0403FD0403FD0302FC0302FC0302FC0302FC0302FC
          0302FC0302FC0302FC0302FC0303FB0303FB0303FB0303FB0303FB0303FB0303
          FB0303FB0303FB0303FB0303FB0303FB0303FB0404FC0404FC0404FC0405FA04
          05FA0405FA0304F90304F90304F90304F90304F90304F90304F90304F90304F9
          0304F90304F90304F90304F90304F90304F90405FA0405FA0405F90405F90405
          F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F904
          05F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F9
          0406F80406F80406F80406F80405F90308F70208FB0402FF0F04FB4338F29DA2
          F7EDFFFFDAFBFF220EF50000FB0111EE0305F70606F20505FD0004FB0508F705
          08F70508F70508F70508F70508F70508F70508F70607F70607F70607F70607F7
          0607F70607F70607F70607F70506F60506F60506F60506F60607F70607F70607
          F70607F70608F60608F60101FF0101FF0102FE0102FE0102FE0102FE0102FE01
          02FE0102FE0102FE0206FF0008EF0000FC0000F90B07FF0000F60C0CF20300F9
          1D22F3F6FCFFFFFFFBF3FEFC928FFF0500EE0E0AFD0002F70001FD0001FD0001
          FD0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE01
          02FE0102FE0102FE0103FC0103FC0103FC0103FC0103FC0302FC0302FC0302FC
          0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302
          FC0403FD0403FD0403FD0403FD0302FC0302FC0302FC0302FC0302FC0302FC03
          02FC0302FC0302FC0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB
          0303FB0303FB0303FB0303FB0303FB0404FC0404FC0404FC0405FA0405FA0405
          FA0304F90304F90304F90304F90304F90304F90304F90304F90304F90304F903
          04F90304F90304F90304F90304F90405FA0405FA0405F90405F90405F90405F9
          0405F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405
          F90405F90405F90405F90405F90405F90405F90405F90405F90405F90406F804
          06F80406F80406F80906FC0306F4000AEE000BF40106FD0601FC1309F62015F5
          4F51EB0900F30609FE0009F30703FC0D08F70907FB0003F60508F70508F70508
          F70508F70508F70508F70508F70508F70607F70607F70607F70607F70607F706
          07F70607F70607F70506F60506F60506F60506F60607F70607F70607F70607F7
          0608F60608F60101FF0101FF0102FE0102FE0102FE0102FE0102FE0102FE0102
          FE0102FE0003F80000FB0505FF0404FF0301FF0806FF0000FC0604FF3F44FFF3
          FCFFFFFBFFD0E1FB170FFC0002FF0100F80006FD0001FD0001FD0001FD0102FE
          0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102
          FE0102FE0103FC0103FC0103FC0103FC0103FC0302FC0302FC0302FC0302FC03
          02FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0403FD
          0403FD0403FD0403FD0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302
          FC0302FC0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB03
          03FB0303FB0303FB0303FB0404FC0404FC0404FC0405FA0405FA0405FA0304F9
          0304F90304F90304F90304F90304F90304F90304F90304F90304F90304F90304
          F90304F90304F90304F90405FA0405FA0405F90405F90405F90405F90405F904
          05F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F9
          0405F90405F90405F90405F90405F90405F90405F90405F90406F80406F80406
          F80406F80805F40405F50105F70004F50005F30007F70007FB0006FF0900FD07
          05FF010AFB0004F70B06FC0C02F60A04F5080BF60508F70508F70508F70508F7
          0508F70508F70508F70508F70607F70607F70607F70607F70607F70607F70607
          F70607F70506F60506F60506F60506F60607F70607F70607F70607F70608F606
          08F60101FF0101FF0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE
          0301FF0202FF0000FC0105F80000F80003FC0009F30000FE4141FFFBFFFFFFF9
          FF6B67FC0000F80003F70703FF0100FC0001FD0001FD0001FD0102FE0102FE01
          02FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE
          0103FC0103FC0103FC0103FC0103FC0302FC0302FC0302FC0302FC0302FC0302
          FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0403FD0403FD04
          03FD0403FD0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC
          0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303
          FB0303FB0303FB0404FC0404FC0404FC0405FA0405FA0405FA0304F90304F903
          04F90304F90304F90304F90304F90304F90304F90304F90304F90304F90304F9
          0304F90304F90405FA0405FA0405F90405F90405F90405F90405F90405F90405
          F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F904
          05F90405F90405F90405F90405F90405F90405F90406F80406F80406F80406F8
          0403FB0604FE0806FF0707FB070BF4060AF20506F60201F90707FF040CF90000
          F70609F8100CF80900F90404F0020BEF0508F70508F70508F70508F70508F705
          08F70508F70508F70607F70607F70607F70607F70607F70607F70607F70607F7
          0506F60506F60506F60506F60607F70607F70607F70607F70608F60608F60101
          FF0101FF0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0301FF02
          05F40002FA0001F60004FD0105FE0004F20005FF2824F9FCFFF7F0EBFF1000F9
          0006FA0000FE0007F50900F90001FD0001FD0001FD0102FE0102FE0102FE0102
          FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0103FC01
          03FC0103FC0103FC0103FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC
          0302FC0302FC0302FC0302FC0302FC0302FC0302FC0403FD0403FD0403FD0403
          FD0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0303FB03
          03FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB
          0303FB0404FC0404FC0404FC0405FA0405FA0405FA0304F90304F90304F90304
          F90304F90304F90304F90304F90304F90304F90304F90304F90304F90304F903
          04F90405FA0405FA0405F90405F90405F90405F90405F90405F90405F90405F9
          0405F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405
          F90405F90405F90405F90405F90405F90406F80406F80406F80406F80306FB03
          05F70504F40805F50B05F80C04FD0C01FF0D02FF0209EC0308F10000FB0A0BF5
          0906F50802FF0209F20006F40508F70508F70508F70508F70508F70508F70508
          F70508F70607F70607F70607F70607F70607F70607F70607F70607F70506F605
          06F60506F60506F60607F70607F70607F70607F70608F60608F60101FF0101FF
          0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0100FD0301FE0506
          FF0000FE0101FF0000FE0103FF0000FD0701FABCBFF6C3CAFB0500FE0000FC07
          03FF0006FF0C00F90001FD0001FD0001FD0102FE0102FE0102FE0102FE0102FE
          0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0103FC0103FC0103
          FC0103FC0103FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC03
          02FC0302FC0302FC0302FC0302FC0302FC0403FD0403FD0403FD0403FD0302FC
          0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0303FB0303FB0303
          FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB04
          04FC0404FC0404FC0405FA0405FA0405FA0304F90304F90304F90304F90304F9
          0304F90304F90304F90304F90304F90304F90304F90304F90304F90304F90405
          FA0405FA0405F90405F90405F90405F90405F90405F90405F90405F90405F904
          05F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F9
          0405F90405F90405F90405F90406F80406F80406F80406F80508F3050AF3060A
          F50608FA0104F90002F40009ED0211EA0702FF0A08FC0907FB0506F00200FA06
          04FF000BEF0005FF0508F70508F70508F70508F70508F70508F70508F70508F7
          0607F70607F70607F70607F70607F70607F70607F70607F70506F60506F60506
          F60506F60607F70607F70607F70607F70608F60608F60101FF0101FF0102FE01
          02FE0102FE0102FE0102FE0102FE0102FE0102FE0001FD0606FF0000FA0203FF
          0606FF0000F90000F80705FF0002FF3B33F68E97FF0200FE0307FA0200FB0001
          FD0800FF0001FD0001FD0001FD0102FE0102FE0102FE0102FE0102FE0102FE01
          02FE0102FE0102FE0102FE0102FE0102FE0102FE0103FC0103FC0103FC0103FC
          0103FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302
          FC0302FC0302FC0302FC0302FC0403FD0403FD0403FD0403FD0302FC0302FC03
          02FC0302FC0302FC0302FC0302FC0302FC0302FC0303FB0303FB0303FB0303FB
          0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0404FC0404
          FC0404FC0405FA0405FA0405FA0304F90304F90304F90304F90304F90304F903
          04F90304F90304F90304F90304F90304F90304F90304F90304F90405FA0405FA
          0405F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405
          F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F904
          05F90405F90405F90406F80406F80406F80406F80804FD0505F90105F70007F8
          0008FB0008FB0007F80007F40501FF0404F80506F60405F50606FE0306F50208
          ED0802FF0508F70508F70508F70508F70508F70508F70508F70508F70607F706
          07F70607F70607F70607F70607F70607F70607F70506F60506F60506F60506F6
          0607F70607F70607F70607F70608F60608F60101FF0101FF0102FE0102FE0102
          FE0102FE0102FE0102FE0102FE0102FE0204FC0004F10000F90503FF0000FA08
          05FF0405F50200FC0004FC0001FF1200FA0302FC0000FD0505F10008F80000FE
          0001FD0001FD0001FD0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102
          FE0102FE0102FE0102FE0102FE0102FE0103FC0103FC0103FC0103FC0103FC03
          02FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC
          0302FC0302FC0302FC0403FD0403FD0403FD0403FD0302FC0302FC0302FC0302
          FC0302FC0302FC0302FC0302FC0302FC0303FB0303FB0303FB0303FB0303FB03
          03FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB0404FC0404FC0404FC
          0405FA0405FA0405FA0304F90304F90304F90304F90304F90304F90304F90304
          F90304F90304F90304F90304F90304F90304F90304F90405FA0405FA0405F904
          05F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F9
          0405F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405
          F90405F90406F80406F80406F80406F80804F70805FB0506FB0104F90105F806
          06FA0C04FB0D01FB030CF00207F00607FB0405FA040BF50107EA0C0AF00E04F8
          0508F70508F70508F70508F70508F70508F70508F70508F70607F70607F70607
          F70607F70607F70607F70607F70607F70506F60506F60506F60506F60607F706
          07F70607F70607F70608F60608F60101FF0101FF0102FE0102FE0102FE0102FE
          0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102
          FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0001FD00
          01FD0001FD0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE
          0102FE0102FE0102FE0102FE0103FC0103FC0103FC0103FC0103FC0302FC0302
          FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC03
          02FC0302FC0403FD0403FD0403FD0403FD0302FC0302FC0302FC0302FC0302FC
          0302FC0302FC0302FC0302FC0303FB0303FB0303FB0303FB0303FB0303FB0303
          FB0303FB0303FB0303FB0303FB0303FB0303FB0404FC0404FC0404FC0405FA04
          05FA0405FA0304F90304F90304F90304F90304F90304F90304F90304F90304F9
          0304F90304F90304F90304F90304F90304F90405FA0405FA0405F90405F90405
          F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F904
          05F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405F9
          0406F80406F80406F80406F80406F80406F80406F80406F80406F80406F80406
          F80406F80506F80506F80506F80506F80506F80506F80506F80506F80508F705
          08F70508F70508F70508F70508F70508F70508F70607F70607F70607F70607F7
          0607F70607F70607F70607F70506F60506F60506F60506F60607F70607F70607
          F70607F70608F60608F60101FF0101FF0102FE0102FE0102FE0102FE0102FE01
          02FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE
          0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0001FD0001FD0001
          FD0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE0102FE01
          02FE0102FE0102FE0103FC0103FC0103FC0103FC0103FC0302FC0302FC0302FC
          0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302FC0302
          FC0403FD0403FD0403FD0403FD0302FC0302FC0302FC0302FC0302FC0302FC03
          02FC0302FC0302FC0303FB0303FB0303FB0303FB0303FB0303FB0303FB0303FB
          0303FB0303FB0303FB0303FB0303FB0404FC0404FC0404FC0405FA0405FA0405
          FA0304F90304F90304F90304F90304F90304F90304F90304F90304F90304F903
          04F90304F90304F90304F90304F90405FA0405FA0405F90405F90405F90405F9
          0405F90405F90405F90405F90405F90405F90405F90405F90405F90405F90405
          F90405F90405F90405F90405F90405F90405F90405F90405F90405F90406F804
          06F80406F80406F80406F80406F80406F80406F80406F80406F80406F80406F8
          0506F80506F80506F80506F80506F80506F80506F80506F80508F70508F70508
          F70508F70508F70508F70508F70508F70607F70607F70607F70607F70607F706
          07F70607F70607F70506F60506F60506F60506F60607F70607F70607F70607F7
          0608F60608F6}
        Stretch = True
      end
      object QRShape13: TQRShape
        Left = 668
        Top = 177
        Width = 189
        Height = 2
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          390.260416666667000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel4: TQRLabel
        Left = 671
        Top = 181
        Width = 79
        Height = 13
        Size.Values = (
          28.663194444444440000
          1479.461805555556000000
          399.079861111111100000
          174.184027777777800000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(-) Outras Dedu'#231#245'es'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel5: TQRLabel
        Left = 672
        Top = 228
        Width = 90
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          502.708333333333300000
          198.437500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(+) Outros Acr'#233'scimos'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object lblCob: TQRLabel
        Left = 169
        Top = 137
        Width = 32
        Height = 18
        Size.Values = (
          39.687500000000000000
          372.621527777777800000
          302.065972222222200000
          70.555555555555560000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'COB.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblCobPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object lblDtaVen: TQRLabel
        Left = 687
        Top = 48
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333333000000
          105.833333333333300000
          350.572916666666700000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Data Vencimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblDtaVenPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object lblDtaMov: TQRLabel
        Left = 14
        Top = 107
        Width = 120
        Height = 17
        Size.Values = (
          37.482638888888900000
          30.868055555555600000
          235.920138888889000000
          264.583333333333000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Data Movimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblDtaMovPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object lblDocumento: TQRLabel
        Left = 159
        Top = 107
        Width = 164
        Height = 17
        Size.Values = (
          37.482638888888900000
          350.572916666667000000
          235.920138888889000000
          361.597222222222000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblDocumentoPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object lblEspDoc: TQRLabel
        Left = 338
        Top = 107
        Width = 63
        Height = 17
        Size.Values = (
          37.482638888888900000
          745.243055555556000000
          235.920138888889000000
          138.906250000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Esp. Doc.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblEspDocPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object lblDtaProcess: TQRLabel
        Left = 478
        Top = 107
        Width = 171
        Height = 17
        Size.Values = (
          37.482638888888900000
          1053.923611111110000000
          235.920138888889000000
          377.031250000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Processamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblDtaProcessPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object lblCedente: TQRLabel
        Left = 687
        Top = 79
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          174.184027777778000000
          350.572916666667000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'N. Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblCedentePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object lblNosNum: TQRLabel
        Left = 687
        Top = 107
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          235.920138888889000000
          350.572916666667000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Nosso Numero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblNosNumPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object lblValorDoc: TQRLabel
        Left = 687
        Top = 136
        Width = 159
        Height = 18
        Size.Values = (
          39.687500000000000000
          1515.684523809520000000
          300.491071428571000000
          351.517857142857000000)
        XLColumn = 0
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblValorDocPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object lblInstr4: TQRLabel
        Left = 24
        Top = 200
        Width = 623
        Height = 14
        Size.Values = (
          29.765625000000000000
          52.916666666666700000
          439.869791666667000000
          1372.526041666670000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr4Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object lblInstr5: TQRLabel
        Left = 24
        Top = 213
        Width = 623
        Height = 14
        Size.Values = (
          29.765625000000000000
          52.916666666666700000
          469.635416666667000000
          1372.526041666670000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr5Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object lblInstr6: TQRLabel
        Left = 24
        Top = 228
        Width = 623
        Height = 14
        Size.Values = (
          29.765625000000000000
          52.916666666666700000
          502.708333333333000000
          1372.526041666670000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr6Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object lblInstr7: TQRLabel
        Left = 24
        Top = 241
        Width = 623
        Height = 14
        Size.Values = (
          29.765625000000000000
          52.916666666666700000
          532.473958333333000000
          1372.526041666670000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr7Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object lblInstr8: TQRLabel
        Left = 24
        Top = 255
        Width = 623
        Height = 14
        Size.Values = (
          29.765625000000000000
          52.916666666666700000
          562.239583333333000000
          1372.526041666670000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr8Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object lblNossoNumero: TQRLabel
        Left = 763
        Top = 312
        Width = 68
        Height = 13
        Size.Values = (
          28.663194444444440000
          1682.309027777778000000
          687.916666666666700000
          149.930555555555600000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nosso Numero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblNossoNumeroPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel68: TQRLabel
        Left = 32
        Top = 1116
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555600000
          70.555555555555600000
          2460.625000000000000000
          1221.493055555560000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '1234567890'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'STS2DE5CSLBGABES330264C'
        Font.Style = []
        OnPrint = QRLabel68Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 13
      end
      object QRShape7: TQRShape
        Left = 3
        Top = 1053
        Width = 853
        Height = 2
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          2321.718750000000000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape11: TQRShape
        Left = 3
        Top = 924
        Width = 853
        Height = 2
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          2037.291666666670000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape14: TQRShape
        Left = 3
        Top = 894
        Width = 853
        Height = 2
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          1971.145833333330000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape15: TQRShape
        Left = 3
        Top = 864
        Width = 853
        Height = 2
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          1905.000000000000000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape18: TQRShape
        Left = 3
        Top = 795
        Width = 853
        Height = 14
        Size.Values = (
          29.765625000000000000
          6.614583333333330000
          1752.864583333330000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape19: TQRShape
        Left = 3
        Top = 834
        Width = 853
        Height = 2
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          1838.854166666670000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape20: TQRShape
        Left = 191
        Top = 777
        Width = 12
        Height = 24
        Size.Values = (
          52.916666666666700000
          420.026041666667000000
          1713.177083333330000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape21: TQRShape
        Left = 3
        Top = 1109
        Width = 853
        Height = 2
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          2444.088541666670000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel7: TQRLabel
        Left = 201
        Top = 777
        Width = 81
        Height = 24
        Size.Values = (
          52.916666666666700000
          443.177083333333000000
          1713.177083333330000000
          178.593750000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '353-7'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNrBancoPrint
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 12
      end
      object QRLabel8: TQRLabel
        Left = 672
        Top = 804
        Width = 48
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1772.708333333333000000
          105.833333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Vencimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape22: TQRShape
        Left = 279
        Top = 777
        Width = 9
        Height = 24
        Size.Values = (
          52.916666666666700000
          615.156250000000000000
          1713.177083333330000000
          19.843750000000000000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel9: TQRLabel
        Left = 5
        Top = 805
        Width = 82
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1774.913194444444000000
          180.798611111111100000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Local de Pagamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel11: TQRLabel
        Left = 57
        Top = 845
        Width = 603
        Height = 18
        Size.Values = (
          39.687500000000000000
          125.677083333333300000
          1863.107638888889000000
          1329.531250000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nome do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNomeCedentePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel12: TQRLabel
        Left = 672
        Top = 836
        Width = 89
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1843.263888888889000000
          196.232638888888900000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Ag'#234'ncia/C'#243'd. Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel13: TQRLabel
        Left = 2
        Top = 866
        Width = 78
        Height = 10
        Size.Values = (
          22.048611111111110000
          4.409722222222222000
          1909.409722222222000000
          171.979166666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel14: TQRLabel
        Left = 145
        Top = 866
        Width = 70
        Height = 10
        Size.Values = (
          22.048611111111110000
          319.704861111111100000
          1909.409722222222000000
          154.340277777777800000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'N'#186' do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel15: TQRLabel
        Left = 334
        Top = 866
        Width = 54
        Height = 10
        Size.Values = (
          22.048611111111110000
          736.423611111111100000
          1909.409722222222000000
          119.062500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Esp'#233'cie Doc.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel16: TQRLabel
        Left = 418
        Top = 866
        Width = 26
        Height = 10
        Size.Values = (
          22.048611111111110000
          921.631944444444400000
          1909.409722222222000000
          57.326388888888890000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Aceite'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel17: TQRLabel
        Left = 475
        Top = 866
        Width = 96
        Height = 10
        Size.Values = (
          22.048611111111110000
          1047.309027777778000000
          1909.409722222222000000
          211.666666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data do Processamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel18: TQRLabel
        Left = 672
        Top = 866
        Width = 84
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          1909.409722222222000000
          185.208333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cart./ Nosso N'#250'mero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel19: TQRLabel
        Left = 2
        Top = 896
        Width = 56
        Height = 10
        Size.Values = (
          22.048611111111110000
          4.409722222222222000
          1975.555555555556000000
          123.472222222222200000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Uso do Banco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel20: TQRLabel
        Left = 169
        Top = 896
        Width = 20
        Height = 10
        Size.Values = (
          22.048611111111110000
          372.621527777777800000
          1975.555555555556000000
          44.097222222222220000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cart.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel21: TQRLabel
        Left = 227
        Top = 896
        Width = 44
        Height = 10
        Size.Values = (
          22.048611111111110000
          500.503472222222200000
          1975.555555555556000000
          97.013888888888890000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Esp Moeda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel22: TQRLabel
        Left = 230
        Top = 907
        Width = 73
        Height = 17
        Size.Values = (
          37.482638888888900000
          507.118055555556000000
          1999.809027777780000000
          160.954861111111000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'R$'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel23: TQRLabel
        Left = 317
        Top = 896
        Width = 46
        Height = 10
        Size.Values = (
          22.048611111111110000
          698.940972222222200000
          1975.555555555556000000
          101.423611111111100000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Quantidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel24: TQRLabel
        Left = 592
        Top = 896
        Width = 41
        Height = 10
        Size.Values = (
          22.048611111111110000
          1305.277777777778000000
          1975.555555555556000000
          90.399305555555560000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Vr. Moeda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel25: TQRLabel
        Left = 576
        Top = 899
        Width = 10
        Height = 22
        Size.Values = (
          48.506944444444440000
          1270.000000000000000000
          1982.170138888889000000
          22.048611111111110000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'x'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 9
      end
      object QRLabel26: TQRLabel
        Left = 672
        Top = 896
        Width = 94
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          1975.555555555556000000
          207.256944444444400000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(=) Valor do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel27: TQRLabel
        Left = 2
        Top = 926
        Width = 43
        Height = 11
        Size.Values = (
          24.253472222222220000
          4.409722222222222000
          2041.701388888889000000
          94.809027777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Instru'#231#245'es'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel28: TQRLabel
        Left = 672
        Top = 926
        Width = 95
        Height = 11
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2041.701388888889000000
          209.461805555555600000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(-) Desconto/Abatimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel29: TQRLabel
        Left = 672
        Top = 974
        Width = 55
        Height = 11
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2147.534722222222000000
          121.267361111111100000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(+) Mora/Multa'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel30: TQRLabel
        Left = 672
        Top = 1018
        Width = 71
        Height = 11
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2244.548611111111000000
          156.545138888888900000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(=) Valor Cobrado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel31: TQRLabel
        Left = 7
        Top = 1057
        Width = 38
        Height = 11
        Size.Values = (
          24.253472222222220000
          15.434027777777780000
          2330.538194444444000000
          83.784722222222220000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Pagador:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel32: TQRLabel
        Left = 3
        Top = 1098
        Width = 74
        Height = 9
        Size.Values = (
          19.843750000000000000
          6.614583333333333000
          2420.937500000000000000
          163.159722222222200000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Sacador/Avalista:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel33: TQRLabel
        Left = 675
        Top = 1095
        Width = 74
        Height = 14
        Size.Values = (
          30.868055555555560000
          1488.281250000000000000
          2414.322916666667000000
          163.159722222222200000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'C'#243'digo de Baixa'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel34: TQRLabel
        Left = 705
        Top = 1112
        Width = 53
        Height = 9
        Size.Values = (
          19.843750000000000000
          1554.427083333333000000
          2451.805555555556000000
          116.857638888888900000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Autentica'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape23: TQRShape
        Left = 668
        Top = 972
        Width = 189
        Height = 2
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          2143.125000000000000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape24: TQRShape
        Left = 668
        Top = 992
        Width = 189
        Height = 2
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          2186.119791666670000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel35: TQRLabel
        Left = 51
        Top = 1056
        Width = 372
        Height = 14
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2328.333333333330000000
          820.208333333334000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'LabelNomeTitular'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNomeTitularPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel36: TQRLabel
        Left = 51
        Top = 1069
        Width = 372
        Height = 14
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2358.098958333330000000
          820.208333333334000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'LabelEndereco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelEnderecoPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel37: TQRLabel
        Left = 51
        Top = 1083
        Width = 372
        Height = 14
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2387.864583333330000000
          820.208333333334000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'LabelCidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelCidadePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRShape26: TQRShape
        Left = 666
        Top = 802
        Width = 3
        Height = 253
        Size.Values = (
          557.829861111111000000
          1468.437500000000000000
          1768.298611111110000000
          6.614583333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel41: TQRLabel
        Left = 6
        Top = 819
        Width = 651
        Height = 15
        Size.Values = (
          33.072916666666700000
          13.229166666666700000
          1805.781250000000000000
          1435.364583333330000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'EM QUALQUER AG'#202'NCIA, AP'#211'S O VENCTO NAS AG. DO BANESPA SANTANDER ' +
          'OU DE ACORDO COM AS INSTRU'#199#213'ES DA FICHA DE COMPENSA'#199#195'O'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel43: TQRLabel
        Left = 227
        Top = 804
        Width = 292
        Height = 9
        Size.Values = (
          19.843750000000000000
          499.401041666667000000
          1772.708333333330000000
          644.921875000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pag'#225'vel preferencialmente nas Ag'#234'ncias do Banespa Santander'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape27: TQRShape
        Left = 143
        Top = 865
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          315.295138888889000000
          1907.204861111110000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape29: TQRShape
        Left = 330
        Top = 865
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          727.604166666667000000
          1907.204861111110000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape30: TQRShape
        Left = 412
        Top = 865
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          908.402777777778000000
          1907.204861111110000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape31: TQRShape
        Left = 165
        Top = 894
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          363.802083333333000000
          1971.145833333330000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape32: TQRShape
        Left = 220
        Top = 894
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          485.069444444444000000
          1971.145833333330000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape33: TQRShape
        Left = 579
        Top = 894
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          1276.614583333330000000
          1971.145833333330000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape34: TQRShape
        Left = 668
        Top = 1017
        Width = 187
        Height = 2
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          2242.343750000000000000
          413.411458333333000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape35: TQRShape
        Left = 312
        Top = 894
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          687.916666666667000000
          1971.145833333330000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel44: TQRLabel
        Left = 8
        Top = 907
        Width = 143
        Height = 17
        Size.Values = (
          37.482638888888900000
          17.638888888888900000
          1999.809027777780000000
          315.295138888889000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Cidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblCidadePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRShape36: TQRShape
        Left = 468
        Top = 865
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          1031.875000000000000000
          1907.204861111110000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel45: TQRLabel
        Left = 446
        Top = 877
        Width = 10
        Height = 17
        Size.Values = (
          37.482638888888890000
          983.368055555555600000
          1933.663194444444000000
          22.048611111111110000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'N'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblAceitePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRImage1: TQRImage
        Left = 7
        Top = 771
        Width = 149
        Height = 29
        Size.Values = (
          63.940972222222200000
          15.434027777777800000
          1699.947916666670000000
          328.524305555556000000)
        XLColumn = 0
        AutoSize = True
        Picture.Data = {
          07544269746D61707A0E0000424D7A0E0000000000007600000028000000B400
          0000270000000100040000000000040E00000000000000000000100000000000
          0000000000000000800000800000008080008000000080008000808000008080
          8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999900009999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999990000999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999000099999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999900009999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999990000999999999999999888888888899999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          99999999999999990000999999999978FFFFFFFFFFFFFFFF8999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          999999990000999999998FFFFFFFFFFFFFFFFFFFFFF8999999999999978FFFFF
          FF899999997FFFF898F8999FFFFFFF98FFFFFFF99998FFF79997FFFF89FF8999
          FFFFFFF99FFFFFFF999998FFFF89FF899999998FFFFF899998FFFFFF89999999
          00009999998FFFFFFFFFFFFFFFFFFFFFFFFFF8999999999998FFF8898FFF8999
          99FFFFFFFFFFFF997FFF899998FFF899998FFFFF899FFFFFFFFFFF8997FFF899
          998FFF899998FFFFFFFFFFFF89997FFFFFFFFF89999FFFF99999999900009999
          98FFFFFFFFFFFFFFFFFFFFFFFFFFFFF99999999998FF9999998FF89998FFF999
          8FFF87799FFF999999FFF99999FFF898878FFF9998FFF87999FFF999999FFF99
          998FFFF99998FFF88799FFFF799998F99998FF8999999999000099998FFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF9999999998F999999998FF9998FF89999FFF9999
          9FFF999999FFF99998FFF999998FF89999FFF99999FFF999999FFF9999FFFF99
          9999FFF99998FFF9999999999998FF899999999900009998FFFFFFFFFFFFFFF8
          9FFFFFFFFFFFFFFF89999999988999999997FF7997FF89999FFF99999FFF9999
          99FFF99998FF8999997FF89999FFF99999FFF999999FFF9999FFF8999999FFF9
          999FFF89999999999998FF89999999990000999FFFFFFFFFFFFFFFF79FFFFFFF
          FFFFFFFFF9999999987999999997FF89998FF8999FFF99999FFF999999FFF999
          98FF89999998FF8999FFF99999FFF999999FFF9998FFF9999999FFF9999FFF99
          999999999998FF89999999990000999FFFFFFFFFFFFFFF899FFFFFFFFFFFFFFF
          F8999999999999999998FF8999998FF89FFF99999FFF999999FFF99998FF8999
          999998FF88FFF99999FFF999999FFF9998FFF9999999FFF9999FFF9999999999
          9998FF89999999990000999FFFFFFFFFFFFFFF999FFFFFFFFFFFFFFFF7999999
          99999999998FFF899999998FFFFF99999FFF999999FF899998FF899999999998
          FFFFF99999FFF999999FFF9998FFF9999999FFF9999FFF88888888879998FF89
          9999999900009998FFFFFFFFFFFFF9998FFFFFFFFFFFFFFFF999999999999999
          8FFFFF99998899999FFF99999FFF999999FF899998FF89999998899997FFF999
          99FFF999999FFF9999FFF9999999FFF9999FFFFFFFFFFFF89998FF8999999999
          00009999FFFFFFFFFFFF8999FFF8FFFFFFFFFFFF899999999999998FFFFFF899
          99FF89999FFF99999FFF999998FF899998FF8999999FF89999FFF99999FFF999
          999FFF9999FFF9999999FFF99998FF8999998FF89998FF899999999900009999
          9FFFFFFFFFF89998FFF87FFFFFFFFFF89999999999998FFFFFFF899999FF8999
          7FFF99999FFF899998FF899998FF8999999FF89997FFF99999FFF899998FF899
          997FF8999999FFF99999FF8999998FF9999FFFF7999F999900009999998FFFFF
          FFF9997FFFF99FFFFFFFFF89999999999998FFFFFFF99999999FF899FFF8999F
          FFFFFF888FFF799998FF89999997FF9998FF8999FFFFFFF888FFF8999998FF89
          9998FFF999997FF89998FF8998FFFFFF88FF99990000999999998FFFFF9999FF
          FF899FFFFFFF89999999999999FFFFFFF999999999998FFFFF8999998FFF8FFF
          FFF8997FFFFFFFFFF9999FFFFFFF999998FFF7FFFFFF899999998FFF8FFFFFF9
          999997FFF8FFF899999FFF88FFFF9999000099999999998FF8999FFFFF999FFF
          FF8999999999999998FFFF899999999999999988879999999998997888799999
          8FFF888889999998887999999999899788889999999999888888FFF999999997
          888899999999989988889999000099999999999999998FFFF9998FF899999999
          9999999998FFF899999999999999999999999999999999999999999998FF8999
          99999999999999999999999999999999999999999999FFF99999999999999999
          999999999999999900009999999999999999FFFF7999FFF99999999999999999
          98FF89999999989999999999999999999999999999999999998F899999999999
          999999999999999999999999999999999999FFF9999999999999999999999999
          9999999900009999999999999998FFF89998FFF9999999999999999998FF9999
          99998F9999999999999999999999999999999999999889999999999999999999
          9999999999999999999999999999FFF999999999999999999999999999999999
          0000999999999999999FFF89998FFF89999999999999999998FF99999999FF99
          9999999999999999999999999999999999999999999999999999999999999999
          99999999999999999999FFF99999999999999999999999999999999900009999
          99999999999FFF9999FFFF99999999999999999999FF89999998FF9999999999
          9999999999999999999999999999999999999999999999999999999999999999
          999999999999FFF9999999999999999999999999999999990000999999999999
          999FF9999FFFF8999999999999999999999FFF9997FFFF999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999FFF9999999999999999999999999999999990000999999999999999FF999
          FFFF8999999999999999999999998FFFFFFFF899999999999999999999999999
          999999999999999999999999999999999999999999999999999999999978FFF9
          9999999999999999999999999999999900009999999999999998F998FFFF9999
          9999999999999999999999988999999999999999999999999999999999999999
          999999999999999999999999999999999999999999999999998FFFF999999999
          99999999999999999999999900009999999999999999899FFFF7999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          999999999999999999999999999999999999999999998FF99999999999999999
          999999999999999900009999999999999999999FFF8999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999900009999999999999999999FFF999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          00009999999999999999999FF799999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999900009999
          999999999999999FF99999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999990000999999999999
          9999999889999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999000099999999999999999999
          8999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999900009999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999990000999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999000099999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          999999990000}
        Stretch = True
      end
      object QRShape37: TQRShape
        Left = 668
        Top = 948
        Width = 189
        Height = 2
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          2090.208333333330000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel46: TQRLabel
        Left = 670
        Top = 950
        Width = 79
        Height = 11
        Size.Values = (
          24.253472222222220000
          1477.256944444444000000
          2094.618055555556000000
          174.184027777777800000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(-) Outras Dedu'#231#245'es'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel47: TQRLabel
        Left = 672
        Top = 994
        Width = 90
        Height = 11
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2191.631944444444000000
          198.437500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(+) Outros Acr'#233'scimos'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel48: TQRLabel
        Left = 170
        Top = 906
        Width = 32
        Height = 18
        Size.Values = (
          39.687500000000000000
          374.826388888888900000
          1997.604166666667000000
          70.555555555555560000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'COB.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblCobPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel49: TQRLabel
        Left = 686
        Top = 816
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          1799.166666666670000000
          351.895833333333000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Data Vencimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblDtaVenPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel52: TQRLabel
        Left = 13
        Top = 877
        Width = 120
        Height = 17
        Size.Values = (
          37.482638888888900000
          28.663194444444400000
          1933.663194444440000000
          264.583333333333000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Data Movimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblDtaMovPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel53: TQRLabel
        Left = 156
        Top = 877
        Width = 163
        Height = 17
        Size.Values = (
          37.482638888888900000
          343.958333333333000000
          1933.663194444440000000
          359.392361111111000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblDocumentoPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel55: TQRLabel
        Left = 337
        Top = 877
        Width = 65
        Height = 17
        Size.Values = (
          37.482638888888900000
          743.038194444444000000
          1933.663194444440000000
          143.315972222222000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Esp. Doc.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblEspDocPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel69: TQRLabel
        Left = 479
        Top = 877
        Width = 169
        Height = 17
        Size.Values = (
          37.482638888888900000
          1056.128472222220000000
          1933.663194444440000000
          372.621527777778000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Processamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblDtaProcessPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel70: TQRLabel
        Left = 686
        Top = 846
        Width = 158
        Height = 18
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          1865.312500000000000000
          349.250000000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'N. Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel128Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel71: TQRLabel
        Left = 694
        Top = 877
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1530.173611111110000000
          1933.663194444440000000
          352.777777777778000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Nosso Numero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel129Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel72: TQRLabel
        Left = 686
        Top = 907
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1512.534722222220000000
          1999.809027777780000000
          352.777777777778000000)
        XLColumn = 0
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblValorDocPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel78: TQRLabel
        Left = 753
        Top = 1095
        Width = 68
        Height = 14
        Size.Values = (
          30.868055555555560000
          1660.260416666667000000
          2414.322916666667000000
          149.930555555555600000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nosso Numero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblNossoNumeroPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object lblLinhaDig: TQRLabel
        Left = 299
        Top = 778
        Width = 537
        Height = 22
        Size.Values = (
          49.609375000000000000
          658.151041666667000000
          1716.484375000000000000
          1184.010416666670000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Linha Digitavel'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblLinhaDigPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 11
      end
      object QRLabel80: TQRLabel
        Left = 818
        Top = 753
        Width = 19
        Height = 19
        Size.Values = (
          41.892361111111110000
          1803.576388888889000000
          1660.260416666667000000
          41.892361111111110000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '"'
        Color = clWhite
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel81: TQRLabel
        Left = 32
        Top = 1134
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555600000
          70.555555555555600000
          2500.312500000000000000
          1221.493055555560000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '1234567890'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'STS2DE5CSLBGABES330264C'
        Font.Style = []
        OnPrint = QRLabel68Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 13
      end
      object QRLabel82: TQRLabel
        Left = 32
        Top = 1152
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555600000
          70.555555555555600000
          2540.000000000000000000
          1221.493055555560000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '1234567890'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'STS2DE5CSLBGABES330264C'
        Font.Style = []
        OnPrint = QRLabel68Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 13
      end
      object lblInstr1: TQRLabel
        Left = 52
        Top = 159
        Width = 594
        Height = 14
        Size.Values = (
          29.765625000000000000
          115.755208333333000000
          350.572916666667000000
          1309.687500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr1Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object lblInstr3: TQRLabel
        Left = 24
        Top = 186
        Width = 623
        Height = 14
        Size.Values = (
          29.765625000000000000
          52.916666666666700000
          410.104166666667000000
          1372.526041666670000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr3Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object InsSac: TQRLabel
        Left = 462
        Top = 279
        Width = 212
        Height = 14
        Size.Values = (
          29.765625000000000000
          1018.645833333330000000
          615.156250000000000000
          466.328125000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = InsSacPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel39: TQRLabel
        Left = 446
        Top = 1062
        Width = 212
        Height = 14
        Size.Values = (
          29.765625000000000000
          982.265625000000000000
          2341.562500000000000000
          466.328125000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = InsSacPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object lblInstr2: TQRLabel
        Left = 24
        Top = 173
        Width = 623
        Height = 14
        Size.Values = (
          29.765625000000000000
          52.916666666666700000
          380.338541666667000000
          1372.526041666670000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr2Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel74: TQRLabel
        Left = 24
        Top = 978
        Width = 621
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          2156.354166666670000000
          1369.218750000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr4Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel75: TQRLabel
        Left = 24
        Top = 994
        Width = 621
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          2191.631944444440000000
          1369.218750000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr5Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel76: TQRLabel
        Left = 24
        Top = 1010
        Width = 621
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          2226.909722222220000000
          1369.218750000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr6Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel77: TQRLabel
        Left = 24
        Top = 1025
        Width = 621
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          2259.982638888890000000
          1369.218750000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr7Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel85: TQRLabel
        Left = 24
        Top = 1036
        Width = 621
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          2284.236111111110000000
          1369.218750000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr8Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel86: TQRLabel
        Left = 51
        Top = 930
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          112.447916666667000000
          2050.520833333330000000
          1309.687500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr1Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel87: TQRLabel
        Left = 24
        Top = 962
        Width = 621
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          2121.076388888890000000
          1369.218750000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr3Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel88: TQRLabel
        Left = 24
        Top = 946
        Width = 621
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          2085.798611111110000000
          1369.218750000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr2Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRShape38: TQRShape
        Left = 3
        Top = 369
        Width = 853
        Height = 6
        Size.Values = (
          13.229166666666700000
          6.614583333333330000
          813.593750000000000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape39: TQRShape
        Left = 3
        Top = 654
        Width = 853
        Height = 2
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          1441.979166666670000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape40: TQRShape
        Left = 3
        Top = 528
        Width = 853
        Height = 2
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          1164.166666666670000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape41: TQRShape
        Left = 3
        Top = 498
        Width = 853
        Height = 2
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          1098.020833333330000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape42: TQRShape
        Left = 3
        Top = 466
        Width = 853
        Height = 3
        Size.Values = (
          6.614583333333330000
          6.614583333333330000
          1028.567708333330000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape43: TQRShape
        Left = 3
        Top = 399
        Width = 853
        Height = 14
        Size.Values = (
          29.765625000000000000
          6.614583333333330000
          879.739583333334000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape44: TQRShape
        Left = 3
        Top = 438
        Width = 853
        Height = 3
        Size.Values = (
          6.614583333333330000
          6.614583333333330000
          965.729166666667000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape45: TQRShape
        Left = 191
        Top = 381
        Width = 12
        Height = 24
        Size.Values = (
          52.916666666666700000
          420.026041666667000000
          840.052083333334000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape46: TQRShape
        Left = 3
        Top = 709
        Width = 853
        Height = 4
        Size.Values = (
          9.921875000000000000
          6.614583333333330000
          1564.348958333330000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel89: TQRLabel
        Left = 201
        Top = 381
        Width = 81
        Height = 24
        Size.Values = (
          52.916666666666700000
          443.177083333333000000
          840.052083333334000000
          178.593750000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '353-7'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNrBancoPrint
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 12
      end
      object QRLabel90: TQRLabel
        Left = 672
        Top = 409
        Width = 48
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          901.788194444444400000
          105.833333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Vencimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape47: TQRShape
        Left = 279
        Top = 381
        Width = 9
        Height = 24
        Size.Values = (
          52.916666666666700000
          615.156250000000000000
          840.052083333334000000
          19.843750000000000000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel91: TQRLabel
        Left = 5
        Top = 408
        Width = 82
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          899.583333333333300000
          180.798611111111100000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Local de Pagamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel92: TQRLabel
        Left = 57
        Top = 445
        Width = 603
        Height = 18
        Size.Values = (
          39.687500000000000000
          125.677083333333300000
          981.163194444444400000
          1329.531250000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nome do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNomeCedentePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel93: TQRLabel
        Left = 672
        Top = 441
        Width = 89
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          972.343750000000000000
          196.232638888888900000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Ag'#234'ncia/C'#243'd. Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel94: TQRLabel
        Left = 2
        Top = 469
        Width = 78
        Height = 13
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          1034.079861111111000000
          171.979166666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel95: TQRLabel
        Left = 145
        Top = 469
        Width = 70
        Height = 13
        Size.Values = (
          28.663194444444440000
          319.704861111111100000
          1034.079861111111000000
          154.340277777777800000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'N'#186' do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel96: TQRLabel
        Left = 334
        Top = 469
        Width = 54
        Height = 13
        Size.Values = (
          28.663194444444440000
          736.423611111111100000
          1034.079861111111000000
          119.062500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Esp'#233'cie Doc.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel97: TQRLabel
        Left = 418
        Top = 469
        Width = 26
        Height = 13
        Size.Values = (
          28.663194444444440000
          921.631944444444400000
          1034.079861111111000000
          57.326388888888890000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Aceite'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel98: TQRLabel
        Left = 475
        Top = 469
        Width = 96
        Height = 13
        Size.Values = (
          28.663194444444440000
          1047.309027777778000000
          1034.079861111111000000
          211.666666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data do Processamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel99: TQRLabel
        Left = 672
        Top = 469
        Width = 84
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1034.079861111111000000
          185.208333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cart./ Nosso N'#250'mero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel100: TQRLabel
        Left = 10
        Top = 502
        Width = 56
        Height = 13
        Size.Values = (
          28.663194444444440000
          22.048611111111110000
          1106.840277777778000000
          123.472222222222200000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Uso do Banco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel101: TQRLabel
        Left = 169
        Top = 502
        Width = 20
        Height = 13
        Size.Values = (
          28.663194444444440000
          372.621527777777800000
          1106.840277777778000000
          44.097222222222220000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cart.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel102: TQRLabel
        Left = 227
        Top = 502
        Width = 44
        Height = 13
        Size.Values = (
          28.663194444444440000
          500.503472222222200000
          1106.840277777778000000
          97.013888888888890000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Esp Moeda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel103: TQRLabel
        Left = 232
        Top = 511
        Width = 73
        Height = 17
        Size.Values = (
          37.482638888888900000
          511.527777777778000000
          1126.684027777780000000
          160.954861111111000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'R$'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel104: TQRLabel
        Left = 317
        Top = 502
        Width = 46
        Height = 13
        Size.Values = (
          28.663194444444440000
          698.940972222222200000
          1106.840277777778000000
          101.423611111111100000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Quantidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel105: TQRLabel
        Left = 592
        Top = 502
        Width = 41
        Height = 13
        Size.Values = (
          28.663194444444440000
          1305.277777777778000000
          1106.840277777778000000
          90.399305555555560000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Vr. Moeda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel106: TQRLabel
        Left = 576
        Top = 502
        Width = 10
        Height = 19
        Size.Values = (
          41.892361111111110000
          1270.000000000000000000
          1106.840277777778000000
          22.048611111111110000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'x'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 9
      end
      object QRLabel107: TQRLabel
        Left = 672
        Top = 502
        Width = 94
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1106.840277777778000000
          207.256944444444400000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(=) Valor do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel108: TQRLabel
        Left = 672
        Top = 530
        Width = 95
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1168.576388888889000000
          209.461805555555600000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(-) Desconto/Abatimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel109: TQRLabel
        Left = 672
        Top = 577
        Width = 55
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1272.204861111111000000
          121.267361111111100000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(+) Mora/Multa'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel110: TQRLabel
        Left = 672
        Top = 622
        Width = 71
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1371.423611111111000000
          156.545138888888900000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(=) Valor Cobrado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel111: TQRLabel
        Left = 2
        Top = 700
        Width = 74
        Height = 12
        Size.Values = (
          26.458333333333330000
          4.409722222222222000
          1543.402777777778000000
          163.159722222222200000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Sacador/Avalista:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel112: TQRLabel
        Left = 674
        Top = 698
        Width = 74
        Height = 13
        Size.Values = (
          28.663194444444440000
          1486.076388888889000000
          1538.993055555556000000
          163.159722222222200000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'C'#243'digo de Baixa'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRShape48: TQRShape
        Left = 668
        Top = 572
        Width = 189
        Height = 2
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          1260.078125000000000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape49: TQRShape
        Left = 668
        Top = 591
        Width = 189
        Height = 6
        Size.Values = (
          13.229166666666700000
          1471.744791666670000000
          1303.072916666670000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel113: TQRLabel
        Left = 51
        Top = 657
        Width = 372
        Height = 14
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          1448.593750000000000000
          820.208333333334000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'LabelNomeTitular'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNomeTitularPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel114: TQRLabel
        Left = 51
        Top = 670
        Width = 372
        Height = 14
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          1478.359375000000000000
          820.208333333334000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'LabelEndereco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelEnderecoPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel115: TQRLabel
        Left = 51
        Top = 684
        Width = 372
        Height = 14
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          1508.125000000000000000
          820.208333333334000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'LabelCidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelCidadePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRShape50: TQRShape
        Left = 666
        Top = 405
        Width = 3
        Height = 250
        Size.Values = (
          552.317708333333000000
          1468.437500000000000000
          892.968750000000000000
          6.614583333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel116: TQRLabel
        Left = 6
        Top = 423
        Width = 651
        Height = 15
        Size.Values = (
          33.072916666666700000
          13.229166666666700000
          932.656250000000000000
          1435.364583333330000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'EM QUALQUER AG'#202'NCIA, AP'#211'S O VENCTO NAS AG. DO BANESPA SANTANDER ' +
          'OU DE ACORDO COM AS INSTRU'#199#213'ES DA FICHA DE COMPENSA'#199#195'O'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel117: TQRLabel
        Left = 227
        Top = 408
        Width = 292
        Height = 9
        Size.Values = (
          19.843750000000000000
          499.401041666667000000
          899.583333333333000000
          644.921875000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pag'#225'vel preferencialmente nas Ag'#234'ncias do Banespa Santander'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape51: TQRShape
        Left = 142
        Top = 471
        Width = 2
        Height = 27
        Size.Values = (
          59.531250000000000000
          314.192708333333000000
          1038.489583333330000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape52: TQRShape
        Left = 330
        Top = 470
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          727.604166666667000000
          1035.182291666670000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape53: TQRShape
        Left = 412
        Top = 470
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          909.505208333333000000
          1035.182291666670000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape54: TQRShape
        Left = 165
        Top = 498
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          363.802083333333000000
          1098.020833333330000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape55: TQRShape
        Left = 220
        Top = 498
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          486.171875000000000000
          1098.020833333330000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape56: TQRShape
        Left = 579
        Top = 498
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          1276.614583333330000000
          1098.020833333330000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape57: TQRShape
        Left = 668
        Top = 615
        Width = 187
        Height = 6
        Size.Values = (
          13.229166666666700000
          1471.744791666670000000
          1355.989583333330000000
          413.411458333333000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape58: TQRShape
        Left = 312
        Top = 498
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          687.916666666667000000
          1098.020833333330000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel118: TQRLabel
        Left = 8
        Top = 511
        Width = 143
        Height = 17
        Size.Values = (
          37.482638888888900000
          17.638888888888900000
          1126.684027777780000000
          315.295138888889000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Cidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblCidadePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRShape59: TQRShape
        Left = 468
        Top = 470
        Width = 2
        Height = 29
        Size.Values = (
          62.838541666666700000
          1031.875000000000000000
          1035.182291666670000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel119: TQRLabel
        Left = 446
        Top = 475
        Width = 10
        Height = 18
        Size.Values = (
          39.687500000000000000
          983.368055555555600000
          1047.309027777778000000
          22.048611111111110000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'N'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblAceitePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRImage3: TQRImage
        Left = 7
        Top = 375
        Width = 149
        Height = 29
        Size.Values = (
          63.940972222222200000
          15.434027777777800000
          826.822916666667000000
          328.524305555556000000)
        XLColumn = 0
        AutoSize = True
        Picture.Data = {
          07544269746D61707A0E0000424D7A0E0000000000007600000028000000B400
          0000270000000100040000000000040E00000000000000000000100000000000
          0000000000000000800000800000008080008000000080008000808000008080
          8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999900009999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999990000999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999000099999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999900009999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999990000999999999999999888888888899999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          99999999999999990000999999999978FFFFFFFFFFFFFFFF8999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          999999990000999999998FFFFFFFFFFFFFFFFFFFFFF8999999999999978FFFFF
          FF899999997FFFF898F8999FFFFFFF98FFFFFFF99998FFF79997FFFF89FF8999
          FFFFFFF99FFFFFFF999998FFFF89FF899999998FFFFF899998FFFFFF89999999
          00009999998FFFFFFFFFFFFFFFFFFFFFFFFFF8999999999998FFF8898FFF8999
          99FFFFFFFFFFFF997FFF899998FFF899998FFFFF899FFFFFFFFFFF8997FFF899
          998FFF899998FFFFFFFFFFFF89997FFFFFFFFF89999FFFF99999999900009999
          98FFFFFFFFFFFFFFFFFFFFFFFFFFFFF99999999998FF9999998FF89998FFF999
          8FFF87799FFF999999FFF99999FFF898878FFF9998FFF87999FFF999999FFF99
          998FFFF99998FFF88799FFFF799998F99998FF8999999999000099998FFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF9999999998F999999998FF9998FF89999FFF9999
          9FFF999999FFF99998FFF999998FF89999FFF99999FFF999999FFF9999FFFF99
          9999FFF99998FFF9999999999998FF899999999900009998FFFFFFFFFFFFFFF8
          9FFFFFFFFFFFFFFF89999999988999999997FF7997FF89999FFF99999FFF9999
          99FFF99998FF8999997FF89999FFF99999FFF999999FFF9999FFF8999999FFF9
          999FFF89999999999998FF89999999990000999FFFFFFFFFFFFFFFF79FFFFFFF
          FFFFFFFFF9999999987999999997FF89998FF8999FFF99999FFF999999FFF999
          98FF89999998FF8999FFF99999FFF999999FFF9998FFF9999999FFF9999FFF99
          999999999998FF89999999990000999FFFFFFFFFFFFFFF899FFFFFFFFFFFFFFF
          F8999999999999999998FF8999998FF89FFF99999FFF999999FFF99998FF8999
          999998FF88FFF99999FFF999999FFF9998FFF9999999FFF9999FFF9999999999
          9998FF89999999990000999FFFFFFFFFFFFFFF999FFFFFFFFFFFFFFFF7999999
          99999999998FFF899999998FFFFF99999FFF999999FF899998FF899999999998
          FFFFF99999FFF999999FFF9998FFF9999999FFF9999FFF88888888879998FF89
          9999999900009998FFFFFFFFFFFFF9998FFFFFFFFFFFFFFFF999999999999999
          8FFFFF99998899999FFF99999FFF999999FF899998FF89999998899997FFF999
          99FFF999999FFF9999FFF9999999FFF9999FFFFFFFFFFFF89998FF8999999999
          00009999FFFFFFFFFFFF8999FFF8FFFFFFFFFFFF899999999999998FFFFFF899
          99FF89999FFF99999FFF999998FF899998FF8999999FF89999FFF99999FFF999
          999FFF9999FFF9999999FFF99998FF8999998FF89998FF899999999900009999
          9FFFFFFFFFF89998FFF87FFFFFFFFFF89999999999998FFFFFFF899999FF8999
          7FFF99999FFF899998FF899998FF8999999FF89997FFF99999FFF899998FF899
          997FF8999999FFF99999FF8999998FF9999FFFF7999F999900009999998FFFFF
          FFF9997FFFF99FFFFFFFFF89999999999998FFFFFFF99999999FF899FFF8999F
          FFFFFF888FFF799998FF89999997FF9998FF8999FFFFFFF888FFF8999998FF89
          9998FFF999997FF89998FF8998FFFFFF88FF99990000999999998FFFFF9999FF
          FF899FFFFFFF89999999999999FFFFFFF999999999998FFFFF8999998FFF8FFF
          FFF8997FFFFFFFFFF9999FFFFFFF999998FFF7FFFFFF899999998FFF8FFFFFF9
          999997FFF8FFF899999FFF88FFFF9999000099999999998FF8999FFFFF999FFF
          FF8999999999999998FFFF899999999999999988879999999998997888799999
          8FFF888889999998887999999999899788889999999999888888FFF999999997
          888899999999989988889999000099999999999999998FFFF9998FF899999999
          9999999998FFF899999999999999999999999999999999999999999998FF8999
          99999999999999999999999999999999999999999999FFF99999999999999999
          999999999999999900009999999999999999FFFF7999FFF99999999999999999
          98FF89999999989999999999999999999999999999999999998F899999999999
          999999999999999999999999999999999999FFF9999999999999999999999999
          9999999900009999999999999998FFF89998FFF9999999999999999998FF9999
          99998F9999999999999999999999999999999999999889999999999999999999
          9999999999999999999999999999FFF999999999999999999999999999999999
          0000999999999999999FFF89998FFF89999999999999999998FF99999999FF99
          9999999999999999999999999999999999999999999999999999999999999999
          99999999999999999999FFF99999999999999999999999999999999900009999
          99999999999FFF9999FFFF99999999999999999999FF89999998FF9999999999
          9999999999999999999999999999999999999999999999999999999999999999
          999999999999FFF9999999999999999999999999999999990000999999999999
          999FF9999FFFF8999999999999999999999FFF9997FFFF999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999FFF9999999999999999999999999999999990000999999999999999FF999
          FFFF8999999999999999999999998FFFFFFFF899999999999999999999999999
          999999999999999999999999999999999999999999999999999999999978FFF9
          9999999999999999999999999999999900009999999999999998F998FFFF9999
          9999999999999999999999988999999999999999999999999999999999999999
          999999999999999999999999999999999999999999999999998FFFF999999999
          99999999999999999999999900009999999999999999899FFFF7999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          999999999999999999999999999999999999999999998FF99999999999999999
          999999999999999900009999999999999999999FFF8999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999900009999999999999999999FFF999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          00009999999999999999999FF799999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999900009999
          999999999999999FF99999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999990000999999999999
          9999999889999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999000099999999999999999999
          8999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999900009999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999990000999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999000099999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          9999999999999999999999999999999999999999999999999999999999999999
          999999990000}
        Stretch = True
      end
      object QRShape60: TQRShape
        Left = 668
        Top = 549
        Width = 189
        Height = 2
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          1210.468750000000000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel120: TQRLabel
        Left = 670
        Top = 553
        Width = 79
        Height = 13
        Size.Values = (
          28.663194444444440000
          1477.256944444444000000
          1219.288194444444000000
          174.184027777777800000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(-) Outras Dedu'#231#245'es'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel121: TQRLabel
        Left = 672
        Top = 600
        Width = 90
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1322.916666666667000000
          198.437500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(+) Outros Acr'#233'scimos'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel122: TQRLabel
        Left = 170
        Top = 511
        Width = 32
        Height = 17
        Size.Values = (
          37.482638888888890000
          374.826388888888900000
          1126.684027777778000000
          70.555555555555560000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'COB.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblCobPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel123: TQRLabel
        Left = 687
        Top = 419
        Width = 159
        Height = 18
        Size.Values = (
          39.687500000000000000
          1514.739583333333000000
          923.836805555555700000
          350.572916666666700000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Data Vencimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblDtaVenPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel124: TQRLabel
        Left = 16
        Top = 479
        Width = 120
        Height = 18
        Size.Values = (
          39.687500000000000000
          34.395833333333300000
          1055.687500000000000000
          264.583333333333000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Data Movimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblDtaMovPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel125: TQRLabel
        Left = 160
        Top = 480
        Width = 164
        Height = 18
        Size.Values = (
          39.687500000000000000
          351.895833333333000000
          1058.333333333330000000
          362.479166666667000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblDocumentoPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel126: TQRLabel
        Left = 339
        Top = 479
        Width = 65
        Height = 18
        Size.Values = (
          39.687500000000000000
          747.447916666667000000
          1055.026041666670000000
          142.213541666667000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Esp. Doc.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblEspDocPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel127: TQRLabel
        Left = 477
        Top = 480
        Width = 169
        Height = 18
        Size.Values = (
          39.687500000000000000
          1051.718750000000000000
          1058.333333333330000000
          373.723958333333000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Processamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblDtaProcessPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel128: TQRLabel
        Left = 688
        Top = 450
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1516.944444444440000000
          992.187500000000000000
          352.777777777778000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'N. Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel128Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel129: TQRLabel
        Left = 688
        Top = 480
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1516.944444444440000000
          1058.333333333330000000
          352.777777777778000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Nosso Numero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel129Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel130: TQRLabel
        Left = 688
        Top = 511
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1516.944444444440000000
          1126.684027777780000000
          352.777777777778000000)
        XLColumn = 0
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblValorDocPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel131: TQRLabel
        Left = 754
        Top = 698
        Width = 68
        Height = 13
        Size.Values = (
          28.663194444444440000
          1662.465277777778000000
          1538.993055555556000000
          149.930555555555600000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nosso Numero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblNossoNumeroPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel133: TQRLabel
        Left = 818
        Top = 364
        Width = 19
        Height = 19
        Size.Values = (
          41.892361111111110000
          1803.576388888889000000
          802.569444444444400000
          41.892361111111110000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '"'
        Color = clWhite
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel134: TQRLabel
        Left = 454
        Top = 663
        Width = 212
        Height = 20
        Size.Values = (
          42.994791666666700000
          1002.109375000000000000
          1461.822916666670000000
          466.328125000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = InsSacPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel135: TQRLabel
        Left = 24
        Top = 578
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1273.307291666670000000
          1369.218750000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr4Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel136: TQRLabel
        Left = 24
        Top = 592
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1306.380208333330000000
          1369.218750000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr5Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel137: TQRLabel
        Left = 24
        Top = 608
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1339.453125000000000000
          1369.218750000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr6Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel138: TQRLabel
        Left = 24
        Top = 623
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1372.526041666670000000
          1369.218750000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr7Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel139: TQRLabel
        Left = 24
        Top = 637
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1405.598958333330000000
          1369.218750000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr8Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel140: TQRLabel
        Left = 51
        Top = 533
        Width = 594
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          1174.088541666670000000
          1309.687500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr1Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel141: TQRLabel
        Left = 24
        Top = 562
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1240.234375000000000000
          1369.218750000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr3Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel142: TQRLabel
        Left = 24
        Top = 547
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1207.161458333330000000
          1369.218750000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = lblInstr2Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel67: TQRLabel
        Left = 687
        Top = 12
        Width = 159
        Height = 23
        Size.Values = (
          50.711805555555560000
          1514.739583333333000000
          26.458333333333330000
          350.572916666666700000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Ficha de caixa'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel132: TQRLabel
        Left = 687
        Top = 383
        Width = 159
        Height = 22
        Size.Values = (
          48.506944444444440000
          1514.739583333333000000
          844.461805555555700000
          350.572916666666700000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Recibo do Sacado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel38: TQRLabel
        Left = 2
        Top = 534
        Width = 43
        Height = 13
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          1177.395833333333000000
          94.809027777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Instru'#231#245'es'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel143: TQRLabel
        Left = 707
        Top = 714
        Width = 53
        Height = 12
        Size.Values = (
          26.458333333333330000
          1558.836805555556000000
          1574.270833333333000000
          116.857638888888900000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Autentica'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel144: TQRLabel
        Left = 5
        Top = 440
        Width = 49
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          970.138888888888900000
          108.038194444444400000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Benefici'#225'rio'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel145: TQRLabel
        Left = 5
        Top = 836
        Width = 49
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1843.263888888889000000
          108.038194444444400000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Benefici'#225'rio'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel6: TQRLabel
        Left = 7
        Top = 657
        Width = 38
        Height = 13
        Size.Values = (
          28.663194444444440000
          15.434027777777780000
          1448.593750000000000000
          83.784722222222220000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Pagador:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
    end
  end
end
