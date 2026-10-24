object frmQckBradesco_Pro: TfrmQckBradesco_Pro
  Left = 116
  Top = 20
  Width = 1005
  Height = 776
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
        Left = 5
        Top = 455
        Width = 853
        Height = 1
        Size.Values = (
          2.645833333333330000
          10.583333333333300000
          1002.770833333330000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal5: TQRShape
        Left = 2
        Top = 340
        Width = 853
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          748.770833333333000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal4: TQRShape
        Left = 2
        Top = 310
        Width = 853
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          682.625000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal3: TQRShape
        Left = 5
        Top = 280
        Width = 853
        Height = 5
        Size.Values = (
          10.583333333333300000
          10.583333333333300000
          616.479166666667000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal1: TQRShape
        Left = 5
        Top = 214
        Width = 853
        Height = 13
        Size.Values = (
          29.104166666666700000
          10.583333333333300000
          470.958333333333000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal2: TQRShape
        Left = 5
        Top = 251
        Width = 853
        Height = 1
        Size.Values = (
          2.645833333333330000
          10.583333333333300000
          552.979166666667000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaVertical1: TQRShape
        Left = 191
        Top = 196
        Width = 12
        Height = 24
        Size.Values = (
          52.916666666666700000
          420.687500000000000000
          431.270833333333000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelNrBanco: TQRLabel
        Left = 199
        Top = 196
        Width = 83
        Height = 24
        Size.Values = (
          52.916666666666700000
          439.208333333333000000
          431.270833333333000000
          182.562500000000000000)
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
        Top = 222
        Width = 48
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          489.479166666666700000
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
        Top = 196
        Width = 11
        Height = 24
        Size.Values = (
          52.916666666666700000
          619.125000000000000000
          431.270833333333000000
          23.812500000000000000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelLocalPagamento: TQRLabel
        Left = 5
        Top = 222
        Width = 82
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          489.479166666666700000
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
        Top = 254
        Width = 49
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          560.034722222222200000
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
        Left = 56
        Top = 258
        Width = 604
        Height = 18
        Size.Values = (
          39.687500000000000000
          123.472222222222200000
          568.854166666666700000
          1331.736111111111000000)
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
        Top = 254
        Width = 89
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          560.034722222222200000
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
        Top = 283
        Width = 78
        Height = 10
        Size.Values = (
          22.048611111111110000
          11.024305555555560000
          623.975694444444400000
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
        Top = 283
        Width = 70
        Height = 10
        Size.Values = (
          22.048611111111110000
          319.704861111111100000
          623.975694444444400000
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
        Top = 283
        Width = 54
        Height = 10
        Size.Values = (
          22.048611111111110000
          738.628472222222200000
          623.975694444444400000
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
        Top = 283
        Width = 26
        Height = 10
        Size.Values = (
          22.048611111111110000
          915.017361111111100000
          623.975694444444400000
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
        Top = 283
        Width = 96
        Height = 10
        Size.Values = (
          22.048611111111110000
          1047.309027777778000000
          623.975694444444400000
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
        Top = 283
        Width = 84
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          623.975694444444400000
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
        Top = 312
        Width = 56
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          687.916666666666700000
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
        Top = 312
        Width = 20
        Height = 13
        Size.Values = (
          28.663194444444440000
          372.621527777777800000
          687.916666666666700000
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
        Top = 312
        Width = 44
        Height = 11
        Size.Values = (
          24.253472222222220000
          500.503472222222200000
          687.916666666666700000
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
        Left = 229
        Top = 322
        Width = 74
        Height = 18
        Size.Values = (
          39.687500000000000000
          505.354166666667000000
          709.083333333333000000
          164.041666666667000000)
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
        Top = 312
        Width = 46
        Height = 13
        Size.Values = (
          28.663194444444440000
          698.940972222222200000
          687.916666666666700000
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
        Top = 312
        Width = 41
        Height = 13
        Size.Values = (
          28.663194444444440000
          1298.663194444444000000
          687.916666666666700000
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
        Top = 312
        Width = 10
        Height = 19
        Size.Values = (
          41.892361111111110000
          1270.000000000000000000
          687.916666666666700000
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
        Top = 312
        Width = 94
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          687.916666666666700000
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
        Top = 341
        Width = 43
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          751.857638888888900000
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
        Top = 342
        Width = 95
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          754.062500000000000000
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
        Top = 386
        Width = 55
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          851.076388888888900000
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
        Top = 437
        Width = 71
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          963.524305555555600000
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
        Top = 458
        Width = 38
        Height = 13
        Size.Values = (
          28.663194444444440000
          15.434027777777780000
          1009.826388888889000000
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
        Top = 498
        Width = 74
        Height = 12
        Size.Values = (
          26.458333333333330000
          2.204861111111111000
          1098.020833333333000000
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
        Top = 497
        Width = 74
        Height = 13
        Size.Values = (
          28.663194444444440000
          1505.920138888889000000
          1095.815972222222000000
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
      object QRShape2: TQRShape
        Left = 667
        Top = 384
        Width = 190
        Height = 1
        Size.Values = (
          2.204861111111111000
          1470.642361111111000000
          846.666666666666700000
          418.923611111111100000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 667
        Top = 401
        Width = 190
        Height = 6
        Size.Values = (
          13.229166666666670000
          1470.642361111111000000
          884.149305555555600000
          418.923611111111100000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNomeTitular: TQRLabel
        Left = 60
        Top = 460
        Width = 372
        Height = 13
        Size.Values = (
          29.104166666666700000
          132.291666666667000000
          1013.354166666670000000
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
        Top = 473
        Width = 372
        Height = 13
        Size.Values = (
          29.104166666666700000
          132.291666666667000000
          1042.458333333330000000
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
        Top = 485
        Width = 372
        Height = 13
        Size.Values = (
          29.104166666666700000
          132.291666666667000000
          1068.916666666670000000
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
        Top = 220
        Width = 5
        Height = 235
        Size.Values = (
          518.583333333333000000
          1468.437500000000000000
          484.187500000000000000
          10.583333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelInformacao1: TQRLabel
        Left = 6
        Top = 236
        Width = 653
        Height = 13
        Size.Values = (
          29.104166666666700000
          13.229166666666700000
          521.229166666667000000
          1439.333333333330000000)
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
        Top = 221
        Width = 293
        Height = 11
        Size.Values = (
          23.812500000000000000
          500.062500000000000000
          486.833333333333000000
          645.583333333333000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pag'#225'vel preferencialmente qualquer Ag'#234'ncia Bradesco'
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
        Left = 143
        Top = 281
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          314.854166666667000000
          619.125000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 330
        Top = 281
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          727.604166666667000000
          619.125000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape6: TQRShape
        Left = 413
        Top = 281
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          910.166666666667000000
          619.125000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape8: TQRShape
        Left = 164
        Top = 311
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          362.479166666667000000
          685.270833333333000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 221
        Top = 311
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          486.833333333333000000
          685.270833333333000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape12: TQRShape
        Left = 578
        Top = 311
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          1275.291666666670000000
          685.270833333333000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape16: TQRShape
        Left = 667
        Top = 431
        Width = 187
        Height = 6
        Size.Values = (
          13.229166666666700000
          1471.083333333330000000
          949.854166666667000000
          412.750000000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape17: TQRShape
        Left = 312
        Top = 311
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          687.916666666667000000
          685.270833333333000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel40: TQRLabel
        Left = 10
        Top = 322
        Width = 145
        Height = 18
        Size.Values = (
          39.687500000000000000
          21.166666666666700000
          709.083333333333000000
          320.145833333333000000)
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
        Top = 281
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          1031.875000000000000000
          619.125000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel42: TQRLabel
        Left = 444
        Top = 292
        Width = 10
        Height = 18
        Size.Values = (
          39.687500000000000000
          978.958333333333300000
          643.819444444444400000
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
        Left = 632
        Top = 1222
        Width = 180
        Height = 26
        Size.Values = (
          57.326388888888890000
          1393.472222222222000000
          2694.340277777778000000
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
        Left = 2
        Top = 863
        Width = 853
        Height = 6
        Size.Values = (
          13.229166666666700000
          5.291666666666670000
          1902.354166666670000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRImage2: TQRImage
        Left = 7
        Top = 187
        Width = 151
        Height = 30
        Size.Values = (
          66.145833333333300000
          15.875000000000000000
          412.750000000000000000
          333.375000000000000000)
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
        Left = 667
        Top = 360
        Width = 190
        Height = 1
        Size.Values = (
          2.204861111111111000
          1470.642361111111000000
          793.750000000000000000
          418.923611111111100000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel4: TQRLabel
        Left = 671
        Top = 364
        Width = 79
        Height = 13
        Size.Values = (
          28.663194444444440000
          1479.461805555556000000
          802.569444444444400000
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
        Top = 407
        Width = 90
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          897.378472222222200000
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
        Top = 322
        Width = 32
        Height = 18
        Size.Values = (
          39.687500000000000000
          372.621527777777800000
          709.965277777777800000
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
        Left = 686
        Top = 233
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1512.534722222222000000
          513.732638888889000000
          352.777777777777900000)
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
        Top = 292
        Width = 120
        Height = 18
        Size.Values = (
          39.687500000000000000
          31.750000000000000000
          642.937500000000000000
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
        Left = 160
        Top = 292
        Width = 164
        Height = 18
        Size.Values = (
          39.687500000000000000
          351.895833333333000000
          642.937500000000000000
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
      object QRLabel54: TQRLabel
        Left = 338
        Top = 292
        Width = 62
        Height = 18
        Size.Values = (
          39.687500000000000000
          746.125000000000000000
          642.937500000000000000
          137.583333333333000000)
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
        Top = 292
        Width = 170
        Height = 18
        Size.Values = (
          39.687500000000000000
          1053.041666666670000000
          642.937500000000000000
          375.708333333333000000)
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
        Left = 674
        Top = 264
        Width = 176
        Height = 18
        Size.Values = (
          39.687500000000000000
          1486.958333333330000000
          582.083333333333000000
          388.937500000000000000)
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
        Left = 674
        Top = 292
        Width = 176
        Height = 18
        Size.Values = (
          39.687500000000000000
          1486.958333333330000000
          642.937500000000000000
          388.937500000000000000)
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
        Left = 688
        Top = 322
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1516.062500000000000000
          709.083333333333000000
          351.895833333333000000)
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
        Top = 385
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          849.312500000000000000
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
        Top = 398
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          878.416666666667000000
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
        Top = 413
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          910.166666666667000000
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
        Top = 426
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          939.270833333333000000
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
        Top = 439
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          968.375000000000000000
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
        Top = 497
        Width = 68
        Height = 13
        Size.Values = (
          28.663194444444440000
          1682.309027777778000000
          1095.815972222222000000
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
        Top = 1213
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555560000
          70.555555555555560000
          2674.496527777778000000
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
        Left = 2
        Top = 1150
        Width = 853
        Height = 2
        Size.Values = (
          5.291666666666670000
          5.291666666666670000
          2534.708333333330000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape11: TQRShape
        Left = 2
        Top = 1021
        Width = 853
        Height = 2
        Size.Values = (
          5.291666666666670000
          5.291666666666670000
          2251.604166666670000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape14: TQRShape
        Left = 2
        Top = 991
        Width = 853
        Height = 2
        Size.Values = (
          5.291666666666670000
          5.291666666666670000
          2185.458333333330000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape15: TQRShape
        Left = 2
        Top = 961
        Width = 853
        Height = 2
        Size.Values = (
          5.291666666666670000
          5.291666666666670000
          2119.312500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape18: TQRShape
        Left = 2
        Top = 893
        Width = 853
        Height = 14
        Size.Values = (
          31.750000000000000000
          5.291666666666670000
          1968.500000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape19: TQRShape
        Left = 2
        Top = 931
        Width = 853
        Height = 2
        Size.Values = (
          5.291666666666670000
          5.291666666666670000
          2053.166666666670000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape20: TQRShape
        Left = 191
        Top = 875
        Width = 12
        Height = 24
        Size.Values = (
          52.916666666666700000
          420.687500000000000000
          1928.812500000000000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape21: TQRShape
        Left = 2
        Top = 1206
        Width = 853
        Height = 2
        Size.Values = (
          5.291666666666670000
          5.291666666666670000
          2659.062500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel7: TQRLabel
        Left = 200
        Top = 875
        Width = 82
        Height = 24
        Size.Values = (
          52.916666666666700000
          441.854166666667000000
          1928.812500000000000000
          179.916666666667000000)
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
        Top = 901
        Width = 48
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1986.579861111111000000
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
        Left = 278
        Top = 875
        Width = 10
        Height = 24
        Size.Values = (
          52.916666666666700000
          613.833333333333000000
          1928.812500000000000000
          21.166666666666700000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel9: TQRLabel
        Left = 5
        Top = 902
        Width = 82
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1988.784722222222000000
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
        Left = 56
        Top = 942
        Width = 604
        Height = 18
        Size.Values = (
          39.687500000000000000
          123.472222222222200000
          2076.979166666667000000
          1331.736111111111000000)
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
        Top = 934
        Width = 89
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          2059.340277777778000000
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
        Top = 964
        Width = 78
        Height = 10
        Size.Values = (
          22.048611111111110000
          4.409722222222222000
          2125.486111111111000000
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
        Top = 964
        Width = 70
        Height = 10
        Size.Values = (
          22.048611111111110000
          319.704861111111100000
          2125.486111111111000000
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
        Top = 964
        Width = 54
        Height = 10
        Size.Values = (
          22.048611111111110000
          736.423611111111100000
          2125.486111111111000000
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
        Top = 964
        Width = 26
        Height = 10
        Size.Values = (
          22.048611111111110000
          921.631944444444400000
          2125.486111111111000000
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
        Top = 964
        Width = 96
        Height = 10
        Size.Values = (
          22.048611111111110000
          1047.309027777778000000
          2125.486111111111000000
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
        Top = 964
        Width = 84
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          2125.486111111111000000
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
        Top = 994
        Width = 56
        Height = 10
        Size.Values = (
          22.048611111111110000
          4.409722222222222000
          2191.631944444444000000
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
        Top = 994
        Width = 20
        Height = 10
        Size.Values = (
          22.048611111111110000
          372.621527777777800000
          2191.631944444444000000
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
        Top = 994
        Width = 44
        Height = 10
        Size.Values = (
          22.048611111111110000
          500.503472222222200000
          2191.631944444444000000
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
        Top = 1004
        Width = 73
        Height = 18
        Size.Values = (
          39.687500000000000000
          508.000000000000000000
          2214.562500000000000000
          161.395833333333000000)
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
        Top = 994
        Width = 46
        Height = 10
        Size.Values = (
          22.048611111111110000
          698.940972222222200000
          2191.631944444444000000
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
        Top = 994
        Width = 41
        Height = 10
        Size.Values = (
          22.048611111111110000
          1305.277777777778000000
          2191.631944444444000000
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
        Top = 996
        Width = 10
        Height = 22
        Size.Values = (
          48.506944444444440000
          1270.000000000000000000
          2196.041666666667000000
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
        Top = 994
        Width = 94
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          2191.631944444444000000
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
        Top = 1024
        Width = 43
        Height = 11
        Size.Values = (
          24.253472222222220000
          4.409722222222222000
          2257.777777777778000000
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
        Top = 1024
        Width = 95
        Height = 11
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2257.777777777778000000
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
        Top = 1072
        Width = 55
        Height = 11
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2363.611111111111000000
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
        Top = 1118
        Width = 71
        Height = 11
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2465.034722222222000000
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
        Top = 1153
        Width = 38
        Height = 11
        Size.Values = (
          24.253472222222220000
          15.434027777777780000
          2542.204861111111000000
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
        Left = 2
        Top = 1195
        Width = 74
        Height = 10
        Size.Values = (
          22.048611111111110000
          4.409722222222222000
          2634.809027777778000000
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
        Left = 674
        Top = 1192
        Width = 74
        Height = 14
        Size.Values = (
          30.868055555555560000
          1486.076388888889000000
          2628.194444444444000000
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
        Left = 704
        Top = 1210
        Width = 53
        Height = 10
        Size.Values = (
          22.048611111111110000
          1552.222222222222000000
          2667.881944444444000000
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
        Top = 1069
        Width = 190
        Height = 2
        Size.Values = (
          5.291666666666670000
          1473.729166666670000000
          2357.437500000000000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape24: TQRShape
        Left = 668
        Top = 1090
        Width = 190
        Height = 2
        Size.Values = (
          5.291666666666670000
          1473.729166666670000000
          2402.416666666670000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel35: TQRLabel
        Left = 52
        Top = 1153
        Width = 372
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          2542.645833333330000000
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
        Left = 52
        Top = 1166
        Width = 372
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          2571.750000000000000000
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
        Left = 52
        Top = 1181
        Width = 372
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          2603.500000000000000000
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
        Top = 899
        Width = 2
        Height = 253
        Size.Values = (
          558.270833333333000000
          1468.437500000000000000
          1981.729166666670000000
          5.291666666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel41: TQRLabel
        Left = 6
        Top = 916
        Width = 650
        Height = 16
        Size.Values = (
          34.395833333333300000
          13.229166666666700000
          2018.770833333330000000
          1434.041666666670000000)
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
        Top = 901
        Width = 292
        Height = 10
        Size.Values = (
          21.166666666666700000
          500.062500000000000000
          1987.020833333330000000
          642.937500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pag'#225'vel preferencialmente qualquer Ag'#234'ncia Bradesco'
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
        Top = 962
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          314.854166666667000000
          2121.958333333330000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape29: TQRShape
        Left = 330
        Top = 962
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          727.604166666667000000
          2121.958333333330000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape30: TQRShape
        Left = 412
        Top = 962
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          907.520833333333000000
          2121.958333333330000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape31: TQRShape
        Left = 164
        Top = 991
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          362.479166666667000000
          2185.458333333330000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape32: TQRShape
        Left = 220
        Top = 991
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          484.187500000000000000
          2185.458333333330000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape33: TQRShape
        Left = 578
        Top = 991
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          1275.291666666670000000
          2185.458333333330000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape34: TQRShape
        Left = 668
        Top = 1117
        Width = 187
        Height = 2
        Size.Values = (
          4.409722222222222000
          1472.847222222222000000
          2462.829861111111000000
          412.309027777777800000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape35: TQRShape
        Left = 312
        Top = 991
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          687.916666666667000000
          2185.458333333330000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel44: TQRLabel
        Left = 8
        Top = 1004
        Width = 143
        Height = 18
        Size.Values = (
          39.687500000000000000
          18.520833333333300000
          2214.562500000000000000
          314.854166666667000000)
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
        Top = 962
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          1031.875000000000000000
          2121.958333333330000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel45: TQRLabel
        Left = 446
        Top = 974
        Width = 10
        Height = 18
        Size.Values = (
          39.687500000000000000
          983.368055555555600000
          2147.534722222222000000
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
        Top = 1045
        Width = 190
        Height = 2
        Size.Values = (
          5.291666666666670000
          1473.729166666670000000
          2304.520833333330000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel46: TQRLabel
        Left = 670
        Top = 1048
        Width = 79
        Height = 11
        Size.Values = (
          24.253472222222220000
          1477.256944444444000000
          2310.694444444444000000
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
        Top = 1092
        Width = 90
        Height = 11
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2407.708333333333000000
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
        Top = 1003
        Width = 32
        Height = 18
        Size.Values = (
          39.687500000000000000
          374.826388888888900000
          2211.475694444444000000
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
        Top = 913
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          2013.479166666670000000
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
        Top = 974
        Width = 120
        Height = 18
        Size.Values = (
          39.687500000000000000
          29.104166666666700000
          2148.416666666670000000
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
        Top = 974
        Width = 163
        Height = 18
        Size.Values = (
          39.687500000000000000
          343.958333333333000000
          2148.416666666670000000
          359.833333333333000000)
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
        Top = 974
        Width = 65
        Height = 18
        Size.Values = (
          39.687500000000000000
          743.479166666667000000
          2148.416666666670000000
          142.875000000000000000)
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
        Top = 974
        Width = 169
        Height = 18
        Size.Values = (
          39.687500000000000000
          1055.687500000000000000
          2148.416666666670000000
          373.062500000000000000)
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
        Left = 674
        Top = 943
        Width = 176
        Height = 18
        Size.Values = (
          39.687500000000000000
          1486.958333333330000000
          2079.625000000000000000
          388.937500000000000000)
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
        Left = 674
        Top = 974
        Width = 176
        Height = 18
        Size.Values = (
          39.687500000000000000
          1486.958333333330000000
          2148.416666666670000000
          388.937500000000000000)
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
        Top = 1004
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          2214.562500000000000000
          351.895833333333000000)
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
        Left = 754
        Top = 1192
        Width = 68
        Height = 14
        Size.Values = (
          30.868055555555560000
          1662.465277777778000000
          2628.194444444444000000
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
        Top = 875
        Width = 538
        Height = 23
        Size.Values = (
          50.270833333333300000
          658.812500000000000000
          1928.812500000000000000
          1185.333333333330000000)
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
        Top = 859
        Width = 19
        Height = 19
        Size.Values = (
          41.892361111111110000
          1803.576388888889000000
          1893.975694444444000000
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
        Top = 1231
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555560000
          70.555555555555560000
          2714.184027777778000000
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
        Top = 1249
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555560000
          70.555555555555560000
          2753.871527777778000000
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
        Top = 344
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          759.354166666667000000
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
        Top = 371
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          817.562500000000000000
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
        Top = 463
        Width = 211
        Height = 13
        Size.Values = (
          29.104166666666700000
          1018.645833333330000000
          1021.291666666670000000
          465.666666666667000000)
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
        Top = 1159
        Width = 212
        Height = 14
        Size.Values = (
          31.750000000000000000
          984.250000000000000000
          2555.875000000000000000
          468.312500000000000000)
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
        Top = 358
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          788.458333333333000000
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
        Left = 52
        Top = 1075
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          2370.666666666670000000
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
        Left = 52
        Top = 1091
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          2405.062500000000000000
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
        Left = 52
        Top = 1108
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          2442.104166666670000000
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
        Left = 52
        Top = 1122
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          2473.854166666670000000
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
        Left = 52
        Top = 1133
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          2497.666666666670000000
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
        Left = 52
        Top = 1027
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          2264.833333333330000000
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
        Left = 52
        Top = 1060
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          2336.270833333330000000
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
        Left = 52
        Top = 1043
        Width = 594
        Height = 14
        Size.Values = (
          31.750000000000000000
          113.770833333333000000
          2299.229166666670000000
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
        Left = 2
        Top = 508
        Width = 853
        Height = 6
        Size.Values = (
          13.229166666666700000
          5.291666666666670000
          1119.187500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape39: TQRShape
        Left = 2
        Top = 804
        Width = 853
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          1772.708333333330000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape40: TQRShape
        Left = 2
        Top = 678
        Width = 853
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          1494.895833333330000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape41: TQRShape
        Left = 2
        Top = 648
        Width = 853
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          1428.750000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape42: TQRShape
        Left = 2
        Top = 617
        Width = 853
        Height = 2
        Size.Values = (
          5.291666666666670000
          5.291666666666670000
          1359.958333333330000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape43: TQRShape
        Left = 2
        Top = 550
        Width = 853
        Height = 13
        Size.Values = (
          29.104166666666700000
          5.291666666666670000
          1211.791666666670000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape44: TQRShape
        Left = 2
        Top = 588
        Width = 853
        Height = 2
        Size.Values = (
          5.291666666666670000
          5.291666666666670000
          1296.458333333330000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape45: TQRShape
        Left = 191
        Top = 532
        Width = 12
        Height = 24
        Size.Values = (
          52.916666666666700000
          420.687500000000000000
          1172.104166666670000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel89: TQRLabel
        Left = 200
        Top = 532
        Width = 82
        Height = 24
        Size.Values = (
          52.916666666666700000
          441.854166666667000000
          1172.104166666670000000
          179.916666666667000000)
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
        Top = 559
        Width = 48
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1232.517361111111000000
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
        Left = 278
        Top = 532
        Width = 10
        Height = 24
        Size.Values = (
          52.916666666666700000
          613.833333333333000000
          1172.104166666670000000
          21.166666666666700000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel91: TQRLabel
        Left = 5
        Top = 558
        Width = 82
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1230.312500000000000000
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
        Left = 56
        Top = 595
        Width = 604
        Height = 18
        Size.Values = (
          39.687500000000000000
          123.472222222222200000
          1311.892361111111000000
          1331.736111111111000000)
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
        Top = 590
        Width = 89
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1300.868055555556000000
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
        Top = 619
        Width = 78
        Height = 13
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          1364.809027777778000000
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
        Top = 619
        Width = 70
        Height = 13
        Size.Values = (
          28.663194444444440000
          319.704861111111100000
          1364.809027777778000000
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
        Top = 619
        Width = 54
        Height = 13
        Size.Values = (
          28.663194444444440000
          736.423611111111100000
          1364.809027777778000000
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
        Top = 619
        Width = 26
        Height = 13
        Size.Values = (
          28.663194444444440000
          921.631944444444400000
          1364.809027777778000000
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
        Top = 619
        Width = 96
        Height = 13
        Size.Values = (
          28.663194444444440000
          1047.309027777778000000
          1364.809027777778000000
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
        Top = 619
        Width = 84
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1364.809027777778000000
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
        Top = 652
        Width = 56
        Height = 13
        Size.Values = (
          28.663194444444440000
          22.048611111111110000
          1437.569444444444000000
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
        Top = 652
        Width = 20
        Height = 13
        Size.Values = (
          28.663194444444440000
          372.621527777777800000
          1437.569444444444000000
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
        Top = 652
        Width = 44
        Height = 13
        Size.Values = (
          28.663194444444440000
          500.503472222222200000
          1437.569444444444000000
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
        Top = 659
        Width = 73
        Height = 18
        Size.Values = (
          39.687500000000000000
          510.645833333333000000
          1452.562500000000000000
          161.395833333333000000)
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
        Top = 652
        Width = 46
        Height = 13
        Size.Values = (
          28.663194444444440000
          698.940972222222200000
          1437.569444444444000000
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
        Top = 652
        Width = 41
        Height = 13
        Size.Values = (
          28.663194444444440000
          1305.277777777778000000
          1437.569444444444000000
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
        Top = 652
        Width = 10
        Height = 19
        Size.Values = (
          41.892361111111110000
          1270.000000000000000000
          1437.569444444444000000
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
        Top = 652
        Width = 94
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1437.569444444444000000
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
        Top = 680
        Width = 95
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1499.305555555556000000
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
        Top = 727
        Width = 55
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1602.934027777778000000
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
        Top = 781
        Width = 71
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1721.996527777778000000
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
        Top = 850
        Width = 74
        Height = 12
        Size.Values = (
          26.458333333333330000
          4.409722222222222000
          1874.131944444444000000
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
        Top = 848
        Width = 74
        Height = 13
        Size.Values = (
          28.663194444444440000
          1486.076388888889000000
          1869.722222222222000000
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
        Left = 667
        Top = 721
        Width = 190
        Height = 1
        Size.Values = (
          2.645833333333330000
          1471.083333333330000000
          1590.145833333330000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape49: TQRShape
        Left = 667
        Top = 742
        Width = 190
        Height = 6
        Size.Values = (
          13.229166666666700000
          1471.083333333330000000
          1635.125000000000000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel113: TQRLabel
        Left = 52
        Top = 808
        Width = 372
        Height = 13
        Size.Values = (
          29.104166666666700000
          113.770833333333000000
          1780.645833333330000000
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
        Left = 52
        Top = 821
        Width = 372
        Height = 13
        Size.Values = (
          29.104166666666700000
          113.770833333333000000
          1809.750000000000000000
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
        Left = 52
        Top = 834
        Width = 372
        Height = 13
        Size.Values = (
          29.104166666666700000
          113.770833333333000000
          1838.854166666670000000
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
        Top = 556
        Width = 2
        Height = 251
        Size.Values = (
          552.979166666667000000
          1468.437500000000000000
          1225.020833333330000000
          5.291666666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel116: TQRLabel
        Left = 6
        Top = 572
        Width = 650
        Height = 16
        Size.Values = (
          34.395833333333300000
          13.229166666666700000
          1262.062500000000000000
          1434.041666666670000000)
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
        Top = 558
        Width = 293
        Height = 10
        Size.Values = (
          21.166666666666700000
          500.062500000000000000
          1230.312500000000000000
          645.583333333333000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pag'#225'vel preferencialmente qualquer Ag'#234'ncia Bradesco'
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
        Left = 143
        Top = 620
        Width = 1
        Height = 26
        Size.Values = (
          58.208333333333300000
          314.854166666667000000
          1367.895833333330000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape52: TQRShape
        Left = 330
        Top = 619
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          727.604166666667000000
          1365.250000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape53: TQRShape
        Left = 413
        Top = 619
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          910.166666666667000000
          1365.250000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape54: TQRShape
        Left = 164
        Top = 648
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          362.479166666667000000
          1428.750000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape55: TQRShape
        Left = 221
        Top = 648
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          486.833333333333000000
          1428.750000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape56: TQRShape
        Left = 578
        Top = 648
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          1275.291666666670000000
          1428.750000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape57: TQRShape
        Left = 667
        Top = 773
        Width = 187
        Height = 6
        Size.Values = (
          13.229166666666670000
          1470.642361111111000000
          1704.357638888889000000
          412.309027777777800000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape58: TQRShape
        Left = 312
        Top = 648
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          687.916666666667000000
          1428.750000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel118: TQRLabel
        Left = 8
        Top = 659
        Width = 143
        Height = 18
        Size.Values = (
          39.687500000000000000
          18.520833333333300000
          1452.562500000000000000
          314.854166666667000000)
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
        Top = 619
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          1031.875000000000000000
          1365.250000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel119: TQRLabel
        Left = 446
        Top = 625
        Width = 10
        Height = 18
        Size.Values = (
          39.687500000000000000
          983.368055555555600000
          1378.038194444444000000
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
        Left = 667
        Top = 700
        Width = 190
        Height = 1
        Size.Values = (
          2.645833333333330000
          1471.083333333330000000
          1542.520833333330000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel120: TQRLabel
        Left = 670
        Top = 703
        Width = 79
        Height = 13
        Size.Values = (
          28.663194444444440000
          1477.256944444444000000
          1550.017361111111000000
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
        Top = 750
        Width = 90
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1653.645833333333000000
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
        Top = 659
        Width = 32
        Height = 18
        Size.Values = (
          39.687500000000000000
          374.826388888888900000
          1453.003472222222000000
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
        Top = 569
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          1254.125000000000000000
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
        Top = 629
        Width = 120
        Height = 18
        Size.Values = (
          39.687500000000000000
          34.395833333333300000
          1386.416666666670000000
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
        Top = 630
        Width = 164
        Height = 18
        Size.Values = (
          39.687500000000000000
          351.895833333333000000
          1389.062500000000000000
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
        Left = 340
        Top = 629
        Width = 65
        Height = 18
        Size.Values = (
          39.687500000000000000
          748.770833333333000000
          1386.416666666670000000
          142.875000000000000000)
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
        Left = 478
        Top = 630
        Width = 169
        Height = 18
        Size.Values = (
          39.687500000000000000
          1053.041666666670000000
          1389.062500000000000000
          373.062500000000000000)
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
        Left = 674
        Top = 600
        Width = 176
        Height = 18
        Size.Values = (
          39.687500000000000000
          1486.958333333330000000
          1322.916666666670000000
          388.937500000000000000)
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
        Left = 674
        Top = 630
        Width = 176
        Height = 18
        Size.Values = (
          39.687500000000000000
          1486.958333333330000000
          1389.062500000000000000
          388.937500000000000000)
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
        Top = 661
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1516.944444444440000000
          1457.413194444440000000
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
        Top = 848
        Width = 68
        Height = 13
        Size.Values = (
          28.663194444444440000
          1662.465277777778000000
          1869.722222222222000000
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
        Top = 505
        Width = 19
        Height = 19
        Size.Values = (
          41.892361111111110000
          1803.576388888889000000
          1113.454861111111000000
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
        Left = 455
        Top = 814
        Width = 211
        Height = 19
        Size.Values = (
          42.333333333333300000
          1002.770833333330000000
          1793.875000000000000000
          465.666666666667000000)
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
        Left = 52
        Top = 728
        Width = 594
        Height = 16
        Size.Values = (
          34.395833333333300000
          113.770833333333000000
          1606.020833333330000000
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
        Left = 52
        Top = 742
        Width = 594
        Height = 16
        Size.Values = (
          34.395833333333300000
          113.770833333333000000
          1635.125000000000000000
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
        Left = 52
        Top = 758
        Width = 594
        Height = 16
        Size.Values = (
          34.395833333333300000
          113.770833333333000000
          1672.166666666670000000
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
        Left = 52
        Top = 773
        Width = 594
        Height = 16
        Size.Values = (
          34.395833333333300000
          113.770833333333000000
          1703.916666666670000000
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
        Left = 52
        Top = 787
        Width = 594
        Height = 16
        Size.Values = (
          34.395833333333300000
          113.770833333333000000
          1735.666666666670000000
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
        Left = 52
        Top = 683
        Width = 594
        Height = 16
        Size.Values = (
          34.395833333333300000
          113.770833333333000000
          1505.479166666670000000
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
        Left = 52
        Top = 712
        Width = 594
        Height = 16
        Size.Values = (
          34.395833333333300000
          113.770833333333000000
          1568.979166666670000000
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
        Left = 52
        Top = 697
        Width = 594
        Height = 16
        Size.Values = (
          34.395833333333300000
          113.770833333333000000
          1537.229166666670000000
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
        Left = 686
        Top = 538
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1512.534722222222000000
          1186.215277777778000000
          352.777777777777900000)
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
        Left = 686
        Top = 200
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1512.534722222222000000
          440.972222222222300000
          352.777777777777900000)
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
        Top = 684
        Width = 43
        Height = 13
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          1508.125000000000000000
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
      object QRLabel144: TQRLabel
        Left = 5
        Top = 590
        Width = 49
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1300.868055555556000000
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
        Top = 934
        Width = 49
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          2059.340277777778000000
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
        Top = 512
        Width = 151
        Height = 30
        Size.Values = (
          66.145833333333300000
          15.875000000000000000
          1129.770833333330000000
          333.375000000000000000)
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
        Top = 868
        Width = 151
        Height = 30
        Size.Values = (
          66.145833333333300000
          15.875000000000000000
          1912.937500000000000000
          333.375000000000000000)
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
      object QRShape64: TQRShape
        Left = 496
        Top = 35
        Width = 4
        Height = 120
        Size.Values = (
          264.583333333333000000
          1093.611111111110000000
          77.170138888888900000
          8.819444444444440000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape61: TQRShape
        Left = 191
        Top = 11
        Width = 12
        Height = 24
        Size.Values = (
          52.916666666666700000
          421.128472222222000000
          24.253472222222200000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel146: TQRLabel
        Left = 200
        Top = 11
        Width = 82
        Height = 24
        Size.Values = (
          52.916666666666700000
          440.972222222222000000
          24.253472222222200000
          180.798611111111000000)
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
      object QRShape62: TQRShape
        Left = 281
        Top = 11
        Width = 10
        Height = 24
        Size.Values = (
          52.916666666666700000
          619.565972222222000000
          24.253472222222200000
          22.048611111111100000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel167: TQRLabel
        Left = 604
        Top = 25
        Width = 101
        Height = 10
        Size.Values = (
          22.048611111111110000
          1331.736111111111000000
          55.121527777777780000
          222.690972222222200000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Comprovante de Entrega'
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
      object QRShape73: TQRShape
        Left = 497
        Top = 36
        Width = 352
        Height = 120
        Size.Values = (
          264.583333333333000000
          1095.815972222220000000
          79.375000000000000000
          776.111111111111000000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel168: TQRLabel
        Left = 546
        Top = 40
        Width = 236
        Height = 10
        Size.Values = (
          22.048611111111110000
          1203.854166666667000000
          88.194444444444440000
          520.347222222222200000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Motivos de n'#227'o entrega.(Para uso da empresa entregadora)'
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
      object QRLabel170: TQRLabel
        Left = 529
        Top = 53
        Width = 38
        Height = 10
        Size.Values = (
          22.048611111111110000
          1166.371527777778000000
          116.857638888888900000
          83.784722222222220000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Mudou-se'
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
      object QRShape74: TQRShape
        Left = 508
        Top = 53
        Width = 19
        Height = 8
        Size.Values = (
          18.520833333333300000
          1119.187500000000000000
          116.416666666667000000
          42.333333333333300000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape75: TQRShape
        Left = 508
        Top = 64
        Width = 19
        Height = 8
        Size.Values = (
          18.520833333333300000
          1119.187500000000000000
          140.229166666667000000
          42.333333333333300000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel171: TQRLabel
        Left = 529
        Top = 64
        Width = 41
        Height = 10
        Size.Values = (
          22.048611111111110000
          1166.371527777778000000
          141.111111111111100000
          90.399305555555560000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Recusado'
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
      object QRShape76: TQRShape
        Left = 508
        Top = 74
        Width = 19
        Height = 8
        Size.Values = (
          18.520833333333300000
          1119.187500000000000000
          164.041666666667000000
          42.333333333333300000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel172: TQRLabel
        Left = 529
        Top = 74
        Width = 34
        Height = 10
        Size.Values = (
          22.048611111111110000
          1166.371527777778000000
          163.159722222222200000
          74.965277777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Ausente'
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
      object QRLabel173: TQRLabel
        Left = 624
        Top = 53
        Width = 35
        Height = 10
        Size.Values = (
          22.048611111111110000
          1375.833333333333000000
          116.857638888888900000
          77.170138888888890000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Falecido'
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
      object QRShape77: TQRShape
        Left = 604
        Top = 53
        Width = 19
        Height = 8
        Size.Values = (
          18.520833333333300000
          1330.854166666670000000
          116.416666666667000000
          42.333333333333300000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape78: TQRShape
        Left = 604
        Top = 64
        Width = 19
        Height = 8
        Size.Values = (
          18.520833333333300000
          1330.854166666670000000
          140.229166666667000000
          42.333333333333300000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel174: TQRLabel
        Left = 624
        Top = 64
        Width = 58
        Height = 10
        Size.Values = (
          22.048611111111110000
          1375.833333333333000000
          141.111111111111100000
          127.881944444444400000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Desconhecido'
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
      object QRShape79: TQRShape
        Left = 604
        Top = 74
        Width = 19
        Height = 8
        Size.Values = (
          18.520833333333300000
          1330.854166666670000000
          164.041666666667000000
          42.333333333333300000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel175: TQRLabel
        Left = 624
        Top = 74
        Width = 60
        Height = 10
        Size.Values = (
          22.048611111111110000
          1375.833333333333000000
          163.159722222222200000
          132.291666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'N'#227'o procurado'
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
      object QRLabel176: TQRLabel
        Left = 736
        Top = 53
        Width = 88
        Height = 11
        Size.Values = (
          24.253472222222220000
          1622.777777777778000000
          116.857638888888900000
          194.027777777777800000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Endere'#231'o insuficiente'
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
      object QRShape80: TQRShape
        Left = 713
        Top = 53
        Width = 19
        Height = 8
        Size.Values = (
          18.520833333333300000
          1571.625000000000000000
          116.416666666667000000
          42.333333333333300000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape81: TQRShape
        Left = 713
        Top = 64
        Width = 19
        Height = 8
        Size.Values = (
          18.520833333333300000
          1571.625000000000000000
          140.229166666667000000
          42.333333333333300000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel177: TQRLabel
        Left = 736
        Top = 64
        Width = 90
        Height = 11
        Size.Values = (
          24.253472222222220000
          1622.777777777778000000
          141.111111111111100000
          198.437500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'N'#227'o existe n'#186' indicado'
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
      object QRShape82: TQRShape
        Left = 713
        Top = 74
        Width = 19
        Height = 8
        Size.Values = (
          18.520833333333300000
          1571.625000000000000000
          164.041666666667000000
          42.333333333333300000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel178: TQRLabel
        Left = 736
        Top = 74
        Width = 100
        Height = 11
        Size.Values = (
          24.253472222222220000
          1622.777777777778000000
          163.159722222222200000
          220.486111111111100000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Outros (Anotar no verso)'
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
      object QRShape83: TQRShape
        Left = 535
        Top = 119
        Width = 78
        Height = 13
        Size.Values = (
          29.104166666666700000
          1180.041666666670000000
          261.937500000000000000
          171.979166666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel179: TQRLabel
        Left = 551
        Top = 128
        Width = 19
        Height = 10
        Size.Values = (
          22.048611111111110000
          1214.878472222222000000
          282.222222222222200000
          41.892361111111110000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data'
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
      object QRShape84: TQRShape
        Left = 624
        Top = 119
        Width = 181
        Height = 13
        Size.Values = (
          29.104166666666700000
          1375.833333333330000000
          261.937500000000000000
          399.520833333333000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel180: TQRLabel
        Left = 685
        Top = 128
        Width = 46
        Height = 10
        Size.Values = (
          22.048611111111110000
          1510.329861111111000000
          282.222222222222200000
          101.423611111111100000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Entregador'
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
      object QRImage4: TQRImage
        Left = 7
        Top = 2
        Width = 151
        Height = 30
        Size.Values = (
          66.145833333333300000
          15.875000000000000000
          5.291666666666670000
          333.375000000000000000)
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
      object QRLabel143: TQRLabel
        Left = 5
        Top = 37
        Width = 49
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          81.579861111111110000
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
      object QRLabel147: TQRLabel
        Left = 56
        Top = 44
        Width = 253
        Height = 18
        Size.Values = (
          39.687500000000000000
          123.472222222222200000
          97.013888888888890000
          557.829861111111100000)
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
      object QRShape28: TQRShape
        Left = 0
        Top = 36
        Width = 498
        Height = 1
        Size.Values = (
          2.645833333333330000
          0.000000000000000000
          79.375000000000000000
          1098.020833333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel148: TQRLabel
        Left = 317
        Top = 37
        Width = 89
        Height = 10
        Size.Values = (
          22.048611111111110000
          698.940972222222200000
          81.579861111111110000
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
      object QRLabel149: TQRLabel
        Left = 319
        Top = 47
        Width = 176
        Height = 18
        Size.Values = (
          39.687500000000000000
          703.791666666667000000
          103.187500000000000000
          388.937500000000000000)
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
      object QRShape46: TQRShape
        Left = 0
        Top = 66
        Width = 498
        Height = 1
        Size.Values = (
          2.645833333333330000
          0.000000000000000000
          145.520833333333000000
          1098.020833333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel150: TQRLabel
        Left = 56
        Top = 79
        Width = 253
        Height = 13
        Size.Values = (
          28.663194444444440000
          123.472222222222200000
          174.184027777777800000
          557.829861111111100000)
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
      object QRLabel151: TQRLabel
        Left = 4
        Top = 68
        Width = 35
        Height = 13
        Size.Values = (
          28.663194444444440000
          8.819444444444444000
          149.930555555555600000
          77.170138888888890000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Pagador'
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
      object QRLabel152: TQRLabel
        Left = 319
        Top = 76
        Width = 176
        Height = 18
        Size.Values = (
          39.687500000000000000
          703.791666666667000000
          166.687500000000000000
          388.937500000000000000)
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
      object QRLabel153: TQRLabel
        Left = 317
        Top = 67
        Width = 84
        Height = 10
        Size.Values = (
          22.048611111111110000
          698.940972222222200000
          147.725694444444400000
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
      object QRShape63: TQRShape
        Left = 0
        Top = 96
        Width = 498
        Height = 1
        Size.Values = (
          2.645833333333330000
          0.000000000000000000
          211.666666666667000000
          1098.020833333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel154: TQRLabel
        Left = 1
        Top = 97
        Width = 48
        Height = 10
        Size.Values = (
          22.048611111111110000
          2.204861111111111000
          213.871527777777800000
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
      object QRLabel155: TQRLabel
        Left = 6
        Top = 108
        Width = 110
        Height = 18
        Size.Values = (
          39.687500000000000000
          13.229166666666700000
          238.125000000000000000
          243.416666666667000000)
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
      object QRLabel156: TQRLabel
        Left = 126
        Top = 98
        Width = 70
        Height = 10
        Size.Values = (
          22.048611111111110000
          277.812500000000000000
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
      object QRLabel157: TQRLabel
        Left = 121
        Top = 107
        Width = 109
        Height = 18
        Size.Values = (
          39.687500000000000000
          267.229166666667000000
          235.479166666667000000
          240.770833333333000000)
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
      object QRShape65: TQRShape
        Left = 221
        Top = 127
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          486.833333333333000000
          280.458333333333000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape66: TQRShape
        Left = 314
        Top = 36
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          693.208333333333000000
          79.375000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape67: TQRShape
        Left = 314
        Top = 68
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          693.208333333333000000
          150.812500000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape68: TQRShape
        Left = 120
        Top = 96
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          264.583333333333000000
          211.666666666667000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel158: TQRLabel
        Left = 236
        Top = 98
        Width = 44
        Height = 11
        Size.Values = (
          24.253472222222220000
          520.347222222222200000
          216.076388888888900000
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
      object QRLabel159: TQRLabel
        Left = 239
        Top = 108
        Width = 60
        Height = 18
        Size.Values = (
          39.687500000000000000
          526.520833333333000000
          238.125000000000000000
          132.291666666667000000)
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
      object QRShape69: TQRShape
        Left = 234
        Top = 96
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          515.937500000000000000
          211.666666666667000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape70: TQRShape
        Left = 314
        Top = 96
        Width = 1
        Height = 32
        Size.Values = (
          71.437500000000000000
          693.208333333333000000
          211.666666666667000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel160: TQRLabel
        Left = 317
        Top = 98
        Width = 94
        Height = 10
        Size.Values = (
          22.048611111111110000
          698.940972222222200000
          216.076388888888900000
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
      object QRLabel161: TQRLabel
        Left = 332
        Top = 108
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          732.895833333333000000
          238.125000000000000000
          351.895833333333000000)
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
      object QRShape85: TQRShape
        Left = 0
        Top = 127
        Width = 498
        Height = 1
        Size.Values = (
          2.645833333333330000
          0.000000000000000000
          280.458333333333000000
          1098.020833333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel10: TQRLabel
        Left = 4
        Top = 128
        Width = 121
        Height = 10
        Size.Values = (
          22.048611111111110000
          8.819444444444444000
          282.222222222222200000
          266.788194444444400000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Recebi(emos) o bloqueto/T'#237'tulo'
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
      object QRLabel162: TQRLabel
        Left = 4
        Top = 138
        Width = 120
        Height = 10
        Size.Values = (
          22.048611111111110000
          8.819444444444444000
          304.270833333333300000
          264.583333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'com as Caracter'#237'sticas acima'
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
      object QRShape86: TQRShape
        Left = 127
        Top = 127
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          280.458333333333000000
          280.458333333333000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel163: TQRLabel
        Left = 131
        Top = 130
        Width = 19
        Height = 10
        Size.Values = (
          22.048611111111110000
          288.836805555555600000
          286.631944444444400000
          41.892361111111110000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data'
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
      object QRShape87: TQRShape
        Left = 0
        Top = 155
        Width = 498
        Height = 1
        Size.Values = (
          2.645833333333330000
          0.000000000000000000
          341.312500000000000000
          1098.020833333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel181: TQRLabel
        Left = 227
        Top = 130
        Width = 44
        Height = 10
        Size.Values = (
          22.048611111111110000
          500.503472222222200000
          286.631944444444400000
          97.013888888888890000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Assinatura'
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
      object QRShape71: TQRShape
        Left = 0
        Top = 185
        Width = 862
        Height = 1
        Size.Values = (
          2.645833333333330000
          0.000000000000000000
          407.458333333333000000
          1899.708333333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel164: TQRLabel
        Left = 5
        Top = 157
        Width = 82
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          346.163194444444400000
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
      object QRLabel165: TQRLabel
        Left = 6
        Top = 172
        Width = 653
        Height = 13
        Size.Values = (
          29.104166666666700000
          13.229166666666700000
          378.354166666667000000
          1439.333333333330000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'PAGAR PREFERENCIALMENTE EM AGENCIAS BRADESCO'
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
      object QRLabel166: TQRLabel
        Left = 818
        Top = 178
        Width = 19
        Height = 19
        Size.Values = (
          41.892361111111110000
          1803.576388888889000000
          392.465277777777800000
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
      object QRLabel169: TQRLabel
        Left = 688
        Top = 416
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1516.944444444444000000
          917.222222222222200000
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
      object QRLabel182: TQRLabel
        Left = 688
        Top = 758
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1516.944444444444000000
          1671.284722222222000000
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
      object QRLabel183: TQRLabel
        Left = 688
        Top = 1100
        Width = 160
        Height = 18
        Size.Values = (
          39.687500000000000000
          1516.944444444444000000
          2425.347222222222000000
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
      object QRLabel184: TQRLabel
        Left = 7
        Top = 808
        Width = 38
        Height = 13
        Size.Values = (
          28.663194444444440000
          15.434027777777780000
          1781.527777777778000000
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
