object frmQckBoletoNossaCaixa: TfrmQckBoletoNossaCaixa
  Left = 125
  Top = 18
  Width = 988
  Height = 789
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
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
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
    object TitleBand1: TQRBand
      Left = 45
      Top = 23
      Width = 861
      Height = 1178
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
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
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          9.921875000000000000
          595.312500000000000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal5: TQRShape
        Left = 3
        Top = 155
        Width = 853
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          340.651041666667000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal4: TQRShape
        Left = 3
        Top = 124
        Width = 853
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          274.505208333333000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal3: TQRShape
        Left = 4
        Top = 94
        Width = 853
        Height = 4
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          9.921875000000000000
          9.921875000000000000
          208.359375000000000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal1: TQRShape
        Left = 4
        Top = 29
        Width = 853
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          9.921875000000000000
          62.838541666666700000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal2: TQRShape
        Left = 4
        Top = 66
        Width = 853
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          9.921875000000000000
          145.520833333333000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaVertical1: TQRShape
        Left = 191
        Top = 11
        Width = 12
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666700000
          420.026041666667000000
          23.151041666666700000
          26.458333333333300000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LinhaHorizontal7: TQRShape
        Left = 4
        Top = 324
        Width = 853
        Height = 4
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          9.921875000000000000
          9.921875000000000000
          714.375000000000000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNrBanco: TQRLabel
        Left = 202
        Top = 17
        Width = 57
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          445.381944444444500000
          37.482638888888900000
          125.677083333333300000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '151-1'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object LabelVencimento: TQRLabel
        Left = 672
        Top = 37
        Width = 48
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          81.579861111111110000
          105.833333333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Vencimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LinhaVertical2: TQRShape
        Left = 281
        Top = 11
        Width = 11
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666700000
          618.463541666667000000
          23.151041666666700000
          23.151041666666700000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelLocalPagamento: TQRLabel
        Left = 5
        Top = 37
        Width = 82
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          81.579861111111110000
          180.798611111111100000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Local de Pagamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelCedente: TQRLabel
        Left = 5
        Top = 70
        Width = 49
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          154.340277777777800000
          108.038194444444400000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Benefici'#225'rio'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelNomeCedente: TQRLabel
        Left = 57
        Top = 73
        Width = 603
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          125.677083333333300000
          160.954861111111100000
          1329.531250000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object LabelAgenciaCodigoCedente: TQRLabel
        Left = 672
        Top = 70
        Width = 89
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          154.340277777777800000
          196.232638888888900000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Ag'#234'ncia/C'#243'd. Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelDataDocumento: TQRLabel
        Left = 5
        Top = 98
        Width = 78
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          11.024305555555560000
          216.076388888888900000
          171.979166666666700000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Data do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelNrDocumento: TQRLabel
        Left = 145
        Top = 98
        Width = 70
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          319.704861111111100000
          216.076388888888900000
          154.340277777777800000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'N'#186' do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelEspecieDoc: TQRLabel
        Left = 335
        Top = 98
        Width = 54
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          738.628472222222200000
          216.076388888888900000
          119.062500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Esp'#233'cie Doc.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelAceite: TQRLabel
        Left = 415
        Top = 98
        Width = 26
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          915.017361111111100000
          216.076388888888900000
          57.326388888888890000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Aceite'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelDataProcessamento: TQRLabel
        Left = 475
        Top = 98
        Width = 96
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1047.309027777778000000
          216.076388888888900000
          211.666666666666700000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Data do Processamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelNossoNumero: TQRLabel
        Left = 672
        Top = 98
        Width = 84
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          216.076388888888900000
          185.208333333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Cart./ Nosso N'#250'mero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelUsoBanco: TQRLabel
        Left = 5
        Top = 127
        Width = 56
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          280.017361111111100000
          123.472222222222200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Uso do Banco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelCarteira: TQRLabel
        Left = 169
        Top = 127
        Width = 20
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          372.621527777777800000
          280.017361111111100000
          44.097222222222220000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Cart.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelEspecie: TQRLabel
        Left = 227
        Top = 127
        Width = 44
        Height = 11
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.253472222222220000
          500.503472222222200000
          280.017361111111100000
          97.013888888888890000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Esp Moeda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelReal: TQRLabel
        Left = 230
        Top = 137
        Width = 75
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          506.015625000000000000
          300.963541666667000000
          165.364583333333000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'R$'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object LabelQuantidade: TQRLabel
        Left = 317
        Top = 127
        Width = 46
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          698.940972222222200000
          280.017361111111100000
          101.423611111111100000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Quantidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelValor: TQRLabel
        Left = 589
        Top = 127
        Width = 41
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1298.663194444444000000
          280.017361111111100000
          90.399305555555560000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Vr. Moeda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelX: TQRLabel
        Left = 576
        Top = 127
        Width = 10
        Height = 19
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          41.892361111111110000
          1270.000000000000000000
          280.017361111111100000
          22.048611111111110000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'x'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 9
      end
      object LabelValorDocumento: TQRLabel
        Left = 672
        Top = 127
        Width = 94
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          280.017361111111100000
          207.256944444444400000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(=) Valor do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel1: TQRLabel
        Left = 5
        Top = 156
        Width = 43
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          343.958333333333300000
          94.809027777777780000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Instru'#231#245'es'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelDesconto: TQRLabel
        Left = 672
        Top = 157
        Width = 95
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          346.163194444444400000
          209.461805555555600000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(-) Desconto/Abatimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelMoraMulta: TQRLabel
        Left = 672
        Top = 205
        Width = 55
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          451.996527777777800000
          121.267361111111100000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(+) Mora/Multa'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelValorCobrado: TQRLabel
        Left = 672
        Top = 252
        Width = 71
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          555.625000000000000000
          156.545138888888900000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(=) Valor Cobrado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelSacado: TQRLabel
        Left = 7
        Top = 273
        Width = 38
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          15.434027777777780000
          601.927083333333300000
          83.784722222222220000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Pagador:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelSacadorAvalista: TQRLabel
        Left = 1
        Top = 313
        Width = 74
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          26.458333333333330000
          2.204861111111111000
          690.121527777777800000
          163.159722222222200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Sacador/Avalista:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object LabelCodigoBaixa: TQRLabel
        Left = 683
        Top = 312
        Width = 74
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1505.920138888889000000
          687.916666666666700000
          163.159722222222200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'C'#243'digo de Baixa'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 6
      end
      object LabelAutenticacaoMecanica: TQRLabel
        Left = 707
        Top = 328
        Width = 53
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          26.458333333333330000
          1558.836805555556000000
          723.194444444444400000
          116.857638888888900000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Autentica'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRShape2: TQRShape
        Left = 668
        Top = 202
        Width = 189
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          446.484375000000000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 668
        Top = 222
        Width = 189
        Height = 6
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          13.229166666666700000
          1471.744791666670000000
          489.479166666667000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNomeTitular: TQRLabel
        Left = 60
        Top = 274
        Width = 372
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          132.291666666667000000
          605.234375000000000000
          820.208333333334000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object LabelEndereco: TQRLabel
        Left = 60
        Top = 288
        Width = 372
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          132.291666666667000000
          635.000000000000000000
          820.208333333334000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object LabelCidade: TQRLabel
        Left = 60
        Top = 300
        Width = 372
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          132.291666666667000000
          661.458333333333000000
          820.208333333334000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRShape1: TQRShape
        Left = 666
        Top = 34
        Width = 4
        Height = 236
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          519.244791666667000000
          1468.437500000000000000
          76.067708333333300000
          9.921875000000000000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelInformacao1: TQRLabel
        Left = 6
        Top = 51
        Width = 652
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          13.229166666666700000
          112.447916666667000000
          1438.671875000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 
          'PREFERENCIALMENTE NO BANCO NOSSA CAIXA S.A. OU NA REDE BANCARIA ' +
          'ATE O VENCIMENTO'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel2: TQRLabel
        Left = 227
        Top = 37
        Width = 292
        Height = 11
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.253472222222200000
          500.503472222222000000
          81.579861111111100000
          643.819444444444000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRShape4: TQRShape
        Left = 142
        Top = 96
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          314.192708333333000000
          211.666666666667000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 330
        Top = 96
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          727.604166666667000000
          211.666666666667000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape6: TQRShape
        Left = 412
        Top = 96
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          909.505208333333000000
          211.666666666667000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape8: TQRShape
        Left = 165
        Top = 126
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          363.802083333333000000
          277.812500000000000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 220
        Top = 126
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          486.171875000000000000
          277.812500000000000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape12: TQRShape
        Left = 579
        Top = 126
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          1276.614583333330000000
          277.812500000000000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape16: TQRShape
        Left = 668
        Top = 246
        Width = 187
        Height = 6
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          13.229166666666700000
          1471.744791666670000000
          542.395833333333000000
          413.411458333333000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape17: TQRShape
        Left = 312
        Top = 126
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          687.916666666667000000
          277.812500000000000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel40: TQRLabel
        Left = 9
        Top = 137
        Width = 146
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          19.843750000000000000
          300.963541666667000000
          320.807291666667000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRShape25: TQRShape
        Left = 468
        Top = 96
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          1031.875000000000000000
          211.666666666667000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel42: TQRLabel
        Left = 444
        Top = 107
        Width = 10
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888890000
          978.958333333333300000
          235.920138888888900000
          22.048611111111110000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel3: TQRLabel
        Left = 633
        Top = 1125
        Width = 180
        Height = 27
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          59.531250000000000000
          1395.677083333333000000
          2480.468750000000000000
          396.875000000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Ficha de Compensa'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRShape9: TQRShape
        Left = 3
        Top = 758
        Width = 853
        Height = 6
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          13.229166666666700000
          6.614583333333330000
          1670.182291666670000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRImage2: TQRImage
        Left = 7
        Top = 1
        Width = 114
        Height = 33
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          72.760416666666700000
          15.434027777777800000
          2.204861111111110000
          251.354166666667000000)
        AutoSize = True
        Picture.Data = {
          07544269746D6170DA1B0000424DDA1B00000000000036000000280000005100
          00001D0000000100180000000000A41B00000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFF7FAFCF7FAFC515458393C4020232776797DD0
          D3D626262A444347757478C3C2C58C8B8EEDECEF7C7C80E0E3E53E4145515458
          9EA1A4686B6F66696D2F3234CECECEF9F9F9FCFCFC5C5C5CBDBDBDF7F7F75054
          53848786ABB0AF292E2D535857939897999D9D7275792C2F33ACAFB35154583F
          4246D7DADE282B2D595959343434F6F6F6FBFBFBFEFEFEBEBEBE14161844474B
          4245499194984043471B1D20A4A7AB6A6F6FDFE4E35C6160B3B7B73C41407D82
          814D51512B2E32DADDE0F7FAFDE6E9EB2E3135494C502F3030E6E6E660606073
          7373B2B2B2FFFFFFDDDDDD5858582D2D2DD3D3D3D3D3D3FFFFFFFFFFFF00FFFF
          FFF7FAFCF7FAFC515458393C4020232776797DD0D3D626262A444347757478C3
          C2C58C8B8EEDECEF7C7C80E0E3E53E41455154589EA1A4686B6F66696D2F3234
          CECECEF9F9F9FCFCFC5C5C5CBDBDBDF7F7F7505453848786ABB0AF292E2D5358
          57939897999D9D7275792C2F33ACAFB35154583F4246D7DADE282B2D59595934
          3434F6F6F6FBFBFBFEFEFEBEBEBE14161844474B4245499194984043471B1D20
          A4A7AB6A6F6FDFE4E35C6160B3B7B73C41407D82814D51512B2E32DADDE0F7FA
          FDE6E9EB2E3135494C502F3030E6E6E6606060737373B2B2B2FFFFFFDDDDDD58
          58582D2D2DD3D3D3D3D3D3FFFFFFFFFFFF00FFFFFFFDFDFDFDFDFD4B4B4BCDCD
          CDD3D3D32A2A2AA0A0A0A4A4A4B9B9B9828282B5B5B5959595F8F8F8868686BA
          BABA4D4D4DF7F7F7E6E6E6646464F5F5F5B1B1B18D8D8DFCFCFCFBFBFB686868
          B9B9B9DCDCDC3B3B3B9A9A9A515151AFAFAFE0E0E03E3E3EF1F1F1FBFBFB6B6B
          6BB3B3B3F9F9F9818181949494454545E8E8E8343434FAFAFAFBFBFBF9F9F95E
          5E5EAFAFAFFCFCFCD7D7D7555555D4D4D46B6B6BAAAAAA7D7D7DF1F1F17B7B7B
          535353ACACAC6E6E6EF5F5F5767676E6E6E6FEFEFEF9F9F9D1D1D1FAFAFA5555
          55969696D5D5D5BCBCBC8F8F8FFAFAFABCBCBC838383C4C4C4F3F3F3F3F3F3FF
          FFFFFFFFFF00FFFFFFF6F6F6F6F6F6555555C2C2C2D1D1D1313131C8C8C84545
          457777777D7D7DBEBEBE9A9A9AF8F8F88181818C8C8C787878F9F9F9F0F0F06E
          6E6EF9F9F9E0E0E0787878F9F9F9FDFDFD666666C4C4C4858585AFAFAF8D8D8D
          454545D4D4D4EAEAEA282828CDCDCD4141413E3E3EE3E3E35B5B5B484848EBEB
          EB4949497E7E7E454545F6F6F6FCFCFCF4F4F4585858FEFEFEFAFAFAFDFDFDA6
          A6A6686868575757B4B4B47F7F7FE9E9E9BCBCBC434343F8F8F8999999737373
          565656E4E4E4FCFCFCF8F8F8F9F9F9E1E1E1343434A2A2A2F6F6F6F3F3F34444
          44606060383838C0C0C0FDFDFDF8F8F8F8F8F8FFFFFFFFFFFF00FFFFFFFBFBFB
          FBFBFB555555515151303030B6B6B6F5F5F5E4E4E48888888E8E8EB6B6B68585
          85EFEFEF7E7E7EBCBCBC454545EFEFEFF8F8F85B5B5BF3F3F3A4A4A48F8F8FFC
          FCFCFAFAFA676767CACACA676767D6D6D69393935C5C5C9D9D9DE2E2E2363636
          818181B4B4B4F0F0F0BABABA5B5B5BF0F0F0EDEDEDEFEFEFB3B3B3414141FEFE
          FEF7F7F7ECECEC686868FBFBFBF8F8F8FAFAFAF3F3F3D4D4D44C4C4CAAAAAA7E
          7E7EFFFFFF8181814F4F4FBBBBBBF1F1F1D7D7D7595959E9E9E9FAFAFAFBFBFB
          B2B2B23333338F8F8FF5F5F5F9F9F9FBFBFB787878FBFBFB424242E6E6E6FEFE
          FEFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFBFBFBFBFBFB4C4C4CD3D3D3BABABA
          535353EEEEEE7373735B5B5BD1D1D1B7B7B7767676515151ADADADF6F6F69090
          90585858CACACAAAAAAA696969606060E6E6E6F6F6F6FCFCFC6F6F6F848484A2
          A2A2DBDBDB8E8E8EDBDBDB6C6C6C5D5D5DC8C8C8C6C6C66060605F5F5FD5D5D5
          616161686868F1F1F19090906161619A9A9AF9F9F9FAFAFAF9F9F94F4F4FFAFA
          FAF6F6F6FCFCFCDFDFDF666666575757E7E7E7989898F3F3F37B7B7BDBDBDB78
          7878CBCBCB636363707070F8F8F8FBFBFBF1F1F12C2C2CD3D3D3FDFDFDFCFCFC
          FCFCFCFBFBFB909090BDBDBD414141FCFCFCFDFDFDFBFBFBFBFBFBFFFFFFFFFF
          FF00FFFFFFFCFCFCFCFCFC4E4E4E878787656565676767FAFAFAFEFEFEFEFEFE
          FEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF5D5D5D222222DFDFDFCACACA888888F9F9F9FD
          FDFDFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
          FEFEFEFEFEFEFEFEFEFBFBFBF7F7F78C8C8C5F5F5FA1A1A1939393F9F9F9FDFD
          FDFAFAFAFDFDFDF3F3F3FCFCFCFAFAFAFDFDFDFEFEFEFEFEFEFEFEFEFFFFFFFF
          FFFFFFFFFFFAFAFA4646468D8D8D929292DFDFDFFAFAFAFDFDFDBDBDBD2E2E2E
          838383FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFF5F5F5F5F5F5B9
          B9B9A0A0A0AEAEAEEDEDEDFBFBFBFCFCFCFEFEFEFEFEFEFEFEFEFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFC2C2C2B1B1B1FCFCFCE9E9E9D1D1D1FCFCFCFAFAFAFEFEFEFEFEFEFEFEFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFDFDFD
          F9F9F9F2F2F2B5B5B5898989B3B3B3F8F8F8FDFDFDFFFFFFF6F6F67E7E7EE1E1
          E1F8F8F8FCFCFCFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFAFAFAE4E4E498
          9898A2A2A2E8E8E8FCFCFCFAFAFAF1F1F19D9D9DE2E2E2FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFF8F8F8F8F8F8F8F8F8F9F9F9F7F7F7FBFBFBFD
          FDFDFBFBFBFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFBFBFBFAFAFAFBFB
          FBFDFDFDFEFEFEFBFBFBFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFAFAFAFCFCFCFBFBFBF4F4F4FBFBFB
          F6F6F6FBFBFBFDFDFDFDFDFDFEFEFEF0F0F0FEFEFEF8F8F8FEFEFEFEFEFEFEFE
          FEFEFEFEFFFFFFFFFFFFFFFFFFFCFCFCFCFCFCF8F8F8F6F6F6FCFCFCFDFDFDFE
          FEFEFBFBFBF7F7F7FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFF0F0F0F0F0F0FDFDFDFCFCFCFFFFFFFCFCFCFCFCFCFEFEFEFEFEFEFEFEFEFE
          FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFDFDFDFBFBFBF7F7F7FBFBFBFCFCFCFDFDFDFBFBFBFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
          FEFEFEFEFEFCFCFCFBFBFBF9F9F9FEFEFEFEFEFEF8F8F8F7F7F7F9F9F9FCFCFC
          FDFDFDFCFCFCFCFCFCFBFBFBFCFCFCFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFF
          FFFDFDFDF9F9F9FDFDFDFBFBFBFDFDFDFDFDFDFEFEFEFAFAFAFCFCFCFBFBFBFD
          FDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF7F7ED37F7ED3FFEDFDE9F9
          F8F0FBF0FFFEF0E7E8EEBDD7F0EEF9F5FBFAF0FBF4FBFBF5FCFCFEFCFCFCF7FF
          FBF7F9F1FEFBFDF1FBFBE6FCF1FEF5FBF7E8FDD7FBFDE9FFFDF1FAF1FBECFAFC
          EDFCE6F9FEE8F9FBF3EFFEF5ECFEEBF9FBF3FDEBFDF4EEFFE7FEE1FFFAF8FFF6
          FCFEF5FEFDF8FDFFFEFCFFFFF2FFFEF6FBF6E5EFFDBFE0F1F1BEC0F5D0DFF5EE
          FCE4EBFDE1F4FDE5FFE9FFFFDEFFFDFBE3FCFFE8EEF6FEFAF3FFF5FFFBEDFEEB
          F8FCF0FCFBFBF8FAFDF2FEFAFCFAF7FCF0FFF6E9F7F9F9F5FBFEE5FCF1FBFCF6
          FAF6FFFDE9FEF3EFFCF5FCE8FDF6ECFFECFEE5FAFBF6FBF7FEF7F5FFF7F5FFFF
          FFFFFFFFFF00FFFFFF6669B06669B0F6E9F9F3FDFDF6FDF9FFF7F2B7BEF52424
          B39F92E5FDF3FDFCF8F4F5FEEFF2FDF0F5FBECFCFEE9F2F6FEF3FEF4FEF4FFFC
          E8FEC3CCDFCEE2EDF7FDF5FFF8FEF5F6F6DBEAE9B3A1FAF1E1EFF9F7F3EFFBE4
          ECFCE2FAF0FBFFF6F9FDFDE3F3FEF8FFFFF6FCFCF5FDFDF7FDFCF9FFFFFCFFFF
          FCFDF8FDE5DCFDB1A8F44A3AD53525CA3A31B17664D6D8E3E3ECE6F8F9F1F9FF
          FFD8FFF6FEFCFBFAF9FEFAFEFEE5F6FDECF7F9FDFCF2FCFFF7FEFDFDF0F9FEEF
          FAFAF9F4FAF4F1F3FEF4FBF5F3F9CBF7FEE3FCF1FCF6FAEEEBFEE5F4EDFAFEF5
          FAFDFDE5F9FEF9FFFFF9FEFEF7FAFAF5FAFAF5FFFFFFFFFFFF00FFFFFF5B66B5
          5B66B5DBD2E2F8FBFBF4F7F7F6F2F86A79D72734C6504FB5F0F2FEF0F9EFDCEF
          FAA0A6DEB5ACE9F2F1FFEAFBEFEBFDF5F8FBFDEFE5FC5447B9433CC0CFD1F2EF
          F4ECF4F8FEACB6ED3013CE9682ECF1F7FBEAEDFDE9EBFFF7F7F8FFFFE7FFFFF2
          F4FAFBEFFAFAF0FDF6F5FEEFFBFEF1FFFEFBFFF9FFF6F9FFB5CBFB2A1BD9372A
          D87985CBBDC7DF9886D05F44C3D4DCEAECFEF7DCEDFBE9F3FAF9E9FBFDF9F1FC
          FDE9FEFCFEFCF2FDFCF5FFFDFCFDFCF8FDF9F7FBDFE2F1989BC6E1F4F5DDEDF7
          BDB4EAE6E8F2EEEFF0F2F0FDE7EAFFF1F6F9FEFEEAFFFEF3F9F9FBFAF9FAFBF9
          F2FFFFF1FFFFF1FFFFFFFFFFFF00FFFFFF7280D37280D39F9DBCFCFAFBFAF8FF
          DFE3FF2A40C65473D53F48B1B6BCE6DAEEF68D9FE22323AF4C3DCC7962DAD0F1
          E0C6E0E9F0FEEEDFE6F53B23D83121E15351B7DEE2F4ECF7FC7D7FE1281EBF38
          2BB79EA6CF9892EC423CC0919EBDF4FCEAF9F2FFC7C5F3BAC0ECE6F0FFEDFCF9
          F8FFF3FEFEFAFFF9FFF3FAFF7093C82C25C46B73C6E0F9E0EBFAE8F1F6FFDCC7
          E4BBB7E9BFDBEF3649A17175D9E9EDFAFFF4FFE1D8FFB4AAE8E6E6FBEAFDF7E0
          F5FC8175CD9377DBE1E5F58D90C3687BAF7973E53504EC5D41C9CBD2EBB5B0FB
          3D35BF9AA9C7F4FCECF9F3FED5D0FAC1BDEAF0F3FFF0FAFAF0FAFAFFFFFFFFFF
          FF00FFFFFF8492E58492E55F64A7F3F1FCF7F6FE9099F12237C3B2CCF3443BD9
          7465E76C75C47589E43244B5C5DAF57B6AC152629E8493C7A0A2D1DBE5FB6B71
          CF3334C56767C55C44C5D3E2EFA7C1DE5657D44F4FD34E52B94E59D61B21CC30
          31CA879BC0CEE1FC3E31D533279B8581D2EAF0FDF2FBFBFCFFF9FFFCFEF3F3FF
          5152DD442AD0E0D5F8FDFEEEFEFCF4FDFAF4FAFCE7C5BBE7645EDD303FC4302F
          C7736AC5EFEAF97678E3352FA7686BABCFEDFF86A7EB2825B45633D6867FCEDE
          F9FF8081E32A13E48B80D7B5A3D24D4AB96774DC282FD23233B999ABCCD1E4FB
          4138DB312AA89295E0E2F1FEE2F1FEFFFFFFFFFFFF00FFFFFF9AA4EB9AA4EB2E
          36ACE3E7FCE6EBFF4850D65660CFD0F1FF5351C6B1A2FB878FD53741CF1B1DBD
          BFD4F9D6E2F85649C69495E45531C4A19EE3D0F3F25766DE727CDFA499D76B5E
          B9D1F6EFB9D2F83739C0C6D0F04A54CA1B22DF6771FB5768B46E7ADE2B26D6B1
          9ECD7467B1B6B3DAF2F6FAFAFEFDFDFFFAF1EFFD3F2EE17762D2FBEBFCFFFBF7
          FBF8FBFEFDF3FEFEF2F3FAFA8B7CE02916E45C5EE2756AC862699A364BC36669
          C5817BC6545DE32D3FDE3E4ACCE6DEFB8478B690A1D5737AEE242CB695B3CCE7
          FBF2CEDFEE4E5CBA1C22D4757BEF5563A77281E50E14C78B87D96060B4929BD2
          929BD2FFFFFFFFFFFF00FFFFFFC0C3F8C0C3F8131AC2C0CEF0BEC9F81619C19E
          9CE4E0FBF7777CBB9390D4DEF7FD5C63D93218F27C73E3E5F1FD998BF7635FCE
          DCCBF15851A5A5BBE36E77EE4F5EC1E5F9F18F6ECF696EC2BDDCF73636C8CBD2
          F4C4C4E82E31C32234A89EA1E7453DBE343CB6F3EBFFF3ECF8BDB9D6F9F9FFFA
          FCFFFAFFFCECF1FC3842C7828FBAF7F8F6FCFCEEFDFEE9F6FBFAF1ECFBFBF9FF
          E5F0F87F75D92514CD91AAE68796CE1725AEA6ABDFE7E0F35052D91521DF6173
          C3F2FDEDE1E0F4625BC62D3AB05E7AC240528FC6D4D3EAFBEACFD8F54D4CC82F
          39A7A9A8E13732CD1C2EB5C4C2EBE8E1F2AAA6CBAAA6CBFFFFFFFFFFFF00FFFF
          FFD1D4FCD1D4FC0D12DB98AEDA6E7FB81F1BD4CDC9EEEEECFF8A74D97972B9E0
          FFF2BED5F14536D13E33A58076D65D62BC5A58C6E9FCE2C6C5E5391DE63B3FDA
          3E4CB3EEFCF1E4D2F76347C94341D42F2DC1B9B4D5EDF5F4BDC7EA4841C14E43
          BFBDBEEF686CC9FAFFE0F9FAE9FAFAF9F7F6FAFAFAFFF9FDFFE8F2FE2E4BBF7A
          93BDF2F2FFFDF8FDF0FBF1C8C5FC7863B1EFEBF2F4FDE7E5F5F5746ADC221AD3
          81A7E5787DD4B9B7D1F9FCD9C0CBE0343FD28891D1FAFBD3E6F2E48783EB2423
          C18087EB9793E16C52C2F3EEF1F2FCF5C8D2E84F40C76454C5BDC3F05360C9DF
          DFE5FFFBF6FFF5FFFFF5FFFFFFFFFFFFFF00FFFFFFEDDBFCEDDBFC2F33B85064
          E1372FD6522ECFF7EEECF2FCFA978FE56152D0EFFEEEF9F1FDD5DAF34338C841
          33CA453DA3A8A7C5F8FCFBEFF4FFA2A7E13337B13438C3D1D2FFF2F2FCE9E5F3
          776ECF271AD58C84D2F3F9F7EFFEF0D7E5F65450B75350CDCBD3FFFCFCFCFBFB
          FBFDFDFDFDFDFDFFFFFFFFFFFFF4F8FF545ACA727EB8F2F8F6FBE5FBFBFDF6AB
          BBED1A22BE989AEDFAF6FEFDF5F1E7DEF4655FCC302BB9A9B0DBF0FCF8FAFDE9
          FCFAEBFBF1F6F6EDF6FBF5FFEBEAFA7A6ECF423AA18990CB9CA3EC4938E3AFAF
          EBF1FDF9EAFDF6D0D3F34C3FBF5856C8C5D4FBF5F9FBFDFDFDFCFCFCFCFCFCFF
          FFFFFFFFFF00FFFFFFF5EEFDF5EEFD404AC41D2ECA2929BE9081D7F9F8F3EEFF
          F79B9AE55448C5E7FCE8FCF7FEF2F9FEB1AFE3A4A0E3DAD8EAF3F4F9FDFFF2F2
          F9FCE8F0FFA0A9DD4752AED4DAF7FAFBFBF5F3FCE1DEF25352CB9B95CFF8FAF7
          F1FEEDEEF9FFCBC6E84E4CB16870B1F1F1F1FCFCFCFDFDFDFBFBFBFFFFFFFFFF
          FFF6FAFF7873E8494AB5DFF9E5FDFAFCF8FDF5C6CEF51F2ABD565FC0F8F7FBFE
          FDEEF1F0FCDBDDF58182CD4E3DACD3C8F3F5F3F9FDFDF5FEFFEFF9FFE6F7FFE8
          F2F6FFC9C4E69796D5DEECF88997C6372FB2948FC5F4FAF8F2FEF5EEF4FFBFB5
          E74645A5505C98E8EAF0FDFDFDFCFCFCFCFCFCFFFFFFFFFFFF00FFFFFFF2F8FA
          F2F8FA5060D21B24DA3239B8C0CDE6F4FDEFE9FFF5A0AAE84136BEDAEEE7FDF9
          F8FAFCEEEEF6FEECF5FFEFF5FCFEFFF4FAFBE8FAFEF4EDF8FBE9F8FFD8E6EFF6
          FDFEFBFDEEF9F9F1F1F7FDDBE5F2F8F4FEFCFDF4FBFEEDF4FAFBEDEAFED7D7ED
          6C759CD2D2D2FEFEFEFBFBFBFDFDFDFFFFFFFFFFFFFAFDFFAA9FF1281FB9B4D0
          DDEFFDEAFBFEF3E6E0F92C39C73140A3EDF0F6FFFEE3F5F9F5EAF2FDE7EEF9A2
          8BD0806EBAF9F2FDF5F5FDF5FBFCECFCF8EBFCEDF8FBF5F5F4FFF4F9FEE9F8F6
          E6F9F89B9ED3D6CEEBFCFBFBFAFEEFF2F9FBF0EBFED5D2E87278A5B7B8BFFFFF
          FFFCFCFCFCFCFCFFFFFFFFFFFF00FFFFFFEFF8F5EFF8F57784E01D1AE74A51C8
          E3F8F3F3FDEFE6FCFBA4B1EE3322C5D1DEECFAF8F9FDFEEBF5FDF7F4FAECF9FD
          EEFBFBF0FFFEF5FCFCF4F9FFF4F2FCF4F1FAFAFBFDF8FEFDF3FEFEF1FAFBF4F0
          FBF7F9F6FAFDFCF5FDFFEBFCFFF8F2F2FFF2F5FFEEF6FEF7F7F7FDFDFDFCFCFC
          FEFEFEFFFFFFFFFFFFFEFFFBE0D8F13A35D15873BCDFF9FBF8FEEBFAF1F7444E
          DF2835A8DADCF0FEFEEAF8FAF2F4FAFBF8FCF9F6F6FEF5F9FBF6FAFAF7F4FFC3
          BDF17F7ED0E0E5FFFCFDF0FBFBFBF6F9F5F6FCEBF3FCEEF1F5FBFBF2FFFDF8FA
          FDFEE9FBFEEEF6F7FBF4EFFFF3F2FEF8F8F9FBFBFBFDFDFDFDFDFDFFFFFFFFFF
          FF00FFFFFFF3F8FCF3F8FC9AA3FB241DDE6060D1EDFCFAF2F9F3EEFAFDB7BFF6
          2F16D0C5CAF1FDFBFDFFFFFBFEFFF6FFFFEEFFFFF5FFFDFEFFFAFFFFFDFEFFFF
          FAFFFFF7FFFFFAFFFEFFFFFDFFFFFEFEFFFFF9FFFFF3FFFDFDFFFEF9FFFFF1FF
          FFF4FDFEFDFAFEFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6
          F3F7F19EA5E9252BB9AAAEF3EFF9E7F6F8EDA8ADF1242AAFD4D1F2FAF9F4FDFE
          FDFEFEFFFFFFF6FDFFEDFDFFE8FCFFF4F2EFFFBEB3EF352BA5A39FEFFFFFFBFF
          FEFFFFFFFCFFFFF5FFFFF6FFFDFEFFF8FFFFFDFDFFFFEFFFFFEBFFFFF7FEFCFF
          FDFAFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFF6F7FEF6F7FEA4
          ABF01F1FAC48439FE1E1F3F7F7FBF3F5FFD2D8F92B11CAB9C0E8FDFEFDFFF9FF
          FEFEFAFFFFF8FFFEFDFFF9FFFFF8FFFFF9FFFFFEFFFFFFFCFFFEFEFFFBFFFFFA
          FFFFFAFFFFFDFFFFFFF9FFFEFDFFFEFEFFFFFAFFFFF6FEFFF5FCFFFAFBFFFDFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6FDEAE0F1FD8684DF4D40C0
          C5D1DDE5F2F9979EFF2225A3D7D1F3FBF8FBFCFAFFFEFBFFFFFEFBFEFCFFFFFF
          FCFFFEFBF7F3FCF0ECFB888EBD828BB2FFFBFFFFFDFFFFFDFFFFFEFFFFFEFFFF
          FEFFFFFEFEFFFFFDFFFFF8FFFFF4FFFFF6FFFFFCFFFDFFFFFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFF5F3FAF5F3FADBE7F5A4B6D67773ADC4B0DEFD
          FBF7FFFCFBEBEEFD462FC6B2C0D7FBFFEDFFF7FFFBFDFEFFFDFFFFFCFFFFFCFF
          FFFCFFFFFDFFFFFEFFFFFEFEFFFDFEFFFDFFFBFCFFFBFCFFFFFCFFFFFCFFFFFD
          FFFFFDFFFFFDFFFFFFFAFDFFF3FCFFF9FBFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFEFFFAFBF9E3F8F8E3EEFA9990CD3B31974853B72C38B8333697
          E6E3F7FAF8F6FAFAFFFCFBFFFFFEFCFEF7FFFFFCFFFFFFFBFFFEFFF3F4FEECFB
          F8E6F3EEFFFBFFFFFFFDFFFEFFFFFBFFFFF9FFFFFEFCFDFFF2FDFFF7FDFDFFFE
          FBFFFFFEFDFFFFFBFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFBF8F6FBF8F6E8FAFFE2FDF6ECECF6F8DDFBFCF6EAFDFDECF2F3EF9C8CD6B2
          C6C9FAFFDCFEF9FEF9FDFDFFFBFFFFFDFFFCFFFDFBFFFAFDFFF9FFFFFBFFFFFC
          FFFEFBFDFFFCF5FFFEF6FFFFFDFDFFFFFAFFFEFDFFFDFCFFFDFBFFFBFEFDFBFF
          F3FAFFFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFCF4FEF0
          FCF3F1FEE0EDEFF5B093D3545ACF4859C8989FD0F6F6F6FBFBF0F9FDFFFAFCFF
          FFFFFBFDFFFCFFFFF2FFFFEDFFFEF9FEF9FDF3F7F8EFF8F4FDFEFEFFFFF8FFFF
          FAFFFAFFFFF9FFFFFEFAFBFFE9FAFFF4FAF9FFFCF6FFFDFCFFFFFFFCFFFFFDFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00}
        Stretch = True
      end
      object QRShape13: TQRShape
        Left = 668
        Top = 177
        Width = 189
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          390.260416666667000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel4: TQRLabel
        Left = 671
        Top = 181
        Width = 79
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1479.461805555556000000
          399.079861111111100000
          174.184027777777800000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(-) Outras Dedu'#231#245'es'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel5: TQRLabel
        Left = 672
        Top = 228
        Width = 90
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          502.708333333333300000
          198.437500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(+) Outros Acr'#233'scimos'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel6: TQRLabel
        Left = 169
        Top = 137
        Width = 32
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          372.621527777777800000
          302.065972222222200000
          70.555555555555560000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel50: TQRLabel
        Left = 687
        Top = 48
        Width = 159
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1514.739583333333000000
          105.833333333333300000
          350.572916666666700000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel51: TQRLabel
        Left = 14
        Top = 107
        Width = 120
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          30.868055555555600000
          235.920138888889000000
          264.583333333333000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel56: TQRLabel
        Left = 159
        Top = 107
        Width = 164
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          350.572916666667000000
          235.920138888889000000
          361.597222222222000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel54: TQRLabel
        Left = 338
        Top = 107
        Width = 63
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          745.243055555556000000
          235.920138888889000000
          138.906250000000000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel57: TQRLabel
        Left = 478
        Top = 107
        Width = 171
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1053.923611111110000000
          235.920138888889000000
          377.031250000000000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel58: TQRLabel
        Left = 687
        Top = 79
        Width = 159
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          174.184027777778000000
          350.572916666667000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel59: TQRLabel
        Left = 687
        Top = 107
        Width = 159
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          235.920138888889000000
          350.572916666667000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel60: TQRLabel
        Left = 687
        Top = 136
        Width = 159
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          1515.684523809520000000
          300.491071428571000000
          351.517857142857000000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel61: TQRLabel
        Left = 52
        Top = 214
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          471.840277777777900000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel62: TQRLabel
        Left = 52
        Top = 227
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          500.503472222222300000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel63: TQRLabel
        Left = 52
        Top = 242
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          533.576388888888900000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel64: TQRLabel
        Left = 52
        Top = 255
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          562.239583333333200000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel65: TQRLabel
        Left = 52
        Top = 159
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          350.572916666666700000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = ' Texto de responsabilidade do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 6
      end
      object QRLabel66: TQRLabel
        Left = 763
        Top = 312
        Width = 68
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1682.309027777778000000
          687.916666666666700000
          149.930555555555600000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel68: TQRLabel
        Left = 32
        Top = 1116
        Width = 554
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          50.711805555555560000
          70.555555555555560000
          2460.625000000000000000
          1221.493055555556000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 13
      end
      object QRShape7: TQRShape
        Left = 3
        Top = 1053
        Width = 853
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          2321.718750000000000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape11: TQRShape
        Left = 3
        Top = 924
        Width = 853
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          2037.291666666670000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape14: TQRShape
        Left = 3
        Top = 894
        Width = 853
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          1971.145833333330000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape15: TQRShape
        Left = 3
        Top = 864
        Width = 853
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          1905.000000000000000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape18: TQRShape
        Left = 3
        Top = 795
        Width = 853
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          6.614583333333330000
          1752.864583333330000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape19: TQRShape
        Left = 3
        Top = 834
        Width = 853
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          1838.854166666670000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape20: TQRShape
        Left = 191
        Top = 777
        Width = 12
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666700000
          420.026041666667000000
          1713.177083333330000000
          26.458333333333300000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape21: TQRShape
        Left = 3
        Top = 1109
        Width = 853
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          2444.088541666670000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel7: TQRLabel
        Left = 202
        Top = 782
        Width = 57
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          445.381944444444500000
          1724.201388888889000000
          125.677083333333300000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '151-1'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object QRLabel8: TQRLabel
        Left = 672
        Top = 804
        Width = 48
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1772.708333333333000000
          105.833333333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Vencimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRShape22: TQRShape
        Left = 279
        Top = 777
        Width = 9
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666700000
          615.156250000000000000
          1713.177083333330000000
          19.843750000000000000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel9: TQRLabel
        Left = 5
        Top = 805
        Width = 82
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1774.913194444444000000
          180.798611111111100000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Local de Pagamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel11: TQRLabel
        Left = 57
        Top = 845
        Width = 603
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          125.677083333333300000
          1863.107638888889000000
          1329.531250000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel12: TQRLabel
        Left = 672
        Top = 836
        Width = 89
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1843.263888888889000000
          196.232638888888900000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Ag'#234'ncia/C'#243'd. Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel13: TQRLabel
        Left = 2
        Top = 866
        Width = 78
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          4.409722222222222000
          1909.409722222222000000
          171.979166666666700000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Data do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel14: TQRLabel
        Left = 145
        Top = 866
        Width = 70
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          319.704861111111100000
          1909.409722222222000000
          154.340277777777800000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'N'#186' do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel15: TQRLabel
        Left = 334
        Top = 866
        Width = 54
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          736.423611111111100000
          1909.409722222222000000
          119.062500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Esp'#233'cie Doc.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel16: TQRLabel
        Left = 418
        Top = 866
        Width = 26
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          921.631944444444400000
          1909.409722222222000000
          57.326388888888890000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Aceite'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel17: TQRLabel
        Left = 475
        Top = 866
        Width = 96
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1047.309027777778000000
          1909.409722222222000000
          211.666666666666700000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Data do Processamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel18: TQRLabel
        Left = 672
        Top = 866
        Width = 84
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          1909.409722222222000000
          185.208333333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Cart./ Nosso N'#250'mero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel19: TQRLabel
        Left = 2
        Top = 896
        Width = 56
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          4.409722222222222000
          1975.555555555556000000
          123.472222222222200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Uso do Banco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel20: TQRLabel
        Left = 169
        Top = 896
        Width = 20
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          372.621527777777800000
          1975.555555555556000000
          44.097222222222220000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Cart.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel21: TQRLabel
        Left = 227
        Top = 896
        Width = 44
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          500.503472222222200000
          1975.555555555556000000
          97.013888888888890000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Esp Moeda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel22: TQRLabel
        Left = 230
        Top = 907
        Width = 73
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          507.118055555556000000
          1999.809027777780000000
          160.954861111111000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'R$'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRLabel23: TQRLabel
        Left = 317
        Top = 896
        Width = 46
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          698.940972222222200000
          1975.555555555556000000
          101.423611111111100000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Quantidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel24: TQRLabel
        Left = 592
        Top = 896
        Width = 41
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1305.277777777778000000
          1975.555555555556000000
          90.399305555555560000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Vr. Moeda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel25: TQRLabel
        Left = 576
        Top = 899
        Width = 10
        Height = 22
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.506944444444440000
          1270.000000000000000000
          1982.170138888889000000
          22.048611111111110000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'x'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 9
      end
      object QRLabel26: TQRLabel
        Left = 672
        Top = 896
        Width = 94
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1481.666666666667000000
          1975.555555555556000000
          207.256944444444400000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(=) Valor do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel27: TQRLabel
        Left = 2
        Top = 926
        Width = 43
        Height = 11
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.253472222222220000
          4.409722222222222000
          2041.701388888889000000
          94.809027777777780000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Instru'#231#245'es'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel28: TQRLabel
        Left = 672
        Top = 926
        Width = 95
        Height = 11
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2041.701388888889000000
          209.461805555555600000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(-) Desconto/Abatimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel29: TQRLabel
        Left = 672
        Top = 974
        Width = 55
        Height = 11
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2147.534722222222000000
          121.267361111111100000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(+) Mora/Multa'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel30: TQRLabel
        Left = 672
        Top = 1018
        Width = 71
        Height = 11
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2244.548611111111000000
          156.545138888888900000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(=) Valor Cobrado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel31: TQRLabel
        Left = 7
        Top = 1057
        Width = 38
        Height = 11
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.253472222222220000
          15.434027777777780000
          2330.538194444444000000
          83.784722222222220000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Pagador:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel32: TQRLabel
        Left = 3
        Top = 1098
        Width = 74
        Height = 9
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          19.843750000000000000
          6.614583333333333000
          2420.937500000000000000
          163.159722222222200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Sacador/Avalista:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel33: TQRLabel
        Left = 675
        Top = 1095
        Width = 74
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          1488.281250000000000000
          2414.322916666667000000
          163.159722222222200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'C'#243'digo de Baixa'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 6
      end
      object QRLabel34: TQRLabel
        Left = 705
        Top = 1112
        Width = 53
        Height = 9
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          19.843750000000000000
          1554.427083333333000000
          2451.805555555556000000
          116.857638888888900000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Autentica'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRShape23: TQRShape
        Left = 668
        Top = 972
        Width = 189
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          2143.125000000000000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape24: TQRShape
        Left = 668
        Top = 992
        Width = 189
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          2186.119791666670000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel35: TQRLabel
        Left = 51
        Top = 1056
        Width = 372
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2328.333333333330000000
          820.208333333334000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel36: TQRLabel
        Left = 51
        Top = 1069
        Width = 372
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2358.098958333330000000
          820.208333333334000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel37: TQRLabel
        Left = 51
        Top = 1083
        Width = 372
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2387.864583333330000000
          820.208333333334000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRShape26: TQRShape
        Left = 666
        Top = 802
        Width = 3
        Height = 253
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          557.829861111111000000
          1468.437500000000000000
          1768.298611111110000000
          6.614583333333330000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel41: TQRLabel
        Left = 6
        Top = 819
        Width = 651
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666700000
          13.229166666666700000
          1805.781250000000000000
          1435.364583333330000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 
          'PREFERENCIALMENTE NO BANCO NOSSA CAIXA S.A. OU NA REDE BANCARIA ' +
          'ATE O VENCIMENTO'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel43: TQRLabel
        Left = 227
        Top = 804
        Width = 292
        Height = 9
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          19.843750000000000000
          499.401041666667000000
          1772.708333333330000000
          644.921875000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRShape27: TQRShape
        Left = 143
        Top = 865
        Width = 1
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          66.145833333333300000
          315.295138888889000000
          1907.204861111110000000
          2.204861111111110000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape29: TQRShape
        Left = 330
        Top = 865
        Width = 1
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          66.145833333333300000
          727.604166666667000000
          1907.204861111110000000
          2.204861111111110000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape30: TQRShape
        Left = 412
        Top = 865
        Width = 1
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          66.145833333333300000
          908.402777777778000000
          1907.204861111110000000
          2.204861111111110000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape31: TQRShape
        Left = 165
        Top = 894
        Width = 1
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          66.145833333333300000
          363.802083333333000000
          1971.145833333330000000
          2.204861111111110000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape32: TQRShape
        Left = 220
        Top = 894
        Width = 1
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          66.145833333333300000
          485.069444444444000000
          1971.145833333330000000
          2.204861111111110000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape33: TQRShape
        Left = 579
        Top = 894
        Width = 1
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          66.145833333333300000
          1276.614583333330000000
          1971.145833333330000000
          2.204861111111110000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape34: TQRShape
        Left = 668
        Top = 1017
        Width = 187
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          2242.343750000000000000
          413.411458333333000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape35: TQRShape
        Left = 312
        Top = 894
        Width = 1
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          66.145833333333300000
          687.916666666667000000
          1971.145833333330000000
          2.204861111111110000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel44: TQRLabel
        Left = 8
        Top = 907
        Width = 143
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          17.638888888888900000
          1999.809027777780000000
          315.295138888889000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRShape36: TQRShape
        Left = 468
        Top = 865
        Width = 1
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          66.145833333333300000
          1031.875000000000000000
          1907.204861111110000000
          2.204861111111110000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel45: TQRLabel
        Left = 446
        Top = 877
        Width = 10
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888890000
          983.368055555555600000
          1933.663194444444000000
          22.048611111111110000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRImage1: TQRImage
        Left = 7
        Top = 767
        Width = 114
        Height = 33
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          72.760416666666700000
          15.434027777777800000
          1691.128472222220000000
          251.354166666667000000)
        AutoSize = True
        Picture.Data = {
          07544269746D6170DA1B0000424DDA1B00000000000036000000280000005100
          00001D0000000100180000000000A41B00000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFF7FAFCF7FAFC515458393C4020232776797DD0
          D3D626262A444347757478C3C2C58C8B8EEDECEF7C7C80E0E3E53E4145515458
          9EA1A4686B6F66696D2F3234CECECEF9F9F9FCFCFC5C5C5CBDBDBDF7F7F75054
          53848786ABB0AF292E2D535857939897999D9D7275792C2F33ACAFB35154583F
          4246D7DADE282B2D595959343434F6F6F6FBFBFBFEFEFEBEBEBE14161844474B
          4245499194984043471B1D20A4A7AB6A6F6FDFE4E35C6160B3B7B73C41407D82
          814D51512B2E32DADDE0F7FAFDE6E9EB2E3135494C502F3030E6E6E660606073
          7373B2B2B2FFFFFFDDDDDD5858582D2D2DD3D3D3D3D3D3FFFFFFFFFFFF00FFFF
          FFF7FAFCF7FAFC515458393C4020232776797DD0D3D626262A444347757478C3
          C2C58C8B8EEDECEF7C7C80E0E3E53E41455154589EA1A4686B6F66696D2F3234
          CECECEF9F9F9FCFCFC5C5C5CBDBDBDF7F7F7505453848786ABB0AF292E2D5358
          57939897999D9D7275792C2F33ACAFB35154583F4246D7DADE282B2D59595934
          3434F6F6F6FBFBFBFEFEFEBEBEBE14161844474B4245499194984043471B1D20
          A4A7AB6A6F6FDFE4E35C6160B3B7B73C41407D82814D51512B2E32DADDE0F7FA
          FDE6E9EB2E3135494C502F3030E6E6E6606060737373B2B2B2FFFFFFDDDDDD58
          58582D2D2DD3D3D3D3D3D3FFFFFFFFFFFF00FFFFFFFDFDFDFDFDFD4B4B4BCDCD
          CDD3D3D32A2A2AA0A0A0A4A4A4B9B9B9828282B5B5B5959595F8F8F8868686BA
          BABA4D4D4DF7F7F7E6E6E6646464F5F5F5B1B1B18D8D8DFCFCFCFBFBFB686868
          B9B9B9DCDCDC3B3B3B9A9A9A515151AFAFAFE0E0E03E3E3EF1F1F1FBFBFB6B6B
          6BB3B3B3F9F9F9818181949494454545E8E8E8343434FAFAFAFBFBFBF9F9F95E
          5E5EAFAFAFFCFCFCD7D7D7555555D4D4D46B6B6BAAAAAA7D7D7DF1F1F17B7B7B
          535353ACACAC6E6E6EF5F5F5767676E6E6E6FEFEFEF9F9F9D1D1D1FAFAFA5555
          55969696D5D5D5BCBCBC8F8F8FFAFAFABCBCBC838383C4C4C4F3F3F3F3F3F3FF
          FFFFFFFFFF00FFFFFFF6F6F6F6F6F6555555C2C2C2D1D1D1313131C8C8C84545
          457777777D7D7DBEBEBE9A9A9AF8F8F88181818C8C8C787878F9F9F9F0F0F06E
          6E6EF9F9F9E0E0E0787878F9F9F9FDFDFD666666C4C4C4858585AFAFAF8D8D8D
          454545D4D4D4EAEAEA282828CDCDCD4141413E3E3EE3E3E35B5B5B484848EBEB
          EB4949497E7E7E454545F6F6F6FCFCFCF4F4F4585858FEFEFEFAFAFAFDFDFDA6
          A6A6686868575757B4B4B47F7F7FE9E9E9BCBCBC434343F8F8F8999999737373
          565656E4E4E4FCFCFCF8F8F8F9F9F9E1E1E1343434A2A2A2F6F6F6F3F3F34444
          44606060383838C0C0C0FDFDFDF8F8F8F8F8F8FFFFFFFFFFFF00FFFFFFFBFBFB
          FBFBFB555555515151303030B6B6B6F5F5F5E4E4E48888888E8E8EB6B6B68585
          85EFEFEF7E7E7EBCBCBC454545EFEFEFF8F8F85B5B5BF3F3F3A4A4A48F8F8FFC
          FCFCFAFAFA676767CACACA676767D6D6D69393935C5C5C9D9D9DE2E2E2363636
          818181B4B4B4F0F0F0BABABA5B5B5BF0F0F0EDEDEDEFEFEFB3B3B3414141FEFE
          FEF7F7F7ECECEC686868FBFBFBF8F8F8FAFAFAF3F3F3D4D4D44C4C4CAAAAAA7E
          7E7EFFFFFF8181814F4F4FBBBBBBF1F1F1D7D7D7595959E9E9E9FAFAFAFBFBFB
          B2B2B23333338F8F8FF5F5F5F9F9F9FBFBFB787878FBFBFB424242E6E6E6FEFE
          FEFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFBFBFBFBFBFB4C4C4CD3D3D3BABABA
          535353EEEEEE7373735B5B5BD1D1D1B7B7B7767676515151ADADADF6F6F69090
          90585858CACACAAAAAAA696969606060E6E6E6F6F6F6FCFCFC6F6F6F848484A2
          A2A2DBDBDB8E8E8EDBDBDB6C6C6C5D5D5DC8C8C8C6C6C66060605F5F5FD5D5D5
          616161686868F1F1F19090906161619A9A9AF9F9F9FAFAFAF9F9F94F4F4FFAFA
          FAF6F6F6FCFCFCDFDFDF666666575757E7E7E7989898F3F3F37B7B7BDBDBDB78
          7878CBCBCB636363707070F8F8F8FBFBFBF1F1F12C2C2CD3D3D3FDFDFDFCFCFC
          FCFCFCFBFBFB909090BDBDBD414141FCFCFCFDFDFDFBFBFBFBFBFBFFFFFFFFFF
          FF00FFFFFFFCFCFCFCFCFC4E4E4E878787656565676767FAFAFAFEFEFEFEFEFE
          FEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF5D5D5D222222DFDFDFCACACA888888F9F9F9FD
          FDFDFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
          FEFEFEFEFEFEFEFEFEFBFBFBF7F7F78C8C8C5F5F5FA1A1A1939393F9F9F9FDFD
          FDFAFAFAFDFDFDF3F3F3FCFCFCFAFAFAFDFDFDFEFEFEFEFEFEFEFEFEFFFFFFFF
          FFFFFFFFFFFAFAFA4646468D8D8D929292DFDFDFFAFAFAFDFDFDBDBDBD2E2E2E
          838383FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFF5F5F5F5F5F5B9
          B9B9A0A0A0AEAEAEEDEDEDFBFBFBFCFCFCFEFEFEFEFEFEFEFEFEFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFC2C2C2B1B1B1FCFCFCE9E9E9D1D1D1FCFCFCFAFAFAFEFEFEFEFEFEFEFEFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFDFDFD
          F9F9F9F2F2F2B5B5B5898989B3B3B3F8F8F8FDFDFDFFFFFFF6F6F67E7E7EE1E1
          E1F8F8F8FCFCFCFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFAFAFAE4E4E498
          9898A2A2A2E8E8E8FCFCFCFAFAFAF1F1F19D9D9DE2E2E2FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFF8F8F8F8F8F8F8F8F8F9F9F9F7F7F7FBFBFBFD
          FDFDFBFBFBFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFBFBFBFAFAFAFBFB
          FBFDFDFDFEFEFEFBFBFBFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFAFAFAFCFCFCFBFBFBF4F4F4FBFBFB
          F6F6F6FBFBFBFDFDFDFDFDFDFEFEFEF0F0F0FEFEFEF8F8F8FEFEFEFEFEFEFEFE
          FEFEFEFEFFFFFFFFFFFFFFFFFFFCFCFCFCFCFCF8F8F8F6F6F6FCFCFCFDFDFDFE
          FEFEFBFBFBF7F7F7FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFF0F0F0F0F0F0FDFDFDFCFCFCFFFFFFFCFCFCFCFCFCFEFEFEFEFEFEFEFEFEFE
          FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFDFDFDFBFBFBF7F7F7FBFBFBFCFCFCFDFDFDFBFBFBFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
          FEFEFEFEFEFCFCFCFBFBFBF9F9F9FEFEFEFEFEFEF8F8F8F7F7F7F9F9F9FCFCFC
          FDFDFDFCFCFCFCFCFCFBFBFBFCFCFCFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFF
          FFFDFDFDF9F9F9FDFDFDFBFBFBFDFDFDFDFDFDFEFEFEFAFAFAFCFCFCFBFBFBFD
          FDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF7F7ED37F7ED3FFEDFDE9F9
          F8F0FBF0FFFEF0E7E8EEBDD7F0EEF9F5FBFAF0FBF4FBFBF5FCFCFEFCFCFCF7FF
          FBF7F9F1FEFBFDF1FBFBE6FCF1FEF5FBF7E8FDD7FBFDE9FFFDF1FAF1FBECFAFC
          EDFCE6F9FEE8F9FBF3EFFEF5ECFEEBF9FBF3FDEBFDF4EEFFE7FEE1FFFAF8FFF6
          FCFEF5FEFDF8FDFFFEFCFFFFF2FFFEF6FBF6E5EFFDBFE0F1F1BEC0F5D0DFF5EE
          FCE4EBFDE1F4FDE5FFE9FFFFDEFFFDFBE3FCFFE8EEF6FEFAF3FFF5FFFBEDFEEB
          F8FCF0FCFBFBF8FAFDF2FEFAFCFAF7FCF0FFF6E9F7F9F9F5FBFEE5FCF1FBFCF6
          FAF6FFFDE9FEF3EFFCF5FCE8FDF6ECFFECFEE5FAFBF6FBF7FEF7F5FFF7F5FFFF
          FFFFFFFFFF00FFFFFF6669B06669B0F6E9F9F3FDFDF6FDF9FFF7F2B7BEF52424
          B39F92E5FDF3FDFCF8F4F5FEEFF2FDF0F5FBECFCFEE9F2F6FEF3FEF4FEF4FFFC
          E8FEC3CCDFCEE2EDF7FDF5FFF8FEF5F6F6DBEAE9B3A1FAF1E1EFF9F7F3EFFBE4
          ECFCE2FAF0FBFFF6F9FDFDE3F3FEF8FFFFF6FCFCF5FDFDF7FDFCF9FFFFFCFFFF
          FCFDF8FDE5DCFDB1A8F44A3AD53525CA3A31B17664D6D8E3E3ECE6F8F9F1F9FF
          FFD8FFF6FEFCFBFAF9FEFAFEFEE5F6FDECF7F9FDFCF2FCFFF7FEFDFDF0F9FEEF
          FAFAF9F4FAF4F1F3FEF4FBF5F3F9CBF7FEE3FCF1FCF6FAEEEBFEE5F4EDFAFEF5
          FAFDFDE5F9FEF9FFFFF9FEFEF7FAFAF5FAFAF5FFFFFFFFFFFF00FFFFFF5B66B5
          5B66B5DBD2E2F8FBFBF4F7F7F6F2F86A79D72734C6504FB5F0F2FEF0F9EFDCEF
          FAA0A6DEB5ACE9F2F1FFEAFBEFEBFDF5F8FBFDEFE5FC5447B9433CC0CFD1F2EF
          F4ECF4F8FEACB6ED3013CE9682ECF1F7FBEAEDFDE9EBFFF7F7F8FFFFE7FFFFF2
          F4FAFBEFFAFAF0FDF6F5FEEFFBFEF1FFFEFBFFF9FFF6F9FFB5CBFB2A1BD9372A
          D87985CBBDC7DF9886D05F44C3D4DCEAECFEF7DCEDFBE9F3FAF9E9FBFDF9F1FC
          FDE9FEFCFEFCF2FDFCF5FFFDFCFDFCF8FDF9F7FBDFE2F1989BC6E1F4F5DDEDF7
          BDB4EAE6E8F2EEEFF0F2F0FDE7EAFFF1F6F9FEFEEAFFFEF3F9F9FBFAF9FAFBF9
          F2FFFFF1FFFFF1FFFFFFFFFFFF00FFFFFF7280D37280D39F9DBCFCFAFBFAF8FF
          DFE3FF2A40C65473D53F48B1B6BCE6DAEEF68D9FE22323AF4C3DCC7962DAD0F1
          E0C6E0E9F0FEEEDFE6F53B23D83121E15351B7DEE2F4ECF7FC7D7FE1281EBF38
          2BB79EA6CF9892EC423CC0919EBDF4FCEAF9F2FFC7C5F3BAC0ECE6F0FFEDFCF9
          F8FFF3FEFEFAFFF9FFF3FAFF7093C82C25C46B73C6E0F9E0EBFAE8F1F6FFDCC7
          E4BBB7E9BFDBEF3649A17175D9E9EDFAFFF4FFE1D8FFB4AAE8E6E6FBEAFDF7E0
          F5FC8175CD9377DBE1E5F58D90C3687BAF7973E53504EC5D41C9CBD2EBB5B0FB
          3D35BF9AA9C7F4FCECF9F3FED5D0FAC1BDEAF0F3FFF0FAFAF0FAFAFFFFFFFFFF
          FF00FFFFFF8492E58492E55F64A7F3F1FCF7F6FE9099F12237C3B2CCF3443BD9
          7465E76C75C47589E43244B5C5DAF57B6AC152629E8493C7A0A2D1DBE5FB6B71
          CF3334C56767C55C44C5D3E2EFA7C1DE5657D44F4FD34E52B94E59D61B21CC30
          31CA879BC0CEE1FC3E31D533279B8581D2EAF0FDF2FBFBFCFFF9FFFCFEF3F3FF
          5152DD442AD0E0D5F8FDFEEEFEFCF4FDFAF4FAFCE7C5BBE7645EDD303FC4302F
          C7736AC5EFEAF97678E3352FA7686BABCFEDFF86A7EB2825B45633D6867FCEDE
          F9FF8081E32A13E48B80D7B5A3D24D4AB96774DC282FD23233B999ABCCD1E4FB
          4138DB312AA89295E0E2F1FEE2F1FEFFFFFFFFFFFF00FFFFFF9AA4EB9AA4EB2E
          36ACE3E7FCE6EBFF4850D65660CFD0F1FF5351C6B1A2FB878FD53741CF1B1DBD
          BFD4F9D6E2F85649C69495E45531C4A19EE3D0F3F25766DE727CDFA499D76B5E
          B9D1F6EFB9D2F83739C0C6D0F04A54CA1B22DF6771FB5768B46E7ADE2B26D6B1
          9ECD7467B1B6B3DAF2F6FAFAFEFDFDFFFAF1EFFD3F2EE17762D2FBEBFCFFFBF7
          FBF8FBFEFDF3FEFEF2F3FAFA8B7CE02916E45C5EE2756AC862699A364BC36669
          C5817BC6545DE32D3FDE3E4ACCE6DEFB8478B690A1D5737AEE242CB695B3CCE7
          FBF2CEDFEE4E5CBA1C22D4757BEF5563A77281E50E14C78B87D96060B4929BD2
          929BD2FFFFFFFFFFFF00FFFFFFC0C3F8C0C3F8131AC2C0CEF0BEC9F81619C19E
          9CE4E0FBF7777CBB9390D4DEF7FD5C63D93218F27C73E3E5F1FD998BF7635FCE
          DCCBF15851A5A5BBE36E77EE4F5EC1E5F9F18F6ECF696EC2BDDCF73636C8CBD2
          F4C4C4E82E31C32234A89EA1E7453DBE343CB6F3EBFFF3ECF8BDB9D6F9F9FFFA
          FCFFFAFFFCECF1FC3842C7828FBAF7F8F6FCFCEEFDFEE9F6FBFAF1ECFBFBF9FF
          E5F0F87F75D92514CD91AAE68796CE1725AEA6ABDFE7E0F35052D91521DF6173
          C3F2FDEDE1E0F4625BC62D3AB05E7AC240528FC6D4D3EAFBEACFD8F54D4CC82F
          39A7A9A8E13732CD1C2EB5C4C2EBE8E1F2AAA6CBAAA6CBFFFFFFFFFFFF00FFFF
          FFD1D4FCD1D4FC0D12DB98AEDA6E7FB81F1BD4CDC9EEEEECFF8A74D97972B9E0
          FFF2BED5F14536D13E33A58076D65D62BC5A58C6E9FCE2C6C5E5391DE63B3FDA
          3E4CB3EEFCF1E4D2F76347C94341D42F2DC1B9B4D5EDF5F4BDC7EA4841C14E43
          BFBDBEEF686CC9FAFFE0F9FAE9FAFAF9F7F6FAFAFAFFF9FDFFE8F2FE2E4BBF7A
          93BDF2F2FFFDF8FDF0FBF1C8C5FC7863B1EFEBF2F4FDE7E5F5F5746ADC221AD3
          81A7E5787DD4B9B7D1F9FCD9C0CBE0343FD28891D1FAFBD3E6F2E48783EB2423
          C18087EB9793E16C52C2F3EEF1F2FCF5C8D2E84F40C76454C5BDC3F05360C9DF
          DFE5FFFBF6FFF5FFFFF5FFFFFFFFFFFFFF00FFFFFFEDDBFCEDDBFC2F33B85064
          E1372FD6522ECFF7EEECF2FCFA978FE56152D0EFFEEEF9F1FDD5DAF34338C841
          33CA453DA3A8A7C5F8FCFBEFF4FFA2A7E13337B13438C3D1D2FFF2F2FCE9E5F3
          776ECF271AD58C84D2F3F9F7EFFEF0D7E5F65450B75350CDCBD3FFFCFCFCFBFB
          FBFDFDFDFDFDFDFFFFFFFFFFFFF4F8FF545ACA727EB8F2F8F6FBE5FBFBFDF6AB
          BBED1A22BE989AEDFAF6FEFDF5F1E7DEF4655FCC302BB9A9B0DBF0FCF8FAFDE9
          FCFAEBFBF1F6F6EDF6FBF5FFEBEAFA7A6ECF423AA18990CB9CA3EC4938E3AFAF
          EBF1FDF9EAFDF6D0D3F34C3FBF5856C8C5D4FBF5F9FBFDFDFDFCFCFCFCFCFCFF
          FFFFFFFFFF00FFFFFFF5EEFDF5EEFD404AC41D2ECA2929BE9081D7F9F8F3EEFF
          F79B9AE55448C5E7FCE8FCF7FEF2F9FEB1AFE3A4A0E3DAD8EAF3F4F9FDFFF2F2
          F9FCE8F0FFA0A9DD4752AED4DAF7FAFBFBF5F3FCE1DEF25352CB9B95CFF8FAF7
          F1FEEDEEF9FFCBC6E84E4CB16870B1F1F1F1FCFCFCFDFDFDFBFBFBFFFFFFFFFF
          FFF6FAFF7873E8494AB5DFF9E5FDFAFCF8FDF5C6CEF51F2ABD565FC0F8F7FBFE
          FDEEF1F0FCDBDDF58182CD4E3DACD3C8F3F5F3F9FDFDF5FEFFEFF9FFE6F7FFE8
          F2F6FFC9C4E69796D5DEECF88997C6372FB2948FC5F4FAF8F2FEF5EEF4FFBFB5
          E74645A5505C98E8EAF0FDFDFDFCFCFCFCFCFCFFFFFFFFFFFF00FFFFFFF2F8FA
          F2F8FA5060D21B24DA3239B8C0CDE6F4FDEFE9FFF5A0AAE84136BEDAEEE7FDF9
          F8FAFCEEEEF6FEECF5FFEFF5FCFEFFF4FAFBE8FAFEF4EDF8FBE9F8FFD8E6EFF6
          FDFEFBFDEEF9F9F1F1F7FDDBE5F2F8F4FEFCFDF4FBFEEDF4FAFBEDEAFED7D7ED
          6C759CD2D2D2FEFEFEFBFBFBFDFDFDFFFFFFFFFFFFFAFDFFAA9FF1281FB9B4D0
          DDEFFDEAFBFEF3E6E0F92C39C73140A3EDF0F6FFFEE3F5F9F5EAF2FDE7EEF9A2
          8BD0806EBAF9F2FDF5F5FDF5FBFCECFCF8EBFCEDF8FBF5F5F4FFF4F9FEE9F8F6
          E6F9F89B9ED3D6CEEBFCFBFBFAFEEFF2F9FBF0EBFED5D2E87278A5B7B8BFFFFF
          FFFCFCFCFCFCFCFFFFFFFFFFFF00FFFFFFEFF8F5EFF8F57784E01D1AE74A51C8
          E3F8F3F3FDEFE6FCFBA4B1EE3322C5D1DEECFAF8F9FDFEEBF5FDF7F4FAECF9FD
          EEFBFBF0FFFEF5FCFCF4F9FFF4F2FCF4F1FAFAFBFDF8FEFDF3FEFEF1FAFBF4F0
          FBF7F9F6FAFDFCF5FDFFEBFCFFF8F2F2FFF2F5FFEEF6FEF7F7F7FDFDFDFCFCFC
          FEFEFEFFFFFFFFFFFFFEFFFBE0D8F13A35D15873BCDFF9FBF8FEEBFAF1F7444E
          DF2835A8DADCF0FEFEEAF8FAF2F4FAFBF8FCF9F6F6FEF5F9FBF6FAFAF7F4FFC3
          BDF17F7ED0E0E5FFFCFDF0FBFBFBF6F9F5F6FCEBF3FCEEF1F5FBFBF2FFFDF8FA
          FDFEE9FBFEEEF6F7FBF4EFFFF3F2FEF8F8F9FBFBFBFDFDFDFDFDFDFFFFFFFFFF
          FF00FFFFFFF3F8FCF3F8FC9AA3FB241DDE6060D1EDFCFAF2F9F3EEFAFDB7BFF6
          2F16D0C5CAF1FDFBFDFFFFFBFEFFF6FFFFEEFFFFF5FFFDFEFFFAFFFFFDFEFFFF
          FAFFFFF7FFFFFAFFFEFFFFFDFFFFFEFEFFFFF9FFFFF3FFFDFDFFFEF9FFFFF1FF
          FFF4FDFEFDFAFEFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6
          F3F7F19EA5E9252BB9AAAEF3EFF9E7F6F8EDA8ADF1242AAFD4D1F2FAF9F4FDFE
          FDFEFEFFFFFFF6FDFFEDFDFFE8FCFFF4F2EFFFBEB3EF352BA5A39FEFFFFFFBFF
          FEFFFFFFFCFFFFF5FFFFF6FFFDFEFFF8FFFFFDFDFFFFEFFFFFEBFFFFF7FEFCFF
          FDFAFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFF6F7FEF6F7FEA4
          ABF01F1FAC48439FE1E1F3F7F7FBF3F5FFD2D8F92B11CAB9C0E8FDFEFDFFF9FF
          FEFEFAFFFFF8FFFEFDFFF9FFFFF8FFFFF9FFFFFEFFFFFFFCFFFEFEFFFBFFFFFA
          FFFFFAFFFFFDFFFFFFF9FFFEFDFFFEFEFFFFFAFFFFF6FEFFF5FCFFFAFBFFFDFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6FDEAE0F1FD8684DF4D40C0
          C5D1DDE5F2F9979EFF2225A3D7D1F3FBF8FBFCFAFFFEFBFFFFFEFBFEFCFFFFFF
          FCFFFEFBF7F3FCF0ECFB888EBD828BB2FFFBFFFFFDFFFFFDFFFFFEFFFFFEFFFF
          FEFFFFFEFEFFFFFDFFFFF8FFFFF4FFFFF6FFFFFCFFFDFFFFFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFF5F3FAF5F3FADBE7F5A4B6D67773ADC4B0DEFD
          FBF7FFFCFBEBEEFD462FC6B2C0D7FBFFEDFFF7FFFBFDFEFFFDFFFFFCFFFFFCFF
          FFFCFFFFFDFFFFFEFFFFFEFEFFFDFEFFFDFFFBFCFFFBFCFFFFFCFFFFFCFFFFFD
          FFFFFDFFFFFDFFFFFFFAFDFFF3FCFFF9FBFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFEFFFAFBF9E3F8F8E3EEFA9990CD3B31974853B72C38B8333697
          E6E3F7FAF8F6FAFAFFFCFBFFFFFEFCFEF7FFFFFCFFFFFFFBFFFEFFF3F4FEECFB
          F8E6F3EEFFFBFFFFFFFDFFFEFFFFFBFFFFF9FFFFFEFCFDFFF2FDFFF7FDFDFFFE
          FBFFFFFEFDFFFFFBFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFBF8F6FBF8F6E8FAFFE2FDF6ECECF6F8DDFBFCF6EAFDFDECF2F3EF9C8CD6B2
          C6C9FAFFDCFEF9FEF9FDFDFFFBFFFFFDFFFCFFFDFBFFFAFDFFF9FFFFFBFFFFFC
          FFFEFBFDFFFCF5FFFEF6FFFFFDFDFFFFFAFFFEFDFFFDFCFFFDFBFFFBFEFDFBFF
          F3FAFFFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFCF4FEF0
          FCF3F1FEE0EDEFF5B093D3545ACF4859C8989FD0F6F6F6FBFBF0F9FDFFFAFCFF
          FFFFFBFDFFFCFFFFF2FFFFEDFFFEF9FEF9FDF3F7F8EFF8F4FDFEFEFFFFF8FFFF
          FAFFFAFFFFF9FFFFFEFAFBFFE9FAFFF4FAF9FFFCF6FFFDFCFFFFFFFCFFFFFDFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00}
        Stretch = True
      end
      object QRShape37: TQRShape
        Left = 668
        Top = 948
        Width = 189
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          2090.208333333330000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel46: TQRLabel
        Left = 670
        Top = 950
        Width = 79
        Height = 11
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.253472222222220000
          1477.256944444444000000
          2094.618055555556000000
          174.184027777777800000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(-) Outras Dedu'#231#245'es'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel47: TQRLabel
        Left = 672
        Top = 994
        Width = 90
        Height = 11
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.253472222222220000
          1481.666666666667000000
          2191.631944444444000000
          198.437500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(+) Outros Acr'#233'scimos'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel48: TQRLabel
        Left = 170
        Top = 906
        Width = 32
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          374.826388888888900000
          1997.604166666667000000
          70.555555555555560000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel49: TQRLabel
        Left = 686
        Top = 816
        Width = 160
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          1799.166666666670000000
          351.895833333333000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel52: TQRLabel
        Left = 13
        Top = 877
        Width = 120
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          28.663194444444400000
          1933.663194444440000000
          264.583333333333000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel53: TQRLabel
        Left = 156
        Top = 877
        Width = 163
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          343.958333333333000000
          1933.663194444440000000
          359.392361111111000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel55: TQRLabel
        Left = 337
        Top = 877
        Width = 65
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          743.038194444444000000
          1933.663194444440000000
          143.315972222222000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel69: TQRLabel
        Left = 479
        Top = 877
        Width = 169
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1056.128472222220000000
          1933.663194444440000000
          372.621527777778000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel70: TQRLabel
        Left = 686
        Top = 846
        Width = 158
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          1865.312500000000000000
          349.250000000000000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel71: TQRLabel
        Left = 694
        Top = 877
        Width = 160
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1530.173611111110000000
          1933.663194444440000000
          352.777777777778000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel72: TQRLabel
        Left = 686
        Top = 907
        Width = 160
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1512.534722222220000000
          1999.809027777780000000
          352.777777777778000000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel78: TQRLabel
        Left = 753
        Top = 1095
        Width = 68
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          1660.260416666667000000
          2414.322916666667000000
          149.930555555555600000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel79: TQRLabel
        Left = 299
        Top = 778
        Width = 537
        Height = 22
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          49.609375000000000000
          658.151041666667000000
          1716.484375000000000000
          1184.010416666670000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 11
      end
      object QRLabel80: TQRLabel
        Left = 794
        Top = 753
        Width = 19
        Height = 19
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          41.892361111111110000
          1750.659722222222000000
          1660.260416666667000000
          41.892361111111110000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '"'
        Color = clWhite
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 10
      end
      object QRLabel81: TQRLabel
        Left = 32
        Top = 1134
        Width = 554
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          50.711805555555560000
          70.555555555555560000
          2500.312500000000000000
          1221.493055555556000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 13
      end
      object QRLabel82: TQRLabel
        Left = 32
        Top = 1152
        Width = 554
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          50.711805555555560000
          70.555555555555560000
          2540.000000000000000000
          1221.493055555556000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 13
      end
      object QRLabel83: TQRLabel
        Left = 52
        Top = 173
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          381.440972222222200000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel84: TQRLabel
        Left = 52
        Top = 200
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          440.972222222222300000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object InsSac: TQRLabel
        Left = 462
        Top = 279
        Width = 212
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          1018.645833333330000000
          615.156250000000000000
          466.328125000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel39: TQRLabel
        Left = 446
        Top = 1062
        Width = 212
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          982.265625000000000000
          2341.562500000000000000
          466.328125000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel73: TQRLabel
        Left = 52
        Top = 187
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          412.309027777777900000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel74: TQRLabel
        Left = 52
        Top = 992
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          2187.222222222222000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel75: TQRLabel
        Left = 52
        Top = 1008
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          2222.500000000000000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel76: TQRLabel
        Left = 52
        Top = 1024
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          2257.777777777778000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel77: TQRLabel
        Left = 52
        Top = 1039
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          2290.850694444445000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel85: TQRLabel
        Left = 52
        Top = 928
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          2046.111111111111000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '   Texto de responsabilidade do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 6
      end
      object QRLabel86: TQRLabel
        Left = 52
        Top = 944
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          2081.388888888889000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel87: TQRLabel
        Left = 52
        Top = 976
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          2151.944444444444000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel88: TQRLabel
        Left = 52
        Top = 960
        Width = 594
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          2116.666666666667000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRShape38: TQRShape
        Left = 3
        Top = 368
        Width = 853
        Height = 6
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          13.229166666666700000
          6.614583333333330000
          811.388888888889000000
          1880.746527777780000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape39: TQRShape
        Left = 3
        Top = 654
        Width = 853
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          1441.979166666670000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape40: TQRShape
        Left = 3
        Top = 528
        Width = 853
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          1164.166666666670000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape41: TQRShape
        Left = 3
        Top = 498
        Width = 853
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          1098.020833333330000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape42: TQRShape
        Left = 3
        Top = 466
        Width = 853
        Height = 3
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          6.614583333333330000
          6.614583333333330000
          1028.567708333330000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape43: TQRShape
        Left = 3
        Top = 399
        Width = 853
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          6.614583333333330000
          879.739583333334000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape44: TQRShape
        Left = 3
        Top = 438
        Width = 853
        Height = 3
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          6.614583333333330000
          6.614583333333330000
          965.729166666667000000
          1881.848958333330000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape45: TQRShape
        Left = 191
        Top = 381
        Width = 12
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666700000
          420.026041666667000000
          840.052083333334000000
          26.458333333333300000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape46: TQRShape
        Left = 3
        Top = 710
        Width = 853
        Height = 4
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          8.819444444444440000
          6.614583333333330000
          1565.451388888890000000
          1880.746527777780000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel89: TQRLabel
        Left = 202
        Top = 387
        Width = 57
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          445.381944444444500000
          853.281250000000000000
          125.677083333333300000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '151-1'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object QRLabel90: TQRLabel
        Left = 672
        Top = 409
        Width = 48
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          901.788194444444400000
          105.833333333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Vencimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRShape47: TQRShape
        Left = 279
        Top = 381
        Width = 9
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666700000
          615.156250000000000000
          840.052083333334000000
          19.843750000000000000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel91: TQRLabel
        Left = 5
        Top = 408
        Width = 82
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          899.583333333333300000
          180.798611111111100000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Local de Pagamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel92: TQRLabel
        Left = 57
        Top = 445
        Width = 603
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          125.677083333333300000
          981.163194444444400000
          1329.531250000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel93: TQRLabel
        Left = 672
        Top = 441
        Width = 89
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          972.343750000000000000
          196.232638888888900000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Ag'#234'ncia/C'#243'd. Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel94: TQRLabel
        Left = 2
        Top = 469
        Width = 78
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          1034.079861111111000000
          171.979166666666700000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Data do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel95: TQRLabel
        Left = 145
        Top = 469
        Width = 70
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          319.704861111111100000
          1034.079861111111000000
          154.340277777777800000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'N'#186' do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel96: TQRLabel
        Left = 334
        Top = 469
        Width = 54
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          736.423611111111100000
          1034.079861111111000000
          119.062500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Esp'#233'cie Doc.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel97: TQRLabel
        Left = 418
        Top = 469
        Width = 26
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          921.631944444444400000
          1034.079861111111000000
          57.326388888888890000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Aceite'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel98: TQRLabel
        Left = 475
        Top = 469
        Width = 96
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1047.309027777778000000
          1034.079861111111000000
          211.666666666666700000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Data do Processamento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel99: TQRLabel
        Left = 672
        Top = 469
        Width = 84
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1034.079861111111000000
          185.208333333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Cart./ Nosso N'#250'mero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel100: TQRLabel
        Left = 10
        Top = 502
        Width = 56
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          22.048611111111110000
          1106.840277777778000000
          123.472222222222200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Uso do Banco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel101: TQRLabel
        Left = 169
        Top = 502
        Width = 20
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          372.621527777777800000
          1106.840277777778000000
          44.097222222222220000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Cart.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel102: TQRLabel
        Left = 227
        Top = 502
        Width = 44
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          500.503472222222200000
          1106.840277777778000000
          97.013888888888890000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Esp Moeda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel103: TQRLabel
        Left = 232
        Top = 511
        Width = 73
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          511.527777777778000000
          1126.684027777780000000
          160.954861111111000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'R$'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRLabel104: TQRLabel
        Left = 317
        Top = 502
        Width = 46
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          698.940972222222200000
          1106.840277777778000000
          101.423611111111100000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Quantidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel105: TQRLabel
        Left = 592
        Top = 502
        Width = 41
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1305.277777777778000000
          1106.840277777778000000
          90.399305555555560000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Vr. Moeda'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel106: TQRLabel
        Left = 576
        Top = 502
        Width = 10
        Height = 19
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          41.892361111111110000
          1270.000000000000000000
          1106.840277777778000000
          22.048611111111110000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'x'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 9
      end
      object QRLabel107: TQRLabel
        Left = 672
        Top = 502
        Width = 94
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1106.840277777778000000
          207.256944444444400000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(=) Valor do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel108: TQRLabel
        Left = 672
        Top = 530
        Width = 95
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1168.576388888889000000
          209.461805555555600000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(-) Desconto/Abatimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel109: TQRLabel
        Left = 672
        Top = 577
        Width = 55
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1272.204861111111000000
          121.267361111111100000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(+) Mora/Multa'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel110: TQRLabel
        Left = 672
        Top = 622
        Width = 71
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1371.423611111111000000
          156.545138888888900000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(=) Valor Cobrado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel111: TQRLabel
        Left = 2
        Top = 700
        Width = 74
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          26.458333333333330000
          4.409722222222222000
          1543.402777777778000000
          163.159722222222200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Sacador/Avalista:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel112: TQRLabel
        Left = 674
        Top = 699
        Width = 74
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1486.076388888889000000
          1541.197916666667000000
          163.159722222222200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'C'#243'digo de Baixa'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 6
      end
      object QRShape48: TQRShape
        Left = 668
        Top = 572
        Width = 189
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          1260.078125000000000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape49: TQRShape
        Left = 668
        Top = 591
        Width = 189
        Height = 6
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          13.229166666666700000
          1471.744791666670000000
          1303.072916666670000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel113: TQRLabel
        Left = 51
        Top = 657
        Width = 372
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          1448.593750000000000000
          820.208333333334000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel114: TQRLabel
        Left = 51
        Top = 670
        Width = 372
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          1478.359375000000000000
          820.208333333334000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel115: TQRLabel
        Left = 51
        Top = 684
        Width = 372
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          1508.125000000000000000
          820.208333333334000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRShape50: TQRShape
        Left = 666
        Top = 405
        Width = 3
        Height = 250
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          552.317708333333000000
          1468.437500000000000000
          892.968750000000000000
          6.614583333333330000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel116: TQRLabel
        Left = 6
        Top = 423
        Width = 651
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666700000
          13.229166666666700000
          932.656250000000000000
          1435.364583333330000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 
          'PREFERENCIALMENTE NO BANCO NOSSA CAIXA S.A. OU NA REDE BANCARIA ' +
          'ATE O VENCIMENTO'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel117: TQRLabel
        Left = 227
        Top = 408
        Width = 292
        Height = 9
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          19.843750000000000000
          499.401041666667000000
          899.583333333333000000
          644.921875000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRShape51: TQRShape
        Left = 142
        Top = 471
        Width = 2
        Height = 27
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          59.531250000000000000
          314.192708333333000000
          1038.489583333330000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape52: TQRShape
        Left = 330
        Top = 470
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          727.604166666667000000
          1035.182291666670000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape53: TQRShape
        Left = 412
        Top = 470
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          909.505208333333000000
          1035.182291666670000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape54: TQRShape
        Left = 165
        Top = 498
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          363.802083333333000000
          1098.020833333330000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape55: TQRShape
        Left = 220
        Top = 498
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          486.171875000000000000
          1098.020833333330000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape56: TQRShape
        Left = 579
        Top = 498
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          1276.614583333330000000
          1098.020833333330000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape57: TQRShape
        Left = 668
        Top = 615
        Width = 187
        Height = 6
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          13.229166666666700000
          1471.744791666670000000
          1355.989583333330000000
          413.411458333333000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape58: TQRShape
        Left = 312
        Top = 498
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          687.916666666667000000
          1098.020833333330000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel118: TQRLabel
        Left = 8
        Top = 511
        Width = 143
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          17.638888888888900000
          1126.684027777780000000
          315.295138888889000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRShape59: TQRShape
        Left = 468
        Top = 470
        Width = 2
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          62.838541666666700000
          1031.875000000000000000
          1035.182291666670000000
          3.307291666666670000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel119: TQRLabel
        Left = 446
        Top = 475
        Width = 10
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          983.368055555555600000
          1047.309027777778000000
          22.048611111111110000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRImage3: TQRImage
        Left = 7
        Top = 372
        Width = 114
        Height = 33
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          72.760416666666700000
          15.434027777777800000
          820.208333333333000000
          251.354166666667000000)
        AutoSize = True
        Picture.Data = {
          07544269746D6170DA1B0000424DDA1B00000000000036000000280000005100
          00001D0000000100180000000000A41B00000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFF7FAFCF7FAFC515458393C4020232776797DD0
          D3D626262A444347757478C3C2C58C8B8EEDECEF7C7C80E0E3E53E4145515458
          9EA1A4686B6F66696D2F3234CECECEF9F9F9FCFCFC5C5C5CBDBDBDF7F7F75054
          53848786ABB0AF292E2D535857939897999D9D7275792C2F33ACAFB35154583F
          4246D7DADE282B2D595959343434F6F6F6FBFBFBFEFEFEBEBEBE14161844474B
          4245499194984043471B1D20A4A7AB6A6F6FDFE4E35C6160B3B7B73C41407D82
          814D51512B2E32DADDE0F7FAFDE6E9EB2E3135494C502F3030E6E6E660606073
          7373B2B2B2FFFFFFDDDDDD5858582D2D2DD3D3D3D3D3D3FFFFFFFFFFFF00FFFF
          FFF7FAFCF7FAFC515458393C4020232776797DD0D3D626262A444347757478C3
          C2C58C8B8EEDECEF7C7C80E0E3E53E41455154589EA1A4686B6F66696D2F3234
          CECECEF9F9F9FCFCFC5C5C5CBDBDBDF7F7F7505453848786ABB0AF292E2D5358
          57939897999D9D7275792C2F33ACAFB35154583F4246D7DADE282B2D59595934
          3434F6F6F6FBFBFBFEFEFEBEBEBE14161844474B4245499194984043471B1D20
          A4A7AB6A6F6FDFE4E35C6160B3B7B73C41407D82814D51512B2E32DADDE0F7FA
          FDE6E9EB2E3135494C502F3030E6E6E6606060737373B2B2B2FFFFFFDDDDDD58
          58582D2D2DD3D3D3D3D3D3FFFFFFFFFFFF00FFFFFFFDFDFDFDFDFD4B4B4BCDCD
          CDD3D3D32A2A2AA0A0A0A4A4A4B9B9B9828282B5B5B5959595F8F8F8868686BA
          BABA4D4D4DF7F7F7E6E6E6646464F5F5F5B1B1B18D8D8DFCFCFCFBFBFB686868
          B9B9B9DCDCDC3B3B3B9A9A9A515151AFAFAFE0E0E03E3E3EF1F1F1FBFBFB6B6B
          6BB3B3B3F9F9F9818181949494454545E8E8E8343434FAFAFAFBFBFBF9F9F95E
          5E5EAFAFAFFCFCFCD7D7D7555555D4D4D46B6B6BAAAAAA7D7D7DF1F1F17B7B7B
          535353ACACAC6E6E6EF5F5F5767676E6E6E6FEFEFEF9F9F9D1D1D1FAFAFA5555
          55969696D5D5D5BCBCBC8F8F8FFAFAFABCBCBC838383C4C4C4F3F3F3F3F3F3FF
          FFFFFFFFFF00FFFFFFF6F6F6F6F6F6555555C2C2C2D1D1D1313131C8C8C84545
          457777777D7D7DBEBEBE9A9A9AF8F8F88181818C8C8C787878F9F9F9F0F0F06E
          6E6EF9F9F9E0E0E0787878F9F9F9FDFDFD666666C4C4C4858585AFAFAF8D8D8D
          454545D4D4D4EAEAEA282828CDCDCD4141413E3E3EE3E3E35B5B5B484848EBEB
          EB4949497E7E7E454545F6F6F6FCFCFCF4F4F4585858FEFEFEFAFAFAFDFDFDA6
          A6A6686868575757B4B4B47F7F7FE9E9E9BCBCBC434343F8F8F8999999737373
          565656E4E4E4FCFCFCF8F8F8F9F9F9E1E1E1343434A2A2A2F6F6F6F3F3F34444
          44606060383838C0C0C0FDFDFDF8F8F8F8F8F8FFFFFFFFFFFF00FFFFFFFBFBFB
          FBFBFB555555515151303030B6B6B6F5F5F5E4E4E48888888E8E8EB6B6B68585
          85EFEFEF7E7E7EBCBCBC454545EFEFEFF8F8F85B5B5BF3F3F3A4A4A48F8F8FFC
          FCFCFAFAFA676767CACACA676767D6D6D69393935C5C5C9D9D9DE2E2E2363636
          818181B4B4B4F0F0F0BABABA5B5B5BF0F0F0EDEDEDEFEFEFB3B3B3414141FEFE
          FEF7F7F7ECECEC686868FBFBFBF8F8F8FAFAFAF3F3F3D4D4D44C4C4CAAAAAA7E
          7E7EFFFFFF8181814F4F4FBBBBBBF1F1F1D7D7D7595959E9E9E9FAFAFAFBFBFB
          B2B2B23333338F8F8FF5F5F5F9F9F9FBFBFB787878FBFBFB424242E6E6E6FEFE
          FEFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFBFBFBFBFBFB4C4C4CD3D3D3BABABA
          535353EEEEEE7373735B5B5BD1D1D1B7B7B7767676515151ADADADF6F6F69090
          90585858CACACAAAAAAA696969606060E6E6E6F6F6F6FCFCFC6F6F6F848484A2
          A2A2DBDBDB8E8E8EDBDBDB6C6C6C5D5D5DC8C8C8C6C6C66060605F5F5FD5D5D5
          616161686868F1F1F19090906161619A9A9AF9F9F9FAFAFAF9F9F94F4F4FFAFA
          FAF6F6F6FCFCFCDFDFDF666666575757E7E7E7989898F3F3F37B7B7BDBDBDB78
          7878CBCBCB636363707070F8F8F8FBFBFBF1F1F12C2C2CD3D3D3FDFDFDFCFCFC
          FCFCFCFBFBFB909090BDBDBD414141FCFCFCFDFDFDFBFBFBFBFBFBFFFFFFFFFF
          FF00FFFFFFFCFCFCFCFCFC4E4E4E878787656565676767FAFAFAFEFEFEFEFEFE
          FEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF5D5D5D222222DFDFDFCACACA888888F9F9F9FD
          FDFDFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
          FEFEFEFEFEFEFEFEFEFBFBFBF7F7F78C8C8C5F5F5FA1A1A1939393F9F9F9FDFD
          FDFAFAFAFDFDFDF3F3F3FCFCFCFAFAFAFDFDFDFEFEFEFEFEFEFEFEFEFFFFFFFF
          FFFFFFFFFFFAFAFA4646468D8D8D929292DFDFDFFAFAFAFDFDFDBDBDBD2E2E2E
          838383FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFF5F5F5F5F5F5B9
          B9B9A0A0A0AEAEAEEDEDEDFBFBFBFCFCFCFEFEFEFEFEFEFEFEFEFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFC2C2C2B1B1B1FCFCFCE9E9E9D1D1D1FCFCFCFAFAFAFEFEFEFEFEFEFEFEFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFDFDFD
          F9F9F9F2F2F2B5B5B5898989B3B3B3F8F8F8FDFDFDFFFFFFF6F6F67E7E7EE1E1
          E1F8F8F8FCFCFCFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFAFAFAE4E4E498
          9898A2A2A2E8E8E8FCFCFCFAFAFAF1F1F19D9D9DE2E2E2FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFF8F8F8F8F8F8F8F8F8F9F9F9F7F7F7FBFBFBFD
          FDFDFBFBFBFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFBFBFBFAFAFAFBFB
          FBFDFDFDFEFEFEFBFBFBFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFAFAFAFCFCFCFBFBFBF4F4F4FBFBFB
          F6F6F6FBFBFBFDFDFDFDFDFDFEFEFEF0F0F0FEFEFEF8F8F8FEFEFEFEFEFEFEFE
          FEFEFEFEFFFFFFFFFFFFFFFFFFFCFCFCFCFCFCF8F8F8F6F6F6FCFCFCFDFDFDFE
          FEFEFBFBFBF7F7F7FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFF0F0F0F0F0F0FDFDFDFCFCFCFFFFFFFCFCFCFCFCFCFEFEFEFEFEFEFEFEFEFE
          FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFDFDFDFBFBFBF7F7F7FBFBFBFCFCFCFDFDFDFBFBFBFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
          FEFEFEFEFEFCFCFCFBFBFBF9F9F9FEFEFEFEFEFEF8F8F8F7F7F7F9F9F9FCFCFC
          FDFDFDFCFCFCFCFCFCFBFBFBFCFCFCFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFF
          FFFDFDFDF9F9F9FDFDFDFBFBFBFDFDFDFDFDFDFEFEFEFAFAFAFCFCFCFBFBFBFD
          FDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF7F7ED37F7ED3FFEDFDE9F9
          F8F0FBF0FFFEF0E7E8EEBDD7F0EEF9F5FBFAF0FBF4FBFBF5FCFCFEFCFCFCF7FF
          FBF7F9F1FEFBFDF1FBFBE6FCF1FEF5FBF7E8FDD7FBFDE9FFFDF1FAF1FBECFAFC
          EDFCE6F9FEE8F9FBF3EFFEF5ECFEEBF9FBF3FDEBFDF4EEFFE7FEE1FFFAF8FFF6
          FCFEF5FEFDF8FDFFFEFCFFFFF2FFFEF6FBF6E5EFFDBFE0F1F1BEC0F5D0DFF5EE
          FCE4EBFDE1F4FDE5FFE9FFFFDEFFFDFBE3FCFFE8EEF6FEFAF3FFF5FFFBEDFEEB
          F8FCF0FCFBFBF8FAFDF2FEFAFCFAF7FCF0FFF6E9F7F9F9F5FBFEE5FCF1FBFCF6
          FAF6FFFDE9FEF3EFFCF5FCE8FDF6ECFFECFEE5FAFBF6FBF7FEF7F5FFF7F5FFFF
          FFFFFFFFFF00FFFFFF6669B06669B0F6E9F9F3FDFDF6FDF9FFF7F2B7BEF52424
          B39F92E5FDF3FDFCF8F4F5FEEFF2FDF0F5FBECFCFEE9F2F6FEF3FEF4FEF4FFFC
          E8FEC3CCDFCEE2EDF7FDF5FFF8FEF5F6F6DBEAE9B3A1FAF1E1EFF9F7F3EFFBE4
          ECFCE2FAF0FBFFF6F9FDFDE3F3FEF8FFFFF6FCFCF5FDFDF7FDFCF9FFFFFCFFFF
          FCFDF8FDE5DCFDB1A8F44A3AD53525CA3A31B17664D6D8E3E3ECE6F8F9F1F9FF
          FFD8FFF6FEFCFBFAF9FEFAFEFEE5F6FDECF7F9FDFCF2FCFFF7FEFDFDF0F9FEEF
          FAFAF9F4FAF4F1F3FEF4FBF5F3F9CBF7FEE3FCF1FCF6FAEEEBFEE5F4EDFAFEF5
          FAFDFDE5F9FEF9FFFFF9FEFEF7FAFAF5FAFAF5FFFFFFFFFFFF00FFFFFF5B66B5
          5B66B5DBD2E2F8FBFBF4F7F7F6F2F86A79D72734C6504FB5F0F2FEF0F9EFDCEF
          FAA0A6DEB5ACE9F2F1FFEAFBEFEBFDF5F8FBFDEFE5FC5447B9433CC0CFD1F2EF
          F4ECF4F8FEACB6ED3013CE9682ECF1F7FBEAEDFDE9EBFFF7F7F8FFFFE7FFFFF2
          F4FAFBEFFAFAF0FDF6F5FEEFFBFEF1FFFEFBFFF9FFF6F9FFB5CBFB2A1BD9372A
          D87985CBBDC7DF9886D05F44C3D4DCEAECFEF7DCEDFBE9F3FAF9E9FBFDF9F1FC
          FDE9FEFCFEFCF2FDFCF5FFFDFCFDFCF8FDF9F7FBDFE2F1989BC6E1F4F5DDEDF7
          BDB4EAE6E8F2EEEFF0F2F0FDE7EAFFF1F6F9FEFEEAFFFEF3F9F9FBFAF9FAFBF9
          F2FFFFF1FFFFF1FFFFFFFFFFFF00FFFFFF7280D37280D39F9DBCFCFAFBFAF8FF
          DFE3FF2A40C65473D53F48B1B6BCE6DAEEF68D9FE22323AF4C3DCC7962DAD0F1
          E0C6E0E9F0FEEEDFE6F53B23D83121E15351B7DEE2F4ECF7FC7D7FE1281EBF38
          2BB79EA6CF9892EC423CC0919EBDF4FCEAF9F2FFC7C5F3BAC0ECE6F0FFEDFCF9
          F8FFF3FEFEFAFFF9FFF3FAFF7093C82C25C46B73C6E0F9E0EBFAE8F1F6FFDCC7
          E4BBB7E9BFDBEF3649A17175D9E9EDFAFFF4FFE1D8FFB4AAE8E6E6FBEAFDF7E0
          F5FC8175CD9377DBE1E5F58D90C3687BAF7973E53504EC5D41C9CBD2EBB5B0FB
          3D35BF9AA9C7F4FCECF9F3FED5D0FAC1BDEAF0F3FFF0FAFAF0FAFAFFFFFFFFFF
          FF00FFFFFF8492E58492E55F64A7F3F1FCF7F6FE9099F12237C3B2CCF3443BD9
          7465E76C75C47589E43244B5C5DAF57B6AC152629E8493C7A0A2D1DBE5FB6B71
          CF3334C56767C55C44C5D3E2EFA7C1DE5657D44F4FD34E52B94E59D61B21CC30
          31CA879BC0CEE1FC3E31D533279B8581D2EAF0FDF2FBFBFCFFF9FFFCFEF3F3FF
          5152DD442AD0E0D5F8FDFEEEFEFCF4FDFAF4FAFCE7C5BBE7645EDD303FC4302F
          C7736AC5EFEAF97678E3352FA7686BABCFEDFF86A7EB2825B45633D6867FCEDE
          F9FF8081E32A13E48B80D7B5A3D24D4AB96774DC282FD23233B999ABCCD1E4FB
          4138DB312AA89295E0E2F1FEE2F1FEFFFFFFFFFFFF00FFFFFF9AA4EB9AA4EB2E
          36ACE3E7FCE6EBFF4850D65660CFD0F1FF5351C6B1A2FB878FD53741CF1B1DBD
          BFD4F9D6E2F85649C69495E45531C4A19EE3D0F3F25766DE727CDFA499D76B5E
          B9D1F6EFB9D2F83739C0C6D0F04A54CA1B22DF6771FB5768B46E7ADE2B26D6B1
          9ECD7467B1B6B3DAF2F6FAFAFEFDFDFFFAF1EFFD3F2EE17762D2FBEBFCFFFBF7
          FBF8FBFEFDF3FEFEF2F3FAFA8B7CE02916E45C5EE2756AC862699A364BC36669
          C5817BC6545DE32D3FDE3E4ACCE6DEFB8478B690A1D5737AEE242CB695B3CCE7
          FBF2CEDFEE4E5CBA1C22D4757BEF5563A77281E50E14C78B87D96060B4929BD2
          929BD2FFFFFFFFFFFF00FFFFFFC0C3F8C0C3F8131AC2C0CEF0BEC9F81619C19E
          9CE4E0FBF7777CBB9390D4DEF7FD5C63D93218F27C73E3E5F1FD998BF7635FCE
          DCCBF15851A5A5BBE36E77EE4F5EC1E5F9F18F6ECF696EC2BDDCF73636C8CBD2
          F4C4C4E82E31C32234A89EA1E7453DBE343CB6F3EBFFF3ECF8BDB9D6F9F9FFFA
          FCFFFAFFFCECF1FC3842C7828FBAF7F8F6FCFCEEFDFEE9F6FBFAF1ECFBFBF9FF
          E5F0F87F75D92514CD91AAE68796CE1725AEA6ABDFE7E0F35052D91521DF6173
          C3F2FDEDE1E0F4625BC62D3AB05E7AC240528FC6D4D3EAFBEACFD8F54D4CC82F
          39A7A9A8E13732CD1C2EB5C4C2EBE8E1F2AAA6CBAAA6CBFFFFFFFFFFFF00FFFF
          FFD1D4FCD1D4FC0D12DB98AEDA6E7FB81F1BD4CDC9EEEEECFF8A74D97972B9E0
          FFF2BED5F14536D13E33A58076D65D62BC5A58C6E9FCE2C6C5E5391DE63B3FDA
          3E4CB3EEFCF1E4D2F76347C94341D42F2DC1B9B4D5EDF5F4BDC7EA4841C14E43
          BFBDBEEF686CC9FAFFE0F9FAE9FAFAF9F7F6FAFAFAFFF9FDFFE8F2FE2E4BBF7A
          93BDF2F2FFFDF8FDF0FBF1C8C5FC7863B1EFEBF2F4FDE7E5F5F5746ADC221AD3
          81A7E5787DD4B9B7D1F9FCD9C0CBE0343FD28891D1FAFBD3E6F2E48783EB2423
          C18087EB9793E16C52C2F3EEF1F2FCF5C8D2E84F40C76454C5BDC3F05360C9DF
          DFE5FFFBF6FFF5FFFFF5FFFFFFFFFFFFFF00FFFFFFEDDBFCEDDBFC2F33B85064
          E1372FD6522ECFF7EEECF2FCFA978FE56152D0EFFEEEF9F1FDD5DAF34338C841
          33CA453DA3A8A7C5F8FCFBEFF4FFA2A7E13337B13438C3D1D2FFF2F2FCE9E5F3
          776ECF271AD58C84D2F3F9F7EFFEF0D7E5F65450B75350CDCBD3FFFCFCFCFBFB
          FBFDFDFDFDFDFDFFFFFFFFFFFFF4F8FF545ACA727EB8F2F8F6FBE5FBFBFDF6AB
          BBED1A22BE989AEDFAF6FEFDF5F1E7DEF4655FCC302BB9A9B0DBF0FCF8FAFDE9
          FCFAEBFBF1F6F6EDF6FBF5FFEBEAFA7A6ECF423AA18990CB9CA3EC4938E3AFAF
          EBF1FDF9EAFDF6D0D3F34C3FBF5856C8C5D4FBF5F9FBFDFDFDFCFCFCFCFCFCFF
          FFFFFFFFFF00FFFFFFF5EEFDF5EEFD404AC41D2ECA2929BE9081D7F9F8F3EEFF
          F79B9AE55448C5E7FCE8FCF7FEF2F9FEB1AFE3A4A0E3DAD8EAF3F4F9FDFFF2F2
          F9FCE8F0FFA0A9DD4752AED4DAF7FAFBFBF5F3FCE1DEF25352CB9B95CFF8FAF7
          F1FEEDEEF9FFCBC6E84E4CB16870B1F1F1F1FCFCFCFDFDFDFBFBFBFFFFFFFFFF
          FFF6FAFF7873E8494AB5DFF9E5FDFAFCF8FDF5C6CEF51F2ABD565FC0F8F7FBFE
          FDEEF1F0FCDBDDF58182CD4E3DACD3C8F3F5F3F9FDFDF5FEFFEFF9FFE6F7FFE8
          F2F6FFC9C4E69796D5DEECF88997C6372FB2948FC5F4FAF8F2FEF5EEF4FFBFB5
          E74645A5505C98E8EAF0FDFDFDFCFCFCFCFCFCFFFFFFFFFFFF00FFFFFFF2F8FA
          F2F8FA5060D21B24DA3239B8C0CDE6F4FDEFE9FFF5A0AAE84136BEDAEEE7FDF9
          F8FAFCEEEEF6FEECF5FFEFF5FCFEFFF4FAFBE8FAFEF4EDF8FBE9F8FFD8E6EFF6
          FDFEFBFDEEF9F9F1F1F7FDDBE5F2F8F4FEFCFDF4FBFEEDF4FAFBEDEAFED7D7ED
          6C759CD2D2D2FEFEFEFBFBFBFDFDFDFFFFFFFFFFFFFAFDFFAA9FF1281FB9B4D0
          DDEFFDEAFBFEF3E6E0F92C39C73140A3EDF0F6FFFEE3F5F9F5EAF2FDE7EEF9A2
          8BD0806EBAF9F2FDF5F5FDF5FBFCECFCF8EBFCEDF8FBF5F5F4FFF4F9FEE9F8F6
          E6F9F89B9ED3D6CEEBFCFBFBFAFEEFF2F9FBF0EBFED5D2E87278A5B7B8BFFFFF
          FFFCFCFCFCFCFCFFFFFFFFFFFF00FFFFFFEFF8F5EFF8F57784E01D1AE74A51C8
          E3F8F3F3FDEFE6FCFBA4B1EE3322C5D1DEECFAF8F9FDFEEBF5FDF7F4FAECF9FD
          EEFBFBF0FFFEF5FCFCF4F9FFF4F2FCF4F1FAFAFBFDF8FEFDF3FEFEF1FAFBF4F0
          FBF7F9F6FAFDFCF5FDFFEBFCFFF8F2F2FFF2F5FFEEF6FEF7F7F7FDFDFDFCFCFC
          FEFEFEFFFFFFFFFFFFFEFFFBE0D8F13A35D15873BCDFF9FBF8FEEBFAF1F7444E
          DF2835A8DADCF0FEFEEAF8FAF2F4FAFBF8FCF9F6F6FEF5F9FBF6FAFAF7F4FFC3
          BDF17F7ED0E0E5FFFCFDF0FBFBFBF6F9F5F6FCEBF3FCEEF1F5FBFBF2FFFDF8FA
          FDFEE9FBFEEEF6F7FBF4EFFFF3F2FEF8F8F9FBFBFBFDFDFDFDFDFDFFFFFFFFFF
          FF00FFFFFFF3F8FCF3F8FC9AA3FB241DDE6060D1EDFCFAF2F9F3EEFAFDB7BFF6
          2F16D0C5CAF1FDFBFDFFFFFBFEFFF6FFFFEEFFFFF5FFFDFEFFFAFFFFFDFEFFFF
          FAFFFFF7FFFFFAFFFEFFFFFDFFFFFEFEFFFFF9FFFFF3FFFDFDFFFEF9FFFFF1FF
          FFF4FDFEFDFAFEFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6
          F3F7F19EA5E9252BB9AAAEF3EFF9E7F6F8EDA8ADF1242AAFD4D1F2FAF9F4FDFE
          FDFEFEFFFFFFF6FDFFEDFDFFE8FCFFF4F2EFFFBEB3EF352BA5A39FEFFFFFFBFF
          FEFFFFFFFCFFFFF5FFFFF6FFFDFEFFF8FFFFFDFDFFFFEFFFFFEBFFFFF7FEFCFF
          FDFAFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFF6F7FEF6F7FEA4
          ABF01F1FAC48439FE1E1F3F7F7FBF3F5FFD2D8F92B11CAB9C0E8FDFEFDFFF9FF
          FEFEFAFFFFF8FFFEFDFFF9FFFFF8FFFFF9FFFFFEFFFFFFFCFFFEFEFFFBFFFFFA
          FFFFFAFFFFFDFFFFFFF9FFFEFDFFFEFEFFFFFAFFFFF6FEFFF5FCFFFAFBFFFDFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6FDEAE0F1FD8684DF4D40C0
          C5D1DDE5F2F9979EFF2225A3D7D1F3FBF8FBFCFAFFFEFBFFFFFEFBFEFCFFFFFF
          FCFFFEFBF7F3FCF0ECFB888EBD828BB2FFFBFFFFFDFFFFFDFFFFFEFFFFFEFFFF
          FEFFFFFEFEFFFFFDFFFFF8FFFFF4FFFFF6FFFFFCFFFDFFFFFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFF5F3FAF5F3FADBE7F5A4B6D67773ADC4B0DEFD
          FBF7FFFCFBEBEEFD462FC6B2C0D7FBFFEDFFF7FFFBFDFEFFFDFFFFFCFFFFFCFF
          FFFCFFFFFDFFFFFEFFFFFEFEFFFDFEFFFDFFFBFCFFFBFCFFFFFCFFFFFCFFFFFD
          FFFFFDFFFFFDFFFFFFFAFDFFF3FCFFF9FBFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFEFFFAFBF9E3F8F8E3EEFA9990CD3B31974853B72C38B8333697
          E6E3F7FAF8F6FAFAFFFCFBFFFFFEFCFEF7FFFFFCFFFFFFFBFFFEFFF3F4FEECFB
          F8E6F3EEFFFBFFFFFFFDFFFEFFFFFBFFFFF9FFFFFEFCFDFFF2FDFFF7FDFDFFFE
          FBFFFFFEFDFFFFFBFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFBF8F6FBF8F6E8FAFFE2FDF6ECECF6F8DDFBFCF6EAFDFDECF2F3EF9C8CD6B2
          C6C9FAFFDCFEF9FEF9FDFDFFFBFFFFFDFFFCFFFDFBFFFAFDFFF9FFFFFBFFFFFC
          FFFEFBFDFFFCF5FFFEF6FFFFFDFDFFFFFAFFFEFDFFFDFCFFFDFBFFFBFEFDFBFF
          F3FAFFFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFCF4FEF0
          FCF3F1FEE0EDEFF5B093D3545ACF4859C8989FD0F6F6F6FBFBF0F9FDFFFAFCFF
          FFFFFBFDFFFCFFFFF2FFFFEDFFFEF9FEF9FDF3F7F8EFF8F4FDFEFEFFFFF8FFFF
          FAFFFAFFFFF9FFFFFEFAFBFFE9FAFFF4FAF9FFFCF6FFFDFCFFFFFFFCFFFFFDFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00}
        Stretch = True
      end
      object QRShape60: TQRShape
        Left = 668
        Top = 549
        Width = 189
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          1210.468750000000000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel120: TQRLabel
        Left = 670
        Top = 553
        Width = 79
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1477.256944444444000000
          1219.288194444444000000
          174.184027777777800000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(-) Outras Dedu'#231#245'es'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel121: TQRLabel
        Left = 672
        Top = 600
        Width = 90
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1322.916666666667000000
          198.437500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(+) Outros Acr'#233'scimos'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel122: TQRLabel
        Left = 170
        Top = 511
        Width = 32
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888890000
          374.826388888888900000
          1126.684027777778000000
          70.555555555555560000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel123: TQRLabel
        Left = 686
        Top = 419
        Width = 160
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          923.395833333333000000
          351.895833333333000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel124: TQRLabel
        Left = 16
        Top = 479
        Width = 120
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          34.395833333333300000
          1055.687500000000000000
          264.583333333333000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel125: TQRLabel
        Left = 160
        Top = 480
        Width = 164
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          351.895833333333000000
          1058.333333333330000000
          362.479166666667000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel126: TQRLabel
        Left = 339
        Top = 479
        Width = 65
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          747.447916666667000000
          1055.026041666670000000
          142.213541666667000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel127: TQRLabel
        Left = 477
        Top = 480
        Width = 169
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          1051.718750000000000000
          1058.333333333330000000
          373.723958333333000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel128: TQRLabel
        Left = 688
        Top = 450
        Width = 160
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1516.944444444440000000
          992.187500000000000000
          352.777777777778000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel129: TQRLabel
        Left = 688
        Top = 480
        Width = 160
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1516.944444444440000000
          1058.333333333330000000
          352.777777777778000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel130: TQRLabel
        Left = 688
        Top = 511
        Width = 160
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1516.944444444440000000
          1126.684027777780000000
          352.777777777778000000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 8
      end
      object QRLabel131: TQRLabel
        Left = 754
        Top = 699
        Width = 68
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1662.465277777778000000
          1541.197916666667000000
          149.930555555555600000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel133: TQRLabel
        Left = 818
        Top = 365
        Width = 19
        Height = 19
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          41.892361111111110000
          1803.576388888889000000
          804.774305555555600000
          41.892361111111110000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '"'
        Color = clWhite
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 10
      end
      object QRLabel134: TQRLabel
        Left = 454
        Top = 663
        Width = 212
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          42.994791666666700000
          1002.109375000000000000
          1461.822916666670000000
          466.328125000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel135: TQRLabel
        Left = 52
        Top = 594
        Width = 594
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          114.652777777777800000
          1309.687500000000000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel136: TQRLabel
        Left = 52
        Top = 608
        Width = 594
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          114.652777777777800000
          1340.555555555556000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel137: TQRLabel
        Left = 52
        Top = 624
        Width = 594
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          114.652777777777800000
          1375.833333333333000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel138: TQRLabel
        Left = 52
        Top = 639
        Width = 594
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          114.652777777777800000
          1408.906250000000000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel139: TQRLabel
        Left = 52
        Top = 534
        Width = 594
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          114.652777777777800000
          1177.395833333333000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '  Texto de responsabilidade do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 6
      end
      object QRLabel140: TQRLabel
        Left = 52
        Top = 549
        Width = 594
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          114.652777777777800000
          1210.468750000000000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel141: TQRLabel
        Left = 52
        Top = 578
        Width = 594
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          114.652777777777800000
          1274.409722222222000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel142: TQRLabel
        Left = 52
        Top = 563
        Width = 594
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          114.652777777777800000
          1241.336805555556000000
          1309.687500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel67: TQRLabel
        Left = 687
        Top = 380
        Width = 159
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          50.711805555555560000
          1514.739583333333000000
          837.847222222222300000
          350.572916666666700000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'Recibo do Sacado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRLabel132: TQRLabel
        Left = 687
        Top = 11
        Width = 159
        Height = 22
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.506944444444440000
          1514.739583333333000000
          24.253472222222220000
          350.572916666666700000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'Ficha de caixa'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRLabel38: TQRLabel
        Left = 2
        Top = 534
        Width = 43
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          1177.395833333333000000
          94.809027777777780000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Instru'#231#245'es'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel143: TQRLabel
        Left = 707
        Top = 715
        Width = 53
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          26.458333333333330000
          1558.836805555556000000
          1576.475694444444000000
          116.857638888888900000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Autentica'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel144: TQRLabel
        Left = 5
        Top = 440
        Width = 49
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          970.138888888888900000
          108.038194444444400000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Benefici'#225'rio'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel145: TQRLabel
        Left = 5
        Top = 836
        Width = 49
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1843.263888888889000000
          108.038194444444400000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Benefici'#225'rio'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel10: TQRLabel
        Left = 203
        Top = 4
        Width = 26
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          447.586805555555600000
          8.819444444444444000
          57.326388888888890000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Banco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel146: TQRLabel
        Left = 203
        Top = 374
        Width = 26
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          447.586805555555600000
          824.618055555555600000
          57.326388888888890000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Banco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel147: TQRLabel
        Left = 203
        Top = 769
        Width = 26
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          447.586805555555600000
          1695.538194444444000000
          57.326388888888890000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Banco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
      object QRLabel148: TQRLabel
        Left = 7
        Top = 657
        Width = 38
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          15.434027777777780000
          1448.593750000000000000
          83.784722222222220000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Pagador:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 5
      end
    end
  end
end
