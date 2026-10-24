object frmQckBradesco: TfrmQckBradesco
  Left = 102
  Top = 26
  Width = 990
  Height = 780
  AutoScroll = True
  Caption = 'frmqckBoletoBradesco'
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
    Top = 0
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
      Height = 1282
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        2826.631944444444000000
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
        Caption = '237-2'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
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
        Top = 201
        Width = 55
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          443.177083333333300000
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
        Top = 253
        Width = 71
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          557.829861111111100000
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
        Top = 198
        Width = 189
        Height = 2
        Size.Values = (
          4.409722222222222000
          1472.847222222222000000
          436.562500000000000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 668
        Top = 218
        Width = 189
        Height = 6
        Size.Values = (
          13.229166666666670000
          1472.847222222222000000
          480.659722222222200000
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
          'EM QUALQUER AG'#202'NCIA, AP'#211'S O VENCTO NAS AG. DO BRADESCO OU DE ACO' +
          'RDO COM AS INSTRU'#199#213'ES DA FICHA DE COMPENSA'#199#195'O'
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
        Top = 36
        Width = 292
        Height = 11
        Size.Values = (
          23.151041666666700000
          499.401041666667000000
          79.375000000000000000
          644.921875000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pag'#225'vel preferencialmente na Rede Bradesco ou Bradesco Expresso'
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
        Top = 247
        Width = 187
        Height = 6
        Size.Values = (
          13.229166666666670000
          1472.847222222222000000
          544.600694444444400000
          412.309027777777800000)
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
      object QRLabel40: TQRLabel
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
        OnPrint = QRLabel40Print
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
      object QRLabel42: TQRLabel
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
        OnPrint = QRLabel42Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel3: TQRLabel
        Left = 633
        Top = 1173
        Width = 180
        Height = 27
        Size.Values = (
          59.531250000000000000
          1395.677083333333000000
          2586.302083333333000000
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
        Top = 806
        Width = 853
        Height = 6
        Size.Values = (
          13.229166666666700000
          6.614583333333330000
          1777.118055555560000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRImage2: TQRImage
        Left = 7
        Top = 3
        Width = 151
        Height = 30
        Size.Values = (
          66.145833333333300000
          15.434027777777800000
          6.614583333333330000
          332.934027777778000000)
        XLColumn = 0
        Picture.Data = {
          07544269746D617066480000424D66480000000000003600000028000000B000
          0000230000000100180000000000304800000000000000000000000000000000
          00008C91EC4042E04A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE3
          4A4BE34A4BE34A4BE33B3FE0A8ABF1E7EBFA4A4BE3BEC2F4FCFCFCF1F3FB5458
          E44A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A
          4BE34A4BE34A4BE39FA3EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          DFDFDE9A98989896959A98989A98989A98989A98989A98989A98989A98989190
          8E9A9897B8B7B6D4D2D2F2F2F2FFFFFFFFFFFFFFFFFFFFFFFFA4A2A181807F81
          807F807E7C81807F8C8B8AEFEFEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D9D8D8A4A2A17C7A796A69676462616866657A7877A8A7A6E7E7E6CCCBCA807E
          7C807E7C81807F7C7A79A8A7A6F1F1F1FFFFFFFFFFFFFFFFFFEDECECBAB9B88F
          8E8D757372686665706E6D8C8B8AB3B2B1E5E4E3F2F2F2989695807E7C807E7C
          807E7C868483E5E4E3F3F3F3F3F3F3F3F3F3F3F3F3F1F1F1BFBEBD9896957A78
          776C6A696A69676A69676C6A69706E6D7C7A79959392B3B2B1EFEFEEFFFFFFFF
          FFFFAEADAC8684837876756866656A69676C6A696A69676866657876758A8887
          AEADACE5E4E3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCDCDBB8B7B68C8B
          8A706E6D6866656C6A696866656C6A697876758C8B8AD7D6D5F3F3F3F3F3F3F3
          F3F3E5E4E3B3B2B191908E7876756C6A696A69676C6A69706E6D7A7877959392
          C2C0C0EDECECFFFFFFFFFFFFFFFFFFFFFFFF676CE70D07D81511D91913DA1913
          DA1913DA1913DA1913DA1913DA1913DA1913DA1913DA1511D90D07D8918EECDC
          E2F91511D9A8ABF1FDFDFDEEEFFA2925DD120CD91913DA1913DA1913DA1913DA
          1913DA1913DA1913DA1913DA1913DA1913DA1913DA1511D98A89E9FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7D6D559575656545357555457555457
          55545755545755545755545755545A58575957565452515B59598C8B8AEDECEC
          FFFFFFFFFFFFFFFFFF8C8B8A575554575554565453575554706E6DFAF9F9FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E86C6A695351505755545A58575B59585A
          585759575652504F868483A8A7A64F4D4C5755545654534F4D4C9F9E9DFDFDFD
          FFFFFFFFFFFFF8F7F79593925957565957565B59585C5A595A58575957565654
          53868483EDECEC9593925351505755545452515E5B5AE5E4E3FFFFFFFFFFFFFF
          FFFFFCFCFCB3B2B15654535654535957565A58575B59585B59585B59585A5857
          5957565452515F5D5CE7E7E6FFFFFFFEFEFE8A88875654535957565A58575B59
          585B59585B59585A5857595756575554545251959392FDFDFDFFFFFFFFFFFFFF
          FFFFFEFEFED1D0CF68666552504F5755545957565B59585B59585B59585A5857
          5755545E5B5AC7C6C5FFFFFFFFFFFFDFDFDE706E6D5654535654535957565A58
          575B59585B59585A585759575656545354525181807FE5E4E3FFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB0D07D89392EEDCE2F91A18DBA8ABF1FEFEFEEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585B59585B59585B59585B59585B59585B59
          585B59585B59585A5857565453706E6DE5E4E3FFFFFFFFFFFF8A88875B59585B
          59585B59585B595872706FEFEFEEFFFFFFFFFFFFFFFFFFFFFFFFF2F2F28C8B8A
          52504F5B59585B59585B59585B59585A58575A58575B5958595756605E5D5B59
          585B59585B5958565453BFBEBDFFFFFFFFFFFFF2F2F2A4A2A15452515B59585B
          59585B59585B59585B59585B59585B59585957568684837C7A795957565B5958
          59575662605FDFDFDEF3F3F3F3F3F3F2F2F2B3B2B15957565A58575B59585B59
          585B59585A58575957565957565957565B595859575662605FE1E0E0FFFFFFFF
          FFFF8C8B8A5755545B59585A58575957565957565957565B59585B59585B5958
          5957565B5958D7D6D5FFFFFFFFFFFFFFFFFFD0CECD5C5A595654535B59585B59
          585B59585B59585B59585B59585B59585957565F5D5CCCCBCAF3F3F3DFDFDE62
          605F5452515B59585B59585B59585B59585A58575B59585B59585B59585B5958
          5A5857545251706E6DE5E4E3FFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB0D07D89392EEDC
          E2F91B1ADCA8ABF1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585B
          59585A58575B59585B59585A58575A58575B59585B59585B59585B5958565453
          8A8887FDFDFDFFFFFF8C8B8A5B59585B59585B59585B5958757372FAF9F9FFFF
          FFFFFFFFFFFFFFFFFFFFE5E4E3605E5D5957565B59585B59585B59585A58575F
          5D5C605E5D5957565957565A58575B59585B59585B59585C5A59BCBBBAFFFFFF
          FFFFFFD9D8D85C5A595B59585B59585B59585B59585A58575755545654535957
          565B59585957565A58575B59585B595859575662605FE5E4E3FFFFFFFFFFFFDC
          DCDB5E5B5A5957565B59585B59585A58575452515E5B5A64626164626162605F
          595756535150605E5DE7E7E6FFFFFFFAF9F98A88875351505452515E5B5A6462
          616462615F5D5C5755545B59585B59585B59585452518C8B8AFCFCFBFFFFFFED
          ECEC6462615654535B59585B59585B59585B5958595756535150545251535150
          5452515E5B5AD7D6D5F6F5F572706F5452515B59585B59585B59585A59585654
          535C5A595C5A595755545B59585B59585B59585B59585351508A8887FAF9F9FF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB0D07D89392EEDCE2F91A18DBA8ABF1FEFEFEEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585E5B5A7573727876757876757876755A58
          575957565B59585B59585B59585B5958575554D7D6D5FFFFFF8684835B59595B
          59585B59585B595872706FEFEFEEFFFFFFFFFFFFFFFFFFFFFFFFBCBBBA5E5B5A
          5A58575B59585B5958595756868483C9C8C8C9C8C8BAB9B881807F5957565B59
          585B59585B59585B5958B3B2B1FFFFFFF3F2F29593925755545B59585B59585B
          595859575659575686848386848362605F5957565B59585B59585B59585B5958
          59575662605FE1E0E0F3F3F3EFEFEE807E7C5452515B59585B59585957565B59
          5891908EC7C6C5DFDFDEE1E0E0D9D8D8B3B2B17C7A79646261DFDFDEFFFFFFFF
          FFFF91908E605E5D989695C4C4C3DFDFDEE1E0E0D7D6D58684835654535B5958
          5B5958595756686665EFEFEEFFFFFF9896954F4D4C5C5A595B59585B59585C5A
          595452516462619A9897A8A7A69F9E9D807E7C646261D0CECDBFBEBD5452515B
          59585A58575B59585B5958595756868483D0CECDC7C6C5706E6D5654535B5958
          5B59585B59585B5958575554C7C6C5FFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB0D07D89392EEDC
          E2F91B1ADCA8ABF1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585A585768
          6665E9E9E8FCFCFCFCFCFCFAF9F9D7D6D56C6A695957565B59585B59585C5A59
          545251BFBEBDFFFFFF8C8B8A5B59585B59585B59585B5958757372FAF9F9FFFF
          FFFFFFFFFFFFFFFFFFFFBFBEBD5E5B5A5A58575B59585A58575F5D5CD0CECDFF
          FFFFFFFFFFFFFFFFF3F3F39593925957565B59585B59585B5958BAB9B8FFFFFF
          EFEFEE6866655A58575B59585B5958595756646261C2C0C0FAF9F9FAF9F9DCDC
          DB72706F5755545B59585B59585B595859575662605FE7E7E6FFFFFFD7D6D55E
          5B5A5A58575B59585A5857595756B3B2B1FAF9F9FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFF8F7F7C7C6C5F1F1F1FFFFFFFEFEFEE1E0E0E5E4E3FCFCFCFFFFFFFFFF
          FFFFFFFFFFFFFFDCDCDB5A58575A58575B5958595756646261EFEFEEEDECEC62
          605F5957565B59585B59585B5958595756959392DFDFDEFCFCFCFEFEFEFDFDFD
          F8F7F7D9D8D8E9E9E89F9E9D5452515B59585A58575B59585A58579A9897F8F7
          F7FFFFFFFFFFFFE9E9E88684835452515B59585B59585B595852504FAEADACFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB0D07D89392EEDCE2F91A18DBA8ABF1FEFEFEEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A5857646261E7E7E6FFFFFFFFFFFFFFFFFFFFFF
          FFC9C8C85755545B59585B59585B595859575691908EFFFFFF8C8B8A5B59585B
          59585B59585B595872706FEFEFEEFFFFFFFFFFFFFFFFFFFFFFFFBAB9B85E5B5A
          5A58575B5958595756646261E1E0E0F3F3F3F3F3F3F3F3F3F3F3F3BFBEBD5957
          565B59585B59585B5958B3B2B1FFFFFFCCCBCA5755545B59585B59585B595854
          5251B3B2B1F1F1F1FFFFFFFFFFFFFFFFFFD9D8D8605E5D5957565B59585B5958
          59575662605FE1E0E0F3F3F3AEADAC5452515B59585B5958565453807E7CFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDECECA8A7A65B59585B5958
          5B5958595756646261E5E4E3C9C8C85755545B59585B59585B59585755547876
          75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F17573725957565B
          59585B5958595756686665E5E4E3F2F2F2FFFFFFFFFFFFFFFFFFD7D6D55C5A59
          5A58575B59585B5958565453868483FFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB0D07D8918EECDC
          E2F91B1ADCA8ABF1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585A585764
          6261EFEFEEFFFFFFFFFFFFFFFFFFFFFFFFEDECEC62605F5A58575B59585B5958
          595756959392FFFFFF91908E5B59585B59585B59585B5958757372FAF9F9FFFF
          FFFFFFFFFFFFFFFFFFFFD7D6D55F5D5C5A58575B59585A5857595756CCCBCAFF
          FFFFFFFFFFFFFFFFFFFFFFC9C8C85B59585B59585B59585A5857BFBEBDFFFFFF
          C4C4C35351505B59585B59585A58575A5958DCDCDBFFFFFFFFFFFFFFFFFFFFFF
          FFFEFEFE9593925452515B59585B5958595756646261E5E4E3FFFFFF807E7C56
          54535B59585B59585452518F8E8DD4D2D2D1D0CFD4D2D2D1D0CFD1D0CFD1D0CF
          D1D0CFD4D2D2D4D2D2D0CECDE5E4E3FEFEFEFFFFFFFFFFFFFFFFFFFAF9F9D9D8
          D8AEADAC7C7A795F5D5C5B59585B59585B59585A58576A6967F6F5F5A8A7A652
          504F5B59585B59585B5958535150B3B2B1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF8F7F7706E6D5A58575B59585B59585452518C8B8AFDFDFDFFFF
          FFFFFFFFFFFFFFFFFFFFFAF9F97573725957565B59585B5958595756757372FF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1913DA
          1D1BDB1C18DB1C18DB0D07D89FA3EEEEEFFA1B1ADCA8ABF1FDFDFDEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1511D91913DA1D19DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A5857646261E5E4E3FFFFFFFFFFFFFFFFFFFFFF
          FFE5E4E3605E5D5A58575B59585B5958595756959392F3F3F38C8B8A5B59585B
          59585B59585B5958757372FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDECEC706E6D
          5654535B59585B59585957567A7877BAB9B8CCCBCACCCBCAD1D0CFA4A2A15654
          535B59585B59585A5857B8B7B6FFFFFF9A98985957565B59585B59585A58575E
          5B5AD7D6D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0CECD5957565A58575B5958
          595756646261DCDCDBF3F3F37573725957565B59585B59585B59585C5A59605E
          5D605E5D605E5D605E5D605E5D605E5D605E5D605E5D605E5D5957569A9898F2
          F2F2FFFFFFF2F2F2D7D6D581807F5F5D5C5755545755545B59585B59585B5958
          5B59585351508F8E8DEDECEC8A88875452515B59585B59585B5958595756D0CE
          CDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E4E36462615957565B
          59585B595852504FBCBBBAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F091908E
          5452515B59585B59585B5958757372E5E4E36E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1A18DB5D63E63333DE1913DA1D18DB1511D95458E476
          79E91913DAADB1F1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB211EDC
          4D51E31A18DB1511D91C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585A585764
          6261F0F0EFFFFFFFFFFFFFFFFFFFFFFFFFD0CECD5755545B59585B59585B5958
          535150C7C6C5FFFFFF8C8B8A5B59585B59585B59585A58576C6A69F0F0F0FFFF
          FFFFFFFFFFFFFFFFFFFFFEFEFED0CECD5957565957565B59585B59585957565E
          5B5A605E5D605E5D605E5D5E5B5A5A58575B59585B59585A5857BFBEBDFFFFFF
          91908E5957565B59585B5958595756605E5DE5E4E3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFDCDCDB5E5B5A5A58575B59585A5857646261E1E0E0FFFFFF7573725B
          59585B59585B59585B59585B59585957565A58575A58575A58575A58575A5857
          5A58575A58575A585752504F9A9897FDFDFDFDFDFDBFBEBD605E5D5654535957
          565B59585B59585B59585B59585B59585957565E5B5AE5E4E3FFFFFF86848356
          54535B59585B59585A58575F5D5CD9D8D8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFE5E4E36462615957565B59585B59585B5958C9C8C8FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFDFDFD9F9E9D52504F5B59585B59585B59586A6967E5
          E4E36E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB120CD94A4BE36E74E9
          1913DA1C18DB1C18DB1D19DB1511D90D07D81913DAADB1F1FCFCFCEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1913DA676CE7B4BAF24042E00D07D81913DA1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A5857646261DFDFDEF0F0F0F0F0F0EFEFEED0CE
          CD6C6A695957565B59585B5958595756605E5DE7E7E6FFFFFF8684835B59585B
          59585B5958595756605E5DD4D2D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F2
          BAB9B85F5D5C5351505957565755545957565957565957565654535957565B59
          585B59585B59585A5857B8B7B6FFFFFF8F8E8D5957565B59585B59585A58575F
          5D5CDCDCDBF3F2F2FFFFFFFFFFFFFFFFFFFFFFFFD4D2D25C5A595B59585B5958
          595756646261DCDCDBF3F3F36C6A695B59585B59585B59585C5A595755545250
          4F52504F52504F52504F52504F5452515B59585B59585C5A59535150B3B2B1FF
          FFFFD4D2D25B59585755545B59585B59585B5958595756575554575554545251
          595756AEADACF3F3F3FFFFFF8684835654535B59585B59585A58575E5B5AD1D0
          CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1E0E062605F5957565B
          59585B5958565453C2C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F19A9897
          5351505B59585B59585B5958686665E1E0E06E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1913DA2925DD8C91EC2925DD1913DA1C18DB1C18DB1C18DB1C18DB1C
          18DB1511D9ADB1F1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB1C18DB
          120CD96E74E9D1D7F78084EB211EDC1913DA1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585F
          5D5C7573727876757C7A797C7A795A58575957565C5A59595756575554787675
          C9C8C8FFFFFFFFFFFF8C8B8A5B59585B59585B59585B5958545251C4C4C3FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCDCDBB3B2B191908E7C7A7970
          6E6D706E6D706E6D7876756C6A695A58575B59585B59585A5857C2C0C0FFFFFF
          81807F5654535B59585B59585A58575E5B5AE5E4E3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFC9C8C85452515B59585B5958595756646261E5E4E3FFFFFF78767559
          57565B59585B59585755548C8B8ABAB9B8B3B2B1B3B2B1B3B2B1B3B2B1989695
          5C5A595B59585B59585B5958C9C8C8FFFFFFA4A2A15452515B59585B59585A58
          5759575662605F7876758A8887A8A7A6C7C6C5FCFCFBFFFFFFFCFCFC98969554
          52515B59585B59585B5958545251C2C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFE9E9E86A69675A58575B59585B59585351509F9E9DFEFEFEFFFF
          FFFFFFFFFFFFFFFFFFFFFAF9F9807E7C5755545B59585B5958595756706E6DE9
          E9E86E74E9120CD91C18DB1C18DB1C18DB1C18DB120CD99FA3EEA8ABF10D07D8
          1C19DB1C18DB1C18DB1C18DB1C18DB1C18DB1511D9B4BAF2FCFCFCF9F9FC2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1C18DB0D07D85458E4FDFDFDBEC2F41B
          1ADC1913DA1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585B59585A58575B59585B59585A58575A58
          575B595859575672706FCCCBCAEDECECFFFFFFFFFFFFFFFFFF8C8B8A5B59585B
          59585B59585B5958595756686665E5E4E3F2F2F2F3F3F3F3F3F3F3F3F3F3F3F3
          F3F3F3F3F3F3F3F3F3F3F3F3EFEFEEEDECECEDECECEDECECF0F0F0B3B2B15654
          535B59585B59585C5A59BCBBBAFFFFFFAEADAC52504F5B59585B59585B595954
          5251D1D0CFFFFFFFFFFFFFFFFFFFFFFFFFEDECEC7A78775957565B59585B5958
          595756646261E1E0E0F3F3F39F9E9D52504F5B59585B5958545251989695F3F3
          F3F3F3F3F3F3F3F3F3F3F3F3F3CCCBCA5957565B595859575662605FD9D8D8E7
          E7E66866655A58575B59585A58575E5B5A9F9E9DDFDFDEEDECECF1F1F1FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFC2C0C05957565B59585B59585B59585755547C7A
          79F1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F17573725957565B
          59585B595859575662605FE9E9E8FFFFFFFFFFFFFFFFFFFFFFFFD4D2D25E5B5A
          5A58575B59585B59585755548C8B8AF3F3F36E74E9120CD91C18DB1C18DB1C18
          DB1913DA3333DEF1F3FB676CE7120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1913DA8084EBB4BAF2ADB1F12925DD1913DA1C18DB1C18DB1C18DB1C18DB
          1D19DB1913DA1511D9BEC2F4FAFDFD8084EB120CD91C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585B
          59585A58575A58575A58575B59585B59585B5958595756686665C9C8C8FEFEFE
          FFFFFFFFFFFFFFFFFF91908E5B59585B59585B59585B59585B59585957566A69
          67BFBEBDD1D0CFD0CECDD4D2D2FFFFFFE7E7E6D7D6D5FAF9F9FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFAF9F981807F5957565B59585A58575F5D5CC9C8C8FFFFFF
          CCCBCA5E5B5A5A58575B59585B5958595756757372E7E7E6FFFFFFFFFFFFF1F1
          F1A8A7A65755545B59585B59585B595859575662605FE7E7E6FFFFFFD0CECD57
          55545B59585B59585A5857646261EDECECFFFFFFFFFFFFFFFFFFFDFDFD8F8E8D
          5452515B5958595756706E6DFFFFFFFFFFFF62605F5957565B59585957567270
          6FF6F5F5FFFFFFFFFFFFFFFFFFFFFFFFFCFCFCE5E4E3FDFDFDFFFFFFE9E9E864
          62615957565B59585B59585B5958595756A4A2A1EDECECFCFCFCFEFEFEFCFCFB
          E5E4E3CCCBCAFCFCFB9F9E9D5351505B59585B59585B59585654539A9897FFFF
          FFFFFFFFFFFFFFE9E9E88684835452515B59585B59585B5958565453A4A2A1FF
          FFFF6E74E9120CD91C18DB1C18DB1C19DB0D07D87679E9FAFDFD3333DE1913DA
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1A18DB1A18DB1A18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB0D07D88084EBFEFEFED1
          D7F7211EDC1913DA8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585B595857555454525154525152504F5957
          565B59585B5958595756545251A4A2A1FFFFFFFFFFFFFFFFFF8C8B8A5B59585B
          59585B59585B59585B59585B5958595756595756605E5D5A5857868483F3F3F3
          CCCBCA64626181807FB3B2B1D1D0CFE5E4E3DCDCDBBAB9B88C8B8A5957565B59
          585B5958595756646261E5E4E3FFFFFFEFEFEE6C6A695755545B59585B59585B
          595859575662605F7A7877807E7C72706F5755545B59585B59585B59585B5958
          59575662605FDFDFDEF3F3F3EFEFEE706E6D5654535B59585B59585755548A88
          87D4D2D2F1F1F1DFDFDEA8A7A65B59585A58575B5958545251A8A7A6FFFFFFFF
          FFFF7C7A795957565B59585A5857605E5D9F9E9DD1D0CFE5E4E3D9D8D8BFBEBD
          91908E807E7CEFEFEEFFFFFFF2F2F29593925351505B59585B59585B59585A58
          57595756706E6D9A9898A4A2A1959392646261868483F3F3F3C2C0C05452515B
          59585B59585B59585C5A595755547C7A79C9C8C8C7C6C5706E6D5755545B5958
          5B59585B59585B5958595756D0CECDF3F3F36E74E9120CD91C18DB1C18DB1A18
          DB1511D9B4BAF2E7EBFA211EDC1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1D19DB1913DA1C18DB1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB0D07D87679E9FDFDFDF7F8FD3B3FE01511D99392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585A
          5857A4A2A1BFBEBDBFBEBDA4A2A16462615755545B59585B59585B5958535150
          D0CECDFFFFFFFFFFFF8F8E8D5B59585B59585B59585A5857605E5D5B59585B59
          585B59585A58575452518A8887FFFFFFD4D2D25F5D5C5452515B5958605E5D64
          626162605F5C5A595957565B59585B59585B5958545251959392FEFEFEFFFFFF
          FFFFFFBAB9B85351505B59585B59585B59585B59585A58575957565755545B59
          585B59585957565B59585B59585B595859575662605FE5E4E3FFFFFFFFFFFFC7
          C6C552504F5A58575B59585B595857555462605F8C8B8A706E6D5A5857595756
          5B5958595756646261E9E9E8FFFFFFFFFFFF9896955351505B59585B59585A58
          57595756605E5D64626162605F5E5B5A52504F72706FFAF9F9FFFFFFFFFFFFEF
          EFEE62605F5654535B59585B59585B59585B5958575554545251565453545251
          5957567C7A79FFFFFFF2F2F27C7A795654535B59585B59585B59585B59585654
          535C5A595C5A595755545B59585B59585B59585C5A5952504F8C8B8AFCFCFBFF
          FFFF6E74E9120CD91C18DB1C18DB1913DA1F1CDBD1D7F7D1D7F7211EDC1913DA
          1C19DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB120CD99FA3EEFDFDFDF7
          F8FD4A4BE31511D98A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A5857595756D7D6D5FFFFFFFFFFFFFFFFFFC4C4
          C35957565A58575B59585B5958595756807E7CF1F1F1FFFFFF8A88875B59585B
          59585B5958565453B8B7B68684835957565B59585B59585957567C7A79F3F3F3
          CCCBCA5F5D5C5A58575B59585957565957565957565A58575B59585B59585B59
          585A5857545251D9D8D8FFFFFFFFFFFFFFFFFFEDECEC7C7A795654535B59585B
          59585B59585B59585B59585B59585B59585957566462615E5B5A5B59585B5958
          59575662605FDFDFDEFFFFFFFFFFFFF2F2F28F8E8D5654535B59585B59585B59
          585A58575957565957565B59585B5958595756565453BCBBBAFFFFFFFFFFFFFF
          FFFFE5E4E3605E5D5654535B59585B59585B59585957565957565957565A5857
          5A5857757372F2F2F2FFFFFFFFFFFFFFFFFFD1D0CF5C5A595654535B59585B59
          585B59585B59585B59585B59585B59585957566C6A69E9E9E8F3F3F3E1E0E080
          7E7C5755545B59585B59585C5A595B59585A59585B59585B59585B59585B5958
          5A585752504F787675E9E9E8FFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1913
          DA2925DDEEEFFAD1D7F7211EDC1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1511D93333DEE7EBFAFDFDFDF1F3FB3333DE1913DA9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585A58575A
          5857D1D0CFFFFFFFFFFFFFFFFFFFFFFFFF7C7A795452515B59585B59585A5857
          6A6967F3F3F3FFFFFF8A8887595756595756595756545251D1D0CFE5E4E35C5A
          595957565B595859575691908EFFFFFFC2C0C05957565452515A58575A58575B
          59585B59585B59585A58575A585757555453515091908EFCFCFCFFFFFFFFFFFF
          FFFFFFFFFFFFEDECEC7573725654535A58575B59585B59585A58575A58575250
          4F81807FC4C4C3605E5D5A58575B595859575662605FE5E4E3FFFFFFFFFFFFFF
          FFFFF6F5F59593925957565957565A58575B59585C5A595B59585A5857595756
          5C5A59AEADACFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFD1D0CF62605F5654535A58
          575B59585B59585B59585B59585A585756545362605FF3F3F3FFFFFFFFFFFFFF
          FFFFFFFFFFD4D2D26C6A695654535755545A58575B59585B59585B59585A5857
          5755545E5B5AE5E4E3FFFFFFFFFFFFE7E7E67573725654535755545A58575A58
          575B59585B59585A58575A5857565453545251868483EDECECFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1913DA2925DDF7F8FDDCE2F91F1CDB1913DA
          1D19DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1913DA1A18DBADB1F1FEFEFEFDFDFDB4
          BAF21913DA1A18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585957565A5857D1D0CFFFFFFFFFFFFFFFFFFFFFFF
          FF81807F5452515B59585B59585A58575E5B5AD4D2D2FFFFFF81807F62605F62
          605F62605F62605FA8A7A6F3F3F3C9C8C86C6A695B59585A585781807FF3F2F2
          E7E7E6B3B2B17C7A795E5B5A5F5D5C5B59585B59585B59585E5B5A5E5B5A7573
          72AEADACEDECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7D6D58684835E
          5B5A5B59585B59585E5B5A5C5A59989695E5E4E3D9D8D85C5A595A58575B5958
          59575662605FDFDFDEFFFFFFFFFFFFFFFFFFFFFFFFE7E7E69A98976866655E5B
          5A5C5A595B59585B59585E5B5A5F5D5CB8B7B6F0F0EFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFD4D2D2706E6D5E5B5A5C5A595B59585B59585C5A595F5D5C
          5F5D5C959392EDECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDEA4A2A16C6A
          695E5B5A5C5A595B59585B59585E5B5A605E5D8F8E8DE5E4E3FFFFFFFFFFFFFF
          FFFFE5E4E3AEADAC72706F5E5B5A5E5B5A5B59585B59585E5B5A5F5D5C7C7A79
          BFBEBDEDECECFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1913
          DA2925DDE7EBFAF7F8FD3333DE1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1511D9
          1B1ADCA8ABF1FDFDFDFEFEFEF1F3FB4A4BE3120CD91C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B595859575659
          5756D7D6D5FFFFFFFFFFFFFFFFFFD9D8D85C5A595A58575B59585B59585A5857
          5E5B5ADCDCDBFFFFFFEFEFEEE5E4E3E5E4E3E5E4E3E5E4E3F3F3F2FFFFFFFFFF
          FFEDECECBFBEBDBCBBBADCDCDBFEFEFEFFFFFFFFFFFFFAF9F9DFDFDED1D0CFC2
          C0C0BCBBBABAB9B8BCBBBAD4D2D2F6F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF8F7F7D1D0CFBAB9B8BCBBBAC4C4C3DCDCDBFCFC
          FCFFFFFFD7D6D55E5B5A5A58575B595859575662605FE5E4E3FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFE7E7E6D0CECDBAB9B8BCBBBABFBEBDCCCBCAE1E0E0
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDECECD7D6
          D5BCBBBABCBBBABCBBBAD0CECDD4D2D2E5E4E3FCFCFBFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E8CCCBCAC2C0C0BAB9B8BFBEBDC4C4C3
          E1E0E0FAF9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F5F5D4D2D2BFBE
          BDAEADACBCBBBAC2C0C0DCDCDBF8F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1913DA1F1CDBD1D7F7FCFCFC5D63E6120CD9
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB120CD91913DAA8ABF1FEFEFEFDFDFDFDFDFD6E74E912
          0CD91C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A58575A5857A4A2A1BFBEBDBFBEBDAEADAC6C6A
          695755545B59585B59585B59585A5857686665E9E9E8FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0CECD5E5B5A5A58575B5958
          59575662605FDFDFDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91F1CDB120CD91913
          DA120CD9ADB1F1FEFEFE9392EE120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB1C18DB1913DA1913DA1511D90D07D81913DA5458E4BEC2F4
          FDFDFDFEFEFEE7EBFA676CE7120CD91C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585B
          595857555454525154525152504F5755545C5A595B59585B59585B5958575554
          8A8887FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFD9D8D85E5B5A5A58575B595859575662605FE5E4E3FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD95D63E6676CE73B3FE01D19DB6E74E9FEFEFEBEC2F41511D9
          0D07D8120CD91511D9120CD9120CD9120CD9120CD90D07D81511D91C18DB1F1C
          DB3333DE6E74E9BEC2F4FCFCFCFCFCFCF7F8FDB4BAF24042E0120CD91A18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585B59585A58575A58575A58575B59585B59
          585B59585B59585B5958595756565453D0CECDFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD1D0CF5E5B5A5B59585B5958
          59575662605FDFDFDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD92925DD4A4BE3676C
          E78C91ECB4BAF2FAFDFDF7F8FD8C91EC5D63E65458E45458E45458E45458E45D
          63E66E74E99392EEA8ABF1B4BAF2DCE2F9FCFCFCFCFCFCF9F9FCD1D7F78A89E9
          4A4BE31913DA1511D91C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7D6D55E5B5A5957565A58575A58575A
          58575A58575A58575A58575A5857595756595756595756575554807E7CE5E4E3
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFD7D6D55C5A595957565A5857595756605E5DE5E4E3FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1511D9120CD91C19DB3333DE8A89E9FAFDFDFDFDFD
          FAFDFDF1F3FBFAFDFDFDFDFDFCFCFCFCFCFCFCFCFCFCFCFCFDFDFDFDFDFDDCE2
          F9ADB1F18084EB4042E01D1BDC0D07D81511D91913DA1D19DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          BAB9B862605F5F5D5C605E5D605E5D605E5D605E5D605E5D605E5D605E5D605E
          5D605E5D8C8B8ABFBEBDE9E9E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBAB9B862605F605E5D605E5D
          5E5B5A686665DFDFDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1D19
          DB1913DA1511D9120CD9B4BAF2FDFDFDE7EBFA6E74E94A4BE3676CE76E74E96E
          74E96E74E95D63E64A4BE33333DE211EDC1511D90D07D81511D91913DA1511D9
          1C19DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDECECD4D2D2D1D0CFD4D2D2D1D0CFD4
          D2D2D1D0CFD4D2D2D1D0CFD1D0CFDCDCDBE7E7E6FAF9F9FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFEDECECD4D2D2D4D2D2D1D0CFD1D0CFD4D2D2F8F7F7FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB120CD94A4BE3FDFDFD
          FDFDFDD1D7F74D51E30D07D80D07D80D07D8120CD9120CD91511D91511D91913
          DA1C18DB1C18DB1511D90D07D84A4BE34042E01913DA1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1511D98A89E9FEFEFEFDFDFDFEFEFE9FA3EE4042E015
          11D90D07D81511D91511D91511D91511D90D07D8120CD93333DE9FA3EE9392EE
          211EDC1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1913DA1511D9
          676CE7E7EBFAFEFEFEFDFDFDF7F8FDB4BAF27679E94A4BE33B3FE03B3FE04D51
          E36E74E9ADB1F1E7EBFA9392EE211EDC1913DA1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1A18DB120CD93333DE9FA3EEE7EBFAFEFEFEFE
          FEFEFDFDFDFCFCFCFAFDFDFDFDFDFDFDFDFEFEFEBEC2F44D51E3120CD91913DA
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1511D9120CD93333DE6E74E99FA3EEBEC2F4D1D7F7D1D7F7ADB1F18084
          EB4042E01913DA120CD91C19DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1D18DB1C18DB1913DA0D07D815
          11D91C19DB211EDC1D1BDB1511D9120CD9120CD91C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1D18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91A18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1913DA1913DA1913DA1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1D18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF676CE70D07D8120CD9120CD9120C
          D9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD912
          0CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9
          120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD98084EBFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFA8ABF1676CE76E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E9
          6E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74
          E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E
          74E96E74E96E74E9ADB1F1F3F3F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Stretch = True
      end
      object QRShape13: TQRShape
        Left = 668
        Top = 176
        Width = 189
        Height = 2
        Size.Values = (
          4.409722222222222000
          1472.847222222222000000
          388.055555555555600000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel4: TQRLabel
        Left = 671
        Top = 180
        Width = 79
        Height = 13
        Size.Values = (
          28.663194444444440000
          1479.461805555556000000
          396.875000000000000000
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
        Top = 222
        Width = 90
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          489.479166666666700000
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
      object QRLabel6: TQRLabel
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
        OnPrint = QRLabel6Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel50: TQRLabel
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
        OnPrint = QRLabel50Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel51: TQRLabel
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
        OnPrint = QRLabel51Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel56: TQRLabel
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
        OnPrint = QRLabel56Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel54: TQRLabel
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
        OnPrint = QRLabel54Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel57: TQRLabel
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
        OnPrint = QRLabel57Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel58: TQRLabel
        Left = 675
        Top = 79
        Width = 176
        Height = 17
        Size.Values = (
          37.482638888888900000
          1488.281250000000000000
          174.184027777778000000
          388.055555555556000000)
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
        OnPrint = QRLabel58Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel59: TQRLabel
        Left = 675
        Top = 107
        Width = 176
        Height = 17
        Size.Values = (
          37.482638888888900000
          1488.281250000000000000
          235.920138888889000000
          388.055555555556000000)
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
        OnPrint = QRLabel59Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel60: TQRLabel
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
        OnPrint = QRLabel60Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel61: TQRLabel
        Left = 52
        Top = 200
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          114.652777777778000000
          440.972222222222000000
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
        OnPrint = QRLabel61Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel62: TQRLabel
        Left = 52
        Top = 213
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          114.652777777778000000
          469.635416666667000000
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
        OnPrint = QRLabel62Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel63: TQRLabel
        Left = 52
        Top = 228
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          114.652777777778000000
          502.708333333333000000
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
        OnPrint = QRLabel63Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel64: TQRLabel
        Left = 52
        Top = 241
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          114.652777777778000000
          531.371527777778000000
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
        OnPrint = QRLabel64Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel65: TQRLabel
        Left = 52
        Top = 255
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          114.652777777778000000
          562.239583333333000000
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
        OnPrint = QRLabel65Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel66: TQRLabel
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
        OnPrint = QRLabel66Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel68: TQRLabel
        Left = 32
        Top = 1164
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555560000
          70.555555555555560000
          2566.458333333333000000
          1221.493055555556000000)
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
        Top = 1101
        Width = 853
        Height = 2
        Size.Values = (
          4.409722222222220000
          6.614583333333330000
          2427.552083333330000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape11: TQRShape
        Left = 3
        Top = 972
        Width = 853
        Height = 2
        Size.Values = (
          4.409722222222220000
          6.614583333333330000
          2143.125000000000000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape14: TQRShape
        Left = 3
        Top = 942
        Width = 853
        Height = 2
        Size.Values = (
          4.409722222222220000
          6.614583333333330000
          2076.979166666670000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape15: TQRShape
        Left = 3
        Top = 912
        Width = 853
        Height = 2
        Size.Values = (
          4.409722222222220000
          6.614583333333330000
          2010.833333333330000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape18: TQRShape
        Left = 3
        Top = 843
        Width = 853
        Height = 14
        Size.Values = (
          30.868055555555600000
          6.614583333333330000
          1858.697916666670000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape19: TQRShape
        Left = 3
        Top = 882
        Width = 853
        Height = 2
        Size.Values = (
          4.409722222222220000
          6.614583333333330000
          1944.687500000000000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape20: TQRShape
        Left = 191
        Top = 825
        Width = 12
        Height = 24
        Size.Values = (
          52.916666666666700000
          421.128472222222000000
          1819.010416666670000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape21: TQRShape
        Left = 3
        Top = 1157
        Width = 853
        Height = 2
        Size.Values = (
          4.409722222222220000
          6.614583333333330000
          2551.024305555560000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel7: TQRLabel
        Left = 201
        Top = 825
        Width = 81
        Height = 24
        Size.Values = (
          52.916666666666700000
          443.177083333333000000
          1819.010416666670000000
          178.593750000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '237-2'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 12
      end
      object QRLabel8: TQRLabel
        Left = 672
        Top = 852
        Width = 48
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1878.541666666667000000
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
        Top = 825
        Width = 9
        Height = 24
        Size.Values = (
          52.916666666666700000
          615.156250000000000000
          1819.010416666670000000
          19.843750000000000000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel9: TQRLabel
        Left = 5
        Top = 853
        Width = 82
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1880.746527777778000000
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
        Top = 893
        Width = 603
        Height = 18
        Size.Values = (
          39.687500000000000000
          125.677083333333300000
          1968.940972222222000000
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
        Top = 884
        Width = 89
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1949.097222222222000000
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
        Top = 914
        Width = 78
        Height = 10
        Size.Values = (
          22.048611111111110000
          4.409722222222222000
          2015.243055555556000000
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
        Top = 914
        Width = 70
        Height = 10
        Size.Values = (
          22.048611111111110000
          319.704861111111100000
          2015.243055555556000000
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
        Top = 914
        Width = 54
        Height = 10
        Size.Values = (
          22.048611111111110000
          736.423611111111100000
          2015.243055555556000000
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
        Top = 914
        Width = 26
        Height = 10
        Size.Values = (
          22.048611111111110000
          921.631944444444400000
          2015.243055555556000000
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
        Top = 914
        Width = 96
        Height = 10
        Size.Values = (
          22.048611111111110000
          1047.309027777778000000
          2015.243055555556000000
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
        Top = 914
        Width = 84
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          2015.243055555556000000
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
        Top = 944
        Width = 56
        Height = 10
        Size.Values = (
          22.048611111111110000
          4.409722222222222000
          2081.388888888889000000
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
        Top = 944
        Width = 20
        Height = 10
        Size.Values = (
          22.048611111111110000
          372.621527777777800000
          2081.388888888889000000
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
        Top = 944
        Width = 44
        Height = 10
        Size.Values = (
          22.048611111111110000
          500.503472222222200000
          2081.388888888889000000
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
        Top = 955
        Width = 73
        Height = 17
        Size.Values = (
          37.482638888888900000
          507.118055555556000000
          2105.642361111110000000
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
        Top = 944
        Width = 46
        Height = 10
        Size.Values = (
          22.048611111111110000
          698.940972222222200000
          2081.388888888889000000
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
        Top = 944
        Width = 41
        Height = 10
        Size.Values = (
          22.048611111111110000
          1305.277777777778000000
          2081.388888888889000000
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
        Top = 947
        Width = 10
        Height = 22
        Size.Values = (
          48.506944444444440000
          1270.000000000000000000
          2088.003472222222000000
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
        Top = 944
        Width = 94
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          2081.388888888889000000
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
        Top = 974
        Width = 43
        Height = 11
        Size.Values = (
          24.253472222222220000
          4.409722222222222000
          2147.534722222222000000
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
        Top = 974
        Width = 95
        Height = 11
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2147.534722222222000000
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
        Top = 1022
        Width = 55
        Height = 11
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2253.368055555556000000
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
        Top = 1068
        Width = 71
        Height = 11
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2354.791666666667000000
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
        Top = 1105
        Width = 38
        Height = 11
        Size.Values = (
          24.253472222222220000
          15.434027777777780000
          2436.371527777778000000
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
        Top = 1146
        Width = 74
        Height = 9
        Size.Values = (
          19.843750000000000000
          6.614583333333333000
          2526.770833333333000000
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
        Top = 1143
        Width = 74
        Height = 14
        Size.Values = (
          30.868055555555560000
          1488.281250000000000000
          2520.156250000000000000
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
        Top = 1160
        Width = 53
        Height = 9
        Size.Values = (
          19.843750000000000000
          1554.427083333333000000
          2557.638888888889000000
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
        Top = 1020
        Width = 189
        Height = 2
        Size.Values = (
          4.409722222222220000
          1472.847222222220000000
          2248.958333333330000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape24: TQRShape
        Left = 668
        Top = 1040
        Width = 189
        Height = 2
        Size.Values = (
          4.409722222222220000
          1472.847222222220000000
          2293.055555555560000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel35: TQRLabel
        Left = 51
        Top = 1104
        Width = 372
        Height = 14
        Size.Values = (
          30.868055555555600000
          112.447916666667000000
          2434.166666666670000000
          820.208333333333000000)
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
        Top = 1117
        Width = 372
        Height = 14
        Size.Values = (
          30.868055555555600000
          112.447916666667000000
          2462.829861111110000000
          820.208333333333000000)
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
        Top = 1131
        Width = 372
        Height = 14
        Size.Values = (
          30.868055555555600000
          112.447916666667000000
          2493.697916666670000000
          820.208333333333000000)
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
        Top = 850
        Width = 3
        Height = 253
        Size.Values = (
          557.829861111111000000
          1468.437500000000000000
          1874.131944444440000000
          6.614583333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel41: TQRLabel
        Left = 6
        Top = 867
        Width = 651
        Height = 15
        Size.Values = (
          33.072916666666700000
          13.229166666666700000
          1911.614583333330000000
          1435.364583333330000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'EM QUALQUER AG'#202'NCIA, AP'#211'S O VENCTO NAS AG. DO BRADESCO OU DE ACO' +
          'RDO COM AS INSTRU'#199#213'ES DA FICHA DE COMPENSA'#199#195'O'
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
        Top = 852
        Width = 292
        Height = 9
        Size.Values = (
          19.843750000000000000
          500.503472222222000000
          1878.541666666670000000
          643.819444444444000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pag'#225'vel preferencialmente na Rede Bradesco ou Bradesco Expresso'
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
        Top = 913
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          315.295138888889000000
          2013.038194444440000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape29: TQRShape
        Left = 330
        Top = 913
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          727.604166666667000000
          2013.038194444440000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape30: TQRShape
        Left = 412
        Top = 913
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          908.402777777778000000
          2013.038194444440000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape31: TQRShape
        Left = 165
        Top = 942
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          363.802083333333000000
          2076.979166666670000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape32: TQRShape
        Left = 220
        Top = 942
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          485.069444444444000000
          2076.979166666670000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape33: TQRShape
        Left = 579
        Top = 942
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          1276.614583333330000000
          2076.979166666670000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape34: TQRShape
        Left = 668
        Top = 1067
        Width = 187
        Height = 2
        Size.Values = (
          4.409722222222222000
          1472.847222222222000000
          2352.586805555556000000
          412.309027777777800000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape35: TQRShape
        Left = 312
        Top = 942
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          687.916666666667000000
          2076.979166666670000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel44: TQRLabel
        Left = 8
        Top = 955
        Width = 143
        Height = 17
        Size.Values = (
          37.482638888888900000
          17.638888888888900000
          2105.642361111110000000
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
        OnPrint = QRLabel40Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRShape36: TQRShape
        Left = 468
        Top = 913
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          1031.875000000000000000
          2013.038194444440000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel45: TQRLabel
        Left = 446
        Top = 925
        Width = 10
        Height = 17
        Size.Values = (
          37.482638888888890000
          983.368055555555600000
          2039.496527777778000000
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
        OnPrint = QRLabel42Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRShape37: TQRShape
        Left = 668
        Top = 996
        Width = 189
        Height = 2
        Size.Values = (
          4.409722222222220000
          1472.847222222220000000
          2196.041666666670000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel46: TQRLabel
        Left = 670
        Top = 998
        Width = 79
        Height = 11
        Size.Values = (
          24.253472222222220000
          1477.256944444444000000
          2200.451388888889000000
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
        Top = 1042
        Width = 90
        Height = 11
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2297.465277777778000000
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
        Top = 954
        Width = 32
        Height = 18
        Size.Values = (
          39.687500000000000000
          374.826388888888900000
          2103.437500000000000000
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
        OnPrint = QRLabel48Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel49: TQRLabel
        Left = 686
        Top = 864
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1512.534722222220000000
          1905.000000000000000000
          352.777777777778000000)
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
        OnPrint = QRLabel50Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel52: TQRLabel
        Left = 13
        Top = 925
        Width = 120
        Height = 17
        Size.Values = (
          37.482638888888900000
          28.663194444444400000
          2039.496527777780000000
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
        OnPrint = QRLabel51Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel53: TQRLabel
        Left = 156
        Top = 925
        Width = 163
        Height = 17
        Size.Values = (
          37.482638888888900000
          343.958333333333000000
          2039.496527777780000000
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
        OnPrint = QRLabel56Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel55: TQRLabel
        Left = 337
        Top = 925
        Width = 65
        Height = 17
        Size.Values = (
          37.482638888888900000
          743.038194444444000000
          2039.496527777780000000
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
        OnPrint = QRLabel54Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel69: TQRLabel
        Left = 479
        Top = 925
        Width = 169
        Height = 17
        Size.Values = (
          37.482638888888900000
          1056.128472222220000000
          2039.496527777780000000
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
        OnPrint = QRLabel57Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel70: TQRLabel
        Left = 675
        Top = 894
        Width = 176
        Height = 18
        Size.Values = (
          39.687500000000000000
          1488.281250000000000000
          1971.145833333330000000
          388.055555555556000000)
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
        OnPrint = QRLabel70Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel71: TQRLabel
        Left = 675
        Top = 925
        Width = 176
        Height = 17
        Size.Values = (
          37.482638888888900000
          1488.281250000000000000
          2039.496527777780000000
          388.055555555556000000)
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
        OnPrint = QRLabel71Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel72: TQRLabel
        Left = 686
        Top = 955
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1512.534722222220000000
          2105.642361111110000000
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
        OnPrint = QRLabel60Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel78: TQRLabel
        Left = 753
        Top = 1143
        Width = 68
        Height = 14
        Size.Values = (
          30.868055555555560000
          1660.260416666667000000
          2520.156250000000000000
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
        OnPrint = QRLabel78Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel79: TQRLabel
        Left = 299
        Top = 826
        Width = 537
        Height = 22
        Size.Values = (
          48.506944444444400000
          659.253472222222000000
          1821.215277777780000000
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
        OnPrint = QRLabel67Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 11
      end
      object QRLabel80: TQRLabel
        Left = 818
        Top = 803
        Width = 19
        Height = 19
        Size.Values = (
          41.892361111111110000
          1803.576388888889000000
          1770.503472222222000000
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
        Top = 1182
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555560000
          70.555555555555560000
          2606.145833333333000000
          1221.493055555556000000)
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
        Top = 1200
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555560000
          70.555555555555560000
          2645.833333333333000000
          1221.493055555556000000)
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
      object QRLabel83: TQRLabel
        Left = 52
        Top = 159
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          114.652777777778000000
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
        OnPrint = QRLabel83Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel84: TQRLabel
        Left = 52
        Top = 186
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          114.652777777778000000
          410.104166666667000000
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
        OnPrint = QRLabel84Print
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
        Top = 1110
        Width = 212
        Height = 14
        Size.Values = (
          30.868055555555600000
          983.368055555556000000
          2447.395833333330000000
          467.430555555556000000)
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
      object QRLabel73: TQRLabel
        Left = 52
        Top = 173
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          114.652777777778000000
          381.440972222222000000
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
        OnPrint = QRLabel73Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel74: TQRLabel
        Left = 51
        Top = 1026
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          112.447916666667000000
          2262.187500000000000000
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
        OnPrint = QRLabel61Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel75: TQRLabel
        Left = 51
        Top = 1042
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          112.447916666667000000
          2297.465277777780000000
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
        OnPrint = QRLabel62Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel76: TQRLabel
        Left = 51
        Top = 1058
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          112.447916666667000000
          2332.743055555560000000
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
        OnPrint = QRLabel63Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel77: TQRLabel
        Left = 51
        Top = 1073
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          112.447916666667000000
          2365.815972222220000000
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
        OnPrint = QRLabel64Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel85: TQRLabel
        Left = 51
        Top = 1084
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          112.447916666667000000
          2390.069444444440000000
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
        OnPrint = QRLabel65Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel86: TQRLabel
        Left = 51
        Top = 978
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          112.447916666667000000
          2156.354166666670000000
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
        OnPrint = QRLabel83Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel87: TQRLabel
        Left = 51
        Top = 1010
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          112.447916666667000000
          2226.909722222220000000
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
        OnPrint = QRLabel84Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel88: TQRLabel
        Left = 51
        Top = 994
        Width = 594
        Height = 14
        Size.Values = (
          30.868055555555600000
          112.447916666667000000
          2191.631944444440000000
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
        OnPrint = QRLabel73Print
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
        Caption = '237-2'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
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
        Top = 630
        Width = 71
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1389.062500000000000000
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
          'EM QUALQUER AG'#202'NCIA, AP'#211'S O VENCTO NAS AG. DO BRADESCO OU DE ACO' +
          'RDO COM AS INSTRU'#199#213'ES DA FICHA DE COMPENSA'#199#195'O'
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
        Caption = 'Pag'#225'vel preferencialmente na Rede Bradesco ou Bradesco Expresso'
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
        Top = 623
        Width = 187
        Height = 6
        Size.Values = (
          13.229166666666670000
          1472.847222222222000000
          1373.628472222222000000
          412.309027777777800000)
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
        OnPrint = QRLabel40Print
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
        OnPrint = QRLabel42Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
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
        OnPrint = QRLabel48Print
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
        OnPrint = QRLabel50Print
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
        OnPrint = QRLabel51Print
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
        OnPrint = QRLabel56Print
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
        OnPrint = QRLabel54Print
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
        OnPrint = QRLabel57Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel128: TQRLabel
        Left = 675
        Top = 450
        Width = 176
        Height = 17
        Size.Values = (
          37.482638888888900000
          1488.281250000000000000
          992.187500000000000000
          388.055555555556000000)
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
        OnPrint = QRLabel70Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel129: TQRLabel
        Left = 675
        Top = 480
        Width = 176
        Height = 17
        Size.Values = (
          37.482638888888900000
          1488.281250000000000000
          1058.333333333330000000
          388.055555555556000000)
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
        OnPrint = QRLabel71Print
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
        OnPrint = QRLabel60Print
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
        OnPrint = QRLabel78Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel133: TQRLabel
        Left = 818
        Top = 366
        Width = 19
        Height = 19
        Size.Values = (
          41.892361111111110000
          1803.576388888889000000
          806.979166666666700000
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
        Left = 51
        Top = 578
        Width = 594
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          1274.409722222220000000
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
        OnPrint = QRLabel61Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel136: TQRLabel
        Left = 51
        Top = 592
        Width = 594
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          1305.277777777780000000
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
        OnPrint = QRLabel62Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel137: TQRLabel
        Left = 51
        Top = 608
        Width = 594
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          1340.555555555560000000
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
        OnPrint = QRLabel63Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel138: TQRLabel
        Left = 51
        Top = 623
        Width = 594
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          1373.628472222220000000
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
        OnPrint = QRLabel64Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel139: TQRLabel
        Left = 51
        Top = 637
        Width = 594
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          1404.496527777780000000
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
        OnPrint = QRLabel65Print
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
          1175.190972222220000000
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
        OnPrint = QRLabel83Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel141: TQRLabel
        Left = 51
        Top = 562
        Width = 594
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          1239.131944444440000000
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
        OnPrint = QRLabel84Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel142: TQRLabel
        Left = 51
        Top = 547
        Width = 594
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          1206.059027777780000000
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
        OnPrint = QRLabel73Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel67: TQRLabel
        Left = 687
        Top = 388
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333333000000
          855.486111111111200000
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
      object QRLabel132: TQRLabel
        Left = 687
        Top = 16
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333333000000
          35.277777777777780000
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
        Top = 884
        Width = 49
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1949.097222222222000000
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
      object QRImage1: TQRImage
        Left = 7
        Top = 374
        Width = 151
        Height = 30
        Size.Values = (
          66.145833333333300000
          15.434027777777800000
          824.618055555556000000
          332.934027777778000000)
        XLColumn = 0
        Picture.Data = {
          07544269746D617066480000424D66480000000000003600000028000000B000
          0000230000000100180000000000304800000000000000000000000000000000
          00008C91EC4042E04A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE3
          4A4BE34A4BE34A4BE33B3FE0A8ABF1E7EBFA4A4BE3BEC2F4FCFCFCF1F3FB5458
          E44A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A
          4BE34A4BE34A4BE39FA3EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          DFDFDE9A98989896959A98989A98989A98989A98989A98989A98989A98989190
          8E9A9897B8B7B6D4D2D2F2F2F2FFFFFFFFFFFFFFFFFFFFFFFFA4A2A181807F81
          807F807E7C81807F8C8B8AEFEFEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D9D8D8A4A2A17C7A796A69676462616866657A7877A8A7A6E7E7E6CCCBCA807E
          7C807E7C81807F7C7A79A8A7A6F1F1F1FFFFFFFFFFFFFFFFFFEDECECBAB9B88F
          8E8D757372686665706E6D8C8B8AB3B2B1E5E4E3F2F2F2989695807E7C807E7C
          807E7C868483E5E4E3F3F3F3F3F3F3F3F3F3F3F3F3F1F1F1BFBEBD9896957A78
          776C6A696A69676A69676C6A69706E6D7C7A79959392B3B2B1EFEFEEFFFFFFFF
          FFFFAEADAC8684837876756866656A69676C6A696A69676866657876758A8887
          AEADACE5E4E3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCDCDBB8B7B68C8B
          8A706E6D6866656C6A696866656C6A697876758C8B8AD7D6D5F3F3F3F3F3F3F3
          F3F3E5E4E3B3B2B191908E7876756C6A696A69676C6A69706E6D7A7877959392
          C2C0C0EDECECFFFFFFFFFFFFFFFFFFFFFFFF676CE70D07D81511D91913DA1913
          DA1913DA1913DA1913DA1913DA1913DA1913DA1913DA1511D90D07D8918EECDC
          E2F91511D9A8ABF1FDFDFDEEEFFA2925DD120CD91913DA1913DA1913DA1913DA
          1913DA1913DA1913DA1913DA1913DA1913DA1913DA1511D98A89E9FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7D6D559575656545357555457555457
          55545755545755545755545755545A58575957565452515B59598C8B8AEDECEC
          FFFFFFFFFFFFFFFFFF8C8B8A575554575554565453575554706E6DFAF9F9FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E86C6A695351505755545A58575B59585A
          585759575652504F868483A8A7A64F4D4C5755545654534F4D4C9F9E9DFDFDFD
          FFFFFFFFFFFFF8F7F79593925957565957565B59585C5A595A58575957565654
          53868483EDECEC9593925351505755545452515E5B5AE5E4E3FFFFFFFFFFFFFF
          FFFFFCFCFCB3B2B15654535654535957565A58575B59585B59585B59585A5857
          5957565452515F5D5CE7E7E6FFFFFFFEFEFE8A88875654535957565A58575B59
          585B59585B59585A5857595756575554545251959392FDFDFDFFFFFFFFFFFFFF
          FFFFFEFEFED1D0CF68666552504F5755545957565B59585B59585B59585A5857
          5755545E5B5AC7C6C5FFFFFFFFFFFFDFDFDE706E6D5654535654535957565A58
          575B59585B59585A585759575656545354525181807FE5E4E3FFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB0D07D89392EEDCE2F91A18DBA8ABF1FEFEFEEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585B59585B59585B59585B59585B59585B59
          585B59585B59585A5857565453706E6DE5E4E3FFFFFFFFFFFF8A88875B59585B
          59585B59585B595872706FEFEFEEFFFFFFFFFFFFFFFFFFFFFFFFF2F2F28C8B8A
          52504F5B59585B59585B59585B59585A58575A58575B5958595756605E5D5B59
          585B59585B5958565453BFBEBDFFFFFFFFFFFFF2F2F2A4A2A15452515B59585B
          59585B59585B59585B59585B59585B59585957568684837C7A795957565B5958
          59575662605FDFDFDEF3F3F3F3F3F3F2F2F2B3B2B15957565A58575B59585B59
          585B59585A58575957565957565957565B595859575662605FE1E0E0FFFFFFFF
          FFFF8C8B8A5755545B59585A58575957565957565957565B59585B59585B5958
          5957565B5958D7D6D5FFFFFFFFFFFFFFFFFFD0CECD5C5A595654535B59585B59
          585B59585B59585B59585B59585B59585957565F5D5CCCCBCAF3F3F3DFDFDE62
          605F5452515B59585B59585B59585B59585A58575B59585B59585B59585B5958
          5A5857545251706E6DE5E4E3FFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB0D07D89392EEDC
          E2F91B1ADCA8ABF1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585B
          59585A58575B59585B59585A58575A58575B59585B59585B59585B5958565453
          8A8887FDFDFDFFFFFF8C8B8A5B59585B59585B59585B5958757372FAF9F9FFFF
          FFFFFFFFFFFFFFFFFFFFE5E4E3605E5D5957565B59585B59585B59585A58575F
          5D5C605E5D5957565957565A58575B59585B59585B59585C5A59BCBBBAFFFFFF
          FFFFFFD9D8D85C5A595B59585B59585B59585B59585A58575755545654535957
          565B59585957565A58575B59585B595859575662605FE5E4E3FFFFFFFFFFFFDC
          DCDB5E5B5A5957565B59585B59585A58575452515E5B5A64626164626162605F
          595756535150605E5DE7E7E6FFFFFFFAF9F98A88875351505452515E5B5A6462
          616462615F5D5C5755545B59585B59585B59585452518C8B8AFCFCFBFFFFFFED
          ECEC6462615654535B59585B59585B59585B5958595756535150545251535150
          5452515E5B5AD7D6D5F6F5F572706F5452515B59585B59585B59585A59585654
          535C5A595C5A595755545B59585B59585B59585B59585351508A8887FAF9F9FF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB0D07D89392EEDCE2F91A18DBA8ABF1FEFEFEEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585E5B5A7573727876757876757876755A58
          575957565B59585B59585B59585B5958575554D7D6D5FFFFFF8684835B59595B
          59585B59585B595872706FEFEFEEFFFFFFFFFFFFFFFFFFFFFFFFBCBBBA5E5B5A
          5A58575B59585B5958595756868483C9C8C8C9C8C8BAB9B881807F5957565B59
          585B59585B59585B5958B3B2B1FFFFFFF3F2F29593925755545B59585B59585B
          595859575659575686848386848362605F5957565B59585B59585B59585B5958
          59575662605FE1E0E0F3F3F3EFEFEE807E7C5452515B59585B59585957565B59
          5891908EC7C6C5DFDFDEE1E0E0D9D8D8B3B2B17C7A79646261DFDFDEFFFFFFFF
          FFFF91908E605E5D989695C4C4C3DFDFDEE1E0E0D7D6D58684835654535B5958
          5B5958595756686665EFEFEEFFFFFF9896954F4D4C5C5A595B59585B59585C5A
          595452516462619A9897A8A7A69F9E9D807E7C646261D0CECDBFBEBD5452515B
          59585A58575B59585B5958595756868483D0CECDC7C6C5706E6D5654535B5958
          5B59585B59585B5958575554C7C6C5FFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB0D07D89392EEDC
          E2F91B1ADCA8ABF1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585A585768
          6665E9E9E8FCFCFCFCFCFCFAF9F9D7D6D56C6A695957565B59585B59585C5A59
          545251BFBEBDFFFFFF8C8B8A5B59585B59585B59585B5958757372FAF9F9FFFF
          FFFFFFFFFFFFFFFFFFFFBFBEBD5E5B5A5A58575B59585A58575F5D5CD0CECDFF
          FFFFFFFFFFFFFFFFF3F3F39593925957565B59585B59585B5958BAB9B8FFFFFF
          EFEFEE6866655A58575B59585B5958595756646261C2C0C0FAF9F9FAF9F9DCDC
          DB72706F5755545B59585B59585B595859575662605FE7E7E6FFFFFFD7D6D55E
          5B5A5A58575B59585A5857595756B3B2B1FAF9F9FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFF8F7F7C7C6C5F1F1F1FFFFFFFEFEFEE1E0E0E5E4E3FCFCFCFFFFFFFFFF
          FFFFFFFFFFFFFFDCDCDB5A58575A58575B5958595756646261EFEFEEEDECEC62
          605F5957565B59585B59585B5958595756959392DFDFDEFCFCFCFEFEFEFDFDFD
          F8F7F7D9D8D8E9E9E89F9E9D5452515B59585A58575B59585A58579A9897F8F7
          F7FFFFFFFFFFFFE9E9E88684835452515B59585B59585B595852504FAEADACFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB0D07D89392EEDCE2F91A18DBA8ABF1FEFEFEEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A5857646261E7E7E6FFFFFFFFFFFFFFFFFFFFFF
          FFC9C8C85755545B59585B59585B595859575691908EFFFFFF8C8B8A5B59585B
          59585B59585B595872706FEFEFEEFFFFFFFFFFFFFFFFFFFFFFFFBAB9B85E5B5A
          5A58575B5958595756646261E1E0E0F3F3F3F3F3F3F3F3F3F3F3F3BFBEBD5957
          565B59585B59585B5958B3B2B1FFFFFFCCCBCA5755545B59585B59585B595854
          5251B3B2B1F1F1F1FFFFFFFFFFFFFFFFFFD9D8D8605E5D5957565B59585B5958
          59575662605FE1E0E0F3F3F3AEADAC5452515B59585B5958565453807E7CFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDECECA8A7A65B59585B5958
          5B5958595756646261E5E4E3C9C8C85755545B59585B59585B59585755547876
          75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F17573725957565B
          59585B5958595756686665E5E4E3F2F2F2FFFFFFFFFFFFFFFFFFD7D6D55C5A59
          5A58575B59585B5958565453868483FFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB0D07D8918EECDC
          E2F91B1ADCA8ABF1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585A585764
          6261EFEFEEFFFFFFFFFFFFFFFFFFFFFFFFEDECEC62605F5A58575B59585B5958
          595756959392FFFFFF91908E5B59585B59585B59585B5958757372FAF9F9FFFF
          FFFFFFFFFFFFFFFFFFFFD7D6D55F5D5C5A58575B59585A5857595756CCCBCAFF
          FFFFFFFFFFFFFFFFFFFFFFC9C8C85B59585B59585B59585A5857BFBEBDFFFFFF
          C4C4C35351505B59585B59585A58575A5958DCDCDBFFFFFFFFFFFFFFFFFFFFFF
          FFFEFEFE9593925452515B59585B5958595756646261E5E4E3FFFFFF807E7C56
          54535B59585B59585452518F8E8DD4D2D2D1D0CFD4D2D2D1D0CFD1D0CFD1D0CF
          D1D0CFD4D2D2D4D2D2D0CECDE5E4E3FEFEFEFFFFFFFFFFFFFFFFFFFAF9F9D9D8
          D8AEADAC7C7A795F5D5C5B59585B59585B59585A58576A6967F6F5F5A8A7A652
          504F5B59585B59585B5958535150B3B2B1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF8F7F7706E6D5A58575B59585B59585452518C8B8AFDFDFDFFFF
          FFFFFFFFFFFFFFFFFFFFFAF9F97573725957565B59585B5958595756757372FF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1913DA
          1D1BDB1C18DB1C18DB0D07D89FA3EEEEEFFA1B1ADCA8ABF1FDFDFDEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1511D91913DA1D19DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A5857646261E5E4E3FFFFFFFFFFFFFFFFFFFFFF
          FFE5E4E3605E5D5A58575B59585B5958595756959392F3F3F38C8B8A5B59585B
          59585B59585B5958757372FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDECEC706E6D
          5654535B59585B59585957567A7877BAB9B8CCCBCACCCBCAD1D0CFA4A2A15654
          535B59585B59585A5857B8B7B6FFFFFF9A98985957565B59585B59585A58575E
          5B5AD7D6D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0CECD5957565A58575B5958
          595756646261DCDCDBF3F3F37573725957565B59585B59585B59585C5A59605E
          5D605E5D605E5D605E5D605E5D605E5D605E5D605E5D605E5D5957569A9898F2
          F2F2FFFFFFF2F2F2D7D6D581807F5F5D5C5755545755545B59585B59585B5958
          5B59585351508F8E8DEDECEC8A88875452515B59585B59585B5958595756D0CE
          CDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E4E36462615957565B
          59585B595852504FBCBBBAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F091908E
          5452515B59585B59585B5958757372E5E4E36E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1A18DB5D63E63333DE1913DA1D18DB1511D95458E476
          79E91913DAADB1F1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB211EDC
          4D51E31A18DB1511D91C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585A585764
          6261F0F0EFFFFFFFFFFFFFFFFFFFFFFFFFD0CECD5755545B59585B59585B5958
          535150C7C6C5FFFFFF8C8B8A5B59585B59585B59585A58576C6A69F0F0F0FFFF
          FFFFFFFFFFFFFFFFFFFFFEFEFED0CECD5957565957565B59585B59585957565E
          5B5A605E5D605E5D605E5D5E5B5A5A58575B59585B59585A5857BFBEBDFFFFFF
          91908E5957565B59585B5958595756605E5DE5E4E3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFDCDCDB5E5B5A5A58575B59585A5857646261E1E0E0FFFFFF7573725B
          59585B59585B59585B59585B59585957565A58575A58575A58575A58575A5857
          5A58575A58575A585752504F9A9897FDFDFDFDFDFDBFBEBD605E5D5654535957
          565B59585B59585B59585B59585B59585957565E5B5AE5E4E3FFFFFF86848356
          54535B59585B59585A58575F5D5CD9D8D8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFE5E4E36462615957565B59585B59585B5958C9C8C8FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFDFDFD9F9E9D52504F5B59585B59585B59586A6967E5
          E4E36E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB120CD94A4BE36E74E9
          1913DA1C18DB1C18DB1D19DB1511D90D07D81913DAADB1F1FCFCFCEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1913DA676CE7B4BAF24042E00D07D81913DA1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A5857646261DFDFDEF0F0F0F0F0F0EFEFEED0CE
          CD6C6A695957565B59585B5958595756605E5DE7E7E6FFFFFF8684835B59585B
          59585B5958595756605E5DD4D2D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F2
          BAB9B85F5D5C5351505957565755545957565957565957565654535957565B59
          585B59585B59585A5857B8B7B6FFFFFF8F8E8D5957565B59585B59585A58575F
          5D5CDCDCDBF3F2F2FFFFFFFFFFFFFFFFFFFFFFFFD4D2D25C5A595B59585B5958
          595756646261DCDCDBF3F3F36C6A695B59585B59585B59585C5A595755545250
          4F52504F52504F52504F52504F5452515B59585B59585C5A59535150B3B2B1FF
          FFFFD4D2D25B59585755545B59585B59585B5958595756575554575554545251
          595756AEADACF3F3F3FFFFFF8684835654535B59585B59585A58575E5B5AD1D0
          CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1E0E062605F5957565B
          59585B5958565453C2C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F19A9897
          5351505B59585B59585B5958686665E1E0E06E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1913DA2925DD8C91EC2925DD1913DA1C18DB1C18DB1C18DB1C18DB1C
          18DB1511D9ADB1F1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB1C18DB
          120CD96E74E9D1D7F78084EB211EDC1913DA1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585F
          5D5C7573727876757C7A797C7A795A58575957565C5A59595756575554787675
          C9C8C8FFFFFFFFFFFF8C8B8A5B59585B59585B59585B5958545251C4C4C3FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCDCDBB3B2B191908E7C7A7970
          6E6D706E6D706E6D7876756C6A695A58575B59585B59585A5857C2C0C0FFFFFF
          81807F5654535B59585B59585A58575E5B5AE5E4E3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFC9C8C85452515B59585B5958595756646261E5E4E3FFFFFF78767559
          57565B59585B59585755548C8B8ABAB9B8B3B2B1B3B2B1B3B2B1B3B2B1989695
          5C5A595B59585B59585B5958C9C8C8FFFFFFA4A2A15452515B59585B59585A58
          5759575662605F7876758A8887A8A7A6C7C6C5FCFCFBFFFFFFFCFCFC98969554
          52515B59585B59585B5958545251C2C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFE9E9E86A69675A58575B59585B59585351509F9E9DFEFEFEFFFF
          FFFFFFFFFFFFFFFFFFFFFAF9F9807E7C5755545B59585B5958595756706E6DE9
          E9E86E74E9120CD91C18DB1C18DB1C18DB1C18DB120CD99FA3EEA8ABF10D07D8
          1C19DB1C18DB1C18DB1C18DB1C18DB1C18DB1511D9B4BAF2FCFCFCF9F9FC2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1C18DB0D07D85458E4FDFDFDBEC2F41B
          1ADC1913DA1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585B59585A58575B59585B59585A58575A58
          575B595859575672706FCCCBCAEDECECFFFFFFFFFFFFFFFFFF8C8B8A5B59585B
          59585B59585B5958595756686665E5E4E3F2F2F2F3F3F3F3F3F3F3F3F3F3F3F3
          F3F3F3F3F3F3F3F3F3F3F3F3EFEFEEEDECECEDECECEDECECF0F0F0B3B2B15654
          535B59585B59585C5A59BCBBBAFFFFFFAEADAC52504F5B59585B59585B595954
          5251D1D0CFFFFFFFFFFFFFFFFFFFFFFFFFEDECEC7A78775957565B59585B5958
          595756646261E1E0E0F3F3F39F9E9D52504F5B59585B5958545251989695F3F3
          F3F3F3F3F3F3F3F3F3F3F3F3F3CCCBCA5957565B595859575662605FD9D8D8E7
          E7E66866655A58575B59585A58575E5B5A9F9E9DDFDFDEEDECECF1F1F1FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFC2C0C05957565B59585B59585B59585755547C7A
          79F1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F17573725957565B
          59585B595859575662605FE9E9E8FFFFFFFFFFFFFFFFFFFFFFFFD4D2D25E5B5A
          5A58575B59585B59585755548C8B8AF3F3F36E74E9120CD91C18DB1C18DB1C18
          DB1913DA3333DEF1F3FB676CE7120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1913DA8084EBB4BAF2ADB1F12925DD1913DA1C18DB1C18DB1C18DB1C18DB
          1D19DB1913DA1511D9BEC2F4FAFDFD8084EB120CD91C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585B
          59585A58575A58575A58575B59585B59585B5958595756686665C9C8C8FEFEFE
          FFFFFFFFFFFFFFFFFF91908E5B59585B59585B59585B59585B59585957566A69
          67BFBEBDD1D0CFD0CECDD4D2D2FFFFFFE7E7E6D7D6D5FAF9F9FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFAF9F981807F5957565B59585A58575F5D5CC9C8C8FFFFFF
          CCCBCA5E5B5A5A58575B59585B5958595756757372E7E7E6FFFFFFFFFFFFF1F1
          F1A8A7A65755545B59585B59585B595859575662605FE7E7E6FFFFFFD0CECD57
          55545B59585B59585A5857646261EDECECFFFFFFFFFFFFFFFFFFFDFDFD8F8E8D
          5452515B5958595756706E6DFFFFFFFFFFFF62605F5957565B59585957567270
          6FF6F5F5FFFFFFFFFFFFFFFFFFFFFFFFFCFCFCE5E4E3FDFDFDFFFFFFE9E9E864
          62615957565B59585B59585B5958595756A4A2A1EDECECFCFCFCFEFEFEFCFCFB
          E5E4E3CCCBCAFCFCFB9F9E9D5351505B59585B59585B59585654539A9897FFFF
          FFFFFFFFFFFFFFE9E9E88684835452515B59585B59585B5958565453A4A2A1FF
          FFFF6E74E9120CD91C18DB1C18DB1C19DB0D07D87679E9FAFDFD3333DE1913DA
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1A18DB1A18DB1A18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB0D07D88084EBFEFEFED1
          D7F7211EDC1913DA8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585B595857555454525154525152504F5957
          565B59585B5958595756545251A4A2A1FFFFFFFFFFFFFFFFFF8C8B8A5B59585B
          59585B59585B59585B59585B5958595756595756605E5D5A5857868483F3F3F3
          CCCBCA64626181807FB3B2B1D1D0CFE5E4E3DCDCDBBAB9B88C8B8A5957565B59
          585B5958595756646261E5E4E3FFFFFFEFEFEE6C6A695755545B59585B59585B
          595859575662605F7A7877807E7C72706F5755545B59585B59585B59585B5958
          59575662605FDFDFDEF3F3F3EFEFEE706E6D5654535B59585B59585755548A88
          87D4D2D2F1F1F1DFDFDEA8A7A65B59585A58575B5958545251A8A7A6FFFFFFFF
          FFFF7C7A795957565B59585A5857605E5D9F9E9DD1D0CFE5E4E3D9D8D8BFBEBD
          91908E807E7CEFEFEEFFFFFFF2F2F29593925351505B59585B59585B59585A58
          57595756706E6D9A9898A4A2A1959392646261868483F3F3F3C2C0C05452515B
          59585B59585B59585C5A595755547C7A79C9C8C8C7C6C5706E6D5755545B5958
          5B59585B59585B5958595756D0CECDF3F3F36E74E9120CD91C18DB1C18DB1A18
          DB1511D9B4BAF2E7EBFA211EDC1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1D19DB1913DA1C18DB1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB0D07D87679E9FDFDFDF7F8FD3B3FE01511D99392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585A
          5857A4A2A1BFBEBDBFBEBDA4A2A16462615755545B59585B59585B5958535150
          D0CECDFFFFFFFFFFFF8F8E8D5B59585B59585B59585A5857605E5D5B59585B59
          585B59585A58575452518A8887FFFFFFD4D2D25F5D5C5452515B5958605E5D64
          626162605F5C5A595957565B59585B59585B5958545251959392FEFEFEFFFFFF
          FFFFFFBAB9B85351505B59585B59585B59585B59585A58575957565755545B59
          585B59585957565B59585B59585B595859575662605FE5E4E3FFFFFFFFFFFFC7
          C6C552504F5A58575B59585B595857555462605F8C8B8A706E6D5A5857595756
          5B5958595756646261E9E9E8FFFFFFFFFFFF9896955351505B59585B59585A58
          57595756605E5D64626162605F5E5B5A52504F72706FFAF9F9FFFFFFFFFFFFEF
          EFEE62605F5654535B59585B59585B59585B5958575554545251565453545251
          5957567C7A79FFFFFFF2F2F27C7A795654535B59585B59585B59585B59585654
          535C5A595C5A595755545B59585B59585B59585C5A5952504F8C8B8AFCFCFBFF
          FFFF6E74E9120CD91C18DB1C18DB1913DA1F1CDBD1D7F7D1D7F7211EDC1913DA
          1C19DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB120CD99FA3EEFDFDFDF7
          F8FD4A4BE31511D98A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A5857595756D7D6D5FFFFFFFFFFFFFFFFFFC4C4
          C35957565A58575B59585B5958595756807E7CF1F1F1FFFFFF8A88875B59585B
          59585B5958565453B8B7B68684835957565B59585B59585957567C7A79F3F3F3
          CCCBCA5F5D5C5A58575B59585957565957565957565A58575B59585B59585B59
          585A5857545251D9D8D8FFFFFFFFFFFFFFFFFFEDECEC7C7A795654535B59585B
          59585B59585B59585B59585B59585B59585957566462615E5B5A5B59585B5958
          59575662605FDFDFDEFFFFFFFFFFFFF2F2F28F8E8D5654535B59585B59585B59
          585A58575957565957565B59585B5958595756565453BCBBBAFFFFFFFFFFFFFF
          FFFFE5E4E3605E5D5654535B59585B59585B59585957565957565957565A5857
          5A5857757372F2F2F2FFFFFFFFFFFFFFFFFFD1D0CF5C5A595654535B59585B59
          585B59585B59585B59585B59585B59585957566C6A69E9E9E8F3F3F3E1E0E080
          7E7C5755545B59585B59585C5A595B59585A59585B59585B59585B59585B5958
          5A585752504F787675E9E9E8FFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1913
          DA2925DDEEEFFAD1D7F7211EDC1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1511D93333DEE7EBFAFDFDFDF1F3FB3333DE1913DA9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585A58575A
          5857D1D0CFFFFFFFFFFFFFFFFFFFFFFFFF7C7A795452515B59585B59585A5857
          6A6967F3F3F3FFFFFF8A8887595756595756595756545251D1D0CFE5E4E35C5A
          595957565B595859575691908EFFFFFFC2C0C05957565452515A58575A58575B
          59585B59585B59585A58575A585757555453515091908EFCFCFCFFFFFFFFFFFF
          FFFFFFFFFFFFEDECEC7573725654535A58575B59585B59585A58575A58575250
          4F81807FC4C4C3605E5D5A58575B595859575662605FE5E4E3FFFFFFFFFFFFFF
          FFFFF6F5F59593925957565957565A58575B59585C5A595B59585A5857595756
          5C5A59AEADACFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFD1D0CF62605F5654535A58
          575B59585B59585B59585B59585A585756545362605FF3F3F3FFFFFFFFFFFFFF
          FFFFFFFFFFD4D2D26C6A695654535755545A58575B59585B59585B59585A5857
          5755545E5B5AE5E4E3FFFFFFFFFFFFE7E7E67573725654535755545A58575A58
          575B59585B59585A58575A5857565453545251868483EDECECFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1913DA2925DDF7F8FDDCE2F91F1CDB1913DA
          1D19DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1913DA1A18DBADB1F1FEFEFEFDFDFDB4
          BAF21913DA1A18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585957565A5857D1D0CFFFFFFFFFFFFFFFFFFFFFFF
          FF81807F5452515B59585B59585A58575E5B5AD4D2D2FFFFFF81807F62605F62
          605F62605F62605FA8A7A6F3F3F3C9C8C86C6A695B59585A585781807FF3F2F2
          E7E7E6B3B2B17C7A795E5B5A5F5D5C5B59585B59585B59585E5B5A5E5B5A7573
          72AEADACEDECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7D6D58684835E
          5B5A5B59585B59585E5B5A5C5A59989695E5E4E3D9D8D85C5A595A58575B5958
          59575662605FDFDFDEFFFFFFFFFFFFFFFFFFFFFFFFE7E7E69A98976866655E5B
          5A5C5A595B59585B59585E5B5A5F5D5CB8B7B6F0F0EFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFD4D2D2706E6D5E5B5A5C5A595B59585B59585C5A595F5D5C
          5F5D5C959392EDECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDEA4A2A16C6A
          695E5B5A5C5A595B59585B59585E5B5A605E5D8F8E8DE5E4E3FFFFFFFFFFFFFF
          FFFFE5E4E3AEADAC72706F5E5B5A5E5B5A5B59585B59585E5B5A5F5D5C7C7A79
          BFBEBDEDECECFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1913
          DA2925DDE7EBFAF7F8FD3333DE1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1511D9
          1B1ADCA8ABF1FDFDFDFEFEFEF1F3FB4A4BE3120CD91C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B595859575659
          5756D7D6D5FFFFFFFFFFFFFFFFFFD9D8D85C5A595A58575B59585B59585A5857
          5E5B5ADCDCDBFFFFFFEFEFEEE5E4E3E5E4E3E5E4E3E5E4E3F3F3F2FFFFFFFFFF
          FFEDECECBFBEBDBCBBBADCDCDBFEFEFEFFFFFFFFFFFFFAF9F9DFDFDED1D0CFC2
          C0C0BCBBBABAB9B8BCBBBAD4D2D2F6F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF8F7F7D1D0CFBAB9B8BCBBBAC4C4C3DCDCDBFCFC
          FCFFFFFFD7D6D55E5B5A5A58575B595859575662605FE5E4E3FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFE7E7E6D0CECDBAB9B8BCBBBABFBEBDCCCBCAE1E0E0
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDECECD7D6
          D5BCBBBABCBBBABCBBBAD0CECDD4D2D2E5E4E3FCFCFBFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E8CCCBCAC2C0C0BAB9B8BFBEBDC4C4C3
          E1E0E0FAF9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F5F5D4D2D2BFBE
          BDAEADACBCBBBAC2C0C0DCDCDBF8F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1913DA1F1CDBD1D7F7FCFCFC5D63E6120CD9
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB120CD91913DAA8ABF1FEFEFEFDFDFDFDFDFD6E74E912
          0CD91C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A58575A5857A4A2A1BFBEBDBFBEBDAEADAC6C6A
          695755545B59585B59585B59585A5857686665E9E9E8FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0CECD5E5B5A5A58575B5958
          59575662605FDFDFDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91F1CDB120CD91913
          DA120CD9ADB1F1FEFEFE9392EE120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB1C18DB1913DA1913DA1511D90D07D81913DA5458E4BEC2F4
          FDFDFDFEFEFEE7EBFA676CE7120CD91C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585B
          595857555454525154525152504F5755545C5A595B59585B59585B5958575554
          8A8887FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFD9D8D85E5B5A5A58575B595859575662605FE5E4E3FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD95D63E6676CE73B3FE01D19DB6E74E9FEFEFEBEC2F41511D9
          0D07D8120CD91511D9120CD9120CD9120CD9120CD90D07D81511D91C18DB1F1C
          DB3333DE6E74E9BEC2F4FCFCFCFCFCFCF7F8FDB4BAF24042E0120CD91A18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585B59585A58575A58575A58575B59585B59
          585B59585B59585B5958595756565453D0CECDFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD1D0CF5E5B5A5B59585B5958
          59575662605FDFDFDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD92925DD4A4BE3676C
          E78C91ECB4BAF2FAFDFDF7F8FD8C91EC5D63E65458E45458E45458E45458E45D
          63E66E74E99392EEA8ABF1B4BAF2DCE2F9FCFCFCFCFCFCF9F9FCD1D7F78A89E9
          4A4BE31913DA1511D91C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7D6D55E5B5A5957565A58575A58575A
          58575A58575A58575A58575A5857595756595756595756575554807E7CE5E4E3
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFD7D6D55C5A595957565A5857595756605E5DE5E4E3FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1511D9120CD91C19DB3333DE8A89E9FAFDFDFDFDFD
          FAFDFDF1F3FBFAFDFDFDFDFDFCFCFCFCFCFCFCFCFCFCFCFCFDFDFDFDFDFDDCE2
          F9ADB1F18084EB4042E01D1BDC0D07D81511D91913DA1D19DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          BAB9B862605F5F5D5C605E5D605E5D605E5D605E5D605E5D605E5D605E5D605E
          5D605E5D8C8B8ABFBEBDE9E9E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBAB9B862605F605E5D605E5D
          5E5B5A686665DFDFDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1D19
          DB1913DA1511D9120CD9B4BAF2FDFDFDE7EBFA6E74E94A4BE3676CE76E74E96E
          74E96E74E95D63E64A4BE33333DE211EDC1511D90D07D81511D91913DA1511D9
          1C19DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDECECD4D2D2D1D0CFD4D2D2D1D0CFD4
          D2D2D1D0CFD4D2D2D1D0CFD1D0CFDCDCDBE7E7E6FAF9F9FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFEDECECD4D2D2D4D2D2D1D0CFD1D0CFD4D2D2F8F7F7FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB120CD94A4BE3FDFDFD
          FDFDFDD1D7F74D51E30D07D80D07D80D07D8120CD9120CD91511D91511D91913
          DA1C18DB1C18DB1511D90D07D84A4BE34042E01913DA1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1511D98A89E9FEFEFEFDFDFDFEFEFE9FA3EE4042E015
          11D90D07D81511D91511D91511D91511D90D07D8120CD93333DE9FA3EE9392EE
          211EDC1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1913DA1511D9
          676CE7E7EBFAFEFEFEFDFDFDF7F8FDB4BAF27679E94A4BE33B3FE03B3FE04D51
          E36E74E9ADB1F1E7EBFA9392EE211EDC1913DA1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1A18DB120CD93333DE9FA3EEE7EBFAFEFEFEFE
          FEFEFDFDFDFCFCFCFAFDFDFDFDFDFDFDFDFEFEFEBEC2F44D51E3120CD91913DA
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1511D9120CD93333DE6E74E99FA3EEBEC2F4D1D7F7D1D7F7ADB1F18084
          EB4042E01913DA120CD91C19DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1D18DB1C18DB1913DA0D07D815
          11D91C19DB211EDC1D1BDB1511D9120CD9120CD91C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1D18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91A18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1913DA1913DA1913DA1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1D18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF676CE70D07D8120CD9120CD9120C
          D9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD912
          0CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9
          120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD98084EBFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFA8ABF1676CE76E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E9
          6E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74
          E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E
          74E96E74E96E74E9ADB1F1F3F3F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Stretch = True
      end
      object QRImage3: TQRImage
        Left = 7
        Top = 819
        Width = 151
        Height = 30
        Size.Values = (
          66.145833333333300000
          15.434027777777800000
          1805.781250000000000000
          332.934027777778000000)
        XLColumn = 0
        Picture.Data = {
          07544269746D617066480000424D66480000000000003600000028000000B000
          0000230000000100180000000000304800000000000000000000000000000000
          00008C91EC4042E04A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE3
          4A4BE34A4BE34A4BE33B3FE0A8ABF1E7EBFA4A4BE3BEC2F4FCFCFCF1F3FB5458
          E44A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A4BE34A
          4BE34A4BE34A4BE39FA3EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          DFDFDE9A98989896959A98989A98989A98989A98989A98989A98989A98989190
          8E9A9897B8B7B6D4D2D2F2F2F2FFFFFFFFFFFFFFFFFFFFFFFFA4A2A181807F81
          807F807E7C81807F8C8B8AEFEFEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D9D8D8A4A2A17C7A796A69676462616866657A7877A8A7A6E7E7E6CCCBCA807E
          7C807E7C81807F7C7A79A8A7A6F1F1F1FFFFFFFFFFFFFFFFFFEDECECBAB9B88F
          8E8D757372686665706E6D8C8B8AB3B2B1E5E4E3F2F2F2989695807E7C807E7C
          807E7C868483E5E4E3F3F3F3F3F3F3F3F3F3F3F3F3F1F1F1BFBEBD9896957A78
          776C6A696A69676A69676C6A69706E6D7C7A79959392B3B2B1EFEFEEFFFFFFFF
          FFFFAEADAC8684837876756866656A69676C6A696A69676866657876758A8887
          AEADACE5E4E3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCDCDBB8B7B68C8B
          8A706E6D6866656C6A696866656C6A697876758C8B8AD7D6D5F3F3F3F3F3F3F3
          F3F3E5E4E3B3B2B191908E7876756C6A696A69676C6A69706E6D7A7877959392
          C2C0C0EDECECFFFFFFFFFFFFFFFFFFFFFFFF676CE70D07D81511D91913DA1913
          DA1913DA1913DA1913DA1913DA1913DA1913DA1913DA1511D90D07D8918EECDC
          E2F91511D9A8ABF1FDFDFDEEEFFA2925DD120CD91913DA1913DA1913DA1913DA
          1913DA1913DA1913DA1913DA1913DA1913DA1913DA1511D98A89E9FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7D6D559575656545357555457555457
          55545755545755545755545755545A58575957565452515B59598C8B8AEDECEC
          FFFFFFFFFFFFFFFFFF8C8B8A575554575554565453575554706E6DFAF9F9FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E86C6A695351505755545A58575B59585A
          585759575652504F868483A8A7A64F4D4C5755545654534F4D4C9F9E9DFDFDFD
          FFFFFFFFFFFFF8F7F79593925957565957565B59585C5A595A58575957565654
          53868483EDECEC9593925351505755545452515E5B5AE5E4E3FFFFFFFFFFFFFF
          FFFFFCFCFCB3B2B15654535654535957565A58575B59585B59585B59585A5857
          5957565452515F5D5CE7E7E6FFFFFFFEFEFE8A88875654535957565A58575B59
          585B59585B59585A5857595756575554545251959392FDFDFDFFFFFFFFFFFFFF
          FFFFFEFEFED1D0CF68666552504F5755545957565B59585B59585B59585A5857
          5755545E5B5AC7C6C5FFFFFFFFFFFFDFDFDE706E6D5654535654535957565A58
          575B59585B59585A585759575656545354525181807FE5E4E3FFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB0D07D89392EEDCE2F91A18DBA8ABF1FEFEFEEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585B59585B59585B59585B59585B59585B59
          585B59585B59585A5857565453706E6DE5E4E3FFFFFFFFFFFF8A88875B59585B
          59585B59585B595872706FEFEFEEFFFFFFFFFFFFFFFFFFFFFFFFF2F2F28C8B8A
          52504F5B59585B59585B59585B59585A58575A58575B5958595756605E5D5B59
          585B59585B5958565453BFBEBDFFFFFFFFFFFFF2F2F2A4A2A15452515B59585B
          59585B59585B59585B59585B59585B59585957568684837C7A795957565B5958
          59575662605FDFDFDEF3F3F3F3F3F3F2F2F2B3B2B15957565A58575B59585B59
          585B59585A58575957565957565957565B595859575662605FE1E0E0FFFFFFFF
          FFFF8C8B8A5755545B59585A58575957565957565957565B59585B59585B5958
          5957565B5958D7D6D5FFFFFFFFFFFFFFFFFFD0CECD5C5A595654535B59585B59
          585B59585B59585B59585B59585B59585957565F5D5CCCCBCAF3F3F3DFDFDE62
          605F5452515B59585B59585B59585B59585A58575B59585B59585B59585B5958
          5A5857545251706E6DE5E4E3FFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB0D07D89392EEDC
          E2F91B1ADCA8ABF1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585B
          59585A58575B59585B59585A58575A58575B59585B59585B59585B5958565453
          8A8887FDFDFDFFFFFF8C8B8A5B59585B59585B59585B5958757372FAF9F9FFFF
          FFFFFFFFFFFFFFFFFFFFE5E4E3605E5D5957565B59585B59585B59585A58575F
          5D5C605E5D5957565957565A58575B59585B59585B59585C5A59BCBBBAFFFFFF
          FFFFFFD9D8D85C5A595B59585B59585B59585B59585A58575755545654535957
          565B59585957565A58575B59585B595859575662605FE5E4E3FFFFFFFFFFFFDC
          DCDB5E5B5A5957565B59585B59585A58575452515E5B5A64626164626162605F
          595756535150605E5DE7E7E6FFFFFFFAF9F98A88875351505452515E5B5A6462
          616462615F5D5C5755545B59585B59585B59585452518C8B8AFCFCFBFFFFFFED
          ECEC6462615654535B59585B59585B59585B5958595756535150545251535150
          5452515E5B5AD7D6D5F6F5F572706F5452515B59585B59585B59585A59585654
          535C5A595C5A595755545B59585B59585B59585B59585351508A8887FAF9F9FF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB0D07D89392EEDCE2F91A18DBA8ABF1FEFEFEEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585E5B5A7573727876757876757876755A58
          575957565B59585B59585B59585B5958575554D7D6D5FFFFFF8684835B59595B
          59585B59585B595872706FEFEFEEFFFFFFFFFFFFFFFFFFFFFFFFBCBBBA5E5B5A
          5A58575B59585B5958595756868483C9C8C8C9C8C8BAB9B881807F5957565B59
          585B59585B59585B5958B3B2B1FFFFFFF3F2F29593925755545B59585B59585B
          595859575659575686848386848362605F5957565B59585B59585B59585B5958
          59575662605FE1E0E0F3F3F3EFEFEE807E7C5452515B59585B59585957565B59
          5891908EC7C6C5DFDFDEE1E0E0D9D8D8B3B2B17C7A79646261DFDFDEFFFFFFFF
          FFFF91908E605E5D989695C4C4C3DFDFDEE1E0E0D7D6D58684835654535B5958
          5B5958595756686665EFEFEEFFFFFF9896954F4D4C5C5A595B59585B59585C5A
          595452516462619A9897A8A7A69F9E9D807E7C646261D0CECDBFBEBD5452515B
          59585A58575B59585B5958595756868483D0CECDC7C6C5706E6D5654535B5958
          5B59585B59585B5958575554C7C6C5FFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB0D07D89392EEDC
          E2F91B1ADCA8ABF1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585A585768
          6665E9E9E8FCFCFCFCFCFCFAF9F9D7D6D56C6A695957565B59585B59585C5A59
          545251BFBEBDFFFFFF8C8B8A5B59585B59585B59585B5958757372FAF9F9FFFF
          FFFFFFFFFFFFFFFFFFFFBFBEBD5E5B5A5A58575B59585A58575F5D5CD0CECDFF
          FFFFFFFFFFFFFFFFF3F3F39593925957565B59585B59585B5958BAB9B8FFFFFF
          EFEFEE6866655A58575B59585B5958595756646261C2C0C0FAF9F9FAF9F9DCDC
          DB72706F5755545B59585B59585B595859575662605FE7E7E6FFFFFFD7D6D55E
          5B5A5A58575B59585A5857595756B3B2B1FAF9F9FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFF8F7F7C7C6C5F1F1F1FFFFFFFEFEFEE1E0E0E5E4E3FCFCFCFFFFFFFFFF
          FFFFFFFFFFFFFFDCDCDB5A58575A58575B5958595756646261EFEFEEEDECEC62
          605F5957565B59585B59585B5958595756959392DFDFDEFCFCFCFEFEFEFDFDFD
          F8F7F7D9D8D8E9E9E89F9E9D5452515B59585A58575B59585A58579A9897F8F7
          F7FFFFFFFFFFFFE9E9E88684835452515B59585B59585B595852504FAEADACFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB0D07D89392EEDCE2F91A18DBA8ABF1FEFEFEEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A5857646261E7E7E6FFFFFFFFFFFFFFFFFFFFFF
          FFC9C8C85755545B59585B59585B595859575691908EFFFFFF8C8B8A5B59585B
          59585B59585B595872706FEFEFEEFFFFFFFFFFFFFFFFFFFFFFFFBAB9B85E5B5A
          5A58575B5958595756646261E1E0E0F3F3F3F3F3F3F3F3F3F3F3F3BFBEBD5957
          565B59585B59585B5958B3B2B1FFFFFFCCCBCA5755545B59585B59585B595854
          5251B3B2B1F1F1F1FFFFFFFFFFFFFFFFFFD9D8D8605E5D5957565B59585B5958
          59575662605FE1E0E0F3F3F3AEADAC5452515B59585B5958565453807E7CFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDECECA8A7A65B59585B5958
          5B5958595756646261E5E4E3C9C8C85755545B59585B59585B59585755547876
          75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F17573725957565B
          59585B5958595756686665E5E4E3F2F2F2FFFFFFFFFFFFFFFFFFD7D6D55C5A59
          5A58575B59585B5958565453868483FFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB0D07D8918EECDC
          E2F91B1ADCA8ABF1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585A585764
          6261EFEFEEFFFFFFFFFFFFFFFFFFFFFFFFEDECEC62605F5A58575B59585B5958
          595756959392FFFFFF91908E5B59585B59585B59585B5958757372FAF9F9FFFF
          FFFFFFFFFFFFFFFFFFFFD7D6D55F5D5C5A58575B59585A5857595756CCCBCAFF
          FFFFFFFFFFFFFFFFFFFFFFC9C8C85B59585B59585B59585A5857BFBEBDFFFFFF
          C4C4C35351505B59585B59585A58575A5958DCDCDBFFFFFFFFFFFFFFFFFFFFFF
          FFFEFEFE9593925452515B59585B5958595756646261E5E4E3FFFFFF807E7C56
          54535B59585B59585452518F8E8DD4D2D2D1D0CFD4D2D2D1D0CFD1D0CFD1D0CF
          D1D0CFD4D2D2D4D2D2D0CECDE5E4E3FEFEFEFFFFFFFFFFFFFFFFFFFAF9F9D9D8
          D8AEADAC7C7A795F5D5C5B59585B59585B59585A58576A6967F6F5F5A8A7A652
          504F5B59585B59585B5958535150B3B2B1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF8F7F7706E6D5A58575B59585B59585452518C8B8AFDFDFDFFFF
          FFFFFFFFFFFFFFFFFFFFFAF9F97573725957565B59585B5958595756757372FF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1913DA
          1D1BDB1C18DB1C18DB0D07D89FA3EEEEEFFA1B1ADCA8ABF1FDFDFDEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1511D91913DA1D19DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A5857646261E5E4E3FFFFFFFFFFFFFFFFFFFFFF
          FFE5E4E3605E5D5A58575B59585B5958595756959392F3F3F38C8B8A5B59585B
          59585B59585B5958757372FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDECEC706E6D
          5654535B59585B59585957567A7877BAB9B8CCCBCACCCBCAD1D0CFA4A2A15654
          535B59585B59585A5857B8B7B6FFFFFF9A98985957565B59585B59585A58575E
          5B5AD7D6D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0CECD5957565A58575B5958
          595756646261DCDCDBF3F3F37573725957565B59585B59585B59585C5A59605E
          5D605E5D605E5D605E5D605E5D605E5D605E5D605E5D605E5D5957569A9898F2
          F2F2FFFFFFF2F2F2D7D6D581807F5F5D5C5755545755545B59585B59585B5958
          5B59585351508F8E8DEDECEC8A88875452515B59585B59585B5958595756D0CE
          CDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E4E36462615957565B
          59585B595852504FBCBBBAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F091908E
          5452515B59585B59585B5958757372E5E4E36E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1A18DB5D63E63333DE1913DA1D18DB1511D95458E476
          79E91913DAADB1F1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB211EDC
          4D51E31A18DB1511D91C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585A585764
          6261F0F0EFFFFFFFFFFFFFFFFFFFFFFFFFD0CECD5755545B59585B59585B5958
          535150C7C6C5FFFFFF8C8B8A5B59585B59585B59585A58576C6A69F0F0F0FFFF
          FFFFFFFFFFFFFFFFFFFFFEFEFED0CECD5957565957565B59585B59585957565E
          5B5A605E5D605E5D605E5D5E5B5A5A58575B59585B59585A5857BFBEBDFFFFFF
          91908E5957565B59585B5958595756605E5DE5E4E3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFDCDCDB5E5B5A5A58575B59585A5857646261E1E0E0FFFFFF7573725B
          59585B59585B59585B59585B59585957565A58575A58575A58575A58575A5857
          5A58575A58575A585752504F9A9897FDFDFDFDFDFDBFBEBD605E5D5654535957
          565B59585B59585B59585B59585B59585957565E5B5AE5E4E3FFFFFF86848356
          54535B59585B59585A58575F5D5CD9D8D8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFE5E4E36462615957565B59585B59585B5958C9C8C8FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFDFDFD9F9E9D52504F5B59585B59585B59586A6967E5
          E4E36E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB120CD94A4BE36E74E9
          1913DA1C18DB1C18DB1D19DB1511D90D07D81913DAADB1F1FCFCFCEEEFFA2925
          DD1913DA1C18DB1C18DB1C18DB1913DA676CE7B4BAF24042E00D07D81913DA1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A5857646261DFDFDEF0F0F0F0F0F0EFEFEED0CE
          CD6C6A695957565B59585B5958595756605E5DE7E7E6FFFFFF8684835B59585B
          59585B5958595756605E5DD4D2D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F2
          BAB9B85F5D5C5351505957565755545957565957565957565654535957565B59
          585B59585B59585A5857B8B7B6FFFFFF8F8E8D5957565B59585B59585A58575F
          5D5CDCDCDBF3F2F2FFFFFFFFFFFFFFFFFFFFFFFFD4D2D25C5A595B59585B5958
          595756646261DCDCDBF3F3F36C6A695B59585B59585B59585C5A595755545250
          4F52504F52504F52504F52504F5452515B59585B59585C5A59535150B3B2B1FF
          FFFFD4D2D25B59585755545B59585B59585B5958595756575554575554545251
          595756AEADACF3F3F3FFFFFF8684835654535B59585B59585A58575E5B5AD1D0
          CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1E0E062605F5957565B
          59585B5958565453C2C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F19A9897
          5351505B59585B59585B5958686665E1E0E06E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1913DA2925DD8C91EC2925DD1913DA1C18DB1C18DB1C18DB1C18DB1C
          18DB1511D9ADB1F1FDFDFDEEEFFA2925DD1913DA1C18DB1C18DB1C18DB1C18DB
          120CD96E74E9D1D7F78084EB211EDC1913DA1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585F
          5D5C7573727876757C7A797C7A795A58575957565C5A59595756575554787675
          C9C8C8FFFFFFFFFFFF8C8B8A5B59585B59585B59585B5958545251C4C4C3FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCDCDBB3B2B191908E7C7A7970
          6E6D706E6D706E6D7876756C6A695A58575B59585B59585A5857C2C0C0FFFFFF
          81807F5654535B59585B59585A58575E5B5AE5E4E3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFC9C8C85452515B59585B5958595756646261E5E4E3FFFFFF78767559
          57565B59585B59585755548C8B8ABAB9B8B3B2B1B3B2B1B3B2B1B3B2B1989695
          5C5A595B59585B59585B5958C9C8C8FFFFFFA4A2A15452515B59585B59585A58
          5759575662605F7876758A8887A8A7A6C7C6C5FCFCFBFFFFFFFCFCFC98969554
          52515B59585B59585B5958545251C2C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFE9E9E86A69675A58575B59585B59585351509F9E9DFEFEFEFFFF
          FFFFFFFFFFFFFFFFFFFFFAF9F9807E7C5755545B59585B5958595756706E6DE9
          E9E86E74E9120CD91C18DB1C18DB1C18DB1C18DB120CD99FA3EEA8ABF10D07D8
          1C19DB1C18DB1C18DB1C18DB1C18DB1C18DB1511D9B4BAF2FCFCFCF9F9FC2925
          DD1913DA1C18DB1C18DB1C18DB1C18DB1C18DB0D07D85458E4FDFDFDBEC2F41B
          1ADC1913DA1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585B59585A58575B59585B59585A58575A58
          575B595859575672706FCCCBCAEDECECFFFFFFFFFFFFFFFFFF8C8B8A5B59585B
          59585B59585B5958595756686665E5E4E3F2F2F2F3F3F3F3F3F3F3F3F3F3F3F3
          F3F3F3F3F3F3F3F3F3F3F3F3EFEFEEEDECECEDECECEDECECF0F0F0B3B2B15654
          535B59585B59585C5A59BCBBBAFFFFFFAEADAC52504F5B59585B59585B595954
          5251D1D0CFFFFFFFFFFFFFFFFFFFFFFFFFEDECEC7A78775957565B59585B5958
          595756646261E1E0E0F3F3F39F9E9D52504F5B59585B5958545251989695F3F3
          F3F3F3F3F3F3F3F3F3F3F3F3F3CCCBCA5957565B595859575662605FD9D8D8E7
          E7E66866655A58575B59585A58575E5B5A9F9E9DDFDFDEEDECECF1F1F1FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFC2C0C05957565B59585B59585B59585755547C7A
          79F1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F17573725957565B
          59585B595859575662605FE9E9E8FFFFFFFFFFFFFFFFFFFFFFFFD4D2D25E5B5A
          5A58575B59585B59585755548C8B8AF3F3F36E74E9120CD91C18DB1C18DB1C18
          DB1913DA3333DEF1F3FB676CE7120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1913DA8084EBB4BAF2ADB1F12925DD1913DA1C18DB1C18DB1C18DB1C18DB
          1D19DB1913DA1511D9BEC2F4FAFDFD8084EB120CD91C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585B
          59585A58575A58575A58575B59585B59585B5958595756686665C9C8C8FEFEFE
          FFFFFFFFFFFFFFFFFF91908E5B59585B59585B59585B59585B59585957566A69
          67BFBEBDD1D0CFD0CECDD4D2D2FFFFFFE7E7E6D7D6D5FAF9F9FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFAF9F981807F5957565B59585A58575F5D5CC9C8C8FFFFFF
          CCCBCA5E5B5A5A58575B59585B5958595756757372E7E7E6FFFFFFFFFFFFF1F1
          F1A8A7A65755545B59585B59585B595859575662605FE7E7E6FFFFFFD0CECD57
          55545B59585B59585A5857646261EDECECFFFFFFFFFFFFFFFFFFFDFDFD8F8E8D
          5452515B5958595756706E6DFFFFFFFFFFFF62605F5957565B59585957567270
          6FF6F5F5FFFFFFFFFFFFFFFFFFFFFFFFFCFCFCE5E4E3FDFDFDFFFFFFE9E9E864
          62615957565B59585B59585B5958595756A4A2A1EDECECFCFCFCFEFEFEFCFCFB
          E5E4E3CCCBCAFCFCFB9F9E9D5351505B59585B59585B59585654539A9897FFFF
          FFFFFFFFFFFFFFE9E9E88684835452515B59585B59585B5958565453A4A2A1FF
          FFFF6E74E9120CD91C18DB1C18DB1C19DB0D07D87679E9FAFDFD3333DE1913DA
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1A18DB1A18DB1A18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB0D07D88084EBFEFEFED1
          D7F7211EDC1913DA8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585B595857555454525154525152504F5957
          565B59585B5958595756545251A4A2A1FFFFFFFFFFFFFFFFFF8C8B8A5B59585B
          59585B59585B59585B59585B5958595756595756605E5D5A5857868483F3F3F3
          CCCBCA64626181807FB3B2B1D1D0CFE5E4E3DCDCDBBAB9B88C8B8A5957565B59
          585B5958595756646261E5E4E3FFFFFFEFEFEE6C6A695755545B59585B59585B
          595859575662605F7A7877807E7C72706F5755545B59585B59585B59585B5958
          59575662605FDFDFDEF3F3F3EFEFEE706E6D5654535B59585B59585755548A88
          87D4D2D2F1F1F1DFDFDEA8A7A65B59585A58575B5958545251A8A7A6FFFFFFFF
          FFFF7C7A795957565B59585A5857605E5D9F9E9DD1D0CFE5E4E3D9D8D8BFBEBD
          91908E807E7CEFEFEEFFFFFFF2F2F29593925351505B59585B59585B59585A58
          57595756706E6D9A9898A4A2A1959392646261868483F3F3F3C2C0C05452515B
          59585B59585B59585C5A595755547C7A79C9C8C8C7C6C5706E6D5755545B5958
          5B59585B59585B5958595756D0CECDF3F3F36E74E9120CD91C18DB1C18DB1A18
          DB1511D9B4BAF2E7EBFA211EDC1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1D19DB1913DA1C18DB1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB0D07D87679E9FDFDFDF7F8FD3B3FE01511D99392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585A
          5857A4A2A1BFBEBDBFBEBDA4A2A16462615755545B59585B59585B5958535150
          D0CECDFFFFFFFFFFFF8F8E8D5B59585B59585B59585A5857605E5D5B59585B59
          585B59585A58575452518A8887FFFFFFD4D2D25F5D5C5452515B5958605E5D64
          626162605F5C5A595957565B59585B59585B5958545251959392FEFEFEFFFFFF
          FFFFFFBAB9B85351505B59585B59585B59585B59585A58575957565755545B59
          585B59585957565B59585B59585B595859575662605FE5E4E3FFFFFFFFFFFFC7
          C6C552504F5A58575B59585B595857555462605F8C8B8A706E6D5A5857595756
          5B5958595756646261E9E9E8FFFFFFFFFFFF9896955351505B59585B59585A58
          57595756605E5D64626162605F5E5B5A52504F72706FFAF9F9FFFFFFFFFFFFEF
          EFEE62605F5654535B59585B59585B59585B5958575554545251565453545251
          5957567C7A79FFFFFFF2F2F27C7A795654535B59585B59585B59585B59585654
          535C5A595C5A595755545B59585B59585B59585C5A5952504F8C8B8AFCFCFBFF
          FFFF6E74E9120CD91C18DB1C18DB1913DA1F1CDBD1D7F7D1D7F7211EDC1913DA
          1C19DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB120CD99FA3EEFDFDFDF7
          F8FD4A4BE31511D98A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A5857595756D7D6D5FFFFFFFFFFFFFFFFFFC4C4
          C35957565A58575B59585B5958595756807E7CF1F1F1FFFFFF8A88875B59585B
          59585B5958565453B8B7B68684835957565B59585B59585957567C7A79F3F3F3
          CCCBCA5F5D5C5A58575B59585957565957565957565A58575B59585B59585B59
          585A5857545251D9D8D8FFFFFFFFFFFFFFFFFFEDECEC7C7A795654535B59585B
          59585B59585B59585B59585B59585B59585957566462615E5B5A5B59585B5958
          59575662605FDFDFDEFFFFFFFFFFFFF2F2F28F8E8D5654535B59585B59585B59
          585A58575957565957565B59585B5958595756565453BCBBBAFFFFFFFFFFFFFF
          FFFFE5E4E3605E5D5654535B59585B59585B59585957565957565957565A5857
          5A5857757372F2F2F2FFFFFFFFFFFFFFFFFFD1D0CF5C5A595654535B59585B59
          585B59585B59585B59585B59585B59585957566C6A69E9E9E8F3F3F3E1E0E080
          7E7C5755545B59585B59585C5A595B59585A59585B59585B59585B59585B5958
          5A585752504F787675E9E9E8FFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1913
          DA2925DDEEEFFAD1D7F7211EDC1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1511D93333DEE7EBFAFDFDFDF1F3FB3333DE1913DA9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585A58575A
          5857D1D0CFFFFFFFFFFFFFFFFFFFFFFFFF7C7A795452515B59585B59585A5857
          6A6967F3F3F3FFFFFF8A8887595756595756595756545251D1D0CFE5E4E35C5A
          595957565B595859575691908EFFFFFFC2C0C05957565452515A58575A58575B
          59585B59585B59585A58575A585757555453515091908EFCFCFCFFFFFFFFFFFF
          FFFFFFFFFFFFEDECEC7573725654535A58575B59585B59585A58575A58575250
          4F81807FC4C4C3605E5D5A58575B595859575662605FE5E4E3FFFFFFFFFFFFFF
          FFFFF6F5F59593925957565957565A58575B59585C5A595B59585A5857595756
          5C5A59AEADACFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFD1D0CF62605F5654535A58
          575B59585B59585B59585B59585A585756545362605FF3F3F3FFFFFFFFFFFFFF
          FFFFFFFFFFD4D2D26C6A695654535755545A58575B59585B59585B59585A5857
          5755545E5B5AE5E4E3FFFFFFFFFFFFE7E7E67573725654535755545A58575A58
          575B59585B59585A58575A5857565453545251868483EDECECFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1913DA2925DDF7F8FDDCE2F91F1CDB1913DA
          1D19DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1913DA1A18DBADB1F1FEFEFEFDFDFDB4
          BAF21913DA1A18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585957565A5857D1D0CFFFFFFFFFFFFFFFFFFFFFFF
          FF81807F5452515B59585B59585A58575E5B5AD4D2D2FFFFFF81807F62605F62
          605F62605F62605FA8A7A6F3F3F3C9C8C86C6A695B59585A585781807FF3F2F2
          E7E7E6B3B2B17C7A795E5B5A5F5D5C5B59585B59585B59585E5B5A5E5B5A7573
          72AEADACEDECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7D6D58684835E
          5B5A5B59585B59585E5B5A5C5A59989695E5E4E3D9D8D85C5A595A58575B5958
          59575662605FDFDFDEFFFFFFFFFFFFFFFFFFFFFFFFE7E7E69A98976866655E5B
          5A5C5A595B59585B59585E5B5A5F5D5CB8B7B6F0F0EFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFD4D2D2706E6D5E5B5A5C5A595B59585B59585C5A595F5D5C
          5F5D5C959392EDECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDEA4A2A16C6A
          695E5B5A5C5A595B59585B59585E5B5A605E5D8F8E8DE5E4E3FFFFFFFFFFFFFF
          FFFFE5E4E3AEADAC72706F5E5B5A5E5B5A5B59585B59585E5B5A5F5D5C7C7A79
          BFBEBDEDECECFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1913
          DA2925DDE7EBFAF7F8FD3333DE1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1511D9
          1B1ADCA8ABF1FDFDFDFEFEFEF1F3FB4A4BE3120CD91C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B595859575659
          5756D7D6D5FFFFFFFFFFFFFFFFFFD9D8D85C5A595A58575B59585B59585A5857
          5E5B5ADCDCDBFFFFFFEFEFEEE5E4E3E5E4E3E5E4E3E5E4E3F3F3F2FFFFFFFFFF
          FFEDECECBFBEBDBCBBBADCDCDBFEFEFEFFFFFFFFFFFFFAF9F9DFDFDED1D0CFC2
          C0C0BCBBBABAB9B8BCBBBAD4D2D2F6F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF8F7F7D1D0CFBAB9B8BCBBBAC4C4C3DCDCDBFCFC
          FCFFFFFFD7D6D55E5B5A5A58575B595859575662605FE5E4E3FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFE7E7E6D0CECDBAB9B8BCBBBABFBEBDCCCBCAE1E0E0
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDECECD7D6
          D5BCBBBABCBBBABCBBBAD0CECDD4D2D2E5E4E3FCFCFBFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E8CCCBCAC2C0C0BAB9B8BFBEBDC4C4C3
          E1E0E0FAF9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F5F5D4D2D2BFBE
          BDAEADACBCBBBAC2C0C0DCDCDBF8F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1913DA1F1CDBD1D7F7FCFCFC5D63E6120CD9
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB120CD91913DAA8ABF1FEFEFEFDFDFDFDFDFD6E74E912
          0CD91C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585A58575A5857A4A2A1BFBEBDBFBEBDAEADAC6C6A
          695755545B59585B59585B59585A5857686665E9E9E8FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0CECD5E5B5A5A58575B5958
          59575662605FDFDFDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91F1CDB120CD91913
          DA120CD9ADB1F1FEFEFE9392EE120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB1C18DB1913DA1913DA1511D90D07D81913DA5458E4BEC2F4
          FDFDFDFEFEFEE7EBFA676CE7120CD91C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D8D85E5B5A5A58575B59585B59585B
          595857555454525154525152504F5755545C5A595B59585B59585B5958575554
          8A8887FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFD9D8D85E5B5A5A58575B595859575662605FE5E4E3FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD95D63E6676CE73B3FE01D19DB6E74E9FEFEFEBEC2F41511D9
          0D07D8120CD91511D9120CD9120CD9120CD9120CD90D07D81511D91C18DB1F1C
          DB3333DE6E74E9BEC2F4FCFCFCFCFCFCF7F8FDB4BAF24042E0120CD91A18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1D0CF5E5B5A5A58575B59585B59585B59585A58575A58575A58575B59585B59
          585B59585B59585B5958595756565453D0CECDFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD1D0CF5E5B5A5B59585B5958
          59575662605FDFDFDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD92925DD4A4BE3676C
          E78C91ECB4BAF2FAFDFDF7F8FD8C91EC5D63E65458E45458E45458E45458E45D
          63E66E74E99392EEA8ABF1B4BAF2DCE2F9FCFCFCFCFCFCF9F9FCD1D7F78A89E9
          4A4BE31913DA1511D91C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7D6D55E5B5A5957565A58575A58575A
          58575A58575A58575A58575A5857595756595756595756575554807E7CE5E4E3
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFD7D6D55C5A595957565A5857595756605E5DE5E4E3FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1511D9120CD91C19DB3333DE8A89E9FAFDFDFDFDFD
          FAFDFDF1F3FBFAFDFDFDFDFDFCFCFCFCFCFCFCFCFCFCFCFCFDFDFDFDFDFDDCE2
          F9ADB1F18084EB4042E01D1BDC0D07D81511D91913DA1D19DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          BAB9B862605F5F5D5C605E5D605E5D605E5D605E5D605E5D605E5D605E5D605E
          5D605E5D8C8B8ABFBEBDE9E9E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBAB9B862605F605E5D605E5D
          5E5B5A686665DFDFDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1D19
          DB1913DA1511D9120CD9B4BAF2FDFDFDE7EBFA6E74E94A4BE3676CE76E74E96E
          74E96E74E95D63E64A4BE33333DE211EDC1511D90D07D81511D91913DA1511D9
          1C19DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDECECD4D2D2D1D0CFD4D2D2D1D0CFD4
          D2D2D1D0CFD4D2D2D1D0CFD1D0CFDCDCDBE7E7E6FAF9F9FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFEDECECD4D2D2D4D2D2D1D0CFD1D0CFD4D2D2F8F7F7FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB120CD94A4BE3FDFDFD
          FDFDFDD1D7F74D51E30D07D80D07D80D07D8120CD9120CD91511D91511D91913
          DA1C18DB1C18DB1511D90D07D84A4BE34042E01913DA1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1511D98A89E9FEFEFEFDFDFDFEFEFE9FA3EE4042E015
          11D90D07D81511D91511D91511D91511D90D07D8120CD93333DE9FA3EE9392EE
          211EDC1913DA1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1913DA1511D9
          676CE7E7EBFAFEFEFEFDFDFDF7F8FDB4BAF27679E94A4BE33B3FE03B3FE04D51
          E36E74E9ADB1F1E7EBFA9392EE211EDC1913DA1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1A18DB120CD93333DE9FA3EEE7EBFAFEFEFEFE
          FEFEFDFDFDFCFCFCFAFDFDFDFDFDFDFDFDFEFEFEBEC2F44D51E3120CD91913DA
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1511D9120CD93333DE6E74E99FA3EEBEC2F4D1D7F7D1D7F7ADB1F18084
          EB4042E01913DA120CD91C19DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1C18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E74E9120CD91C18DB1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1D18DB1C18DB1913DA0D07D815
          11D91C19DB211EDC1D1BDB1511D9120CD9120CD91C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1D18DB9392EEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E74E9120CD91A18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB
          1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1913DA1913DA1913DA1C18DB1C18
          DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C18DB1C
          18DB1C18DB1D18DB8A89E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF676CE70D07D8120CD9120CD9120C
          D9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD912
          0CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD9
          120CD9120CD9120CD9120CD9120CD9120CD9120CD9120CD98084EBFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFA8ABF1676CE76E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E9
          6E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74
          E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E74E96E
          74E96E74E96E74E9ADB1F1F3F3F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Stretch = True
      end
      object QRLabel169: TQRLabel
        Left = 688
        Top = 232
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1516.944444444444000000
          511.527777777777800000
          352.777777777777800000)
        XLColumn = 0
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'OutroAcresc'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel169Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel10: TQRLabel
        Left = 688
        Top = 608
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1516.944444444444000000
          1340.555555555556000000
          352.777777777777800000)
        XLColumn = 0
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'OutroAcresc'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel169Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel146: TQRLabel
        Left = 688
        Top = 1050
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1516.944444444444000000
          2315.104166666667000000
          352.777777777777800000)
        XLColumn = 0
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'OutroAcresc'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel169Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel147: TQRLabel
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
