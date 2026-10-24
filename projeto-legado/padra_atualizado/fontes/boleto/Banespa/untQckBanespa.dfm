object frmQckBanespa: TfrmQckBanespa
  Left = 112
  Top = 18
  Width = 982
  Height = 769
  AutoScroll = True
  Caption = 'frmqckBoletoBanespa'
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
        Caption = '033-7'
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
        Top = 2
        Width = 93
        Height = 30
        Size.Values = (
          66.145833333333300000
          16.536458333333300000
          3.307291666666670000
          205.052083333333000000)
        XLColumn = 0
        AutoSize = True
        Picture.Data = {
          07544269746D617042170000424D421700000000000036000000280000004E00
          00001900000001001800000000000C1700000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFF7F7FEB4B9F9ACB2F89CA2F6CED1FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF3F4FD3B45EF1823EC1823EC646CF2FDFDFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6B73F218
          23EC212CED3B45EFE6E8FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FDFDFFFAFAFEF7F7FEF7F7FEFDFDFFFFFFFFF7F7FEECEDFDF3F4
          FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFEECEDFDECEDFDFFFFFFFFFFFFFA
          FAFEF7F7FEF7F7FEFDFDFFFAFAFEF7F7FEF7F7FEF7F7FEFDFDFFFFFFFFFDFDFF
          FAFAFEF7F7FEF7F7FEFAFAFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFAFA
          FEF7F7FEFAFAFEFAFAFEFDFDFFFDFDFFF7F7FEFAFAFEFAFAFEFAFAFEFFFFFFFF
          FFFFFFFFFFFFFFFF9CA2F61823EC212CED2934EDCED1FBFFFFFFF7F7FEE6E8FD
          F3F4FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FEECEDFDF3F4FDFDFDFFFFFF
          FFF3F4FDF3F4FDFAFAFEFDFDFFFFFFFF0000ECEDFD848BF56B73F26B73F2D7D9
          FBDDDFFC6B73F24C55F0646CF2ACB2F8ECEDFDFFFFFFFFFFFFCED1FB747CF34C
          55F04C55F08C93F5E2E4FCACB2F8646CF26B73F2CED1FBD7D9FB747CF36B73F2
          646CF2BDC1F9FFFFFFFFFFFFA4AAF76B73F26B73F2848BF5F3F4FDFFFFFFFFFF
          FFD7D9FBA4AAF78C93F5747CF36B73F26B73F2646CF2CED1FBD7D9FB6B73F26B
          73F26B73F26B73F2848BF5A4AAF7DDDFFCFFFFFFBDC1F9212CED212CED212CED
          BDC1F9CED1FB5962F14C55F0646CF2ACB2F8F3F4FDFFFFFFFFFFFFBDC1F9646C
          F24C55F05962F19CA2F6DDDFFC848BF5646CF2747CF3CED1FBFFFFFF0000ECED
          FD4C55F0060FEA060FEA747CF33B45EF060FEA060FEA060FEA060FEA646CF2F3
          F4FDECEDFD3B45EF060FEA1823EC060FEA060FEA323CEE323CEE060FEA060FEA
          747CF3DDDFFC212CED060FEA060FEA747CF3FDFDFFFFFFFF848BF5060FEA060F
          EA1823ECCED1FBFFFFFFB4B9F92934ED1823EC060FEA060FEA060FEA060FEA06
          0FEA6B73F2ACB2F81823EC060FEA060FEA060FEA060FEA060FEA323CEEC6CAFA
          E6E8FD3B45EF212CED2934ED6B73F23B45EF060FEA060FEA060FEA060FEA6B73
          F2FFFFFFCED1FB2934ED060FEA1823EC060FEA060FEA323CEE323CEE060FEA06
          0FEA7C83F4FFFFFF0000FFFFFF8C93F51823EC323CEE2934ED212CED7C83F464
          6CF2212CED212CED060FEA949BF6C6CAFA1823EC2934ED2934ED848BF5B4B9F9
          6B73F2212CED323CEE2934ED4C55F0F3F4FD646CF2212CED1823EC5962F1F3F4
          FDFFFFFFBDC1F9212CED2934ED2934EDB4B9F9F3F4FD323CEE060FEA212CED4C
          55F08C93F5949BF6949BF68C93F5ACB2F8E6E8FDA4AAF7949BF6949BF69CA2F6
          6B73F22934ED060FEA3B45EFECEDFD646CF2212CED323CEE1823EC3B45EF9CA2
          F66B73F22934ED212CED1823ECA4AAF7B4B9F9060FEA2934ED3B45EF949BF6AC
          B2F85962F1212CED323CEE1823EC646CF2FAFAFE0000FFFFFFA4AAF71823EC29
          34ED1823EC6B73F2FDFDFFECEDFD646CF21823EC1823EC3B45EFB4B9F9323CEE
          2934ED323CEEE2E4FCFFFFFFFFFFFF7C83F4212CED2934ED323CEEECEDFD7C83
          F41823EC1823EC3B45EFDDDFFCFFFFFFE6E8FD3B45EF2934ED212CED949BF6BD
          C1F91823EC212CED2934EDCED1FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFD7D9FB3B45EF212CED060FEABDC1F9848BF5212C
          ED2934ED212CED9CA2F6FFFFFFFDFDFF5962F1212CED2934ED3B45EF9CA2F621
          2CED1823EC4C55F0E2E4FCFFFFFFF3F4FD6B73F2212CED212CED4C55F0E6E8FD
          0000FFFFFFCED1FB323CEE212CED1823EC8C93F5FDFDFFFFFFFFC6CAFA2934ED
          212CED1823EC9CA2F6646CF21823EC2934ED8C93F5FFFFFFFFFFFFE2E4FC3B45
          EF212CED1823ECBDC1F9B4B9F91823EC212CED2934EDC6CAFAFFFFFFFDFDFF4C
          55F0212CED212CED747CF3B4B9F9212CED212CED3B45EFE2E4FCECEDFDECEDFD
          ECEDFDECEDFDE6E8FDE6E8FDFDFDFFFFFFFFCED1FB8C93F54C55F02934ED323C
          EE1823EC949BF6A4AAF71823EC2934ED212CEDA4AAF7FFFFFFFFFFFFA4AAF721
          2CED2934ED2934ED8C93F55962F11823EC2934EDACB2F8FFFFFFFFFFFFD7D9FB
          2934ED1823EC3B45EFD7D9FB0000FFFFFFECEDFD4C55F01823EC1823EC7C83F4
          FDFDFFFFFFFFECEDFD5962F11823EC1823EC646CF2C6CAFA323CEE1823EC212C
          ED646CF2A4AAF7C6CAFA4C55F0212CED212CED8C93F5DDDFFC2934ED212CED18
          23ECA4AAF7FFFFFFFFFFFF6B73F21823EC212CED5962F1B4B9F9323CEE212CED
          323CEE3B45EF323CEE323CEE323CEE3B45EF323CEE4C55F0D7D9FB9CA2F6212C
          ED1823EC212CED2934ED212CED1823ECB4B9F9D7D9FB212CED2934ED1823EC94
          9BF6FFFFFFFFFFFFE6E8FD323CEE212CED212CED848BF5C6CAFA212CED060FEA
          2934ED747CF3ACB2F8B4B9F93B45EF212CED212CEDACB2F80000FFFFFFFAFAFE
          6B73F21823EC1823EC5962F1F7F7FEFFFFFFF3F4FD6B73F21823EC2934ED2934
          EDE2E4FCD7D9FB646CF22934ED060FEA1823EC212CED212CED323CEE212CED6B
          73F2ECEDFD3B45EF212CED1823EC7C83F4FDFDFFFFFFFFA4AAF71823EC2934ED
          3B45EFB4B9F94C55F0212CED323CEE323CEE3B45EF3B45EF3B45EF212CED1823
          EC1823ECA4AAF73B45EF212CED323CEE2934ED1823EC2934ED9CA2F6FAFAFEFA
          FAFE3B45EF2934ED212CED747CF3FFFFFFFFFFFFFAFAFE4C55F0212CED212CED
          4C55F0FAFAFECED1FB646CF2212CED060FEA1823EC212CED212CED323CEE1823
          EC8C93F50000FFFFFFFFFFFF848BF51823EC2934ED212CEDC6CAFAFFFFFFFFFF
          FF949BF61823EC2934ED1823ECC6CAFAFFFFFFFFFFFFE6E8FDBDC1F9ACB2F8B4
          B9F98C93F5323CEE212CED4C55F0ECEDFD646CF21823EC212CED3B45EFE2E4FC
          FFFFFFD7D9FB212CED2934ED2934EDB4B9F97C83F41823EC212CED949BF6FFFF
          FFFFFFFFF7F7FE6B73F21823EC212CED949BF63B45EF323CEE2934ED4C55F0AC
          B2F8F3F4FDFFFFFFFFFFFFFDFDFF646CF2212CED212CED3B45EFD7D9FBFFFFFF
          FFFFFF5962F1212CED212CED3B45EFDDDFFCFFFFFFFFFFFFE6E8FDB4B9F9ACB2
          F8ACB2F87C83F41823EC1823EC6B73F20000FFFFFFFFFFFFACB2F8212CED2934
          ED1823EC6B73F2F3F4FDFDFDFF7C83F41823EC323CEE1823ECC6CAFAFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFACB2F82934ED212CED323CEED7D9FB9CA2F6
          1823EC323CEE212CED848BF5DDDFFCB4B9F9212CED323CEE1823EC9CA2F6D7D9
          FB2934ED060FEA3B45EFD7D9FBFFFFFFF3F4FD646CF21823EC1823ECA4AAF74C
          55F0212CED2934ED848BF5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9CA2F61823EC
          323CEE1823EC646CF2ECEDFDECEDFD4C55F02934ED212CED3B45EFE2E4FCFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFF949BF61823EC212CED4C55F00000FFFF
          FFFFFFFFCED1FB323CEE212CED323CEE212CED4C55F06B73F2323CEE2934ED21
          2CED1823ECD7D9FBFFFFFF9CA2F6747CF38C93F5949BF67C83F43B45EF2934ED
          212CED1823ECDDDFFCC6CAFA1823EC2934ED323CEE212CED212CED2934ED323C
          EE323CEE060FEA7C83F4FFFFFFA4AAF71823EC060FEA3B45EFB4B9F98C93F532
          3CEE1823EC1823ECCED1FBACB2F8060FEA1823EC2934ED747CF3949BF68C93F5
          8C93F5949BF66B73F22934ED323CEE2934ED1823EC3B45EF4C55F0323CEE323C
          EE1823EC5962F1FFFFFFF3F4FD8C93F57C83F4949BF6949BF6747CF32934ED29
          34ED060FEA3B45EF0000FFFFFFFFFFFFE6E8FD4C55F0212CED2934ED6B73F24C
          55F0060FEA060FEA060FEA060FEA7C83F4F7F7FEFDFDFF646CF2060FEA060FEA
          060FEA060FEA060FEA1823EC1823EC646CF2FFFFFFCED1FB1823EC060FEA1823
          EC848BF52934ED060FEA1823EC060FEA1823ECB4B9F9FFFFFFFFFFFF9CA2F632
          3CEE060FEA060FEA060FEA060FEA060FEA7C83F4F7F7FEFFFFFF8C93F53B45EF
          212CED060FEA060FEA060FEA060FEA060FEA060FEA1823EC060FEA1823EC747C
          F33B45EF060FEA060FEA060FEA1823ECACB2F8FFFFFFFAFAFE3B45EF060FEA06
          0FEA060FEA060FEA060FEA1823EC060FEA8C93F50000FFFFFFFFFFFFFFFFFF6B
          73F2212CED212CED5962F1ECEDFD9CA2F66B73F2646CF2949BF6ECEDFDFFFFFF
          FFFFFFCED1FB848BF58C93F58C93F5848BF5848BF5848BF5ACB2F8ECEDFDFFFF
          FFECEDFD949BF6747CF3848BF5E6E8FDD7D9FB848BF56B73F26B73F2B4B9F9FD
          FDFFFFFFFFFFFFFFFFFFFFD7D9FB9CA2F66B73F26B73F2747CF3ACB2F8F7F7FE
          FFFFFFFFFFFFFDFDFFCED1FB9CA2F6A4AAF79CA2F6949BF6949BF6949BF6949B
          F6848BF5848BF5848BF5D7D9FBECEDFD949BF6747CF37C83F4B4B9F9FDFDFFFF
          FFFFFFFFFFBDC1F9848BF58C93F58C93F5848BF5848BF58C93F5B4B9F9F7F7FE
          0000FFFFFFFFFFFFFFFFFF8C93F5212CED2934ED2934EDE2E4FCFFFFFFF7F7FE
          F3F4FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFDFDFFFDFDFFFDFDFFFDFD
          FFFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFDFDFFFAFAFEFDFDFFFFFFFFFD
          FDFFF7F7FEF7F7FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFAFAFE
          F7F7FEFAFAFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6CAFA3B45EF6B73F28C93
          F5ACB2F8C6CAFADDDFFCF3F4FDFDFDFFFFFFFFFDFDFFFAFAFEFDFDFFFFFFFFFD
          FDFFF3F4FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFDFDFFFDFDFFFDFDFF
          FDFDFFFDFDFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFACB2F8212CED2934ED
          212CEDACB2F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFD7D9FB1823EC060FEA1823EC212CED212CED2934ED323CEE323CEE3B45EF3B
          45EF3B45EF3B45EF3B45EF3B45EF2934EDBDC1F9FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFCED1FB323CEE2934ED1823EC7C83F4FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FEACB2F8747CF35962F1323CEE2934ED21
          2CED212CED212CED212CED212CED212CED212CED212CED2934ED1823EC848BF5
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFAFAFE3B45EF1823EC060FEA4C55F0FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FE848BF559
          62F1ACB2F8ACB2F8A4AAF7949BF6747CF3646CF25962F14C55F03B45EF3B45EF
          3B45EF323CEE2934ED5962F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFACB2
          F8848BF5848BF59CA2F6FAFAFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF949BF6060FEA060FEA2934ED5962F17C83F49CA2F6B4B9F9
          C6CAFAC6CAFACED1FBC6CAFABDC1F9B4B9F9ACB2F8BDC1F9FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6E8FD7C83F43B45EF060FEA
          060FEA060FEA060FEA1823EC2934ED3B45EF5962F1646CF26B73F26B73F26B73
          F2646CF2CED1FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFDDDFFCA4AAF76B73F23B45EF212CED1823EC060FEA060FEA060F
          EA060FEA1823EC1823EC1823EC060FEA949BF6FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FED7D9FBC6CA
          FA949BF6646CF24C55F0323CEE2934ED212CED212CED212CED060FEA6B73F2FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFF3F4FDE6E8FDDDDFFCCED1FBB4B9F9A4
          AAF79CA2F68C93F5B4B9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000}
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
        OnPrint = QRLabel58Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel59: TQRLabel
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
        OnPrint = QRLabel61Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel62: TQRLabel
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
        OnPrint = QRLabel62Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel63: TQRLabel
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
        OnPrint = QRLabel63Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel64: TQRLabel
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
        OnPrint = QRLabel64Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel65: TQRLabel
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
        Top = 1116
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555560000
          70.555555555555560000
          2460.625000000000000000
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
        Caption = '033-7'
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
        OnPrint = QRLabel40Print
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
        OnPrint = QRLabel42Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRImage1: TQRImage
        Left = 7
        Top = 771
        Width = 93
        Height = 30
        Size.Values = (
          66.145833333333300000
          16.536458333333300000
          1699.947916666670000000
          205.052083333333000000)
        XLColumn = 0
        AutoSize = True
        Picture.Data = {
          07544269746D617042170000424D421700000000000036000000280000004E00
          00001900000001001800000000000C1700000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFF7F7FEB4B9F9ACB2F89CA2F6CED1FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF3F4FD3B45EF1823EC1823EC646CF2FDFDFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6B73F218
          23EC212CED3B45EFE6E8FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FDFDFFFAFAFEF7F7FEF7F7FEFDFDFFFFFFFFF7F7FEECEDFDF3F4
          FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFEECEDFDECEDFDFFFFFFFFFFFFFA
          FAFEF7F7FEF7F7FEFDFDFFFAFAFEF7F7FEF7F7FEF7F7FEFDFDFFFFFFFFFDFDFF
          FAFAFEF7F7FEF7F7FEFAFAFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFAFA
          FEF7F7FEFAFAFEFAFAFEFDFDFFFDFDFFF7F7FEFAFAFEFAFAFEFAFAFEFFFFFFFF
          FFFFFFFFFFFFFFFF9CA2F61823EC212CED2934EDCED1FBFFFFFFF7F7FEE6E8FD
          F3F4FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FEECEDFDF3F4FDFDFDFFFFFF
          FFF3F4FDF3F4FDFAFAFEFDFDFFFFFFFF0000ECEDFD848BF56B73F26B73F2D7D9
          FBDDDFFC6B73F24C55F0646CF2ACB2F8ECEDFDFFFFFFFFFFFFCED1FB747CF34C
          55F04C55F08C93F5E2E4FCACB2F8646CF26B73F2CED1FBD7D9FB747CF36B73F2
          646CF2BDC1F9FFFFFFFFFFFFA4AAF76B73F26B73F2848BF5F3F4FDFFFFFFFFFF
          FFD7D9FBA4AAF78C93F5747CF36B73F26B73F2646CF2CED1FBD7D9FB6B73F26B
          73F26B73F26B73F2848BF5A4AAF7DDDFFCFFFFFFBDC1F9212CED212CED212CED
          BDC1F9CED1FB5962F14C55F0646CF2ACB2F8F3F4FDFFFFFFFFFFFFBDC1F9646C
          F24C55F05962F19CA2F6DDDFFC848BF5646CF2747CF3CED1FBFFFFFF0000ECED
          FD4C55F0060FEA060FEA747CF33B45EF060FEA060FEA060FEA060FEA646CF2F3
          F4FDECEDFD3B45EF060FEA1823EC060FEA060FEA323CEE323CEE060FEA060FEA
          747CF3DDDFFC212CED060FEA060FEA747CF3FDFDFFFFFFFF848BF5060FEA060F
          EA1823ECCED1FBFFFFFFB4B9F92934ED1823EC060FEA060FEA060FEA060FEA06
          0FEA6B73F2ACB2F81823EC060FEA060FEA060FEA060FEA060FEA323CEEC6CAFA
          E6E8FD3B45EF212CED2934ED6B73F23B45EF060FEA060FEA060FEA060FEA6B73
          F2FFFFFFCED1FB2934ED060FEA1823EC060FEA060FEA323CEE323CEE060FEA06
          0FEA7C83F4FFFFFF0000FFFFFF8C93F51823EC323CEE2934ED212CED7C83F464
          6CF2212CED212CED060FEA949BF6C6CAFA1823EC2934ED2934ED848BF5B4B9F9
          6B73F2212CED323CEE2934ED4C55F0F3F4FD646CF2212CED1823EC5962F1F3F4
          FDFFFFFFBDC1F9212CED2934ED2934EDB4B9F9F3F4FD323CEE060FEA212CED4C
          55F08C93F5949BF6949BF68C93F5ACB2F8E6E8FDA4AAF7949BF6949BF69CA2F6
          6B73F22934ED060FEA3B45EFECEDFD646CF2212CED323CEE1823EC3B45EF9CA2
          F66B73F22934ED212CED1823ECA4AAF7B4B9F9060FEA2934ED3B45EF949BF6AC
          B2F85962F1212CED323CEE1823EC646CF2FAFAFE0000FFFFFFA4AAF71823EC29
          34ED1823EC6B73F2FDFDFFECEDFD646CF21823EC1823EC3B45EFB4B9F9323CEE
          2934ED323CEEE2E4FCFFFFFFFFFFFF7C83F4212CED2934ED323CEEECEDFD7C83
          F41823EC1823EC3B45EFDDDFFCFFFFFFE6E8FD3B45EF2934ED212CED949BF6BD
          C1F91823EC212CED2934EDCED1FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFD7D9FB3B45EF212CED060FEABDC1F9848BF5212C
          ED2934ED212CED9CA2F6FFFFFFFDFDFF5962F1212CED2934ED3B45EF9CA2F621
          2CED1823EC4C55F0E2E4FCFFFFFFF3F4FD6B73F2212CED212CED4C55F0E6E8FD
          0000FFFFFFCED1FB323CEE212CED1823EC8C93F5FDFDFFFFFFFFC6CAFA2934ED
          212CED1823EC9CA2F6646CF21823EC2934ED8C93F5FFFFFFFFFFFFE2E4FC3B45
          EF212CED1823ECBDC1F9B4B9F91823EC212CED2934EDC6CAFAFFFFFFFDFDFF4C
          55F0212CED212CED747CF3B4B9F9212CED212CED3B45EFE2E4FCECEDFDECEDFD
          ECEDFDECEDFDE6E8FDE6E8FDFDFDFFFFFFFFCED1FB8C93F54C55F02934ED323C
          EE1823EC949BF6A4AAF71823EC2934ED212CEDA4AAF7FFFFFFFFFFFFA4AAF721
          2CED2934ED2934ED8C93F55962F11823EC2934EDACB2F8FFFFFFFFFFFFD7D9FB
          2934ED1823EC3B45EFD7D9FB0000FFFFFFECEDFD4C55F01823EC1823EC7C83F4
          FDFDFFFFFFFFECEDFD5962F11823EC1823EC646CF2C6CAFA323CEE1823EC212C
          ED646CF2A4AAF7C6CAFA4C55F0212CED212CED8C93F5DDDFFC2934ED212CED18
          23ECA4AAF7FFFFFFFFFFFF6B73F21823EC212CED5962F1B4B9F9323CEE212CED
          323CEE3B45EF323CEE323CEE323CEE3B45EF323CEE4C55F0D7D9FB9CA2F6212C
          ED1823EC212CED2934ED212CED1823ECB4B9F9D7D9FB212CED2934ED1823EC94
          9BF6FFFFFFFFFFFFE6E8FD323CEE212CED212CED848BF5C6CAFA212CED060FEA
          2934ED747CF3ACB2F8B4B9F93B45EF212CED212CEDACB2F80000FFFFFFFAFAFE
          6B73F21823EC1823EC5962F1F7F7FEFFFFFFF3F4FD6B73F21823EC2934ED2934
          EDE2E4FCD7D9FB646CF22934ED060FEA1823EC212CED212CED323CEE212CED6B
          73F2ECEDFD3B45EF212CED1823EC7C83F4FDFDFFFFFFFFA4AAF71823EC2934ED
          3B45EFB4B9F94C55F0212CED323CEE323CEE3B45EF3B45EF3B45EF212CED1823
          EC1823ECA4AAF73B45EF212CED323CEE2934ED1823EC2934ED9CA2F6FAFAFEFA
          FAFE3B45EF2934ED212CED747CF3FFFFFFFFFFFFFAFAFE4C55F0212CED212CED
          4C55F0FAFAFECED1FB646CF2212CED060FEA1823EC212CED212CED323CEE1823
          EC8C93F50000FFFFFFFFFFFF848BF51823EC2934ED212CEDC6CAFAFFFFFFFFFF
          FF949BF61823EC2934ED1823ECC6CAFAFFFFFFFFFFFFE6E8FDBDC1F9ACB2F8B4
          B9F98C93F5323CEE212CED4C55F0ECEDFD646CF21823EC212CED3B45EFE2E4FC
          FFFFFFD7D9FB212CED2934ED2934EDB4B9F97C83F41823EC212CED949BF6FFFF
          FFFFFFFFF7F7FE6B73F21823EC212CED949BF63B45EF323CEE2934ED4C55F0AC
          B2F8F3F4FDFFFFFFFFFFFFFDFDFF646CF2212CED212CED3B45EFD7D9FBFFFFFF
          FFFFFF5962F1212CED212CED3B45EFDDDFFCFFFFFFFFFFFFE6E8FDB4B9F9ACB2
          F8ACB2F87C83F41823EC1823EC6B73F20000FFFFFFFFFFFFACB2F8212CED2934
          ED1823EC6B73F2F3F4FDFDFDFF7C83F41823EC323CEE1823ECC6CAFAFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFACB2F82934ED212CED323CEED7D9FB9CA2F6
          1823EC323CEE212CED848BF5DDDFFCB4B9F9212CED323CEE1823EC9CA2F6D7D9
          FB2934ED060FEA3B45EFD7D9FBFFFFFFF3F4FD646CF21823EC1823ECA4AAF74C
          55F0212CED2934ED848BF5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9CA2F61823EC
          323CEE1823EC646CF2ECEDFDECEDFD4C55F02934ED212CED3B45EFE2E4FCFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFF949BF61823EC212CED4C55F00000FFFF
          FFFFFFFFCED1FB323CEE212CED323CEE212CED4C55F06B73F2323CEE2934ED21
          2CED1823ECD7D9FBFFFFFF9CA2F6747CF38C93F5949BF67C83F43B45EF2934ED
          212CED1823ECDDDFFCC6CAFA1823EC2934ED323CEE212CED212CED2934ED323C
          EE323CEE060FEA7C83F4FFFFFFA4AAF71823EC060FEA3B45EFB4B9F98C93F532
          3CEE1823EC1823ECCED1FBACB2F8060FEA1823EC2934ED747CF3949BF68C93F5
          8C93F5949BF66B73F22934ED323CEE2934ED1823EC3B45EF4C55F0323CEE323C
          EE1823EC5962F1FFFFFFF3F4FD8C93F57C83F4949BF6949BF6747CF32934ED29
          34ED060FEA3B45EF0000FFFFFFFFFFFFE6E8FD4C55F0212CED2934ED6B73F24C
          55F0060FEA060FEA060FEA060FEA7C83F4F7F7FEFDFDFF646CF2060FEA060FEA
          060FEA060FEA060FEA1823EC1823EC646CF2FFFFFFCED1FB1823EC060FEA1823
          EC848BF52934ED060FEA1823EC060FEA1823ECB4B9F9FFFFFFFFFFFF9CA2F632
          3CEE060FEA060FEA060FEA060FEA060FEA7C83F4F7F7FEFFFFFF8C93F53B45EF
          212CED060FEA060FEA060FEA060FEA060FEA060FEA1823EC060FEA1823EC747C
          F33B45EF060FEA060FEA060FEA1823ECACB2F8FFFFFFFAFAFE3B45EF060FEA06
          0FEA060FEA060FEA060FEA1823EC060FEA8C93F50000FFFFFFFFFFFFFFFFFF6B
          73F2212CED212CED5962F1ECEDFD9CA2F66B73F2646CF2949BF6ECEDFDFFFFFF
          FFFFFFCED1FB848BF58C93F58C93F5848BF5848BF5848BF5ACB2F8ECEDFDFFFF
          FFECEDFD949BF6747CF3848BF5E6E8FDD7D9FB848BF56B73F26B73F2B4B9F9FD
          FDFFFFFFFFFFFFFFFFFFFFD7D9FB9CA2F66B73F26B73F2747CF3ACB2F8F7F7FE
          FFFFFFFFFFFFFDFDFFCED1FB9CA2F6A4AAF79CA2F6949BF6949BF6949BF6949B
          F6848BF5848BF5848BF5D7D9FBECEDFD949BF6747CF37C83F4B4B9F9FDFDFFFF
          FFFFFFFFFFBDC1F9848BF58C93F58C93F5848BF5848BF58C93F5B4B9F9F7F7FE
          0000FFFFFFFFFFFFFFFFFF8C93F5212CED2934ED2934EDE2E4FCFFFFFFF7F7FE
          F3F4FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFDFDFFFDFDFFFDFDFFFDFD
          FFFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFDFDFFFAFAFEFDFDFFFFFFFFFD
          FDFFF7F7FEF7F7FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFAFAFE
          F7F7FEFAFAFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6CAFA3B45EF6B73F28C93
          F5ACB2F8C6CAFADDDFFCF3F4FDFDFDFFFFFFFFFDFDFFFAFAFEFDFDFFFFFFFFFD
          FDFFF3F4FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFDFDFFFDFDFFFDFDFF
          FDFDFFFDFDFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFACB2F8212CED2934ED
          212CEDACB2F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFD7D9FB1823EC060FEA1823EC212CED212CED2934ED323CEE323CEE3B45EF3B
          45EF3B45EF3B45EF3B45EF3B45EF2934EDBDC1F9FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFCED1FB323CEE2934ED1823EC7C83F4FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FEACB2F8747CF35962F1323CEE2934ED21
          2CED212CED212CED212CED212CED212CED212CED212CED2934ED1823EC848BF5
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFAFAFE3B45EF1823EC060FEA4C55F0FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FE848BF559
          62F1ACB2F8ACB2F8A4AAF7949BF6747CF3646CF25962F14C55F03B45EF3B45EF
          3B45EF323CEE2934ED5962F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFACB2
          F8848BF5848BF59CA2F6FAFAFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF949BF6060FEA060FEA2934ED5962F17C83F49CA2F6B4B9F9
          C6CAFAC6CAFACED1FBC6CAFABDC1F9B4B9F9ACB2F8BDC1F9FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6E8FD7C83F43B45EF060FEA
          060FEA060FEA060FEA1823EC2934ED3B45EF5962F1646CF26B73F26B73F26B73
          F2646CF2CED1FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFDDDFFCA4AAF76B73F23B45EF212CED1823EC060FEA060FEA060F
          EA060FEA1823EC1823EC1823EC060FEA949BF6FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FED7D9FBC6CA
          FA949BF6646CF24C55F0323CEE2934ED212CED212CED212CED060FEA6B73F2FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFF3F4FDE6E8FDDDDFFCCED1FBB4B9F9A4
          AAF79CA2F68C93F5B4B9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000}
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
        OnPrint = QRLabel48Print
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
        OnPrint = QRLabel50Print
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
        OnPrint = QRLabel51Print
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
        OnPrint = QRLabel56Print
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
        OnPrint = QRLabel54Print
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
        OnPrint = QRLabel57Print
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
        OnPrint = QRLabel70Print
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
        OnPrint = QRLabel71Print
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
        OnPrint = QRLabel60Print
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
        OnPrint = QRLabel78Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel79: TQRLabel
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
        OnPrint = QRLabel67Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 11
      end
      object QRLabel80: TQRLabel
        Left = 818
        Top = 754
        Width = 19
        Height = 19
        Size.Values = (
          41.892361111111110000
          1803.576388888889000000
          1662.465277777778000000
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
          50.711805555555560000
          70.555555555555560000
          2500.312500000000000000
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
        Top = 1152
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555560000
          70.555555555555560000
          2540.000000000000000000
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
        OnPrint = QRLabel83Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel84: TQRLabel
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
      object QRLabel73: TQRLabel
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
        OnPrint = QRLabel73Print
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
        OnPrint = QRLabel61Print
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
        OnPrint = QRLabel62Print
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
        OnPrint = QRLabel63Print
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
        OnPrint = QRLabel64Print
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
        OnPrint = QRLabel65Print
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
        OnPrint = QRLabel83Print
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
        OnPrint = QRLabel84Print
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
        Caption = '033-7'
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
      object QRImage3: TQRImage
        Left = 7
        Top = 374
        Width = 93
        Height = 30
        Size.Values = (
          66.145833333333300000
          16.536458333333300000
          823.515625000000000000
          205.052083333333000000)
        XLColumn = 0
        AutoSize = True
        Picture.Data = {
          07544269746D617042170000424D421700000000000036000000280000004E00
          00001900000001001800000000000C1700000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFF7F7FEB4B9F9ACB2F89CA2F6CED1FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF3F4FD3B45EF1823EC1823EC646CF2FDFDFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6B73F218
          23EC212CED3B45EFE6E8FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FDFDFFFAFAFEF7F7FEF7F7FEFDFDFFFFFFFFF7F7FEECEDFDF3F4
          FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFEECEDFDECEDFDFFFFFFFFFFFFFA
          FAFEF7F7FEF7F7FEFDFDFFFAFAFEF7F7FEF7F7FEF7F7FEFDFDFFFFFFFFFDFDFF
          FAFAFEF7F7FEF7F7FEFAFAFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFAFA
          FEF7F7FEFAFAFEFAFAFEFDFDFFFDFDFFF7F7FEFAFAFEFAFAFEFAFAFEFFFFFFFF
          FFFFFFFFFFFFFFFF9CA2F61823EC212CED2934EDCED1FBFFFFFFF7F7FEE6E8FD
          F3F4FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FEECEDFDF3F4FDFDFDFFFFFF
          FFF3F4FDF3F4FDFAFAFEFDFDFFFFFFFF0000ECEDFD848BF56B73F26B73F2D7D9
          FBDDDFFC6B73F24C55F0646CF2ACB2F8ECEDFDFFFFFFFFFFFFCED1FB747CF34C
          55F04C55F08C93F5E2E4FCACB2F8646CF26B73F2CED1FBD7D9FB747CF36B73F2
          646CF2BDC1F9FFFFFFFFFFFFA4AAF76B73F26B73F2848BF5F3F4FDFFFFFFFFFF
          FFD7D9FBA4AAF78C93F5747CF36B73F26B73F2646CF2CED1FBD7D9FB6B73F26B
          73F26B73F26B73F2848BF5A4AAF7DDDFFCFFFFFFBDC1F9212CED212CED212CED
          BDC1F9CED1FB5962F14C55F0646CF2ACB2F8F3F4FDFFFFFFFFFFFFBDC1F9646C
          F24C55F05962F19CA2F6DDDFFC848BF5646CF2747CF3CED1FBFFFFFF0000ECED
          FD4C55F0060FEA060FEA747CF33B45EF060FEA060FEA060FEA060FEA646CF2F3
          F4FDECEDFD3B45EF060FEA1823EC060FEA060FEA323CEE323CEE060FEA060FEA
          747CF3DDDFFC212CED060FEA060FEA747CF3FDFDFFFFFFFF848BF5060FEA060F
          EA1823ECCED1FBFFFFFFB4B9F92934ED1823EC060FEA060FEA060FEA060FEA06
          0FEA6B73F2ACB2F81823EC060FEA060FEA060FEA060FEA060FEA323CEEC6CAFA
          E6E8FD3B45EF212CED2934ED6B73F23B45EF060FEA060FEA060FEA060FEA6B73
          F2FFFFFFCED1FB2934ED060FEA1823EC060FEA060FEA323CEE323CEE060FEA06
          0FEA7C83F4FFFFFF0000FFFFFF8C93F51823EC323CEE2934ED212CED7C83F464
          6CF2212CED212CED060FEA949BF6C6CAFA1823EC2934ED2934ED848BF5B4B9F9
          6B73F2212CED323CEE2934ED4C55F0F3F4FD646CF2212CED1823EC5962F1F3F4
          FDFFFFFFBDC1F9212CED2934ED2934EDB4B9F9F3F4FD323CEE060FEA212CED4C
          55F08C93F5949BF6949BF68C93F5ACB2F8E6E8FDA4AAF7949BF6949BF69CA2F6
          6B73F22934ED060FEA3B45EFECEDFD646CF2212CED323CEE1823EC3B45EF9CA2
          F66B73F22934ED212CED1823ECA4AAF7B4B9F9060FEA2934ED3B45EF949BF6AC
          B2F85962F1212CED323CEE1823EC646CF2FAFAFE0000FFFFFFA4AAF71823EC29
          34ED1823EC6B73F2FDFDFFECEDFD646CF21823EC1823EC3B45EFB4B9F9323CEE
          2934ED323CEEE2E4FCFFFFFFFFFFFF7C83F4212CED2934ED323CEEECEDFD7C83
          F41823EC1823EC3B45EFDDDFFCFFFFFFE6E8FD3B45EF2934ED212CED949BF6BD
          C1F91823EC212CED2934EDCED1FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFD7D9FB3B45EF212CED060FEABDC1F9848BF5212C
          ED2934ED212CED9CA2F6FFFFFFFDFDFF5962F1212CED2934ED3B45EF9CA2F621
          2CED1823EC4C55F0E2E4FCFFFFFFF3F4FD6B73F2212CED212CED4C55F0E6E8FD
          0000FFFFFFCED1FB323CEE212CED1823EC8C93F5FDFDFFFFFFFFC6CAFA2934ED
          212CED1823EC9CA2F6646CF21823EC2934ED8C93F5FFFFFFFFFFFFE2E4FC3B45
          EF212CED1823ECBDC1F9B4B9F91823EC212CED2934EDC6CAFAFFFFFFFDFDFF4C
          55F0212CED212CED747CF3B4B9F9212CED212CED3B45EFE2E4FCECEDFDECEDFD
          ECEDFDECEDFDE6E8FDE6E8FDFDFDFFFFFFFFCED1FB8C93F54C55F02934ED323C
          EE1823EC949BF6A4AAF71823EC2934ED212CEDA4AAF7FFFFFFFFFFFFA4AAF721
          2CED2934ED2934ED8C93F55962F11823EC2934EDACB2F8FFFFFFFFFFFFD7D9FB
          2934ED1823EC3B45EFD7D9FB0000FFFFFFECEDFD4C55F01823EC1823EC7C83F4
          FDFDFFFFFFFFECEDFD5962F11823EC1823EC646CF2C6CAFA323CEE1823EC212C
          ED646CF2A4AAF7C6CAFA4C55F0212CED212CED8C93F5DDDFFC2934ED212CED18
          23ECA4AAF7FFFFFFFFFFFF6B73F21823EC212CED5962F1B4B9F9323CEE212CED
          323CEE3B45EF323CEE323CEE323CEE3B45EF323CEE4C55F0D7D9FB9CA2F6212C
          ED1823EC212CED2934ED212CED1823ECB4B9F9D7D9FB212CED2934ED1823EC94
          9BF6FFFFFFFFFFFFE6E8FD323CEE212CED212CED848BF5C6CAFA212CED060FEA
          2934ED747CF3ACB2F8B4B9F93B45EF212CED212CEDACB2F80000FFFFFFFAFAFE
          6B73F21823EC1823EC5962F1F7F7FEFFFFFFF3F4FD6B73F21823EC2934ED2934
          EDE2E4FCD7D9FB646CF22934ED060FEA1823EC212CED212CED323CEE212CED6B
          73F2ECEDFD3B45EF212CED1823EC7C83F4FDFDFFFFFFFFA4AAF71823EC2934ED
          3B45EFB4B9F94C55F0212CED323CEE323CEE3B45EF3B45EF3B45EF212CED1823
          EC1823ECA4AAF73B45EF212CED323CEE2934ED1823EC2934ED9CA2F6FAFAFEFA
          FAFE3B45EF2934ED212CED747CF3FFFFFFFFFFFFFAFAFE4C55F0212CED212CED
          4C55F0FAFAFECED1FB646CF2212CED060FEA1823EC212CED212CED323CEE1823
          EC8C93F50000FFFFFFFFFFFF848BF51823EC2934ED212CEDC6CAFAFFFFFFFFFF
          FF949BF61823EC2934ED1823ECC6CAFAFFFFFFFFFFFFE6E8FDBDC1F9ACB2F8B4
          B9F98C93F5323CEE212CED4C55F0ECEDFD646CF21823EC212CED3B45EFE2E4FC
          FFFFFFD7D9FB212CED2934ED2934EDB4B9F97C83F41823EC212CED949BF6FFFF
          FFFFFFFFF7F7FE6B73F21823EC212CED949BF63B45EF323CEE2934ED4C55F0AC
          B2F8F3F4FDFFFFFFFFFFFFFDFDFF646CF2212CED212CED3B45EFD7D9FBFFFFFF
          FFFFFF5962F1212CED212CED3B45EFDDDFFCFFFFFFFFFFFFE6E8FDB4B9F9ACB2
          F8ACB2F87C83F41823EC1823EC6B73F20000FFFFFFFFFFFFACB2F8212CED2934
          ED1823EC6B73F2F3F4FDFDFDFF7C83F41823EC323CEE1823ECC6CAFAFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFACB2F82934ED212CED323CEED7D9FB9CA2F6
          1823EC323CEE212CED848BF5DDDFFCB4B9F9212CED323CEE1823EC9CA2F6D7D9
          FB2934ED060FEA3B45EFD7D9FBFFFFFFF3F4FD646CF21823EC1823ECA4AAF74C
          55F0212CED2934ED848BF5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9CA2F61823EC
          323CEE1823EC646CF2ECEDFDECEDFD4C55F02934ED212CED3B45EFE2E4FCFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFF949BF61823EC212CED4C55F00000FFFF
          FFFFFFFFCED1FB323CEE212CED323CEE212CED4C55F06B73F2323CEE2934ED21
          2CED1823ECD7D9FBFFFFFF9CA2F6747CF38C93F5949BF67C83F43B45EF2934ED
          212CED1823ECDDDFFCC6CAFA1823EC2934ED323CEE212CED212CED2934ED323C
          EE323CEE060FEA7C83F4FFFFFFA4AAF71823EC060FEA3B45EFB4B9F98C93F532
          3CEE1823EC1823ECCED1FBACB2F8060FEA1823EC2934ED747CF3949BF68C93F5
          8C93F5949BF66B73F22934ED323CEE2934ED1823EC3B45EF4C55F0323CEE323C
          EE1823EC5962F1FFFFFFF3F4FD8C93F57C83F4949BF6949BF6747CF32934ED29
          34ED060FEA3B45EF0000FFFFFFFFFFFFE6E8FD4C55F0212CED2934ED6B73F24C
          55F0060FEA060FEA060FEA060FEA7C83F4F7F7FEFDFDFF646CF2060FEA060FEA
          060FEA060FEA060FEA1823EC1823EC646CF2FFFFFFCED1FB1823EC060FEA1823
          EC848BF52934ED060FEA1823EC060FEA1823ECB4B9F9FFFFFFFFFFFF9CA2F632
          3CEE060FEA060FEA060FEA060FEA060FEA7C83F4F7F7FEFFFFFF8C93F53B45EF
          212CED060FEA060FEA060FEA060FEA060FEA060FEA1823EC060FEA1823EC747C
          F33B45EF060FEA060FEA060FEA1823ECACB2F8FFFFFFFAFAFE3B45EF060FEA06
          0FEA060FEA060FEA060FEA1823EC060FEA8C93F50000FFFFFFFFFFFFFFFFFF6B
          73F2212CED212CED5962F1ECEDFD9CA2F66B73F2646CF2949BF6ECEDFDFFFFFF
          FFFFFFCED1FB848BF58C93F58C93F5848BF5848BF5848BF5ACB2F8ECEDFDFFFF
          FFECEDFD949BF6747CF3848BF5E6E8FDD7D9FB848BF56B73F26B73F2B4B9F9FD
          FDFFFFFFFFFFFFFFFFFFFFD7D9FB9CA2F66B73F26B73F2747CF3ACB2F8F7F7FE
          FFFFFFFFFFFFFDFDFFCED1FB9CA2F6A4AAF79CA2F6949BF6949BF6949BF6949B
          F6848BF5848BF5848BF5D7D9FBECEDFD949BF6747CF37C83F4B4B9F9FDFDFFFF
          FFFFFFFFFFBDC1F9848BF58C93F58C93F5848BF5848BF58C93F5B4B9F9F7F7FE
          0000FFFFFFFFFFFFFFFFFF8C93F5212CED2934ED2934EDE2E4FCFFFFFFF7F7FE
          F3F4FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFDFDFFFDFDFFFDFDFFFDFD
          FFFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFDFDFFFAFAFEFDFDFFFFFFFFFD
          FDFFF7F7FEF7F7FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFAFAFE
          F7F7FEFAFAFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6CAFA3B45EF6B73F28C93
          F5ACB2F8C6CAFADDDFFCF3F4FDFDFDFFFFFFFFFDFDFFFAFAFEFDFDFFFFFFFFFD
          FDFFF3F4FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFDFDFFFDFDFFFDFDFF
          FDFDFFFDFDFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFACB2F8212CED2934ED
          212CEDACB2F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFD7D9FB1823EC060FEA1823EC212CED212CED2934ED323CEE323CEE3B45EF3B
          45EF3B45EF3B45EF3B45EF3B45EF2934EDBDC1F9FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFCED1FB323CEE2934ED1823EC7C83F4FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FEACB2F8747CF35962F1323CEE2934ED21
          2CED212CED212CED212CED212CED212CED212CED212CED2934ED1823EC848BF5
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFAFAFE3B45EF1823EC060FEA4C55F0FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FE848BF559
          62F1ACB2F8ACB2F8A4AAF7949BF6747CF3646CF25962F14C55F03B45EF3B45EF
          3B45EF323CEE2934ED5962F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFACB2
          F8848BF5848BF59CA2F6FAFAFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF949BF6060FEA060FEA2934ED5962F17C83F49CA2F6B4B9F9
          C6CAFAC6CAFACED1FBC6CAFABDC1F9B4B9F9ACB2F8BDC1F9FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6E8FD7C83F43B45EF060FEA
          060FEA060FEA060FEA1823EC2934ED3B45EF5962F1646CF26B73F26B73F26B73
          F2646CF2CED1FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFDDDFFCA4AAF76B73F23B45EF212CED1823EC060FEA060FEA060F
          EA060FEA1823EC1823EC1823EC060FEA949BF6FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FED7D9FBC6CA
          FA949BF6646CF24C55F0323CEE2934ED212CED212CED212CED060FEA6B73F2FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFF3F4FDE6E8FDDDDFFCCED1FBB4B9F9A4
          AAF79CA2F68C93F5B4B9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000}
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
        OnPrint = QRLabel48Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel123: TQRLabel
        Left = 686
        Top = 419
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          923.395833333333000000
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
        OnPrint = QRLabel70Print
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
        Top = 365
        Width = 19
        Height = 19
        Size.Values = (
          41.892361111111110000
          1803.576388888889000000
          804.774305555555600000
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
        OnPrint = QRLabel61Print
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
        OnPrint = QRLabel62Print
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
        OnPrint = QRLabel63Print
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
        OnPrint = QRLabel64Print
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
        OnPrint = QRLabel83Print
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
        OnPrint = QRLabel84Print
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
        OnPrint = QRLabel73Print
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
      object QRLabel10: TQRLabel
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
