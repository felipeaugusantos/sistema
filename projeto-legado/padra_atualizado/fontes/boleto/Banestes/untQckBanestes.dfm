object frmQckBanestes: TfrmQckBanestes
  Left = 100
  Top = 9
  Width = 988
  Height = 788
  AutoScroll = True
  Caption = 'frmQckBanestes'
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
        Caption = '021-0'
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
        Left = 58
        Top = 75
        Width = 602
        Height = 18
        Size.Values = (
          39.687500000000000000
          127.881944444444400000
          165.364583333333300000
          1327.326388888889000000)
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
        Width = 60
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          216.076388888888900000
          132.291666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nosso N'#250'mero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Caption = 'AT'#201' O VENCIMENTO PAG'#193'VEL EM QUALQUER BANCO'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Width = 144
        Height = 28
        Size.Values = (
          61.736111111111120000
          15.434027777777780000
          11.024305555555560000
          317.500000000000000000)
        XLColumn = 0
        AutoSize = True
        Picture.Data = {
          07544269746D6170864F0000424D864F00000000000036000000280000009000
          00002F0000000100180000000000504F00000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
          FFFFE0F0E8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F0F0E8F8F8F0F8F8F0F8F8
          E8F8F8F0F8F8F0F8F8F0F8F8E8F0F0E0F0E8E0E8E8F0F8F8F0F8F8F0F8F8E8F8
          F0F0F8F8F0F8F8E8F8F0F0F8F8D8E8E0F0F8F8E0F0E8E0F0E8F0F8F8F0F8F8F0
          F8F8F0F8F8E0F0E8F0F8F8E8F8F0E8F8F0F0F8F8E0F0E8E0E8E8F0F8F8E0F0E8
          F0F8F8F0F8F8E0F0E8E8F0F0F0F8F8D8E8E0E8F8F0F0F8F8F0F8F8F0F8F8E8F8
          F0F0F8F8F0F8F8F0F8F8F0F8F8E0F0E8F0F8F8F0F8F8F0F8F8A8B8B0100810A8
          B8B0F0F8F8F0F8F8E8F8F0E0E8E8F0F8F8E8F8F8E0F0E8F0F8F8F0F8F8F0F8F8
          E0F0E8F0F8F8E8F8F0E8F8F8F0F8F8908090100810C8D0D8F0F8F8F0F8F8E0E8
          E8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8F0F8F8F0F8F8D8E8E0E0F0E8F0
          F8F8F0F8F8F0F8F8E0F0E8F0F8F8E0F0E8F0F8F8F0F8F8E0E8E8E8F8F0E8F0F0
          E8F8F0E8F8F0E8F8F8F0F8F8F0F8F8E8F8F0F0F8F8F0F8F8E8F8F0F0F8F8F0F8
          F8E0E8E8F0F8F8F0F8F8F0F8F8E8F8F8F0F8F8F0F8F8F0F8F8E8F8F0F0F8F8F0
          F8F8F0F8F8E8F8F8F0F8F8D8E8E0F0F8F8F0F8F8F0F8F8F0F8F8E8F8F0F0F8F8
          F0F8F8D8E8E0F0F8F8D8E8E0FFFFFFFFFFFFF0F8F8E0F0E8788880788880C8B8
          C0F0F8F8E0F0E8F0F8F8E0F0E8F0F8F8C8D0D8908090908090908090A8B8B0F0
          F8F8F0F8F8D8E8E0908090A8B8B0A8B8B0C8D0D8C8D0D8A8B8B0D8E8E0E8F8F0
          9898A0E0E8E8F0F8F89898A0606868A8B8B0E8F8F8F0F8F8D8E8E07888807888
          80C8D0D8F0F8F8F0F8F8E8F8F0F0F8F8F0F8F8A8B8B09898A0A8B8B0E0F0E8F0
          F8F8D8E8E09898A0A8B8B0C8D0D8F0F8F8A8B8B0A8B8B0E8F8F0C8B8C0908090
          F0F8F8C8B8C0A8B8B0A8B8B0100810606868908090C8B8C0F0F8F8C8D0D8A8B8
          B0E8F8F8F0F8F8E8F8F0A8B8B0A8B8B0A8B8B0E8F8F8F0F8F8F0F8F8F0F8F878
          8880100810788880788880C8D0D8F0F8F8F0F8F8A8B8B0788880A8B8B0E8F8F0
          F0F8F89898A0C8D0D8F0F8F8F0F8F8A8B8B0788880C8D0D8F0F8F8A8B8B07888
          80A8B8B0F0F8F8E8F8F0E8F8F0F0F8F8F0F8F8A8B8B09898A0A8B8B0908090D8
          E8E0E8F8F0D8E8E0788880908090F0F8F8F0F8F8F0F8F8E8F8F0F0F8F8E8F8F0
          C8D0D8A8B8B0E8F8F0F0F8F8F0F8F8908090788880A8B8B0E8F8F0F0F8F8D8E8
          E0788880606868D8E8E0E8F8F0E0F0E8C8D0D8908090A8B8B0F0F8F8FFFFFFFF
          FFFFC8D0D8303038000000282028100810908090F0F8F0E0E8E8F0F8F8F0F8F8
          606868100810282028282028100810384040C8D0D82820281008107888802820
          28504858788880000000A8B8B0C8D0D80000009898A0B0A08800000030303810
          0810788880C8D0D8384040303038384040303038C8D0D8F0F8F0F0F8F8F0F8F0
          788880282028605848303038606868E0F0E8303038303038303038605848E0E8
          E8384040384040FFFFFF606868605848E0F0E8605848384040A8B8B010081038
          4040282028303038C8D0D8788880000000D8E8E0E8F0F0605848100810384040
          384040A8B8B0F0F8F0FFFFFFFFFFFF788880000000605848303038282028E0E8
          E8606868303038384040282028908090C8D0D8100810788880FFFFFFA8B8B000
          0000000000A8B8B0908090100810605848282028788880FFFFFFE8F0F0FFFFFF
          C8D0D8282028282028384040000000908090A8B8B02820283840403030386058
          48E0E8E8F0F8F8F0F8F8E8F0F0FFFFFF605848100810D8E8E0FFFFFF78888028
          20283840402820289898A0D8E8E0303038282028282028303038FFFFFF788880
          100810303038100810606868FFFFFFFFFFFF605848000000A8B8B0F0E8E02820
          28303038FFFFFFFFFFFFFFFFFFF8F0F0384040282028F0E8E0F8F0F850485810
          0810788880282028605848E0E8E8303038605848A8B8B0100810C8D0D8C8D0D8
          1008109898A0384040384040E0E8E8788880788880B0A088100810A8B8B0E0E8
          E8100810788880F8F0F0FFFFFFF8F0F8C8D0D8B0A088C8D0D860584828202860
          5848282028C8D0D8C8D0D8806060A8B8B0605848384040FFFFFF605848384040
          FFFFFF605848303038A8B8B0282028788880F0E8E01008107888809080902820
          28FFFFFFA8B8B0000000A8B8B0C8D0D8788880A8B8B0FFFFFFFFFFFFFFFFFF90
          8090100810C8D0D8A8B8B0100810908090282028606868F8F0F8908090908090
          E0E8E8282028A8B8B0F8F0F0908090100810A8B8B0FFFFFF384040282028FFFF
          FF605848100810FFFFFFFFFFFFF8F0F0A8B8B01008109898A0F0E8E028202890
          8090606868100810E0E8E8C8D0D8605848F0E8E0FFFFFFFFFFFFF0F0E8F8F0F8
          282028000000A8B8B0FFFFFF100810384040FFFFFF3840403840407888800000
          00A8B8B0C8D0D8605848788880282028605848F8F0F8A8B8B0788880FFFFFFFF
          FFFF282028303038FFFFFFFFFFFF788880100810C8B8C0FFFFFFFFFFFFFFFFFF
          806060100810C0A8A8A8B8B0384040303038F0E8E0A8B8B06058486058482820
          28806060908090100810E0E8E8A8B8B0282028908090100810806060FFFFFFFF
          FFFFF0F0E8C0A8A8100810A8B8B0FFFFFF100810605848FFFFFFFFFFFFF0F0E8
          C0A8A8282028100810303038788880606868000000605848384040384040C0A8
          A8605848384040F8F0F8606868384040FFFFFF605848605848A8B8B0100810C8
          B8C0FFFFFF282028788880908090100810FFFFFF908090100810303038806060
          303038908090FFFFFFFFFFFFF8F0F8908090100810F0F0E8C8D0D82820286058
          48282028303038384040384040606868F0F0E80000009898A0FFFFFF9898A010
          0810F0F0E8F8F0F8282028788880F8F0F0788880100810F0F0E8FFFFFFF8F0F8
          C0A8A8000000C0A8A8F8F0F8100810A8B8B05048581008106058483030386058
          48C8D0D8F0F0E8FFFFFFFFFFFF908090282028606868605848E0E8E810081090
          8090F8F0F8605848282028806060100810C8D0D8F8F0F8FFFFFFF8F0F0282028
          282028605848605848282028FFFFFFFFFFFF282028384040FFFFFFF8F0F89080
          90100810A8B8B0FFFFFFFFFFFFFFFFFF78888010081028202810081028202890
          8090FFFFFF788880788880C8D0D8282028788880908090000000788880788880
          282028908090605848282028F8F0F0806060606868C0A8A81008109898A0C8B8
          C0000000908090FFFFFFFFFFFFFFFFFF788880282028C8D0D8908090C8B8C090
          8090100810A8B8B09898A0282028A8B8B0384040282028C8B8C0303038282028
          C8D0D8384040605848C0A8A8100810788880C8B8C0100810C0A8A87888800000
          00605848A8B8B00000009898A09898A0282028908090FFFFFFF8F0F0FFFFFF78
          88801008109080909898A0100810A8B8B0303038384040C8D0D8303038504858
          E0E8E8282028282028788880605848282028788880C8D0D8605848303038F8F0
          F0384040303038F8F0F8FFFFFFF8F0F8C8B8C0100810788880C8D0D810081098
          98A0788880100810C8D0D8908090100810C8D0D8FFFFFFF8F0F8F8F0F0504858
          384040C8D0D8384040E0E8E8303038504858E0E8E8384040504858A8B8B00000
          00908090C8B8C0303038C8B8C0303038384040E0E8E8504858282028FFFFFFFF
          FFFF303038100810E0E8E8FFFFFF605848282028E0E8E8F8F0F0FFFFFFF8F0F8
          504858303038E0E8E8F0F0F8504858282028F0F0F89080903030383840403030
          38A8B8B09898A0303038504858100810384040E0E8E8C8B8C028202828202828
          2028A8B8B0FFFFFF788880282028282028504858F0F0F8F0F0F8F0F0F8FFFFFF
          A8B8B0384040384040303038A8B8B0F8F0F8504858384040384040606868F0F0
          F8788880303038384040282028605848303038000000908090A8B8B028202860
          5848384040605848F0F0F89898A02820282820287888809898A0282028504858
          504858C8D0D8FFFFFFF8F0F8E0E8F0908090282028504858384040605848F8F0
          F8C8B8C0384040282028504858A8B8B0E0E8F030303830303830303828202810
          0810100810C8D0D8C8B8C0303038282028282028A8B8B0FFFFFFF8F0F8F0F0F8
          F0F0F8605848282028504858000000A8B8B0E0E8E83840403030383030387888
          80FFFFFFFFFFFFF0F0F8E0E8F0100810908090FFFFFF384040A8B8B0C8D0D828
          2028282028303038A8B8B0FFFFFF606868282028384040606868F0F0F8A8B8B0
          384040303038282028C8B8C0FFFFFFFFFFFF9080902820283840406068680000
          00504858F0F8F8F0F8F8E0E8F0F0F8F860686810081078888078888028202828
          2028E0E8F0F0F8F8E0E8E8C8D0D8E0E8E8F0F8F8E8F0F8E0E8E8F0F8F8E0E8E8
          F0F8F8F0F8F8F0F8F8E8F0F8C8B8C0F0F8F8F0F8F8F0F8F8F0F8F8E0E8E8C8D0
          D8E0E8F0F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E0E8E8D8E8E0F0F8F8E8
          F0F0F0F8F8C8B8C0C8D0D8F0F8F8F0F8F8E0E8F0E0E8F0E0E8F0C8B8C0F0F8F8
          E0E8E8D8E8E0F0F8F8F0F8F8E8F0F8F0F8F8D8E8E0E0E8F0F0F8F8D8E8E0F0F8
          F8F0F8F8E8F0F8F0F8F8C8D0D8D8E8E0E0E8F0F0F8F8F0F8F8F0F8F8F0F8F8F0
          F8F8D8E8E0E0E8F0C8D0D8E8F0F8F0F8F8F0F8F8C8D0D8C8D0D8E0E8F0F0F8F8
          F0F8F8E0E8F0F0F8F8E0E8E89898A0100810A8B8B0E8F0F0F0F8F8E8F0F8C8D0
          D8C8D0D8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8C8D0D8C8B8C010081090
          8090F0F8F8E8F0F8C8D0D8D8E8E0F0F8F8F0F8F8E0E8F0F0F8F8E8F0F8E0E8F0
          E8F0F8F0F8F8F0F8F8E0E8F0F0F8F8E0E8E8C8D0D8C8D0D8F0F8F8F0F8F8F0F8
          F8A8B8B0C8B8C0F0F8F8E8F0F8F0F8F8C8D0D8A8B8B0C8D0D8E8F0F8FFFFFFFF
          FFFFFFFFFF788880282028303038788880E0E8E8FFFFFFE0E8E8F0F8F8F0F8F8
          788880282028605848605848504858C8B8C0FFFFFFF0F8F8FFFFFFF0F8F8F0F8
          F8F0F8F8FFFFFFF0F8F8E0E8F0F0F8F8FFFFFFE8F8F8FFFFFFF0F8F8E0E8E8F0
          F8F8FFFFFFE0E8E8FFFFFFF0F8F8E0E8F0F0F8F8F0F8F8F0F8F8FFFFFFE8F0F0
          F0F0F8F0F8F8E0E8F0F0F8F8FFFFFFF0F8F8F0F8F8F0F8F8FFFFFFE0F0E8F0F8
          F8F0F8F8FFFFFFF0F8F8FFFFFFE0E8E8FFFFFFF0F8F8D8E8E0E0F0E8FFFFFFE0
          E8E8FFFFFFF0F8F8FFFFFFF0F8F8FFFFFFE8F8F8FFFFFFF0F8F8FFFFFFF0F8F8
          FFFFFFE8F0F0E8F0F0F0F8F8E8F0F8F0F8F8FFFFFFF0F8F8FFFFFFF0F8F8E8F0
          F0E0E8E8FFFFFFF0F8F8F0F8F8F0F8F8E8F0F8F0F8F8FFFFFFF0F8F8E8F0F078
          8880E8F0F0F0F8F8E0E8F0F0F8F8FFFFFFF0F8F8F0F8F8E0E8E8E0E8F0F0F8F8
          E0E8E8F0F8F8FFFFFFE0E8E8605848A8B8B0E8F0F0F0F8F8FFFFFFF0F8F8F0F8
          F8E0E8E8FFFFFFF0F8F8FFFFFFF0F8F8F0F8F8F0F8F8E8F0F8E0E8E8FFFFFFF0
          F8F8FFFFFFF0F8F8FFFFFFE0E8E8F0F8F8F0F8F8FFFFFFF0F8F8FFFFFFE0F0E8
          6068683840409898A0E0E8E8FFFFFFFFFFFFF0F0E8FFFFFFFFFFFFF0E8E0FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0FFFFFFFFFFFFF8F8F0F0F0E8FF
          FFFFFFFFFFF0E8E0F8F8F0FFFFFFF0F0E8F8F0E8FFFFFFF8F8F0FFFFFFFFFFFF
          F8F8F0FFFFFFFFFFFFF8F8F0FFFFFFFFFFFFF0F0E8F8F8F0FFFFFFFFFFFFFFFF
          FFFFFFFFF8F8F0F8F8F0FFFFFFF8F8F0FFFFFFFFFFFFFFFFFFFFFFFFF8F0F0FF
          FFFFF8F0F0FFFFFFF0F0E8F8F0E8FFFFFFFFFFFFF0E8E0FFFFFFFFFFFFF8F8F0
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F0F8F0E8F8F8F0FFFF
          FFF8F0E8FFFFFFF0F0E8F8F0F0F8F0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8
          F8F0FFFFFFF0E8E0FFFFFFF0F0E8FFFFFFFFFFFFFFFFFFF0E8E0F8F0F0FFFFFF
          FFFFFFF0F0E8F8F8F0F8F8F0F0E8E0FFFFFFF0E8E0FFFFFFF8F8F0F8F8F0F0F0
          E8FFFFFFF8F8F0FFFFFFFFFFFFF8F8F0F8F0F0FFFFFFF0E8E0F0F0E8F8F8F0FF
          FFFFFFFFFFF8F8F0F8F8F0F8F0E8F0F0E8FFFFFFFFFFFFF8F8F0F8F8F0FFFFFF
          F8F8F0F8F8F0FFFFFFFFFFFFF0F0E8FFFFFFF8F0F0F0E8E0FFFFFFFFFFFFF8F8
          F0F0E8E0FFFFFFF8F8F0F0F0E8FFFFFFF8F0F0A8B8B0F8E0D8FFFFFFFFFFFFFF
          FFFFF8F8F0F8F8F0F8F8F0F8E8D8F8F8F0F8F8E8F8F8F0F8F0E0F8F8F0F8F8F0
          F8F8F0F8F8F0F8E8E0F8F0E0F8F8F0F8F8F0F8E8D8F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8F0F8F8F0F8F8E8F8F8E8F8F0E0F8F8F0F8F8F0F8E8E0F8F8F0F8F8F0F8
          E8D8F8F8F0F8F8F0F8E8E0F8F0E0F8F8F0F8E8E0F8F0E8F8F8F0F8F8F0F8F8F0
          F8F8F0F8E0D8F8F8F0F8F8F0F8F0E8F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F0
          E8F8F8E8F8F8F0F8F8F0F8E8E0F8F8F0F8F8F0F8F8F0F8F8F0F8F0E0F8F0E8F8
          F8F0F8F0E0F8F8F0F8F8F0F8F8E8F8F8F0F8F0E0F8F8E8F8F8F0F8F8F0F8F8F0
          F8F8E8F8F8E8F8F8E8F8F0E0F8F8F0F8F8F0F8F8E8F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8F0F8F8F0F8F8F0F8F8F0F8F0E0F8
          F8E8F8F8F0F8E8D8F8E8D8F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8
          F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8E8F8E0D8F8F8E8F8F8F0F8E0D0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8
          F8E8F8F8F0F8F8F0F8F0E0F8F0E8F8F8F0F8F8F0F8F0E8F8F8F0F8F8F0F8F8E8
          F8F8F0F8F8F0F8F8F0F8F0E8FFFFFFFFFFFFB08070A87860B88878B88870B888
          70B08070C09078B07868A07060A87860B07868B08068B08070C08878B88870A0
          7058B88870B88878A87860A07058A87868C09078B88870B08068C09078A07058
          B08070B08068A87868B08070A87860C09078A07058C09078B08070A87868B080
          68B08068B88870A07060905848B08068C09078B88878C09078A87860B08070B8
          8870B08068A07058B08068B08068B07868B88878C08878885840C09078B08070
          A87868B88870B08068B08068C08878A07058B08070B88870A87868A07058B888
          70B88870A07060B07868A87868A87860B88870B08068B08068B08070B08068B8
          8870B08070B08070B08068B88870B08068B88870A87868A87860B08070905848
          B88878B88870A07058A07058B88878A87868B88878B07868B88870B080689058
          48B08070C09078A87868905848C09078C09078A07058B88878A07058A07060B8
          8878B08070B88870A07058A07060B88878B07868B07868C09078C09078A07060
          B88878A87860B08070B08068C08878B88870A07058C09078B88870A07058B888
          78B88870A87860A87868B07868B08070B07868B07868A87860C09078FFFFFFFF
          FFFF682008702810682810682810682008682808602008682810702810703018
          6820086018006828106020085818007030187838185818006020008038205818
          0058180060280868301060200080381860180070200878301860200060200860
          2808783820581800601800783820702810601800682810702810782810782810
          6018007020086018006828107838205818007028107028107030186020087030
          1058180068280878382068281058180078382060200858180070301860200870
          3010703010581800703010703010581800783818703018602008703018602000
          7838186020006020087838185818006828087030185818007030106820086820
          0860200078382068281060200870301868281058180078382068280868280868
          2808682008702810703010682008682810703018682008682810703018581800
          6020086828086020086828107838205818006020087030106020007030186828
          0860200080382058180060200070301860200870301058180068280868280860
          2008703018581800682818682008703018602008703018682810682008702810
          682008703018682810702810FFFFFFFFFFFF7820109038208838187028087830
          1080381878381078301080301880301880301878301878301870381070381070
          3810803808803808783808703008682808602808682808703008803810883810
          9030109030108830108038107838107038107038107838108830108830108030
          1078381078381880301890281090281090281090301080301870301078301070
          3010783018783018783018783810783810783810783810783810783818783018
          7830187830187830187830107838107838108038108038108038108038107838
          1078381078381078381078380878380878300878380878381080381080381080
          3810803018803018803010803010803810783810783810703810703010683010
          6830107030107830107830108030088030088838108038108030108030188030
          1880301878301878301878381078381078381078381078381078381078381878
          3810803810803810803810803810803810803810803810803810783810783810
          7838107838107838107838107838107838108038206820107830188038208038
          20803818702808883818803010803010803010803010883010883010FFFFFFFF
          FFFF883018903018883010783008803810803810783008783010783010783010
          7830187830187030106830106828087030088038088838107838087030086028
          0860280868280870300880301088301090301090301088301080301070301068
          3010683010703010883010882810803010783010703010783010902810902810
          9030189030188030187830187830187830187830187828187830107830107830
          1078301078301078301078301078301878301878301878301078301078300878
          3008803008803008803008803008803008783008783008783008803010803010
          8038108038108038108038108038108038108030188030188030188830108030
          1080381078381078381070301070301870301870301078381080381088381088
          3810803010803010803010803018803018803018803018783018783010703010
          7030087030087030107030107830107830108030108030108030108030108030
          1080301080301078301080301078301078301078301078301078301078301078
          3010703018682810783020783018783010803010782808883818883010883010
          883010883010883010883010FFFFFFFFFFFF8830188830188030108030088038
          1078381070300880381870280870281070281068281068281060280858301060
          2808782810802810782810702810682810682810682810702010782818782018
          7820187820187820187020186820186828186028106828087820088028087028
          1068281068281070281080201090281088281080201068281068281068281070
          2010702010782010702810702810702810702810702810702810702810702010
          7020107020107028107028107028087028087028107820107820107820107820
          1078201078201070201078201078201078201078201078201078201878201878
          2018702818702818782810782810782808782808702808702808682008682810
          6828106828107028107028087828087828087028087028087028107020107020
          1870201870201070201070281070280870280870280870280870281078281078
          2010782018782018782018782018782018782018782018702018782018702018
          7020187020187020187020187020187020187030186028107030186020086020
          00783010702808803010803010803010803010803010803010803010FFFFFFFF
          FFFF903018883018802808803010803810783008783010905848C08870C08878
          C08878C08878C08870C09078B88870C09078C08878C08080C08080C08080C080
          80C08878C08080C08080C08878C08878C08080C08080C08080C08080C08080B0
          8070B88878B88870C08870C08878B88878B88878B88878B88878C08870C08870
          C08870C08870B88870B88870B88870C08878C08078C08878C08870C08870B888
          70C09078C09078C09078C08878C08878C08878C08878C08878C08878B88870B8
          8878C08878C08878C08080C08878C08878C08878C08878C08878C08078C08078
          C08078C08078C08078C08078C08080C08078B88878B88878B88878C08870C088
          70C08870C08870C08870B88870B88870B88870B88870B88870B88870C08870B8
          8870B88870B88878B88878B88878C08878C08878C08878C08878C08878B88878
          C08870C08870C08878C08878C08878C08878C08878C08878C08878C08080C080
          80C08080C08080C08080C08080C08080C08080C08080C08080C08080C08080C0
          8878C09078C08878C09078C08870C08870C09078905848783010783010803010
          803010803010803010803010FFFFFFFFFFFF8830188830188830108838108038
          10702808803810A05048F8F8E0F8F8E8F8F8F0F8F8F0F8F8E8F8F8E8F8F8E0F8
          F8E8F8F8F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8
          E8F0F8E8E8F8F0F8F8E8F8F8F0F8F8E8F8F8F0F8F8E8F0F8E8F0F8E8F8F8E8F8
          F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8F0F8F8F0
          F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8F0F8F8F0FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8
          F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8
          F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8F0F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8
          F8F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F0FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F0F8F8E8F8F8E0F8F8E8F8F8E0F8F8
          E0F8F0D8A87860602000783010783010783010783010783010783010FFFFFFFF
          FFFF883010883018883010883810803810702808783818A05048F8F8E0F8F8E8
          F8F8E8F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8F0F8F0F0F8F0F0F8F0
          F0F8F0F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8
          F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8E8F8F0E8F8F0F0F8E8F8F8E8F8F8E8
          F8F8E8F8F8E8F0F8E8F0F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8
          E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8
          F8E8F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0
          F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8
          E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8
          F8E8F0F8E8F0F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8
          F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8
          F8F0F8F8F0F8F0E0F8F8E0F8F8E0F8F8E0F8F0D8C08870783810783810783010
          783810783010783010783010FFFFFFFFFFFF8830109038188830108830108838
          1078300878381068483090584890584890584890584890584890584890584890
          5848905848905848905848A05048A05048A05048A05048A05048905848885840
          885840885840905848A05048A05048A05048A05048A05048A05048A050489058
          48905848905848905848A05048A05048A05048885840885840905848A05048A0
          5048A05048A05048A05048905848905848905848905848905848A05048A05048
          A05048A05048A050489058489058489058489058489058489058489058489058
          4890584890584890584890584890584890584890584890584888584088584088
          5840905848905848905848905848905848A05048A05048A05048A05048A05048
          A05048A05048905848905848905848905848905848905848905848A05048A050
          48A05048A05048A05048905848905848905848905848905848A05048A05048A0
          5048A05048905848905848905848905848905848905848905848905848905848
          9058489058489058489058489058489058489058489058489058488858408858
          40905848783818682808783010783010803010803010803010783010FFFFFFFF
          FFFF883010883818883010883008883810803810703010703018582010582010
          5820102820285820105820105820105820105830105830106820107820108828
          1088280888280880280868200860200060200068280878280880280888280888
          2808902810882018882018782018582010582010582010602008802818882018
          7820186820106028106828108820188820189028108828108020107020186820
          1868201868201868201078201880201080201078201070201068201058201058
          2010602008602008602008602008682008682008682008682008702810702810
          6828106828106828106828106028106028106020086020186820186820187020
          1878201878201888201888201888201888201880201078201068201860201860
          2018682018702018782018882018882018882018882018882018702018682018
          6020186020186020186820187020187020106820086820086820086820086820
          0868201068281068281068200860200860200860200860200860200860200858
          2010582010582818603018603018583010683010703010883820783010803010
          803010803010803010803010FFFFFFFFFFFF8830188830108838108838108830
          08783008783818684830A07060806060A07060A07060A07060A07060A07060A0
          7060A87860885840885840783820702810803010883818883820A07058A87860
          A07058703818783810883810882808903010903018903018702010A07058A070
          58A07058A87860905848883018782010B08068A87860A0705878382078201090
          3018903818903820702810682818905848A07060A07058A07058883820682008
          783018A87860A87860A07058A07060A07060A07058A87860A07058A07058A070
          58A07058A07058A07058603018684830583010783820603018B88878B0A088E8
          C098E8C098E09888B88878684830682818582010803018802818883018883018
          903820601800803820A87860A07058A07060B080708838207020189038209030
          18802808903818783018A07058A07058A07060A07060A07060A07058A07058A8
          7860A07058A87860885840A87860A07058603018783820583010583010905848
          B88878B0A088E8C098E8C098B0A088B080686848306030185818006030187838
          20682810702810803018803010883010883010883010883010883010FFFFFFFF
          FFFF803018803010883810903810883008803008783818783820F8F8E8F8F0E8
          FFFFFFF8F0E8F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E0F8F8E0F8E8D8E098
          88703818581800905848F8F8E0F8F8E0F8F8E0E8C09870381860200090381888
          3010802818782818783820E8C098F8F0D8F8F8E8F8F8E8F8E8D8783018803018
          F8D8D0F8F8E0F8F8E0B0A088803820802808782808783810602808885840F8D8
          D0F8F8F0F8F8E8F8F8E8684830602808803820E8C098F8F0D8F8F8E8F8F8F0F8
          F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8A87868301000
          603018B0A088F8E0D0F8F8E8F8F8E8F8F8E0F8F8E0F8F8E0F8F0D8F8E0D0D0B0
          90905848582818682818682008803010783008783810885840E8C098F8F0D8F8
          F8F0F8E8E0E09888702818782810802808883008903818703010F8D8D0F8F8F0
          F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E0F8F8E8F8F8E8F8F8E8F8F8
          E0B08068301000603018B88878F8E0D0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8
          F8E8F8D8D0D0B090A07058603018582010783820883820803010883010883010
          883010883010883010883010FFFFFFFFFFFF8038188030108830109038109038
          10803010783010683018F8E0D0F8F8F0FFFFFFF8E8E0F8F0F0F8F8F0F8E8E0F8
          F8E8F8F8E8F8F8F0F8F0E0F8F8E8F8F8F0F8D8D0A07058581800B88878F8F0E0
          F8F8E8F8F0E0A07058581800803820782818803018682010783820F8D8D0F8F8
          E8F8F8E8F8F0D8E8C098883820702810D0B090F8F8E0F8F8E0E8C09880382080
          3010783008783818581800905848F8F8F0F8F8F0F8F8F0F8F8E8A07058603010
          703818E8C098F8F8E0F8F8E8F8F8F0FFFFFFF8F8F0F8F8F0FFFFFFFFFFFFF8F8
          F0F8F8F0FFFFFFF8F8F0B88878582010D0B090F8F8F0FFFFFFF8F0E8FFFFFFF8
          F8F0F8F8E0F8F8E0F8F8E8F8F8F0F8F0E8F8E0D8B08070783820683010803818
          682808783810581800B0A088F8F8E8F8F8F0F8F8F0F8D8D07838207830088838
          10903810883810602000D0B090F8F8F0F8F8F0F8F0E0F8F8F0F8F8E8F8F8E0F8
          F8E0F8F8E8F8F0E8F8F8F0F8E8E0F8F8F0B88878301000B0A088F8F8F0F8F8F0
          F8F8F0F8F8F0F8F0E8F8E8E0F8F0E8F8F8F0F8F8F0F8F0E8F8D8D0B888787838
          20682810803820883018883010903010903010903010903010883010FFFFFFFF
          FFFF803818803010803008883010903810883810783010603010D0B090F8F8F0
          F8F8F0FFFFFFF8F8F0F8F0E8F8E8E0F8F8E8F8F8F0F8F8F0F8F8F0F8F8F0F8E8
          E0F8F8F0F8E0D8684830684830F8D8D0F8F8F0F8F8F0E0B0B068483058201058
          2010602018581800603018E0B0B0F8F8E8F8F8E8F8F8E8E8C098782818601800
          B08068F8F8E0F8F8E0F8F0D8783820803010783008703810583010B0A088F8F8
          F0F8F8F0F8F0E0F8F8E8B0A088602808581800A87860F8F8E0F8F8F0F0F0E8F8
          F0F0FFFFFFF8E8E8FFFFFFFFFFFFF8F0F0FFFFFFFFFFFFF8F0F8E0B0B0A07060
          F8F0F0FFFFFFFFFFFFFFFFFFFFFFFFF8E8D8F8E0D0F8E0D0F8F0D8F8F8F0F8F8
          F0FFFFFFF8E8E0B08068683010703810682808783810581800A87860F8F8E8F8
          F8F0F8F0E8F8E8E0684830783810883810883810783808602000A87860F8F8F0
          FFFFFFE0F0E8F8F8F0F8F8E8F8F8E0F8F8E8F8F8F0F8F0F0FFFFFFF8F8F0FFFF
          FFE0B0B0905848FFFFFFF8F0E8F8F0F0F8F0F0F8F8F0F8F0F0F8E0D8F8E0D8FF
          FFFFF8E8E0F8F8F0F8F8F0F8F0E0C09078602810702008883820883010883010
          903010903010903010883010FFFFFFFFFFFF8038188030108830108830109038
          10883810783010602808B88870F8F8F0F8F0E0F8F8E8E0D0C068483078382078
          3820603018684830D0B090FFFFFFFFFFFFF8F0F0F8F0F0C0A8A8582010C08080
          F8F0F0F8F0F0FFFFFFD0B090B0A088E0B0B0E0B0B0D0B090E0B0B0F8F8E8F0F8
          F0F0F8E8F8F8E8E09888782018702010905848F8F8E8F8F8E8F8F8E088584078
          2810783810602000684830F8F8E8FFFFFFFFFFFFFFFFFFF8F8F0F8C0B8583010
          581800684830F8F8E8F8F8F0FFFFFFFFFFFFC0A8A8A87868B88878B88878C080
          80C08878C08080C08080A87868A87868F8E8E8F8F0F0FFFFFFFFFFFFB8887888
          5840603018603010905848B0A088F8E8E8FFFFFFF8F8F0F8F8E0783820602000
          783808783810602808905848F8F8F0FFFFFFF8F8F0F8F8F0A070587030087830
          08803008803808703810885840F8F0E0FFFFFFF8F0F0F8F8F0C0A8A8B88870B8
          8878B88878C08080C09078B88878B08070A07060A87868F8E8E8F8F0F0F8F8F0
          F8F0E8C09078684830582818603018684830B0A088F8F8F0F8F8E8F8F8F0F8E0
          D0885840682810803018803010883010883010883010883010883010FFFFFFFF
          FFFF783018803010883010883008903010903810783010602808885840F8F8E8
          F8F8E8F8F8F0F8F0E8885840683018783820803820783820603018D0B090F8F8
          F0F8F8F0F8F0E8F8F8F0684830684830F8D8D0FFFFFFFFFFFFF0E8E0FFFFFFF8
          F8F0FFFFFFF8F8F0FFFFFFFFFFFFE8F8F0F0F8E8F8F8F0C09078802818802818
          603018F8E0D0E0F0E8F8F8E8A87868782810883820602000A07060F8F8F0F8F0
          F0FFFFFFF8F0F8F8F0E8F8F0D8885840683010603018F8E8D8F8F0F0F0F8F8F0
          F0F8C08080582010582010682818582010682818682018702818702818A07058
          E0B0B0F8D8D0F8D8D0F8C0B8684830602008602808783820582010603018F8E8
          E8FFFFFFF8E0D8F8F8F0A87860682808803810703008682808783820F8C0B8F8
          F0F0FFFFFFFFFFFFB88878682808803808903810803808703008684830E0D0C0
          FFFFFFFFFFFFF8E8E8C080805818005818006020086020085820105820105818
          00682818A87860E8C098F8C0B8F8F8E8F8C0B890584858180068281878382060
          3018384040F8F8F0F8F0E0F8F8E8F8F8E8A87860703018783018803010803010
          883010883010803010803010FFFFFFFFFFFF7830108038188838108830089030
          10903810803810683010603018F8E0D0F8F8E8F8F8F0F8F8E8A0706058180070
          2010702008802818581800B88878F8F8E8F8F8E8F8F8E8F8F0E0783820582010
          A87868F8F8F0F8F8F0F8F8F0F0F8F0E0F0E8F8F0F8F8F0F0FFFFFFF0F8F8E8F8
          F0F0F8F0FFFFFFB88870782018802818603018A8B8B0F0F8F0F8F8F0D0B09070
          2010803010783018E8C098FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0E8A07058
          683018602008E0B0B0FFFFFFFFFFFFFFFFFFF8C0B87038186828087838187028
          10803018782808883818802810702008702008803820905848A0705870381878
          3820602000783820582010684830F8E0D8FFFFFFF8F0F0F8F8F0E09888682808
          783808803810703010783820C0A8A8FFFFFFF8F0F8FFFFFFE8C0987038188838
          10903810803808702808582818B0A088FFFFFFF8F0F8F8F0F8E0B0B070281870
          2010803018884018883820803818702808682008702808703008703008905848
          903820682808682808783818703010581800605848E0E8E8F8F8F0F8F8F0F8F8
          E8C09078683010783018783010803010803010803010803010803010FFFFFFFF
          FFFF703010803818883818883010883008883810803818703018583010E0B0B0
          F8F8F0F8F0E0F8F8F0D0B090582010703020803018702818683018D0B090F8F8
          E8F8F8E8F8F8E8F8E8D8684830683018582010F8D8D0F8F8E8F8F8F0F8F8E0C8
          B8C0E0B0B0E0B0B0E0E8E8F0F8F0E8F8F8FFFFFFFFFFFFA87868782018802818
          582818B88878F8F8F0F8F8E8F8E0D8783820682010905848F8F8F0F8E8E8FFFF
          FFFFFFFFFFFFFFFFFFFFF8F8F0B88878703018581800C09078FFFFFFE8F0F8FF
          FFFFF8E0D8703818581800683010602808682808601800783010883818802808
          803010883010702808682808682808602808684830684830B88878F8F0F0F8F0
          F0FFFFFFFFFFFFF8F8F0D0B090683010702808883820682810703020B88878F8
          F0F8FFFFFFFFFFFFF8F0E0783820783008803008883008803818682818C09078
          FFFFFFF8F0F8FFFFFFF8E0D87838206820186020086020006020006020007838
          10884018702808803810803818783008682808703008703810703818905848C0
          9078F8E0D0E0F0E8F8F8F0F8F8E8F8F8F0D0B090602008703010783010803010
          803010803010803010803010FFFFFFFFFFFF7830107830108030108030108830
          10803010803010783018682818B88878F8F8F0F8F8F0F8F8F0F8E8E0E0D0C0E0
          B0B0E0B0B0E8C098F8D8D0F8F0E0F8F8F0F8F8F0F8F8F0B0A088703018782818
          782010A07058F8F8F0F8F0E8FFFFFF788880301000682818B88878F8F0E8F8F8
          F0F8F8F0F8F8F0905848682810783018602008A07058F8F8E8F8F8F0F8F0F080
          6060602018B08070F8F8F0F8F0E8FFFFFFE8F8F0E0E8E8F8F8F0F8F8E8F8C0B8
          682818782018A05048FFFFFFF8F8F0FFFFFFF8F8F0D0B090B0A088B88878B888
          70B88878B88878C09078803820702810883018782010702010883820905848D0
          B090F8E8D8FFFFFFF0F8F0FFFFFFFFFFFFFFFFFFF8E8E0F8F8F0E09888602810
          783820783018682810783820905848F8F8F0FFFFFFFFFFFFF8F0E0A070587028
          10903818903010803008703008905848F8F8E8F8F8F0F8F8F0F8E8E8C0A8A8B0
          A088B88878B0A088C09078B88878C09078803820602000883820783818682810
          783820A07058E8C098F8C0B8F8F8F0FFFFFFF0E8E0FFFFFFF8F8F0F8F8E8F8F8
          F0C09078683010803820803010803010883010883010883010803010FFFFFFFF
          FFFF783010803010803010803010803010803010803018803018702818A07058
          F8F8E8F8F8F0FFFFFFFFFFFFFFFFFFF8F0F8F8F0E8F8F8F0F8F8F0FFFFFFF0F0
          E8F0E8E0B0A088603018682010983818802010883018E0B0B0F8F8F0FFFFFFE0
          D0C0783820581800C09078F8F8F0F8F8E8F8F8E8F8F8E0905848683010783010
          782810905848F8E8D8F8F8F0FFFFFF788880582010F8C0B8FFFFFFFFFFFFE8F8
          F0C8D0D8B0A088F8F8F0F8F8E8F8E0D0783820802818903820F8E8E0F8F8E8F0
          F8F8FFFFFFF8E8E8FFFFFFF8F8F0F8F8F0F8F8E8F8F8E8F8F8E0885840803820
          983818682010905848F8C0B8F8F8F0FFFFFFFFFFFFE0E8E8FFFFFFFFFFFFF8F8
          F0F8F8F0F8F8F0F8E8D8905848602008783020702818702818682818783820F8
          E8D8FFFFFFFFFFFFF8F8E8B88878601800782008802808883810803810803820
          F8E8D8F8F8E8F8F8F0FFFFFFFFFFFFF8F0F8F8F8F0F8F8F0F8F8E8F8F8E8F8F0
          D8A87860581800683018602008885840F8D8D0F8F8E8FFFFFFFFFFFFF8F0F0F8
          F0F0FFFFFFF8F8F0F8F8F0F8F8F0F8F8E8A87860581800702810803010883010
          883010883010883010883010FFFFFFFFFFFF8030108030108030108030108030
          10803010803010783018702818783820F8D8D0F8F8F0FFFFFFFFFFFFFFFFFFFF
          FFFFF8F8F0F8F8F0F8E8E8FFFFFFF8F0F0F0E8E0B0A088684830682818803018
          802818702008A07058F8F0E8FFFFFFF8F8F0C09078581800B0A088F8F8F0F8F8
          E8F8F8E8F8F0D8885840683018783010803018702010F8C0B8F8F8F0FFFFFF98
          98A0684830FFFFFFFFFFFFFFFFFFF8F0E8788880605848F8F8F0F8F8E8F8F8E8
          905848782018702018E0B0B0F8F8F0F0F8F8FFFFFFFFFFFFF0F8F0F0F8F0F0F8
          E8F8F8E0F8F8E0F8F8E0E09888682810682010682818C09078F8F8E8F8F8F0E0
          F0E8FFFFFFF8F0F0FFFFFFF8F8F0F8F0E0F8F0E0F8E8D8C09078783018782010
          903018802810983818802818782810F8C0B8F8F0E8FFFFFFF8F8F0E0B0B07030
          20803018803010884018682808603010E8C098F8F8E8F8F0E8F0F0E8FFFFFFFF
          FFFFF8F0E8F8F0E0F8F0E0F8F8E8F8F8E8B88878583010583010603018C09078
          F8F8E8F8F8F0F0E8E0FFFFFFF0F8F8FFFFFFFFFFFFF8E8E0F8F8F0F8F0E8C090
          78682818702810983818803010883010883010883010803010803010FFFFFFFF
          FFFF803010803010803010803010803010803010803010783018783020682818
          E0B0B0F8F8F0F8F0F0FFFFFFE0E8E8B0A088E8C098E09888E0B0B0E0D0C0FFFF
          FFFFFFFFF8F0E8E0B0B0905848601800783018803820583010D0B090F8F8F0F8
          F8F0F8D8D0684830B0A088F8F8F0F8F8F0F8F8F0F8E8D8603018703018803818
          883820601800C09078F8F8F0FFFFFFC8D0D8B0A088FFFFFFFFFFFFF8F8F0F8F8
          F0605848384040F8E0D0F8F8E8F8F8F0B08070682018702018C08878F8F8F0F0
          F8F0E0E8E8FFFFFFF0F0E8F8F8E8F8F8F0F8F8E8F8F8E8F8F8E0D0B090682010
          682010885840F8E8D8F8F8F0F0F8F0F0F8F8FFFFFFFFFFFFF8E0D8F8E0D8F8C0
          B8D0B090905848783018883820903018903018902810983818782008702008C0
          8878FFFFFFFFFFFFF8F8F0F8E0D8783820703018682008682008703010583010
          D0B090F8F8F0F8F8F0FFFFFFFFFFFFF0E8E0F8F8F0F8F8F0F8F0E0F8F8E0F8F0
          D8C09078783820603018603018F8E8D8F8F8E0F8F8F0F8F8F0F0F8F8E8F8F8D8
          E8E0F8E8E0E8C098C09078905848581800682810883820802810883010883010
          883010883010803010803010FFFFFFFFFFFF8030108030108030108030108030
          10803010803010783018783018602810B0A088F8F8F0F8F8F0FFFFFFA8B8B030
          3038582010582010603018684830A8B8B0F8F8F0F8F8F0F8F8F0E09888703018
          682808883820602808684830F8E8D8F8F8F0F8F8F0D0B090C0A8A8F8F0F0FFFF
          FFF8F8F0F8E0D0603018702810903820883018702008A07060F8F8F0F8F8F0F0
          F0E8F8E0D8FFFFFFF8F0E8FFFFFFF8D8D0582818603018E0B0B0F8F8E8F8F8F0
          D0B090582010702818A07058F8F8F0F8F8F0FFFFFFF8F0F0A070605828186030
          18603018803820A05048A05048883018883018682018E8C098F8F8E8E8F8F0F0
          F8F0F8F0E8C09078684830783820582818602008581800682008802810802808
          903010983818903018802810903820A87860FFFFFFFFFFFFFFFFFFF8F0E89058
          48683018703018803820783820581800A07058F8E8D8F8F8F0FFFFFFF0E8E078
          8880603018783820783820783820905848883820682818682818682818F8F0D8
          F8F8E8F8F8F0FFFFFFF0E8E09080906068686030186828186828186020187030
          20883820883820782808883010883010883010803010803010803010FFFFFFFF
          FFFF803010803010803010803010803010803010803010783018703018682818
          A87868F8F8E8F8F8F0FFFFFFC8B8C02820286020188038205820103010006058
          48F8E8E0F8F8F0F8F0E0F8F0D8A87860581800683010783820602808B88878F8
          F8F0F8F8E8F8F8F0F8E0D8F8F0F0FFFFFFF8E8E0E0D0C0783820702810903820
          802810803018885840F8F8E8F8F8F0FFFFFFFFFFFFFFFFFFF8F0E8FFFFFFB080
          70602018582010C09078F8F8F0F8F8E8F8D8D0683018783020783820F8F8E8F8
          F8F0FFFFFFF8F0F0B08070582818603018703020782818782018882810903018
          903018602008D0B090F8F8F0F8F8F0F8F8F0E0B0B05828185820106030186030
          18603018A87860A0705890382080301880281090382078281060180078301878
          3820E0E8E8F0F8F8FFFFFFFFFFFFA07060582818602810683018683018583010
          905848F8F8E0F8F8F0FFFFFFE0E8E88060605820107830207830207028187830
          20803820803018783020682818E09888F8F8F0F8F0E0F8F0E8E0B0B028202828
          2028603018582010783820A07058A05048682008601800983818883010883010
          883010803010803010803010FFFFFFFFFFFF8030108030108030108030108030
          10803010803010783018702810683018885840F8E8D8F8F8F0F8F8F0F8F0E880
          6060582010702818582010301000605848F8F0E8F8F8F0F8F8E8F8F8E8C09078
          602000682808703818603010684830F8E0D0F8F8F0FFFFFFFFFFFFF8F8F0FFFF
          FFF8E8E8E0B0B0682818782810903818802810883818703018F8D8D0F8F8F0F8
          F8F0FFFFFFFFFFFFF8F0E8F8E8E8803820782018602008A87860F8F8E8F8F8E8
          F8F0E0905848682818682818F8C0B8F8F8F0FFFFFFF8E8E0B888785820105818
          00682818682010782010882018782008883018682010B07868F8E8E0F8F8F0F8
          F0E8F8E0D8684830582818301000582010905848F8F0D8F8F0D8D0B090C08870
          683010703818885840783820783820603018E0E8E8F0F8F8FFFFFFFFFFFFB0A0
          88684830783820783820603018583010603018E0D0C0F8F8F0F8F8F0F8F0F0C0
          A8A8582010682018682018602008602008682008682008682008783018A05048
          F8F8E8F8F8F0F8F8F0F8E0D8684830603018582010301000A87868F8F0D8F8F8
          E8F8C0B8B08068782808803010883010803010803010803010803010FFFFFFFF
          FFFF803010803010803010803010803010803010803010783010703010703818
          603018F8E0D0F8F8E8F8F0E0F8F8F0D0B090E09888C08878D0B090B88878F8E8
          E0FFFFFFF8F8E8F8F8E8F8F8E0A07058703010883820682008803820581800B8
          8878F8F8F0F0E8E0FFFFFFF8F8F0FFFFFFFFFFFFD0B090581800803018883018
          802808803018682810D0B090F8F8E8F8F8E0F8F8F0F8F8F0F8F8F0D0B0908830
          18903018782018885840F8F8E8F8F8E8F8F8E8A87868582010602018D0B090F8
          F8F0F8F8F0FFFFFFF8E8E0C09078B88878D0B090C09078C09078E09888C08878
          E09888905848682818E8C098F8F8F0F8F8F0F8F8F0F8E0D8B0A088B0A088B0A0
          88F8F0D8F8F8E8F8F8E8F8F8E8E8C098603018885840F8D8D0F8E8D8F8E8D8F8
          E0D0F8F0F0FFFFFFF8F0F0FFFFFFF8F8F0E0D0C0F8E0D0F8E0D0F8E0D0B08068
          583010D0B090F8F8E8F8F8F0FFFFFFE0D0C0B88878C09078C09078C09078C090
          78C09078C09078E09888885840683018E8C098F8F8E8F8F8F0F8F8F0F8D8D0B0
          A088B88878B88878F8E8D8F8F8E8F8E8D8F8F8E0F8D8D0782810803010803010
          803010803010803010803010FFFFFFFFFFFF8030108030108830108830108030
          10803010803010783010783010803820603010B0A088F8F8E8F8F8E8F8F8E8F8
          F8F0F8F8F0F8F8E8F8F8E8F8F0E8F8F8F0F8F8F0F8F8F0F8F8E8F8E0D0905848
          702808983818803008782808903820703018E0D0C0F8F8F0F8F8F0F8F8F0FFFF
          FFF8F8F0B88878783020883018903018802808883818682808A87860F8F8E8F8
          F8E0F8F8F0F8F8F0F8F8F0A07058883018903018883018702818F8D8D0F8F8E8
          F8E8D8B0A088682818602008B08070F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8E09888582818603018D0B090F8
          F8F0F8F8F0FFFFFFF8F8F0F8F8E8F8F8E8F8F8F0F8F8E8F8F8E8F8F8E8B08070
          582818603018F8E8D8F8F8E8F8F8E8F8F8F0FFFFFFFFFFFFFFFFFFFFFFFFF8F8
          F0F8F8F0F8F8F0F8F8E8F8F0D8E09888603018B08068F8F8F0F8F8F0F8F8E8F8
          F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8B88878602008
          885840D0B090F8F0E0F8F8F0F8F0E8F8F8F0F8F8F0F8F8E8F8F0D8F8F8E0F8F8
          E8F8F8E0C09078703008783010803010803010803010883010883010FFFFFFFF
          FFFF803010803010883010883010803010803010803010803010783010783818
          581800B88870F8F8E8F8F8E8F8F8E8F8F8E8F8F8E0F8F8E0F8F8E8F8F8F0F8F8
          F0F8F8F0F8F0E0F8E0D0B0806870301070280890381088300888280898381870
          2008B08068F8F0D8F8F8F0F8F8F0F8F8F0F8F8F0C08078602008802818903818
          882810803010602000905848F8F8E0F8F8E8F8F8F0F8F8E8F8E0D09058488020
          10903018903018803820B0A088F8F8E0F8F8E8F8E0D0702010602008905848F8
          F8E0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E0F8F8E0F8F8E8F8F8E8
          F8F8E8E8C098783820602008905848B88878F8E8E0F8F0F0F8F8F0F8F0E8F8F8
          E8F8F8F0F8F8F0F8F0E0B88878684830582010603018F8D8D0F8F0E0F8F8F0F8
          F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8E8C098
          682818905848F8E8D8F8F8E8F8F8F0F8F8E8F8F8E8F8F8E0F8F8E0F8F8E0F8F8
          E0F8F8E0F8F8E0F8F8E0F8E0D0603018301000684830B0A088F8F8E0F8F8E0F8
          F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F0D8C09078803820581800783010803010
          803010883010883010883010FFFFFFFFFFFF8030188030108830108830108830
          10803010803010803010884018883820682808A05048D0B090D0B090E8C098D0
          B090E8C098E8C098D0B090D0B090D0B090B0A088B08070905848683018682808
          803008903810903010903010903018782008783820B0A088D0B090D0B090D0B0
          90E8C098A07058782818782008903818883010883818702808783820C09078D0
          B090D0B090B88878B88878783020882810903018903018783010905848D0B090
          D0B090D0B090883018803018783820E09888D0B090D0B090D0B090D0B090D0B0
          90A8B8B0A8B8B0A8B8B0D0B090D0B090D0B090C0907888382070281088382080
          3018A05048C08080E0B0B0F8D8D0F8E0D0F8C0B8C09078A07058703020702818
          702818682010C08870C09078E09888D0B090D0B090D0B090D0B090D0B090D0B0
          90D0B090D0B090E8C098E8C098E09888803820684830C09078E8C098E8C098D0
          B090D0B090D0B090D0B090D0B090D0B090D0B090D0B090D0B090C09078783820
          603018603010683018905848C08870E8C098F8E0D0E0D0C0E8C098B0A0889058
          48603010602808783818783010803010803010883010883010883010FFFFFFFF
          FFFF803018803018883010883010883010883010883010803010782808803818
          6820087028087838186028106830186830186030106028085830105828186030
          1858281858201058180070281088381890381890301090301090301090301088
          3010602808683018603018682818683018682818682010803018803010903818
          8030088838108838186828087838207838207838206030187838207020109030
          1898381890281078280858301058301060280870280888301880281060280860
          3018603018603018603018603018603018603018603018603018603018583010
          6830187838207828108028109028108020107820187820187020186820186020
          1868301870302070301870281088301890382070200888382080301880382070
          3020682818603018603018603018603018603018603018683018581800883820
          7028107028107838206028106030106030185830105830105830105830105830
          1060301060301068301078382068280880382080382068200870200870281080
          3820583010603018603018602008581800603010783818803818783010803010
          803010883010883010883010FFFFFFFFFFFF8030188030188830108830108830
          1088301088301088301080301098381888401880381878301870281078301878
          3820703810703810703018703018703020703020783820803820803818903818
          8830108028089030108828088028089038188038187838107030107028107830
          2070281078301890382090382090381878280878280888381878301070280868
          2810703018682810702810782810902810983818903010884018703818683010
          7030088028089838189838187838187038187830188028188028188030187830
          1878301878301870301078301870301078301088381890381898381898381898
          3818882018883018883018883820803820803820783018782810883018903018
          9838188828109030187820087820107028107830107830107030106830106830
          1068301068301070301080301890382080281088301888382070301068281068
          3018703010703010783010783010783010783010803010803010802810782008
          8830189030189030189838188828087820087838207838207838207838207838
          20803820783010601800803010803010803010803010883010883010FFFFFFFF
          FFFF803018803018883010883010883010883010883010883010802808802808
          8028088028088030108030188030187828108038188840188838208038207828
          1870201878201880281888301888301080280888300888381080300878280890
          3818782808803008883818782808803018803018803018702008803010883810
          8030088030088838108030108030108838208830188830188028108838188828
          0890301088300880381060280870381078280898381888280890301068200878
          3818803018883018903018903018903018903018903018903018883018883018
          8028108028108828108828088828088828089030189030188830188030187830
          1078301078301080301090381880280888281090301090381888281088301888
          3820883810883810803810783810783810703818783818803818883818882810
          8028088828088830187830106828087838188838188830188830188830188830
          1888301888301888301880281090381898381890301088280890301098381898
          3818803018682010682008782810782810782810803010983818803010803010
          803010803010803010803010FFFFFFFFFFFF8030188030188030108830108830
          1088301088301088301098381888301090301090381890381890381888301880
          2808802808803008883010883018883018903018903018903018883018883010
          8830108838108038107830107830108038109038109038109838188828088838
          1888301890382078280878280880300890381088381088381088301080281088
          3018802808903018802808903820882810903810802808703008682808783810
          8030089838189030109838187830087838187830108030108830109028109028
          1090281090281090281090301890381888381880381080381878381078380880
          3810883818883018803818803810783810783810783810803810883810803008
          8830089038108030088030088030108030109030109030108830088030087830
          0870300878301080301088301090301090301898381898381888381878301088
          3820883010883010883010883010803010803010803010803010883818883818
          7828087828088838108838188830108028089030189030189030189838189838
          18882808802808883010883010883010803010803010803010803010FFFFFFFF
          FFFF803018803018803018803010883010883010883010883010883010802808
          9038189838188828108828108830189038189038109038108830108828109030
          1890301890301888301890301890381890381880381070280870300878381878
          3008903810802808903010903010903820782008883818803018883818783008
          8838108030088028089038189038188828109030189838188028089038188828
          0898381888381078381068280868280890381088280898381888280880301070
          3810783810783010883010903010903018903018903018903018902810903818
          8038107030087038106828086828087838108038108030107830087030087030
          0870300878380880381080380888381090381090381080300880381080381888
          3810903810903810903810803808783808783810783810803010903018902810
          9030108828089030109038208030107828088830109030108830108830108830
          1080301080301080301070280888401880381080381080381078300880381090
          3818882810903018903018902810902810983818983818882808903010883010
          803010803010803010803010FFFFFFFFFFFF}
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
          1514.739583333330000000
          105.833333333333000000
          350.572916666667000000)
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
        Caption = '021-0'
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
        Left = 58
        Top = 845
        Width = 602
        Height = 18
        Size.Values = (
          39.687500000000000000
          127.881944444444400000
          1863.107638888889000000
          1327.326388888889000000)
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
        Width = 60
        Height = 10
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          1909.409722222222000000
          132.291666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nosso N'#250'mero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Caption = 'AT'#201' O VENCIMENTO PAG'#193'VEL EM QUALQUER BANCO'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Picture.Data = {
          07544269746D6170864F0000424D864F00000000000036000000280000009000
          00002F0000000100180000000000504F00000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
          FFFFE0F0E8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F0F0E8F8F8F0F8F8F0F8F8
          E8F8F8F0F8F8F0F8F8F0F8F8E8F0F0E0F0E8E0E8E8F0F8F8F0F8F8F0F8F8E8F8
          F0F0F8F8F0F8F8E8F8F0F0F8F8D8E8E0F0F8F8E0F0E8E0F0E8F0F8F8F0F8F8F0
          F8F8F0F8F8E0F0E8F0F8F8E8F8F0E8F8F0F0F8F8E0F0E8E0E8E8F0F8F8E0F0E8
          F0F8F8F0F8F8E0F0E8E8F0F0F0F8F8D8E8E0E8F8F0F0F8F8F0F8F8F0F8F8E8F8
          F0F0F8F8F0F8F8F0F8F8F0F8F8E0F0E8F0F8F8F0F8F8F0F8F8A8B8B0100810A8
          B8B0F0F8F8F0F8F8E8F8F0E0E8E8F0F8F8E8F8F8E0F0E8F0F8F8F0F8F8F0F8F8
          E0F0E8F0F8F8E8F8F0E8F8F8F0F8F8908090100810C8D0D8F0F8F8F0F8F8E0E8
          E8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8F0F8F8F0F8F8D8E8E0E0F0E8F0
          F8F8F0F8F8F0F8F8E0F0E8F0F8F8E0F0E8F0F8F8F0F8F8E0E8E8E8F8F0E8F0F0
          E8F8F0E8F8F0E8F8F8F0F8F8F0F8F8E8F8F0F0F8F8F0F8F8E8F8F0F0F8F8F0F8
          F8E0E8E8F0F8F8F0F8F8F0F8F8E8F8F8F0F8F8F0F8F8F0F8F8E8F8F0F0F8F8F0
          F8F8F0F8F8E8F8F8F0F8F8D8E8E0F0F8F8F0F8F8F0F8F8F0F8F8E8F8F0F0F8F8
          F0F8F8D8E8E0F0F8F8D8E8E0FFFFFFFFFFFFF0F8F8E0F0E8788880788880C8B8
          C0F0F8F8E0F0E8F0F8F8E0F0E8F0F8F8C8D0D8908090908090908090A8B8B0F0
          F8F8F0F8F8D8E8E0908090A8B8B0A8B8B0C8D0D8C8D0D8A8B8B0D8E8E0E8F8F0
          9898A0E0E8E8F0F8F89898A0606868A8B8B0E8F8F8F0F8F8D8E8E07888807888
          80C8D0D8F0F8F8F0F8F8E8F8F0F0F8F8F0F8F8A8B8B09898A0A8B8B0E0F0E8F0
          F8F8D8E8E09898A0A8B8B0C8D0D8F0F8F8A8B8B0A8B8B0E8F8F0C8B8C0908090
          F0F8F8C8B8C0A8B8B0A8B8B0100810606868908090C8B8C0F0F8F8C8D0D8A8B8
          B0E8F8F8F0F8F8E8F8F0A8B8B0A8B8B0A8B8B0E8F8F8F0F8F8F0F8F8F0F8F878
          8880100810788880788880C8D0D8F0F8F8F0F8F8A8B8B0788880A8B8B0E8F8F0
          F0F8F89898A0C8D0D8F0F8F8F0F8F8A8B8B0788880C8D0D8F0F8F8A8B8B07888
          80A8B8B0F0F8F8E8F8F0E8F8F0F0F8F8F0F8F8A8B8B09898A0A8B8B0908090D8
          E8E0E8F8F0D8E8E0788880908090F0F8F8F0F8F8F0F8F8E8F8F0F0F8F8E8F8F0
          C8D0D8A8B8B0E8F8F0F0F8F8F0F8F8908090788880A8B8B0E8F8F0F0F8F8D8E8
          E0788880606868D8E8E0E8F8F0E0F0E8C8D0D8908090A8B8B0F0F8F8FFFFFFFF
          FFFFC8D0D8303038000000282028100810908090F0F8F0E0E8E8F0F8F8F0F8F8
          606868100810282028282028100810384040C8D0D82820281008107888802820
          28504858788880000000A8B8B0C8D0D80000009898A0B0A08800000030303810
          0810788880C8D0D8384040303038384040303038C8D0D8F0F8F0F0F8F8F0F8F0
          788880282028605848303038606868E0F0E8303038303038303038605848E0E8
          E8384040384040FFFFFF606868605848E0F0E8605848384040A8B8B010081038
          4040282028303038C8D0D8788880000000D8E8E0E8F0F0605848100810384040
          384040A8B8B0F0F8F0FFFFFFFFFFFF788880000000605848303038282028E0E8
          E8606868303038384040282028908090C8D0D8100810788880FFFFFFA8B8B000
          0000000000A8B8B0908090100810605848282028788880FFFFFFE8F0F0FFFFFF
          C8D0D8282028282028384040000000908090A8B8B02820283840403030386058
          48E0E8E8F0F8F8F0F8F8E8F0F0FFFFFF605848100810D8E8E0FFFFFF78888028
          20283840402820289898A0D8E8E0303038282028282028303038FFFFFF788880
          100810303038100810606868FFFFFFFFFFFF605848000000A8B8B0F0E8E02820
          28303038FFFFFFFFFFFFFFFFFFF8F0F0384040282028F0E8E0F8F0F850485810
          0810788880282028605848E0E8E8303038605848A8B8B0100810C8D0D8C8D0D8
          1008109898A0384040384040E0E8E8788880788880B0A088100810A8B8B0E0E8
          E8100810788880F8F0F0FFFFFFF8F0F8C8D0D8B0A088C8D0D860584828202860
          5848282028C8D0D8C8D0D8806060A8B8B0605848384040FFFFFF605848384040
          FFFFFF605848303038A8B8B0282028788880F0E8E01008107888809080902820
          28FFFFFFA8B8B0000000A8B8B0C8D0D8788880A8B8B0FFFFFFFFFFFFFFFFFF90
          8090100810C8D0D8A8B8B0100810908090282028606868F8F0F8908090908090
          E0E8E8282028A8B8B0F8F0F0908090100810A8B8B0FFFFFF384040282028FFFF
          FF605848100810FFFFFFFFFFFFF8F0F0A8B8B01008109898A0F0E8E028202890
          8090606868100810E0E8E8C8D0D8605848F0E8E0FFFFFFFFFFFFF0F0E8F8F0F8
          282028000000A8B8B0FFFFFF100810384040FFFFFF3840403840407888800000
          00A8B8B0C8D0D8605848788880282028605848F8F0F8A8B8B0788880FFFFFFFF
          FFFF282028303038FFFFFFFFFFFF788880100810C8B8C0FFFFFFFFFFFFFFFFFF
          806060100810C0A8A8A8B8B0384040303038F0E8E0A8B8B06058486058482820
          28806060908090100810E0E8E8A8B8B0282028908090100810806060FFFFFFFF
          FFFFF0F0E8C0A8A8100810A8B8B0FFFFFF100810605848FFFFFFFFFFFFF0F0E8
          C0A8A8282028100810303038788880606868000000605848384040384040C0A8
          A8605848384040F8F0F8606868384040FFFFFF605848605848A8B8B0100810C8
          B8C0FFFFFF282028788880908090100810FFFFFF908090100810303038806060
          303038908090FFFFFFFFFFFFF8F0F8908090100810F0F0E8C8D0D82820286058
          48282028303038384040384040606868F0F0E80000009898A0FFFFFF9898A010
          0810F0F0E8F8F0F8282028788880F8F0F0788880100810F0F0E8FFFFFFF8F0F8
          C0A8A8000000C0A8A8F8F0F8100810A8B8B05048581008106058483030386058
          48C8D0D8F0F0E8FFFFFFFFFFFF908090282028606868605848E0E8E810081090
          8090F8F0F8605848282028806060100810C8D0D8F8F0F8FFFFFFF8F0F0282028
          282028605848605848282028FFFFFFFFFFFF282028384040FFFFFFF8F0F89080
          90100810A8B8B0FFFFFFFFFFFFFFFFFF78888010081028202810081028202890
          8090FFFFFF788880788880C8D0D8282028788880908090000000788880788880
          282028908090605848282028F8F0F0806060606868C0A8A81008109898A0C8B8
          C0000000908090FFFFFFFFFFFFFFFFFF788880282028C8D0D8908090C8B8C090
          8090100810A8B8B09898A0282028A8B8B0384040282028C8B8C0303038282028
          C8D0D8384040605848C0A8A8100810788880C8B8C0100810C0A8A87888800000
          00605848A8B8B00000009898A09898A0282028908090FFFFFFF8F0F0FFFFFF78
          88801008109080909898A0100810A8B8B0303038384040C8D0D8303038504858
          E0E8E8282028282028788880605848282028788880C8D0D8605848303038F8F0
          F0384040303038F8F0F8FFFFFFF8F0F8C8B8C0100810788880C8D0D810081098
          98A0788880100810C8D0D8908090100810C8D0D8FFFFFFF8F0F8F8F0F0504858
          384040C8D0D8384040E0E8E8303038504858E0E8E8384040504858A8B8B00000
          00908090C8B8C0303038C8B8C0303038384040E0E8E8504858282028FFFFFFFF
          FFFF303038100810E0E8E8FFFFFF605848282028E0E8E8F8F0F0FFFFFFF8F0F8
          504858303038E0E8E8F0F0F8504858282028F0F0F89080903030383840403030
          38A8B8B09898A0303038504858100810384040E0E8E8C8B8C028202828202828
          2028A8B8B0FFFFFF788880282028282028504858F0F0F8F0F0F8F0F0F8FFFFFF
          A8B8B0384040384040303038A8B8B0F8F0F8504858384040384040606868F0F0
          F8788880303038384040282028605848303038000000908090A8B8B028202860
          5848384040605848F0F0F89898A02820282820287888809898A0282028504858
          504858C8D0D8FFFFFFF8F0F8E0E8F0908090282028504858384040605848F8F0
          F8C8B8C0384040282028504858A8B8B0E0E8F030303830303830303828202810
          0810100810C8D0D8C8B8C0303038282028282028A8B8B0FFFFFFF8F0F8F0F0F8
          F0F0F8605848282028504858000000A8B8B0E0E8E83840403030383030387888
          80FFFFFFFFFFFFF0F0F8E0E8F0100810908090FFFFFF384040A8B8B0C8D0D828
          2028282028303038A8B8B0FFFFFF606868282028384040606868F0F0F8A8B8B0
          384040303038282028C8B8C0FFFFFFFFFFFF9080902820283840406068680000
          00504858F0F8F8F0F8F8E0E8F0F0F8F860686810081078888078888028202828
          2028E0E8F0F0F8F8E0E8E8C8D0D8E0E8E8F0F8F8E8F0F8E0E8E8F0F8F8E0E8E8
          F0F8F8F0F8F8F0F8F8E8F0F8C8B8C0F0F8F8F0F8F8F0F8F8F0F8F8E0E8E8C8D0
          D8E0E8F0F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E0E8E8D8E8E0F0F8F8E8
          F0F0F0F8F8C8B8C0C8D0D8F0F8F8F0F8F8E0E8F0E0E8F0E0E8F0C8B8C0F0F8F8
          E0E8E8D8E8E0F0F8F8F0F8F8E8F0F8F0F8F8D8E8E0E0E8F0F0F8F8D8E8E0F0F8
          F8F0F8F8E8F0F8F0F8F8C8D0D8D8E8E0E0E8F0F0F8F8F0F8F8F0F8F8F0F8F8F0
          F8F8D8E8E0E0E8F0C8D0D8E8F0F8F0F8F8F0F8F8C8D0D8C8D0D8E0E8F0F0F8F8
          F0F8F8E0E8F0F0F8F8E0E8E89898A0100810A8B8B0E8F0F0F0F8F8E8F0F8C8D0
          D8C8D0D8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8C8D0D8C8B8C010081090
          8090F0F8F8E8F0F8C8D0D8D8E8E0F0F8F8F0F8F8E0E8F0F0F8F8E8F0F8E0E8F0
          E8F0F8F0F8F8F0F8F8E0E8F0F0F8F8E0E8E8C8D0D8C8D0D8F0F8F8F0F8F8F0F8
          F8A8B8B0C8B8C0F0F8F8E8F0F8F0F8F8C8D0D8A8B8B0C8D0D8E8F0F8FFFFFFFF
          FFFFFFFFFF788880282028303038788880E0E8E8FFFFFFE0E8E8F0F8F8F0F8F8
          788880282028605848605848504858C8B8C0FFFFFFF0F8F8FFFFFFF0F8F8F0F8
          F8F0F8F8FFFFFFF0F8F8E0E8F0F0F8F8FFFFFFE8F8F8FFFFFFF0F8F8E0E8E8F0
          F8F8FFFFFFE0E8E8FFFFFFF0F8F8E0E8F0F0F8F8F0F8F8F0F8F8FFFFFFE8F0F0
          F0F0F8F0F8F8E0E8F0F0F8F8FFFFFFF0F8F8F0F8F8F0F8F8FFFFFFE0F0E8F0F8
          F8F0F8F8FFFFFFF0F8F8FFFFFFE0E8E8FFFFFFF0F8F8D8E8E0E0F0E8FFFFFFE0
          E8E8FFFFFFF0F8F8FFFFFFF0F8F8FFFFFFE8F8F8FFFFFFF0F8F8FFFFFFF0F8F8
          FFFFFFE8F0F0E8F0F0F0F8F8E8F0F8F0F8F8FFFFFFF0F8F8FFFFFFF0F8F8E8F0
          F0E0E8E8FFFFFFF0F8F8F0F8F8F0F8F8E8F0F8F0F8F8FFFFFFF0F8F8E8F0F078
          8880E8F0F0F0F8F8E0E8F0F0F8F8FFFFFFF0F8F8F0F8F8E0E8E8E0E8F0F0F8F8
          E0E8E8F0F8F8FFFFFFE0E8E8605848A8B8B0E8F0F0F0F8F8FFFFFFF0F8F8F0F8
          F8E0E8E8FFFFFFF0F8F8FFFFFFF0F8F8F0F8F8F0F8F8E8F0F8E0E8E8FFFFFFF0
          F8F8FFFFFFF0F8F8FFFFFFE0E8E8F0F8F8F0F8F8FFFFFFF0F8F8FFFFFFE0F0E8
          6068683840409898A0E0E8E8FFFFFFFFFFFFF0F0E8FFFFFFFFFFFFF0E8E0FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0FFFFFFFFFFFFF8F8F0F0F0E8FF
          FFFFFFFFFFF0E8E0F8F8F0FFFFFFF0F0E8F8F0E8FFFFFFF8F8F0FFFFFFFFFFFF
          F8F8F0FFFFFFFFFFFFF8F8F0FFFFFFFFFFFFF0F0E8F8F8F0FFFFFFFFFFFFFFFF
          FFFFFFFFF8F8F0F8F8F0FFFFFFF8F8F0FFFFFFFFFFFFFFFFFFFFFFFFF8F0F0FF
          FFFFF8F0F0FFFFFFF0F0E8F8F0E8FFFFFFFFFFFFF0E8E0FFFFFFFFFFFFF8F8F0
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F0F8F0E8F8F8F0FFFF
          FFF8F0E8FFFFFFF0F0E8F8F0F0F8F0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8
          F8F0FFFFFFF0E8E0FFFFFFF0F0E8FFFFFFFFFFFFFFFFFFF0E8E0F8F0F0FFFFFF
          FFFFFFF0F0E8F8F8F0F8F8F0F0E8E0FFFFFFF0E8E0FFFFFFF8F8F0F8F8F0F0F0
          E8FFFFFFF8F8F0FFFFFFFFFFFFF8F8F0F8F0F0FFFFFFF0E8E0F0F0E8F8F8F0FF
          FFFFFFFFFFF8F8F0F8F8F0F8F0E8F0F0E8FFFFFFFFFFFFF8F8F0F8F8F0FFFFFF
          F8F8F0F8F8F0FFFFFFFFFFFFF0F0E8FFFFFFF8F0F0F0E8E0FFFFFFFFFFFFF8F8
          F0F0E8E0FFFFFFF8F8F0F0F0E8FFFFFFF8F0F0A8B8B0F8E0D8FFFFFFFFFFFFFF
          FFFFF8F8F0F8F8F0F8F8F0F8E8D8F8F8F0F8F8E8F8F8F0F8F0E0F8F8F0F8F8F0
          F8F8F0F8F8F0F8E8E0F8F0E0F8F8F0F8F8F0F8E8D8F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8F0F8F8F0F8F8E8F8F8E8F8F0E0F8F8F0F8F8F0F8E8E0F8F8F0F8F8F0F8
          E8D8F8F8F0F8F8F0F8E8E0F8F0E0F8F8F0F8E8E0F8F0E8F8F8F0F8F8F0F8F8F0
          F8F8F0F8E0D8F8F8F0F8F8F0F8F0E8F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F0
          E8F8F8E8F8F8F0F8F8F0F8E8E0F8F8F0F8F8F0F8F8F0F8F8F0F8F0E0F8F0E8F8
          F8F0F8F0E0F8F8F0F8F8F0F8F8E8F8F8F0F8F0E0F8F8E8F8F8F0F8F8F0F8F8F0
          F8F8E8F8F8E8F8F8E8F8F0E0F8F8F0F8F8F0F8F8E8F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8F0F8F8F0F8F8F0F8F8F0F8F0E0F8
          F8E8F8F8F0F8E8D8F8E8D8F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8
          F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8E8F8E0D8F8F8E8F8F8F0F8E0D0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8
          F8E8F8F8F0F8F8F0F8F0E0F8F0E8F8F8F0F8F8F0F8F0E8F8F8F0F8F8F0F8F8E8
          F8F8F0F8F8F0F8F8F0F8F0E8FFFFFFFFFFFFB08070A87860B88878B88870B888
          70B08070C09078B07868A07060A87860B07868B08068B08070C08878B88870A0
          7058B88870B88878A87860A07058A87868C09078B88870B08068C09078A07058
          B08070B08068A87868B08070A87860C09078A07058C09078B08070A87868B080
          68B08068B88870A07060905848B08068C09078B88878C09078A87860B08070B8
          8870B08068A07058B08068B08068B07868B88878C08878885840C09078B08070
          A87868B88870B08068B08068C08878A07058B08070B88870A87868A07058B888
          70B88870A07060B07868A87868A87860B88870B08068B08068B08070B08068B8
          8870B08070B08070B08068B88870B08068B88870A87868A87860B08070905848
          B88878B88870A07058A07058B88878A87868B88878B07868B88870B080689058
          48B08070C09078A87868905848C09078C09078A07058B88878A07058A07060B8
          8878B08070B88870A07058A07060B88878B07868B07868C09078C09078A07060
          B88878A87860B08070B08068C08878B88870A07058C09078B88870A07058B888
          78B88870A87860A87868B07868B08070B07868B07868A87860C09078FFFFFFFF
          FFFF682008702810682810682810682008682808602008682810702810703018
          6820086018006828106020085818007030187838185818006020008038205818
          0058180060280868301060200080381860180070200878301860200060200860
          2808783820581800601800783820702810601800682810702810782810782810
          6018007020086018006828107838205818007028107028107030186020087030
          1058180068280878382068281058180078382060200858180070301860200870
          3010703010581800703010703010581800783818703018602008703018602000
          7838186020006020087838185818006828087030185818007030106820086820
          0860200078382068281060200870301868281058180078382068280868280868
          2808682008702810703010682008682810703018682008682810703018581800
          6020086828086020086828107838205818006020087030106020007030186828
          0860200080382058180060200070301860200870301058180068280868280860
          2008703018581800682818682008703018602008703018682810682008702810
          682008703018682810702810FFFFFFFFFFFF7820109038208838187028087830
          1080381878381078301080301880301880301878301878301870381070381070
          3810803808803808783808703008682808602808682808703008803810883810
          9030109030108830108038107838107038107038107838108830108830108030
          1078381078381880301890281090281090281090301080301870301078301070
          3010783018783018783018783810783810783810783810783810783818783018
          7830187830187830187830107838107838108038108038108038108038107838
          1078381078381078381078380878380878300878380878381080381080381080
          3810803018803018803010803010803810783810783810703810703010683010
          6830107030107830107830108030088030088838108038108030108030188030
          1880301878301878301878381078381078381078381078381078381078381878
          3810803810803810803810803810803810803810803810803810783810783810
          7838107838107838107838107838107838108038206820107830188038208038
          20803818702808883818803010803010803010803010883010883010FFFFFFFF
          FFFF883018903018883010783008803810803810783008783010783010783010
          7830187830187030106830106828087030088038088838107838087030086028
          0860280868280870300880301088301090301090301088301080301070301068
          3010683010703010883010882810803010783010703010783010902810902810
          9030189030188030187830187830187830187830187828187830107830107830
          1078301078301078301078301078301878301878301878301078301078300878
          3008803008803008803008803008803008783008783008783008803010803010
          8038108038108038108038108038108038108030188030188030188830108030
          1080381078381078381070301070301870301870301078381080381088381088
          3810803010803010803010803018803018803018803018783018783010703010
          7030087030087030107030107830107830108030108030108030108030108030
          1080301080301078301080301078301078301078301078301078301078301078
          3010703018682810783020783018783010803010782808883818883010883010
          883010883010883010883010FFFFFFFFFFFF8830188830188030108030088038
          1078381070300880381870280870281070281068281068281060280858301060
          2808782810802810782810702810682810682810682810702010782818782018
          7820187820187820187020186820186828186028106828087820088028087028
          1068281068281070281080201090281088281080201068281068281068281070
          2010702010782010702810702810702810702810702810702810702810702010
          7020107020107028107028107028087028087028107820107820107820107820
          1078201078201070201078201078201078201078201078201078201878201878
          2018702818702818782810782810782808782808702808702808682008682810
          6828106828107028107028087828087828087028087028087028107020107020
          1870201870201070201070281070280870280870280870280870281078281078
          2010782018782018782018782018782018782018782018702018782018702018
          7020187020187020187020187020187020187030186028107030186020086020
          00783010702808803010803010803010803010803010803010803010FFFFFFFF
          FFFF903018883018802808803010803810783008783010905848C08870C08878
          C08878C08878C08870C09078B88870C09078C08878C08080C08080C08080C080
          80C08878C08080C08080C08878C08878C08080C08080C08080C08080C08080B0
          8070B88878B88870C08870C08878B88878B88878B88878B88878C08870C08870
          C08870C08870B88870B88870B88870C08878C08078C08878C08870C08870B888
          70C09078C09078C09078C08878C08878C08878C08878C08878C08878B88870B8
          8878C08878C08878C08080C08878C08878C08878C08878C08878C08078C08078
          C08078C08078C08078C08078C08080C08078B88878B88878B88878C08870C088
          70C08870C08870C08870B88870B88870B88870B88870B88870B88870C08870B8
          8870B88870B88878B88878B88878C08878C08878C08878C08878C08878B88878
          C08870C08870C08878C08878C08878C08878C08878C08878C08878C08080C080
          80C08080C08080C08080C08080C08080C08080C08080C08080C08080C08080C0
          8878C09078C08878C09078C08870C08870C09078905848783010783010803010
          803010803010803010803010FFFFFFFFFFFF8830188830188830108838108038
          10702808803810A05048F8F8E0F8F8E8F8F8F0F8F8F0F8F8E8F8F8E8F8F8E0F8
          F8E8F8F8F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8
          E8F0F8E8E8F8F0F8F8E8F8F8F0F8F8E8F8F8F0F8F8E8F0F8E8F0F8E8F8F8E8F8
          F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8F0F8F8F0
          F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8F0F8F8F0FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8
          F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8
          F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8F0F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8
          F8F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F0FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F0F8F8E8F8F8E0F8F8E8F8F8E0F8F8
          E0F8F0D8A87860602000783010783010783010783010783010783010FFFFFFFF
          FFFF883010883018883010883810803810702808783818A05048F8F8E0F8F8E8
          F8F8E8F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8F0F8F0F0F8F0F0F8F0
          F0F8F0F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8
          F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8E8F8F0E8F8F0F0F8E8F8F8E8F8F8E8
          F8F8E8F8F8E8F0F8E8F0F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8
          E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8
          F8E8F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0
          F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8
          E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8
          F8E8F0F8E8F0F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8
          F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8
          F8F0F8F8F0F8F0E0F8F8E0F8F8E0F8F8E0F8F0D8C08870783810783810783010
          783810783010783010783010FFFFFFFFFFFF8830109038188830108830108838
          1078300878381068483090584890584890584890584890584890584890584890
          5848905848905848905848A05048A05048A05048A05048A05048905848885840
          885840885840905848A05048A05048A05048A05048A05048A05048A050489058
          48905848905848905848A05048A05048A05048885840885840905848A05048A0
          5048A05048A05048A05048905848905848905848905848905848A05048A05048
          A05048A05048A050489058489058489058489058489058489058489058489058
          4890584890584890584890584890584890584890584890584888584088584088
          5840905848905848905848905848905848A05048A05048A05048A05048A05048
          A05048A05048905848905848905848905848905848905848905848A05048A050
          48A05048A05048A05048905848905848905848905848905848A05048A05048A0
          5048A05048905848905848905848905848905848905848905848905848905848
          9058489058489058489058489058489058489058489058489058488858408858
          40905848783818682808783010783010803010803010803010783010FFFFFFFF
          FFFF883010883818883010883008883810803810703010703018582010582010
          5820102820285820105820105820105820105830105830106820107820108828
          1088280888280880280868200860200060200068280878280880280888280888
          2808902810882018882018782018582010582010582010602008802818882018
          7820186820106028106828108820188820189028108828108020107020186820
          1868201868201868201078201880201080201078201070201068201058201058
          2010602008602008602008602008682008682008682008682008702810702810
          6828106828106828106828106028106028106020086020186820186820187020
          1878201878201888201888201888201888201880201078201068201860201860
          2018682018702018782018882018882018882018882018882018702018682018
          6020186020186020186820187020187020106820086820086820086820086820
          0868201068281068281068200860200860200860200860200860200860200858
          2010582010582818603018603018583010683010703010883820783010803010
          803010803010803010803010FFFFFFFFFFFF8830188830108838108838108830
          08783008783818684830A07060806060A07060A07060A07060A07060A07060A0
          7060A87860885840885840783820702810803010883818883820A07058A87860
          A07058703818783810883810882808903010903018903018702010A07058A070
          58A07058A87860905848883018782010B08068A87860A0705878382078201090
          3018903818903820702810682818905848A07060A07058A07058883820682008
          783018A87860A87860A07058A07060A07060A07058A87860A07058A07058A070
          58A07058A07058A07058603018684830583010783820603018B88878B0A088E8
          C098E8C098E09888B88878684830682818582010803018802818883018883018
          903820601800803820A87860A07058A07060B080708838207020189038209030
          18802808903818783018A07058A07058A07060A07060A07060A07058A07058A8
          7860A07058A87860885840A87860A07058603018783820583010583010905848
          B88878B0A088E8C098E8C098B0A088B080686848306030185818006030187838
          20682810702810803018803010883010883010883010883010883010FFFFFFFF
          FFFF803018803010883810903810883008803008783818783820F8F8E8F8F0E8
          FFFFFFF8F0E8F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E0F8F8E0F8E8D8E098
          88703818581800905848F8F8E0F8F8E0F8F8E0E8C09870381860200090381888
          3010802818782818783820E8C098F8F0D8F8F8E8F8F8E8F8E8D8783018803018
          F8D8D0F8F8E0F8F8E0B0A088803820802808782808783810602808885840F8D8
          D0F8F8F0F8F8E8F8F8E8684830602808803820E8C098F8F0D8F8F8E8F8F8F0F8
          F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8A87868301000
          603018B0A088F8E0D0F8F8E8F8F8E8F8F8E0F8F8E0F8F8E0F8F0D8F8E0D0D0B0
          90905848582818682818682008803010783008783810885840E8C098F8F0D8F8
          F8F0F8E8E0E09888702818782810802808883008903818703010F8D8D0F8F8F0
          F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E0F8F8E8F8F8E8F8F8E8F8F8
          E0B08068301000603018B88878F8E0D0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8
          F8E8F8D8D0D0B090A07058603018582010783820883820803010883010883010
          883010883010883010883010FFFFFFFFFFFF8038188030108830109038109038
          10803010783010683018F8E0D0F8F8F0FFFFFFF8E8E0F8F0F0F8F8F0F8E8E0F8
          F8E8F8F8E8F8F8F0F8F0E0F8F8E8F8F8F0F8D8D0A07058581800B88878F8F0E0
          F8F8E8F8F0E0A07058581800803820782818803018682010783820F8D8D0F8F8
          E8F8F8E8F8F0D8E8C098883820702810D0B090F8F8E0F8F8E0E8C09880382080
          3010783008783818581800905848F8F8F0F8F8F0F8F8F0F8F8E8A07058603010
          703818E8C098F8F8E0F8F8E8F8F8F0FFFFFFF8F8F0F8F8F0FFFFFFFFFFFFF8F8
          F0F8F8F0FFFFFFF8F8F0B88878582010D0B090F8F8F0FFFFFFF8F0E8FFFFFFF8
          F8F0F8F8E0F8F8E0F8F8E8F8F8F0F8F0E8F8E0D8B08070783820683010803818
          682808783810581800B0A088F8F8E8F8F8F0F8F8F0F8D8D07838207830088838
          10903810883810602000D0B090F8F8F0F8F8F0F8F0E0F8F8F0F8F8E8F8F8E0F8
          F8E0F8F8E8F8F0E8F8F8F0F8E8E0F8F8F0B88878301000B0A088F8F8F0F8F8F0
          F8F8F0F8F8F0F8F0E8F8E8E0F8F0E8F8F8F0F8F8F0F8F0E8F8D8D0B888787838
          20682810803820883018883010903010903010903010903010883010FFFFFFFF
          FFFF803818803010803008883010903810883810783010603010D0B090F8F8F0
          F8F8F0FFFFFFF8F8F0F8F0E8F8E8E0F8F8E8F8F8F0F8F8F0F8F8F0F8F8F0F8E8
          E0F8F8F0F8E0D8684830684830F8D8D0F8F8F0F8F8F0E0B0B068483058201058
          2010602018581800603018E0B0B0F8F8E8F8F8E8F8F8E8E8C098782818601800
          B08068F8F8E0F8F8E0F8F0D8783820803010783008703810583010B0A088F8F8
          F0F8F8F0F8F0E0F8F8E8B0A088602808581800A87860F8F8E0F8F8F0F0F0E8F8
          F0F0FFFFFFF8E8E8FFFFFFFFFFFFF8F0F0FFFFFFFFFFFFF8F0F8E0B0B0A07060
          F8F0F0FFFFFFFFFFFFFFFFFFFFFFFFF8E8D8F8E0D0F8E0D0F8F0D8F8F8F0F8F8
          F0FFFFFFF8E8E0B08068683010703810682808783810581800A87860F8F8E8F8
          F8F0F8F0E8F8E8E0684830783810883810883810783808602000A87860F8F8F0
          FFFFFFE0F0E8F8F8F0F8F8E8F8F8E0F8F8E8F8F8F0F8F0F0FFFFFFF8F8F0FFFF
          FFE0B0B0905848FFFFFFF8F0E8F8F0F0F8F0F0F8F8F0F8F0F0F8E0D8F8E0D8FF
          FFFFF8E8E0F8F8F0F8F8F0F8F0E0C09078602810702008883820883010883010
          903010903010903010883010FFFFFFFFFFFF8038188030108830108830109038
          10883810783010602808B88870F8F8F0F8F0E0F8F8E8E0D0C068483078382078
          3820603018684830D0B090FFFFFFFFFFFFF8F0F0F8F0F0C0A8A8582010C08080
          F8F0F0F8F0F0FFFFFFD0B090B0A088E0B0B0E0B0B0D0B090E0B0B0F8F8E8F0F8
          F0F0F8E8F8F8E8E09888782018702010905848F8F8E8F8F8E8F8F8E088584078
          2810783810602000684830F8F8E8FFFFFFFFFFFFFFFFFFF8F8F0F8C0B8583010
          581800684830F8F8E8F8F8F0FFFFFFFFFFFFC0A8A8A87868B88878B88878C080
          80C08878C08080C08080A87868A87868F8E8E8F8F0F0FFFFFFFFFFFFB8887888
          5840603018603010905848B0A088F8E8E8FFFFFFF8F8F0F8F8E0783820602000
          783808783810602808905848F8F8F0FFFFFFF8F8F0F8F8F0A070587030087830
          08803008803808703810885840F8F0E0FFFFFFF8F0F0F8F8F0C0A8A8B88870B8
          8878B88878C08080C09078B88878B08070A07060A87868F8E8E8F8F0F0F8F8F0
          F8F0E8C09078684830582818603018684830B0A088F8F8F0F8F8E8F8F8F0F8E0
          D0885840682810803018803010883010883010883010883010883010FFFFFFFF
          FFFF783018803010883010883008903010903810783010602808885840F8F8E8
          F8F8E8F8F8F0F8F0E8885840683018783820803820783820603018D0B090F8F8
          F0F8F8F0F8F0E8F8F8F0684830684830F8D8D0FFFFFFFFFFFFF0E8E0FFFFFFF8
          F8F0FFFFFFF8F8F0FFFFFFFFFFFFE8F8F0F0F8E8F8F8F0C09078802818802818
          603018F8E0D0E0F0E8F8F8E8A87868782810883820602000A07060F8F8F0F8F0
          F0FFFFFFF8F0F8F8F0E8F8F0D8885840683010603018F8E8D8F8F0F0F0F8F8F0
          F0F8C08080582010582010682818582010682818682018702818702818A07058
          E0B0B0F8D8D0F8D8D0F8C0B8684830602008602808783820582010603018F8E8
          E8FFFFFFF8E0D8F8F8F0A87860682808803810703008682808783820F8C0B8F8
          F0F0FFFFFFFFFFFFB88878682808803808903810803808703008684830E0D0C0
          FFFFFFFFFFFFF8E8E8C080805818005818006020086020085820105820105818
          00682818A87860E8C098F8C0B8F8F8E8F8C0B890584858180068281878382060
          3018384040F8F8F0F8F0E0F8F8E8F8F8E8A87860703018783018803010803010
          883010883010803010803010FFFFFFFFFFFF7830108038188838108830089030
          10903810803810683010603018F8E0D0F8F8E8F8F8F0F8F8E8A0706058180070
          2010702008802818581800B88878F8F8E8F8F8E8F8F8E8F8F0E0783820582010
          A87868F8F8F0F8F8F0F8F8F0F0F8F0E0F0E8F8F0F8F8F0F0FFFFFFF0F8F8E8F8
          F0F0F8F0FFFFFFB88870782018802818603018A8B8B0F0F8F0F8F8F0D0B09070
          2010803010783018E8C098FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0E8A07058
          683018602008E0B0B0FFFFFFFFFFFFFFFFFFF8C0B87038186828087838187028
          10803018782808883818802810702008702008803820905848A0705870381878
          3820602000783820582010684830F8E0D8FFFFFFF8F0F0F8F8F0E09888682808
          783808803810703010783820C0A8A8FFFFFFF8F0F8FFFFFFE8C0987038188838
          10903810803808702808582818B0A088FFFFFFF8F0F8F8F0F8E0B0B070281870
          2010803018884018883820803818702808682008702808703008703008905848
          903820682808682808783818703010581800605848E0E8E8F8F8F0F8F8F0F8F8
          E8C09078683010783018783010803010803010803010803010803010FFFFFFFF
          FFFF703010803818883818883010883008883810803818703018583010E0B0B0
          F8F8F0F8F0E0F8F8F0D0B090582010703020803018702818683018D0B090F8F8
          E8F8F8E8F8F8E8F8E8D8684830683018582010F8D8D0F8F8E8F8F8F0F8F8E0C8
          B8C0E0B0B0E0B0B0E0E8E8F0F8F0E8F8F8FFFFFFFFFFFFA87868782018802818
          582818B88878F8F8F0F8F8E8F8E0D8783820682010905848F8F8F0F8E8E8FFFF
          FFFFFFFFFFFFFFFFFFFFF8F8F0B88878703018581800C09078FFFFFFE8F0F8FF
          FFFFF8E0D8703818581800683010602808682808601800783010883818802808
          803010883010702808682808682808602808684830684830B88878F8F0F0F8F0
          F0FFFFFFFFFFFFF8F8F0D0B090683010702808883820682810703020B88878F8
          F0F8FFFFFFFFFFFFF8F0E0783820783008803008883008803818682818C09078
          FFFFFFF8F0F8FFFFFFF8E0D87838206820186020086020006020006020007838
          10884018702808803810803818783008682808703008703810703818905848C0
          9078F8E0D0E0F0E8F8F8F0F8F8E8F8F8F0D0B090602008703010783010803010
          803010803010803010803010FFFFFFFFFFFF7830107830108030108030108830
          10803010803010783018682818B88878F8F8F0F8F8F0F8F8F0F8E8E0E0D0C0E0
          B0B0E0B0B0E8C098F8D8D0F8F0E0F8F8F0F8F8F0F8F8F0B0A088703018782818
          782010A07058F8F8F0F8F0E8FFFFFF788880301000682818B88878F8F0E8F8F8
          F0F8F8F0F8F8F0905848682810783018602008A07058F8F8E8F8F8F0F8F0F080
          6060602018B08070F8F8F0F8F0E8FFFFFFE8F8F0E0E8E8F8F8F0F8F8E8F8C0B8
          682818782018A05048FFFFFFF8F8F0FFFFFFF8F8F0D0B090B0A088B88878B888
          70B88878B88878C09078803820702810883018782010702010883820905848D0
          B090F8E8D8FFFFFFF0F8F0FFFFFFFFFFFFFFFFFFF8E8E0F8F8F0E09888602810
          783820783018682810783820905848F8F8F0FFFFFFFFFFFFF8F0E0A070587028
          10903818903010803008703008905848F8F8E8F8F8F0F8F8F0F8E8E8C0A8A8B0
          A088B88878B0A088C09078B88878C09078803820602000883820783818682810
          783820A07058E8C098F8C0B8F8F8F0FFFFFFF0E8E0FFFFFFF8F8F0F8F8E8F8F8
          F0C09078683010803820803010803010883010883010883010803010FFFFFFFF
          FFFF783010803010803010803010803010803010803018803018702818A07058
          F8F8E8F8F8F0FFFFFFFFFFFFFFFFFFF8F0F8F8F0E8F8F8F0F8F8F0FFFFFFF0F0
          E8F0E8E0B0A088603018682010983818802010883018E0B0B0F8F8F0FFFFFFE0
          D0C0783820581800C09078F8F8F0F8F8E8F8F8E8F8F8E0905848683010783010
          782810905848F8E8D8F8F8F0FFFFFF788880582010F8C0B8FFFFFFFFFFFFE8F8
          F0C8D0D8B0A088F8F8F0F8F8E8F8E0D0783820802818903820F8E8E0F8F8E8F0
          F8F8FFFFFFF8E8E8FFFFFFF8F8F0F8F8F0F8F8E8F8F8E8F8F8E0885840803820
          983818682010905848F8C0B8F8F8F0FFFFFFFFFFFFE0E8E8FFFFFFFFFFFFF8F8
          F0F8F8F0F8F8F0F8E8D8905848602008783020702818702818682818783820F8
          E8D8FFFFFFFFFFFFF8F8E8B88878601800782008802808883810803810803820
          F8E8D8F8F8E8F8F8F0FFFFFFFFFFFFF8F0F8F8F8F0F8F8F0F8F8E8F8F8E8F8F0
          D8A87860581800683018602008885840F8D8D0F8F8E8FFFFFFFFFFFFF8F0F0F8
          F0F0FFFFFFF8F8F0F8F8F0F8F8F0F8F8E8A87860581800702810803010883010
          883010883010883010883010FFFFFFFFFFFF8030108030108030108030108030
          10803010803010783018702818783820F8D8D0F8F8F0FFFFFFFFFFFFFFFFFFFF
          FFFFF8F8F0F8F8F0F8E8E8FFFFFFF8F0F0F0E8E0B0A088684830682818803018
          802818702008A07058F8F0E8FFFFFFF8F8F0C09078581800B0A088F8F8F0F8F8
          E8F8F8E8F8F0D8885840683018783010803018702010F8C0B8F8F8F0FFFFFF98
          98A0684830FFFFFFFFFFFFFFFFFFF8F0E8788880605848F8F8F0F8F8E8F8F8E8
          905848782018702018E0B0B0F8F8F0F0F8F8FFFFFFFFFFFFF0F8F0F0F8F0F0F8
          E8F8F8E0F8F8E0F8F8E0E09888682810682010682818C09078F8F8E8F8F8F0E0
          F0E8FFFFFFF8F0F0FFFFFFF8F8F0F8F0E0F8F0E0F8E8D8C09078783018782010
          903018802810983818802818782810F8C0B8F8F0E8FFFFFFF8F8F0E0B0B07030
          20803018803010884018682808603010E8C098F8F8E8F8F0E8F0F0E8FFFFFFFF
          FFFFF8F0E8F8F0E0F8F0E0F8F8E8F8F8E8B88878583010583010603018C09078
          F8F8E8F8F8F0F0E8E0FFFFFFF0F8F8FFFFFFFFFFFFF8E8E0F8F8F0F8F0E8C090
          78682818702810983818803010883010883010883010803010803010FFFFFFFF
          FFFF803010803010803010803010803010803010803010783018783020682818
          E0B0B0F8F8F0F8F0F0FFFFFFE0E8E8B0A088E8C098E09888E0B0B0E0D0C0FFFF
          FFFFFFFFF8F0E8E0B0B0905848601800783018803820583010D0B090F8F8F0F8
          F8F0F8D8D0684830B0A088F8F8F0F8F8F0F8F8F0F8E8D8603018703018803818
          883820601800C09078F8F8F0FFFFFFC8D0D8B0A088FFFFFFFFFFFFF8F8F0F8F8
          F0605848384040F8E0D0F8F8E8F8F8F0B08070682018702018C08878F8F8F0F0
          F8F0E0E8E8FFFFFFF0F0E8F8F8E8F8F8F0F8F8E8F8F8E8F8F8E0D0B090682010
          682010885840F8E8D8F8F8F0F0F8F0F0F8F8FFFFFFFFFFFFF8E0D8F8E0D8F8C0
          B8D0B090905848783018883820903018903018902810983818782008702008C0
          8878FFFFFFFFFFFFF8F8F0F8E0D8783820703018682008682008703010583010
          D0B090F8F8F0F8F8F0FFFFFFFFFFFFF0E8E0F8F8F0F8F8F0F8F0E0F8F8E0F8F0
          D8C09078783820603018603018F8E8D8F8F8E0F8F8F0F8F8F0F0F8F8E8F8F8D8
          E8E0F8E8E0E8C098C09078905848581800682810883820802810883010883010
          883010883010803010803010FFFFFFFFFFFF8030108030108030108030108030
          10803010803010783018783018602810B0A088F8F8F0F8F8F0FFFFFFA8B8B030
          3038582010582010603018684830A8B8B0F8F8F0F8F8F0F8F8F0E09888703018
          682808883820602808684830F8E8D8F8F8F0F8F8F0D0B090C0A8A8F8F0F0FFFF
          FFF8F8F0F8E0D0603018702810903820883018702008A07060F8F8F0F8F8F0F0
          F0E8F8E0D8FFFFFFF8F0E8FFFFFFF8D8D0582818603018E0B0B0F8F8E8F8F8F0
          D0B090582010702818A07058F8F8F0F8F8F0FFFFFFF8F0F0A070605828186030
          18603018803820A05048A05048883018883018682018E8C098F8F8E8E8F8F0F0
          F8F0F8F0E8C09078684830783820582818602008581800682008802810802808
          903010983818903018802810903820A87860FFFFFFFFFFFFFFFFFFF8F0E89058
          48683018703018803820783820581800A07058F8E8D8F8F8F0FFFFFFF0E8E078
          8880603018783820783820783820905848883820682818682818682818F8F0D8
          F8F8E8F8F8F0FFFFFFF0E8E09080906068686030186828186828186020187030
          20883820883820782808883010883010883010803010803010803010FFFFFFFF
          FFFF803010803010803010803010803010803010803010783018703018682818
          A87868F8F8E8F8F8F0FFFFFFC8B8C02820286020188038205820103010006058
          48F8E8E0F8F8F0F8F0E0F8F0D8A87860581800683010783820602808B88878F8
          F8F0F8F8E8F8F8F0F8E0D8F8F0F0FFFFFFF8E8E0E0D0C0783820702810903820
          802810803018885840F8F8E8F8F8F0FFFFFFFFFFFFFFFFFFF8F0E8FFFFFFB080
          70602018582010C09078F8F8F0F8F8E8F8D8D0683018783020783820F8F8E8F8
          F8F0FFFFFFF8F0F0B08070582818603018703020782818782018882810903018
          903018602008D0B090F8F8F0F8F8F0F8F8F0E0B0B05828185820106030186030
          18603018A87860A0705890382080301880281090382078281060180078301878
          3820E0E8E8F0F8F8FFFFFFFFFFFFA07060582818602810683018683018583010
          905848F8F8E0F8F8F0FFFFFFE0E8E88060605820107830207830207028187830
          20803820803018783020682818E09888F8F8F0F8F0E0F8F0E8E0B0B028202828
          2028603018582010783820A07058A05048682008601800983818883010883010
          883010803010803010803010FFFFFFFFFFFF8030108030108030108030108030
          10803010803010783018702810683018885840F8E8D8F8F8F0F8F8F0F8F0E880
          6060582010702818582010301000605848F8F0E8F8F8F0F8F8E8F8F8E8C09078
          602000682808703818603010684830F8E0D0F8F8F0FFFFFFFFFFFFF8F8F0FFFF
          FFF8E8E8E0B0B0682818782810903818802810883818703018F8D8D0F8F8F0F8
          F8F0FFFFFFFFFFFFF8F0E8F8E8E8803820782018602008A87860F8F8E8F8F8E8
          F8F0E0905848682818682818F8C0B8F8F8F0FFFFFFF8E8E0B888785820105818
          00682818682010782010882018782008883018682010B07868F8E8E0F8F8F0F8
          F0E8F8E0D8684830582818301000582010905848F8F0D8F8F0D8D0B090C08870
          683010703818885840783820783820603018E0E8E8F0F8F8FFFFFFFFFFFFB0A0
          88684830783820783820603018583010603018E0D0C0F8F8F0F8F8F0F8F0F0C0
          A8A8582010682018682018602008602008682008682008682008783018A05048
          F8F8E8F8F8F0F8F8F0F8E0D8684830603018582010301000A87868F8F0D8F8F8
          E8F8C0B8B08068782808803010883010803010803010803010803010FFFFFFFF
          FFFF803010803010803010803010803010803010803010783010703010703818
          603018F8E0D0F8F8E8F8F0E0F8F8F0D0B090E09888C08878D0B090B88878F8E8
          E0FFFFFFF8F8E8F8F8E8F8F8E0A07058703010883820682008803820581800B8
          8878F8F8F0F0E8E0FFFFFFF8F8F0FFFFFFFFFFFFD0B090581800803018883018
          802808803018682810D0B090F8F8E8F8F8E0F8F8F0F8F8F0F8F8F0D0B0908830
          18903018782018885840F8F8E8F8F8E8F8F8E8A87868582010602018D0B090F8
          F8F0F8F8F0FFFFFFF8E8E0C09078B88878D0B090C09078C09078E09888C08878
          E09888905848682818E8C098F8F8F0F8F8F0F8F8F0F8E0D8B0A088B0A088B0A0
          88F8F0D8F8F8E8F8F8E8F8F8E8E8C098603018885840F8D8D0F8E8D8F8E8D8F8
          E0D0F8F0F0FFFFFFF8F0F0FFFFFFF8F8F0E0D0C0F8E0D0F8E0D0F8E0D0B08068
          583010D0B090F8F8E8F8F8F0FFFFFFE0D0C0B88878C09078C09078C09078C090
          78C09078C09078E09888885840683018E8C098F8F8E8F8F8F0F8F8F0F8D8D0B0
          A088B88878B88878F8E8D8F8F8E8F8E8D8F8F8E0F8D8D0782810803010803010
          803010803010803010803010FFFFFFFFFFFF8030108030108830108830108030
          10803010803010783010783010803820603010B0A088F8F8E8F8F8E8F8F8E8F8
          F8F0F8F8F0F8F8E8F8F8E8F8F0E8F8F8F0F8F8F0F8F8F0F8F8E8F8E0D0905848
          702808983818803008782808903820703018E0D0C0F8F8F0F8F8F0F8F8F0FFFF
          FFF8F8F0B88878783020883018903018802808883818682808A87860F8F8E8F8
          F8E0F8F8F0F8F8F0F8F8F0A07058883018903018883018702818F8D8D0F8F8E8
          F8E8D8B0A088682818602008B08070F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8E09888582818603018D0B090F8
          F8F0F8F8F0FFFFFFF8F8F0F8F8E8F8F8E8F8F8F0F8F8E8F8F8E8F8F8E8B08070
          582818603018F8E8D8F8F8E8F8F8E8F8F8F0FFFFFFFFFFFFFFFFFFFFFFFFF8F8
          F0F8F8F0F8F8F0F8F8E8F8F0D8E09888603018B08068F8F8F0F8F8F0F8F8E8F8
          F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8B88878602008
          885840D0B090F8F0E0F8F8F0F8F0E8F8F8F0F8F8F0F8F8E8F8F0D8F8F8E0F8F8
          E8F8F8E0C09078703008783010803010803010803010883010883010FFFFFFFF
          FFFF803010803010883010883010803010803010803010803010783010783818
          581800B88870F8F8E8F8F8E8F8F8E8F8F8E8F8F8E0F8F8E0F8F8E8F8F8F0F8F8
          F0F8F8F0F8F0E0F8E0D0B0806870301070280890381088300888280898381870
          2008B08068F8F0D8F8F8F0F8F8F0F8F8F0F8F8F0C08078602008802818903818
          882810803010602000905848F8F8E0F8F8E8F8F8F0F8F8E8F8E0D09058488020
          10903018903018803820B0A088F8F8E0F8F8E8F8E0D0702010602008905848F8
          F8E0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E0F8F8E0F8F8E8F8F8E8
          F8F8E8E8C098783820602008905848B88878F8E8E0F8F0F0F8F8F0F8F0E8F8F8
          E8F8F8F0F8F8F0F8F0E0B88878684830582010603018F8D8D0F8F0E0F8F8F0F8
          F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8E8C098
          682818905848F8E8D8F8F8E8F8F8F0F8F8E8F8F8E8F8F8E0F8F8E0F8F8E0F8F8
          E0F8F8E0F8F8E0F8F8E0F8E0D0603018301000684830B0A088F8F8E0F8F8E0F8
          F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F0D8C09078803820581800783010803010
          803010883010883010883010FFFFFFFFFFFF8030188030108830108830108830
          10803010803010803010884018883820682808A05048D0B090D0B090E8C098D0
          B090E8C098E8C098D0B090D0B090D0B090B0A088B08070905848683018682808
          803008903810903010903010903018782008783820B0A088D0B090D0B090D0B0
          90E8C098A07058782818782008903818883010883818702808783820C09078D0
          B090D0B090B88878B88878783020882810903018903018783010905848D0B090
          D0B090D0B090883018803018783820E09888D0B090D0B090D0B090D0B090D0B0
          90A8B8B0A8B8B0A8B8B0D0B090D0B090D0B090C0907888382070281088382080
          3018A05048C08080E0B0B0F8D8D0F8E0D0F8C0B8C09078A07058703020702818
          702818682010C08870C09078E09888D0B090D0B090D0B090D0B090D0B090D0B0
          90D0B090D0B090E8C098E8C098E09888803820684830C09078E8C098E8C098D0
          B090D0B090D0B090D0B090D0B090D0B090D0B090D0B090D0B090C09078783820
          603018603010683018905848C08870E8C098F8E0D0E0D0C0E8C098B0A0889058
          48603010602808783818783010803010803010883010883010883010FFFFFFFF
          FFFF803018803018883010883010883010883010883010803010782808803818
          6820087028087838186028106830186830186030106028085830105828186030
          1858281858201058180070281088381890381890301090301090301090301088
          3010602808683018603018682818683018682818682010803018803010903818
          8030088838108838186828087838207838207838206030187838207020109030
          1898381890281078280858301058301060280870280888301880281060280860
          3018603018603018603018603018603018603018603018603018603018583010
          6830187838207828108028109028108020107820187820187020186820186020
          1868301870302070301870281088301890382070200888382080301880382070
          3020682818603018603018603018603018603018603018683018581800883820
          7028107028107838206028106030106030185830105830105830105830105830
          1060301060301068301078382068280880382080382068200870200870281080
          3820583010603018603018602008581800603010783818803818783010803010
          803010883010883010883010FFFFFFFFFFFF8030188030188830108830108830
          1088301088301088301080301098381888401880381878301870281078301878
          3820703810703810703018703018703020703020783820803820803818903818
          8830108028089030108828088028089038188038187838107030107028107830
          2070281078301890382090382090381878280878280888381878301070280868
          2810703018682810702810782810902810983818903010884018703818683010
          7030088028089838189838187838187038187830188028188028188030187830
          1878301878301870301078301870301078301088381890381898381898381898
          3818882018883018883018883820803820803820783018782810883018903018
          9838188828109030187820087820107028107830107830107030106830106830
          1068301068301070301080301890382080281088301888382070301068281068
          3018703010703010783010783010783010783010803010803010802810782008
          8830189030189030189838188828087820087838207838207838207838207838
          20803820783010601800803010803010803010803010883010883010FFFFFFFF
          FFFF803018803018883010883010883010883010883010883010802808802808
          8028088028088030108030188030187828108038188840188838208038207828
          1870201878201880281888301888301080280888300888381080300878280890
          3818782808803008883818782808803018803018803018702008803010883810
          8030088030088838108030108030108838208830188830188028108838188828
          0890301088300880381060280870381078280898381888280890301068200878
          3818803018883018903018903018903018903018903018903018883018883018
          8028108028108828108828088828088828089030189030188830188030187830
          1078301078301080301090381880280888281090301090381888281088301888
          3820883810883810803810783810783810703818783818803818883818882810
          8028088828088830187830106828087838188838188830188830188830188830
          1888301888301888301880281090381898381890301088280890301098381898
          3818803018682010682008782810782810782810803010983818803010803010
          803010803010803010803010FFFFFFFFFFFF8030188030188030108830108830
          1088301088301088301098381888301090301090381890381890381888301880
          2808802808803008883010883018883018903018903018903018883018883010
          8830108838108038107830107830108038109038109038109838188828088838
          1888301890382078280878280880300890381088381088381088301080281088
          3018802808903018802808903820882810903810802808703008682808783810
          8030089838189030109838187830087838187830108030108830109028109028
          1090281090281090281090301890381888381880381080381878381078380880
          3810883818883018803818803810783810783810783810803810883810803008
          8830089038108030088030088030108030109030109030108830088030087830
          0870300878301080301088301090301090301898381898381888381878301088
          3820883010883010883010883010803010803010803010803010883818883818
          7828087828088838108838188830108028089030189030189030189838189838
          18882808802808883010883010883010803010803010803010803010FFFFFFFF
          FFFF803018803018803018803010883010883010883010883010883010802808
          9038189838188828108828108830189038189038109038108830108828109030
          1890301890301888301890301890381890381880381070280870300878381878
          3008903810802808903010903010903820782008883818803018883818783008
          8838108030088028089038189038188828109030189838188028089038188828
          0898381888381078381068280868280890381088280898381888280880301070
          3810783810783010883010903010903018903018903018903018902810903818
          8038107030087038106828086828087838108038108030107830087030087030
          0870300878380880381080380888381090381090381080300880381080381888
          3810903810903810903810803808783808783810783810803010903018902810
          9030108828089030109038208030107828088830109030108830108830108830
          1080301080301080301070280888401880381080381080381078300880381090
          3818882810903018903018902810902810983818983818882808903010883010
          803010803010803010803010FFFFFFFFFFFF}
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
        Caption = '021-0'
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
        Left = 58
        Top = 445
        Width = 602
        Height = 18
        Size.Values = (
          39.687500000000000000
          127.881944444444400000
          981.163194444444400000
          1327.326388888889000000)
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
        Width = 60
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1034.079861111111000000
          132.291666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nosso N'#250'mero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Caption = 'AT'#201' O VENCIMENTO PAG'#193'VEL EM QUALQUER BANCO'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Picture.Data = {
          07544269746D6170864F0000424D864F00000000000036000000280000009000
          00002F0000000100180000000000504F00000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
          FFFFE0F0E8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F0F0E8F8F8F0F8F8F0F8F8
          E8F8F8F0F8F8F0F8F8F0F8F8E8F0F0E0F0E8E0E8E8F0F8F8F0F8F8F0F8F8E8F8
          F0F0F8F8F0F8F8E8F8F0F0F8F8D8E8E0F0F8F8E0F0E8E0F0E8F0F8F8F0F8F8F0
          F8F8F0F8F8E0F0E8F0F8F8E8F8F0E8F8F0F0F8F8E0F0E8E0E8E8F0F8F8E0F0E8
          F0F8F8F0F8F8E0F0E8E8F0F0F0F8F8D8E8E0E8F8F0F0F8F8F0F8F8F0F8F8E8F8
          F0F0F8F8F0F8F8F0F8F8F0F8F8E0F0E8F0F8F8F0F8F8F0F8F8A8B8B0100810A8
          B8B0F0F8F8F0F8F8E8F8F0E0E8E8F0F8F8E8F8F8E0F0E8F0F8F8F0F8F8F0F8F8
          E0F0E8F0F8F8E8F8F0E8F8F8F0F8F8908090100810C8D0D8F0F8F8F0F8F8E0E8
          E8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8F0F8F8F0F8F8D8E8E0E0F0E8F0
          F8F8F0F8F8F0F8F8E0F0E8F0F8F8E0F0E8F0F8F8F0F8F8E0E8E8E8F8F0E8F0F0
          E8F8F0E8F8F0E8F8F8F0F8F8F0F8F8E8F8F0F0F8F8F0F8F8E8F8F0F0F8F8F0F8
          F8E0E8E8F0F8F8F0F8F8F0F8F8E8F8F8F0F8F8F0F8F8F0F8F8E8F8F0F0F8F8F0
          F8F8F0F8F8E8F8F8F0F8F8D8E8E0F0F8F8F0F8F8F0F8F8F0F8F8E8F8F0F0F8F8
          F0F8F8D8E8E0F0F8F8D8E8E0FFFFFFFFFFFFF0F8F8E0F0E8788880788880C8B8
          C0F0F8F8E0F0E8F0F8F8E0F0E8F0F8F8C8D0D8908090908090908090A8B8B0F0
          F8F8F0F8F8D8E8E0908090A8B8B0A8B8B0C8D0D8C8D0D8A8B8B0D8E8E0E8F8F0
          9898A0E0E8E8F0F8F89898A0606868A8B8B0E8F8F8F0F8F8D8E8E07888807888
          80C8D0D8F0F8F8F0F8F8E8F8F0F0F8F8F0F8F8A8B8B09898A0A8B8B0E0F0E8F0
          F8F8D8E8E09898A0A8B8B0C8D0D8F0F8F8A8B8B0A8B8B0E8F8F0C8B8C0908090
          F0F8F8C8B8C0A8B8B0A8B8B0100810606868908090C8B8C0F0F8F8C8D0D8A8B8
          B0E8F8F8F0F8F8E8F8F0A8B8B0A8B8B0A8B8B0E8F8F8F0F8F8F0F8F8F0F8F878
          8880100810788880788880C8D0D8F0F8F8F0F8F8A8B8B0788880A8B8B0E8F8F0
          F0F8F89898A0C8D0D8F0F8F8F0F8F8A8B8B0788880C8D0D8F0F8F8A8B8B07888
          80A8B8B0F0F8F8E8F8F0E8F8F0F0F8F8F0F8F8A8B8B09898A0A8B8B0908090D8
          E8E0E8F8F0D8E8E0788880908090F0F8F8F0F8F8F0F8F8E8F8F0F0F8F8E8F8F0
          C8D0D8A8B8B0E8F8F0F0F8F8F0F8F8908090788880A8B8B0E8F8F0F0F8F8D8E8
          E0788880606868D8E8E0E8F8F0E0F0E8C8D0D8908090A8B8B0F0F8F8FFFFFFFF
          FFFFC8D0D8303038000000282028100810908090F0F8F0E0E8E8F0F8F8F0F8F8
          606868100810282028282028100810384040C8D0D82820281008107888802820
          28504858788880000000A8B8B0C8D0D80000009898A0B0A08800000030303810
          0810788880C8D0D8384040303038384040303038C8D0D8F0F8F0F0F8F8F0F8F0
          788880282028605848303038606868E0F0E8303038303038303038605848E0E8
          E8384040384040FFFFFF606868605848E0F0E8605848384040A8B8B010081038
          4040282028303038C8D0D8788880000000D8E8E0E8F0F0605848100810384040
          384040A8B8B0F0F8F0FFFFFFFFFFFF788880000000605848303038282028E0E8
          E8606868303038384040282028908090C8D0D8100810788880FFFFFFA8B8B000
          0000000000A8B8B0908090100810605848282028788880FFFFFFE8F0F0FFFFFF
          C8D0D8282028282028384040000000908090A8B8B02820283840403030386058
          48E0E8E8F0F8F8F0F8F8E8F0F0FFFFFF605848100810D8E8E0FFFFFF78888028
          20283840402820289898A0D8E8E0303038282028282028303038FFFFFF788880
          100810303038100810606868FFFFFFFFFFFF605848000000A8B8B0F0E8E02820
          28303038FFFFFFFFFFFFFFFFFFF8F0F0384040282028F0E8E0F8F0F850485810
          0810788880282028605848E0E8E8303038605848A8B8B0100810C8D0D8C8D0D8
          1008109898A0384040384040E0E8E8788880788880B0A088100810A8B8B0E0E8
          E8100810788880F8F0F0FFFFFFF8F0F8C8D0D8B0A088C8D0D860584828202860
          5848282028C8D0D8C8D0D8806060A8B8B0605848384040FFFFFF605848384040
          FFFFFF605848303038A8B8B0282028788880F0E8E01008107888809080902820
          28FFFFFFA8B8B0000000A8B8B0C8D0D8788880A8B8B0FFFFFFFFFFFFFFFFFF90
          8090100810C8D0D8A8B8B0100810908090282028606868F8F0F8908090908090
          E0E8E8282028A8B8B0F8F0F0908090100810A8B8B0FFFFFF384040282028FFFF
          FF605848100810FFFFFFFFFFFFF8F0F0A8B8B01008109898A0F0E8E028202890
          8090606868100810E0E8E8C8D0D8605848F0E8E0FFFFFFFFFFFFF0F0E8F8F0F8
          282028000000A8B8B0FFFFFF100810384040FFFFFF3840403840407888800000
          00A8B8B0C8D0D8605848788880282028605848F8F0F8A8B8B0788880FFFFFFFF
          FFFF282028303038FFFFFFFFFFFF788880100810C8B8C0FFFFFFFFFFFFFFFFFF
          806060100810C0A8A8A8B8B0384040303038F0E8E0A8B8B06058486058482820
          28806060908090100810E0E8E8A8B8B0282028908090100810806060FFFFFFFF
          FFFFF0F0E8C0A8A8100810A8B8B0FFFFFF100810605848FFFFFFFFFFFFF0F0E8
          C0A8A8282028100810303038788880606868000000605848384040384040C0A8
          A8605848384040F8F0F8606868384040FFFFFF605848605848A8B8B0100810C8
          B8C0FFFFFF282028788880908090100810FFFFFF908090100810303038806060
          303038908090FFFFFFFFFFFFF8F0F8908090100810F0F0E8C8D0D82820286058
          48282028303038384040384040606868F0F0E80000009898A0FFFFFF9898A010
          0810F0F0E8F8F0F8282028788880F8F0F0788880100810F0F0E8FFFFFFF8F0F8
          C0A8A8000000C0A8A8F8F0F8100810A8B8B05048581008106058483030386058
          48C8D0D8F0F0E8FFFFFFFFFFFF908090282028606868605848E0E8E810081090
          8090F8F0F8605848282028806060100810C8D0D8F8F0F8FFFFFFF8F0F0282028
          282028605848605848282028FFFFFFFFFFFF282028384040FFFFFFF8F0F89080
          90100810A8B8B0FFFFFFFFFFFFFFFFFF78888010081028202810081028202890
          8090FFFFFF788880788880C8D0D8282028788880908090000000788880788880
          282028908090605848282028F8F0F0806060606868C0A8A81008109898A0C8B8
          C0000000908090FFFFFFFFFFFFFFFFFF788880282028C8D0D8908090C8B8C090
          8090100810A8B8B09898A0282028A8B8B0384040282028C8B8C0303038282028
          C8D0D8384040605848C0A8A8100810788880C8B8C0100810C0A8A87888800000
          00605848A8B8B00000009898A09898A0282028908090FFFFFFF8F0F0FFFFFF78
          88801008109080909898A0100810A8B8B0303038384040C8D0D8303038504858
          E0E8E8282028282028788880605848282028788880C8D0D8605848303038F8F0
          F0384040303038F8F0F8FFFFFFF8F0F8C8B8C0100810788880C8D0D810081098
          98A0788880100810C8D0D8908090100810C8D0D8FFFFFFF8F0F8F8F0F0504858
          384040C8D0D8384040E0E8E8303038504858E0E8E8384040504858A8B8B00000
          00908090C8B8C0303038C8B8C0303038384040E0E8E8504858282028FFFFFFFF
          FFFF303038100810E0E8E8FFFFFF605848282028E0E8E8F8F0F0FFFFFFF8F0F8
          504858303038E0E8E8F0F0F8504858282028F0F0F89080903030383840403030
          38A8B8B09898A0303038504858100810384040E0E8E8C8B8C028202828202828
          2028A8B8B0FFFFFF788880282028282028504858F0F0F8F0F0F8F0F0F8FFFFFF
          A8B8B0384040384040303038A8B8B0F8F0F8504858384040384040606868F0F0
          F8788880303038384040282028605848303038000000908090A8B8B028202860
          5848384040605848F0F0F89898A02820282820287888809898A0282028504858
          504858C8D0D8FFFFFFF8F0F8E0E8F0908090282028504858384040605848F8F0
          F8C8B8C0384040282028504858A8B8B0E0E8F030303830303830303828202810
          0810100810C8D0D8C8B8C0303038282028282028A8B8B0FFFFFFF8F0F8F0F0F8
          F0F0F8605848282028504858000000A8B8B0E0E8E83840403030383030387888
          80FFFFFFFFFFFFF0F0F8E0E8F0100810908090FFFFFF384040A8B8B0C8D0D828
          2028282028303038A8B8B0FFFFFF606868282028384040606868F0F0F8A8B8B0
          384040303038282028C8B8C0FFFFFFFFFFFF9080902820283840406068680000
          00504858F0F8F8F0F8F8E0E8F0F0F8F860686810081078888078888028202828
          2028E0E8F0F0F8F8E0E8E8C8D0D8E0E8E8F0F8F8E8F0F8E0E8E8F0F8F8E0E8E8
          F0F8F8F0F8F8F0F8F8E8F0F8C8B8C0F0F8F8F0F8F8F0F8F8F0F8F8E0E8E8C8D0
          D8E0E8F0F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E0E8E8D8E8E0F0F8F8E8
          F0F0F0F8F8C8B8C0C8D0D8F0F8F8F0F8F8E0E8F0E0E8F0E0E8F0C8B8C0F0F8F8
          E0E8E8D8E8E0F0F8F8F0F8F8E8F0F8F0F8F8D8E8E0E0E8F0F0F8F8D8E8E0F0F8
          F8F0F8F8E8F0F8F0F8F8C8D0D8D8E8E0E0E8F0F0F8F8F0F8F8F0F8F8F0F8F8F0
          F8F8D8E8E0E0E8F0C8D0D8E8F0F8F0F8F8F0F8F8C8D0D8C8D0D8E0E8F0F0F8F8
          F0F8F8E0E8F0F0F8F8E0E8E89898A0100810A8B8B0E8F0F0F0F8F8E8F0F8C8D0
          D8C8D0D8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8C8D0D8C8B8C010081090
          8090F0F8F8E8F0F8C8D0D8D8E8E0F0F8F8F0F8F8E0E8F0F0F8F8E8F0F8E0E8F0
          E8F0F8F0F8F8F0F8F8E0E8F0F0F8F8E0E8E8C8D0D8C8D0D8F0F8F8F0F8F8F0F8
          F8A8B8B0C8B8C0F0F8F8E8F0F8F0F8F8C8D0D8A8B8B0C8D0D8E8F0F8FFFFFFFF
          FFFFFFFFFF788880282028303038788880E0E8E8FFFFFFE0E8E8F0F8F8F0F8F8
          788880282028605848605848504858C8B8C0FFFFFFF0F8F8FFFFFFF0F8F8F0F8
          F8F0F8F8FFFFFFF0F8F8E0E8F0F0F8F8FFFFFFE8F8F8FFFFFFF0F8F8E0E8E8F0
          F8F8FFFFFFE0E8E8FFFFFFF0F8F8E0E8F0F0F8F8F0F8F8F0F8F8FFFFFFE8F0F0
          F0F0F8F0F8F8E0E8F0F0F8F8FFFFFFF0F8F8F0F8F8F0F8F8FFFFFFE0F0E8F0F8
          F8F0F8F8FFFFFFF0F8F8FFFFFFE0E8E8FFFFFFF0F8F8D8E8E0E0F0E8FFFFFFE0
          E8E8FFFFFFF0F8F8FFFFFFF0F8F8FFFFFFE8F8F8FFFFFFF0F8F8FFFFFFF0F8F8
          FFFFFFE8F0F0E8F0F0F0F8F8E8F0F8F0F8F8FFFFFFF0F8F8FFFFFFF0F8F8E8F0
          F0E0E8E8FFFFFFF0F8F8F0F8F8F0F8F8E8F0F8F0F8F8FFFFFFF0F8F8E8F0F078
          8880E8F0F0F0F8F8E0E8F0F0F8F8FFFFFFF0F8F8F0F8F8E0E8E8E0E8F0F0F8F8
          E0E8E8F0F8F8FFFFFFE0E8E8605848A8B8B0E8F0F0F0F8F8FFFFFFF0F8F8F0F8
          F8E0E8E8FFFFFFF0F8F8FFFFFFF0F8F8F0F8F8F0F8F8E8F0F8E0E8E8FFFFFFF0
          F8F8FFFFFFF0F8F8FFFFFFE0E8E8F0F8F8F0F8F8FFFFFFF0F8F8FFFFFFE0F0E8
          6068683840409898A0E0E8E8FFFFFFFFFFFFF0F0E8FFFFFFFFFFFFF0E8E0FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0FFFFFFFFFFFFF8F8F0F0F0E8FF
          FFFFFFFFFFF0E8E0F8F8F0FFFFFFF0F0E8F8F0E8FFFFFFF8F8F0FFFFFFFFFFFF
          F8F8F0FFFFFFFFFFFFF8F8F0FFFFFFFFFFFFF0F0E8F8F8F0FFFFFFFFFFFFFFFF
          FFFFFFFFF8F8F0F8F8F0FFFFFFF8F8F0FFFFFFFFFFFFFFFFFFFFFFFFF8F0F0FF
          FFFFF8F0F0FFFFFFF0F0E8F8F0E8FFFFFFFFFFFFF0E8E0FFFFFFFFFFFFF8F8F0
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F0F8F0E8F8F8F0FFFF
          FFF8F0E8FFFFFFF0F0E8F8F0F0F8F0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8
          F8F0FFFFFFF0E8E0FFFFFFF0F0E8FFFFFFFFFFFFFFFFFFF0E8E0F8F0F0FFFFFF
          FFFFFFF0F0E8F8F8F0F8F8F0F0E8E0FFFFFFF0E8E0FFFFFFF8F8F0F8F8F0F0F0
          E8FFFFFFF8F8F0FFFFFFFFFFFFF8F8F0F8F0F0FFFFFFF0E8E0F0F0E8F8F8F0FF
          FFFFFFFFFFF8F8F0F8F8F0F8F0E8F0F0E8FFFFFFFFFFFFF8F8F0F8F8F0FFFFFF
          F8F8F0F8F8F0FFFFFFFFFFFFF0F0E8FFFFFFF8F0F0F0E8E0FFFFFFFFFFFFF8F8
          F0F0E8E0FFFFFFF8F8F0F0F0E8FFFFFFF8F0F0A8B8B0F8E0D8FFFFFFFFFFFFFF
          FFFFF8F8F0F8F8F0F8F8F0F8E8D8F8F8F0F8F8E8F8F8F0F8F0E0F8F8F0F8F8F0
          F8F8F0F8F8F0F8E8E0F8F0E0F8F8F0F8F8F0F8E8D8F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8F0F8F8F0F8F8E8F8F8E8F8F0E0F8F8F0F8F8F0F8E8E0F8F8F0F8F8F0F8
          E8D8F8F8F0F8F8F0F8E8E0F8F0E0F8F8F0F8E8E0F8F0E8F8F8F0F8F8F0F8F8F0
          F8F8F0F8E0D8F8F8F0F8F8F0F8F0E8F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F0
          E8F8F8E8F8F8F0F8F8F0F8E8E0F8F8F0F8F8F0F8F8F0F8F8F0F8F0E0F8F0E8F8
          F8F0F8F0E0F8F8F0F8F8F0F8F8E8F8F8F0F8F0E0F8F8E8F8F8F0F8F8F0F8F8F0
          F8F8E8F8F8E8F8F8E8F8F0E0F8F8F0F8F8F0F8F8E8F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8F0F8F8F0F8F8F0F8F8F0F8F0E0F8
          F8E8F8F8F0F8E8D8F8E8D8F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8
          F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8E8F8E0D8F8F8E8F8F8F0F8E0D0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8
          F8E8F8F8F0F8F8F0F8F0E0F8F0E8F8F8F0F8F8F0F8F0E8F8F8F0F8F8F0F8F8E8
          F8F8F0F8F8F0F8F8F0F8F0E8FFFFFFFFFFFFB08070A87860B88878B88870B888
          70B08070C09078B07868A07060A87860B07868B08068B08070C08878B88870A0
          7058B88870B88878A87860A07058A87868C09078B88870B08068C09078A07058
          B08070B08068A87868B08070A87860C09078A07058C09078B08070A87868B080
          68B08068B88870A07060905848B08068C09078B88878C09078A87860B08070B8
          8870B08068A07058B08068B08068B07868B88878C08878885840C09078B08070
          A87868B88870B08068B08068C08878A07058B08070B88870A87868A07058B888
          70B88870A07060B07868A87868A87860B88870B08068B08068B08070B08068B8
          8870B08070B08070B08068B88870B08068B88870A87868A87860B08070905848
          B88878B88870A07058A07058B88878A87868B88878B07868B88870B080689058
          48B08070C09078A87868905848C09078C09078A07058B88878A07058A07060B8
          8878B08070B88870A07058A07060B88878B07868B07868C09078C09078A07060
          B88878A87860B08070B08068C08878B88870A07058C09078B88870A07058B888
          78B88870A87860A87868B07868B08070B07868B07868A87860C09078FFFFFFFF
          FFFF682008702810682810682810682008682808602008682810702810703018
          6820086018006828106020085818007030187838185818006020008038205818
          0058180060280868301060200080381860180070200878301860200060200860
          2808783820581800601800783820702810601800682810702810782810782810
          6018007020086018006828107838205818007028107028107030186020087030
          1058180068280878382068281058180078382060200858180070301860200870
          3010703010581800703010703010581800783818703018602008703018602000
          7838186020006020087838185818006828087030185818007030106820086820
          0860200078382068281060200870301868281058180078382068280868280868
          2808682008702810703010682008682810703018682008682810703018581800
          6020086828086020086828107838205818006020087030106020007030186828
          0860200080382058180060200070301860200870301058180068280868280860
          2008703018581800682818682008703018602008703018682810682008702810
          682008703018682810702810FFFFFFFFFFFF7820109038208838187028087830
          1080381878381078301080301880301880301878301878301870381070381070
          3810803808803808783808703008682808602808682808703008803810883810
          9030109030108830108038107838107038107038107838108830108830108030
          1078381078381880301890281090281090281090301080301870301078301070
          3010783018783018783018783810783810783810783810783810783818783018
          7830187830187830187830107838107838108038108038108038108038107838
          1078381078381078381078380878380878300878380878381080381080381080
          3810803018803018803010803010803810783810783810703810703010683010
          6830107030107830107830108030088030088838108038108030108030188030
          1880301878301878301878381078381078381078381078381078381078381878
          3810803810803810803810803810803810803810803810803810783810783810
          7838107838107838107838107838107838108038206820107830188038208038
          20803818702808883818803010803010803010803010883010883010FFFFFFFF
          FFFF883018903018883010783008803810803810783008783010783010783010
          7830187830187030106830106828087030088038088838107838087030086028
          0860280868280870300880301088301090301090301088301080301070301068
          3010683010703010883010882810803010783010703010783010902810902810
          9030189030188030187830187830187830187830187828187830107830107830
          1078301078301078301078301078301878301878301878301078301078300878
          3008803008803008803008803008803008783008783008783008803010803010
          8038108038108038108038108038108038108030188030188030188830108030
          1080381078381078381070301070301870301870301078381080381088381088
          3810803010803010803010803018803018803018803018783018783010703010
          7030087030087030107030107830107830108030108030108030108030108030
          1080301080301078301080301078301078301078301078301078301078301078
          3010703018682810783020783018783010803010782808883818883010883010
          883010883010883010883010FFFFFFFFFFFF8830188830188030108030088038
          1078381070300880381870280870281070281068281068281060280858301060
          2808782810802810782810702810682810682810682810702010782818782018
          7820187820187820187020186820186828186028106828087820088028087028
          1068281068281070281080201090281088281080201068281068281068281070
          2010702010782010702810702810702810702810702810702810702810702010
          7020107020107028107028107028087028087028107820107820107820107820
          1078201078201070201078201078201078201078201078201078201878201878
          2018702818702818782810782810782808782808702808702808682008682810
          6828106828107028107028087828087828087028087028087028107020107020
          1870201870201070201070281070280870280870280870280870281078281078
          2010782018782018782018782018782018782018782018702018782018702018
          7020187020187020187020187020187020187030186028107030186020086020
          00783010702808803010803010803010803010803010803010803010FFFFFFFF
          FFFF903018883018802808803010803810783008783010905848C08870C08878
          C08878C08878C08870C09078B88870C09078C08878C08080C08080C08080C080
          80C08878C08080C08080C08878C08878C08080C08080C08080C08080C08080B0
          8070B88878B88870C08870C08878B88878B88878B88878B88878C08870C08870
          C08870C08870B88870B88870B88870C08878C08078C08878C08870C08870B888
          70C09078C09078C09078C08878C08878C08878C08878C08878C08878B88870B8
          8878C08878C08878C08080C08878C08878C08878C08878C08878C08078C08078
          C08078C08078C08078C08078C08080C08078B88878B88878B88878C08870C088
          70C08870C08870C08870B88870B88870B88870B88870B88870B88870C08870B8
          8870B88870B88878B88878B88878C08878C08878C08878C08878C08878B88878
          C08870C08870C08878C08878C08878C08878C08878C08878C08878C08080C080
          80C08080C08080C08080C08080C08080C08080C08080C08080C08080C08080C0
          8878C09078C08878C09078C08870C08870C09078905848783010783010803010
          803010803010803010803010FFFFFFFFFFFF8830188830188830108838108038
          10702808803810A05048F8F8E0F8F8E8F8F8F0F8F8F0F8F8E8F8F8E8F8F8E0F8
          F8E8F8F8F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8
          E8F0F8E8E8F8F0F8F8E8F8F8F0F8F8E8F8F8F0F8F8E8F0F8E8F0F8E8F8F8E8F8
          F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8F0F8F8F0
          F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8F0F8F8F0FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8
          F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8
          F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8F0F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8
          F8F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F0FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F0F8F8E8F8F8E0F8F8E8F8F8E0F8F8
          E0F8F0D8A87860602000783010783010783010783010783010783010FFFFFFFF
          FFFF883010883018883010883810803810702808783818A05048F8F8E0F8F8E8
          F8F8E8F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8F0F8F0F0F8F0F0F8F0
          F0F8F0F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8
          F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8E8F8F0E8F8F0F0F8E8F8F8E8F8F8E8
          F8F8E8F8F8E8F0F8E8F0F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8
          E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8
          F8E8F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0
          F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8
          E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8
          F8E8F0F8E8F0F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8
          F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8
          F8F0F8F8F0F8F0E0F8F8E0F8F8E0F8F8E0F8F0D8C08870783810783810783010
          783810783010783010783010FFFFFFFFFFFF8830109038188830108830108838
          1078300878381068483090584890584890584890584890584890584890584890
          5848905848905848905848A05048A05048A05048A05048A05048905848885840
          885840885840905848A05048A05048A05048A05048A05048A05048A050489058
          48905848905848905848A05048A05048A05048885840885840905848A05048A0
          5048A05048A05048A05048905848905848905848905848905848A05048A05048
          A05048A05048A050489058489058489058489058489058489058489058489058
          4890584890584890584890584890584890584890584890584888584088584088
          5840905848905848905848905848905848A05048A05048A05048A05048A05048
          A05048A05048905848905848905848905848905848905848905848A05048A050
          48A05048A05048A05048905848905848905848905848905848A05048A05048A0
          5048A05048905848905848905848905848905848905848905848905848905848
          9058489058489058489058489058489058489058489058489058488858408858
          40905848783818682808783010783010803010803010803010783010FFFFFFFF
          FFFF883010883818883010883008883810803810703010703018582010582010
          5820102820285820105820105820105820105830105830106820107820108828
          1088280888280880280868200860200060200068280878280880280888280888
          2808902810882018882018782018582010582010582010602008802818882018
          7820186820106028106828108820188820189028108828108020107020186820
          1868201868201868201078201880201080201078201070201068201058201058
          2010602008602008602008602008682008682008682008682008702810702810
          6828106828106828106828106028106028106020086020186820186820187020
          1878201878201888201888201888201888201880201078201068201860201860
          2018682018702018782018882018882018882018882018882018702018682018
          6020186020186020186820187020187020106820086820086820086820086820
          0868201068281068281068200860200860200860200860200860200860200858
          2010582010582818603018603018583010683010703010883820783010803010
          803010803010803010803010FFFFFFFFFFFF8830188830108838108838108830
          08783008783818684830A07060806060A07060A07060A07060A07060A07060A0
          7060A87860885840885840783820702810803010883818883820A07058A87860
          A07058703818783810883810882808903010903018903018702010A07058A070
          58A07058A87860905848883018782010B08068A87860A0705878382078201090
          3018903818903820702810682818905848A07060A07058A07058883820682008
          783018A87860A87860A07058A07060A07060A07058A87860A07058A07058A070
          58A07058A07058A07058603018684830583010783820603018B88878B0A088E8
          C098E8C098E09888B88878684830682818582010803018802818883018883018
          903820601800803820A87860A07058A07060B080708838207020189038209030
          18802808903818783018A07058A07058A07060A07060A07060A07058A07058A8
          7860A07058A87860885840A87860A07058603018783820583010583010905848
          B88878B0A088E8C098E8C098B0A088B080686848306030185818006030187838
          20682810702810803018803010883010883010883010883010883010FFFFFFFF
          FFFF803018803010883810903810883008803008783818783820F8F8E8F8F0E8
          FFFFFFF8F0E8F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E0F8F8E0F8E8D8E098
          88703818581800905848F8F8E0F8F8E0F8F8E0E8C09870381860200090381888
          3010802818782818783820E8C098F8F0D8F8F8E8F8F8E8F8E8D8783018803018
          F8D8D0F8F8E0F8F8E0B0A088803820802808782808783810602808885840F8D8
          D0F8F8F0F8F8E8F8F8E8684830602808803820E8C098F8F0D8F8F8E8F8F8F0F8
          F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8A87868301000
          603018B0A088F8E0D0F8F8E8F8F8E8F8F8E0F8F8E0F8F8E0F8F0D8F8E0D0D0B0
          90905848582818682818682008803010783008783810885840E8C098F8F0D8F8
          F8F0F8E8E0E09888702818782810802808883008903818703010F8D8D0F8F8F0
          F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E0F8F8E8F8F8E8F8F8E8F8F8
          E0B08068301000603018B88878F8E0D0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8
          F8E8F8D8D0D0B090A07058603018582010783820883820803010883010883010
          883010883010883010883010FFFFFFFFFFFF8038188030108830109038109038
          10803010783010683018F8E0D0F8F8F0FFFFFFF8E8E0F8F0F0F8F8F0F8E8E0F8
          F8E8F8F8E8F8F8F0F8F0E0F8F8E8F8F8F0F8D8D0A07058581800B88878F8F0E0
          F8F8E8F8F0E0A07058581800803820782818803018682010783820F8D8D0F8F8
          E8F8F8E8F8F0D8E8C098883820702810D0B090F8F8E0F8F8E0E8C09880382080
          3010783008783818581800905848F8F8F0F8F8F0F8F8F0F8F8E8A07058603010
          703818E8C098F8F8E0F8F8E8F8F8F0FFFFFFF8F8F0F8F8F0FFFFFFFFFFFFF8F8
          F0F8F8F0FFFFFFF8F8F0B88878582010D0B090F8F8F0FFFFFFF8F0E8FFFFFFF8
          F8F0F8F8E0F8F8E0F8F8E8F8F8F0F8F0E8F8E0D8B08070783820683010803818
          682808783810581800B0A088F8F8E8F8F8F0F8F8F0F8D8D07838207830088838
          10903810883810602000D0B090F8F8F0F8F8F0F8F0E0F8F8F0F8F8E8F8F8E0F8
          F8E0F8F8E8F8F0E8F8F8F0F8E8E0F8F8F0B88878301000B0A088F8F8F0F8F8F0
          F8F8F0F8F8F0F8F0E8F8E8E0F8F0E8F8F8F0F8F8F0F8F0E8F8D8D0B888787838
          20682810803820883018883010903010903010903010903010883010FFFFFFFF
          FFFF803818803010803008883010903810883810783010603010D0B090F8F8F0
          F8F8F0FFFFFFF8F8F0F8F0E8F8E8E0F8F8E8F8F8F0F8F8F0F8F8F0F8F8F0F8E8
          E0F8F8F0F8E0D8684830684830F8D8D0F8F8F0F8F8F0E0B0B068483058201058
          2010602018581800603018E0B0B0F8F8E8F8F8E8F8F8E8E8C098782818601800
          B08068F8F8E0F8F8E0F8F0D8783820803010783008703810583010B0A088F8F8
          F0F8F8F0F8F0E0F8F8E8B0A088602808581800A87860F8F8E0F8F8F0F0F0E8F8
          F0F0FFFFFFF8E8E8FFFFFFFFFFFFF8F0F0FFFFFFFFFFFFF8F0F8E0B0B0A07060
          F8F0F0FFFFFFFFFFFFFFFFFFFFFFFFF8E8D8F8E0D0F8E0D0F8F0D8F8F8F0F8F8
          F0FFFFFFF8E8E0B08068683010703810682808783810581800A87860F8F8E8F8
          F8F0F8F0E8F8E8E0684830783810883810883810783808602000A87860F8F8F0
          FFFFFFE0F0E8F8F8F0F8F8E8F8F8E0F8F8E8F8F8F0F8F0F0FFFFFFF8F8F0FFFF
          FFE0B0B0905848FFFFFFF8F0E8F8F0F0F8F0F0F8F8F0F8F0F0F8E0D8F8E0D8FF
          FFFFF8E8E0F8F8F0F8F8F0F8F0E0C09078602810702008883820883010883010
          903010903010903010883010FFFFFFFFFFFF8038188030108830108830109038
          10883810783010602808B88870F8F8F0F8F0E0F8F8E8E0D0C068483078382078
          3820603018684830D0B090FFFFFFFFFFFFF8F0F0F8F0F0C0A8A8582010C08080
          F8F0F0F8F0F0FFFFFFD0B090B0A088E0B0B0E0B0B0D0B090E0B0B0F8F8E8F0F8
          F0F0F8E8F8F8E8E09888782018702010905848F8F8E8F8F8E8F8F8E088584078
          2810783810602000684830F8F8E8FFFFFFFFFFFFFFFFFFF8F8F0F8C0B8583010
          581800684830F8F8E8F8F8F0FFFFFFFFFFFFC0A8A8A87868B88878B88878C080
          80C08878C08080C08080A87868A87868F8E8E8F8F0F0FFFFFFFFFFFFB8887888
          5840603018603010905848B0A088F8E8E8FFFFFFF8F8F0F8F8E0783820602000
          783808783810602808905848F8F8F0FFFFFFF8F8F0F8F8F0A070587030087830
          08803008803808703810885840F8F0E0FFFFFFF8F0F0F8F8F0C0A8A8B88870B8
          8878B88878C08080C09078B88878B08070A07060A87868F8E8E8F8F0F0F8F8F0
          F8F0E8C09078684830582818603018684830B0A088F8F8F0F8F8E8F8F8F0F8E0
          D0885840682810803018803010883010883010883010883010883010FFFFFFFF
          FFFF783018803010883010883008903010903810783010602808885840F8F8E8
          F8F8E8F8F8F0F8F0E8885840683018783820803820783820603018D0B090F8F8
          F0F8F8F0F8F0E8F8F8F0684830684830F8D8D0FFFFFFFFFFFFF0E8E0FFFFFFF8
          F8F0FFFFFFF8F8F0FFFFFFFFFFFFE8F8F0F0F8E8F8F8F0C09078802818802818
          603018F8E0D0E0F0E8F8F8E8A87868782810883820602000A07060F8F8F0F8F0
          F0FFFFFFF8F0F8F8F0E8F8F0D8885840683010603018F8E8D8F8F0F0F0F8F8F0
          F0F8C08080582010582010682818582010682818682018702818702818A07058
          E0B0B0F8D8D0F8D8D0F8C0B8684830602008602808783820582010603018F8E8
          E8FFFFFFF8E0D8F8F8F0A87860682808803810703008682808783820F8C0B8F8
          F0F0FFFFFFFFFFFFB88878682808803808903810803808703008684830E0D0C0
          FFFFFFFFFFFFF8E8E8C080805818005818006020086020085820105820105818
          00682818A87860E8C098F8C0B8F8F8E8F8C0B890584858180068281878382060
          3018384040F8F8F0F8F0E0F8F8E8F8F8E8A87860703018783018803010803010
          883010883010803010803010FFFFFFFFFFFF7830108038188838108830089030
          10903810803810683010603018F8E0D0F8F8E8F8F8F0F8F8E8A0706058180070
          2010702008802818581800B88878F8F8E8F8F8E8F8F8E8F8F0E0783820582010
          A87868F8F8F0F8F8F0F8F8F0F0F8F0E0F0E8F8F0F8F8F0F0FFFFFFF0F8F8E8F8
          F0F0F8F0FFFFFFB88870782018802818603018A8B8B0F0F8F0F8F8F0D0B09070
          2010803010783018E8C098FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0E8A07058
          683018602008E0B0B0FFFFFFFFFFFFFFFFFFF8C0B87038186828087838187028
          10803018782808883818802810702008702008803820905848A0705870381878
          3820602000783820582010684830F8E0D8FFFFFFF8F0F0F8F8F0E09888682808
          783808803810703010783820C0A8A8FFFFFFF8F0F8FFFFFFE8C0987038188838
          10903810803808702808582818B0A088FFFFFFF8F0F8F8F0F8E0B0B070281870
          2010803018884018883820803818702808682008702808703008703008905848
          903820682808682808783818703010581800605848E0E8E8F8F8F0F8F8F0F8F8
          E8C09078683010783018783010803010803010803010803010803010FFFFFFFF
          FFFF703010803818883818883010883008883810803818703018583010E0B0B0
          F8F8F0F8F0E0F8F8F0D0B090582010703020803018702818683018D0B090F8F8
          E8F8F8E8F8F8E8F8E8D8684830683018582010F8D8D0F8F8E8F8F8F0F8F8E0C8
          B8C0E0B0B0E0B0B0E0E8E8F0F8F0E8F8F8FFFFFFFFFFFFA87868782018802818
          582818B88878F8F8F0F8F8E8F8E0D8783820682010905848F8F8F0F8E8E8FFFF
          FFFFFFFFFFFFFFFFFFFFF8F8F0B88878703018581800C09078FFFFFFE8F0F8FF
          FFFFF8E0D8703818581800683010602808682808601800783010883818802808
          803010883010702808682808682808602808684830684830B88878F8F0F0F8F0
          F0FFFFFFFFFFFFF8F8F0D0B090683010702808883820682810703020B88878F8
          F0F8FFFFFFFFFFFFF8F0E0783820783008803008883008803818682818C09078
          FFFFFFF8F0F8FFFFFFF8E0D87838206820186020086020006020006020007838
          10884018702808803810803818783008682808703008703810703818905848C0
          9078F8E0D0E0F0E8F8F8F0F8F8E8F8F8F0D0B090602008703010783010803010
          803010803010803010803010FFFFFFFFFFFF7830107830108030108030108830
          10803010803010783018682818B88878F8F8F0F8F8F0F8F8F0F8E8E0E0D0C0E0
          B0B0E0B0B0E8C098F8D8D0F8F0E0F8F8F0F8F8F0F8F8F0B0A088703018782818
          782010A07058F8F8F0F8F0E8FFFFFF788880301000682818B88878F8F0E8F8F8
          F0F8F8F0F8F8F0905848682810783018602008A07058F8F8E8F8F8F0F8F0F080
          6060602018B08070F8F8F0F8F0E8FFFFFFE8F8F0E0E8E8F8F8F0F8F8E8F8C0B8
          682818782018A05048FFFFFFF8F8F0FFFFFFF8F8F0D0B090B0A088B88878B888
          70B88878B88878C09078803820702810883018782010702010883820905848D0
          B090F8E8D8FFFFFFF0F8F0FFFFFFFFFFFFFFFFFFF8E8E0F8F8F0E09888602810
          783820783018682810783820905848F8F8F0FFFFFFFFFFFFF8F0E0A070587028
          10903818903010803008703008905848F8F8E8F8F8F0F8F8F0F8E8E8C0A8A8B0
          A088B88878B0A088C09078B88878C09078803820602000883820783818682810
          783820A07058E8C098F8C0B8F8F8F0FFFFFFF0E8E0FFFFFFF8F8F0F8F8E8F8F8
          F0C09078683010803820803010803010883010883010883010803010FFFFFFFF
          FFFF783010803010803010803010803010803010803018803018702818A07058
          F8F8E8F8F8F0FFFFFFFFFFFFFFFFFFF8F0F8F8F0E8F8F8F0F8F8F0FFFFFFF0F0
          E8F0E8E0B0A088603018682010983818802010883018E0B0B0F8F8F0FFFFFFE0
          D0C0783820581800C09078F8F8F0F8F8E8F8F8E8F8F8E0905848683010783010
          782810905848F8E8D8F8F8F0FFFFFF788880582010F8C0B8FFFFFFFFFFFFE8F8
          F0C8D0D8B0A088F8F8F0F8F8E8F8E0D0783820802818903820F8E8E0F8F8E8F0
          F8F8FFFFFFF8E8E8FFFFFFF8F8F0F8F8F0F8F8E8F8F8E8F8F8E0885840803820
          983818682010905848F8C0B8F8F8F0FFFFFFFFFFFFE0E8E8FFFFFFFFFFFFF8F8
          F0F8F8F0F8F8F0F8E8D8905848602008783020702818702818682818783820F8
          E8D8FFFFFFFFFFFFF8F8E8B88878601800782008802808883810803810803820
          F8E8D8F8F8E8F8F8F0FFFFFFFFFFFFF8F0F8F8F8F0F8F8F0F8F8E8F8F8E8F8F0
          D8A87860581800683018602008885840F8D8D0F8F8E8FFFFFFFFFFFFF8F0F0F8
          F0F0FFFFFFF8F8F0F8F8F0F8F8F0F8F8E8A87860581800702810803010883010
          883010883010883010883010FFFFFFFFFFFF8030108030108030108030108030
          10803010803010783018702818783820F8D8D0F8F8F0FFFFFFFFFFFFFFFFFFFF
          FFFFF8F8F0F8F8F0F8E8E8FFFFFFF8F0F0F0E8E0B0A088684830682818803018
          802818702008A07058F8F0E8FFFFFFF8F8F0C09078581800B0A088F8F8F0F8F8
          E8F8F8E8F8F0D8885840683018783010803018702010F8C0B8F8F8F0FFFFFF98
          98A0684830FFFFFFFFFFFFFFFFFFF8F0E8788880605848F8F8F0F8F8E8F8F8E8
          905848782018702018E0B0B0F8F8F0F0F8F8FFFFFFFFFFFFF0F8F0F0F8F0F0F8
          E8F8F8E0F8F8E0F8F8E0E09888682810682010682818C09078F8F8E8F8F8F0E0
          F0E8FFFFFFF8F0F0FFFFFFF8F8F0F8F0E0F8F0E0F8E8D8C09078783018782010
          903018802810983818802818782810F8C0B8F8F0E8FFFFFFF8F8F0E0B0B07030
          20803018803010884018682808603010E8C098F8F8E8F8F0E8F0F0E8FFFFFFFF
          FFFFF8F0E8F8F0E0F8F0E0F8F8E8F8F8E8B88878583010583010603018C09078
          F8F8E8F8F8F0F0E8E0FFFFFFF0F8F8FFFFFFFFFFFFF8E8E0F8F8F0F8F0E8C090
          78682818702810983818803010883010883010883010803010803010FFFFFFFF
          FFFF803010803010803010803010803010803010803010783018783020682818
          E0B0B0F8F8F0F8F0F0FFFFFFE0E8E8B0A088E8C098E09888E0B0B0E0D0C0FFFF
          FFFFFFFFF8F0E8E0B0B0905848601800783018803820583010D0B090F8F8F0F8
          F8F0F8D8D0684830B0A088F8F8F0F8F8F0F8F8F0F8E8D8603018703018803818
          883820601800C09078F8F8F0FFFFFFC8D0D8B0A088FFFFFFFFFFFFF8F8F0F8F8
          F0605848384040F8E0D0F8F8E8F8F8F0B08070682018702018C08878F8F8F0F0
          F8F0E0E8E8FFFFFFF0F0E8F8F8E8F8F8F0F8F8E8F8F8E8F8F8E0D0B090682010
          682010885840F8E8D8F8F8F0F0F8F0F0F8F8FFFFFFFFFFFFF8E0D8F8E0D8F8C0
          B8D0B090905848783018883820903018903018902810983818782008702008C0
          8878FFFFFFFFFFFFF8F8F0F8E0D8783820703018682008682008703010583010
          D0B090F8F8F0F8F8F0FFFFFFFFFFFFF0E8E0F8F8F0F8F8F0F8F0E0F8F8E0F8F0
          D8C09078783820603018603018F8E8D8F8F8E0F8F8F0F8F8F0F0F8F8E8F8F8D8
          E8E0F8E8E0E8C098C09078905848581800682810883820802810883010883010
          883010883010803010803010FFFFFFFFFFFF8030108030108030108030108030
          10803010803010783018783018602810B0A088F8F8F0F8F8F0FFFFFFA8B8B030
          3038582010582010603018684830A8B8B0F8F8F0F8F8F0F8F8F0E09888703018
          682808883820602808684830F8E8D8F8F8F0F8F8F0D0B090C0A8A8F8F0F0FFFF
          FFF8F8F0F8E0D0603018702810903820883018702008A07060F8F8F0F8F8F0F0
          F0E8F8E0D8FFFFFFF8F0E8FFFFFFF8D8D0582818603018E0B0B0F8F8E8F8F8F0
          D0B090582010702818A07058F8F8F0F8F8F0FFFFFFF8F0F0A070605828186030
          18603018803820A05048A05048883018883018682018E8C098F8F8E8E8F8F0F0
          F8F0F8F0E8C09078684830783820582818602008581800682008802810802808
          903010983818903018802810903820A87860FFFFFFFFFFFFFFFFFFF8F0E89058
          48683018703018803820783820581800A07058F8E8D8F8F8F0FFFFFFF0E8E078
          8880603018783820783820783820905848883820682818682818682818F8F0D8
          F8F8E8F8F8F0FFFFFFF0E8E09080906068686030186828186828186020187030
          20883820883820782808883010883010883010803010803010803010FFFFFFFF
          FFFF803010803010803010803010803010803010803010783018703018682818
          A87868F8F8E8F8F8F0FFFFFFC8B8C02820286020188038205820103010006058
          48F8E8E0F8F8F0F8F0E0F8F0D8A87860581800683010783820602808B88878F8
          F8F0F8F8E8F8F8F0F8E0D8F8F0F0FFFFFFF8E8E0E0D0C0783820702810903820
          802810803018885840F8F8E8F8F8F0FFFFFFFFFFFFFFFFFFF8F0E8FFFFFFB080
          70602018582010C09078F8F8F0F8F8E8F8D8D0683018783020783820F8F8E8F8
          F8F0FFFFFFF8F0F0B08070582818603018703020782818782018882810903018
          903018602008D0B090F8F8F0F8F8F0F8F8F0E0B0B05828185820106030186030
          18603018A87860A0705890382080301880281090382078281060180078301878
          3820E0E8E8F0F8F8FFFFFFFFFFFFA07060582818602810683018683018583010
          905848F8F8E0F8F8F0FFFFFFE0E8E88060605820107830207830207028187830
          20803820803018783020682818E09888F8F8F0F8F0E0F8F0E8E0B0B028202828
          2028603018582010783820A07058A05048682008601800983818883010883010
          883010803010803010803010FFFFFFFFFFFF8030108030108030108030108030
          10803010803010783018702810683018885840F8E8D8F8F8F0F8F8F0F8F0E880
          6060582010702818582010301000605848F8F0E8F8F8F0F8F8E8F8F8E8C09078
          602000682808703818603010684830F8E0D0F8F8F0FFFFFFFFFFFFF8F8F0FFFF
          FFF8E8E8E0B0B0682818782810903818802810883818703018F8D8D0F8F8F0F8
          F8F0FFFFFFFFFFFFF8F0E8F8E8E8803820782018602008A87860F8F8E8F8F8E8
          F8F0E0905848682818682818F8C0B8F8F8F0FFFFFFF8E8E0B888785820105818
          00682818682010782010882018782008883018682010B07868F8E8E0F8F8F0F8
          F0E8F8E0D8684830582818301000582010905848F8F0D8F8F0D8D0B090C08870
          683010703818885840783820783820603018E0E8E8F0F8F8FFFFFFFFFFFFB0A0
          88684830783820783820603018583010603018E0D0C0F8F8F0F8F8F0F8F0F0C0
          A8A8582010682018682018602008602008682008682008682008783018A05048
          F8F8E8F8F8F0F8F8F0F8E0D8684830603018582010301000A87868F8F0D8F8F8
          E8F8C0B8B08068782808803010883010803010803010803010803010FFFFFFFF
          FFFF803010803010803010803010803010803010803010783010703010703818
          603018F8E0D0F8F8E8F8F0E0F8F8F0D0B090E09888C08878D0B090B88878F8E8
          E0FFFFFFF8F8E8F8F8E8F8F8E0A07058703010883820682008803820581800B8
          8878F8F8F0F0E8E0FFFFFFF8F8F0FFFFFFFFFFFFD0B090581800803018883018
          802808803018682810D0B090F8F8E8F8F8E0F8F8F0F8F8F0F8F8F0D0B0908830
          18903018782018885840F8F8E8F8F8E8F8F8E8A87868582010602018D0B090F8
          F8F0F8F8F0FFFFFFF8E8E0C09078B88878D0B090C09078C09078E09888C08878
          E09888905848682818E8C098F8F8F0F8F8F0F8F8F0F8E0D8B0A088B0A088B0A0
          88F8F0D8F8F8E8F8F8E8F8F8E8E8C098603018885840F8D8D0F8E8D8F8E8D8F8
          E0D0F8F0F0FFFFFFF8F0F0FFFFFFF8F8F0E0D0C0F8E0D0F8E0D0F8E0D0B08068
          583010D0B090F8F8E8F8F8F0FFFFFFE0D0C0B88878C09078C09078C09078C090
          78C09078C09078E09888885840683018E8C098F8F8E8F8F8F0F8F8F0F8D8D0B0
          A088B88878B88878F8E8D8F8F8E8F8E8D8F8F8E0F8D8D0782810803010803010
          803010803010803010803010FFFFFFFFFFFF8030108030108830108830108030
          10803010803010783010783010803820603010B0A088F8F8E8F8F8E8F8F8E8F8
          F8F0F8F8F0F8F8E8F8F8E8F8F0E8F8F8F0F8F8F0F8F8F0F8F8E8F8E0D0905848
          702808983818803008782808903820703018E0D0C0F8F8F0F8F8F0F8F8F0FFFF
          FFF8F8F0B88878783020883018903018802808883818682808A87860F8F8E8F8
          F8E0F8F8F0F8F8F0F8F8F0A07058883018903018883018702818F8D8D0F8F8E8
          F8E8D8B0A088682818602008B08070F8F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8
          F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8E09888582818603018D0B090F8
          F8F0F8F8F0FFFFFFF8F8F0F8F8E8F8F8E8F8F8F0F8F8E8F8F8E8F8F8E8B08070
          582818603018F8E8D8F8F8E8F8F8E8F8F8F0FFFFFFFFFFFFFFFFFFFFFFFFF8F8
          F0F8F8F0F8F8F0F8F8E8F8F0D8E09888603018B08068F8F8F0F8F8F0F8F8E8F8
          F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8B88878602008
          885840D0B090F8F0E0F8F8F0F8F0E8F8F8F0F8F8F0F8F8E8F8F0D8F8F8E0F8F8
          E8F8F8E0C09078703008783010803010803010803010883010883010FFFFFFFF
          FFFF803010803010883010883010803010803010803010803010783010783818
          581800B88870F8F8E8F8F8E8F8F8E8F8F8E8F8F8E0F8F8E0F8F8E8F8F8F0F8F8
          F0F8F8F0F8F0E0F8E0D0B0806870301070280890381088300888280898381870
          2008B08068F8F0D8F8F8F0F8F8F0F8F8F0F8F8F0C08078602008802818903818
          882810803010602000905848F8F8E0F8F8E8F8F8F0F8F8E8F8E0D09058488020
          10903018903018803820B0A088F8F8E0F8F8E8F8E0D0702010602008905848F8
          F8E0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F8E0F8F8E0F8F8E8F8F8E8
          F8F8E8E8C098783820602008905848B88878F8E8E0F8F0F0F8F8F0F8F0E8F8F8
          E8F8F8F0F8F8F0F8F0E0B88878684830582010603018F8D8D0F8F0E0F8F8F0F8
          F8F0F8F8F0F8F8F0F8F8F0F8F8F0F8F8E8F8F8E8F8F8E8F8F8E8F8F8E8E8C098
          682818905848F8E8D8F8F8E8F8F8F0F8F8E8F8F8E8F8F8E0F8F8E0F8F8E0F8F8
          E0F8F8E0F8F8E0F8F8E0F8E0D0603018301000684830B0A088F8F8E0F8F8E0F8
          F8E8F8F8E8F8F8E8F8F8E8F8F8E8F8F0D8C09078803820581800783010803010
          803010883010883010883010FFFFFFFFFFFF8030188030108830108830108830
          10803010803010803010884018883820682808A05048D0B090D0B090E8C098D0
          B090E8C098E8C098D0B090D0B090D0B090B0A088B08070905848683018682808
          803008903810903010903010903018782008783820B0A088D0B090D0B090D0B0
          90E8C098A07058782818782008903818883010883818702808783820C09078D0
          B090D0B090B88878B88878783020882810903018903018783010905848D0B090
          D0B090D0B090883018803018783820E09888D0B090D0B090D0B090D0B090D0B0
          90A8B8B0A8B8B0A8B8B0D0B090D0B090D0B090C0907888382070281088382080
          3018A05048C08080E0B0B0F8D8D0F8E0D0F8C0B8C09078A07058703020702818
          702818682010C08870C09078E09888D0B090D0B090D0B090D0B090D0B090D0B0
          90D0B090D0B090E8C098E8C098E09888803820684830C09078E8C098E8C098D0
          B090D0B090D0B090D0B090D0B090D0B090D0B090D0B090D0B090C09078783820
          603018603010683018905848C08870E8C098F8E0D0E0D0C0E8C098B0A0889058
          48603010602808783818783010803010803010883010883010883010FFFFFFFF
          FFFF803018803018883010883010883010883010883010803010782808803818
          6820087028087838186028106830186830186030106028085830105828186030
          1858281858201058180070281088381890381890301090301090301090301088
          3010602808683018603018682818683018682818682010803018803010903818
          8030088838108838186828087838207838207838206030187838207020109030
          1898381890281078280858301058301060280870280888301880281060280860
          3018603018603018603018603018603018603018603018603018603018583010
          6830187838207828108028109028108020107820187820187020186820186020
          1868301870302070301870281088301890382070200888382080301880382070
          3020682818603018603018603018603018603018603018683018581800883820
          7028107028107838206028106030106030185830105830105830105830105830
          1060301060301068301078382068280880382080382068200870200870281080
          3820583010603018603018602008581800603010783818803818783010803010
          803010883010883010883010FFFFFFFFFFFF8030188030188830108830108830
          1088301088301088301080301098381888401880381878301870281078301878
          3820703810703810703018703018703020703020783820803820803818903818
          8830108028089030108828088028089038188038187838107030107028107830
          2070281078301890382090382090381878280878280888381878301070280868
          2810703018682810702810782810902810983818903010884018703818683010
          7030088028089838189838187838187038187830188028188028188030187830
          1878301878301870301078301870301078301088381890381898381898381898
          3818882018883018883018883820803820803820783018782810883018903018
          9838188828109030187820087820107028107830107830107030106830106830
          1068301068301070301080301890382080281088301888382070301068281068
          3018703010703010783010783010783010783010803010803010802810782008
          8830189030189030189838188828087820087838207838207838207838207838
          20803820783010601800803010803010803010803010883010883010FFFFFFFF
          FFFF803018803018883010883010883010883010883010883010802808802808
          8028088028088030108030188030187828108038188840188838208038207828
          1870201878201880281888301888301080280888300888381080300878280890
          3818782808803008883818782808803018803018803018702008803010883810
          8030088030088838108030108030108838208830188830188028108838188828
          0890301088300880381060280870381078280898381888280890301068200878
          3818803018883018903018903018903018903018903018903018883018883018
          8028108028108828108828088828088828089030189030188830188030187830
          1078301078301080301090381880280888281090301090381888281088301888
          3820883810883810803810783810783810703818783818803818883818882810
          8028088828088830187830106828087838188838188830188830188830188830
          1888301888301888301880281090381898381890301088280890301098381898
          3818803018682010682008782810782810782810803010983818803010803010
          803010803010803010803010FFFFFFFFFFFF8030188030188030108830108830
          1088301088301088301098381888301090301090381890381890381888301880
          2808802808803008883010883018883018903018903018903018883018883010
          8830108838108038107830107830108038109038109038109838188828088838
          1888301890382078280878280880300890381088381088381088301080281088
          3018802808903018802808903820882810903810802808703008682808783810
          8030089838189030109838187830087838187830108030108830109028109028
          1090281090281090281090301890381888381880381080381878381078380880
          3810883818883018803818803810783810783810783810803810883810803008
          8830089038108030088030088030108030109030109030108830088030087830
          0870300878301080301088301090301090301898381898381888381878301088
          3820883010883010883010883010803010803010803010803010883818883818
          7828087828088838108838188830108028089030189030189030189838189838
          18882808802808883010883010883010803010803010803010803010FFFFFFFF
          FFFF803018803018803018803010883010883010883010883010883010802808
          9038189838188828108828108830189038189038109038108830108828109030
          1890301890301888301890301890381890381880381070280870300878381878
          3008903810802808903010903010903820782008883818803018883818783008
          8838108030088028089038189038188828109030189838188028089038188828
          0898381888381078381068280868280890381088280898381888280880301070
          3810783810783010883010903010903018903018903018903018902810903818
          8038107030087038106828086828087838108038108030107830087030087030
          0870300878380880381080380888381090381090381080300880381080381888
          3810903810903810903810803808783808783810783810803010903018902810
          9030108828089030109038208030107828088830109030108830108830108830
          1080301080301080301070280888401880381080381080381078300880381090
          3818882810903018903018902810902810983818983818882808903010883010
          803010803010803010803010FFFFFFFFFFFF}
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
        Width = 160
        Height = 23
        Size.Values = (
          50.711805555555560000
          1514.739583333333000000
          26.458333333333330000
          352.777777777777900000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Ficha de Caixa'
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
        Top = 383
        Width = 160
        Height = 22
        Size.Values = (
          48.506944444444440000
          1512.534722222222000000
          844.461805555555700000
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
      object QRLabel2: TQRLabel
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
