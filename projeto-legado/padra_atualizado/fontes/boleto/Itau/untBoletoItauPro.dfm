object frmQckBoletoItauPro: TfrmQckBoletoItauPro
  Left = 123
  Top = 25
  Width = 996
  Height = 811
  AutoScroll = True
  Caption = 'frmQckBoletoItauPro'
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
    Left = 28
    Top = 8
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
      Height = 1283
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
        2828.836805555556000000
        1898.385416666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object QRShape44: TQRShape
        Left = 4
        Top = 64
        Width = 494
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          8.819444444444444000
          141.111111111111100000
          1089.201388888889000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape63: TQRShape
        Left = 4
        Top = 94
        Width = 493
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          8.819444444444444000
          207.256944444444400000
          1086.996527777778000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape85: TQRShape
        Left = 4
        Top = 125
        Width = 502
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          8.819444444444444000
          275.607638888888900000
          1106.840277777778000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal6: TQRShape
        Left = 4
        Top = 447
        Width = 853
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          4.409722222222222000
          8.819444444444444000
          985.572916666666600000
          1880.746527777778000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal5: TQRShape
        Left = 4
        Top = 329
        Width = 853
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          8.819444444444444000
          725.399305555555700000
          1880.746527777778000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal4: TQRShape
        Left = 4
        Top = 299
        Width = 853
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          8.819444444444444000
          659.253472222222300000
          1880.746527777778000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal3: TQRShape
        Left = 4
        Top = 266
        Width = 853
        Height = 4
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          8.819444444444444000
          8.819444444444444000
          586.493055555555700000
          1880.746527777778000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal1: TQRShape
        Left = 4
        Top = 200
        Width = 853
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444450000
          8.819444444444444000
          440.972222222222300000
          1880.746527777778000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal2: TQRShape
        Left = 4
        Top = 239
        Width = 853
        Height = 2
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          4.409722222222222000
          8.819444444444444000
          526.961805555555600000
          1880.746527777778000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaVertical1: TQRShape
        Left = 191
        Top = 182
        Width = 12
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666660000
          421.128472222222200000
          401.284722222222300000
          26.458333333333330000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LinhaHorizontal7: TQRShape
        Left = 4
        Top = 514
        Width = 853
        Height = 5
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          11.024305555555560000
          8.819444444444444000
          1133.298611111111000000
          1880.746527777778000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNrBanco: TQRLabel
        Left = 200
        Top = 182
        Width = 82
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666660000
          440.972222222222300000
          401.284722222222300000
          180.798611111111100000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '341-7'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 12
      end
      object LabelVencimento: TQRLabel
        Left = 672
        Top = 210
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
          463.020833333333300000
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
        Left = 280
        Top = 182
        Width = 10
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666660000
          617.361111111111200000
          401.284722222222300000
          22.048611111111110000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelLocalPagamento: TQRLabel
        Left = 5
        Top = 208
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
          458.611111111111100000
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
        Top = 242
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
          533.576388888888900000
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
      object LabelAgenciaCodigoCedente: TQRLabel
        Left = 672
        Top = 242
        Width = 89
        Height = 9
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          19.843750000000000000
          1481.666666666667000000
          533.576388888888900000
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
        Top = 272
        Width = 78
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          599.722222222222200000
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
        Top = 272
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
          599.722222222222200000
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
        Top = 272
        Width = 54
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          738.628472222222200000
          599.722222222222200000
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
        Top = 272
        Width = 26
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          915.017361111111100000
          599.722222222222200000
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
        Top = 272
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
          599.722222222222200000
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
        Top = 272
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
          599.722222222222200000
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
        Top = 301
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
          663.663194444444400000
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
        Top = 301
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
          663.663194444444400000
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
        Top = 301
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
          663.663194444444400000
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
        Left = 229
        Top = 311
        Width = 73
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          504.913194444444500000
          685.711805555555700000
          160.954861111111100000)
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
        Top = 301
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
          663.663194444444400000
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
        Top = 301
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
          663.663194444444400000
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
        Top = 303
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
          668.072916666666700000
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
        Top = 301
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
          663.663194444444400000
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
        Top = 332
        Width = 374
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          732.013888888888900000
          824.618055555555600000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 
          'Instru'#231#245'es (Todas informa'#231#245'es deste bloqueto s'#227'o de exclusiva re' +
          'sponsabilidade do cedente).'
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
        Top = 332
        Width = 95
        Height = 9
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          19.843750000000000000
          1481.666666666667000000
          732.013888888888900000
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
        Top = 381
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
          840.052083333333300000
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
        Top = 424
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
          934.861111111111100000
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
        Left = 5
        Top = 450
        Width = 38
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          992.187500000000000000
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
        Left = 2
        Top = 495
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
          1091.406250000000000000
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
        Left = 682
        Top = 493
        Width = 74
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1503.715277777778000000
          1086.996527777778000000
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
      object QRShape2: TQRShape
        Left = 667
        Top = 379
        Width = 188
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          1470.642361111111000000
          835.642361111111000000
          414.513888888888900000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 667
        Top = 398
        Width = 188
        Height = 6
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          13.229166666666670000
          1470.642361111111000000
          877.534722222222300000
          414.513888888888900000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNomeTitular: TQRLabel
        Left = 52
        Top = 451
        Width = 372
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          994.392361111111200000
          820.208333333333200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'LabelNomeTitular'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNomeTitularPrint
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 7
      end
      object LabelEndereco: TQRLabel
        Left = 52
        Top = 467
        Width = 372
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          1029.670138888889000000
          820.208333333333200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'LabelEndereco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelEnderecoPrint
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 7
      end
      object LabelCidade: TQRLabel
        Left = 52
        Top = 482
        Width = 372
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          1062.743055555556000000
          820.208333333333200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'LabelCidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelCidadePrint
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 7
      end
      object QRShape1: TQRShape
        Left = 666
        Top = 205
        Width = 4
        Height = 243
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          535.781250000000000000
          1468.437500000000000000
          451.996527777777800000
          8.819444444444444000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelInformacao1: TQRLabel
        Left = 108
        Top = 212
        Width = 296
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          238.125000000000000000
          467.430555555555600000
          652.638888888889000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'AT'#201' O VENCIMENTO PAGUE PREFERENCIALMENTE NO ITA'#218
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
        Left = 143
        Top = 271
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          315.295138888888900000
          597.517361111111200000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 330
        Top = 269
        Width = 1
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          63.940972222222230000
          727.604166666666800000
          593.107638888889000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape6: TQRShape
        Left = 413
        Top = 269
        Width = 1
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          63.940972222222230000
          910.607638888889000000
          593.107638888889000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape8: TQRShape
        Left = 164
        Top = 299
        Width = 1
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          63.940972222222230000
          361.597222222222300000
          659.253472222222300000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 221
        Top = 299
        Width = 1
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          63.940972222222230000
          487.274305555555600000
          659.253472222222300000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape12: TQRShape
        Left = 578
        Top = 294
        Width = 1
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          63.940972222222230000
          1274.409722222222000000
          648.229166666666600000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape16: TQRShape
        Left = 667
        Top = 421
        Width = 187
        Height = 6
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          13.229166666666670000
          1470.642361111111000000
          928.246527777777900000
          412.309027777777900000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape17: TQRShape
        Left = 312
        Top = 299
        Width = 1
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          63.940972222222230000
          687.916666666666600000
          659.253472222222300000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel40: TQRLabel
        Left = 7
        Top = 311
        Width = 145
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          15.434027777777780000
          685.711805555555700000
          319.704861111111200000)
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
        Top = 269
        Width = 1
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          63.940972222222230000
          1031.875000000000000000
          593.107638888889000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel42: TQRLabel
        Left = 440
        Top = 280
        Width = 10
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888890000
          970.138888888888900000
          617.361111111111100000
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
      object QRShape9: TQRShape
        Left = 3
        Top = 860
        Width = 853
        Height = 6
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          13.229166666666670000
          6.614583333333332000
          1896.180555555556000000
          1880.746527777778000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRImage2: TQRImage
        Left = 7
        Top = 173
        Width = 124
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          66.145833333333340000
          15.434027777777780000
          381.440972222222200000
          273.402777777777800000)
        AutoSize = True
        Picture.Data = {
          07544269746D6170C63F0000424DC63F00000000000036000000280000009600
          0000240000000100180000000000903F00000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFAF7F3FFFBF6F8F2EDFFFEFAFFFCF9D7C3BE9D8482
          7D61607D5F5E7F605F7F5F607F5E627E5F627C5E637C5D647A5F637D5F647D5F
          647D5F647D5F647D5F647D5F647D5F647D60637C5F627D60637D60637C5F627B
          5E617C60607E61648165658E6F70F0D4D4FFFCFBFFF9F7FFFAF7F9F8F4F2F7F5
          FAFFFEFBFFFEFBFFFEFDFFFEFDFFFEFDFFFFFDFFFFFDFFFFFDFFFFFEFEFEFEFE
          FEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFBFFFDF7FFFFF9E4D0CB836A663E20
          1B3815124F282639100E3B0F103C10113D10133C10163A1116390F16390F163A
          10173A11163A11163A11163A11163A11163A11163A12143A1214381012370F11
          370F113911133A12133A12143A1214431B1D300B0D6E4F50DDC5C5FFFEFCFDF6
          F3F9F8F4FFFFFCFDFFFEFFFFFEFFFFFEFFFFFEFFFFFEFDFFFEFDFFFEFDFFFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFF9F4FFFEF9F2D9D580635E51
          2E2A49201D2F02005524224C16164F161750171A4E171A4E161B4C161D4B141D
          49151C49151C49151C49151C49151C49151C49161A49161A49161A4A171B4815
          194613174715174917194A181A4816184614164F1D2140131647202278595AD7
          C2C1FFFEFCFFFEFBF9F6F2FFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFE
          FFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFF6F1FFEEE9B99994
          542F2B4419165C2C285D2623561B195B1B1B5C1A1B5D1A1D5C191E5B171E5916
          1D55141D52131C53141D53151B53151B53151B53151B53151B53151B53161A53
          161A53161A53161A54171B54171B5317185115164E13174B11163E080D401316
          4A2527775B5BFFEBEAFFFEFCFAF3F0FFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFF
          FEFFFFFEFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFEF7FFE5
          DE704B4350231F69383A49171B532322501A196121206121215B1F25571E2651
          1C264B192349172145161F45192045192045182147182147182147191F471B1C
          4B1B1A511819561A1B591B21521C23461A2040181D45171D45161E4619224E23
          2C451D223A13154B2525EFD1D0FFF4F2FFFEFEFFFEFFFFFEFFFFFFFEFFFFFEFF
          FFFEFFFFFEFFFFFEFDFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFF2CEB9AA6C42356A37345928363B14242E141A2E100F44120C521D1A47252C
          2B17241A0D1D09020F160F1C1F1C252023280D0F17120E1A110A190500091A14
          191514101C1109310B064F1C1A511D24401E280C0D170008120D06131609190E
          02161808191801093D1B1B592322C79795FFF4F1FFFFFFFEFDFFFCFEFFFFFFFF
          FDFEFCFFFFFCF9FFFAF8FFFFF5FDFCFDFFFFFDFDFDFFFFFFFEFEFEFFFFFFFFFF
          FFF7F7F7FFFFFFFFFFFFFCFCFCFFFFFFFFFFFFFDFDFDFFFFFFF9F9F9FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFF5F5F5FFFFFFFDFDFDFFFFFFFCFCFCFFFFFFFEFEFE
          FFFFFFFFFFFFFCFCFCFFFFFFFFFFFFFEFEFEFFFFFFF8F8F8FFFFFFFCFCFCFFFF
          FFF7F7F7FFFFFFFFFFFFFFFFFFFBFBFBFFFFFFFFFFFFFCFCFCFFFFFFFAFAFAFF
          FFFFFFFFFFFDFDFDFFFFFFFDFDFDFFFFFFFAFAFAFFFFFFFFFFFFFFFFFFFFFFFF
          FCFCFCFDFDFDFAFAFAFFFFFFFFFFFFFDFDFDFFFFFFFEFEFEFFFFFFFFFFFFFFFF
          FFFFFFFFFBFBFBFFFFFFFDFDFDFEFEFEFFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFF
          FFFFF5F5F5FFFFFFFFFFFFFDFDFDFFFFFFF9F9F9FFFFFFFAFAFAFFFFFFFFFFFF
          FFFFFFF4F4F4FFFFFFFDFDFDFDFDFDFEFEFEFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDEAB9AA976038265D2E2A5F4251584F634252581D2B2729170C4330
          293F454C435A693D606E456D7900242C001B2326585E3D707A4975862A546700
          212F0232382653501431281B150E3723224032383E4754487A863877851A4E5B
          001C2D30576D415F702C383E1E110F451814B58682FFFBF8FCFCFCFDFEFFF5F6
          FAFFFFFFF7F5F4FFFFFCFBFFFCF6FFFFF6FFFFF8FDFCFFFFFFF6F6F6FBFBFBFF
          FFFFF7F7F7FFFFFFFDFDFDFDFDFDFCFCFCFBFBFBFFFFFFEEEEEEFFFFFFFFFFFF
          FEFEFEFDFDFDFFFFFFFCFCFCFEFEFEFFFFFFF0F0F0FFFFFFF8F8F8FFFFFFFFFF
          FFFFFFFFF4F4F4FFFFFFFFFFFFFBFBFBFFFFFFFCFCFCFDFDFDFEFEFEF8F8F8FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9F6F6F6FFFFFFFFFFFFFCFCFCFFFFFF
          FFFFFFF8F8F8FFFFFFFFFFFFFDFDFDFFFFFFFFFFFFFFFFFFF7F7F7FEFEFEFCFC
          FCFBFBFBFFFFFFFFFFFFF7F7F7FDFDFDFFFFFFFFFFFFF8F8F8FFFFFFF6F6F6FF
          FFFFFFFFFFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFF9F9F9FBFBFBFFFFFFFAFAFA
          FDFDFDFFFFFFFFFFFFFEFEFEF5F5F5FBFBFBFFFFFFFFFFFFF5F5F5FFFFFFF3F3
          F3F8F8F8FFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFFFFFFF7F7F7FFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFF0AC9E88572F1D55362D858E97A5D3DE87D4D127716500
          23131E3C2F6DA9A98EDEE58FEAEF80DBDF00494A277A7B6CCED474DCE975D5EC
          67CBE32D9DAF47B6C084E3E6428B890016150A2D30699DA48CD6E27BE4F163DE
          E85FDEE61E9AA25CC9D771CBD63D7D7D01201932221B92766FFFFDF9F6F7F5FB
          F8FAFFFEFFFBF3F4FFFEFEFFFFFCFDFBFAFBFFFFF2F7FAFDFFFFF9F9F9FFFFFF
          FDFDFDDEDEDEECECECFFFFFFFFFFFFE4E4E4EDEDEDFAFAFAFFFFFFFFFFFFFBFB
          FBFCFCFCFDFDFDFBFBFBFFFFFFFAFAFAF5F5F5FDFDFDFFFFFFFFFFFFEFEFEFDF
          DFDFD7D7D7FFFFFFFFFFFFFFFFFFF8F8F8FFFFFFE9E9E9EBEBEBE0E0E0FFFFFF
          FFFFFFFCFCFCFEFEFEFFFFFFF1F1F1FBFBFBFFFFFFFFFFFFFFFFFFF9F9F9FFFF
          FFFFFFFFF5F5F5FFFFFFE8E8E8DCDCDCFCFCFCFFFFFFDFDFDFE7E7E7FFFFFFFF
          FFFFE2E2E2F1F1F1FFFFFFF4F4F4F8F8F8E3E3E3F6F6F6FBFBFBFFFFFFFFFFFF
          FFFFFFFAFAFAFFFFFFFCFCFCFBFBFBF4F4F4F9F9F9F5F5F5C5C5C5C9C9C9CACA
          CAF5F5F5FFFFFFF6F6F6FFFFFFF3F3F3FFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFB
          FBFBFFFFFFFEFEFEFEFEFEF9F9F9F6F6F6FFFFFFFDFDFDFFFFFFFBFBFBF7F7F7
          0000FFFFFFFFFFFFFFFFFFFFFFEBAB96815F3A2643312664898D85D5DC70DED8
          00685B002C1B23615580D8D860C6CB4CB4B92186880055526ACDCB63DEE255D0
          DE127992228DA840C3D75CE6F355D0D4177B7B00282821646779CFD580E5ED53
          C6D127A3AD39BEC24FD7DD59E1ED66DFE926808000261E333127846F67FFFDF8
          FCFDFBFFFEFFFCF5F84C41430D01010900000700000703082C2B2F969597FFFF
          FFF7F7F74545450000000404046565655A5A5A000000090909FFFFFF33333300
          0000A3A3A3FFFFFFFFFFFF262626000000C8C8C8FFFFFFFCFCFCE9E9E9525252
          0000000000001111110D0D0DFCFCFCFAFAFAEAEAEA5050500303030000000000
          00363636D6D6D6FFFFFFFEFEFEF8F8F8FFFFFFFFFFFFF3F3F345454500000086
          8686FBFBFBFFFFFFE5E5E5272727000000070707BDBDBD383838000000000000
          6969695B5B5B020202030303FFFFFFCECECE1010100303030D0D0DB9B9B91B1B
          1B000000E3E3E3FFFFFFF8F8F8FFFFFFFFFFFFFFFFFFC4C4C40A0A0A00000000
          00000000000D0D0D8E8E8EFFFFFFA5A5A50202021C1C1CF8F8F85E5E5E0E0E0E
          FFFFFFFFFFFFFAFAFAF8F8F8FFFFFFF7F7F7101010050505C9C9C99797970202
          022626260000FFFFFFFFFFFFFFFFFFFFFFEDB1927D64412D3D352857878B79D3
          DA6FDDDB00635A002C201D665E71CFD47AD9E3539FAB00111800424194EBE755
          CDCD097A84000823001D3C005F765DDDEA6BE9EA23928E001B17317E7B84E1E0
          7ED9DD227077003239003D413082875FD6E55FD9E717717200272137312A8871
          69FFF9F2FCFFFBFFFFFFFFFEFF4B46450900005D514F7E72723C303609010815
          1214BEBEBEA9A9A9050505222222BCBCBC6A6A6A000000000000AEAEAEFAFAFA
          494949000000A7A7A7F1F1F1FCFCFC1C1C1C000000B3B3B3FFFFFFFEFEFE3D3D
          3D050505252525B1B1B1AEAEAE8C8C8CFFFFFFFFFFFF4444440000005E5E5ED9
          D9D9828282000000232323FBFBFBF6F6F6FFFFFFFFFFFFFFFFFFFFFFFF444444
          000000808080FFFFFFFFFFFF7B7B7B000000272727B5B5B5A5A5A50606062424
          24B7B7B7686868070707000000B2B2B2F9F9F95454540202023838386D6D6D18
          18180D0D0D0F0F0FD6D6D6FAFAFAFFFFFFFBFBFBFCFCFCFFFFFFC1C1C15B5B5B
          ACACACB8B8B8A3A3A30C0C0C000000B1B1B1979797060606171717FFFFFFB4B4
          B4000000B2B2B2FEFEFEFEFEFEFFFFFFFAFAFA9B9B9B0404041E1E1EFFFFFFA0
          A0A00101012323230000FFFFFFFFFFFFFFFFFFFFFDEA9F806B4E2D1A322E2355
          8F9484E6EE75E6E8006862002921135D5975D4DE71CCDB468292001F2A144445
          83CAC775E6E848B8C40B506B00234100384F35BCCA50D0D51B8B8B002D2A3387
          8581E3E37AD4D5063D46001D26112A2E2D5D6377DDEF72E2F427757B02272339
          2B25957871FFFCF5FCFDF9F9F9F9FCFCFC413F3E090602A19A97FFFDFFFFFBFF
          1B131A020001A4A4A4ADADAD000000636363FFFFFFFFFFFF252525030303FDFD
          FDF9F9F93E3E3E0D0D0D999999FFFFFFFFFFFF1B1B1B0E0E0EC5C5C5F9F9F9DB
          DBDB000000010101EBEBEBFFFFFFFFFFFFFFFFFFFFFFFFD2D2D2000000080808
          F1F1F1FAFAFAFAFAFA262626000000A1A1A1FFFFFFFFFFFFF9F9F9FAFAFAFFFF
          FF404040000000868686FFFFFFFFFFFF6161610000008A8A8AFFFFFFA9A9A902
          0202545454FFFFFFFFFFFF181818000000FFFFFFFDFDFD414141040404A4A4A4
          FFFFFFB6B6B6020202040404DEDEDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFB
          FBFFFFFFFFFFFFFFFFFFFFFFFF5C5C5C010101676767ECECECBABABACECECEFE
          FEFEFFFFFF202020484848DFDFDFDEDEDEE0E0E0E8E8E8363636000000939393
          F4F4F4E4E4E4C8C8C8CACACA0000FFFFFFFFFFFFFFFFFFFFFFF0A08F7A5E3D2D
          3D362D45838B6ED4E05DD3D8006263003E3D0D4D5178D4E57FDAEF508A9D0B2E
          3B0F2A2E48797B66CED359D4E262D1EB37B3D1009AB238DDEE61E3F0157E8700
          2B31318C906AD6DA6DCBD1255561263744141C2328444F7CCFE574D1E636717A
          0A1E1F41221FA17772FFFDF8FFFFFCFDFFFEFBFFFF3A413E050B06929593FDFD
          FDFFFDFF000006050406B7B7B7DDDDDD2323230000006D6D6D9D9D9D11111103
          0303F4F4F4FFFFFF4646460000009F9F9FFFFFFFFEFEFE242424000000B4B4B4
          FFFFFF9E9E9E0000002A2A2AFEFEFEFFFFFFFEFEFEFFFFFFF8F8F89F9F9F0909
          09222222FCFCFCFFFFFFFFFFFF505050060606838383F7F7F7FFFFFFFFFFFFFF
          FFFFF7F7F7404040080808787878F8F8F8FFFFFF5B5B5B040404737373F9F9F9
          EEEEEE1010100B0B0B6C6C6C979797141414040404FCFCFCF8F8F84747470000
          00C6C6C6FAFAFAFFFFFF171717000000DBDBDBFFFFFFFDFDFDFCFCFCFBFBFBFD
          FDFDFFFFFFF4F4F4F7F7F7FFFFFFDDDDDD232323010101707070F9F9F9FFFFFF
          FCFCFCF8F8F8F8F8F87E7E7E0303030303030707070000000000000000000101
          01F6F6F6FFFFFFFFFFFFF3F3F3FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFEE9488
          765330223A30294C87907BE3F064DCE200676B002C2F1C646C65CEE16FDAEF44
          899A001C28283D3F042B2D004F5408828E2FA6BC2CB1CC2AD0E737DBEE56D0E0
          29899600343B297B807DE3E87FDBE003343E051A22282E33435D6485D1E773CA
          DE4279801624234D28249E6E6AFFF5F0FFFBF8FEFFFDF9FEFD363F3C0003007A
          8380A6AEAD3B414601040C5C5E5FFDFDFDFDFDFDE1E1E17878783A3A3A252525
          070707000000FFFFFFFFFFFF3C3C3C020202A0A0A0FCFCFCFFFFFF1D1D1D0505
          05C6C6C6F8F8F8A5A5A5040404292929FFFFFFF9F9F9FFFFFFFDFDFDFFFFFFA2
          A2A2000000232323FEFEFEFCFCFCFDFDFD565656000000878787FFFFFFFAFAFA
          FFFFFFFFFFFFFFFFFF404040000000868686FFFFFFF9F9F95E5E5E0000007F7F
          7FFFFFFFF6F6F6E9E9E97272723D3D3D252525060606000000FFFFFFFFFFFF3E
          3E3E040404BBBBBBFFFFFFF6F6F62A2A2A000000E6E6E6FCFCFCFCFCFCFFFFFF
          FFFFFFFDFDFDFBFBFBFFFFFFFBFBFB9898981C1C1C000000070707C7C7C7FFFF
          FFFDFDFDFEFEFEFFFFFFFFFFFFDBDBDB0000005F5F5FC2C2C2C1C1C154545403
          03034C4C4CFCFCFCFFFFFFFCFCFCFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFF49686795D372B41302D5286927BDCEA6ADFE8005B61003B3F04646A47D0E0
          4DD7E93291A000252D0A2C2B5F8B85348B880A727700354800364E00687C44CB
          DB6CDBE52A828800363A36767797EAEB8ADCDD003C3E18403F22333037595976
          CFDD6DD0DE3778791E342F4828229B6D66FFFBF5FFFEFAFFFDFEFEFEFE383D3B
          000300000200000806011215A0ACB0F9FDFEFDFDFDFFFFFFFAFAFAFFFFFFFFFF
          FFF7F7F7131313000000FFFFFFFFFFFF3D3D3D000000444444FFFFFFFEFEFE19
          1919000000C5C5C5FDFDFDD3D3D3000000000000DBDBDBFFFFFFFFFFFFF5F5F5
          FCFCFCDCDCDC000000030303F0F0F0FCFCFCFFFFFF191919000000A6A6A6FFFF
          FFFAFAFAFFFFFFFFFFFFFFFFFF424242000000828282FFFFFFFFFFFF58585802
          02027F7F7FFFFFFFFFFFFFFFFFFFFCFCFCFFFFFFFAFAFA111111030303FFFFFF
          F8F8F8434343000000C1C1C1FFFFFFFFFFFF272727000000E4E4E4F9F9F9FBFB
          FBFFFFFFFAFAFAFBFBFBFFFFFFE4E4E43F3F3F000000000000232323B4B4B4FE
          FEFEFFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFF4040402F2F2FFFFFFFFBFBFB
          222222000000B3B3B3FFFFFFFEFEFEFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDF3998378623A2E4A373457848F7AD2E06EDBE3006B6E086A6A5AC8
          CC4CE6F147DEEC6BD5E078BBBE3F615B4F71678ED2C787D9D46FBAC263B5C160
          C4D077DAE284CED237706F113632578079A2DED88ECEC810443D1C3F35232D21
          374E4999E7EE7FD7DE38716E1B2C2349291EA5776FFFFEF8FFFAF6FFFEFFFCFA
          FA3E413F030904757E7BA0ABA919282B051115C2C6C7FAFAFAFCFCFC7B7B7B90
          9090C4C4C4979797000000131313FFFFFFF7F7F73D3D3D0000002222222C2C2C
          4747470000000D0D0DE2E2E2F6F6F6FFFFFF4E4E4E0202022727279393939B9B
          9B7B7B7BFDFDFDF9F9F9515151000000474747B9B9B96B6B6B000000292929FF
          FFFFFDFDFDFFFFFFFBFBFBF5F5F5FCFCFC424242000000888888FDFDFDC8C8C8
          4646460000005757579B9B9BEEEEEE6D6D6DA0A0A0B5B5B59494940101010808
          08FEFEFEFFFFFF424242000000C5C5C5F4F4F4FFFFFF1111110E0E0ED6D6D6FF
          FFFFFFFFFFF0F0F0FFFFFFFFFFFFF6F6F63333330000000F0F0F727272EAEAEA
          FFFFFFFFFFFFFAFAFAFFFFFFFEFEFEFFFFFFFBFBFBFDFDFDA0A0A0040404D1D1
          D1B4B4B4020202191919F6F6F6FFFFFFF9F9F9FFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFCF7A382795F35294B38336687908DD5E17BDCE006716F16
          7C775FD6D540DEE440D6E06FD1D98BC1C2394C432D3A2A81A79198D1BC9AE2D6
          95E3DC94DBD880B3AF81938C4443393637277A8674B4D8C7B0D7C73C57472931
          20422E1C6F675A9CC5C791C6C9607F783F3E3051271A9A695FFFF8F0FEFAF5F9
          F7F7FFFEFF3C3A3A020000A2A19DFFFFFEB5B8BC04070B1C1E1FF9F9F9FAFAFA
          7D7D7D171717000000000000202020BFBFBFF7F7F7FEFEFE6565651C1C1CA0A0
          A06060600909090202027D7D7DFCFCFCFFFFFFFBFBFBF1F1F16868680C0C0C08
          0808000000383838FFFFFFFAFAFAEAEAEA7474740909090000000505054C4C4C
          F7F7F7F2F2F2FBFBFBFFFFFFFCFCFCFFFFFFFFFFFF474747020202868686F6F6
          F69E9E9E010101060606090909242424E9E9E97E7E7E1414140000000000001C
          1C1CB5B5B5FFFFFFFBFBFB5555551F1F1FC4C4C4FFFFFFFCFCFC4444441B1B1B
          E3E3E3F5F5F5FFFFFFFFFFFFFFFFFFFFFFFFC1C1C1020202040404C0C0C0FFFF
          FFFFFFFFFFFFFFFFFFFFFAFAFAFFFFFFFCFCFCFFFFFFFDFDFDF7F7F7F7F7F710
          10106A6A6A575757000000777777FDFDFDF4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFDF8A889805E37294A372F6A878C9BDAE284DADA
          0B6A6300463E056D6653DEE15DE2E934888D19403E413D3242332032321A3D4F
          383D62523660553F5E57444C455A4137542D1F532F1D462E1A2F2F1D3A443321
          28193A3B2B4136223027193139383A44443331263E25155D2919A47365FFFDF4
          FCFDF9FDFFFFF8F9FD423D3E080000A39A97FFFEFEB6AFB2050106000001FFFF
          FFFEFEFEFFFFFFF7F7F7F1F1F1EEEEEEF8F8F8F2F2F2FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFAFAFAF5F5F5F5F5F5FFFFFFFFFFFFFFFFFFF9F9F9FFFFFFF7F7F7
          FFFFFFE0E0E0FDFDFDFEFEFEFFFFFFFDFDFDFFFFFFEFEFEFFFFFFFE2E2E2FCFC
          FCFCFCFCF2F2F2FFFFFFFDFDFDFEFEFEFFFFFFF4F4F4FEFEFE3E3E3E0404047E
          7E7EFFFFFFECECEC6666660303037B7B7BFFFFFFFFFFFFFDFDFDFDFDFDF1F1F1
          E5E5E5FAFAFAFFFFFFFFFFFFFBFBFBFFFFFFFDFDFDFFFFFFF5F5F5FFFFFFFFFF
          FFFFFFFFFFFFFFF9F9F9FFFFFFF4F4F4FFFFFFF9F9F9CCCCCC060606111111FF
          FFFFFFFFFFF0F0F0FCFCFCFFFFFFFFFFFFFFFFFFF8F8F8FFFFFFFFFFFFF8F8F8
          FFFFFF606060131313151515000000D5D5D5FBFBFBFDFDFDFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFBF1A49386603E2E4E3B2E6F8785A4E0
          DF8BDED51D6E5F00372A2362586ED0D063C8CA64A9A620392F5231216C34215B
          301D502D1F4C2E294024243A20204D2C294D1C14692C22752F227232275A2A24
          51342F403D357484797292813447383823214A211F4D2114602D19753321AB77
          67FFFBEFF4FEF8F2FBFEF7FDFF4A47490700003B2D2E3628290B000007000152
          5050F4F4F4FFFFFFF1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFBFBFB
          F6F6F6FEFEFEFDFDFDFFFFFFFFFFFFFCFCFCFAFAFAFFFFFFF9F9F9FFFFFFF9F9
          F9FEFEFEF8F8F8FAFAFAFFFFFFF6F6F6FCFCFCFFFFFFF3F3F3FFFFFFFFFFFFF6
          F6F6FFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFEFEFEF9F9F9FFFFFFFFFFFF3C3C3C
          000000787878FFFFFFFFFFFFD2D2D29E9E9EC5C5C5FBFBFBFDFDFDFFFFFFF5F5
          F5FFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFBFBFBFFFFFFAAAAAA535353E8
          E8E8FEFEFEFAFAFAFAFAFAFEFEFEFFFFFFFFFFFFFAFAFAFFFFFFF5F5F51D1D1D
          0505054444447A7A7A545454343434FDFDFDFFFFFFFDFDFDFBFBFBFDFDFDFFFF
          FFFFFFFFFBFBFBC4C4C40101010000002D2D2DFFFFFFFFFFFFFFFFFFFDFDFDFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFF5A494845C3D285943317F
          8E86B6E0D9A0DBCC42766431443353675BA1D7D79AD8D86B958E313425723B26
          8030196A240D601E0C66221B682726632A29733C376024187533216F21117223
          166A211D59232250323190908ABDDACBA6B7A9673F3A6D2C246429166C2E166E
          2A13A2705CFFFDF0F3FFFCEDFCFEF6FEFF7D7C80665E5F6F63635F5351766E6E
          A19C9DF7F5F5FFFFFFFCFCFCF6F6F6FFFFFFFEFEFEF7F7F7FFFFFFFDFDFDFFFF
          FFFBFBFBFFFFFFFFFFFFF5F5F5FFFFFFF7F7F7FFFFFFFFFFFFF7F7F7FFFFFFFB
          FBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFAFAFAFFFFFF
          FCFCFCFFFFFFF8F8F8FBFBFBFAFAFAF9F9F9FBFBFBFFFFFFFFFFFFFFFFFFF1F1
          F18C8C8C656565AFAFAFFFFFFFFFFFFFF9F9F9FFFFFFFBFBFBFFFFFFFFFFFFFB
          FBFBFFFFFFFAFAFAFAFAFAFFFFFFF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          4444442C2C2CE7E7E7FFFFFFFFFFFFF8F8F8F8F8F8FFFFFFFAFAFAFDFDFDFDFD
          FDF1F1F15959592424241919193535355A5A5AFEFEFEFFFFFFFAFAFAFFFFFFFD
          FDFDFBFBFBFFFFFFFDFDFDFFFFFF6C6C6C686868B3B3B3FFFFFFFEFEFEF8F8F8
          FDFDFDFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFF5AC92825F4027
          654B33797368959E948C9E8D5D644F5A4230674F437880807E9091696B65573D
          2D843A228C32148F3F20843A1E7C301E742D1F652A1B602B175D280D5F28096B
          2D0F6B2910742D1F752F2868252270403C8A7A6E9485758A594F76392B662E15
          652F116B2F12A87E67FFFFF4E7FBF6F1FFFFF4FDFFFDFDFFFFFEFFF9F4F1FFFF
          FCEDF4F1F5FEFBF3F5F5FFFFFFFBFBFBFFFFFFFEFEFEFFFFFFFFFFFFFEFEFEFF
          FFFFF3F3F3FFFFFFFAFAFAFAFAFAFFFFFFF9F9F9FFFFFFFDFDFDFFFFFFFFFFFF
          FFFFFFFDFDFDFBFBFBFEFEFEFAFAFAF8F8F8F9F9F9FFFFFFFBFBFBF9F9F9FFFF
          FFF8F8F8FFFFFFFFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFFFDFDFDFDFDFDFE
          FEFEFFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFDFDFDFFFFFFFBFBFBFFFFFFF6F6F6
          F7F7F7FFFFFFF9F9F9FFFFFFFDFDFDFCFCFCFFFFFFFFFFFFFFFFFFFAFAFAFFFF
          FFFFFFFFE0E0E0777777AFAFAFFFFFFFF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFDFDFDFAFAFAFDFDFDFCFCFCFFFFFFF8F8F8FFFFFFFFFFFFFDFDFDFDFDFD
          FFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFFF6F6F6F9F9F9FFFFFFF7F7F7FFFF
          FFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFBF2B693
          85724D376F4D365A3D2F4E362A5B453360402D7844336F3B2E573A36533E3C55
          382F703F2F94442D8D3315843514883C1F83351E8138247A3B26652C137D4627
          6E3815804727783A1C76311D7C31238231297129216134266035246E2F21702C
          19773B2370391E602A119E7965FFFFF7F5FFFDF6FFFFF5FBFFFAFAFFFFFEFFFF
          FDFCFDFFFEF3FEFBF6FFFFFBFFFFFCFCFCFFFFFFFAFAFAFFFFFFFAFAFAFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF3F3F3FFFFFFFEFEFEF5F5F5FFFFFFFFFFFFFCFC
          FCFBFBFBFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF9F9F9FFFFFFFF
          FFFFF8F8F8FFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFEFEFEFCFCFCFBFBFBFFFFFF
          FBFBFBFBFBFBFFFFFFF2F2F2FDFDFDFFFFFFF9F9F9FDFDFDFAFAFAFFFFFFFBFB
          FBFFFFFFFDFDFDFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFFFFFFFF
          FFFFF6F6F6FFFFFFFAFAFAFFFFFFF9F9F9FAFAFAFFFFFFFDFDFDFBFBFBFFFFFF
          FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFBFBFBFFFFFFFAFAFAFFFFFFFDFD
          FDFFFFFFFAFAFAFFFFFFFFFFFFFDFDFDFEFEFEFBFBFBFFFFFFFFFFFFF6F6F6FF
          FFFFFBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          F5EFB68F877E51447E4A3D7841347940318348387D3F2D864334844335784138
          7641377840357E3F318B3F2D8E3F2A8D432B8A422A883F29843E27803D267E3E
          267E3E257E3F23824027813F26813D26833C28833B29803B28773A2678392585
          3524833120823A28773927693528A27E74FFFAF4FFFCFBFFFEFFFFFEFFFFFEFF
          FFFEFFFFFEFFFDFFFFFBFFFFFBFFFFFCFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDF8BE9893895B538B554A8E4D3F924C3B9D5341964C3A924C3B914C
          3D8D4C3E8D4C3E8D4C3E8D4A3B8F49388E49368F4A368D4A358D48348B48338B
          46328946318A45318946318C47338A47328A45318845308A453188453087422E
          8A412D96402E913A2A8D42327D40326B3D32A3817BFFF9F7FFFBF9FFFEFFFFFE
          FFFFFDFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFEFEFEFEFEFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFBF4BB9E958A64588E5F51925A49985846A15D4A9B574495
          554394564692574893584992574792564693534194523F96544195534096523F
          93513E94503D92503D94503D92503D97534094523F95513E93513E95513E9250
          3D924E3B944C3A9B4C39964837934E3D834C3D71493DA4897FFFFBF6FFFDFAFF
          FEFFFFFFFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFFFFFEFEFEFEFEFEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFCF4BFA99E9373669A7162A06E5CA56C57AB6F59
          A66A54A36854A068559F69589D69589F69589D6854A06752A06551A46654A365
          53A56553A26452A46452A26452A36351A16351A1614F9E604E9F5F4D9D5F4D9F
          5F4D9C5E4C9C5C4A9C5A48A158449D5543955A47885747795649A89287FFFCF6
          FFFDFAFFFFFEFFFFFFFFFEFFFFFEFFFFFEFFFFFFFFFFFFFFFFFFFFFEFEFEFEFE
          FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFAEEC0AFA2987F6FA07F6CAB7E69AD7B
          64B07A63AC765FAC7762A97763A67762A37661A47560A77561AA7560AD7661AC
          7461AC7463AE7363AB7362AD7262AA7261AC7161AA7261AC7161A97160AA6F5F
          A76F5EA96E5EA66E5DA66B5BA56A57AA6954A667529E6955916655836658AC9A
          8FFFFEF7FFFDFAFFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFFFEFFFFFEFFFFFFFEFF
          FEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFCF0C7B7AAA18A7AA98976B5
          8B74B6846DB88269B68067BB8671B78670B3846FB0836EB1826DB4836DB7856E
          BA8570B6836FB68271B68271B58170B58170B4806FB37F6EB27E6DB27E6DB17D
          6CB07C6BAF7B6AAF7B6AAD7968AB7766AE7663B47862B37761A976629C746290
          7365B4A297FFFEF7FFFEF9FFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFE
          FFFFFEFFFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFF5D5C4B7AF9585
          B4907EC1927CC08C75C28A71C28A71C7907BC48F7AC18E7ABF8D79C08E78C38E
          79C69079C68F7AC18F7BBF8F7DBF8F7DBE8E7CBD8D7BBC8C7ABB8B79BA8A78B2
          8270B1816FB0806EAF7F6DAE7E6CAD7D6BAB7B69AC7965B57864B67965AB7864
          9F776596796BB7A59AFFFFF6FFFDF8FFFFFEFFFFFEFFFFFFFFFFFFFFFFFEFFFF
          FEFFFFFEFFFFFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFEF3D4BE
          B2AC8D7EAE8674BA8773BA816BBB7F69BF806BBB806CBA816CB9816EB9816EB9
          816EBB826DBD806CBB806CB98470B68470B68472B5836FB48270B2806CB17F6D
          B07E6AB17F6DB07E6AAF7D6BAE7C68AD7B69AC7A66A97765AD7562B1725EB374
          60A973629F746399796CB9A59AFFFCF4FFFCF7FFFFFCFFFFFEFFFFFFFFFFFFFF
          FFFEFFFFFEFFFFFCFFFFFCFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          F5EEDFC2B9A07D70A07463AD7562BD7E69A7644FC27F6AB2705DB0705EAE7060
          AE705EAF715FB1725EB5715EB3715EB0735FAE735FAD725FAD725EAC715EAC71
          5DAB705DAB705CAC715EAC715DAB705DA96E5AA76C59A56A56A56A57A86B57AC
          6754AF6B58A368588B5C4E987568B59C92FFFDF7FBF5F0FFFFFCFFFFFEFFFFFF
          FFFFFFFFFFFEFDFFFEFDFFFCFDFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDF8DEBFB6896259A576689B60509C5A47B06B589A5542A35E4DA15E
          4F9F5E4F9F5E4FA15E4FA35E4DA45E4DA45F4CA6614EA5614EA4604DA4604DA3
          5F4CA35F4CA25E4BA25E4B9E5A479E5A479E5A479D59469C58459B57449C5845
          9E59469B5341985342965B4C8F60526E4B3EBEA49DFFF6F0FFFFFCFFFFFEFFFF
          FEFFFFFFFFFFFFFDFFFEFDFFFEFBFFFCFBFFFCFDFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE
          FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFDF9FEE1DA89625A8454488F54458A4A389C574696503F91
          4C3D8F4B3E8C4B3D8A4B3D8C4B3D8D493C90493B924A39964A38964A38964A38
          9549379549379448369448369448369145339145339145339044328F43318F43
          318F43318E4432873F2E7C3C2A773E2F7C4F427A574DF3DBD5FFF9F6FFFCF9FF
          FFFEFFFFFFFFFEFFFFFFFFFDFFFEFDFFFEFBFFFCFBFFFCFDFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFF6F3FFF5F1AA8882693F337D483B884D3D6D2F1F
          8241327A3B2D783A2F763A2E76392F75382E76382D7B372A7D38298139288338
          288237278237278237278237278136268136268237278237278237278035257E
          33237D32227E33237C34237634227E4333693528532B1F91746BFFF6EFFFFEFA
          FEF6F6FFFEFFFFFFFFFFFEFFFFFEFFFDFFFFFDFFFEFBFFFEFBFFFEFDFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFCFFFFFBF3DDD79D7E755D33276130
          225E291C723B2E622D20612D215E2B215E2B215D2A205F2B1F63281E65291D68
          2B1D6A2B1D6A2B1D6A2B1D6A2B1D692A1C692A1C692A1C6A2B1D6A2B1D6A2B1D
          68291B67281A66271967281A65281A6831225A2919592F22927267EBD6CEFFFF
          F9FFFAF7FFFFFEFFFFFFFFFEFFFFFEFFFFFEFFFFFFFFFFFFFEFDFFFEFDFFFEFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFF8F8F8FAF7F3FFFDF7E5D0C88F
          6F646A4335673B2E55281B562A1D542A1E52292052292051281F53291D56281D
          58281C57271B57271B57271B57271B57271B57271B57271B57271B56261A5727
          1B58281C57271B57271B57271B59291D582B1E5328195B3727876A5CEED8CCFF
          FFF7FFFCF5F4F3EFF5F7F7FDFFFFFDFFFFFFFEFFFFFEFFFFFEFFFFFFFFFFFFFF
          FFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFF6FFFFFAFFFEFFFFFA
          FFFFF8FFF9EEE9CCBEBE9D8E8E6D5E98786B96786D93766D93766D95766D9777
          6C9A776A9A776A93756A91756A91756A91756A91756A91756A91756A92766B90
          746991756A92766B92766B92766B92766B94786D957A6CA18475E6CCBBFFF7E8
          FFFFF5F2EDE4FFFFFAFBFFFEF7FDFCFAFFFFFBFEFFFDFEFFFFFEFFFFFEFFFFFE
          FFFFFEFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
        Stretch = True
      end
      object QRShape13: TQRShape
        Left = 667
        Top = 356
        Width = 188
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          1470.642361111111000000
          784.930555555555700000
          414.513888888888900000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel6: TQRLabel
        Left = 170
        Top = 311
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
          685.711805555555600000
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
        Left = 686
        Top = 221
        Width = 160
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1512.534722222222000000
          487.274305555555600000
          352.777777777777900000)
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
        Left = 13
        Top = 280
        Width = 120
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          28.663194444444450000
          617.361111111111200000
          264.583333333333400000)
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
        Left = 157
        Top = 280
        Width = 163
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          346.163194444444500000
          617.361111111111200000
          359.392361111111200000)
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
        Left = 337
        Top = 280
        Width = 65
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          743.038194444444400000
          617.361111111111200000
          143.315972222222200000)
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
        Left = 479
        Top = 280
        Width = 169
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1056.128472222222000000
          617.361111111111200000
          372.621527777777800000)
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
        Left = 686
        Top = 251
        Width = 160
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1512.534722222222000000
          553.420138888888900000
          352.777777777777900000)
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
        Left = 685
        Top = 281
        Width = 161
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1510.329861111111000000
          619.565972222222300000
          354.982638888888900000)
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
        Left = 685
        Top = 311
        Width = 161
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1510.329861111111000000
          685.711805555555700000
          354.982638888888900000)
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
        Left = 24
        Top = 372
        Width = 622
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          52.916666666666660000
          820.208333333333200000
          1371.423611111111000000)
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
        Left = 24
        Top = 387
        Width = 622
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          52.916666666666660000
          853.281250000000000000
          1371.423611111111000000)
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
        Left = 24
        Top = 402
        Width = 622
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          52.916666666666660000
          886.354166666666600000
          1371.423611111111000000)
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
        Left = 24
        Top = 417
        Width = 622
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          52.916666666666660000
          919.427083333333200000
          1371.423611111111000000)
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
        Left = 24
        Top = 432
        Width = 622
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          52.916666666666660000
          952.500000000000000000
          1371.423611111111000000)
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
        OnPrint = QRLabel65Print
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 6
      end
      object QRLabel66: TQRLabel
        Left = 762
        Top = 493
        Width = 68
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1680.104166666667000000
          1086.996527777778000000
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
        Top = 1218
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
          2685.520833333333000000
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
        Top = 1150
        Width = 854
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          6.614583333333332000
          2535.590277777778000000
          1882.951388888889000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape11: TQRShape
        Left = 3
        Top = 1025
        Width = 854
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          6.614583333333332000
          2259.982638888889000000
          1882.951388888889000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape14: TQRShape
        Left = 3
        Top = 995
        Width = 854
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          6.614583333333332000
          2193.836805555556000000
          1882.951388888889000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape15: TQRShape
        Left = 3
        Top = 963
        Width = 854
        Height = 3
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          6.614583333333332000
          6.614583333333332000
          2123.281250000000000000
          1882.951388888889000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape18: TQRShape
        Left = 3
        Top = 893
        Width = 853
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          6.614583333333332000
          1968.940972222223000000
          1880.746527777778000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape19: TQRShape
        Left = 3
        Top = 935
        Width = 854
        Height = 3
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          6.614583333333332000
          6.614583333333332000
          2061.545138888889000000
          1882.951388888889000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape20: TQRShape
        Left = 191
        Top = 875
        Width = 12
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666660000
          421.128472222222200000
          1929.253472222222000000
          26.458333333333330000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape21: TQRShape
        Left = 3
        Top = 1211
        Width = 854
        Height = 4
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          8.819444444444444000
          6.614583333333332000
          2670.086805555556000000
          1882.951388888889000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel7: TQRLabel
        Left = 201
        Top = 875
        Width = 81
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666660000
          443.177083333333300000
          1929.253472222222000000
          178.593750000000000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '341-7'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 12
      end
      object QRLabel8: TQRLabel
        Left = 672
        Top = 903
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
          1990.989583333333000000
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
        Top = 875
        Width = 9
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666660000
          615.156250000000000000
          1929.253472222222000000
          19.843750000000000000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel9: TQRLabel
        Left = 5
        Top = 902
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
          1988.784722222222000000
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
      object QRLabel10: TQRLabel
        Left = 2
        Top = 938
        Width = 49
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          2068.159722222222000000
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
      object QRLabel12: TQRLabel
        Left = 672
        Top = 938
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
          2068.159722222222000000
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
        Top = 966
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
          2129.895833333333000000
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
        Top = 966
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
          2129.895833333333000000
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
        Top = 966
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
          2129.895833333333000000
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
        Top = 966
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
          2129.895833333333000000
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
        Top = 966
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
          2129.895833333333000000
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
        Top = 966
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
          2129.895833333333000000
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
        Top = 996
        Width = 56
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          2196.041666666667000000
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
        Top = 996
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
          2196.041666666667000000
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
        Top = 996
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
          2196.041666666667000000
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
        Top = 1006
        Width = 73
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          507.118055555555600000
          2218.090277777778000000
          160.954861111111100000)
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
        Top = 996
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
          2196.041666666667000000
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
        Top = 997
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
          2198.246527777778000000
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
        Top = 999
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
          2202.656250000000000000
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
        Top = 997
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
          2198.246527777778000000
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
        Top = 1026
        Width = 374
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          2262.187500000000000000
          824.618055555555600000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 
          'Instru'#231#245'es (Todas informa'#231#245'es deste bloqueto s'#227'o de exclusiva re' +
          'sponsabilidade do cedente).'
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
        Top = 1026
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
          2262.187500000000000000
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
        Left = 671
        Top = 1077
        Width = 55
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1479.461805555556000000
          2374.635416666667000000
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
        Top = 1124
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
          2478.263888888889000000
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
        Left = 2
        Top = 1152
        Width = 38
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          2540.000000000000000000
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
        Left = 5
        Top = 1201
        Width = 74
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          26.458333333333330000
          11.024305555555560000
          2648.038194444444000000
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
        Left = 674
        Top = 1197
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
          2639.218750000000000000
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
        Left = 665
        Top = 1216
        Width = 203
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          26.458333333333330000
          1466.232638888889000000
          2681.111111111111000000
          447.586805555555600000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'FICHA DE COMPENSA'#199#195'O/Autentica'#231#227'o Mecanica'
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
        Left = 667
        Top = 1075
        Width = 189
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          1470.642361111111000000
          2370.225694444445000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape24: TQRShape
        Left = 668
        Top = 1097
        Width = 189
        Height = 6
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          13.229166666666670000
          1472.847222222222000000
          2418.732638888889000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel35: TQRLabel
        Left = 51
        Top = 1153
        Width = 372
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          112.447916666666700000
          2542.204861111111000000
          820.208333333333200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'LabelNomeTitular'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNomeTitularPrint
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 7
      end
      object QRLabel36: TQRLabel
        Left = 51
        Top = 1169
        Width = 372
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          112.447916666666700000
          2577.482638888889000000
          820.208333333333200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'LabelEndereco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelEnderecoPrint
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 7
      end
      object QRLabel37: TQRLabel
        Left = 51
        Top = 1186
        Width = 372
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          112.447916666666700000
          2614.965277777778000000
          820.208333333333200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'LabelCidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelCidadePrint
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 7
      end
      object QRShape26: TQRShape
        Left = 666
        Top = 891
        Width = 3
        Height = 259
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          571.059027777777900000
          1468.437500000000000000
          1964.531250000000000000
          6.614583333333332000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape27: TQRShape
        Left = 143
        Top = 966
        Width = 1
        Height = 27
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          59.531250000000000000
          315.295138888888900000
          2129.895833333333000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape29: TQRShape
        Left = 330
        Top = 965
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          727.604166666666800000
          2127.690972222223000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape30: TQRShape
        Left = 412
        Top = 965
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          908.402777777777900000
          2127.690972222223000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape31: TQRShape
        Left = 165
        Top = 995
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          363.802083333333400000
          2193.836805555556000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape32: TQRShape
        Left = 220
        Top = 995
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          485.069444444444500000
          2193.836805555556000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape33: TQRShape
        Left = 579
        Top = 995
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          1276.614583333333000000
          2193.836805555556000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape34: TQRShape
        Left = 668
        Top = 1121
        Width = 188
        Height = 6
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          13.229166666666670000
          1472.847222222222000000
          2471.649305555556000000
          414.513888888888900000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape35: TQRShape
        Left = 312
        Top = 995
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          687.916666666666600000
          2193.836805555556000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel44: TQRLabel
        Left = 10
        Top = 1004
        Width = 143
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.097222222222230000
          22.048611111111110000
          2213.680555555556000000
          315.295138888888900000)
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
        Top = 965
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          1031.875000000000000000
          2127.690972222223000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel45: TQRLabel
        Left = 446
        Top = 976
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
          2151.944444444444000000
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
        Top = 866
        Width = 123
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          66.145833333333340000
          15.434027777777780000
          1909.409722222222000000
          271.197916666666700000)
        Picture.Data = {
          07544269746D6170C63F0000424DC63F00000000000036000000280000009600
          0000240000000100180000000000903F00000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFAF7F3FFFBF6F8F2EDFFFEFAFFFCF9D7C3BE9D8482
          7D61607D5F5E7F605F7F5F607F5E627E5F627C5E637C5D647A5F637D5F647D5F
          647D5F647D5F647D5F647D5F647D5F647D60637C5F627D60637D60637C5F627B
          5E617C60607E61648165658E6F70F0D4D4FFFCFBFFF9F7FFFAF7F9F8F4F2F7F5
          FAFFFEFBFFFEFBFFFEFDFFFEFDFFFEFDFFFFFDFFFFFDFFFFFDFFFFFEFEFEFEFE
          FEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFBFFFDF7FFFFF9E4D0CB836A663E20
          1B3815124F282639100E3B0F103C10113D10133C10163A1116390F16390F163A
          10173A11163A11163A11163A11163A11163A11163A12143A1214381012370F11
          370F113911133A12133A12143A1214431B1D300B0D6E4F50DDC5C5FFFEFCFDF6
          F3F9F8F4FFFFFCFDFFFEFFFFFEFFFFFEFFFFFEFFFFFEFDFFFEFDFFFEFDFFFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFF9F4FFFEF9F2D9D580635E51
          2E2A49201D2F02005524224C16164F161750171A4E171A4E161B4C161D4B141D
          49151C49151C49151C49151C49151C49151C49161A49161A49161A4A171B4815
          194613174715174917194A181A4816184614164F1D2140131647202278595AD7
          C2C1FFFEFCFFFEFBF9F6F2FFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFE
          FFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFF6F1FFEEE9B99994
          542F2B4419165C2C285D2623561B195B1B1B5C1A1B5D1A1D5C191E5B171E5916
          1D55141D52131C53141D53151B53151B53151B53151B53151B53151B53161A53
          161A53161A53161A54171B54171B5317185115164E13174B11163E080D401316
          4A2527775B5BFFEBEAFFFEFCFAF3F0FFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFF
          FEFFFFFEFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFEF7FFE5
          DE704B4350231F69383A49171B532322501A196121206121215B1F25571E2651
          1C264B192349172145161F45192045192045182147182147182147191F471B1C
          4B1B1A511819561A1B591B21521C23461A2040181D45171D45161E4619224E23
          2C451D223A13154B2525EFD1D0FFF4F2FFFEFEFFFEFFFFFEFFFFFFFEFFFFFEFF
          FFFEFFFFFEFFFFFEFDFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFF2CEB9AA6C42356A37345928363B14242E141A2E100F44120C521D1A47252C
          2B17241A0D1D09020F160F1C1F1C252023280D0F17120E1A110A190500091A14
          191514101C1109310B064F1C1A511D24401E280C0D170008120D06131609190E
          02161808191801093D1B1B592322C79795FFF4F1FFFFFFFEFDFFFCFEFFFFFFFF
          FDFEFCFFFFFCF9FFFAF8FFFFF5FDFCFDFFFFFDFDFDFFFFFFFEFEFEFFFFFFFFFF
          FFF7F7F7FFFFFFFFFFFFFCFCFCFFFFFFFFFFFFFDFDFDFFFFFFF9F9F9FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFF5F5F5FFFFFFFDFDFDFFFFFFFCFCFCFFFFFFFEFEFE
          FFFFFFFFFFFFFCFCFCFFFFFFFFFFFFFEFEFEFFFFFFF8F8F8FFFFFFFCFCFCFFFF
          FFF7F7F7FFFFFFFFFFFFFFFFFFFBFBFBFFFFFFFFFFFFFCFCFCFFFFFFFAFAFAFF
          FFFFFFFFFFFDFDFDFFFFFFFDFDFDFFFFFFFAFAFAFFFFFFFFFFFFFFFFFFFFFFFF
          FCFCFCFDFDFDFAFAFAFFFFFFFFFFFFFDFDFDFFFFFFFEFEFEFFFFFFFFFFFFFFFF
          FFFFFFFFFBFBFBFFFFFFFDFDFDFEFEFEFFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFF
          FFFFF5F5F5FFFFFFFFFFFFFDFDFDFFFFFFF9F9F9FFFFFFFAFAFAFFFFFFFFFFFF
          FFFFFFF4F4F4FFFFFFFDFDFDFDFDFDFEFEFEFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDEAB9AA976038265D2E2A5F4251584F634252581D2B2729170C4330
          293F454C435A693D606E456D7900242C001B2326585E3D707A4975862A546700
          212F0232382653501431281B150E3723224032383E4754487A863877851A4E5B
          001C2D30576D415F702C383E1E110F451814B58682FFFBF8FCFCFCFDFEFFF5F6
          FAFFFFFFF7F5F4FFFFFCFBFFFCF6FFFFF6FFFFF8FDFCFFFFFFF6F6F6FBFBFBFF
          FFFFF7F7F7FFFFFFFDFDFDFDFDFDFCFCFCFBFBFBFFFFFFEEEEEEFFFFFFFFFFFF
          FEFEFEFDFDFDFFFFFFFCFCFCFEFEFEFFFFFFF0F0F0FFFFFFF8F8F8FFFFFFFFFF
          FFFFFFFFF4F4F4FFFFFFFFFFFFFBFBFBFFFFFFFCFCFCFDFDFDFEFEFEF8F8F8FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9F6F6F6FFFFFFFFFFFFFCFCFCFFFFFF
          FFFFFFF8F8F8FFFFFFFFFFFFFDFDFDFFFFFFFFFFFFFFFFFFF7F7F7FEFEFEFCFC
          FCFBFBFBFFFFFFFFFFFFF7F7F7FDFDFDFFFFFFFFFFFFF8F8F8FFFFFFF6F6F6FF
          FFFFFFFFFFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFF9F9F9FBFBFBFFFFFFFAFAFA
          FDFDFDFFFFFFFFFFFFFEFEFEF5F5F5FBFBFBFFFFFFFFFFFFF5F5F5FFFFFFF3F3
          F3F8F8F8FFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFFFFFFF7F7F7FFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFF0AC9E88572F1D55362D858E97A5D3DE87D4D127716500
          23131E3C2F6DA9A98EDEE58FEAEF80DBDF00494A277A7B6CCED474DCE975D5EC
          67CBE32D9DAF47B6C084E3E6428B890016150A2D30699DA48CD6E27BE4F163DE
          E85FDEE61E9AA25CC9D771CBD63D7D7D01201932221B92766FFFFDF9F6F7F5FB
          F8FAFFFEFFFBF3F4FFFEFEFFFFFCFDFBFAFBFFFFF2F7FAFDFFFFF9F9F9FFFFFF
          FDFDFDDEDEDEECECECFFFFFFFFFFFFE4E4E4EDEDEDFAFAFAFFFFFFFFFFFFFBFB
          FBFCFCFCFDFDFDFBFBFBFFFFFFFAFAFAF5F5F5FDFDFDFFFFFFFFFFFFEFEFEFDF
          DFDFD7D7D7FFFFFFFFFFFFFFFFFFF8F8F8FFFFFFE9E9E9EBEBEBE0E0E0FFFFFF
          FFFFFFFCFCFCFEFEFEFFFFFFF1F1F1FBFBFBFFFFFFFFFFFFFFFFFFF9F9F9FFFF
          FFFFFFFFF5F5F5FFFFFFE8E8E8DCDCDCFCFCFCFFFFFFDFDFDFE7E7E7FFFFFFFF
          FFFFE2E2E2F1F1F1FFFFFFF4F4F4F8F8F8E3E3E3F6F6F6FBFBFBFFFFFFFFFFFF
          FFFFFFFAFAFAFFFFFFFCFCFCFBFBFBF4F4F4F9F9F9F5F5F5C5C5C5C9C9C9CACA
          CAF5F5F5FFFFFFF6F6F6FFFFFFF3F3F3FFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFB
          FBFBFFFFFFFEFEFEFEFEFEF9F9F9F6F6F6FFFFFFFDFDFDFFFFFFFBFBFBF7F7F7
          0000FFFFFFFFFFFFFFFFFFFFFFEBAB96815F3A2643312664898D85D5DC70DED8
          00685B002C1B23615580D8D860C6CB4CB4B92186880055526ACDCB63DEE255D0
          DE127992228DA840C3D75CE6F355D0D4177B7B00282821646779CFD580E5ED53
          C6D127A3AD39BEC24FD7DD59E1ED66DFE926808000261E333127846F67FFFDF8
          FCFDFBFFFEFFFCF5F84C41430D01010900000700000703082C2B2F969597FFFF
          FFF7F7F74545450000000404046565655A5A5A000000090909FFFFFF33333300
          0000A3A3A3FFFFFFFFFFFF262626000000C8C8C8FFFFFFFCFCFCE9E9E9525252
          0000000000001111110D0D0DFCFCFCFAFAFAEAEAEA5050500303030000000000
          00363636D6D6D6FFFFFFFEFEFEF8F8F8FFFFFFFFFFFFF3F3F345454500000086
          8686FBFBFBFFFFFFE5E5E5272727000000070707BDBDBD383838000000000000
          6969695B5B5B020202030303FFFFFFCECECE1010100303030D0D0DB9B9B91B1B
          1B000000E3E3E3FFFFFFF8F8F8FFFFFFFFFFFFFFFFFFC4C4C40A0A0A00000000
          00000000000D0D0D8E8E8EFFFFFFA5A5A50202021C1C1CF8F8F85E5E5E0E0E0E
          FFFFFFFFFFFFFAFAFAF8F8F8FFFFFFF7F7F7101010050505C9C9C99797970202
          022626260000FFFFFFFFFFFFFFFFFFFFFFEDB1927D64412D3D352857878B79D3
          DA6FDDDB00635A002C201D665E71CFD47AD9E3539FAB00111800424194EBE755
          CDCD097A84000823001D3C005F765DDDEA6BE9EA23928E001B17317E7B84E1E0
          7ED9DD227077003239003D413082875FD6E55FD9E717717200272137312A8871
          69FFF9F2FCFFFBFFFFFFFFFEFF4B46450900005D514F7E72723C303609010815
          1214BEBEBEA9A9A9050505222222BCBCBC6A6A6A000000000000AEAEAEFAFAFA
          494949000000A7A7A7F1F1F1FCFCFC1C1C1C000000B3B3B3FFFFFFFEFEFE3D3D
          3D050505252525B1B1B1AEAEAE8C8C8CFFFFFFFFFFFF4444440000005E5E5ED9
          D9D9828282000000232323FBFBFBF6F6F6FFFFFFFFFFFFFFFFFFFFFFFF444444
          000000808080FFFFFFFFFFFF7B7B7B000000272727B5B5B5A5A5A50606062424
          24B7B7B7686868070707000000B2B2B2F9F9F95454540202023838386D6D6D18
          18180D0D0D0F0F0FD6D6D6FAFAFAFFFFFFFBFBFBFCFCFCFFFFFFC1C1C15B5B5B
          ACACACB8B8B8A3A3A30C0C0C000000B1B1B1979797060606171717FFFFFFB4B4
          B4000000B2B2B2FEFEFEFEFEFEFFFFFFFAFAFA9B9B9B0404041E1E1EFFFFFFA0
          A0A00101012323230000FFFFFFFFFFFFFFFFFFFFFDEA9F806B4E2D1A322E2355
          8F9484E6EE75E6E8006862002921135D5975D4DE71CCDB468292001F2A144445
          83CAC775E6E848B8C40B506B00234100384F35BCCA50D0D51B8B8B002D2A3387
          8581E3E37AD4D5063D46001D26112A2E2D5D6377DDEF72E2F427757B02272339
          2B25957871FFFCF5FCFDF9F9F9F9FCFCFC413F3E090602A19A97FFFDFFFFFBFF
          1B131A020001A4A4A4ADADAD000000636363FFFFFFFFFFFF252525030303FDFD
          FDF9F9F93E3E3E0D0D0D999999FFFFFFFFFFFF1B1B1B0E0E0EC5C5C5F9F9F9DB
          DBDB000000010101EBEBEBFFFFFFFFFFFFFFFFFFFFFFFFD2D2D2000000080808
          F1F1F1FAFAFAFAFAFA262626000000A1A1A1FFFFFFFFFFFFF9F9F9FAFAFAFFFF
          FF404040000000868686FFFFFFFFFFFF6161610000008A8A8AFFFFFFA9A9A902
          0202545454FFFFFFFFFFFF181818000000FFFFFFFDFDFD414141040404A4A4A4
          FFFFFFB6B6B6020202040404DEDEDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFB
          FBFFFFFFFFFFFFFFFFFFFFFFFF5C5C5C010101676767ECECECBABABACECECEFE
          FEFEFFFFFF202020484848DFDFDFDEDEDEE0E0E0E8E8E8363636000000939393
          F4F4F4E4E4E4C8C8C8CACACA0000FFFFFFFFFFFFFFFFFFFFFFF0A08F7A5E3D2D
          3D362D45838B6ED4E05DD3D8006263003E3D0D4D5178D4E57FDAEF508A9D0B2E
          3B0F2A2E48797B66CED359D4E262D1EB37B3D1009AB238DDEE61E3F0157E8700
          2B31318C906AD6DA6DCBD1255561263744141C2328444F7CCFE574D1E636717A
          0A1E1F41221FA17772FFFDF8FFFFFCFDFFFEFBFFFF3A413E050B06929593FDFD
          FDFFFDFF000006050406B7B7B7DDDDDD2323230000006D6D6D9D9D9D11111103
          0303F4F4F4FFFFFF4646460000009F9F9FFFFFFFFEFEFE242424000000B4B4B4
          FFFFFF9E9E9E0000002A2A2AFEFEFEFFFFFFFEFEFEFFFFFFF8F8F89F9F9F0909
          09222222FCFCFCFFFFFFFFFFFF505050060606838383F7F7F7FFFFFFFFFFFFFF
          FFFFF7F7F7404040080808787878F8F8F8FFFFFF5B5B5B040404737373F9F9F9
          EEEEEE1010100B0B0B6C6C6C979797141414040404FCFCFCF8F8F84747470000
          00C6C6C6FAFAFAFFFFFF171717000000DBDBDBFFFFFFFDFDFDFCFCFCFBFBFBFD
          FDFDFFFFFFF4F4F4F7F7F7FFFFFFDDDDDD232323010101707070F9F9F9FFFFFF
          FCFCFCF8F8F8F8F8F87E7E7E0303030303030707070000000000000000000101
          01F6F6F6FFFFFFFFFFFFF3F3F3FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFEE9488
          765330223A30294C87907BE3F064DCE200676B002C2F1C646C65CEE16FDAEF44
          899A001C28283D3F042B2D004F5408828E2FA6BC2CB1CC2AD0E737DBEE56D0E0
          29899600343B297B807DE3E87FDBE003343E051A22282E33435D6485D1E773CA
          DE4279801624234D28249E6E6AFFF5F0FFFBF8FEFFFDF9FEFD363F3C0003007A
          8380A6AEAD3B414601040C5C5E5FFDFDFDFDFDFDE1E1E17878783A3A3A252525
          070707000000FFFFFFFFFFFF3C3C3C020202A0A0A0FCFCFCFFFFFF1D1D1D0505
          05C6C6C6F8F8F8A5A5A5040404292929FFFFFFF9F9F9FFFFFFFDFDFDFFFFFFA2
          A2A2000000232323FEFEFEFCFCFCFDFDFD565656000000878787FFFFFFFAFAFA
          FFFFFFFFFFFFFFFFFF404040000000868686FFFFFFF9F9F95E5E5E0000007F7F
          7FFFFFFFF6F6F6E9E9E97272723D3D3D252525060606000000FFFFFFFFFFFF3E
          3E3E040404BBBBBBFFFFFFF6F6F62A2A2A000000E6E6E6FCFCFCFCFCFCFFFFFF
          FFFFFFFDFDFDFBFBFBFFFFFFFBFBFB9898981C1C1C000000070707C7C7C7FFFF
          FFFDFDFDFEFEFEFFFFFFFFFFFFDBDBDB0000005F5F5FC2C2C2C1C1C154545403
          03034C4C4CFCFCFCFFFFFFFCFCFCFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFF49686795D372B41302D5286927BDCEA6ADFE8005B61003B3F04646A47D0E0
          4DD7E93291A000252D0A2C2B5F8B85348B880A727700354800364E00687C44CB
          DB6CDBE52A828800363A36767797EAEB8ADCDD003C3E18403F22333037595976
          CFDD6DD0DE3778791E342F4828229B6D66FFFBF5FFFEFAFFFDFEFEFEFE383D3B
          000300000200000806011215A0ACB0F9FDFEFDFDFDFFFFFFFAFAFAFFFFFFFFFF
          FFF7F7F7131313000000FFFFFFFFFFFF3D3D3D000000444444FFFFFFFEFEFE19
          1919000000C5C5C5FDFDFDD3D3D3000000000000DBDBDBFFFFFFFFFFFFF5F5F5
          FCFCFCDCDCDC000000030303F0F0F0FCFCFCFFFFFF191919000000A6A6A6FFFF
          FFFAFAFAFFFFFFFFFFFFFFFFFF424242000000828282FFFFFFFFFFFF58585802
          02027F7F7FFFFFFFFFFFFFFFFFFFFCFCFCFFFFFFFAFAFA111111030303FFFFFF
          F8F8F8434343000000C1C1C1FFFFFFFFFFFF272727000000E4E4E4F9F9F9FBFB
          FBFFFFFFFAFAFAFBFBFBFFFFFFE4E4E43F3F3F000000000000232323B4B4B4FE
          FEFEFFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFF4040402F2F2FFFFFFFFBFBFB
          222222000000B3B3B3FFFFFFFEFEFEFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDF3998378623A2E4A373457848F7AD2E06EDBE3006B6E086A6A5AC8
          CC4CE6F147DEEC6BD5E078BBBE3F615B4F71678ED2C787D9D46FBAC263B5C160
          C4D077DAE284CED237706F113632578079A2DED88ECEC810443D1C3F35232D21
          374E4999E7EE7FD7DE38716E1B2C2349291EA5776FFFFEF8FFFAF6FFFEFFFCFA
          FA3E413F030904757E7BA0ABA919282B051115C2C6C7FAFAFAFCFCFC7B7B7B90
          9090C4C4C4979797000000131313FFFFFFF7F7F73D3D3D0000002222222C2C2C
          4747470000000D0D0DE2E2E2F6F6F6FFFFFF4E4E4E0202022727279393939B9B
          9B7B7B7BFDFDFDF9F9F9515151000000474747B9B9B96B6B6B000000292929FF
          FFFFFDFDFDFFFFFFFBFBFBF5F5F5FCFCFC424242000000888888FDFDFDC8C8C8
          4646460000005757579B9B9BEEEEEE6D6D6DA0A0A0B5B5B59494940101010808
          08FEFEFEFFFFFF424242000000C5C5C5F4F4F4FFFFFF1111110E0E0ED6D6D6FF
          FFFFFFFFFFF0F0F0FFFFFFFFFFFFF6F6F63333330000000F0F0F727272EAEAEA
          FFFFFFFFFFFFFAFAFAFFFFFFFEFEFEFFFFFFFBFBFBFDFDFDA0A0A0040404D1D1
          D1B4B4B4020202191919F6F6F6FFFFFFF9F9F9FFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFCF7A382795F35294B38336687908DD5E17BDCE006716F16
          7C775FD6D540DEE440D6E06FD1D98BC1C2394C432D3A2A81A79198D1BC9AE2D6
          95E3DC94DBD880B3AF81938C4443393637277A8674B4D8C7B0D7C73C57472931
          20422E1C6F675A9CC5C791C6C9607F783F3E3051271A9A695FFFF8F0FEFAF5F9
          F7F7FFFEFF3C3A3A020000A2A19DFFFFFEB5B8BC04070B1C1E1FF9F9F9FAFAFA
          7D7D7D171717000000000000202020BFBFBFF7F7F7FEFEFE6565651C1C1CA0A0
          A06060600909090202027D7D7DFCFCFCFFFFFFFBFBFBF1F1F16868680C0C0C08
          0808000000383838FFFFFFFAFAFAEAEAEA7474740909090000000505054C4C4C
          F7F7F7F2F2F2FBFBFBFFFFFFFCFCFCFFFFFFFFFFFF474747020202868686F6F6
          F69E9E9E010101060606090909242424E9E9E97E7E7E1414140000000000001C
          1C1CB5B5B5FFFFFFFBFBFB5555551F1F1FC4C4C4FFFFFFFCFCFC4444441B1B1B
          E3E3E3F5F5F5FFFFFFFFFFFFFFFFFFFFFFFFC1C1C1020202040404C0C0C0FFFF
          FFFFFFFFFFFFFFFFFFFFFAFAFAFFFFFFFCFCFCFFFFFFFDFDFDF7F7F7F7F7F710
          10106A6A6A575757000000777777FDFDFDF4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFDF8A889805E37294A372F6A878C9BDAE284DADA
          0B6A6300463E056D6653DEE15DE2E934888D19403E413D3242332032321A3D4F
          383D62523660553F5E57444C455A4137542D1F532F1D462E1A2F2F1D3A443321
          28193A3B2B4136223027193139383A44443331263E25155D2919A47365FFFDF4
          FCFDF9FDFFFFF8F9FD423D3E080000A39A97FFFEFEB6AFB2050106000001FFFF
          FFFEFEFEFFFFFFF7F7F7F1F1F1EEEEEEF8F8F8F2F2F2FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFAFAFAF5F5F5F5F5F5FFFFFFFFFFFFFFFFFFF9F9F9FFFFFFF7F7F7
          FFFFFFE0E0E0FDFDFDFEFEFEFFFFFFFDFDFDFFFFFFEFEFEFFFFFFFE2E2E2FCFC
          FCFCFCFCF2F2F2FFFFFFFDFDFDFEFEFEFFFFFFF4F4F4FEFEFE3E3E3E0404047E
          7E7EFFFFFFECECEC6666660303037B7B7BFFFFFFFFFFFFFDFDFDFDFDFDF1F1F1
          E5E5E5FAFAFAFFFFFFFFFFFFFBFBFBFFFFFFFDFDFDFFFFFFF5F5F5FFFFFFFFFF
          FFFFFFFFFFFFFFF9F9F9FFFFFFF4F4F4FFFFFFF9F9F9CCCCCC060606111111FF
          FFFFFFFFFFF0F0F0FCFCFCFFFFFFFFFFFFFFFFFFF8F8F8FFFFFFFFFFFFF8F8F8
          FFFFFF606060131313151515000000D5D5D5FBFBFBFDFDFDFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFBF1A49386603E2E4E3B2E6F8785A4E0
          DF8BDED51D6E5F00372A2362586ED0D063C8CA64A9A620392F5231216C34215B
          301D502D1F4C2E294024243A20204D2C294D1C14692C22752F227232275A2A24
          51342F403D357484797292813447383823214A211F4D2114602D19753321AB77
          67FFFBEFF4FEF8F2FBFEF7FDFF4A47490700003B2D2E3628290B000007000152
          5050F4F4F4FFFFFFF1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFBFBFB
          F6F6F6FEFEFEFDFDFDFFFFFFFFFFFFFCFCFCFAFAFAFFFFFFF9F9F9FFFFFFF9F9
          F9FEFEFEF8F8F8FAFAFAFFFFFFF6F6F6FCFCFCFFFFFFF3F3F3FFFFFFFFFFFFF6
          F6F6FFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFEFEFEF9F9F9FFFFFFFFFFFF3C3C3C
          000000787878FFFFFFFFFFFFD2D2D29E9E9EC5C5C5FBFBFBFDFDFDFFFFFFF5F5
          F5FFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFBFBFBFFFFFFAAAAAA535353E8
          E8E8FEFEFEFAFAFAFAFAFAFEFEFEFFFFFFFFFFFFFAFAFAFFFFFFF5F5F51D1D1D
          0505054444447A7A7A545454343434FDFDFDFFFFFFFDFDFDFBFBFBFDFDFDFFFF
          FFFFFFFFFBFBFBC4C4C40101010000002D2D2DFFFFFFFFFFFFFFFFFFFDFDFDFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFF5A494845C3D285943317F
          8E86B6E0D9A0DBCC42766431443353675BA1D7D79AD8D86B958E313425723B26
          8030196A240D601E0C66221B682726632A29733C376024187533216F21117223
          166A211D59232250323190908ABDDACBA6B7A9673F3A6D2C246429166C2E166E
          2A13A2705CFFFDF0F3FFFCEDFCFEF6FEFF7D7C80665E5F6F63635F5351766E6E
          A19C9DF7F5F5FFFFFFFCFCFCF6F6F6FFFFFFFEFEFEF7F7F7FFFFFFFDFDFDFFFF
          FFFBFBFBFFFFFFFFFFFFF5F5F5FFFFFFF7F7F7FFFFFFFFFFFFF7F7F7FFFFFFFB
          FBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFAFAFAFFFFFF
          FCFCFCFFFFFFF8F8F8FBFBFBFAFAFAF9F9F9FBFBFBFFFFFFFFFFFFFFFFFFF1F1
          F18C8C8C656565AFAFAFFFFFFFFFFFFFF9F9F9FFFFFFFBFBFBFFFFFFFFFFFFFB
          FBFBFFFFFFFAFAFAFAFAFAFFFFFFF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          4444442C2C2CE7E7E7FFFFFFFFFFFFF8F8F8F8F8F8FFFFFFFAFAFAFDFDFDFDFD
          FDF1F1F15959592424241919193535355A5A5AFEFEFEFFFFFFFAFAFAFFFFFFFD
          FDFDFBFBFBFFFFFFFDFDFDFFFFFF6C6C6C686868B3B3B3FFFFFFFEFEFEF8F8F8
          FDFDFDFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFF5AC92825F4027
          654B33797368959E948C9E8D5D644F5A4230674F437880807E9091696B65573D
          2D843A228C32148F3F20843A1E7C301E742D1F652A1B602B175D280D5F28096B
          2D0F6B2910742D1F752F2868252270403C8A7A6E9485758A594F76392B662E15
          652F116B2F12A87E67FFFFF4E7FBF6F1FFFFF4FDFFFDFDFFFFFEFFF9F4F1FFFF
          FCEDF4F1F5FEFBF3F5F5FFFFFFFBFBFBFFFFFFFEFEFEFFFFFFFFFFFFFEFEFEFF
          FFFFF3F3F3FFFFFFFAFAFAFAFAFAFFFFFFF9F9F9FFFFFFFDFDFDFFFFFFFFFFFF
          FFFFFFFDFDFDFBFBFBFEFEFEFAFAFAF8F8F8F9F9F9FFFFFFFBFBFBF9F9F9FFFF
          FFF8F8F8FFFFFFFFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFFFDFDFDFDFDFDFE
          FEFEFFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFDFDFDFFFFFFFBFBFBFFFFFFF6F6F6
          F7F7F7FFFFFFF9F9F9FFFFFFFDFDFDFCFCFCFFFFFFFFFFFFFFFFFFFAFAFAFFFF
          FFFFFFFFE0E0E0777777AFAFAFFFFFFFF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFDFDFDFAFAFAFDFDFDFCFCFCFFFFFFF8F8F8FFFFFFFFFFFFFDFDFDFDFDFD
          FFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFFF6F6F6F9F9F9FFFFFFF7F7F7FFFF
          FFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFBF2B693
          85724D376F4D365A3D2F4E362A5B453360402D7844336F3B2E573A36533E3C55
          382F703F2F94442D8D3315843514883C1F83351E8138247A3B26652C137D4627
          6E3815804727783A1C76311D7C31238231297129216134266035246E2F21702C
          19773B2370391E602A119E7965FFFFF7F5FFFDF6FFFFF5FBFFFAFAFFFFFEFFFF
          FDFCFDFFFEF3FEFBF6FFFFFBFFFFFCFCFCFFFFFFFAFAFAFFFFFFFAFAFAFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF3F3F3FFFFFFFEFEFEF5F5F5FFFFFFFFFFFFFCFC
          FCFBFBFBFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF9F9F9FFFFFFFF
          FFFFF8F8F8FFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFEFEFEFCFCFCFBFBFBFFFFFF
          FBFBFBFBFBFBFFFFFFF2F2F2FDFDFDFFFFFFF9F9F9FDFDFDFAFAFAFFFFFFFBFB
          FBFFFFFFFDFDFDFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFFFFFFFF
          FFFFF6F6F6FFFFFFFAFAFAFFFFFFF9F9F9FAFAFAFFFFFFFDFDFDFBFBFBFFFFFF
          FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFBFBFBFFFFFFFAFAFAFFFFFFFDFD
          FDFFFFFFFAFAFAFFFFFFFFFFFFFDFDFDFEFEFEFBFBFBFFFFFFFFFFFFF6F6F6FF
          FFFFFBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          F5EFB68F877E51447E4A3D7841347940318348387D3F2D864334844335784138
          7641377840357E3F318B3F2D8E3F2A8D432B8A422A883F29843E27803D267E3E
          267E3E257E3F23824027813F26813D26833C28833B29803B28773A2678392585
          3524833120823A28773927693528A27E74FFFAF4FFFCFBFFFEFFFFFEFFFFFEFF
          FFFEFFFFFEFFFDFFFFFBFFFFFBFFFFFCFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDF8BE9893895B538B554A8E4D3F924C3B9D5341964C3A924C3B914C
          3D8D4C3E8D4C3E8D4C3E8D4A3B8F49388E49368F4A368D4A358D48348B48338B
          46328946318A45318946318C47338A47328A45318845308A453188453087422E
          8A412D96402E913A2A8D42327D40326B3D32A3817BFFF9F7FFFBF9FFFEFFFFFE
          FFFFFDFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFEFEFEFEFEFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFBF4BB9E958A64588E5F51925A49985846A15D4A9B574495
          554394564692574893584992574792564693534194523F96544195534096523F
          93513E94503D92503D94503D92503D97534094523F95513E93513E95513E9250
          3D924E3B944C3A9B4C39964837934E3D834C3D71493DA4897FFFFBF6FFFDFAFF
          FEFFFFFFFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFFFFFEFEFEFEFEFEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFCF4BFA99E9373669A7162A06E5CA56C57AB6F59
          A66A54A36854A068559F69589D69589F69589D6854A06752A06551A46654A365
          53A56553A26452A46452A26452A36351A16351A1614F9E604E9F5F4D9D5F4D9F
          5F4D9C5E4C9C5C4A9C5A48A158449D5543955A47885747795649A89287FFFCF6
          FFFDFAFFFFFEFFFFFFFFFEFFFFFEFFFFFEFFFFFFFFFFFFFFFFFFFFFEFEFEFEFE
          FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFAEEC0AFA2987F6FA07F6CAB7E69AD7B
          64B07A63AC765FAC7762A97763A67762A37661A47560A77561AA7560AD7661AC
          7461AC7463AE7363AB7362AD7262AA7261AC7161AA7261AC7161A97160AA6F5F
          A76F5EA96E5EA66E5DA66B5BA56A57AA6954A667529E6955916655836658AC9A
          8FFFFEF7FFFDFAFFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFFFEFFFFFEFFFFFFFEFF
          FEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFCF0C7B7AAA18A7AA98976B5
          8B74B6846DB88269B68067BB8671B78670B3846FB0836EB1826DB4836DB7856E
          BA8570B6836FB68271B68271B58170B58170B4806FB37F6EB27E6DB27E6DB17D
          6CB07C6BAF7B6AAF7B6AAD7968AB7766AE7663B47862B37761A976629C746290
          7365B4A297FFFEF7FFFEF9FFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFE
          FFFFFEFFFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFF5D5C4B7AF9585
          B4907EC1927CC08C75C28A71C28A71C7907BC48F7AC18E7ABF8D79C08E78C38E
          79C69079C68F7AC18F7BBF8F7DBF8F7DBE8E7CBD8D7BBC8C7ABB8B79BA8A78B2
          8270B1816FB0806EAF7F6DAE7E6CAD7D6BAB7B69AC7965B57864B67965AB7864
          9F776596796BB7A59AFFFFF6FFFDF8FFFFFEFFFFFEFFFFFFFFFFFFFFFFFEFFFF
          FEFFFFFEFFFFFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFEF3D4BE
          B2AC8D7EAE8674BA8773BA816BBB7F69BF806BBB806CBA816CB9816EB9816EB9
          816EBB826DBD806CBB806CB98470B68470B68472B5836FB48270B2806CB17F6D
          B07E6AB17F6DB07E6AAF7D6BAE7C68AD7B69AC7A66A97765AD7562B1725EB374
          60A973629F746399796CB9A59AFFFCF4FFFCF7FFFFFCFFFFFEFFFFFFFFFFFFFF
          FFFEFFFFFEFFFFFCFFFFFCFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          F5EEDFC2B9A07D70A07463AD7562BD7E69A7644FC27F6AB2705DB0705EAE7060
          AE705EAF715FB1725EB5715EB3715EB0735FAE735FAD725FAD725EAC715EAC71
          5DAB705DAB705CAC715EAC715DAB705DA96E5AA76C59A56A56A56A57A86B57AC
          6754AF6B58A368588B5C4E987568B59C92FFFDF7FBF5F0FFFFFCFFFFFEFFFFFF
          FFFFFFFFFFFEFDFFFEFDFFFCFDFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDF8DEBFB6896259A576689B60509C5A47B06B589A5542A35E4DA15E
          4F9F5E4F9F5E4FA15E4FA35E4DA45E4DA45F4CA6614EA5614EA4604DA4604DA3
          5F4CA35F4CA25E4BA25E4B9E5A479E5A479E5A479D59469C58459B57449C5845
          9E59469B5341985342965B4C8F60526E4B3EBEA49DFFF6F0FFFFFCFFFFFEFFFF
          FEFFFFFFFFFFFFFDFFFEFDFFFEFBFFFCFBFFFCFDFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE
          FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFDF9FEE1DA89625A8454488F54458A4A389C574696503F91
          4C3D8F4B3E8C4B3D8A4B3D8C4B3D8D493C90493B924A39964A38964A38964A38
          9549379549379448369448369448369145339145339145339044328F43318F43
          318F43318E4432873F2E7C3C2A773E2F7C4F427A574DF3DBD5FFF9F6FFFCF9FF
          FFFEFFFFFFFFFEFFFFFFFFFDFFFEFDFFFEFBFFFCFBFFFCFDFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFF6F3FFF5F1AA8882693F337D483B884D3D6D2F1F
          8241327A3B2D783A2F763A2E76392F75382E76382D7B372A7D38298139288338
          288237278237278237278237278136268136268237278237278237278035257E
          33237D32227E33237C34237634227E4333693528532B1F91746BFFF6EFFFFEFA
          FEF6F6FFFEFFFFFFFFFFFEFFFFFEFFFDFFFFFDFFFEFBFFFEFBFFFEFDFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFCFFFFFBF3DDD79D7E755D33276130
          225E291C723B2E622D20612D215E2B215E2B215D2A205F2B1F63281E65291D68
          2B1D6A2B1D6A2B1D6A2B1D6A2B1D692A1C692A1C692A1C6A2B1D6A2B1D6A2B1D
          68291B67281A66271967281A65281A6831225A2919592F22927267EBD6CEFFFF
          F9FFFAF7FFFFFEFFFFFFFFFEFFFFFEFFFFFEFFFFFFFFFFFFFEFDFFFEFDFFFEFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFF8F8F8FAF7F3FFFDF7E5D0C88F
          6F646A4335673B2E55281B562A1D542A1E52292052292051281F53291D56281D
          58281C57271B57271B57271B57271B57271B57271B57271B57271B56261A5727
          1B58281C57271B57271B57271B59291D582B1E5328195B3727876A5CEED8CCFF
          FFF7FFFCF5F4F3EFF5F7F7FDFFFFFDFFFFFFFEFFFFFEFFFFFEFFFFFFFFFFFFFF
          FFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFF6FFFFFAFFFEFFFFFA
          FFFFF8FFF9EEE9CCBEBE9D8E8E6D5E98786B96786D93766D93766D95766D9777
          6C9A776A9A776A93756A91756A91756A91756A91756A91756A91756A92766B90
          746991756A92766B92766B92766B92766B94786D957A6CA18475E6CCBBFFF7E8
          FFFFF5F2EDE4FFFFFAFBFFFEF7FDFCFAFFFFFBFEFFFDFEFFFFFEFFFFFEFFFFFE
          FFFFFEFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
        Stretch = True
      end
      object QRShape37: TQRShape
        Left = 668
        Top = 1051
        Width = 189
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          1472.847222222222000000
          2317.309027777778000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel48: TQRLabel
        Left = 170
        Top = 1005
        Width = 32
        Height = 19
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          41.892361111111110000
          374.826388888888900000
          2215.885416666667000000
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
      object QRLabel49: TQRLabel
        Left = 687
        Top = 916
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
          2019.652777777778000000
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
      object QRLabel52: TQRLabel
        Left = 14
        Top = 976
        Width = 120
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          30.868055555555560000
          2151.944444444444000000
          264.583333333333400000)
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
        Left = 158
        Top = 976
        Width = 164
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          348.368055555555600000
          2151.944444444444000000
          361.597222222222300000)
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
        Left = 338
        Top = 976
        Width = 65
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          745.243055555555600000
          2151.944444444444000000
          143.315972222222200000)
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
        Left = 478
        Top = 977
        Width = 169
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1053.923611111111000000
          2154.149305555556000000
          372.621527777777800000)
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
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRLabel70: TQRLabel
        Left = 687
        Top = 946
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
          2085.798611111111000000
          350.572916666666700000)
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
      object QRLabel71: TQRLabel
        Left = 687
        Top = 975
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
          2149.739583333333000000
          350.572916666666700000)
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
      object QRLabel72: TQRLabel
        Left = 687
        Top = 1007
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
          2220.295138888889000000
          350.572916666666700000)
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
        Left = 755
        Top = 1196
        Width = 68
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1664.670138888889000000
          2637.013888888889000000
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
      object QRLabel80: TQRLabel
        Left = 818
        Top = 854
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
          1882.951388888889000000
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
        Top = 1238
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
          2729.618055555556000000
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
        Top = 1258
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
          2773.715277777778000000
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
        Left = 24
        Top = 344
        Width = 622
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444450000
          52.916666666666660000
          758.472222222222300000
          1371.423611111111000000)
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
        Left = 24
        Top = 358
        Width = 622
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444450000
          52.916666666666660000
          789.340277777777800000
          1371.423611111111000000)
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
        Left = 454
        Top = 455
        Width = 211
        Height = 19
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          41.892361111111120000
          1001.006944444444000000
          1003.211805555556000000
          465.225694444444500000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = InsSacPrint
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 7
      end
      object QRLabel39: TQRLabel
        Left = 453
        Top = 1158
        Width = 212
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          998.802083333333400000
          2553.229166666667000000
          467.430555555555600000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = InsSacPrint
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 7
      end
      object QRLabel74: TQRLabel
        Left = 24
        Top = 1070
        Width = 621
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          52.916666666666660000
          2359.201388888889000000
          1369.218750000000000000)
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
        Left = 24
        Top = 1085
        Width = 621
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          52.916666666666660000
          2392.274305555556000000
          1369.218750000000000000)
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
        Left = 24
        Top = 1102
        Width = 621
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          52.916666666666660000
          2429.756944444444000000
          1369.218750000000000000)
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
        Left = 24
        Top = 1116
        Width = 621
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          52.916666666666660000
          2460.625000000000000000
          1369.218750000000000000)
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
        Left = 24
        Top = 1133
        Width = 621
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          52.916666666666660000
          2498.107638888889000000
          1369.218750000000000000)
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
        OnPrint = QRLabel65Print
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 6
      end
      object QRLabel86: TQRLabel
        Left = 24
        Top = 1037
        Width = 621
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          52.916666666666660000
          2286.440972222222000000
          1369.218750000000000000)
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
        Left = 24
        Top = 1055
        Width = 621
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          52.916666666666660000
          2326.128472222223000000
          1369.218750000000000000)
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
      object QRLabel89: TQRLabel
        Left = 108
        Top = 225
        Width = 269
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          238.125000000000000000
          496.093750000000000000
          593.107638888889000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'AP'#211'S O VENCIMENTO PAGUE SOMENTE NO ITA'#218
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
      object QRLabel41: TQRLabel
        Left = 89
        Top = 906
        Width = 310
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          196.232638888888900000
          1997.604166666667000000
          683.506944444444400000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'AT'#201' O VENCIMENTO PAGUE PREFERENCIALMENTE NO ITA'#218
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
      object QRLabel90: TQRLabel
        Left = 89
        Top = 920
        Width = 256
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          196.232638888888900000
          2028.472222222222000000
          564.444444444444500000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'AP'#211'S O VENCIMENTO PAGUE SOMENTE NO ITA'#218
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
        Left = 686
        Top = 182
        Width = 160
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.097222222222230000
          1512.534722222222000000
          401.284722222222300000
          352.777777777777900000)
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
      object qrlLinDig: TQRLabel
        Left = 295
        Top = 876
        Width = 554
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          50.711805555555560000
          650.434027777777700000
          1931.458333333333000000
          1221.493055555556000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'Linha Digitavel'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = qrlLinDigPrint
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRShape28: TQRShape
        Left = 3
        Top = 795
        Width = 854
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          6.614583333333332000
          1752.864583333333000000
          1882.951388888889000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape38: TQRShape
        Left = 3
        Top = 675
        Width = 854
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          6.614583333333332000
          1488.281250000000000000
          1882.951388888889000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape39: TQRShape
        Left = 3
        Top = 645
        Width = 854
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          6.614583333333332000
          1422.135416666667000000
          1882.951388888889000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape40: TQRShape
        Left = 3
        Top = 614
        Width = 854
        Height = 3
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          6.614583333333332000
          6.614583333333332000
          1353.784722222222000000
          1882.951388888889000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape41: TQRShape
        Left = 3
        Top = 544
        Width = 854
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          6.614583333333332000
          1199.444444444445000000
          1882.951388888889000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape42: TQRShape
        Left = 3
        Top = 585
        Width = 854
        Height = 3
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          6.614583333333332000
          6.614583333333332000
          1289.843750000000000000
          1882.951388888889000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape43: TQRShape
        Left = 191
        Top = 526
        Width = 12
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666660000
          421.128472222222200000
          1159.756944444445000000
          26.458333333333330000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel4: TQRLabel
        Left = 201
        Top = 526
        Width = 81
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666660000
          443.177083333333300000
          1159.756944444445000000
          178.593750000000000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '341-7'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 12
      end
      object QRLabel5: TQRLabel
        Left = 672
        Top = 554
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
          1221.493055555556000000
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
      object QRShape45: TQRShape
        Left = 279
        Top = 526
        Width = 9
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666660000
          615.156250000000000000
          1159.756944444445000000
          19.843750000000000000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel38: TQRLabel
        Left = 5
        Top = 553
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
          1219.288194444444000000
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
      object QRLabel43: TQRLabel
        Left = 5
        Top = 590
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
          1300.868055555556000000
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
      object QRLabel47: TQRLabel
        Left = 672
        Top = 588
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
          1296.458333333333000000
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
      object QRLabel67: TQRLabel
        Left = 5
        Top = 616
        Width = 78
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1358.194444444444000000
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
      object QRLabel79: TQRLabel
        Left = 145
        Top = 616
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
          1358.194444444444000000
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
      object QRLabel91: TQRLabel
        Left = 335
        Top = 616
        Width = 54
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          738.628472222222200000
          1358.194444444444000000
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
      object QRLabel92: TQRLabel
        Left = 415
        Top = 616
        Width = 26
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          915.017361111111100000
          1358.194444444444000000
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
      object QRLabel93: TQRLabel
        Left = 475
        Top = 616
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
          1358.194444444444000000
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
      object QRLabel94: TQRLabel
        Left = 672
        Top = 616
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
          1358.194444444444000000
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
      object QRLabel95: TQRLabel
        Left = 5
        Top = 647
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
          1426.545138888889000000
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
      object QRLabel96: TQRLabel
        Left = 169
        Top = 647
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
          1426.545138888889000000
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
      object QRLabel97: TQRLabel
        Left = 227
        Top = 647
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
          1426.545138888889000000
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
      object QRLabel98: TQRLabel
        Left = 230
        Top = 656
        Width = 73
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          507.118055555555600000
          1446.388888888889000000
          160.954861111111100000)
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
      object QRLabel99: TQRLabel
        Left = 317
        Top = 647
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
          1426.545138888889000000
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
      object QRLabel100: TQRLabel
        Left = 589
        Top = 647
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
          1426.545138888889000000
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
      object QRLabel101: TQRLabel
        Left = 576
        Top = 648
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
          1428.750000000000000000
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
      object QRLabel102: TQRLabel
        Left = 672
        Top = 647
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
          1426.545138888889000000
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
      object QRLabel103: TQRLabel
        Left = 5
        Top = 677
        Width = 374
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1492.690972222222000000
          824.618055555555600000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 
          'Instru'#231#245'es (Todas informa'#231#245'es deste bloqueto s'#227'o de exclusiva re' +
          'sponsabilidade do cedente).'
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
      object QRLabel104: TQRLabel
        Left = 672
        Top = 677
        Width = 95
        Height = 9
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          19.843750000000000000
          1481.666666666667000000
          1492.690972222222000000
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
      object QRLabel105: TQRLabel
        Left = 672
        Top = 726
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
          1600.729166666667000000
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
      object QRLabel106: TQRLabel
        Left = 672
        Top = 771
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
          1699.947916666667000000
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
      object QRLabel107: TQRLabel
        Left = 5
        Top = 797
        Width = 38
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1757.274305555556000000
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
      object QRLabel108: TQRLabel
        Left = 2
        Top = 844
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
          1860.902777777778000000
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
      object QRLabel109: TQRLabel
        Left = 682
        Top = 840
        Width = 74
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1503.715277777778000000
          1852.083333333333000000
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
      object QRShape46: TQRShape
        Left = 668
        Top = 723
        Width = 189
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          1472.847222222222000000
          1594.114583333333000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape47: TQRShape
        Left = 668
        Top = 744
        Width = 189
        Height = 6
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          13.229166666666670000
          1472.847222222222000000
          1640.416666666667000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel111: TQRLabel
        Left = 51
        Top = 798
        Width = 372
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          112.447916666666700000
          1759.479166666667000000
          820.208333333333200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'LabelNomeTitular'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNomeTitularPrint
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 7
      end
      object QRLabel112: TQRLabel
        Left = 51
        Top = 813
        Width = 372
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          112.447916666666700000
          1792.552083333333000000
          820.208333333333200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'LabelEndereco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelEnderecoPrint
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 7
      end
      object QRLabel113: TQRLabel
        Left = 51
        Top = 830
        Width = 372
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          112.447916666666700000
          1830.034722222222000000
          820.208333333333200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'LabelCidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelCidadePrint
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 7
      end
      object QRShape48: TQRShape
        Left = 666
        Top = 549
        Width = 3
        Height = 247
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          544.600694444444500000
          1468.437500000000000000
          1210.468750000000000000
          6.614583333333332000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel114: TQRLabel
        Left = 108
        Top = 556
        Width = 297
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          238.125000000000000000
          1225.902777777778000000
          654.843750000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'AT'#201' O VENCIMENTO PAGUE PREFERENCIALMENTE NO ITA'#218
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
      object QRShape49: TQRShape
        Left = 143
        Top = 615
        Width = 1
        Height = 27
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          59.531250000000000000
          315.295138888888900000
          1355.989583333333000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape50: TQRShape
        Left = 330
        Top = 615
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          727.604166666666800000
          1355.989583333333000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape51: TQRShape
        Left = 412
        Top = 615
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          908.402777777777900000
          1355.989583333333000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape52: TQRShape
        Left = 165
        Top = 645
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          363.802083333333400000
          1422.135416666667000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape53: TQRShape
        Left = 220
        Top = 645
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          485.069444444444500000
          1422.135416666667000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape54: TQRShape
        Left = 579
        Top = 645
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          1276.614583333333000000
          1422.135416666667000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape55: TQRShape
        Left = 668
        Top = 767
        Width = 189
        Height = 6
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          13.229166666666670000
          1472.847222222222000000
          1691.128472222222000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape56: TQRShape
        Left = 312
        Top = 645
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          687.916666666666600000
          1422.135416666667000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel115: TQRLabel
        Left = 8
        Top = 656
        Width = 146
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          17.638888888888890000
          1446.388888888889000000
          321.909722222222200000)
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
      object QRShape57: TQRShape
        Left = 468
        Top = 615
        Width = 1
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          61.736111111111120000
          1031.875000000000000000
          1355.989583333333000000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel116: TQRLabel
        Left = 440
        Top = 626
        Width = 10
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888890000
          970.138888888888900000
          1380.243055555556000000
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
        Left = 8
        Top = 519
        Width = 123
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          66.145833333333340000
          17.638888888888890000
          1144.322916666667000000
          271.197916666666700000)
        AutoSize = True
        Picture.Data = {
          07544269746D6170C63F0000424DC63F00000000000036000000280000009600
          0000240000000100180000000000903F00000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFAF7F3FFFBF6F8F2EDFFFEFAFFFCF9D7C3BE9D8482
          7D61607D5F5E7F605F7F5F607F5E627E5F627C5E637C5D647A5F637D5F647D5F
          647D5F647D5F647D5F647D5F647D5F647D60637C5F627D60637D60637C5F627B
          5E617C60607E61648165658E6F70F0D4D4FFFCFBFFF9F7FFFAF7F9F8F4F2F7F5
          FAFFFEFBFFFEFBFFFEFDFFFEFDFFFEFDFFFFFDFFFFFDFFFFFDFFFFFEFEFEFEFE
          FEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFBFFFDF7FFFFF9E4D0CB836A663E20
          1B3815124F282639100E3B0F103C10113D10133C10163A1116390F16390F163A
          10173A11163A11163A11163A11163A11163A11163A12143A1214381012370F11
          370F113911133A12133A12143A1214431B1D300B0D6E4F50DDC5C5FFFEFCFDF6
          F3F9F8F4FFFFFCFDFFFEFFFFFEFFFFFEFFFFFEFFFFFEFDFFFEFDFFFEFDFFFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFF9F4FFFEF9F2D9D580635E51
          2E2A49201D2F02005524224C16164F161750171A4E171A4E161B4C161D4B141D
          49151C49151C49151C49151C49151C49151C49161A49161A49161A4A171B4815
          194613174715174917194A181A4816184614164F1D2140131647202278595AD7
          C2C1FFFEFCFFFEFBF9F6F2FFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFE
          FFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFF6F1FFEEE9B99994
          542F2B4419165C2C285D2623561B195B1B1B5C1A1B5D1A1D5C191E5B171E5916
          1D55141D52131C53141D53151B53151B53151B53151B53151B53151B53161A53
          161A53161A53161A54171B54171B5317185115164E13174B11163E080D401316
          4A2527775B5BFFEBEAFFFEFCFAF3F0FFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFF
          FEFFFFFEFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFEF7FFE5
          DE704B4350231F69383A49171B532322501A196121206121215B1F25571E2651
          1C264B192349172145161F45192045192045182147182147182147191F471B1C
          4B1B1A511819561A1B591B21521C23461A2040181D45171D45161E4619224E23
          2C451D223A13154B2525EFD1D0FFF4F2FFFEFEFFFEFFFFFEFFFFFFFEFFFFFEFF
          FFFEFFFFFEFFFFFEFDFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFF2CEB9AA6C42356A37345928363B14242E141A2E100F44120C521D1A47252C
          2B17241A0D1D09020F160F1C1F1C252023280D0F17120E1A110A190500091A14
          191514101C1109310B064F1C1A511D24401E280C0D170008120D06131609190E
          02161808191801093D1B1B592322C79795FFF4F1FFFFFFFEFDFFFCFEFFFFFFFF
          FDFEFCFFFFFCF9FFFAF8FFFFF5FDFCFDFFFFFDFDFDFFFFFFFEFEFEFFFFFFFFFF
          FFF7F7F7FFFFFFFFFFFFFCFCFCFFFFFFFFFFFFFDFDFDFFFFFFF9F9F9FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFF5F5F5FFFFFFFDFDFDFFFFFFFCFCFCFFFFFFFEFEFE
          FFFFFFFFFFFFFCFCFCFFFFFFFFFFFFFEFEFEFFFFFFF8F8F8FFFFFFFCFCFCFFFF
          FFF7F7F7FFFFFFFFFFFFFFFFFFFBFBFBFFFFFFFFFFFFFCFCFCFFFFFFFAFAFAFF
          FFFFFFFFFFFDFDFDFFFFFFFDFDFDFFFFFFFAFAFAFFFFFFFFFFFFFFFFFFFFFFFF
          FCFCFCFDFDFDFAFAFAFFFFFFFFFFFFFDFDFDFFFFFFFEFEFEFFFFFFFFFFFFFFFF
          FFFFFFFFFBFBFBFFFFFFFDFDFDFEFEFEFFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFF
          FFFFF5F5F5FFFFFFFFFFFFFDFDFDFFFFFFF9F9F9FFFFFFFAFAFAFFFFFFFFFFFF
          FFFFFFF4F4F4FFFFFFFDFDFDFDFDFDFEFEFEFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDEAB9AA976038265D2E2A5F4251584F634252581D2B2729170C4330
          293F454C435A693D606E456D7900242C001B2326585E3D707A4975862A546700
          212F0232382653501431281B150E3723224032383E4754487A863877851A4E5B
          001C2D30576D415F702C383E1E110F451814B58682FFFBF8FCFCFCFDFEFFF5F6
          FAFFFFFFF7F5F4FFFFFCFBFFFCF6FFFFF6FFFFF8FDFCFFFFFFF6F6F6FBFBFBFF
          FFFFF7F7F7FFFFFFFDFDFDFDFDFDFCFCFCFBFBFBFFFFFFEEEEEEFFFFFFFFFFFF
          FEFEFEFDFDFDFFFFFFFCFCFCFEFEFEFFFFFFF0F0F0FFFFFFF8F8F8FFFFFFFFFF
          FFFFFFFFF4F4F4FFFFFFFFFFFFFBFBFBFFFFFFFCFCFCFDFDFDFEFEFEF8F8F8FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9F6F6F6FFFFFFFFFFFFFCFCFCFFFFFF
          FFFFFFF8F8F8FFFFFFFFFFFFFDFDFDFFFFFFFFFFFFFFFFFFF7F7F7FEFEFEFCFC
          FCFBFBFBFFFFFFFFFFFFF7F7F7FDFDFDFFFFFFFFFFFFF8F8F8FFFFFFF6F6F6FF
          FFFFFFFFFFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFF9F9F9FBFBFBFFFFFFFAFAFA
          FDFDFDFFFFFFFFFFFFFEFEFEF5F5F5FBFBFBFFFFFFFFFFFFF5F5F5FFFFFFF3F3
          F3F8F8F8FFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFFFFFFF7F7F7FFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFF0AC9E88572F1D55362D858E97A5D3DE87D4D127716500
          23131E3C2F6DA9A98EDEE58FEAEF80DBDF00494A277A7B6CCED474DCE975D5EC
          67CBE32D9DAF47B6C084E3E6428B890016150A2D30699DA48CD6E27BE4F163DE
          E85FDEE61E9AA25CC9D771CBD63D7D7D01201932221B92766FFFFDF9F6F7F5FB
          F8FAFFFEFFFBF3F4FFFEFEFFFFFCFDFBFAFBFFFFF2F7FAFDFFFFF9F9F9FFFFFF
          FDFDFDDEDEDEECECECFFFFFFFFFFFFE4E4E4EDEDEDFAFAFAFFFFFFFFFFFFFBFB
          FBFCFCFCFDFDFDFBFBFBFFFFFFFAFAFAF5F5F5FDFDFDFFFFFFFFFFFFEFEFEFDF
          DFDFD7D7D7FFFFFFFFFFFFFFFFFFF8F8F8FFFFFFE9E9E9EBEBEBE0E0E0FFFFFF
          FFFFFFFCFCFCFEFEFEFFFFFFF1F1F1FBFBFBFFFFFFFFFFFFFFFFFFF9F9F9FFFF
          FFFFFFFFF5F5F5FFFFFFE8E8E8DCDCDCFCFCFCFFFFFFDFDFDFE7E7E7FFFFFFFF
          FFFFE2E2E2F1F1F1FFFFFFF4F4F4F8F8F8E3E3E3F6F6F6FBFBFBFFFFFFFFFFFF
          FFFFFFFAFAFAFFFFFFFCFCFCFBFBFBF4F4F4F9F9F9F5F5F5C5C5C5C9C9C9CACA
          CAF5F5F5FFFFFFF6F6F6FFFFFFF3F3F3FFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFB
          FBFBFFFFFFFEFEFEFEFEFEF9F9F9F6F6F6FFFFFFFDFDFDFFFFFFFBFBFBF7F7F7
          0000FFFFFFFFFFFFFFFFFFFFFFEBAB96815F3A2643312664898D85D5DC70DED8
          00685B002C1B23615580D8D860C6CB4CB4B92186880055526ACDCB63DEE255D0
          DE127992228DA840C3D75CE6F355D0D4177B7B00282821646779CFD580E5ED53
          C6D127A3AD39BEC24FD7DD59E1ED66DFE926808000261E333127846F67FFFDF8
          FCFDFBFFFEFFFCF5F84C41430D01010900000700000703082C2B2F969597FFFF
          FFF7F7F74545450000000404046565655A5A5A000000090909FFFFFF33333300
          0000A3A3A3FFFFFFFFFFFF262626000000C8C8C8FFFFFFFCFCFCE9E9E9525252
          0000000000001111110D0D0DFCFCFCFAFAFAEAEAEA5050500303030000000000
          00363636D6D6D6FFFFFFFEFEFEF8F8F8FFFFFFFFFFFFF3F3F345454500000086
          8686FBFBFBFFFFFFE5E5E5272727000000070707BDBDBD383838000000000000
          6969695B5B5B020202030303FFFFFFCECECE1010100303030D0D0DB9B9B91B1B
          1B000000E3E3E3FFFFFFF8F8F8FFFFFFFFFFFFFFFFFFC4C4C40A0A0A00000000
          00000000000D0D0D8E8E8EFFFFFFA5A5A50202021C1C1CF8F8F85E5E5E0E0E0E
          FFFFFFFFFFFFFAFAFAF8F8F8FFFFFFF7F7F7101010050505C9C9C99797970202
          022626260000FFFFFFFFFFFFFFFFFFFFFFEDB1927D64412D3D352857878B79D3
          DA6FDDDB00635A002C201D665E71CFD47AD9E3539FAB00111800424194EBE755
          CDCD097A84000823001D3C005F765DDDEA6BE9EA23928E001B17317E7B84E1E0
          7ED9DD227077003239003D413082875FD6E55FD9E717717200272137312A8871
          69FFF9F2FCFFFBFFFFFFFFFEFF4B46450900005D514F7E72723C303609010815
          1214BEBEBEA9A9A9050505222222BCBCBC6A6A6A000000000000AEAEAEFAFAFA
          494949000000A7A7A7F1F1F1FCFCFC1C1C1C000000B3B3B3FFFFFFFEFEFE3D3D
          3D050505252525B1B1B1AEAEAE8C8C8CFFFFFFFFFFFF4444440000005E5E5ED9
          D9D9828282000000232323FBFBFBF6F6F6FFFFFFFFFFFFFFFFFFFFFFFF444444
          000000808080FFFFFFFFFFFF7B7B7B000000272727B5B5B5A5A5A50606062424
          24B7B7B7686868070707000000B2B2B2F9F9F95454540202023838386D6D6D18
          18180D0D0D0F0F0FD6D6D6FAFAFAFFFFFFFBFBFBFCFCFCFFFFFFC1C1C15B5B5B
          ACACACB8B8B8A3A3A30C0C0C000000B1B1B1979797060606171717FFFFFFB4B4
          B4000000B2B2B2FEFEFEFEFEFEFFFFFFFAFAFA9B9B9B0404041E1E1EFFFFFFA0
          A0A00101012323230000FFFFFFFFFFFFFFFFFFFFFDEA9F806B4E2D1A322E2355
          8F9484E6EE75E6E8006862002921135D5975D4DE71CCDB468292001F2A144445
          83CAC775E6E848B8C40B506B00234100384F35BCCA50D0D51B8B8B002D2A3387
          8581E3E37AD4D5063D46001D26112A2E2D5D6377DDEF72E2F427757B02272339
          2B25957871FFFCF5FCFDF9F9F9F9FCFCFC413F3E090602A19A97FFFDFFFFFBFF
          1B131A020001A4A4A4ADADAD000000636363FFFFFFFFFFFF252525030303FDFD
          FDF9F9F93E3E3E0D0D0D999999FFFFFFFFFFFF1B1B1B0E0E0EC5C5C5F9F9F9DB
          DBDB000000010101EBEBEBFFFFFFFFFFFFFFFFFFFFFFFFD2D2D2000000080808
          F1F1F1FAFAFAFAFAFA262626000000A1A1A1FFFFFFFFFFFFF9F9F9FAFAFAFFFF
          FF404040000000868686FFFFFFFFFFFF6161610000008A8A8AFFFFFFA9A9A902
          0202545454FFFFFFFFFFFF181818000000FFFFFFFDFDFD414141040404A4A4A4
          FFFFFFB6B6B6020202040404DEDEDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFB
          FBFFFFFFFFFFFFFFFFFFFFFFFF5C5C5C010101676767ECECECBABABACECECEFE
          FEFEFFFFFF202020484848DFDFDFDEDEDEE0E0E0E8E8E8363636000000939393
          F4F4F4E4E4E4C8C8C8CACACA0000FFFFFFFFFFFFFFFFFFFFFFF0A08F7A5E3D2D
          3D362D45838B6ED4E05DD3D8006263003E3D0D4D5178D4E57FDAEF508A9D0B2E
          3B0F2A2E48797B66CED359D4E262D1EB37B3D1009AB238DDEE61E3F0157E8700
          2B31318C906AD6DA6DCBD1255561263744141C2328444F7CCFE574D1E636717A
          0A1E1F41221FA17772FFFDF8FFFFFCFDFFFEFBFFFF3A413E050B06929593FDFD
          FDFFFDFF000006050406B7B7B7DDDDDD2323230000006D6D6D9D9D9D11111103
          0303F4F4F4FFFFFF4646460000009F9F9FFFFFFFFEFEFE242424000000B4B4B4
          FFFFFF9E9E9E0000002A2A2AFEFEFEFFFFFFFEFEFEFFFFFFF8F8F89F9F9F0909
          09222222FCFCFCFFFFFFFFFFFF505050060606838383F7F7F7FFFFFFFFFFFFFF
          FFFFF7F7F7404040080808787878F8F8F8FFFFFF5B5B5B040404737373F9F9F9
          EEEEEE1010100B0B0B6C6C6C979797141414040404FCFCFCF8F8F84747470000
          00C6C6C6FAFAFAFFFFFF171717000000DBDBDBFFFFFFFDFDFDFCFCFCFBFBFBFD
          FDFDFFFFFFF4F4F4F7F7F7FFFFFFDDDDDD232323010101707070F9F9F9FFFFFF
          FCFCFCF8F8F8F8F8F87E7E7E0303030303030707070000000000000000000101
          01F6F6F6FFFFFFFFFFFFF3F3F3FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFEE9488
          765330223A30294C87907BE3F064DCE200676B002C2F1C646C65CEE16FDAEF44
          899A001C28283D3F042B2D004F5408828E2FA6BC2CB1CC2AD0E737DBEE56D0E0
          29899600343B297B807DE3E87FDBE003343E051A22282E33435D6485D1E773CA
          DE4279801624234D28249E6E6AFFF5F0FFFBF8FEFFFDF9FEFD363F3C0003007A
          8380A6AEAD3B414601040C5C5E5FFDFDFDFDFDFDE1E1E17878783A3A3A252525
          070707000000FFFFFFFFFFFF3C3C3C020202A0A0A0FCFCFCFFFFFF1D1D1D0505
          05C6C6C6F8F8F8A5A5A5040404292929FFFFFFF9F9F9FFFFFFFDFDFDFFFFFFA2
          A2A2000000232323FEFEFEFCFCFCFDFDFD565656000000878787FFFFFFFAFAFA
          FFFFFFFFFFFFFFFFFF404040000000868686FFFFFFF9F9F95E5E5E0000007F7F
          7FFFFFFFF6F6F6E9E9E97272723D3D3D252525060606000000FFFFFFFFFFFF3E
          3E3E040404BBBBBBFFFFFFF6F6F62A2A2A000000E6E6E6FCFCFCFCFCFCFFFFFF
          FFFFFFFDFDFDFBFBFBFFFFFFFBFBFB9898981C1C1C000000070707C7C7C7FFFF
          FFFDFDFDFEFEFEFFFFFFFFFFFFDBDBDB0000005F5F5FC2C2C2C1C1C154545403
          03034C4C4CFCFCFCFFFFFFFCFCFCFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFF49686795D372B41302D5286927BDCEA6ADFE8005B61003B3F04646A47D0E0
          4DD7E93291A000252D0A2C2B5F8B85348B880A727700354800364E00687C44CB
          DB6CDBE52A828800363A36767797EAEB8ADCDD003C3E18403F22333037595976
          CFDD6DD0DE3778791E342F4828229B6D66FFFBF5FFFEFAFFFDFEFEFEFE383D3B
          000300000200000806011215A0ACB0F9FDFEFDFDFDFFFFFFFAFAFAFFFFFFFFFF
          FFF7F7F7131313000000FFFFFFFFFFFF3D3D3D000000444444FFFFFFFEFEFE19
          1919000000C5C5C5FDFDFDD3D3D3000000000000DBDBDBFFFFFFFFFFFFF5F5F5
          FCFCFCDCDCDC000000030303F0F0F0FCFCFCFFFFFF191919000000A6A6A6FFFF
          FFFAFAFAFFFFFFFFFFFFFFFFFF424242000000828282FFFFFFFFFFFF58585802
          02027F7F7FFFFFFFFFFFFFFFFFFFFCFCFCFFFFFFFAFAFA111111030303FFFFFF
          F8F8F8434343000000C1C1C1FFFFFFFFFFFF272727000000E4E4E4F9F9F9FBFB
          FBFFFFFFFAFAFAFBFBFBFFFFFFE4E4E43F3F3F000000000000232323B4B4B4FE
          FEFEFFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFF4040402F2F2FFFFFFFFBFBFB
          222222000000B3B3B3FFFFFFFEFEFEFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDF3998378623A2E4A373457848F7AD2E06EDBE3006B6E086A6A5AC8
          CC4CE6F147DEEC6BD5E078BBBE3F615B4F71678ED2C787D9D46FBAC263B5C160
          C4D077DAE284CED237706F113632578079A2DED88ECEC810443D1C3F35232D21
          374E4999E7EE7FD7DE38716E1B2C2349291EA5776FFFFEF8FFFAF6FFFEFFFCFA
          FA3E413F030904757E7BA0ABA919282B051115C2C6C7FAFAFAFCFCFC7B7B7B90
          9090C4C4C4979797000000131313FFFFFFF7F7F73D3D3D0000002222222C2C2C
          4747470000000D0D0DE2E2E2F6F6F6FFFFFF4E4E4E0202022727279393939B9B
          9B7B7B7BFDFDFDF9F9F9515151000000474747B9B9B96B6B6B000000292929FF
          FFFFFDFDFDFFFFFFFBFBFBF5F5F5FCFCFC424242000000888888FDFDFDC8C8C8
          4646460000005757579B9B9BEEEEEE6D6D6DA0A0A0B5B5B59494940101010808
          08FEFEFEFFFFFF424242000000C5C5C5F4F4F4FFFFFF1111110E0E0ED6D6D6FF
          FFFFFFFFFFF0F0F0FFFFFFFFFFFFF6F6F63333330000000F0F0F727272EAEAEA
          FFFFFFFFFFFFFAFAFAFFFFFFFEFEFEFFFFFFFBFBFBFDFDFDA0A0A0040404D1D1
          D1B4B4B4020202191919F6F6F6FFFFFFF9F9F9FFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFCF7A382795F35294B38336687908DD5E17BDCE006716F16
          7C775FD6D540DEE440D6E06FD1D98BC1C2394C432D3A2A81A79198D1BC9AE2D6
          95E3DC94DBD880B3AF81938C4443393637277A8674B4D8C7B0D7C73C57472931
          20422E1C6F675A9CC5C791C6C9607F783F3E3051271A9A695FFFF8F0FEFAF5F9
          F7F7FFFEFF3C3A3A020000A2A19DFFFFFEB5B8BC04070B1C1E1FF9F9F9FAFAFA
          7D7D7D171717000000000000202020BFBFBFF7F7F7FEFEFE6565651C1C1CA0A0
          A06060600909090202027D7D7DFCFCFCFFFFFFFBFBFBF1F1F16868680C0C0C08
          0808000000383838FFFFFFFAFAFAEAEAEA7474740909090000000505054C4C4C
          F7F7F7F2F2F2FBFBFBFFFFFFFCFCFCFFFFFFFFFFFF474747020202868686F6F6
          F69E9E9E010101060606090909242424E9E9E97E7E7E1414140000000000001C
          1C1CB5B5B5FFFFFFFBFBFB5555551F1F1FC4C4C4FFFFFFFCFCFC4444441B1B1B
          E3E3E3F5F5F5FFFFFFFFFFFFFFFFFFFFFFFFC1C1C1020202040404C0C0C0FFFF
          FFFFFFFFFFFFFFFFFFFFFAFAFAFFFFFFFCFCFCFFFFFFFDFDFDF7F7F7F7F7F710
          10106A6A6A575757000000777777FDFDFDF4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFDF8A889805E37294A372F6A878C9BDAE284DADA
          0B6A6300463E056D6653DEE15DE2E934888D19403E413D3242332032321A3D4F
          383D62523660553F5E57444C455A4137542D1F532F1D462E1A2F2F1D3A443321
          28193A3B2B4136223027193139383A44443331263E25155D2919A47365FFFDF4
          FCFDF9FDFFFFF8F9FD423D3E080000A39A97FFFEFEB6AFB2050106000001FFFF
          FFFEFEFEFFFFFFF7F7F7F1F1F1EEEEEEF8F8F8F2F2F2FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFAFAFAF5F5F5F5F5F5FFFFFFFFFFFFFFFFFFF9F9F9FFFFFFF7F7F7
          FFFFFFE0E0E0FDFDFDFEFEFEFFFFFFFDFDFDFFFFFFEFEFEFFFFFFFE2E2E2FCFC
          FCFCFCFCF2F2F2FFFFFFFDFDFDFEFEFEFFFFFFF4F4F4FEFEFE3E3E3E0404047E
          7E7EFFFFFFECECEC6666660303037B7B7BFFFFFFFFFFFFFDFDFDFDFDFDF1F1F1
          E5E5E5FAFAFAFFFFFFFFFFFFFBFBFBFFFFFFFDFDFDFFFFFFF5F5F5FFFFFFFFFF
          FFFFFFFFFFFFFFF9F9F9FFFFFFF4F4F4FFFFFFF9F9F9CCCCCC060606111111FF
          FFFFFFFFFFF0F0F0FCFCFCFFFFFFFFFFFFFFFFFFF8F8F8FFFFFFFFFFFFF8F8F8
          FFFFFF606060131313151515000000D5D5D5FBFBFBFDFDFDFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFBF1A49386603E2E4E3B2E6F8785A4E0
          DF8BDED51D6E5F00372A2362586ED0D063C8CA64A9A620392F5231216C34215B
          301D502D1F4C2E294024243A20204D2C294D1C14692C22752F227232275A2A24
          51342F403D357484797292813447383823214A211F4D2114602D19753321AB77
          67FFFBEFF4FEF8F2FBFEF7FDFF4A47490700003B2D2E3628290B000007000152
          5050F4F4F4FFFFFFF1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFBFBFB
          F6F6F6FEFEFEFDFDFDFFFFFFFFFFFFFCFCFCFAFAFAFFFFFFF9F9F9FFFFFFF9F9
          F9FEFEFEF8F8F8FAFAFAFFFFFFF6F6F6FCFCFCFFFFFFF3F3F3FFFFFFFFFFFFF6
          F6F6FFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFEFEFEF9F9F9FFFFFFFFFFFF3C3C3C
          000000787878FFFFFFFFFFFFD2D2D29E9E9EC5C5C5FBFBFBFDFDFDFFFFFFF5F5
          F5FFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFBFBFBFFFFFFAAAAAA535353E8
          E8E8FEFEFEFAFAFAFAFAFAFEFEFEFFFFFFFFFFFFFAFAFAFFFFFFF5F5F51D1D1D
          0505054444447A7A7A545454343434FDFDFDFFFFFFFDFDFDFBFBFBFDFDFDFFFF
          FFFFFFFFFBFBFBC4C4C40101010000002D2D2DFFFFFFFFFFFFFFFFFFFDFDFDFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFF5A494845C3D285943317F
          8E86B6E0D9A0DBCC42766431443353675BA1D7D79AD8D86B958E313425723B26
          8030196A240D601E0C66221B682726632A29733C376024187533216F21117223
          166A211D59232250323190908ABDDACBA6B7A9673F3A6D2C246429166C2E166E
          2A13A2705CFFFDF0F3FFFCEDFCFEF6FEFF7D7C80665E5F6F63635F5351766E6E
          A19C9DF7F5F5FFFFFFFCFCFCF6F6F6FFFFFFFEFEFEF7F7F7FFFFFFFDFDFDFFFF
          FFFBFBFBFFFFFFFFFFFFF5F5F5FFFFFFF7F7F7FFFFFFFFFFFFF7F7F7FFFFFFFB
          FBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFAFAFAFFFFFF
          FCFCFCFFFFFFF8F8F8FBFBFBFAFAFAF9F9F9FBFBFBFFFFFFFFFFFFFFFFFFF1F1
          F18C8C8C656565AFAFAFFFFFFFFFFFFFF9F9F9FFFFFFFBFBFBFFFFFFFFFFFFFB
          FBFBFFFFFFFAFAFAFAFAFAFFFFFFF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          4444442C2C2CE7E7E7FFFFFFFFFFFFF8F8F8F8F8F8FFFFFFFAFAFAFDFDFDFDFD
          FDF1F1F15959592424241919193535355A5A5AFEFEFEFFFFFFFAFAFAFFFFFFFD
          FDFDFBFBFBFFFFFFFDFDFDFFFFFF6C6C6C686868B3B3B3FFFFFFFEFEFEF8F8F8
          FDFDFDFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFF5AC92825F4027
          654B33797368959E948C9E8D5D644F5A4230674F437880807E9091696B65573D
          2D843A228C32148F3F20843A1E7C301E742D1F652A1B602B175D280D5F28096B
          2D0F6B2910742D1F752F2868252270403C8A7A6E9485758A594F76392B662E15
          652F116B2F12A87E67FFFFF4E7FBF6F1FFFFF4FDFFFDFDFFFFFEFFF9F4F1FFFF
          FCEDF4F1F5FEFBF3F5F5FFFFFFFBFBFBFFFFFFFEFEFEFFFFFFFFFFFFFEFEFEFF
          FFFFF3F3F3FFFFFFFAFAFAFAFAFAFFFFFFF9F9F9FFFFFFFDFDFDFFFFFFFFFFFF
          FFFFFFFDFDFDFBFBFBFEFEFEFAFAFAF8F8F8F9F9F9FFFFFFFBFBFBF9F9F9FFFF
          FFF8F8F8FFFFFFFFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFFFDFDFDFDFDFDFE
          FEFEFFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFDFDFDFFFFFFFBFBFBFFFFFFF6F6F6
          F7F7F7FFFFFFF9F9F9FFFFFFFDFDFDFCFCFCFFFFFFFFFFFFFFFFFFFAFAFAFFFF
          FFFFFFFFE0E0E0777777AFAFAFFFFFFFF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFDFDFDFAFAFAFDFDFDFCFCFCFFFFFFF8F8F8FFFFFFFFFFFFFDFDFDFDFDFD
          FFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFFF6F6F6F9F9F9FFFFFFF7F7F7FFFF
          FFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFBF2B693
          85724D376F4D365A3D2F4E362A5B453360402D7844336F3B2E573A36533E3C55
          382F703F2F94442D8D3315843514883C1F83351E8138247A3B26652C137D4627
          6E3815804727783A1C76311D7C31238231297129216134266035246E2F21702C
          19773B2370391E602A119E7965FFFFF7F5FFFDF6FFFFF5FBFFFAFAFFFFFEFFFF
          FDFCFDFFFEF3FEFBF6FFFFFBFFFFFCFCFCFFFFFFFAFAFAFFFFFFFAFAFAFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF3F3F3FFFFFFFEFEFEF5F5F5FFFFFFFFFFFFFCFC
          FCFBFBFBFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF9F9F9FFFFFFFF
          FFFFF8F8F8FFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFEFEFEFCFCFCFBFBFBFFFFFF
          FBFBFBFBFBFBFFFFFFF2F2F2FDFDFDFFFFFFF9F9F9FDFDFDFAFAFAFFFFFFFBFB
          FBFFFFFFFDFDFDFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFFFFFFFF
          FFFFF6F6F6FFFFFFFAFAFAFFFFFFF9F9F9FAFAFAFFFFFFFDFDFDFBFBFBFFFFFF
          FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFBFBFBFFFFFFFAFAFAFFFFFFFDFD
          FDFFFFFFFAFAFAFFFFFFFFFFFFFDFDFDFEFEFEFBFBFBFFFFFFFFFFFFF6F6F6FF
          FFFFFBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          F5EFB68F877E51447E4A3D7841347940318348387D3F2D864334844335784138
          7641377840357E3F318B3F2D8E3F2A8D432B8A422A883F29843E27803D267E3E
          267E3E257E3F23824027813F26813D26833C28833B29803B28773A2678392585
          3524833120823A28773927693528A27E74FFFAF4FFFCFBFFFEFFFFFEFFFFFEFF
          FFFEFFFFFEFFFDFFFFFBFFFFFBFFFFFCFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDF8BE9893895B538B554A8E4D3F924C3B9D5341964C3A924C3B914C
          3D8D4C3E8D4C3E8D4C3E8D4A3B8F49388E49368F4A368D4A358D48348B48338B
          46328946318A45318946318C47338A47328A45318845308A453188453087422E
          8A412D96402E913A2A8D42327D40326B3D32A3817BFFF9F7FFFBF9FFFEFFFFFE
          FFFFFDFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFEFEFEFEFEFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFBF4BB9E958A64588E5F51925A49985846A15D4A9B574495
          554394564692574893584992574792564693534194523F96544195534096523F
          93513E94503D92503D94503D92503D97534094523F95513E93513E95513E9250
          3D924E3B944C3A9B4C39964837934E3D834C3D71493DA4897FFFFBF6FFFDFAFF
          FEFFFFFFFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFFFFFEFEFEFEFEFEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFCF4BFA99E9373669A7162A06E5CA56C57AB6F59
          A66A54A36854A068559F69589D69589F69589D6854A06752A06551A46654A365
          53A56553A26452A46452A26452A36351A16351A1614F9E604E9F5F4D9D5F4D9F
          5F4D9C5E4C9C5C4A9C5A48A158449D5543955A47885747795649A89287FFFCF6
          FFFDFAFFFFFEFFFFFFFFFEFFFFFEFFFFFEFFFFFFFFFFFFFFFFFFFFFEFEFEFEFE
          FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFAEEC0AFA2987F6FA07F6CAB7E69AD7B
          64B07A63AC765FAC7762A97763A67762A37661A47560A77561AA7560AD7661AC
          7461AC7463AE7363AB7362AD7262AA7261AC7161AA7261AC7161A97160AA6F5F
          A76F5EA96E5EA66E5DA66B5BA56A57AA6954A667529E6955916655836658AC9A
          8FFFFEF7FFFDFAFFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFFFEFFFFFEFFFFFFFEFF
          FEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFCF0C7B7AAA18A7AA98976B5
          8B74B6846DB88269B68067BB8671B78670B3846FB0836EB1826DB4836DB7856E
          BA8570B6836FB68271B68271B58170B58170B4806FB37F6EB27E6DB27E6DB17D
          6CB07C6BAF7B6AAF7B6AAD7968AB7766AE7663B47862B37761A976629C746290
          7365B4A297FFFEF7FFFEF9FFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFE
          FFFFFEFFFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFF5D5C4B7AF9585
          B4907EC1927CC08C75C28A71C28A71C7907BC48F7AC18E7ABF8D79C08E78C38E
          79C69079C68F7AC18F7BBF8F7DBF8F7DBE8E7CBD8D7BBC8C7ABB8B79BA8A78B2
          8270B1816FB0806EAF7F6DAE7E6CAD7D6BAB7B69AC7965B57864B67965AB7864
          9F776596796BB7A59AFFFFF6FFFDF8FFFFFEFFFFFEFFFFFFFFFFFFFFFFFEFFFF
          FEFFFFFEFFFFFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFEF3D4BE
          B2AC8D7EAE8674BA8773BA816BBB7F69BF806BBB806CBA816CB9816EB9816EB9
          816EBB826DBD806CBB806CB98470B68470B68472B5836FB48270B2806CB17F6D
          B07E6AB17F6DB07E6AAF7D6BAE7C68AD7B69AC7A66A97765AD7562B1725EB374
          60A973629F746399796CB9A59AFFFCF4FFFCF7FFFFFCFFFFFEFFFFFFFFFFFFFF
          FFFEFFFFFEFFFFFCFFFFFCFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          F5EEDFC2B9A07D70A07463AD7562BD7E69A7644FC27F6AB2705DB0705EAE7060
          AE705EAF715FB1725EB5715EB3715EB0735FAE735FAD725FAD725EAC715EAC71
          5DAB705DAB705CAC715EAC715DAB705DA96E5AA76C59A56A56A56A57A86B57AC
          6754AF6B58A368588B5C4E987568B59C92FFFDF7FBF5F0FFFFFCFFFFFEFFFFFF
          FFFFFFFFFFFEFDFFFEFDFFFCFDFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDF8DEBFB6896259A576689B60509C5A47B06B589A5542A35E4DA15E
          4F9F5E4F9F5E4FA15E4FA35E4DA45E4DA45F4CA6614EA5614EA4604DA4604DA3
          5F4CA35F4CA25E4BA25E4B9E5A479E5A479E5A479D59469C58459B57449C5845
          9E59469B5341985342965B4C8F60526E4B3EBEA49DFFF6F0FFFFFCFFFFFEFFFF
          FEFFFFFFFFFFFFFDFFFEFDFFFEFBFFFCFBFFFCFDFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE
          FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFDF9FEE1DA89625A8454488F54458A4A389C574696503F91
          4C3D8F4B3E8C4B3D8A4B3D8C4B3D8D493C90493B924A39964A38964A38964A38
          9549379549379448369448369448369145339145339145339044328F43318F43
          318F43318E4432873F2E7C3C2A773E2F7C4F427A574DF3DBD5FFF9F6FFFCF9FF
          FFFEFFFFFFFFFEFFFFFFFFFDFFFEFDFFFEFBFFFCFBFFFCFDFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFF6F3FFF5F1AA8882693F337D483B884D3D6D2F1F
          8241327A3B2D783A2F763A2E76392F75382E76382D7B372A7D38298139288338
          288237278237278237278237278136268136268237278237278237278035257E
          33237D32227E33237C34237634227E4333693528532B1F91746BFFF6EFFFFEFA
          FEF6F6FFFEFFFFFFFFFFFEFFFFFEFFFDFFFFFDFFFEFBFFFEFBFFFEFDFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFCFFFFFBF3DDD79D7E755D33276130
          225E291C723B2E622D20612D215E2B215E2B215D2A205F2B1F63281E65291D68
          2B1D6A2B1D6A2B1D6A2B1D6A2B1D692A1C692A1C692A1C6A2B1D6A2B1D6A2B1D
          68291B67281A66271967281A65281A6831225A2919592F22927267EBD6CEFFFF
          F9FFFAF7FFFFFEFFFFFFFFFEFFFFFEFFFFFEFFFFFFFFFFFFFEFDFFFEFDFFFEFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFF8F8F8FAF7F3FFFDF7E5D0C88F
          6F646A4335673B2E55281B562A1D542A1E52292052292051281F53291D56281D
          58281C57271B57271B57271B57271B57271B57271B57271B57271B56261A5727
          1B58281C57271B57271B57271B59291D582B1E5328195B3727876A5CEED8CCFF
          FFF7FFFCF5F4F3EFF5F7F7FDFFFFFDFFFFFFFEFFFFFEFFFFFEFFFFFFFFFFFFFF
          FFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFF6FFFFFAFFFEFFFFFA
          FFFFF8FFF9EEE9CCBEBE9D8E8E6D5E98786B96786D93766D93766D95766D9777
          6C9A776A9A776A93756A91756A91756A91756A91756A91756A91756A92766B90
          746991756A92766B92766B92766B92766B94786D957A6CA18475E6CCBBFFF7E8
          FFFFF5F2EDE4FFFFFAFBFFFEF7FDFCFAFFFFFBFEFFFDFEFFFFFEFFFFFEFFFFFE
          FFFFFEFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
        Stretch = True
      end
      object QRShape58: TQRShape
        Left = 668
        Top = 701
        Width = 189
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          1472.847222222222000000
          1545.607638888889000000
          416.718750000000000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel117: TQRLabel
        Left = 170
        Top = 656
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
          1446.388888888889000000
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
      object QRLabel118: TQRLabel
        Left = 687
        Top = 566
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
          1247.951388888889000000
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
      object QRLabel119: TQRLabel
        Left = 14
        Top = 626
        Width = 120
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          30.868055555555560000
          1380.243055555556000000
          264.583333333333400000)
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
      object QRLabel120: TQRLabel
        Left = 158
        Top = 626
        Width = 164
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          348.368055555555600000
          1380.243055555556000000
          361.597222222222300000)
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
      object QRLabel121: TQRLabel
        Left = 338
        Top = 626
        Width = 65
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          745.243055555555600000
          1380.243055555556000000
          143.315972222222200000)
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
      object QRLabel122: TQRLabel
        Left = 478
        Top = 626
        Width = 169
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1053.923611111111000000
          1380.243055555556000000
          372.621527777777800000)
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
      object QRLabel123: TQRLabel
        Left = 687
        Top = 596
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
          1314.097222222222000000
          350.572916666666700000)
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
      object QRLabel124: TQRLabel
        Left = 686
        Top = 626
        Width = 160
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1512.534722222222000000
          1380.243055555556000000
          352.777777777777900000)
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
      object QRLabel125: TQRLabel
        Left = 686
        Top = 656
        Width = 160
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.482638888888900000
          1512.534722222222000000
          1446.388888888889000000
          352.777777777777900000)
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
      object QRLabel126: TQRLabel
        Left = 24
        Top = 717
        Width = 621
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          52.916666666666660000
          1580.885416666667000000
          1369.218750000000000000)
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
      object QRLabel127: TQRLabel
        Left = 24
        Top = 732
        Width = 621
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          52.916666666666660000
          1613.958333333333000000
          1369.218750000000000000)
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
      object QRLabel128: TQRLabel
        Left = 24
        Top = 748
        Width = 621
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          52.916666666666660000
          1649.236111111111000000
          1369.218750000000000000)
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
      object QRLabel129: TQRLabel
        Left = 24
        Top = 763
        Width = 621
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          52.916666666666660000
          1682.309027777778000000
          1369.218750000000000000)
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
      object QRLabel130: TQRLabel
        Left = 24
        Top = 778
        Width = 621
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          52.916666666666660000
          1715.381944444444000000
          1369.218750000000000000)
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
        OnPrint = QRLabel65Print
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 6
      end
      object QRLabel131: TQRLabel
        Left = 762
        Top = 840
        Width = 68
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          1680.104166666667000000
          1852.083333333333000000
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
      object QRLabel132: TQRLabel
        Left = 24
        Top = 688
        Width = 621
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          52.916666666666660000
          1516.944444444444000000
          1369.218750000000000000)
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
      object QRLabel133: TQRLabel
        Left = 24
        Top = 701
        Width = 621
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.868055555555560000
          52.916666666666660000
          1545.607638888889000000
          1369.218750000000000000)
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
      object QRLabel134: TQRLabel
        Left = 453
        Top = 801
        Width = 212
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.097222222222230000
          998.802083333333400000
          1766.093750000000000000
          467.430555555555600000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = ' '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = InsSacPrint
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 7
      end
      object QRLabel136: TQRLabel
        Left = 108
        Top = 570
        Width = 268
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          33.072916666666670000
          238.125000000000000000
          1256.770833333333000000
          590.902777777777800000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'AP'#211'S O VENCIMENTO PAGUE SOMENTE NO ITA'#218
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
      object QRLabel137: TQRLabel
        Left = 687
        Top = 526
        Width = 159
        Height = 21
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          46.302083333333340000
          1514.739583333333000000
          1159.756944444445000000
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
      object QRShape71: TQRShape
        Left = 0
        Top = 170
        Width = 862
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          0.000000000000000000
          374.826388888888800000
          1900.590277777778000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel146: TQRLabel
        Left = 200
        Top = 9
        Width = 82
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666660000
          440.972222222222300000
          19.843750000000000000
          180.798611111111100000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '341-7'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 12
      end
      object QRShape61: TQRShape
        Left = 191
        Top = 9
        Width = 12
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666660000
          421.128472222222200000
          19.843750000000000000
          26.458333333333330000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape62: TQRShape
        Left = 281
        Top = 9
        Width = 10
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666660000
          619.565972222222300000
          19.843750000000000000
          22.048611111111110000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel167: TQRLabel
        Left = 620
        Top = 23
        Width = 101
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1367.013888888889000000
          50.711805555555560000
          222.690972222222200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Comprovante de Entrega'
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
        Left = 5
        Top = 35
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
          77.170138888888890000
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
      object qrlNomeCedente1: TQRLabel
        Left = 57
        Top = 35
        Width = 252
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          77.170138888888890000
          555.625000000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel148: TQRLabel
        Left = 317
        Top = 35
        Width = 89
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          698.940972222222200000
          77.170138888888890000
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
      object QRLabel149: TQRLabel
        Left = 319
        Top = 45
        Width = 176
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          703.350694444444400000
          99.218750000000000000
          388.055555555555500000)
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
      object QRShape66: TQRShape
        Left = 314
        Top = 34
        Width = 1
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          66.145833333333340000
          692.326388888889000000
          74.965277777777790000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel151: TQRLabel
        Left = 5
        Top = 66
        Width = 35
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          145.520833333333300000
          77.170138888888890000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Pagador'
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
      object QRLabel150: TQRLabel
        Left = 46
        Top = 77
        Width = 263
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444450000
          101.423611111111100000
          169.774305555555600000
          579.878472222222300000)
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
      object QRShape67: TQRShape
        Left = 314
        Top = 67
        Width = 1
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          63.940972222222230000
          692.326388888889000000
          147.725694444444400000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape70: TQRShape
        Left = 314
        Top = 94
        Width = 1
        Height = 32
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          70.555555555555560000
          692.326388888889000000
          207.256944444444400000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel153: TQRLabel
        Left = 317
        Top = 65
        Width = 84
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          698.940972222222200000
          143.315972222222200000
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
      object QRLabel152: TQRLabel
        Left = 319
        Top = 74
        Width = 176
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          703.350694444444400000
          163.159722222222200000
          388.055555555555500000)
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
      object QRLabel154: TQRLabel
        Left = 5
        Top = 95
        Width = 48
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          11.024305555555560000
          209.461805555555600000
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
      object QRLabel155: TQRLabel
        Left = 6
        Top = 106
        Width = 110
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          13.229166666666670000
          233.715277777777800000
          242.534722222222200000)
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
      object QRShape68: TQRShape
        Left = 120
        Top = 94
        Width = 1
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          63.940972222222230000
          264.583333333333400000
          207.256944444444400000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel156: TQRLabel
        Left = 126
        Top = 96
        Width = 70
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          277.812500000000000000
          211.666666666666700000
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
      object QRLabel157: TQRLabel
        Left = 121
        Top = 105
        Width = 109
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          266.788194444444400000
          231.510416666666700000
          240.329861111111100000)
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
      object QRShape69: TQRShape
        Left = 234
        Top = 94
        Width = 1
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          63.940972222222230000
          515.937500000000000000
          207.256944444444400000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel158: TQRLabel
        Left = 236
        Top = 96
        Width = 44
        Height = 11
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.253472222222220000
          520.347222222222200000
          211.666666666666700000
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
      object QRLabel159: TQRLabel
        Left = 239
        Top = 106
        Width = 60
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          526.961805555555600000
          233.715277777777800000
          132.291666666666700000)
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
      object QRLabel160: TQRLabel
        Left = 317
        Top = 96
        Width = 94
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          698.940972222222200000
          211.666666666666700000
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
      object QRLabel161: TQRLabel
        Left = 332
        Top = 106
        Width = 160
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          732.013888888889000000
          233.715277777777800000
          352.777777777777900000)
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
      object QRLabel73: TQRLabel
        Left = 4
        Top = 126
        Width = 121
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          8.819444444444444000
          277.812500000000000000
          266.788194444444400000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Recebi(emos) o bloqueto/T'#237'tulo'
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
      object QRLabel162: TQRLabel
        Left = 4
        Top = 136
        Width = 120
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          8.819444444444444000
          299.861111111111100000
          264.583333333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'com as Caracter'#237'sticas acima'
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
      object QRShape86: TQRShape
        Left = 127
        Top = 125
        Width = 1
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          63.940972222222230000
          280.017361111111100000
          275.607638888888900000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel163: TQRLabel
        Left = 131
        Top = 128
        Width = 19
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          288.836805555555600000
          282.222222222222200000
          41.892361111111110000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Data'
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
      object QRShape65: TQRShape
        Left = 221
        Top = 125
        Width = 1
        Height = 29
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          63.940972222222230000
          487.274305555555600000
          275.607638888888900000
          2.204861111111111000)
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel181: TQRLabel
        Left = 227
        Top = 128
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
          282.222222222222200000
          97.013888888888890000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Assinatura'
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
      object QRShape73: TQRShape
        Left = 497
        Top = 34
        Width = 352
        Height = 120
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          264.583333333333400000
          1095.815972222222000000
          74.965277777777790000
          776.111111111111000000)
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape74: TQRShape
        Left = 508
        Top = 51
        Width = 19
        Height = 8
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          17.638888888888890000
          1120.069444444445000000
          112.447916666666700000
          41.892361111111120000)
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape75: TQRShape
        Left = 508
        Top = 62
        Width = 19
        Height = 8
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          17.638888888888890000
          1120.069444444445000000
          136.701388888888900000
          41.892361111111120000)
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape76: TQRShape
        Left = 508
        Top = 72
        Width = 19
        Height = 8
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          17.638888888888890000
          1120.069444444445000000
          158.750000000000000000
          41.892361111111120000)
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel172: TQRLabel
        Left = 529
        Top = 72
        Width = 34
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1166.371527777778000000
          158.750000000000000000
          74.965277777777780000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Ausente'
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
      object QRLabel171: TQRLabel
        Left = 529
        Top = 62
        Width = 41
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1166.371527777778000000
          136.701388888888900000
          90.399305555555560000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Recusado'
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
      object QRLabel170: TQRLabel
        Left = 529
        Top = 51
        Width = 38
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1166.371527777778000000
          112.447916666666700000
          83.784722222222220000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Mudou-se'
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
      object QRLabel168: TQRLabel
        Left = 546
        Top = 38
        Width = 236
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1203.854166666667000000
          83.784722222222220000
          520.347222222222200000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Motivos de n'#227'o entrega.(Para uso da empresa entregadora)'
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
      object QRShape77: TQRShape
        Left = 604
        Top = 51
        Width = 19
        Height = 8
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          17.638888888888890000
          1331.736111111111000000
          112.447916666666700000
          41.892361111111120000)
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel173: TQRLabel
        Left = 624
        Top = 51
        Width = 35
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1375.833333333333000000
          112.447916666666700000
          77.170138888888890000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Falecido'
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
      object QRLabel174: TQRLabel
        Left = 624
        Top = 62
        Width = 58
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1375.833333333333000000
          136.701388888888900000
          127.881944444444400000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Desconhecido'
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
      object QRShape78: TQRShape
        Left = 604
        Top = 62
        Width = 19
        Height = 8
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          17.638888888888890000
          1331.736111111111000000
          136.701388888888900000
          41.892361111111120000)
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape79: TQRShape
        Left = 604
        Top = 72
        Width = 19
        Height = 8
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          17.638888888888890000
          1331.736111111111000000
          158.750000000000000000
          41.892361111111120000)
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel175: TQRLabel
        Left = 624
        Top = 72
        Width = 60
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1375.833333333333000000
          158.750000000000000000
          132.291666666666700000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'N'#227'o procurado'
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
      object QRShape82: TQRShape
        Left = 713
        Top = 72
        Width = 19
        Height = 8
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          17.638888888888890000
          1572.065972222222000000
          158.750000000000000000
          41.892361111111120000)
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel178: TQRLabel
        Left = 736
        Top = 72
        Width = 100
        Height = 11
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.253472222222220000
          1622.777777777778000000
          158.750000000000000000
          220.486111111111100000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Outros (Anotar no verso)'
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
      object QRLabel177: TQRLabel
        Left = 736
        Top = 62
        Width = 90
        Height = 11
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.253472222222220000
          1622.777777777778000000
          136.701388888888900000
          198.437500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'N'#227'o existe n'#186' indicado'
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
      object QRShape81: TQRShape
        Left = 713
        Top = 62
        Width = 19
        Height = 8
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          17.638888888888890000
          1572.065972222222000000
          136.701388888888900000
          41.892361111111120000)
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape80: TQRShape
        Left = 713
        Top = 51
        Width = 19
        Height = 8
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          17.638888888888890000
          1572.065972222222000000
          112.447916666666700000
          41.892361111111120000)
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel176: TQRLabel
        Left = 736
        Top = 51
        Width = 88
        Height = 11
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.253472222222220000
          1622.777777777778000000
          112.447916666666700000
          194.027777777777800000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Endere'#231'o insuficiente'
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
      object QRLabel180: TQRLabel
        Left = 685
        Top = 127
        Width = 46
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1510.329861111111000000
          280.017361111111100000
          101.423611111111100000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Entregador'
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
      object QRShape84: TQRShape
        Left = 624
        Top = 117
        Width = 181
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444450000
          1375.833333333333000000
          257.968750000000000000
          399.079861111111200000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape83: TQRShape
        Left = 535
        Top = 117
        Width = 78
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444450000
          1179.600694444445000000
          257.968750000000000000
          171.979166666666700000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel179: TQRLabel
        Left = 551
        Top = 127
        Width = 19
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          22.048611111111110000
          1214.878472222222000000
          280.017361111111100000
          41.892361111111110000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Data'
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
      object QRShape87: TQRShape
        Left = 4
        Top = 153
        Width = 493
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          8.819444444444444000
          337.343750000000000000
          1086.996527777778000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel164: TQRLabel
        Left = 5
        Top = 155
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
          341.753472222222200000
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
      object QRLabel165: TQRLabel
        Left = 88
        Top = 155
        Width = 713
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444450000
          194.027777777777800000
          341.753472222222200000
          1572.065972222222000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 
          'AT'#201' O VENCIMENTO PAGUE PREFERENCIALMENTE NO ITA'#218' / AP'#211'S O VENCIM' +
          'ENTO PAGUE SOMENTE NO ITA'#218
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
      object QRShape59: TQRShape
        Left = 4
        Top = 34
        Width = 493
        Height = 1
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2.204861111111111000
          8.819444444444444000
          74.965277777777790000
          1086.996527777778000000)
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRImage4: TQRImage
        Left = 7
        Top = 1
        Width = 124
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          66.145833333333340000
          15.434027777777780000
          2.204861111111111000
          273.402777777777800000)
        AutoSize = True
        Picture.Data = {
          07544269746D6170C63F0000424DC63F00000000000036000000280000009600
          0000240000000100180000000000903F00000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFAF7F3FFFBF6F8F2EDFFFEFAFFFCF9D7C3BE9D8482
          7D61607D5F5E7F605F7F5F607F5E627E5F627C5E637C5D647A5F637D5F647D5F
          647D5F647D5F647D5F647D5F647D5F647D60637C5F627D60637D60637C5F627B
          5E617C60607E61648165658E6F70F0D4D4FFFCFBFFF9F7FFFAF7F9F8F4F2F7F5
          FAFFFEFBFFFEFBFFFEFDFFFEFDFFFEFDFFFFFDFFFFFDFFFFFDFFFFFEFEFEFEFE
          FEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFBFFFDF7FFFFF9E4D0CB836A663E20
          1B3815124F282639100E3B0F103C10113D10133C10163A1116390F16390F163A
          10173A11163A11163A11163A11163A11163A11163A12143A1214381012370F11
          370F113911133A12133A12143A1214431B1D300B0D6E4F50DDC5C5FFFEFCFDF6
          F3F9F8F4FFFFFCFDFFFEFFFFFEFFFFFEFFFFFEFFFFFEFDFFFEFDFFFEFDFFFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFF9F4FFFEF9F2D9D580635E51
          2E2A49201D2F02005524224C16164F161750171A4E171A4E161B4C161D4B141D
          49151C49151C49151C49151C49151C49151C49161A49161A49161A4A171B4815
          194613174715174917194A181A4816184614164F1D2140131647202278595AD7
          C2C1FFFEFCFFFEFBF9F6F2FFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFE
          FFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFF6F1FFEEE9B99994
          542F2B4419165C2C285D2623561B195B1B1B5C1A1B5D1A1D5C191E5B171E5916
          1D55141D52131C53141D53151B53151B53151B53151B53151B53151B53161A53
          161A53161A53161A54171B54171B5317185115164E13174B11163E080D401316
          4A2527775B5BFFEBEAFFFEFCFAF3F0FFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFF
          FEFFFFFEFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFEF7FFE5
          DE704B4350231F69383A49171B532322501A196121206121215B1F25571E2651
          1C264B192349172145161F45192045192045182147182147182147191F471B1C
          4B1B1A511819561A1B591B21521C23461A2040181D45171D45161E4619224E23
          2C451D223A13154B2525EFD1D0FFF4F2FFFEFEFFFEFFFFFEFFFFFFFEFFFFFEFF
          FFFEFFFFFEFFFFFEFDFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFF2CEB9AA6C42356A37345928363B14242E141A2E100F44120C521D1A47252C
          2B17241A0D1D09020F160F1C1F1C252023280D0F17120E1A110A190500091A14
          191514101C1109310B064F1C1A511D24401E280C0D170008120D06131609190E
          02161808191801093D1B1B592322C79795FFF4F1FFFFFFFEFDFFFCFEFFFFFFFF
          FDFEFCFFFFFCF9FFFAF8FFFFF5FDFCFDFFFFFDFDFDFFFFFFFEFEFEFFFFFFFFFF
          FFF7F7F7FFFFFFFFFFFFFCFCFCFFFFFFFFFFFFFDFDFDFFFFFFF9F9F9FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFF5F5F5FFFFFFFDFDFDFFFFFFFCFCFCFFFFFFFEFEFE
          FFFFFFFFFFFFFCFCFCFFFFFFFFFFFFFEFEFEFFFFFFF8F8F8FFFFFFFCFCFCFFFF
          FFF7F7F7FFFFFFFFFFFFFFFFFFFBFBFBFFFFFFFFFFFFFCFCFCFFFFFFFAFAFAFF
          FFFFFFFFFFFDFDFDFFFFFFFDFDFDFFFFFFFAFAFAFFFFFFFFFFFFFFFFFFFFFFFF
          FCFCFCFDFDFDFAFAFAFFFFFFFFFFFFFDFDFDFFFFFFFEFEFEFFFFFFFFFFFFFFFF
          FFFFFFFFFBFBFBFFFFFFFDFDFDFEFEFEFFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFF
          FFFFF5F5F5FFFFFFFFFFFFFDFDFDFFFFFFF9F9F9FFFFFFFAFAFAFFFFFFFFFFFF
          FFFFFFF4F4F4FFFFFFFDFDFDFDFDFDFEFEFEFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDEAB9AA976038265D2E2A5F4251584F634252581D2B2729170C4330
          293F454C435A693D606E456D7900242C001B2326585E3D707A4975862A546700
          212F0232382653501431281B150E3723224032383E4754487A863877851A4E5B
          001C2D30576D415F702C383E1E110F451814B58682FFFBF8FCFCFCFDFEFFF5F6
          FAFFFFFFF7F5F4FFFFFCFBFFFCF6FFFFF6FFFFF8FDFCFFFFFFF6F6F6FBFBFBFF
          FFFFF7F7F7FFFFFFFDFDFDFDFDFDFCFCFCFBFBFBFFFFFFEEEEEEFFFFFFFFFFFF
          FEFEFEFDFDFDFFFFFFFCFCFCFEFEFEFFFFFFF0F0F0FFFFFFF8F8F8FFFFFFFFFF
          FFFFFFFFF4F4F4FFFFFFFFFFFFFBFBFBFFFFFFFCFCFCFDFDFDFEFEFEF8F8F8FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9F6F6F6FFFFFFFFFFFFFCFCFCFFFFFF
          FFFFFFF8F8F8FFFFFFFFFFFFFDFDFDFFFFFFFFFFFFFFFFFFF7F7F7FEFEFEFCFC
          FCFBFBFBFFFFFFFFFFFFF7F7F7FDFDFDFFFFFFFFFFFFF8F8F8FFFFFFF6F6F6FF
          FFFFFFFFFFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFF9F9F9FBFBFBFFFFFFFAFAFA
          FDFDFDFFFFFFFFFFFFFEFEFEF5F5F5FBFBFBFFFFFFFFFFFFF5F5F5FFFFFFF3F3
          F3F8F8F8FFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFFFFFFF7F7F7FFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFF0AC9E88572F1D55362D858E97A5D3DE87D4D127716500
          23131E3C2F6DA9A98EDEE58FEAEF80DBDF00494A277A7B6CCED474DCE975D5EC
          67CBE32D9DAF47B6C084E3E6428B890016150A2D30699DA48CD6E27BE4F163DE
          E85FDEE61E9AA25CC9D771CBD63D7D7D01201932221B92766FFFFDF9F6F7F5FB
          F8FAFFFEFFFBF3F4FFFEFEFFFFFCFDFBFAFBFFFFF2F7FAFDFFFFF9F9F9FFFFFF
          FDFDFDDEDEDEECECECFFFFFFFFFFFFE4E4E4EDEDEDFAFAFAFFFFFFFFFFFFFBFB
          FBFCFCFCFDFDFDFBFBFBFFFFFFFAFAFAF5F5F5FDFDFDFFFFFFFFFFFFEFEFEFDF
          DFDFD7D7D7FFFFFFFFFFFFFFFFFFF8F8F8FFFFFFE9E9E9EBEBEBE0E0E0FFFFFF
          FFFFFFFCFCFCFEFEFEFFFFFFF1F1F1FBFBFBFFFFFFFFFFFFFFFFFFF9F9F9FFFF
          FFFFFFFFF5F5F5FFFFFFE8E8E8DCDCDCFCFCFCFFFFFFDFDFDFE7E7E7FFFFFFFF
          FFFFE2E2E2F1F1F1FFFFFFF4F4F4F8F8F8E3E3E3F6F6F6FBFBFBFFFFFFFFFFFF
          FFFFFFFAFAFAFFFFFFFCFCFCFBFBFBF4F4F4F9F9F9F5F5F5C5C5C5C9C9C9CACA
          CAF5F5F5FFFFFFF6F6F6FFFFFFF3F3F3FFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFB
          FBFBFFFFFFFEFEFEFEFEFEF9F9F9F6F6F6FFFFFFFDFDFDFFFFFFFBFBFBF7F7F7
          0000FFFFFFFFFFFFFFFFFFFFFFEBAB96815F3A2643312664898D85D5DC70DED8
          00685B002C1B23615580D8D860C6CB4CB4B92186880055526ACDCB63DEE255D0
          DE127992228DA840C3D75CE6F355D0D4177B7B00282821646779CFD580E5ED53
          C6D127A3AD39BEC24FD7DD59E1ED66DFE926808000261E333127846F67FFFDF8
          FCFDFBFFFEFFFCF5F84C41430D01010900000700000703082C2B2F969597FFFF
          FFF7F7F74545450000000404046565655A5A5A000000090909FFFFFF33333300
          0000A3A3A3FFFFFFFFFFFF262626000000C8C8C8FFFFFFFCFCFCE9E9E9525252
          0000000000001111110D0D0DFCFCFCFAFAFAEAEAEA5050500303030000000000
          00363636D6D6D6FFFFFFFEFEFEF8F8F8FFFFFFFFFFFFF3F3F345454500000086
          8686FBFBFBFFFFFFE5E5E5272727000000070707BDBDBD383838000000000000
          6969695B5B5B020202030303FFFFFFCECECE1010100303030D0D0DB9B9B91B1B
          1B000000E3E3E3FFFFFFF8F8F8FFFFFFFFFFFFFFFFFFC4C4C40A0A0A00000000
          00000000000D0D0D8E8E8EFFFFFFA5A5A50202021C1C1CF8F8F85E5E5E0E0E0E
          FFFFFFFFFFFFFAFAFAF8F8F8FFFFFFF7F7F7101010050505C9C9C99797970202
          022626260000FFFFFFFFFFFFFFFFFFFFFFEDB1927D64412D3D352857878B79D3
          DA6FDDDB00635A002C201D665E71CFD47AD9E3539FAB00111800424194EBE755
          CDCD097A84000823001D3C005F765DDDEA6BE9EA23928E001B17317E7B84E1E0
          7ED9DD227077003239003D413082875FD6E55FD9E717717200272137312A8871
          69FFF9F2FCFFFBFFFFFFFFFEFF4B46450900005D514F7E72723C303609010815
          1214BEBEBEA9A9A9050505222222BCBCBC6A6A6A000000000000AEAEAEFAFAFA
          494949000000A7A7A7F1F1F1FCFCFC1C1C1C000000B3B3B3FFFFFFFEFEFE3D3D
          3D050505252525B1B1B1AEAEAE8C8C8CFFFFFFFFFFFF4444440000005E5E5ED9
          D9D9828282000000232323FBFBFBF6F6F6FFFFFFFFFFFFFFFFFFFFFFFF444444
          000000808080FFFFFFFFFFFF7B7B7B000000272727B5B5B5A5A5A50606062424
          24B7B7B7686868070707000000B2B2B2F9F9F95454540202023838386D6D6D18
          18180D0D0D0F0F0FD6D6D6FAFAFAFFFFFFFBFBFBFCFCFCFFFFFFC1C1C15B5B5B
          ACACACB8B8B8A3A3A30C0C0C000000B1B1B1979797060606171717FFFFFFB4B4
          B4000000B2B2B2FEFEFEFEFEFEFFFFFFFAFAFA9B9B9B0404041E1E1EFFFFFFA0
          A0A00101012323230000FFFFFFFFFFFFFFFFFFFFFDEA9F806B4E2D1A322E2355
          8F9484E6EE75E6E8006862002921135D5975D4DE71CCDB468292001F2A144445
          83CAC775E6E848B8C40B506B00234100384F35BCCA50D0D51B8B8B002D2A3387
          8581E3E37AD4D5063D46001D26112A2E2D5D6377DDEF72E2F427757B02272339
          2B25957871FFFCF5FCFDF9F9F9F9FCFCFC413F3E090602A19A97FFFDFFFFFBFF
          1B131A020001A4A4A4ADADAD000000636363FFFFFFFFFFFF252525030303FDFD
          FDF9F9F93E3E3E0D0D0D999999FFFFFFFFFFFF1B1B1B0E0E0EC5C5C5F9F9F9DB
          DBDB000000010101EBEBEBFFFFFFFFFFFFFFFFFFFFFFFFD2D2D2000000080808
          F1F1F1FAFAFAFAFAFA262626000000A1A1A1FFFFFFFFFFFFF9F9F9FAFAFAFFFF
          FF404040000000868686FFFFFFFFFFFF6161610000008A8A8AFFFFFFA9A9A902
          0202545454FFFFFFFFFFFF181818000000FFFFFFFDFDFD414141040404A4A4A4
          FFFFFFB6B6B6020202040404DEDEDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFB
          FBFFFFFFFFFFFFFFFFFFFFFFFF5C5C5C010101676767ECECECBABABACECECEFE
          FEFEFFFFFF202020484848DFDFDFDEDEDEE0E0E0E8E8E8363636000000939393
          F4F4F4E4E4E4C8C8C8CACACA0000FFFFFFFFFFFFFFFFFFFFFFF0A08F7A5E3D2D
          3D362D45838B6ED4E05DD3D8006263003E3D0D4D5178D4E57FDAEF508A9D0B2E
          3B0F2A2E48797B66CED359D4E262D1EB37B3D1009AB238DDEE61E3F0157E8700
          2B31318C906AD6DA6DCBD1255561263744141C2328444F7CCFE574D1E636717A
          0A1E1F41221FA17772FFFDF8FFFFFCFDFFFEFBFFFF3A413E050B06929593FDFD
          FDFFFDFF000006050406B7B7B7DDDDDD2323230000006D6D6D9D9D9D11111103
          0303F4F4F4FFFFFF4646460000009F9F9FFFFFFFFEFEFE242424000000B4B4B4
          FFFFFF9E9E9E0000002A2A2AFEFEFEFFFFFFFEFEFEFFFFFFF8F8F89F9F9F0909
          09222222FCFCFCFFFFFFFFFFFF505050060606838383F7F7F7FFFFFFFFFFFFFF
          FFFFF7F7F7404040080808787878F8F8F8FFFFFF5B5B5B040404737373F9F9F9
          EEEEEE1010100B0B0B6C6C6C979797141414040404FCFCFCF8F8F84747470000
          00C6C6C6FAFAFAFFFFFF171717000000DBDBDBFFFFFFFDFDFDFCFCFCFBFBFBFD
          FDFDFFFFFFF4F4F4F7F7F7FFFFFFDDDDDD232323010101707070F9F9F9FFFFFF
          FCFCFCF8F8F8F8F8F87E7E7E0303030303030707070000000000000000000101
          01F6F6F6FFFFFFFFFFFFF3F3F3FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFEE9488
          765330223A30294C87907BE3F064DCE200676B002C2F1C646C65CEE16FDAEF44
          899A001C28283D3F042B2D004F5408828E2FA6BC2CB1CC2AD0E737DBEE56D0E0
          29899600343B297B807DE3E87FDBE003343E051A22282E33435D6485D1E773CA
          DE4279801624234D28249E6E6AFFF5F0FFFBF8FEFFFDF9FEFD363F3C0003007A
          8380A6AEAD3B414601040C5C5E5FFDFDFDFDFDFDE1E1E17878783A3A3A252525
          070707000000FFFFFFFFFFFF3C3C3C020202A0A0A0FCFCFCFFFFFF1D1D1D0505
          05C6C6C6F8F8F8A5A5A5040404292929FFFFFFF9F9F9FFFFFFFDFDFDFFFFFFA2
          A2A2000000232323FEFEFEFCFCFCFDFDFD565656000000878787FFFFFFFAFAFA
          FFFFFFFFFFFFFFFFFF404040000000868686FFFFFFF9F9F95E5E5E0000007F7F
          7FFFFFFFF6F6F6E9E9E97272723D3D3D252525060606000000FFFFFFFFFFFF3E
          3E3E040404BBBBBBFFFFFFF6F6F62A2A2A000000E6E6E6FCFCFCFCFCFCFFFFFF
          FFFFFFFDFDFDFBFBFBFFFFFFFBFBFB9898981C1C1C000000070707C7C7C7FFFF
          FFFDFDFDFEFEFEFFFFFFFFFFFFDBDBDB0000005F5F5FC2C2C2C1C1C154545403
          03034C4C4CFCFCFCFFFFFFFCFCFCFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFF49686795D372B41302D5286927BDCEA6ADFE8005B61003B3F04646A47D0E0
          4DD7E93291A000252D0A2C2B5F8B85348B880A727700354800364E00687C44CB
          DB6CDBE52A828800363A36767797EAEB8ADCDD003C3E18403F22333037595976
          CFDD6DD0DE3778791E342F4828229B6D66FFFBF5FFFEFAFFFDFEFEFEFE383D3B
          000300000200000806011215A0ACB0F9FDFEFDFDFDFFFFFFFAFAFAFFFFFFFFFF
          FFF7F7F7131313000000FFFFFFFFFFFF3D3D3D000000444444FFFFFFFEFEFE19
          1919000000C5C5C5FDFDFDD3D3D3000000000000DBDBDBFFFFFFFFFFFFF5F5F5
          FCFCFCDCDCDC000000030303F0F0F0FCFCFCFFFFFF191919000000A6A6A6FFFF
          FFFAFAFAFFFFFFFFFFFFFFFFFF424242000000828282FFFFFFFFFFFF58585802
          02027F7F7FFFFFFFFFFFFFFFFFFFFCFCFCFFFFFFFAFAFA111111030303FFFFFF
          F8F8F8434343000000C1C1C1FFFFFFFFFFFF272727000000E4E4E4F9F9F9FBFB
          FBFFFFFFFAFAFAFBFBFBFFFFFFE4E4E43F3F3F000000000000232323B4B4B4FE
          FEFEFFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFF4040402F2F2FFFFFFFFBFBFB
          222222000000B3B3B3FFFFFFFEFEFEFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDF3998378623A2E4A373457848F7AD2E06EDBE3006B6E086A6A5AC8
          CC4CE6F147DEEC6BD5E078BBBE3F615B4F71678ED2C787D9D46FBAC263B5C160
          C4D077DAE284CED237706F113632578079A2DED88ECEC810443D1C3F35232D21
          374E4999E7EE7FD7DE38716E1B2C2349291EA5776FFFFEF8FFFAF6FFFEFFFCFA
          FA3E413F030904757E7BA0ABA919282B051115C2C6C7FAFAFAFCFCFC7B7B7B90
          9090C4C4C4979797000000131313FFFFFFF7F7F73D3D3D0000002222222C2C2C
          4747470000000D0D0DE2E2E2F6F6F6FFFFFF4E4E4E0202022727279393939B9B
          9B7B7B7BFDFDFDF9F9F9515151000000474747B9B9B96B6B6B000000292929FF
          FFFFFDFDFDFFFFFFFBFBFBF5F5F5FCFCFC424242000000888888FDFDFDC8C8C8
          4646460000005757579B9B9BEEEEEE6D6D6DA0A0A0B5B5B59494940101010808
          08FEFEFEFFFFFF424242000000C5C5C5F4F4F4FFFFFF1111110E0E0ED6D6D6FF
          FFFFFFFFFFF0F0F0FFFFFFFFFFFFF6F6F63333330000000F0F0F727272EAEAEA
          FFFFFFFFFFFFFAFAFAFFFFFFFEFEFEFFFFFFFBFBFBFDFDFDA0A0A0040404D1D1
          D1B4B4B4020202191919F6F6F6FFFFFFF9F9F9FFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFCF7A382795F35294B38336687908DD5E17BDCE006716F16
          7C775FD6D540DEE440D6E06FD1D98BC1C2394C432D3A2A81A79198D1BC9AE2D6
          95E3DC94DBD880B3AF81938C4443393637277A8674B4D8C7B0D7C73C57472931
          20422E1C6F675A9CC5C791C6C9607F783F3E3051271A9A695FFFF8F0FEFAF5F9
          F7F7FFFEFF3C3A3A020000A2A19DFFFFFEB5B8BC04070B1C1E1FF9F9F9FAFAFA
          7D7D7D171717000000000000202020BFBFBFF7F7F7FEFEFE6565651C1C1CA0A0
          A06060600909090202027D7D7DFCFCFCFFFFFFFBFBFBF1F1F16868680C0C0C08
          0808000000383838FFFFFFFAFAFAEAEAEA7474740909090000000505054C4C4C
          F7F7F7F2F2F2FBFBFBFFFFFFFCFCFCFFFFFFFFFFFF474747020202868686F6F6
          F69E9E9E010101060606090909242424E9E9E97E7E7E1414140000000000001C
          1C1CB5B5B5FFFFFFFBFBFB5555551F1F1FC4C4C4FFFFFFFCFCFC4444441B1B1B
          E3E3E3F5F5F5FFFFFFFFFFFFFFFFFFFFFFFFC1C1C1020202040404C0C0C0FFFF
          FFFFFFFFFFFFFFFFFFFFFAFAFAFFFFFFFCFCFCFFFFFFFDFDFDF7F7F7F7F7F710
          10106A6A6A575757000000777777FDFDFDF4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFDF8A889805E37294A372F6A878C9BDAE284DADA
          0B6A6300463E056D6653DEE15DE2E934888D19403E413D3242332032321A3D4F
          383D62523660553F5E57444C455A4137542D1F532F1D462E1A2F2F1D3A443321
          28193A3B2B4136223027193139383A44443331263E25155D2919A47365FFFDF4
          FCFDF9FDFFFFF8F9FD423D3E080000A39A97FFFEFEB6AFB2050106000001FFFF
          FFFEFEFEFFFFFFF7F7F7F1F1F1EEEEEEF8F8F8F2F2F2FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFAFAFAF5F5F5F5F5F5FFFFFFFFFFFFFFFFFFF9F9F9FFFFFFF7F7F7
          FFFFFFE0E0E0FDFDFDFEFEFEFFFFFFFDFDFDFFFFFFEFEFEFFFFFFFE2E2E2FCFC
          FCFCFCFCF2F2F2FFFFFFFDFDFDFEFEFEFFFFFFF4F4F4FEFEFE3E3E3E0404047E
          7E7EFFFFFFECECEC6666660303037B7B7BFFFFFFFFFFFFFDFDFDFDFDFDF1F1F1
          E5E5E5FAFAFAFFFFFFFFFFFFFBFBFBFFFFFFFDFDFDFFFFFFF5F5F5FFFFFFFFFF
          FFFFFFFFFFFFFFF9F9F9FFFFFFF4F4F4FFFFFFF9F9F9CCCCCC060606111111FF
          FFFFFFFFFFF0F0F0FCFCFCFFFFFFFFFFFFFFFFFFF8F8F8FFFFFFFFFFFFF8F8F8
          FFFFFF606060131313151515000000D5D5D5FBFBFBFDFDFDFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFBF1A49386603E2E4E3B2E6F8785A4E0
          DF8BDED51D6E5F00372A2362586ED0D063C8CA64A9A620392F5231216C34215B
          301D502D1F4C2E294024243A20204D2C294D1C14692C22752F227232275A2A24
          51342F403D357484797292813447383823214A211F4D2114602D19753321AB77
          67FFFBEFF4FEF8F2FBFEF7FDFF4A47490700003B2D2E3628290B000007000152
          5050F4F4F4FFFFFFF1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFBFBFB
          F6F6F6FEFEFEFDFDFDFFFFFFFFFFFFFCFCFCFAFAFAFFFFFFF9F9F9FFFFFFF9F9
          F9FEFEFEF8F8F8FAFAFAFFFFFFF6F6F6FCFCFCFFFFFFF3F3F3FFFFFFFFFFFFF6
          F6F6FFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFEFEFEF9F9F9FFFFFFFFFFFF3C3C3C
          000000787878FFFFFFFFFFFFD2D2D29E9E9EC5C5C5FBFBFBFDFDFDFFFFFFF5F5
          F5FFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFBFBFBFFFFFFAAAAAA535353E8
          E8E8FEFEFEFAFAFAFAFAFAFEFEFEFFFFFFFFFFFFFAFAFAFFFFFFF5F5F51D1D1D
          0505054444447A7A7A545454343434FDFDFDFFFFFFFDFDFDFBFBFBFDFDFDFFFF
          FFFFFFFFFBFBFBC4C4C40101010000002D2D2DFFFFFFFFFFFFFFFFFFFDFDFDFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFF5A494845C3D285943317F
          8E86B6E0D9A0DBCC42766431443353675BA1D7D79AD8D86B958E313425723B26
          8030196A240D601E0C66221B682726632A29733C376024187533216F21117223
          166A211D59232250323190908ABDDACBA6B7A9673F3A6D2C246429166C2E166E
          2A13A2705CFFFDF0F3FFFCEDFCFEF6FEFF7D7C80665E5F6F63635F5351766E6E
          A19C9DF7F5F5FFFFFFFCFCFCF6F6F6FFFFFFFEFEFEF7F7F7FFFFFFFDFDFDFFFF
          FFFBFBFBFFFFFFFFFFFFF5F5F5FFFFFFF7F7F7FFFFFFFFFFFFF7F7F7FFFFFFFB
          FBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFAFAFAFFFFFF
          FCFCFCFFFFFFF8F8F8FBFBFBFAFAFAF9F9F9FBFBFBFFFFFFFFFFFFFFFFFFF1F1
          F18C8C8C656565AFAFAFFFFFFFFFFFFFF9F9F9FFFFFFFBFBFBFFFFFFFFFFFFFB
          FBFBFFFFFFFAFAFAFAFAFAFFFFFFF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          4444442C2C2CE7E7E7FFFFFFFFFFFFF8F8F8F8F8F8FFFFFFFAFAFAFDFDFDFDFD
          FDF1F1F15959592424241919193535355A5A5AFEFEFEFFFFFFFAFAFAFFFFFFFD
          FDFDFBFBFBFFFFFFFDFDFDFFFFFF6C6C6C686868B3B3B3FFFFFFFEFEFEF8F8F8
          FDFDFDFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFF5AC92825F4027
          654B33797368959E948C9E8D5D644F5A4230674F437880807E9091696B65573D
          2D843A228C32148F3F20843A1E7C301E742D1F652A1B602B175D280D5F28096B
          2D0F6B2910742D1F752F2868252270403C8A7A6E9485758A594F76392B662E15
          652F116B2F12A87E67FFFFF4E7FBF6F1FFFFF4FDFFFDFDFFFFFEFFF9F4F1FFFF
          FCEDF4F1F5FEFBF3F5F5FFFFFFFBFBFBFFFFFFFEFEFEFFFFFFFFFFFFFEFEFEFF
          FFFFF3F3F3FFFFFFFAFAFAFAFAFAFFFFFFF9F9F9FFFFFFFDFDFDFFFFFFFFFFFF
          FFFFFFFDFDFDFBFBFBFEFEFEFAFAFAF8F8F8F9F9F9FFFFFFFBFBFBF9F9F9FFFF
          FFF8F8F8FFFFFFFFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFFFDFDFDFDFDFDFE
          FEFEFFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFDFDFDFFFFFFFBFBFBFFFFFFF6F6F6
          F7F7F7FFFFFFF9F9F9FFFFFFFDFDFDFCFCFCFFFFFFFFFFFFFFFFFFFAFAFAFFFF
          FFFFFFFFE0E0E0777777AFAFAFFFFFFFF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFDFDFDFAFAFAFDFDFDFCFCFCFFFFFFF8F8F8FFFFFFFFFFFFFDFDFDFDFDFD
          FFFFFFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFFF6F6F6F9F9F9FFFFFFF7F7F7FFFF
          FFFFFFFFFAFAFAFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFBF2B693
          85724D376F4D365A3D2F4E362A5B453360402D7844336F3B2E573A36533E3C55
          382F703F2F94442D8D3315843514883C1F83351E8138247A3B26652C137D4627
          6E3815804727783A1C76311D7C31238231297129216134266035246E2F21702C
          19773B2370391E602A119E7965FFFFF7F5FFFDF6FFFFF5FBFFFAFAFFFFFEFFFF
          FDFCFDFFFEF3FEFBF6FFFFFBFFFFFCFCFCFFFFFFFAFAFAFFFFFFFAFAFAFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF3F3F3FFFFFFFEFEFEF5F5F5FFFFFFFFFFFFFCFC
          FCFBFBFBFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF9F9F9FFFFFFFF
          FFFFF8F8F8FFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFEFEFEFCFCFCFBFBFBFFFFFF
          FBFBFBFBFBFBFFFFFFF2F2F2FDFDFDFFFFFFF9F9F9FDFDFDFAFAFAFFFFFFFBFB
          FBFFFFFFFDFDFDFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFFFFFFFF
          FFFFF6F6F6FFFFFFFAFAFAFFFFFFF9F9F9FAFAFAFFFFFFFDFDFDFBFBFBFFFFFF
          FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFBFBFBFFFFFFFAFAFAFFFFFFFDFD
          FDFFFFFFFAFAFAFFFFFFFFFFFFFDFDFDFEFEFEFBFBFBFFFFFFFFFFFFF6F6F6FF
          FFFFFBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          F5EFB68F877E51447E4A3D7841347940318348387D3F2D864334844335784138
          7641377840357E3F318B3F2D8E3F2A8D432B8A422A883F29843E27803D267E3E
          267E3E257E3F23824027813F26813D26833C28833B29803B28773A2678392585
          3524833120823A28773927693528A27E74FFFAF4FFFCFBFFFEFFFFFEFFFFFEFF
          FFFEFFFFFEFFFDFFFFFBFFFFFBFFFFFCFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDF8BE9893895B538B554A8E4D3F924C3B9D5341964C3A924C3B914C
          3D8D4C3E8D4C3E8D4C3E8D4A3B8F49388E49368F4A368D4A358D48348B48338B
          46328946318A45318946318C47338A47328A45318845308A453188453087422E
          8A412D96402E913A2A8D42327D40326B3D32A3817BFFF9F7FFFBF9FFFEFFFFFE
          FFFFFDFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFEFEFEFEFEFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFBF4BB9E958A64588E5F51925A49985846A15D4A9B574495
          554394564692574893584992574792564693534194523F96544195534096523F
          93513E94503D92503D94503D92503D97534094523F95513E93513E95513E9250
          3D924E3B944C3A9B4C39964837934E3D834C3D71493DA4897FFFFBF6FFFDFAFF
          FEFFFFFFFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFFFFFEFEFEFEFEFEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFCF4BFA99E9373669A7162A06E5CA56C57AB6F59
          A66A54A36854A068559F69589D69589F69589D6854A06752A06551A46654A365
          53A56553A26452A46452A26452A36351A16351A1614F9E604E9F5F4D9D5F4D9F
          5F4D9C5E4C9C5C4A9C5A48A158449D5543955A47885747795649A89287FFFCF6
          FFFDFAFFFFFEFFFFFFFFFEFFFFFEFFFFFEFFFFFFFFFFFFFFFFFFFFFEFEFEFEFE
          FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFAEEC0AFA2987F6FA07F6CAB7E69AD7B
          64B07A63AC765FAC7762A97763A67762A37661A47560A77561AA7560AD7661AC
          7461AC7463AE7363AB7362AD7262AA7261AC7161AA7261AC7161A97160AA6F5F
          A76F5EA96E5EA66E5DA66B5BA56A57AA6954A667529E6955916655836658AC9A
          8FFFFEF7FFFDFAFFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFFFEFFFFFEFFFFFFFEFF
          FEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFCF0C7B7AAA18A7AA98976B5
          8B74B6846DB88269B68067BB8671B78670B3846FB0836EB1826DB4836DB7856E
          BA8570B6836FB68271B68271B58170B58170B4806FB37F6EB27E6DB27E6DB17D
          6CB07C6BAF7B6AAF7B6AAD7968AB7766AE7663B47862B37761A976629C746290
          7365B4A297FFFEF7FFFEF9FFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFE
          FFFFFEFFFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFF5D5C4B7AF9585
          B4907EC1927CC08C75C28A71C28A71C7907BC48F7AC18E7ABF8D79C08E78C38E
          79C69079C68F7AC18F7BBF8F7DBF8F7DBE8E7CBD8D7BBC8C7ABB8B79BA8A78B2
          8270B1816FB0806EAF7F6DAE7E6CAD7D6BAB7B69AC7965B57864B67965AB7864
          9F776596796BB7A59AFFFFF6FFFDF8FFFFFEFFFFFEFFFFFFFFFFFFFFFFFEFFFF
          FEFFFFFEFFFFFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFEF3D4BE
          B2AC8D7EAE8674BA8773BA816BBB7F69BF806BBB806CBA816CB9816EB9816EB9
          816EBB826DBD806CBB806CB98470B68470B68472B5836FB48270B2806CB17F6D
          B07E6AB17F6DB07E6AAF7D6BAE7C68AD7B69AC7A66A97765AD7562B1725EB374
          60A973629F746399796CB9A59AFFFCF4FFFCF7FFFFFCFFFFFEFFFFFFFFFFFFFF
          FFFEFFFFFEFFFFFCFFFFFCFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          F5EEDFC2B9A07D70A07463AD7562BD7E69A7644FC27F6AB2705DB0705EAE7060
          AE705EAF715FB1725EB5715EB3715EB0735FAE735FAD725FAD725EAC715EAC71
          5DAB705DAB705CAC715EAC715DAB705DA96E5AA76C59A56A56A56A57A86B57AC
          6754AF6B58A368588B5C4E987568B59C92FFFDF7FBF5F0FFFFFCFFFFFEFFFFFF
          FFFFFFFFFFFEFDFFFEFDFFFCFDFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFDF8DEBFB6896259A576689B60509C5A47B06B589A5542A35E4DA15E
          4F9F5E4F9F5E4FA15E4FA35E4DA45E4DA45F4CA6614EA5614EA4604DA4604DA3
          5F4CA35F4CA25E4BA25E4B9E5A479E5A479E5A479D59469C58459B57449C5845
          9E59469B5341985342965B4C8F60526E4B3EBEA49DFFF6F0FFFFFCFFFFFEFFFF
          FEFFFFFFFFFFFFFDFFFEFDFFFEFBFFFCFBFFFCFDFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE
          FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFDF9FEE1DA89625A8454488F54458A4A389C574696503F91
          4C3D8F4B3E8C4B3D8A4B3D8C4B3D8D493C90493B924A39964A38964A38964A38
          9549379549379448369448369448369145339145339145339044328F43318F43
          318F43318E4432873F2E7C3C2A773E2F7C4F427A574DF3DBD5FFF9F6FFFCF9FF
          FFFEFFFFFFFFFEFFFFFFFFFDFFFEFDFFFEFBFFFCFBFFFCFDFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFF6F3FFF5F1AA8882693F337D483B884D3D6D2F1F
          8241327A3B2D783A2F763A2E76392F75382E76382D7B372A7D38298139288338
          288237278237278237278237278136268136268237278237278237278035257E
          33237D32227E33237C34237634227E4333693528532B1F91746BFFF6EFFFFEFA
          FEF6F6FFFEFFFFFFFFFFFEFFFFFEFFFDFFFFFDFFFEFBFFFEFBFFFEFDFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFCFFFFFBF3DDD79D7E755D33276130
          225E291C723B2E622D20612D215E2B215E2B215D2A205F2B1F63281E65291D68
          2B1D6A2B1D6A2B1D6A2B1D6A2B1D692A1C692A1C692A1C6A2B1D6A2B1D6A2B1D
          68291B67281A66271967281A65281A6831225A2919592F22927267EBD6CEFFFF
          F9FFFAF7FFFFFEFFFFFFFFFEFFFFFEFFFFFEFFFFFFFFFFFFFEFDFFFEFDFFFEFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFF8F8F8FAF7F3FFFDF7E5D0C88F
          6F646A4335673B2E55281B562A1D542A1E52292052292051281F53291D56281D
          58281C57271B57271B57271B57271B57271B57271B57271B57271B56261A5727
          1B58281C57271B57271B57271B59291D582B1E5328195B3727876A5CEED8CCFF
          FFF7FFFCF5F4F3EFF5F7F7FDFFFFFDFFFFFFFEFFFFFEFFFFFEFFFFFFFFFFFFFF
          FFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFF6FFFFFAFFFEFFFFFA
          FFFFF8FFF9EEE9CCBEBE9D8E8E6D5E98786B96786D93766D93766D95766D9777
          6C9A776A9A776A93756A91756A91756A91756A91756A91756A91756A92766B90
          746991756A92766B92766B92766B92766B94786D957A6CA18475E6CCBBFFF7E8
          FFFFF5F2EDE4FFFFFAFBFFFEF7FDFCFAFFFFFBFEFFFDFEFFFFFEFFFFFEFFFFFE
          FFFFFEFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
        Stretch = True
      end
      object QRLabel166: TQRLabel
        Left = 818
        Top = 162
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
          357.187500000000000000
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
      object QRLabel3: TQRLabel
        Left = 818
        Top = 508
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
          1120.069444444444000000
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
      object qrlEnderecoCedente1: TQRLabel
        Left = 57
        Top = 49
        Width = 252
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          108.038194444444400000
          555.625000000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'Endereco do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = qrlEnderecoCedente1Print
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 6
      end
      object QRLabel46: TQRLabel
        Left = 57
        Top = 601
        Width = 607
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          1325.121527777778000000
          1338.350694444444000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'Endereco do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = qrlEnderecoCedente1Print
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 6
      end
      object QRLabel88: TQRLabel
        Left = 57
        Top = 588
        Width = 607
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          1296.458333333333000000
          1338.350694444444000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel11: TQRLabel
        Left = 57
        Top = 937
        Width = 607
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          2065.954861111111000000
          1338.350694444444000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel110: TQRLabel
        Left = 57
        Top = 950
        Width = 607
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          2094.618055555556000000
          1338.350694444444000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'Endereco do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = qrlEnderecoCedente1Print
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 6
      end
      object QRLabel135: TQRLabel
        Left = 57
        Top = 241
        Width = 607
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          531.371527777777800000
          1338.350694444444000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
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
        WordWrap = True
        FontSize = 6
      end
      object QRLabel138: TQRLabel
        Left = 57
        Top = 254
        Width = 607
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          560.034722222222200000
          1338.350694444444000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'Endereco do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = qrlEnderecoCedente1Print
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 6
      end
    end
  end
end
