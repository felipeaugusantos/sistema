object frmQckUnibanco: TfrmQckUnibanco
  Left = 129
  Top = 6
  Width = 983
  Height = 764
  AutoScroll = True
  Caption = 'Unibanco'
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
        Caption = '409-0'
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
        Top = 69
        Width = 603
        Height = 13
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          152.135416666666700000
          1329.531250000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nome do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNomeCedentePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
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
      object QRLabel2: TQRLabel
        Left = 123
        Top = 38
        Width = 454
        Height = 11
        Size.Values = (
          24.253472222222220000
          271.197916666666700000
          83.784722222222230000
          1001.006944444444000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'Pag'#225'vel em qualquer banco at'#233' o vencimento, ap'#243's somente no unib' +
          'anco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Width = 144
        Height = 23
        Size.Values = (
          50.711805555555560000
          15.434027777777780000
          4.409722222222222000
          317.500000000000000000)
        XLColumn = 0
        AutoSize = True
        Picture.Data = {
          07544269746D617006270000424D062700000000000036000000280000009000
          0000170000000100180000000000D02600000000000000000000000000000000
          0000F8FCFFFCFDFFFFFFFFFFFFFBFBF1E7F0E1D1EFDECBFFEAD5FFFFF2FFFDF2
          FDFFFEF6FFFFF8FFFFFFFFFBFFFBE9FAE9CFC0AF94B2A083BCA68AE5D0B5FFF7
          E4FFFFF8FFFEFEF7FAFFFAFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFFFFFDFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFFFFFEFCF9E9D8B7A3808067
          2F75550C7A580084610088713FC4B18EEBE2D4FFFFFEFFFFFCD5C7B49C845A96
          783DC0AB78C5AF759F85426B520C837033D9CFA7FFFFF2FDFFFFF7FDFFFDFFFF
          FFFDF8FFFDF8FFFEFFFBFDFFFDFCFFFFFDFFFEFBFFFFFFF5FFFFFBF9FCFFFFFA
          FFF8FFF8FFFFFBFFFFF7FFFEFFFFFCFCFFFDFDFFFEFFFEFCFBFDFFFFF8FCFFFC
          FEFEFFFFFEFFFCFFFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFBFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF8FDFB
          FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5FFFAFAFFFDFDFFFFFFFCFBFDFEFFF5FC
          FFFBFFFFFDFFFFFFFFFCF5FFF9FFFFF9FFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFEDFDFFF5E0CA896D2D6E51008556008957007C55007B53087B5601844C00
          8F7227FEEAD9B28E60815411C1B183F2FBFEFFFFFCFFFEF7FFFFFFC8BDA77951
          09795106CBBC95FFFFF2FBFAFFFAFEF2FFFFF9FDFAFCFBFFFEFAFCFFF5F2FFFF
          FFF8FFFFFFF9FEFDFFFFF7FFFFF9FFFEFFFFFEFFFFFFFBF9FFFBFDFCFFFFFFF0
          FFFFF2F3FCFFF3FCFFFFFFF2FFFFF1FDFCFFFFFFFFFFFCFFFFFFF5FBFFFBFBFE
          FCFFFFFEFFFDFFFFFFEFFDFCFFFCFFF6FFFFE3FDFFFFF3F8FFF4FDFFFFFFEEFE
          FBFDFCFBFFFFFFF1FFFFF4F2FBFFF3FCFFFFFFF0FFFFF1FDFCFFFFFEF6FFFEFC
          FBFFF8FFFFFBFFFDF8FBFFF8FFFEFCFFFFF9FFFEFFFDFDFFFAFFFCEAF6FFFFFA
          FFFFFDFFFFFFF5FFFFFCFFF9FFFFFDFFFCF9F4FDFFFBF4FEFEFAFEFFFFFDFFFF
          FDFCFFFFFBFFFCFAFFFCFFFFFCFEFFFDFFF6FFF5FFFFF4FBF3FFFFFDFEFFFFFB
          F8FEFFF9F8FFFFFAFFFFFAEDFFFFF4FFFEFFFDFFF5FFFFF9FFFDFDFFFEFFFFFF
          FEFFFFF8FFFFF4FFFFF8F7F3F2ECE9E4EAE7D9F4EAD9F8E8D7F2E3D3EDE8D9E3
          E6D6FFF3DDF9F9FFFAFFFEFFFAFDFDFAFFFFFFFCFFFFF8F3E9CBDFD1BEDED2C0
          D8CCBAECE1CDFFFEEBFFFFF5F7FEFFEDFDFFFFFDE89268338251008057007F50
          00845600835A00855100835208877332E4C8AA97742A775906D6C3AEFFFFFCFF
          FFF4FAFFFEFFFDF9FBFCFAFFFFF2AE8C5682530273581FECDECCFDFBFFFFFFF8
          FEFEF8FAFBFFFAFFFEF9FAFEFFFEFFFDF6DBD6BD93AF986AA38953A0824B9C7C
          4B9C7B4A9A7B44A689509A7D56A1824BC4AF89FDFBFBFDFBFBBBA6809C7D4693
          764FA69269FFFDFFFDFFFEF9FAFEF8FCFFFFF4E6C2A68394894D987C4D8F7C43
          A08643E5DFC8FFFFFBEFECD7A78B4E957D4993794A9B7F3FC5B384FEFFF6FFFF
          F8BEAC7D9B7F3F947A4B947D4D9E7A4A9480479C7B439E7D459480479F7B4BAF
          9868D6CAAEFFFFF2FDFFF7FAFFFFC0987B9A79489A803EAD9063FEFFF6FFFFF9
          FFFFFBFFFFFEFBFEFCFFFFF7D9CBAF91794F8F8042A28646917D449B80409075
          359A8E46998D47FFFBF0F7FEFFF5FFFDFAFFF9FFFFEDBEAE89A690569A814392
          7941937846E6D7BDFCFBFFF1F8FFFDFFFFF6EDD2C4AE84967A4B91671C845D0F
          825D0D825A08845504885908825C0A795906B3A277F8F7FFF7FDFFFFFEFEFFFF
          F5BCB387896B3C74561D7A55016E4D007A5B106A4A0886682FB99F7BFFF1E4FF
          FCFFC0A775925C0F884F008158097A561A7E6029795D1D794802896837F5DFBB
          9A78427E5F00C0AB77B7AE82F6E6DAFFFFFFF6FFFFFFFFFEF6FDFFF6FFFED1BA
          8D875400794F02B79C7AFFFAFFFFFFF8FEFFFBFAFFFFF8FEFDFFFFF9F7E9D290
          7B478252047F51008559008054008554008C5805875300905700845200855500
          AA8C55FFFFFBFFFFFBA1834C835300835100A17730FFF9FCF7FEFFFFFFFFFDFE
          FFA289618551057356008B53017D5201774D00E4D5C2FFFEFFF9ECD686580A7F
          4F00835000815000AF905BFFFEFEFFFEFEA687527F4E008451017F53008B5600
          7D53008A55008C57007E54008D58017D5100705310AE9E74FFFEE9FFFFF9AB7E
          418C5B00845800956922F8FFFBF4FAF9FBFDFFFAF8FFFFFDFFFFFEE7977A4176
          5100735601865400794F0083570383530080590082630EFFF9EFF1FFFFF4FDFA
          FFFFEDAA9C627A5D0C7C54008357008156008C5909CAB08BF9F9FFF6FDFFEDE6
          D2886D35754D028154038C5A007C4F007A53007D57057F540382560279530079
          5700AD995FFBFAFCF8FDFFFFFEF29B8A59775D038859008354009356008D5700
          865600875700855900734C009C7E47FFF6D09A7A397748008F6B2BD9C6A0FFF5
          DFFCF6E9F4EDDCEDD6B6F4E4CDAB854B7951008A7537D8C1A7805F029B7737F7
          F0F7FBFDFDFAFFFFEEFBFFF1F9F9CBB780845500865402916B2AFDF6F9FFFFFC
          FDFFFEF5FCFFFAFFFFFFFFF0AF99696D4E008555038C5A007950007756067955
          09724B067F560D8B5800825300865A00A68C56FFFDFFFFFDFF9E844E885C0087
          5800A87634FFFBFFF3FFFFFFFFF1C9C19C7350078D5200865B00895400805603
          794E05E6D6CFF9F6FFF2EBE2825910845503865401875804AC8F62FFFAFFFEF8
          FFA08356845501875502865A008455007B5A1176500877510971500786570085
          59007C4F00775611DCCDACF9F8F4A9874C7C57007E5700987133F9FFFAFBFFFF
          FDFCFFFFFBFFFFFEF9CEB38E774F078959007A5505864D00A17538B48F518554
          0E8754008D6320F8EEFEFAFDFFFFFEFCF0D7B577570B7C550081520182510585
          5801814F00D6C09DFFFEFFFFFAED9B7D448255008053008057028D50008E5A07
          845811855C1D8D62239366228D611A8C651BBBA679FDFFFFF9FAFED8C1A17E5B
          118659008A55008456027B500D906925846117785300805400845700734F0FB6
          996C835C127B5B1AF2E7CCFBFDFEFDFFFFF0F5FEF4FCFFFFFEF6C7AC8A7D5A00
          7A570EDABEADB59252884E00885D00AD8F66FFFDF6F1FDFDECF9FFFFFFF9987F
          2F7F56007B490092690DFCF4F4FFFEFFFBFFFFF3FCFFF9FDFEFFFCE6886C2B86
          5B007C4F0686550071530CA39668D6C59EE2D4B8E0CFAE8B672B7854007C5800
          A7915DFFFEFFFFFEFF9B85517A56007955019C7842FFFDFFEEFAFEFFFFE2886A
          238256008654087D54007F58007655007B5400E9DCC6FCFCFFEDEEDE795E0E77
          57007654007E5B01AB965FFFFFFEFFFFFE9D88517B58007755007B50008F6A20
          F0E1C1F2E8D0ECE2CAC8B9997F5A107D52018D59007F5100A9885AFFFFFEA187
          586F50057C5604835A1BB69C6EB79E76B6A07CB19A74BCA16F7F5D1B7A520083
          56007E5900814F07E5CCA2BFAE7D7452108354008A631EFBF7FDFDFBFFFFFEF6
          9C774B8056037B520083580F7A4D097D5203805204CCBEA2FBFFFFF7E6CB7F51
          038D5900855A00745101765D33D3C0A5F4EBE1FBF6F3FAF4EFFBF2E8FDF5E8FE
          F8EDFFF9ECF8FEFFFFFDF498773F804E008C5500885A027C5F1CE7D2D4FFFDFA
          F7E9D38E7642744E00865B00775200806215855C0DAD9456FFFFF7F1F5FFFFFF
          FFFAFAFFFAFCFFEAE3CF7E5D0E7B4E00876C33FFEBE6926D358B52077D53007C
          5300E7C7AAFBFFFBF2F4FED2B6947A56007A5400855A11916E18FEF9F6FEFBFD
          F8FDFCF8FFFFF7F5FBFFF3DC7C5E177C4E007A4F06845100998048FFFCEAFFFF
          F8FFFFFFFFFFF59479477C56047E5600AE935BFFFFFBFFFFFBA2874F7A52007A
          54028F7C3FFFFBF8FBFFFFC9B29282510383530077500B7555007F5705795500
          825400E9D4B9FFFEFFF0EDDE7B5B0F785300795301815901B0955DFFFFF9FFFF
          F9A388507E56007B5503815305906F2AFFFFF9FBFEFFFBFEFFFFFAF3B6955085
          57098150048958008E682EFFFEFAA282517D5607905B01814D008F5900855400
          7A50007E5700835B007E56007A5500775400795300A67E44FFFFEEA9A0747855
          0B86540090681DFAF4EDFBFFFECFBEA3754F0F8557007F56007B530182560384
          5500835400C2B69AF8FEFFC7B89E81540A8350008559007D5502B8AE90FFFFF1
          FBFEFFF6FDFFF8FFFFFBFFFEFBFFFFFAFFFFFFFCFFF0FBFFFDF1DF8258118B55
          00864F06755006AE9A6BFBFFFBF5FCF7FFFFF5CCB993784D0A8B50008E540C7D
          4B0F936E2ABAA66CFFFEF6FBFAFFFFFFFAFFFFFFFFFEFAAA925E7E56007B4D0D
          B3A162FFFEFAF2E1E48F773B805C047E5300916D31FFFFF1D6CAB27B54108859
          038053007D5709A28B5BFFFEF9FFFDFFF7FAF8FBFFFEFFFCFFF0DFCA6D4D068B
          5B037F56078E5B00B8A06CFFFFFCFEF9FBF9FBFFFFFFF997783B805100835600
          B1935CFFFFFBFFFFFBA88A53825500825302907A33FFFFFBFFF8EB875F2A8954
          037F510082560F7756007E4E067E5304875503E9D4BFFFFCFFF6EFE6855B1488
          5604825107865706B59564FFFCFEFFFCFEA9895884550483520880530294722C
          FFF9F5F9F9FFFDFDFFFFFFFBCDAB657B4E0084510B7C51008B6F2FFFFFFAAE8B
          53855400884D00855B02714A00825E12775103825A028456008C5C0081560076
          5101795B0EEBCFB7FFFDFFAFA3797A4E008C56008C6521FCF8F3FFFFEF86713D
          7F5502814C008357047954027D55008A5800895700CDC2A2F7FCFDB5A3847F52
          088758027C5000805100DAD2B4FFFFF4F8F7F9FAFDFFFEFFFAFFFFF6FDFEFAFB
          FEFFFBFFFFF4FFFDE6D4C381570C85550084550B704C00C2A579F9FBFBF8FEFF
          FFFFFED9C4A8794C098F56008350007C5500D0B8848D7F4BFFFEF7FDF8FFFFFD
          F8FDFFFFF5E9DF7A550B8D4F036D5C00DCCBA4FFFEF8F4F8FFF7FFE98B773084
          5305755601D6BFA59E86507D5700834C038F5A00724F00E6D6CAFFFFFAFFFDFF
          FDFFFEF8FCF7FFFBFFF2DECC745510815200785400865600BCA676FBFFFFFDF9
          FFFBFDFFFFFFF19D7A30855202845503A68C5DFCFDFFFCFDFF9D835482530185
          5202A48138FDF7F8B5A5888250008558007E5600844E07AD843F885908785200
          7D5500E7DDC5F4FAFFECECDE835B098F5A00835200825600AE9660FDFFFEFDFF
          FEA48C568054008453007851028C6D22FCEEE8F5F0EFFAF5F4D8CAC48A6B207A
          5304814C03865F00907F40FBFFFEA1824B875502815200826F26E4E1CCE0D9C5
          F4E2C58F6D3F804D0E854D008650037F5006A89758FFFFF9EDF7FFB0A4748D5D
          00845300836524FAFFFAD3C2A174520C8A54009054027C4C0AAA8A4189661680
          4F00805300C9BF9DFFFFF9B3976E845200804F00805609805204DED9C4FFFFFB
          FDFCFFFFFCFFFFFDFCFFFFFBFEFDFFFAFBFFF8FFF4F8FFF9E0CBBC784F067D57
          00795301805A02CAA170FFFFFBF5F9FAFFFFFFD4C1A67C5211855200885F006F
          5400FFF9F48E854CD5CB9CFFFFF7FAFFFBFFFDFFC0A58B7F5E007D5100705707
          F3EBC6FAFFFEEFFEF6FFFFF5FFF6DE8664296E5100BA8447D4BBA78052008757
          007B4D0DAD977EFFFFEEFDFFFEFFFEFFFBFFFFFFFCFFFBFFFBE5DDD080550485
          55007C5700875005BDA679FDFFFEFFFFFEFBFFFFFFFEFD9A7A38805401805500
          AB915BFFFFFEFFFFFEA187517F54008155029F8041FFF1DC845B167B4F027E58
          06845501947A34D2BFB28054007F5103815400E1D5C9FBFFFEF6EAE0875C0B7A
          5501815500845A01AB9260FFFFFFFFFEFAA48C52845500834F02845004855703
          8B63108960178862147855007957007853038A5A006A520AD8C5AAFFF8F6AC87
          4D795109835206937425FFFFF8F4FFFFDFD4B47D5502845B008050028050087D
          610AF2EAEAF1FBFBFBFDFDB6A16A8757007D4B008B7030FEEFCE946D23844F00
          845504824C05806624E0D7BC7558159157007B5700C7BE9CFFFFF8AE98647E53
          007E53027E5407855700D7D4C5FFFEFFFFFEFFFAFBF7FFFFFBF9F2F7FFFEFFFF
          FAEDFFFEF1FDFDFFE7CDAF7A5305725504825602875404B9A576FFFBFDFFFFF9
          FFFEFBDAC6AD7153068259007B4D007B5503FDFCFFF6E5CA916F41C7A58DFDE7
          F3FFF6FFB3A5818E7A229F803BB1A176FFFFFCF3EEFDF7EBE9D4C1ACBFAD8EDF
          D6AA765A0D905C16DEC2A381590E785406B49365FFF8EAFFFFF8FDFFFEFFFEFF
          FBFFFFFFFCFFFBFFFBE5DDD08055048555007C5700875005BDA679FDFFFEFFFF
          FEFBFFFFFFFEFD9A7A38805401815600AB915BFFFFFEFFFFFEA187517F540081
          5502A18041C1A56F805615765100835204764E00DCCCA8EBD6C08054007F5103
          815400E1D5C9FBFFFEF6EAE0885D0C7A55018054007D5200AD9462FFFEFEFFFE
          FAA0884E8354008554068F54058556007650007D56018054008D5F0080510084
          500D7A510CA89770FFF8EBFFFFFBA8884D7A530883530199742AFFFFFFFEF5EB
          8A753E7752008250048452007F5809C6AD81FFFAF7F8FFFFFDFFFFBAA5728354
          0089580A8D6F28C2AB7E7E51008353057E52007F4F07C3B688F9EFDD80590B84
          52007D5601C2B498FFFFFBA88E5F885A068354037F55087F5200E1DABFFFFFF9
          FFF9FFFFFFFCBBAF8781712C7E6821876C34887A50FFFDFDECD8B9744D007F5A
          067E4F00815002BFA67EFFFFFEF9FDF2FFFFF9D4BFA07A57078555008F580783
          5301F8FFFFFAFAFAFFF8E48877447B6218B09047C9A779DFB8A9ECBDA2DDB89E
          B69C6EA488418A6210774B0079541CD1B299B09757835507D3B788876833BBA8
          7DFFFBE3FDFFFEFAFDFFFDFFFEFFFEFFFBFFFFFFFCFFFBFFFBE5DDD080550485
          55007C5700885106BEA77AFDFFFEFFFFFEFBFFFFFFFEFD9B7B39805401815600
          AC925CFFFFFEFFFFFEA187517F54008155028A601D7F5E0E7B51047F58008953
          009B7C3FFFFCFBE1D2B18054007F5103815400E1D5C9FBFFFEF7EBE1885D0C7B
          5602845A017F5400B29869FEFBFDFFFFFCA38B518357008150028B5500755000
          816B2981662D7C530A855200885300885411DCBF9AFFFEFEFFFEFFF7FCF39E83
          4A7D57098455009A712CFFFCFFC8AB86724E0082590A834C038C5A07886C30FF
          F9F2FFFEFCF8FFFFFBFFFFB4A0707B4F008A5707845F0F8260258754007F5201
          7F5900906C2CEEEFDBF5EBE18857017C54027C5205D0BBA5FFF6F4BB9E728352
          028754047F5104855900E1D4C4FFFFF6F9FEFFFFFEFEB99C75805900865C0083
          570080651BFFFFFCE2D7B97D59008152008755037D5201B99C75F3FAFDF8FFFE
          FFFFFCD9C4A87753078552008B5403815002F1FDF7FBFFFEFFF8FFFFFBFFCFC4
          92907C2F7352037C54006654076B4B097E5702875A00814F00865D01775A0073
          5500D7C69F724F05C3A76BFDECD1FFFFF8FDFFFBF4FDFFFDFAFFFDFFFEFFFEFF
          FBFFFFFFFCFFFBFFFBE5DDD08055048555007C5700885106BEA77AFDFFFEFFFF
          FEFBFFFFFFFEFD9B7B39815502815600AC925CFFFFFEFFFFFEA288527F540081
          55028350007455007D57008855057B5300DEC8AFF8FCFFD5CAAA8054007F5103
          815400E1D5C9FBFFFEF7EBE1885D0C7B56027D52007F5300B09667FDFCFEFFFF
          FCA38B51855900804F0181550084712EFDFBE3F9F1F1E9CFB7835C188055007B
          5300BFA986FFFBFFF5F8FDFBFFF9A68655785106865600A47838FAE4DF88621A
          8054007F5000925D00744C04D2C2B1FFFFFCFFFEFCFAFFFFF9FCFFB2A0717F55
          028752018155007A4D03865401815300735800CCB98CFAFFFCECDDDA88560379
          54007E5409D2BBA1FFFAF4C1A77F8052048250008051007D5400DAD0BEFBFFFB
          F1FEFFFFFDFFBF9E8486520C8551007F5000926C14FFF6F8EAE3CF8463068650
          008655007E5800C5A574F4FDFFF4FDFFFBFBFBD2C2A574510D8052008352027F
          530CFFFCFFFFFFF7F6FCF1FBFFFCFFFFF8FFEFE2CFAD96CDA679AF8948976E30
          8B6612805D00865F11896218966F25B38451D8D3C49A8548A68D4FFFFDF6FAFC
          FFF8FFFFF7FFFFFFFCFFFDFFFEFFFEFFFBFFFFFFFCFFFBFFFBE5DDD080550485
          55007C5700875005BEA77AFDFFFEFFFFFEFBFFFFFFFEFD9A7A38805401815600
          AC925CFFFFFEFFFFFEA187517F54008155028F5600765B0B835A00824F009680
          3FFFF9F5FAFCFFD5CEB38054007F5103815400E1D5C9FBFFFEF7EBE1885D0C7A
          55017F5300815704AB9365FFFEFFFEFFFB9E884E83570083540389570079652C
          FCFFFAF6FAFFFFFFF885682B7E59007E5600937F48FFFEFBFEFEFEFFFFFBA57F
          55784C05895900A27835B493657950018257008B5C00825300998054FFFCFFFE
          FFF4FFFEFEFAFFFFFCFEFFB5A374815907844F008557008755037E5002895901
          7C6D25FDF9E6FBFFFEEEDDDA82580D8057007D5503CFB996FFFFF8D8C8A47350
          06875A038458007C5600B2A76BFFFEF1FBF9FFFFF7F0967A448152017F4E0082
          5813936D1FFFF8FFFDFAF28066198A5603825300775600A68341FFFFF8FFFDF9
          FFFFF2AD93657A50039464057D5100785008FFFBFFFDF7FFEFFFFFF1FFF9FFFB
          FEE8D1B7715D1CA58E50D7B786E0CEB7F4F2EAEBF0EEEDE7E8FFF7F5FFF9FBFF
          F9FFFDFFFFB9A97E987C3FFBFEFFF7F7FFFBFFFFFBFDFDFFFFFCFDFFFEFFFEFF
          FBFFFFFFFCFFFBFFFBE5DDD08055048555007C5700875005BCA578FDFFFEFFFF
          FEFBFFFFFFFEFD997937805401805500AB915BFFFFFEFFFFFEA187517E530081
          55028F57006D52027C4D007B5405E1D6C2FFFFF9FDFCFFD4CCB58054007F5103
          815400E1D5C9FBFFFEF6EAE0875C0B795400855B087C5100A78E62FFFEFFFFFF
          FCA28C527F55008152018D50008F6C2DFDF3D1EFE8D5DDC8A27E5C1083590084
          5400A7945BFFFFF4FDFBFAFFFDF9AA845482550C8352008159118058007F520E
          7A5200815A007A5610EFE2D2F5FAFBFFFFF8FFFDFFF9FEFFFFFFFFB5A1717C54
          02805000865A008452007B5007794F08C9C39AFDFFFFFEFFFAEBDED67D5A1182
          56007A5400D7C09AFFFEF9FDF9E1796329714800815600805B00795606BC9C71
          C1A98DAA935B735300875B00865D01735200A58C5AFFF8FFFFFDFFB6A572784F
          068357047F5B00765100A2824DCFAE87B49362835B108753008652008259009E
          7A3AEEFFFBF8FCFFFFFFF9FFFFF5FFFBFFEADEC6715605865200805700715B19
          E6E4CCF7FCFDFAFFFBFFFFF9FFFFFCF6FEF4FAFBFFD2C3A3AF8F54F6FFFFFCFA
          FFFEFAF9FFFFFFFFFEFAFDFFFEFFFEFFFBFFFFFFFCFFFBFFFBE5DDD080550485
          55007D5800864F04BBA477FCFFFDFFFFFEFBFFFFFFFEFD9878367F5300805500
          AB915BFFFFFEFFFEFDA086507E5300805401855900744D03865511A6915AFFFF
          FFF7FFF6F9FEFDDDCAB58054007F5103815400E0D4C8FAFFFDF5E9DF865B0A78
          53007D52017B5001C1A87CF5F6FAFFFFFEA18B518157007F50008B5508734800
          8261187E5B1C7C540C7A52008055007F540BD7C7AAFFFFFBFBFEFFFFFFFCAA8A
          487C54018452007B54098456007F5306774F007D5D14BEAC95FFFDFDFFFFF9FA
          FCFCFFFBFFF8FDFFFFFFFCB6A06C7E5401835403845A017E51007F540B977B52
          FFFFF5FFFBFFFFFFFBEAE1D77F590B805400805800D3BD99FBFCFFF8FFFCC0B5
          8F7955157F53067650008956068052047C5604755000865B008357007550007B
          5D0AE0DAC3FFFCFFFBFCFFEFE8CF816529744B028357048557007A4E0080530F
          7E550C7D5100865400815400765A13E4CDADFFFCFFFFFCFFF9FBFBFAFDFFFDF8
          FFFFF8EB8461228558008A5102794F02CDAF8CFFFEFCFFFFFFF6F8FFFFFBFFFF
          FFF4FFFEFFC6B398CFAA6EF4FDFFFFFFFEFFFEFEF8FAFBFDFFFEFDFFFEFFFEFF
          FBFFFFFFFCFFFBFFFBE5DDD08055048555007D5800864F04BAA376FBFEFCFFFF
          FEFBFFFFFFFDFC9777357F53007F5400AA905AFFFEFDFFFEFDA086507E530080
          5401795500854F0EA97C38FFF3E1F8FFF8FAFFFFF7FFF7E3C5B28054007F5103
          815400E0D4C8F9FEFCF4E8DE855A097752007B500192691AFCE3B9FDFDFFFCFD
          FB998349825900815201755000865F03805100895102874F028354027B590DBD
          A063FFFDFFF6FEFFF3FCFFFAFFFB9D87357A56008B58027751038754047D5600
          936916CAAB8CFFFDFFFFFFFEFFFFF9F9FCFFFDFAFFF5FCFFFFFFFCB69C668157
          048153057B55007D53069D6F22F6E6D5FBFEFFFFFBFFFBFFFEE9E3D67F530081
          55027D5400CEB797F8FBFFF1FDFFFFFFF0DCBA858959177D540B855500835400
          855400835202825602795400886428F0C6AFF9FFF8F9FDFEF8FAFFFFFFF8F4E0
          B09E76357C4A02895700885E007B50017A55057B57007A5108826221D1C59BFF
          FEFFFCFFFDFFFFFCFFFFFFFAFCFFF8FEFFFFFFF1A590597D56017F59007D5601
          8A692AFFFEE1F9FEFFE8FAFFF3FFFFFDFFF4FFFFEA9B896CD7D3B6FFFFF2FBFF
          FFFBFEFFF6F9F7FFFFF7FAFFFEFDFFFFFFFEFFFFFCFEFFFEFEF6EEE7CDC4B6C0
          B9A6CDC2A6C3BDA6E3E0D1FFFFF9FDFFFCFFFFFCFBF8F0D8D1C8CFC4A8C4BCA5
          DAD4C9FFFEFBFFFEFBDCD6CBC8C0A9D2C7ABC8C2B5E1DBD0FBF5F0FFFFFEFFFE
          FFFFFFFFFDFBFAECEDE9CEC1ABCBC1AFC9C3B6F2F0E6FFFFF8FAF4E7D0C6B4CA
          BDA7CFC9BCF1EFE4FFFFFBFFFFFCFAFAF4DDD9CEC6BCAACCBFA9CCC1A1CDC2A4
          CEC3A7CBC1A9C5BCA8CCC5B2EAE1D3FFFFF3FDFFFEFCFFFBFFFFF9FDFBF1D9D6
          C8C7C0AFCBC1AFCCC3AFCAC7B9DEDBCDF5F3E9FFFFF9FFFFFCFDFDFDFCFEFFFD
          FEFFFFFEFDFFFFFCFFFDF6E4DDD4CAC1B4CBBEAED4C6B4E2D3C0F0F5F4FDFFFF
          FFFEFFFFFCFEFFFEFEF5EDE6CFC6B8C8C1AEC4BEABEDE9DEFFFFFEF9F9FFF9F9
          FFFFFFFEEDE9DEC4BEABB7956AA483559F804BA68A54B09C6DD5C6A6FAF2E1FF
          FFF9FFFFFEFFFFFFFDFEFFFDFEFFFFFFFFFBF5EED5CABCAC9E8BA78D519F8850
          9B8758AA9A75D0C5AAF6EFE0FFFFF9FFFFFCFAFFFEFEFDF9FFFFFEFDFDFFF3F6
          FEFFFFF8E8D6AD714F0D8253028155026C4600AB9565FFF8E7FFFEFFFFF9FCFF
          FAF8CCBA8B877857FFFFF2FFFFFFFBFEFFF5F8FCFFFFFFFEFDF9FCFEFEFCFEFE
          FFFEFFFCF9FBFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FFFFF6FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFAFFFFFFFFFEFFFFFCFFFDFFF8FAFFFFFDFCFFFFEEAC956F7355047F5500
          935F01804A009E7334CCAE7FD4BB939C835B5F561DDED5B4FFFDFAFFFAFFFBFC
          FFFBFEFFFDFCFEFFFCFFFFFFFEFFFFFFFFFEFFFEFDFFFFFCFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFFFFFDFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FDFEFEFFFDFFFFFCFFFAFBFFFD
          FFF8F8FEFFFFFCFFF7EABC995081570C7F4B00875509794D067752087654007F
          5D00D1C8A6FFFFF1FFFEFEFFFCFFF8F7FFFAFBFFFFFEFFFFFDFFFFFFFEFDFDFD
          FFFFFFFFFEFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFAFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFFFBFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFAFFFFFDFEFCFFFFFCFFFFFEFEFDFFFCFBFFFCFCFFFFFEFFFFF8FFD9C4B5
          A58153906621865E1693753AB09C73FAECCFFFFCFFFFF9F6FFFFF9F8FAF4FDFF
          FFFDFEFFF7F6F8FFFFFEFFFFFFFFFDFDFEFEFEFBFDFDFAFCFDFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFF9FEFFF6FBFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
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
        Left = 679
        Top = 48
        Width = 170
        Height = 17
        Size.Values = (
          37.482638888888900000
          1497.100694444444000000
          105.833333333333300000
          374.826388888888800000)
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
        Left = 679
        Top = 79
        Width = 170
        Height = 17
        Size.Values = (
          37.482638888888900000
          1497.100694444444000000
          174.184027777777800000
          374.826388888888800000)
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
        Left = 679
        Top = 107
        Width = 170
        Height = 17
        Size.Values = (
          37.482638888888900000
          1497.100694444444000000
          235.920138888888900000
          374.826388888888800000)
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
        Left = 679
        Top = 136
        Width = 170
        Height = 18
        Size.Values = (
          39.687500000000000000
          1497.100694444444000000
          299.861111111111200000
          374.826388888888800000)
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
        Caption = '409-0'
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
        Top = 836
        Width = 603
        Height = 13
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          1843.263888888889000000
          1329.531250000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nome do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNomeCedentePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
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
      object QRLabel43: TQRLabel
        Left = 123
        Top = 804
        Width = 462
        Height = 9
        Size.Values = (
          19.843750000000000000
          271.197916666666700000
          1772.708333333333000000
          1018.645833333333000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'Pag'#225'vel em qualquer banco at'#233' o vencimento, ap'#243's somente no unib' +
          'anco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Width = 144
        Height = 23
        Size.Values = (
          50.711805555555600000
          15.434027777777800000
          1699.947916666670000000
          317.500000000000000000)
        XLColumn = 0
        AutoSize = True
        Picture.Data = {
          07544269746D617006270000424D062700000000000036000000280000009000
          0000170000000100180000000000D02600000000000000000000000000000000
          0000F8FCFFFCFDFFFFFFFFFFFFFBFBF1E7F0E1D1EFDECBFFEAD5FFFFF2FFFDF2
          FDFFFEF6FFFFF8FFFFFFFFFBFFFBE9FAE9CFC0AF94B2A083BCA68AE5D0B5FFF7
          E4FFFFF8FFFEFEF7FAFFFAFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFFFFFDFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFFFFFEFCF9E9D8B7A3808067
          2F75550C7A580084610088713FC4B18EEBE2D4FFFFFEFFFFFCD5C7B49C845A96
          783DC0AB78C5AF759F85426B520C837033D9CFA7FFFFF2FDFFFFF7FDFFFDFFFF
          FFFDF8FFFDF8FFFEFFFBFDFFFDFCFFFFFDFFFEFBFFFFFFF5FFFFFBF9FCFFFFFA
          FFF8FFF8FFFFFBFFFFF7FFFEFFFFFCFCFFFDFDFFFEFFFEFCFBFDFFFFF8FCFFFC
          FEFEFFFFFEFFFCFFFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFBFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF8FDFB
          FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5FFFAFAFFFDFDFFFFFFFCFBFDFEFFF5FC
          FFFBFFFFFDFFFFFFFFFCF5FFF9FFFFF9FFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFEDFDFFF5E0CA896D2D6E51008556008957007C55007B53087B5601844C00
          8F7227FEEAD9B28E60815411C1B183F2FBFEFFFFFCFFFEF7FFFFFFC8BDA77951
          09795106CBBC95FFFFF2FBFAFFFAFEF2FFFFF9FDFAFCFBFFFEFAFCFFF5F2FFFF
          FFF8FFFFFFF9FEFDFFFFF7FFFFF9FFFEFFFFFEFFFFFFFBF9FFFBFDFCFFFFFFF0
          FFFFF2F3FCFFF3FCFFFFFFF2FFFFF1FDFCFFFFFFFFFFFCFFFFFFF5FBFFFBFBFE
          FCFFFFFEFFFDFFFFFFEFFDFCFFFCFFF6FFFFE3FDFFFFF3F8FFF4FDFFFFFFEEFE
          FBFDFCFBFFFFFFF1FFFFF4F2FBFFF3FCFFFFFFF0FFFFF1FDFCFFFFFEF6FFFEFC
          FBFFF8FFFFFBFFFDF8FBFFF8FFFEFCFFFFF9FFFEFFFDFDFFFAFFFCEAF6FFFFFA
          FFFFFDFFFFFFF5FFFFFCFFF9FFFFFDFFFCF9F4FDFFFBF4FEFEFAFEFFFFFDFFFF
          FDFCFFFFFBFFFCFAFFFCFFFFFCFEFFFDFFF6FFF5FFFFF4FBF3FFFFFDFEFFFFFB
          F8FEFFF9F8FFFFFAFFFFFAEDFFFFF4FFFEFFFDFFF5FFFFF9FFFDFDFFFEFFFFFF
          FEFFFFF8FFFFF4FFFFF8F7F3F2ECE9E4EAE7D9F4EAD9F8E8D7F2E3D3EDE8D9E3
          E6D6FFF3DDF9F9FFFAFFFEFFFAFDFDFAFFFFFFFCFFFFF8F3E9CBDFD1BEDED2C0
          D8CCBAECE1CDFFFEEBFFFFF5F7FEFFEDFDFFFFFDE89268338251008057007F50
          00845600835A00855100835208877332E4C8AA97742A775906D6C3AEFFFFFCFF
          FFF4FAFFFEFFFDF9FBFCFAFFFFF2AE8C5682530273581FECDECCFDFBFFFFFFF8
          FEFEF8FAFBFFFAFFFEF9FAFEFFFEFFFDF6DBD6BD93AF986AA38953A0824B9C7C
          4B9C7B4A9A7B44A689509A7D56A1824BC4AF89FDFBFBFDFBFBBBA6809C7D4693
          764FA69269FFFDFFFDFFFEF9FAFEF8FCFFFFF4E6C2A68394894D987C4D8F7C43
          A08643E5DFC8FFFFFBEFECD7A78B4E957D4993794A9B7F3FC5B384FEFFF6FFFF
          F8BEAC7D9B7F3F947A4B947D4D9E7A4A9480479C7B439E7D459480479F7B4BAF
          9868D6CAAEFFFFF2FDFFF7FAFFFFC0987B9A79489A803EAD9063FEFFF6FFFFF9
          FFFFFBFFFFFEFBFEFCFFFFF7D9CBAF91794F8F8042A28646917D449B80409075
          359A8E46998D47FFFBF0F7FEFFF5FFFDFAFFF9FFFFEDBEAE89A690569A814392
          7941937846E6D7BDFCFBFFF1F8FFFDFFFFF6EDD2C4AE84967A4B91671C845D0F
          825D0D825A08845504885908825C0A795906B3A277F8F7FFF7FDFFFFFEFEFFFF
          F5BCB387896B3C74561D7A55016E4D007A5B106A4A0886682FB99F7BFFF1E4FF
          FCFFC0A775925C0F884F008158097A561A7E6029795D1D794802896837F5DFBB
          9A78427E5F00C0AB77B7AE82F6E6DAFFFFFFF6FFFFFFFFFEF6FDFFF6FFFED1BA
          8D875400794F02B79C7AFFFAFFFFFFF8FEFFFBFAFFFFF8FEFDFFFFF9F7E9D290
          7B478252047F51008559008054008554008C5805875300905700845200855500
          AA8C55FFFFFBFFFFFBA1834C835300835100A17730FFF9FCF7FEFFFFFFFFFDFE
          FFA289618551057356008B53017D5201774D00E4D5C2FFFEFFF9ECD686580A7F
          4F00835000815000AF905BFFFEFEFFFEFEA687527F4E008451017F53008B5600
          7D53008A55008C57007E54008D58017D5100705310AE9E74FFFEE9FFFFF9AB7E
          418C5B00845800956922F8FFFBF4FAF9FBFDFFFAF8FFFFFDFFFFFEE7977A4176
          5100735601865400794F0083570383530080590082630EFFF9EFF1FFFFF4FDFA
          FFFFEDAA9C627A5D0C7C54008357008156008C5909CAB08BF9F9FFF6FDFFEDE6
          D2886D35754D028154038C5A007C4F007A53007D57057F540382560279530079
          5700AD995FFBFAFCF8FDFFFFFEF29B8A59775D038859008354009356008D5700
          865600875700855900734C009C7E47FFF6D09A7A397748008F6B2BD9C6A0FFF5
          DFFCF6E9F4EDDCEDD6B6F4E4CDAB854B7951008A7537D8C1A7805F029B7737F7
          F0F7FBFDFDFAFFFFEEFBFFF1F9F9CBB780845500865402916B2AFDF6F9FFFFFC
          FDFFFEF5FCFFFAFFFFFFFFF0AF99696D4E008555038C5A007950007756067955
          09724B067F560D8B5800825300865A00A68C56FFFDFFFFFDFF9E844E885C0087
          5800A87634FFFBFFF3FFFFFFFFF1C9C19C7350078D5200865B00895400805603
          794E05E6D6CFF9F6FFF2EBE2825910845503865401875804AC8F62FFFAFFFEF8
          FFA08356845501875502865A008455007B5A1176500877510971500786570085
          59007C4F00775611DCCDACF9F8F4A9874C7C57007E5700987133F9FFFAFBFFFF
          FDFCFFFFFBFFFFFEF9CEB38E774F078959007A5505864D00A17538B48F518554
          0E8754008D6320F8EEFEFAFDFFFFFEFCF0D7B577570B7C550081520182510585
          5801814F00D6C09DFFFEFFFFFAED9B7D448255008053008057028D50008E5A07
          845811855C1D8D62239366228D611A8C651BBBA679FDFFFFF9FAFED8C1A17E5B
          118659008A55008456027B500D906925846117785300805400845700734F0FB6
          996C835C127B5B1AF2E7CCFBFDFEFDFFFFF0F5FEF4FCFFFFFEF6C7AC8A7D5A00
          7A570EDABEADB59252884E00885D00AD8F66FFFDF6F1FDFDECF9FFFFFFF9987F
          2F7F56007B490092690DFCF4F4FFFEFFFBFFFFF3FCFFF9FDFEFFFCE6886C2B86
          5B007C4F0686550071530CA39668D6C59EE2D4B8E0CFAE8B672B7854007C5800
          A7915DFFFEFFFFFEFF9B85517A56007955019C7842FFFDFFEEFAFEFFFFE2886A
          238256008654087D54007F58007655007B5400E9DCC6FCFCFFEDEEDE795E0E77
          57007654007E5B01AB965FFFFFFEFFFFFE9D88517B58007755007B50008F6A20
          F0E1C1F2E8D0ECE2CAC8B9997F5A107D52018D59007F5100A9885AFFFFFEA187
          586F50057C5604835A1BB69C6EB79E76B6A07CB19A74BCA16F7F5D1B7A520083
          56007E5900814F07E5CCA2BFAE7D7452108354008A631EFBF7FDFDFBFFFFFEF6
          9C774B8056037B520083580F7A4D097D5203805204CCBEA2FBFFFFF7E6CB7F51
          038D5900855A00745101765D33D3C0A5F4EBE1FBF6F3FAF4EFFBF2E8FDF5E8FE
          F8EDFFF9ECF8FEFFFFFDF498773F804E008C5500885A027C5F1CE7D2D4FFFDFA
          F7E9D38E7642744E00865B00775200806215855C0DAD9456FFFFF7F1F5FFFFFF
          FFFAFAFFFAFCFFEAE3CF7E5D0E7B4E00876C33FFEBE6926D358B52077D53007C
          5300E7C7AAFBFFFBF2F4FED2B6947A56007A5400855A11916E18FEF9F6FEFBFD
          F8FDFCF8FFFFF7F5FBFFF3DC7C5E177C4E007A4F06845100998048FFFCEAFFFF
          F8FFFFFFFFFFF59479477C56047E5600AE935BFFFFFBFFFFFBA2874F7A52007A
          54028F7C3FFFFBF8FBFFFFC9B29282510383530077500B7555007F5705795500
          825400E9D4B9FFFEFFF0EDDE7B5B0F785300795301815901B0955DFFFFF9FFFF
          F9A388507E56007B5503815305906F2AFFFFF9FBFEFFFBFEFFFFFAF3B6955085
          57098150048958008E682EFFFEFAA282517D5607905B01814D008F5900855400
          7A50007E5700835B007E56007A5500775400795300A67E44FFFFEEA9A0747855
          0B86540090681DFAF4EDFBFFFECFBEA3754F0F8557007F56007B530182560384
          5500835400C2B69AF8FEFFC7B89E81540A8350008559007D5502B8AE90FFFFF1
          FBFEFFF6FDFFF8FFFFFBFFFEFBFFFFFAFFFFFFFCFFF0FBFFFDF1DF8258118B55
          00864F06755006AE9A6BFBFFFBF5FCF7FFFFF5CCB993784D0A8B50008E540C7D
          4B0F936E2ABAA66CFFFEF6FBFAFFFFFFFAFFFFFFFFFEFAAA925E7E56007B4D0D
          B3A162FFFEFAF2E1E48F773B805C047E5300916D31FFFFF1D6CAB27B54108859
          038053007D5709A28B5BFFFEF9FFFDFFF7FAF8FBFFFEFFFCFFF0DFCA6D4D068B
          5B037F56078E5B00B8A06CFFFFFCFEF9FBF9FBFFFFFFF997783B805100835600
          B1935CFFFFFBFFFFFBA88A53825500825302907A33FFFFFBFFF8EB875F2A8954
          037F510082560F7756007E4E067E5304875503E9D4BFFFFCFFF6EFE6855B1488
          5604825107865706B59564FFFCFEFFFCFEA9895884550483520880530294722C
          FFF9F5F9F9FFFDFDFFFFFFFBCDAB657B4E0084510B7C51008B6F2FFFFFFAAE8B
          53855400884D00855B02714A00825E12775103825A028456008C5C0081560076
          5101795B0EEBCFB7FFFDFFAFA3797A4E008C56008C6521FCF8F3FFFFEF86713D
          7F5502814C008357047954027D55008A5800895700CDC2A2F7FCFDB5A3847F52
          088758027C5000805100DAD2B4FFFFF4F8F7F9FAFDFFFEFFFAFFFFF6FDFEFAFB
          FEFFFBFFFFF4FFFDE6D4C381570C85550084550B704C00C2A579F9FBFBF8FEFF
          FFFFFED9C4A8794C098F56008350007C5500D0B8848D7F4BFFFEF7FDF8FFFFFD
          F8FDFFFFF5E9DF7A550B8D4F036D5C00DCCBA4FFFEF8F4F8FFF7FFE98B773084
          5305755601D6BFA59E86507D5700834C038F5A00724F00E6D6CAFFFFFAFFFDFF
          FDFFFEF8FCF7FFFBFFF2DECC745510815200785400865600BCA676FBFFFFFDF9
          FFFBFDFFFFFFF19D7A30855202845503A68C5DFCFDFFFCFDFF9D835482530185
          5202A48138FDF7F8B5A5888250008558007E5600844E07AD843F885908785200
          7D5500E7DDC5F4FAFFECECDE835B098F5A00835200825600AE9660FDFFFEFDFF
          FEA48C568054008453007851028C6D22FCEEE8F5F0EFFAF5F4D8CAC48A6B207A
          5304814C03865F00907F40FBFFFEA1824B875502815200826F26E4E1CCE0D9C5
          F4E2C58F6D3F804D0E854D008650037F5006A89758FFFFF9EDF7FFB0A4748D5D
          00845300836524FAFFFAD3C2A174520C8A54009054027C4C0AAA8A4189661680
          4F00805300C9BF9DFFFFF9B3976E845200804F00805609805204DED9C4FFFFFB
          FDFCFFFFFCFFFFFDFCFFFFFBFEFDFFFAFBFFF8FFF4F8FFF9E0CBBC784F067D57
          00795301805A02CAA170FFFFFBF5F9FAFFFFFFD4C1A67C5211855200885F006F
          5400FFF9F48E854CD5CB9CFFFFF7FAFFFBFFFDFFC0A58B7F5E007D5100705707
          F3EBC6FAFFFEEFFEF6FFFFF5FFF6DE8664296E5100BA8447D4BBA78052008757
          007B4D0DAD977EFFFFEEFDFFFEFFFEFFFBFFFFFFFCFFFBFFFBE5DDD080550485
          55007C5700875005BDA679FDFFFEFFFFFEFBFFFFFFFEFD9A7A38805401805500
          AB915BFFFFFEFFFFFEA187517F54008155029F8041FFF1DC845B167B4F027E58
          06845501947A34D2BFB28054007F5103815400E1D5C9FBFFFEF6EAE0875C0B7A
          5501815500845A01AB9260FFFFFFFFFEFAA48C52845500834F02845004855703
          8B63108960178862147855007957007853038A5A006A520AD8C5AAFFF8F6AC87
          4D795109835206937425FFFFF8F4FFFFDFD4B47D5502845B008050028050087D
          610AF2EAEAF1FBFBFBFDFDB6A16A8757007D4B008B7030FEEFCE946D23844F00
          845504824C05806624E0D7BC7558159157007B5700C7BE9CFFFFF8AE98647E53
          007E53027E5407855700D7D4C5FFFEFFFFFEFFFAFBF7FFFFFBF9F2F7FFFEFFFF
          FAEDFFFEF1FDFDFFE7CDAF7A5305725504825602875404B9A576FFFBFDFFFFF9
          FFFEFBDAC6AD7153068259007B4D007B5503FDFCFFF6E5CA916F41C7A58DFDE7
          F3FFF6FFB3A5818E7A229F803BB1A176FFFFFCF3EEFDF7EBE9D4C1ACBFAD8EDF
          D6AA765A0D905C16DEC2A381590E785406B49365FFF8EAFFFFF8FDFFFEFFFEFF
          FBFFFFFFFCFFFBFFFBE5DDD08055048555007C5700875005BDA679FDFFFEFFFF
          FEFBFFFFFFFEFD9A7A38805401815600AB915BFFFFFEFFFFFEA187517F540081
          5502A18041C1A56F805615765100835204764E00DCCCA8EBD6C08054007F5103
          815400E1D5C9FBFFFEF6EAE0885D0C7A55018054007D5200AD9462FFFEFEFFFE
          FAA0884E8354008554068F54058556007650007D56018054008D5F0080510084
          500D7A510CA89770FFF8EBFFFFFBA8884D7A530883530199742AFFFFFFFEF5EB
          8A753E7752008250048452007F5809C6AD81FFFAF7F8FFFFFDFFFFBAA5728354
          0089580A8D6F28C2AB7E7E51008353057E52007F4F07C3B688F9EFDD80590B84
          52007D5601C2B498FFFFFBA88E5F885A068354037F55087F5200E1DABFFFFFF9
          FFF9FFFFFFFCBBAF8781712C7E6821876C34887A50FFFDFDECD8B9744D007F5A
          067E4F00815002BFA67EFFFFFEF9FDF2FFFFF9D4BFA07A57078555008F580783
          5301F8FFFFFAFAFAFFF8E48877447B6218B09047C9A779DFB8A9ECBDA2DDB89E
          B69C6EA488418A6210774B0079541CD1B299B09757835507D3B788876833BBA8
          7DFFFBE3FDFFFEFAFDFFFDFFFEFFFEFFFBFFFFFFFCFFFBFFFBE5DDD080550485
          55007C5700885106BEA77AFDFFFEFFFFFEFBFFFFFFFEFD9B7B39805401815600
          AC925CFFFFFEFFFFFEA187517F54008155028A601D7F5E0E7B51047F58008953
          009B7C3FFFFCFBE1D2B18054007F5103815400E1D5C9FBFFFEF7EBE1885D0C7B
          5602845A017F5400B29869FEFBFDFFFFFCA38B518357008150028B5500755000
          816B2981662D7C530A855200885300885411DCBF9AFFFEFEFFFEFFF7FCF39E83
          4A7D57098455009A712CFFFCFFC8AB86724E0082590A834C038C5A07886C30FF
          F9F2FFFEFCF8FFFFFBFFFFB4A0707B4F008A5707845F0F8260258754007F5201
          7F5900906C2CEEEFDBF5EBE18857017C54027C5205D0BBA5FFF6F4BB9E728352
          028754047F5104855900E1D4C4FFFFF6F9FEFFFFFEFEB99C75805900865C0083
          570080651BFFFFFCE2D7B97D59008152008755037D5201B99C75F3FAFDF8FFFE
          FFFFFCD9C4A87753078552008B5403815002F1FDF7FBFFFEFFF8FFFFFBFFCFC4
          92907C2F7352037C54006654076B4B097E5702875A00814F00865D01775A0073
          5500D7C69F724F05C3A76BFDECD1FFFFF8FDFFFBF4FDFFFDFAFFFDFFFEFFFEFF
          FBFFFFFFFCFFFBFFFBE5DDD08055048555007C5700885106BEA77AFDFFFEFFFF
          FEFBFFFFFFFEFD9B7B39815502815600AC925CFFFFFEFFFFFEA288527F540081
          55028350007455007D57008855057B5300DEC8AFF8FCFFD5CAAA8054007F5103
          815400E1D5C9FBFFFEF7EBE1885D0C7B56027D52007F5300B09667FDFCFEFFFF
          FCA38B51855900804F0181550084712EFDFBE3F9F1F1E9CFB7835C188055007B
          5300BFA986FFFBFFF5F8FDFBFFF9A68655785106865600A47838FAE4DF88621A
          8054007F5000925D00744C04D2C2B1FFFFFCFFFEFCFAFFFFF9FCFFB2A0717F55
          028752018155007A4D03865401815300735800CCB98CFAFFFCECDDDA88560379
          54007E5409D2BBA1FFFAF4C1A77F8052048250008051007D5400DAD0BEFBFFFB
          F1FEFFFFFDFFBF9E8486520C8551007F5000926C14FFF6F8EAE3CF8463068650
          008655007E5800C5A574F4FDFFF4FDFFFBFBFBD2C2A574510D8052008352027F
          530CFFFCFFFFFFF7F6FCF1FBFFFCFFFFF8FFEFE2CFAD96CDA679AF8948976E30
          8B6612805D00865F11896218966F25B38451D8D3C49A8548A68D4FFFFDF6FAFC
          FFF8FFFFF7FFFFFFFCFFFDFFFEFFFEFFFBFFFFFFFCFFFBFFFBE5DDD080550485
          55007C5700875005BEA77AFDFFFEFFFFFEFBFFFFFFFEFD9A7A38805401815600
          AC925CFFFFFEFFFFFEA187517F54008155028F5600765B0B835A00824F009680
          3FFFF9F5FAFCFFD5CEB38054007F5103815400E1D5C9FBFFFEF7EBE1885D0C7A
          55017F5300815704AB9365FFFEFFFEFFFB9E884E83570083540389570079652C
          FCFFFAF6FAFFFFFFF885682B7E59007E5600937F48FFFEFBFEFEFEFFFFFBA57F
          55784C05895900A27835B493657950018257008B5C00825300998054FFFCFFFE
          FFF4FFFEFEFAFFFFFCFEFFB5A374815907844F008557008755037E5002895901
          7C6D25FDF9E6FBFFFEEEDDDA82580D8057007D5503CFB996FFFFF8D8C8A47350
          06875A038458007C5600B2A76BFFFEF1FBF9FFFFF7F0967A448152017F4E0082
          5813936D1FFFF8FFFDFAF28066198A5603825300775600A68341FFFFF8FFFDF9
          FFFFF2AD93657A50039464057D5100785008FFFBFFFDF7FFEFFFFFF1FFF9FFFB
          FEE8D1B7715D1CA58E50D7B786E0CEB7F4F2EAEBF0EEEDE7E8FFF7F5FFF9FBFF
          F9FFFDFFFFB9A97E987C3FFBFEFFF7F7FFFBFFFFFBFDFDFFFFFCFDFFFEFFFEFF
          FBFFFFFFFCFFFBFFFBE5DDD08055048555007C5700875005BCA578FDFFFEFFFF
          FEFBFFFFFFFEFD997937805401805500AB915BFFFFFEFFFFFEA187517E530081
          55028F57006D52027C4D007B5405E1D6C2FFFFF9FDFCFFD4CCB58054007F5103
          815400E1D5C9FBFFFEF6EAE0875C0B795400855B087C5100A78E62FFFEFFFFFF
          FCA28C527F55008152018D50008F6C2DFDF3D1EFE8D5DDC8A27E5C1083590084
          5400A7945BFFFFF4FDFBFAFFFDF9AA845482550C8352008159118058007F520E
          7A5200815A007A5610EFE2D2F5FAFBFFFFF8FFFDFFF9FEFFFFFFFFB5A1717C54
          02805000865A008452007B5007794F08C9C39AFDFFFFFEFFFAEBDED67D5A1182
          56007A5400D7C09AFFFEF9FDF9E1796329714800815600805B00795606BC9C71
          C1A98DAA935B735300875B00865D01735200A58C5AFFF8FFFFFDFFB6A572784F
          068357047F5B00765100A2824DCFAE87B49362835B108753008652008259009E
          7A3AEEFFFBF8FCFFFFFFF9FFFFF5FFFBFFEADEC6715605865200805700715B19
          E6E4CCF7FCFDFAFFFBFFFFF9FFFFFCF6FEF4FAFBFFD2C3A3AF8F54F6FFFFFCFA
          FFFEFAF9FFFFFFFFFEFAFDFFFEFFFEFFFBFFFFFFFCFFFBFFFBE5DDD080550485
          55007D5800864F04BBA477FCFFFDFFFFFEFBFFFFFFFEFD9878367F5300805500
          AB915BFFFFFEFFFEFDA086507E5300805401855900744D03865511A6915AFFFF
          FFF7FFF6F9FEFDDDCAB58054007F5103815400E0D4C8FAFFFDF5E9DF865B0A78
          53007D52017B5001C1A87CF5F6FAFFFFFEA18B518157007F50008B5508734800
          8261187E5B1C7C540C7A52008055007F540BD7C7AAFFFFFBFBFEFFFFFFFCAA8A
          487C54018452007B54098456007F5306774F007D5D14BEAC95FFFDFDFFFFF9FA
          FCFCFFFBFFF8FDFFFFFFFCB6A06C7E5401835403845A017E51007F540B977B52
          FFFFF5FFFBFFFFFFFBEAE1D77F590B805400805800D3BD99FBFCFFF8FFFCC0B5
          8F7955157F53067650008956068052047C5604755000865B008357007550007B
          5D0AE0DAC3FFFCFFFBFCFFEFE8CF816529744B028357048557007A4E0080530F
          7E550C7D5100865400815400765A13E4CDADFFFCFFFFFCFFF9FBFBFAFDFFFDF8
          FFFFF8EB8461228558008A5102794F02CDAF8CFFFEFCFFFFFFF6F8FFFFFBFFFF
          FFF4FFFEFFC6B398CFAA6EF4FDFFFFFFFEFFFEFEF8FAFBFDFFFEFDFFFEFFFEFF
          FBFFFFFFFCFFFBFFFBE5DDD08055048555007D5800864F04BAA376FBFEFCFFFF
          FEFBFFFFFFFDFC9777357F53007F5400AA905AFFFEFDFFFEFDA086507E530080
          5401795500854F0EA97C38FFF3E1F8FFF8FAFFFFF7FFF7E3C5B28054007F5103
          815400E0D4C8F9FEFCF4E8DE855A097752007B500192691AFCE3B9FDFDFFFCFD
          FB998349825900815201755000865F03805100895102874F028354027B590DBD
          A063FFFDFFF6FEFFF3FCFFFAFFFB9D87357A56008B58027751038754047D5600
          936916CAAB8CFFFDFFFFFFFEFFFFF9F9FCFFFDFAFFF5FCFFFFFFFCB69C668157
          048153057B55007D53069D6F22F6E6D5FBFEFFFFFBFFFBFFFEE9E3D67F530081
          55027D5400CEB797F8FBFFF1FDFFFFFFF0DCBA858959177D540B855500835400
          855400835202825602795400886428F0C6AFF9FFF8F9FDFEF8FAFFFFFFF8F4E0
          B09E76357C4A02895700885E007B50017A55057B57007A5108826221D1C59BFF
          FEFFFCFFFDFFFFFCFFFFFFFAFCFFF8FEFFFFFFF1A590597D56017F59007D5601
          8A692AFFFEE1F9FEFFE8FAFFF3FFFFFDFFF4FFFFEA9B896CD7D3B6FFFFF2FBFF
          FFFBFEFFF6F9F7FFFFF7FAFFFEFDFFFFFFFEFFFFFCFEFFFEFEF6EEE7CDC4B6C0
          B9A6CDC2A6C3BDA6E3E0D1FFFFF9FDFFFCFFFFFCFBF8F0D8D1C8CFC4A8C4BCA5
          DAD4C9FFFEFBFFFEFBDCD6CBC8C0A9D2C7ABC8C2B5E1DBD0FBF5F0FFFFFEFFFE
          FFFFFFFFFDFBFAECEDE9CEC1ABCBC1AFC9C3B6F2F0E6FFFFF8FAF4E7D0C6B4CA
          BDA7CFC9BCF1EFE4FFFFFBFFFFFCFAFAF4DDD9CEC6BCAACCBFA9CCC1A1CDC2A4
          CEC3A7CBC1A9C5BCA8CCC5B2EAE1D3FFFFF3FDFFFEFCFFFBFFFFF9FDFBF1D9D6
          C8C7C0AFCBC1AFCCC3AFCAC7B9DEDBCDF5F3E9FFFFF9FFFFFCFDFDFDFCFEFFFD
          FEFFFFFEFDFFFFFCFFFDF6E4DDD4CAC1B4CBBEAED4C6B4E2D3C0F0F5F4FDFFFF
          FFFEFFFFFCFEFFFEFEF5EDE6CFC6B8C8C1AEC4BEABEDE9DEFFFFFEF9F9FFF9F9
          FFFFFFFEEDE9DEC4BEABB7956AA483559F804BA68A54B09C6DD5C6A6FAF2E1FF
          FFF9FFFFFEFFFFFFFDFEFFFDFEFFFFFFFFFBF5EED5CABCAC9E8BA78D519F8850
          9B8758AA9A75D0C5AAF6EFE0FFFFF9FFFFFCFAFFFEFEFDF9FFFFFEFDFDFFF3F6
          FEFFFFF8E8D6AD714F0D8253028155026C4600AB9565FFF8E7FFFEFFFFF9FCFF
          FAF8CCBA8B877857FFFFF2FFFFFFFBFEFFF5F8FCFFFFFFFEFDF9FCFEFEFCFEFE
          FFFEFFFCF9FBFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FFFFF6FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFAFFFFFFFFFEFFFFFCFFFDFFF8FAFFFFFDFCFFFFEEAC956F7355047F5500
          935F01804A009E7334CCAE7FD4BB939C835B5F561DDED5B4FFFDFAFFFAFFFBFC
          FFFBFEFFFDFCFEFFFCFFFFFFFEFFFFFFFFFEFFFEFDFFFFFCFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFFFFFDFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FDFEFEFFFDFFFFFCFFFAFBFFFD
          FFF8F8FEFFFFFCFFF7EABC995081570C7F4B00875509794D067752087654007F
          5D00D1C8A6FFFFF1FFFEFEFFFCFFF8F7FFFAFBFFFFFEFFFFFDFFFFFFFEFDFDFD
          FFFFFFFFFEFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFAFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFFFBFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFAFFFFFDFEFCFFFFFCFFFFFEFEFDFFFCFBFFFCFCFFFFFEFFFFF8FFD9C4B5
          A58153906621865E1693753AB09C73FAECCFFFFCFFFFF9F6FFFFF9F8FAF4FDFF
          FFFDFEFFF7F6F8FFFFFEFFFFFFFFFDFDFEFEFEFBFDFDFAFCFDFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFF9FEFFF6FBFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
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
        Left = 678
        Top = 816
        Width = 171
        Height = 18
        Size.Values = (
          39.687500000000000000
          1494.895833333333000000
          1799.166666666667000000
          377.031250000000000000)
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
        Left = 678
        Top = 846
        Width = 171
        Height = 18
        Size.Values = (
          39.687500000000000000
          1494.895833333333000000
          1865.312500000000000000
          377.031250000000000000)
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
        Left = 678
        Top = 877
        Width = 171
        Height = 17
        Size.Values = (
          37.482638888888900000
          1494.895833333333000000
          1933.663194444444000000
          377.031250000000000000)
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
        Left = 678
        Top = 907
        Width = 171
        Height = 17
        Size.Values = (
          37.482638888888900000
          1494.895833333333000000
          1999.809027777778000000
          377.031250000000000000)
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
        Left = 794
        Top = 755
        Width = 19
        Height = 19
        Size.Values = (
          41.892361111111110000
          1750.659722222222000000
          1664.670138888889000000
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
        Caption = '409-0'
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
        Top = 440
        Width = 603
        Height = 13
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          970.138888888888900000
          1329.531250000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nome do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNomeCedentePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
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
      object QRLabel117: TQRLabel
        Left = 123
        Top = 408
        Width = 454
        Height = 9
        Size.Values = (
          19.843750000000000000
          271.197916666666700000
          899.583333333333400000
          1001.006944444444000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'Pag'#225'vel em qualquer banco at'#233' o vencimento, ap'#243's somente no unib' +
          'anco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Width = 144
        Height = 23
        Size.Values = (
          50.711805555555600000
          15.434027777777800000
          824.618055555556000000
          317.500000000000000000)
        XLColumn = 0
        AutoSize = True
        Picture.Data = {
          07544269746D617006270000424D062700000000000036000000280000009000
          0000170000000100180000000000D02600000000000000000000000000000000
          0000F8FCFFFCFDFFFFFFFFFFFFFBFBF1E7F0E1D1EFDECBFFEAD5FFFFF2FFFDF2
          FDFFFEF6FFFFF8FFFFFFFFFBFFFBE9FAE9CFC0AF94B2A083BCA68AE5D0B5FFF7
          E4FFFFF8FFFEFEF7FAFFFAFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFFFFFDFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFFFFFEFCF9E9D8B7A3808067
          2F75550C7A580084610088713FC4B18EEBE2D4FFFFFEFFFFFCD5C7B49C845A96
          783DC0AB78C5AF759F85426B520C837033D9CFA7FFFFF2FDFFFFF7FDFFFDFFFF
          FFFDF8FFFDF8FFFEFFFBFDFFFDFCFFFFFDFFFEFBFFFFFFF5FFFFFBF9FCFFFFFA
          FFF8FFF8FFFFFBFFFFF7FFFEFFFFFCFCFFFDFDFFFEFFFEFCFBFDFFFFF8FCFFFC
          FEFEFFFFFEFFFCFFFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFBFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF8FDFB
          FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5FFFAFAFFFDFDFFFFFFFCFBFDFEFFF5FC
          FFFBFFFFFDFFFFFFFFFCF5FFF9FFFFF9FFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFEDFDFFF5E0CA896D2D6E51008556008957007C55007B53087B5601844C00
          8F7227FEEAD9B28E60815411C1B183F2FBFEFFFFFCFFFEF7FFFFFFC8BDA77951
          09795106CBBC95FFFFF2FBFAFFFAFEF2FFFFF9FDFAFCFBFFFEFAFCFFF5F2FFFF
          FFF8FFFFFFF9FEFDFFFFF7FFFFF9FFFEFFFFFEFFFFFFFBF9FFFBFDFCFFFFFFF0
          FFFFF2F3FCFFF3FCFFFFFFF2FFFFF1FDFCFFFFFFFFFFFCFFFFFFF5FBFFFBFBFE
          FCFFFFFEFFFDFFFFFFEFFDFCFFFCFFF6FFFFE3FDFFFFF3F8FFF4FDFFFFFFEEFE
          FBFDFCFBFFFFFFF1FFFFF4F2FBFFF3FCFFFFFFF0FFFFF1FDFCFFFFFEF6FFFEFC
          FBFFF8FFFFFBFFFDF8FBFFF8FFFEFCFFFFF9FFFEFFFDFDFFFAFFFCEAF6FFFFFA
          FFFFFDFFFFFFF5FFFFFCFFF9FFFFFDFFFCF9F4FDFFFBF4FEFEFAFEFFFFFDFFFF
          FDFCFFFFFBFFFCFAFFFCFFFFFCFEFFFDFFF6FFF5FFFFF4FBF3FFFFFDFEFFFFFB
          F8FEFFF9F8FFFFFAFFFFFAEDFFFFF4FFFEFFFDFFF5FFFFF9FFFDFDFFFEFFFFFF
          FEFFFFF8FFFFF4FFFFF8F7F3F2ECE9E4EAE7D9F4EAD9F8E8D7F2E3D3EDE8D9E3
          E6D6FFF3DDF9F9FFFAFFFEFFFAFDFDFAFFFFFFFCFFFFF8F3E9CBDFD1BEDED2C0
          D8CCBAECE1CDFFFEEBFFFFF5F7FEFFEDFDFFFFFDE89268338251008057007F50
          00845600835A00855100835208877332E4C8AA97742A775906D6C3AEFFFFFCFF
          FFF4FAFFFEFFFDF9FBFCFAFFFFF2AE8C5682530273581FECDECCFDFBFFFFFFF8
          FEFEF8FAFBFFFAFFFEF9FAFEFFFEFFFDF6DBD6BD93AF986AA38953A0824B9C7C
          4B9C7B4A9A7B44A689509A7D56A1824BC4AF89FDFBFBFDFBFBBBA6809C7D4693
          764FA69269FFFDFFFDFFFEF9FAFEF8FCFFFFF4E6C2A68394894D987C4D8F7C43
          A08643E5DFC8FFFFFBEFECD7A78B4E957D4993794A9B7F3FC5B384FEFFF6FFFF
          F8BEAC7D9B7F3F947A4B947D4D9E7A4A9480479C7B439E7D459480479F7B4BAF
          9868D6CAAEFFFFF2FDFFF7FAFFFFC0987B9A79489A803EAD9063FEFFF6FFFFF9
          FFFFFBFFFFFEFBFEFCFFFFF7D9CBAF91794F8F8042A28646917D449B80409075
          359A8E46998D47FFFBF0F7FEFFF5FFFDFAFFF9FFFFEDBEAE89A690569A814392
          7941937846E6D7BDFCFBFFF1F8FFFDFFFFF6EDD2C4AE84967A4B91671C845D0F
          825D0D825A08845504885908825C0A795906B3A277F8F7FFF7FDFFFFFEFEFFFF
          F5BCB387896B3C74561D7A55016E4D007A5B106A4A0886682FB99F7BFFF1E4FF
          FCFFC0A775925C0F884F008158097A561A7E6029795D1D794802896837F5DFBB
          9A78427E5F00C0AB77B7AE82F6E6DAFFFFFFF6FFFFFFFFFEF6FDFFF6FFFED1BA
          8D875400794F02B79C7AFFFAFFFFFFF8FEFFFBFAFFFFF8FEFDFFFFF9F7E9D290
          7B478252047F51008559008054008554008C5805875300905700845200855500
          AA8C55FFFFFBFFFFFBA1834C835300835100A17730FFF9FCF7FEFFFFFFFFFDFE
          FFA289618551057356008B53017D5201774D00E4D5C2FFFEFFF9ECD686580A7F
          4F00835000815000AF905BFFFEFEFFFEFEA687527F4E008451017F53008B5600
          7D53008A55008C57007E54008D58017D5100705310AE9E74FFFEE9FFFFF9AB7E
          418C5B00845800956922F8FFFBF4FAF9FBFDFFFAF8FFFFFDFFFFFEE7977A4176
          5100735601865400794F0083570383530080590082630EFFF9EFF1FFFFF4FDFA
          FFFFEDAA9C627A5D0C7C54008357008156008C5909CAB08BF9F9FFF6FDFFEDE6
          D2886D35754D028154038C5A007C4F007A53007D57057F540382560279530079
          5700AD995FFBFAFCF8FDFFFFFEF29B8A59775D038859008354009356008D5700
          865600875700855900734C009C7E47FFF6D09A7A397748008F6B2BD9C6A0FFF5
          DFFCF6E9F4EDDCEDD6B6F4E4CDAB854B7951008A7537D8C1A7805F029B7737F7
          F0F7FBFDFDFAFFFFEEFBFFF1F9F9CBB780845500865402916B2AFDF6F9FFFFFC
          FDFFFEF5FCFFFAFFFFFFFFF0AF99696D4E008555038C5A007950007756067955
          09724B067F560D8B5800825300865A00A68C56FFFDFFFFFDFF9E844E885C0087
          5800A87634FFFBFFF3FFFFFFFFF1C9C19C7350078D5200865B00895400805603
          794E05E6D6CFF9F6FFF2EBE2825910845503865401875804AC8F62FFFAFFFEF8
          FFA08356845501875502865A008455007B5A1176500877510971500786570085
          59007C4F00775611DCCDACF9F8F4A9874C7C57007E5700987133F9FFFAFBFFFF
          FDFCFFFFFBFFFFFEF9CEB38E774F078959007A5505864D00A17538B48F518554
          0E8754008D6320F8EEFEFAFDFFFFFEFCF0D7B577570B7C550081520182510585
          5801814F00D6C09DFFFEFFFFFAED9B7D448255008053008057028D50008E5A07
          845811855C1D8D62239366228D611A8C651BBBA679FDFFFFF9FAFED8C1A17E5B
          118659008A55008456027B500D906925846117785300805400845700734F0FB6
          996C835C127B5B1AF2E7CCFBFDFEFDFFFFF0F5FEF4FCFFFFFEF6C7AC8A7D5A00
          7A570EDABEADB59252884E00885D00AD8F66FFFDF6F1FDFDECF9FFFFFFF9987F
          2F7F56007B490092690DFCF4F4FFFEFFFBFFFFF3FCFFF9FDFEFFFCE6886C2B86
          5B007C4F0686550071530CA39668D6C59EE2D4B8E0CFAE8B672B7854007C5800
          A7915DFFFEFFFFFEFF9B85517A56007955019C7842FFFDFFEEFAFEFFFFE2886A
          238256008654087D54007F58007655007B5400E9DCC6FCFCFFEDEEDE795E0E77
          57007654007E5B01AB965FFFFFFEFFFFFE9D88517B58007755007B50008F6A20
          F0E1C1F2E8D0ECE2CAC8B9997F5A107D52018D59007F5100A9885AFFFFFEA187
          586F50057C5604835A1BB69C6EB79E76B6A07CB19A74BCA16F7F5D1B7A520083
          56007E5900814F07E5CCA2BFAE7D7452108354008A631EFBF7FDFDFBFFFFFEF6
          9C774B8056037B520083580F7A4D097D5203805204CCBEA2FBFFFFF7E6CB7F51
          038D5900855A00745101765D33D3C0A5F4EBE1FBF6F3FAF4EFFBF2E8FDF5E8FE
          F8EDFFF9ECF8FEFFFFFDF498773F804E008C5500885A027C5F1CE7D2D4FFFDFA
          F7E9D38E7642744E00865B00775200806215855C0DAD9456FFFFF7F1F5FFFFFF
          FFFAFAFFFAFCFFEAE3CF7E5D0E7B4E00876C33FFEBE6926D358B52077D53007C
          5300E7C7AAFBFFFBF2F4FED2B6947A56007A5400855A11916E18FEF9F6FEFBFD
          F8FDFCF8FFFFF7F5FBFFF3DC7C5E177C4E007A4F06845100998048FFFCEAFFFF
          F8FFFFFFFFFFF59479477C56047E5600AE935BFFFFFBFFFFFBA2874F7A52007A
          54028F7C3FFFFBF8FBFFFFC9B29282510383530077500B7555007F5705795500
          825400E9D4B9FFFEFFF0EDDE7B5B0F785300795301815901B0955DFFFFF9FFFF
          F9A388507E56007B5503815305906F2AFFFFF9FBFEFFFBFEFFFFFAF3B6955085
          57098150048958008E682EFFFEFAA282517D5607905B01814D008F5900855400
          7A50007E5700835B007E56007A5500775400795300A67E44FFFFEEA9A0747855
          0B86540090681DFAF4EDFBFFFECFBEA3754F0F8557007F56007B530182560384
          5500835400C2B69AF8FEFFC7B89E81540A8350008559007D5502B8AE90FFFFF1
          FBFEFFF6FDFFF8FFFFFBFFFEFBFFFFFAFFFFFFFCFFF0FBFFFDF1DF8258118B55
          00864F06755006AE9A6BFBFFFBF5FCF7FFFFF5CCB993784D0A8B50008E540C7D
          4B0F936E2ABAA66CFFFEF6FBFAFFFFFFFAFFFFFFFFFEFAAA925E7E56007B4D0D
          B3A162FFFEFAF2E1E48F773B805C047E5300916D31FFFFF1D6CAB27B54108859
          038053007D5709A28B5BFFFEF9FFFDFFF7FAF8FBFFFEFFFCFFF0DFCA6D4D068B
          5B037F56078E5B00B8A06CFFFFFCFEF9FBF9FBFFFFFFF997783B805100835600
          B1935CFFFFFBFFFFFBA88A53825500825302907A33FFFFFBFFF8EB875F2A8954
          037F510082560F7756007E4E067E5304875503E9D4BFFFFCFFF6EFE6855B1488
          5604825107865706B59564FFFCFEFFFCFEA9895884550483520880530294722C
          FFF9F5F9F9FFFDFDFFFFFFFBCDAB657B4E0084510B7C51008B6F2FFFFFFAAE8B
          53855400884D00855B02714A00825E12775103825A028456008C5C0081560076
          5101795B0EEBCFB7FFFDFFAFA3797A4E008C56008C6521FCF8F3FFFFEF86713D
          7F5502814C008357047954027D55008A5800895700CDC2A2F7FCFDB5A3847F52
          088758027C5000805100DAD2B4FFFFF4F8F7F9FAFDFFFEFFFAFFFFF6FDFEFAFB
          FEFFFBFFFFF4FFFDE6D4C381570C85550084550B704C00C2A579F9FBFBF8FEFF
          FFFFFED9C4A8794C098F56008350007C5500D0B8848D7F4BFFFEF7FDF8FFFFFD
          F8FDFFFFF5E9DF7A550B8D4F036D5C00DCCBA4FFFEF8F4F8FFF7FFE98B773084
          5305755601D6BFA59E86507D5700834C038F5A00724F00E6D6CAFFFFFAFFFDFF
          FDFFFEF8FCF7FFFBFFF2DECC745510815200785400865600BCA676FBFFFFFDF9
          FFFBFDFFFFFFF19D7A30855202845503A68C5DFCFDFFFCFDFF9D835482530185
          5202A48138FDF7F8B5A5888250008558007E5600844E07AD843F885908785200
          7D5500E7DDC5F4FAFFECECDE835B098F5A00835200825600AE9660FDFFFEFDFF
          FEA48C568054008453007851028C6D22FCEEE8F5F0EFFAF5F4D8CAC48A6B207A
          5304814C03865F00907F40FBFFFEA1824B875502815200826F26E4E1CCE0D9C5
          F4E2C58F6D3F804D0E854D008650037F5006A89758FFFFF9EDF7FFB0A4748D5D
          00845300836524FAFFFAD3C2A174520C8A54009054027C4C0AAA8A4189661680
          4F00805300C9BF9DFFFFF9B3976E845200804F00805609805204DED9C4FFFFFB
          FDFCFFFFFCFFFFFDFCFFFFFBFEFDFFFAFBFFF8FFF4F8FFF9E0CBBC784F067D57
          00795301805A02CAA170FFFFFBF5F9FAFFFFFFD4C1A67C5211855200885F006F
          5400FFF9F48E854CD5CB9CFFFFF7FAFFFBFFFDFFC0A58B7F5E007D5100705707
          F3EBC6FAFFFEEFFEF6FFFFF5FFF6DE8664296E5100BA8447D4BBA78052008757
          007B4D0DAD977EFFFFEEFDFFFEFFFEFFFBFFFFFFFCFFFBFFFBE5DDD080550485
          55007C5700875005BDA679FDFFFEFFFFFEFBFFFFFFFEFD9A7A38805401805500
          AB915BFFFFFEFFFFFEA187517F54008155029F8041FFF1DC845B167B4F027E58
          06845501947A34D2BFB28054007F5103815400E1D5C9FBFFFEF6EAE0875C0B7A
          5501815500845A01AB9260FFFFFFFFFEFAA48C52845500834F02845004855703
          8B63108960178862147855007957007853038A5A006A520AD8C5AAFFF8F6AC87
          4D795109835206937425FFFFF8F4FFFFDFD4B47D5502845B008050028050087D
          610AF2EAEAF1FBFBFBFDFDB6A16A8757007D4B008B7030FEEFCE946D23844F00
          845504824C05806624E0D7BC7558159157007B5700C7BE9CFFFFF8AE98647E53
          007E53027E5407855700D7D4C5FFFEFFFFFEFFFAFBF7FFFFFBF9F2F7FFFEFFFF
          FAEDFFFEF1FDFDFFE7CDAF7A5305725504825602875404B9A576FFFBFDFFFFF9
          FFFEFBDAC6AD7153068259007B4D007B5503FDFCFFF6E5CA916F41C7A58DFDE7
          F3FFF6FFB3A5818E7A229F803BB1A176FFFFFCF3EEFDF7EBE9D4C1ACBFAD8EDF
          D6AA765A0D905C16DEC2A381590E785406B49365FFF8EAFFFFF8FDFFFEFFFEFF
          FBFFFFFFFCFFFBFFFBE5DDD08055048555007C5700875005BDA679FDFFFEFFFF
          FEFBFFFFFFFEFD9A7A38805401815600AB915BFFFFFEFFFFFEA187517F540081
          5502A18041C1A56F805615765100835204764E00DCCCA8EBD6C08054007F5103
          815400E1D5C9FBFFFEF6EAE0885D0C7A55018054007D5200AD9462FFFEFEFFFE
          FAA0884E8354008554068F54058556007650007D56018054008D5F0080510084
          500D7A510CA89770FFF8EBFFFFFBA8884D7A530883530199742AFFFFFFFEF5EB
          8A753E7752008250048452007F5809C6AD81FFFAF7F8FFFFFDFFFFBAA5728354
          0089580A8D6F28C2AB7E7E51008353057E52007F4F07C3B688F9EFDD80590B84
          52007D5601C2B498FFFFFBA88E5F885A068354037F55087F5200E1DABFFFFFF9
          FFF9FFFFFFFCBBAF8781712C7E6821876C34887A50FFFDFDECD8B9744D007F5A
          067E4F00815002BFA67EFFFFFEF9FDF2FFFFF9D4BFA07A57078555008F580783
          5301F8FFFFFAFAFAFFF8E48877447B6218B09047C9A779DFB8A9ECBDA2DDB89E
          B69C6EA488418A6210774B0079541CD1B299B09757835507D3B788876833BBA8
          7DFFFBE3FDFFFEFAFDFFFDFFFEFFFEFFFBFFFFFFFCFFFBFFFBE5DDD080550485
          55007C5700885106BEA77AFDFFFEFFFFFEFBFFFFFFFEFD9B7B39805401815600
          AC925CFFFFFEFFFFFEA187517F54008155028A601D7F5E0E7B51047F58008953
          009B7C3FFFFCFBE1D2B18054007F5103815400E1D5C9FBFFFEF7EBE1885D0C7B
          5602845A017F5400B29869FEFBFDFFFFFCA38B518357008150028B5500755000
          816B2981662D7C530A855200885300885411DCBF9AFFFEFEFFFEFFF7FCF39E83
          4A7D57098455009A712CFFFCFFC8AB86724E0082590A834C038C5A07886C30FF
          F9F2FFFEFCF8FFFFFBFFFFB4A0707B4F008A5707845F0F8260258754007F5201
          7F5900906C2CEEEFDBF5EBE18857017C54027C5205D0BBA5FFF6F4BB9E728352
          028754047F5104855900E1D4C4FFFFF6F9FEFFFFFEFEB99C75805900865C0083
          570080651BFFFFFCE2D7B97D59008152008755037D5201B99C75F3FAFDF8FFFE
          FFFFFCD9C4A87753078552008B5403815002F1FDF7FBFFFEFFF8FFFFFBFFCFC4
          92907C2F7352037C54006654076B4B097E5702875A00814F00865D01775A0073
          5500D7C69F724F05C3A76BFDECD1FFFFF8FDFFFBF4FDFFFDFAFFFDFFFEFFFEFF
          FBFFFFFFFCFFFBFFFBE5DDD08055048555007C5700885106BEA77AFDFFFEFFFF
          FEFBFFFFFFFEFD9B7B39815502815600AC925CFFFFFEFFFFFEA288527F540081
          55028350007455007D57008855057B5300DEC8AFF8FCFFD5CAAA8054007F5103
          815400E1D5C9FBFFFEF7EBE1885D0C7B56027D52007F5300B09667FDFCFEFFFF
          FCA38B51855900804F0181550084712EFDFBE3F9F1F1E9CFB7835C188055007B
          5300BFA986FFFBFFF5F8FDFBFFF9A68655785106865600A47838FAE4DF88621A
          8054007F5000925D00744C04D2C2B1FFFFFCFFFEFCFAFFFFF9FCFFB2A0717F55
          028752018155007A4D03865401815300735800CCB98CFAFFFCECDDDA88560379
          54007E5409D2BBA1FFFAF4C1A77F8052048250008051007D5400DAD0BEFBFFFB
          F1FEFFFFFDFFBF9E8486520C8551007F5000926C14FFF6F8EAE3CF8463068650
          008655007E5800C5A574F4FDFFF4FDFFFBFBFBD2C2A574510D8052008352027F
          530CFFFCFFFFFFF7F6FCF1FBFFFCFFFFF8FFEFE2CFAD96CDA679AF8948976E30
          8B6612805D00865F11896218966F25B38451D8D3C49A8548A68D4FFFFDF6FAFC
          FFF8FFFFF7FFFFFFFCFFFDFFFEFFFEFFFBFFFFFFFCFFFBFFFBE5DDD080550485
          55007C5700875005BEA77AFDFFFEFFFFFEFBFFFFFFFEFD9A7A38805401815600
          AC925CFFFFFEFFFFFEA187517F54008155028F5600765B0B835A00824F009680
          3FFFF9F5FAFCFFD5CEB38054007F5103815400E1D5C9FBFFFEF7EBE1885D0C7A
          55017F5300815704AB9365FFFEFFFEFFFB9E884E83570083540389570079652C
          FCFFFAF6FAFFFFFFF885682B7E59007E5600937F48FFFEFBFEFEFEFFFFFBA57F
          55784C05895900A27835B493657950018257008B5C00825300998054FFFCFFFE
          FFF4FFFEFEFAFFFFFCFEFFB5A374815907844F008557008755037E5002895901
          7C6D25FDF9E6FBFFFEEEDDDA82580D8057007D5503CFB996FFFFF8D8C8A47350
          06875A038458007C5600B2A76BFFFEF1FBF9FFFFF7F0967A448152017F4E0082
          5813936D1FFFF8FFFDFAF28066198A5603825300775600A68341FFFFF8FFFDF9
          FFFFF2AD93657A50039464057D5100785008FFFBFFFDF7FFEFFFFFF1FFF9FFFB
          FEE8D1B7715D1CA58E50D7B786E0CEB7F4F2EAEBF0EEEDE7E8FFF7F5FFF9FBFF
          F9FFFDFFFFB9A97E987C3FFBFEFFF7F7FFFBFFFFFBFDFDFFFFFCFDFFFEFFFEFF
          FBFFFFFFFCFFFBFFFBE5DDD08055048555007C5700875005BCA578FDFFFEFFFF
          FEFBFFFFFFFEFD997937805401805500AB915BFFFFFEFFFFFEA187517E530081
          55028F57006D52027C4D007B5405E1D6C2FFFFF9FDFCFFD4CCB58054007F5103
          815400E1D5C9FBFFFEF6EAE0875C0B795400855B087C5100A78E62FFFEFFFFFF
          FCA28C527F55008152018D50008F6C2DFDF3D1EFE8D5DDC8A27E5C1083590084
          5400A7945BFFFFF4FDFBFAFFFDF9AA845482550C8352008159118058007F520E
          7A5200815A007A5610EFE2D2F5FAFBFFFFF8FFFDFFF9FEFFFFFFFFB5A1717C54
          02805000865A008452007B5007794F08C9C39AFDFFFFFEFFFAEBDED67D5A1182
          56007A5400D7C09AFFFEF9FDF9E1796329714800815600805B00795606BC9C71
          C1A98DAA935B735300875B00865D01735200A58C5AFFF8FFFFFDFFB6A572784F
          068357047F5B00765100A2824DCFAE87B49362835B108753008652008259009E
          7A3AEEFFFBF8FCFFFFFFF9FFFFF5FFFBFFEADEC6715605865200805700715B19
          E6E4CCF7FCFDFAFFFBFFFFF9FFFFFCF6FEF4FAFBFFD2C3A3AF8F54F6FFFFFCFA
          FFFEFAF9FFFFFFFFFEFAFDFFFEFFFEFFFBFFFFFFFCFFFBFFFBE5DDD080550485
          55007D5800864F04BBA477FCFFFDFFFFFEFBFFFFFFFEFD9878367F5300805500
          AB915BFFFFFEFFFEFDA086507E5300805401855900744D03865511A6915AFFFF
          FFF7FFF6F9FEFDDDCAB58054007F5103815400E0D4C8FAFFFDF5E9DF865B0A78
          53007D52017B5001C1A87CF5F6FAFFFFFEA18B518157007F50008B5508734800
          8261187E5B1C7C540C7A52008055007F540BD7C7AAFFFFFBFBFEFFFFFFFCAA8A
          487C54018452007B54098456007F5306774F007D5D14BEAC95FFFDFDFFFFF9FA
          FCFCFFFBFFF8FDFFFFFFFCB6A06C7E5401835403845A017E51007F540B977B52
          FFFFF5FFFBFFFFFFFBEAE1D77F590B805400805800D3BD99FBFCFFF8FFFCC0B5
          8F7955157F53067650008956068052047C5604755000865B008357007550007B
          5D0AE0DAC3FFFCFFFBFCFFEFE8CF816529744B028357048557007A4E0080530F
          7E550C7D5100865400815400765A13E4CDADFFFCFFFFFCFFF9FBFBFAFDFFFDF8
          FFFFF8EB8461228558008A5102794F02CDAF8CFFFEFCFFFFFFF6F8FFFFFBFFFF
          FFF4FFFEFFC6B398CFAA6EF4FDFFFFFFFEFFFEFEF8FAFBFDFFFEFDFFFEFFFEFF
          FBFFFFFFFCFFFBFFFBE5DDD08055048555007D5800864F04BAA376FBFEFCFFFF
          FEFBFFFFFFFDFC9777357F53007F5400AA905AFFFEFDFFFEFDA086507E530080
          5401795500854F0EA97C38FFF3E1F8FFF8FAFFFFF7FFF7E3C5B28054007F5103
          815400E0D4C8F9FEFCF4E8DE855A097752007B500192691AFCE3B9FDFDFFFCFD
          FB998349825900815201755000865F03805100895102874F028354027B590DBD
          A063FFFDFFF6FEFFF3FCFFFAFFFB9D87357A56008B58027751038754047D5600
          936916CAAB8CFFFDFFFFFFFEFFFFF9F9FCFFFDFAFFF5FCFFFFFFFCB69C668157
          048153057B55007D53069D6F22F6E6D5FBFEFFFFFBFFFBFFFEE9E3D67F530081
          55027D5400CEB797F8FBFFF1FDFFFFFFF0DCBA858959177D540B855500835400
          855400835202825602795400886428F0C6AFF9FFF8F9FDFEF8FAFFFFFFF8F4E0
          B09E76357C4A02895700885E007B50017A55057B57007A5108826221D1C59BFF
          FEFFFCFFFDFFFFFCFFFFFFFAFCFFF8FEFFFFFFF1A590597D56017F59007D5601
          8A692AFFFEE1F9FEFFE8FAFFF3FFFFFDFFF4FFFFEA9B896CD7D3B6FFFFF2FBFF
          FFFBFEFFF6F9F7FFFFF7FAFFFEFDFFFFFFFEFFFFFCFEFFFEFEF6EEE7CDC4B6C0
          B9A6CDC2A6C3BDA6E3E0D1FFFFF9FDFFFCFFFFFCFBF8F0D8D1C8CFC4A8C4BCA5
          DAD4C9FFFEFBFFFEFBDCD6CBC8C0A9D2C7ABC8C2B5E1DBD0FBF5F0FFFFFEFFFE
          FFFFFFFFFDFBFAECEDE9CEC1ABCBC1AFC9C3B6F2F0E6FFFFF8FAF4E7D0C6B4CA
          BDA7CFC9BCF1EFE4FFFFFBFFFFFCFAFAF4DDD9CEC6BCAACCBFA9CCC1A1CDC2A4
          CEC3A7CBC1A9C5BCA8CCC5B2EAE1D3FFFFF3FDFFFEFCFFFBFFFFF9FDFBF1D9D6
          C8C7C0AFCBC1AFCCC3AFCAC7B9DEDBCDF5F3E9FFFFF9FFFFFCFDFDFDFCFEFFFD
          FEFFFFFEFDFFFFFCFFFDF6E4DDD4CAC1B4CBBEAED4C6B4E2D3C0F0F5F4FDFFFF
          FFFEFFFFFCFEFFFEFEF5EDE6CFC6B8C8C1AEC4BEABEDE9DEFFFFFEF9F9FFF9F9
          FFFFFFFEEDE9DEC4BEABB7956AA483559F804BA68A54B09C6DD5C6A6FAF2E1FF
          FFF9FFFFFEFFFFFFFDFEFFFDFEFFFFFFFFFBF5EED5CABCAC9E8BA78D519F8850
          9B8758AA9A75D0C5AAF6EFE0FFFFF9FFFFFCFAFFFEFEFDF9FFFFFEFDFDFFF3F6
          FEFFFFF8E8D6AD714F0D8253028155026C4600AB9565FFF8E7FFFEFFFFF9FCFF
          FAF8CCBA8B877857FFFFF2FFFFFFFBFEFFF5F8FCFFFFFFFEFDF9FCFEFEFCFEFE
          FFFEFFFCF9FBFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FFFFF6FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFAFFFFFFFFFEFFFFFCFFFDFFF8FAFFFFFDFCFFFFEEAC956F7355047F5500
          935F01804A009E7334CCAE7FD4BB939C835B5F561DDED5B4FFFDFAFFFAFFFBFC
          FFFBFEFFFDFCFEFFFCFFFFFFFEFFFFFFFFFEFFFEFDFFFFFCFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFFFFFDFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FDFEFEFFFDFFFFFCFFFAFBFFFD
          FFF8F8FEFFFFFCFFF7EABC995081570C7F4B00875509794D067752087654007F
          5D00D1C8A6FFFFF1FFFEFEFFFCFFF8F7FFFAFBFFFFFEFFFFFDFFFFFFFEFDFDFD
          FFFFFFFFFEFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFAFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFFFBFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFAFFFFFDFEFCFFFFFCFFFFFEFEFDFFFCFBFFFCFCFFFFFEFFFFF8FFD9C4B5
          A58153906621865E1693753AB09C73FAECCFFFFCFFFFF9F6FFFFF9F8FAF4FDFF
          FFFDFEFFF7F6F8FFFFFEFFFFFFFFFDFDFEFEFEFBFDFDFAFCFDFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFF9FEFFF6FBFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
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
        Left = 678
        Top = 419
        Width = 171
        Height = 18
        Size.Values = (
          39.687500000000000000
          1494.895833333333000000
          923.836805555555700000
          377.031250000000000000)
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
        Left = 680
        Top = 450
        Width = 169
        Height = 17
        Size.Values = (
          37.482638888888900000
          1499.305555555556000000
          992.187500000000000000
          372.621527777777800000)
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
        Left = 680
        Top = 480
        Width = 169
        Height = 17
        Size.Values = (
          37.482638888888900000
          1499.305555555556000000
          1058.333333333333000000
          372.621527777777800000)
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
        Left = 680
        Top = 511
        Width = 169
        Height = 17
        Size.Values = (
          37.482638888888900000
          1499.305555555556000000
          1126.684027777778000000
          372.621527777777800000)
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
        Top = 367
        Width = 19
        Height = 19
        Size.Values = (
          41.892361111111110000
          1803.576388888889000000
          809.184027777777800000
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
        Left = 683
        Top = 12
        Width = 91
        Height = 23
        Size.Values = (
          50.711805555555560000
          1505.920138888889000000
          26.458333333333330000
          200.642361111111100000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
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
        Left = 682
        Top = 383
        Width = 116
        Height = 22
        Size.Values = (
          48.506944444444440000
          1503.715277777778000000
          844.461805555555600000
          255.763888888888900000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
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
      object rllEndereco1: TQRLabel
        Left = 57
        Top = 83
        Width = 603
        Height = 13
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          183.003472222222200000
          1329.531250000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Endere'#231'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = rllEndereco1Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object rllEndereco2: TQRLabel
        Left = 57
        Top = 454
        Width = 603
        Height = 13
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          1001.006944444444000000
          1329.531250000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Endere'#231'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = rllEndereco1Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object rllEndereco3: TQRLabel
        Left = 57
        Top = 851
        Width = 603
        Height = 13
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          1876.336805555556000000
          1329.531250000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Endere'#231'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = rllEndereco1Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
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
