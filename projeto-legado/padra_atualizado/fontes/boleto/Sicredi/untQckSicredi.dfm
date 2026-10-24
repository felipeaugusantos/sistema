object frmQckSicredi: TfrmQckSicredi
  Left = 106
  Top = 3
  Width = 980
  Height = 788
  AutoScroll = True
  Caption = 'Sicredi'
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
    Top = 8
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
      Height = 1194
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        2632.604166666667000000
        1898.385416666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object LinhaHorizontal6: TQRShape
        Left = 4
        Top = 278
        Width = 853
        Height = 2
        Size.Values = (
          4.409722222222220000
          8.819444444444440000
          612.951388888889000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal5: TQRShape
        Left = 4
        Top = 158
        Width = 853
        Height = 1
        Size.Values = (
          2.645833333333330000
          7.937500000000000000
          349.250000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal4: TQRShape
        Left = 4
        Top = 128
        Width = 853
        Height = 1
        Size.Values = (
          2.645833333333330000
          7.937500000000000000
          283.104166666667000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal3: TQRShape
        Left = 4
        Top = 97
        Width = 853
        Height = 4
        Size.Values = (
          7.937500000000000000
          7.937500000000000000
          214.312500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal1: TQRShape
        Left = 4
        Top = 29
        Width = 853
        Height = 13
        Size.Values = (
          29.104166666666700000
          7.937500000000000000
          63.500000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal2: TQRShape
        Left = 4
        Top = 68
        Width = 853
        Height = 2
        Size.Values = (
          5.291666666666670000
          7.937500000000000000
          150.812500000000000000
          1881.187500000000000000)
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
          420.687500000000000000
          23.812500000000000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LinhaHorizontal7: TQRShape
        Left = 4
        Top = 337
        Width = 853
        Height = 5
        Size.Values = (
          11.024305555555600000
          8.819444444444440000
          743.038194444444000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNrBanco: TQRLabel
        Left = 200
        Top = 11
        Width = 82
        Height = 24
        Size.Values = (
          52.916666666666700000
          441.854166666667000000
          23.812500000000000000
          179.916666666667000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '748-X'
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
        Top = 39
        Width = 48
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          85.989583333333330000
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
        Left = 280
        Top = 11
        Width = 10
        Height = 24
        Size.Values = (
          52.916666666666700000
          616.479166666667000000
          23.812500000000000000
          21.166666666666700000)
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
        Top = 71
        Width = 49
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          156.545138888888900000
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
        Top = 81
        Width = 603
        Height = 17
        Size.Values = (
          37.482638888888890000
          125.677083333333300000
          178.593750000000000000
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
        Top = 71
        Width = 89
        Height = 9
        Size.Values = (
          19.843750000000000000
          1481.666666666667000000
          156.545138888888900000
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
        Top = 101
        Width = 78
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          222.690972222222200000
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
        Top = 101
        Width = 70
        Height = 13
        Size.Values = (
          28.663194444444440000
          319.704861111111100000
          222.690972222222200000
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
        Top = 101
        Width = 54
        Height = 13
        Size.Values = (
          28.663194444444440000
          738.628472222222200000
          222.690972222222200000
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
        Top = 101
        Width = 26
        Height = 13
        Size.Values = (
          28.663194444444440000
          915.017361111111100000
          222.690972222222200000
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
        Top = 101
        Width = 96
        Height = 13
        Size.Values = (
          28.663194444444440000
          1047.309027777778000000
          222.690972222222200000
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
        Top = 101
        Width = 84
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          222.690972222222200000
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
        Top = 130
        Width = 56
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          286.631944444444400000
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
        Top = 130
        Width = 20
        Height = 13
        Size.Values = (
          28.663194444444440000
          372.621527777777800000
          286.631944444444400000
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
        Top = 130
        Width = 44
        Height = 11
        Size.Values = (
          24.253472222222220000
          500.503472222222200000
          286.631944444444400000
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
        Top = 140
        Width = 73
        Height = 17
        Size.Values = (
          37.482638888888900000
          504.913194444444000000
          308.680555555556000000
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
      object LabelQuantidade: TQRLabel
        Left = 317
        Top = 130
        Width = 46
        Height = 13
        Size.Values = (
          28.663194444444440000
          698.940972222222200000
          286.631944444444400000
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
        Top = 130
        Width = 41
        Height = 13
        Size.Values = (
          28.663194444444440000
          1298.663194444444000000
          286.631944444444400000
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
        Top = 132
        Width = 10
        Height = 19
        Size.Values = (
          41.892361111111110000
          1270.000000000000000000
          291.041666666666700000
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
        Top = 130
        Width = 94
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          286.631944444444400000
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
        Top = 161
        Width = 374
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          354.982638888888900000
          824.618055555555600000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object LabelDesconto: TQRLabel
        Left = 672
        Top = 161
        Width = 95
        Height = 9
        Size.Values = (
          19.843750000000000000
          1481.666666666667000000
          354.982638888888900000
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
        Top = 210
        Width = 55
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          463.020833333333300000
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
        Left = 5
        Top = 281
        Width = 38
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          619.565972222222200000
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
        Left = 2
        Top = 326
        Width = 74
        Height = 12
        Size.Values = (
          26.458333333333330000
          4.409722222222222000
          718.784722222222200000
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
        Left = 682
        Top = 324
        Width = 74
        Height = 13
        Size.Values = (
          28.663194444444440000
          1503.715277777778000000
          714.375000000000000000
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
        Left = 706
        Top = 341
        Width = 53
        Height = 12
        Size.Values = (
          26.458333333333330000
          1556.631944444444000000
          751.857638888888900000
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
        Left = 667
        Top = 208
        Width = 188
        Height = 1
        Size.Values = (
          2.645833333333330000
          1471.083333333330000000
          457.729166666667000000
          415.395833333333000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 667
        Top = 227
        Width = 188
        Height = 6
        Size.Values = (
          13.229166666666700000
          1471.083333333330000000
          500.062500000000000000
          415.395833333333000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNomeTitular: TQRLabel
        Left = 52
        Top = 282
        Width = 372
        Height = 14
        Size.Values = (
          30.868055555555600000
          114.652777777778000000
          621.770833333333000000
          820.208333333333000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object LabelEndereco: TQRLabel
        Left = 52
        Top = 298
        Width = 372
        Height = 14
        Size.Values = (
          30.868055555555600000
          114.652777777778000000
          657.048611111111000000
          820.208333333333000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object LabelCidade: TQRLabel
        Left = 52
        Top = 313
        Width = 372
        Height = 14
        Size.Values = (
          30.868055555555600000
          114.652777777778000000
          690.121527777778000000
          820.208333333333000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRShape1: TQRShape
        Left = 666
        Top = 34
        Width = 4
        Height = 248
        Size.Values = (
          546.805555555556000000
          1468.437500000000000000
          74.965277777777800000
          8.819444444444440000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelInformacao1: TQRLabel
        Left = 36
        Top = 49
        Width = 389
        Height = 19
        Size.Values = (
          41.892361111111100000
          79.375000000000000000
          108.038194444444000000
          857.690972222222000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'PAG'#193'VEL PREFERENCIALMENTE NAS COOP. DE CR'#201'DITO DO SICREDI'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRShape4: TQRShape
        Left = 143
        Top = 100
        Width = 1
        Height = 28
        Size.Values = (
          60.854166666666700000
          314.854166666667000000
          219.604166666667000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 330
        Top = 98
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          727.604166666667000000
          216.958333333333000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape6: TQRShape
        Left = 413
        Top = 98
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          910.166666666667000000
          216.958333333333000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape8: TQRShape
        Left = 164
        Top = 128
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          362.479166666667000000
          283.104166666667000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 221
        Top = 128
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          486.833333333333000000
          283.104166666667000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape12: TQRShape
        Left = 578
        Top = 128
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          1275.291666666670000000
          283.104166666667000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape16: TQRShape
        Left = 667
        Top = 250
        Width = 187
        Height = 6
        Size.Values = (
          13.229166666666700000
          1471.083333333330000000
          550.333333333333000000
          412.750000000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape17: TQRShape
        Left = 312
        Top = 128
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          687.916666666667000000
          283.104166666667000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel40: TQRLabel
        Left = 7
        Top = 140
        Width = 145
        Height = 17
        Size.Values = (
          37.482638888888900000
          15.434027777777800000
          308.680555555556000000
          319.704861111111000000)
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
        Top = 98
        Width = 1
        Height = 29
        Size.Values = (
          63.500000000000000000
          1031.875000000000000000
          216.958333333333000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel42: TQRLabel
        Left = 440
        Top = 109
        Width = 10
        Height = 17
        Size.Values = (
          37.482638888888890000
          970.138888888888900000
          240.329861111111100000
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
      object QRShape9: TQRShape
        Left = 3
        Top = 745
        Width = 853
        Height = 6
        Size.Values = (
          13.229166666666700000
          6.614583333333330000
          1642.621527777780000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape13: TQRShape
        Left = 667
        Top = 185
        Width = 188
        Height = 1
        Size.Values = (
          2.645833333333330000
          1471.083333333330000000
          407.458333333333000000
          415.395833333333000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel6: TQRLabel
        Left = 170
        Top = 140
        Width = 32
        Height = 17
        Size.Values = (
          37.482638888888890000
          374.826388888888900000
          308.680555555555600000
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
        Top = 50
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1512.534722222220000000
          110.243055555556000000
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
      object QRLabel51: TQRLabel
        Left = 13
        Top = 109
        Width = 120
        Height = 17
        Size.Values = (
          37.482638888888900000
          28.663194444444400000
          240.329861111111000000
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
        Left = 157
        Top = 109
        Width = 163
        Height = 17
        Size.Values = (
          37.482638888888900000
          346.163194444444000000
          240.329861111111000000
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
      object QRLabel54: TQRLabel
        Left = 337
        Top = 109
        Width = 65
        Height = 17
        Size.Values = (
          37.482638888888900000
          743.038194444444000000
          240.329861111111000000
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
      object QRLabel57: TQRLabel
        Left = 479
        Top = 109
        Width = 169
        Height = 17
        Size.Values = (
          37.482638888888900000
          1056.128472222220000000
          240.329861111111000000
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
      object QRLabel58: TQRLabel
        Left = 686
        Top = 81
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1512.534722222220000000
          178.593750000000000000
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
        OnPrint = QRLabel58Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel59: TQRLabel
        Left = 685
        Top = 110
        Width = 161
        Height = 17
        Size.Values = (
          37.482638888888900000
          1510.329861111110000000
          242.534722222222000000
          354.982638888889000000)
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
        Left = 685
        Top = 140
        Width = 161
        Height = 17
        Size.Values = (
          37.482638888888900000
          1510.329861111110000000
          308.680555555556000000
          354.982638888889000000)
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
        Top = 204
        Width = 622
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          449.791666666667000000
          1371.423611111110000000)
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
        Top = 219
        Width = 622
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          482.864583333333000000
          1371.423611111110000000)
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
        Top = 234
        Width = 622
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          515.937500000000000000
          1371.423611111110000000)
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
        Top = 249
        Width = 622
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          549.010416666667000000
          1371.423611111110000000)
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
        Top = 264
        Width = 622
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          582.083333333333000000
          1371.423611111110000000)
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
        Left = 762
        Top = 324
        Width = 68
        Height = 13
        Size.Values = (
          28.663194444444440000
          1680.104166666667000000
          714.375000000000000000
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
        Top = 1112
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555560000
          70.555555555555560000
          2451.805555555556000000
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
        Top = 1044
        Width = 854
        Height = 1
        Size.Values = (
          2.204861111111110000
          6.614583333333330000
          2301.875000000000000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape11: TQRShape
        Left = 3
        Top = 913
        Width = 854
        Height = 1
        Size.Values = (
          2.204861111111110000
          6.614583333333330000
          2013.038194444440000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape14: TQRShape
        Left = 3
        Top = 883
        Width = 854
        Height = 1
        Size.Values = (
          2.204861111111110000
          6.614583333333330000
          1946.892361111110000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape15: TQRShape
        Left = 3
        Top = 851
        Width = 854
        Height = 3
        Size.Values = (
          6.614583333333330000
          6.614583333333330000
          1876.336805555560000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape18: TQRShape
        Left = 3
        Top = 781
        Width = 853
        Height = 14
        Size.Values = (
          29.765625000000000000
          6.614583333333330000
          1723.098958333330000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape19: TQRShape
        Left = 3
        Top = 823
        Width = 854
        Height = 3
        Size.Values = (
          6.614583333333330000
          6.614583333333330000
          1814.600694444440000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape20: TQRShape
        Left = 191
        Top = 763
        Width = 12
        Height = 24
        Size.Values = (
          52.916666666666700000
          420.026041666667000000
          1683.411458333330000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape21: TQRShape
        Left = 3
        Top = 1105
        Width = 854
        Height = 4
        Size.Values = (
          8.819444444444440000
          6.614583333333330000
          2436.371527777780000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel7: TQRLabel
        Left = 201
        Top = 763
        Width = 81
        Height = 24
        Size.Values = (
          52.916666666666700000
          443.177083333333000000
          1683.411458333330000000
          178.593750000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '748-X'
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
        Top = 791
        Width = 48
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1744.045138888889000000
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
        Top = 763
        Width = 9
        Height = 24
        Size.Values = (
          52.916666666666700000
          615.156250000000000000
          1683.411458333330000000
          19.843750000000000000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel9: TQRLabel
        Left = 5
        Top = 790
        Width = 82
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1741.840277777778000000
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
      object QRLabel10: TQRLabel
        Left = 2
        Top = 826
        Width = 49
        Height = 13
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          1821.215277777778000000
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
      object QRLabel11: TQRLabel
        Left = 57
        Top = 833
        Width = 603
        Height = 17
        Size.Values = (
          37.482638888888890000
          125.677083333333300000
          1836.649305555556000000
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
        Top = 826
        Width = 89
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1821.215277777778000000
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
        Top = 854
        Width = 78
        Height = 13
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          1882.951388888889000000
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
        Top = 854
        Width = 70
        Height = 13
        Size.Values = (
          28.663194444444440000
          319.704861111111100000
          1882.951388888889000000
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
        Top = 854
        Width = 54
        Height = 13
        Size.Values = (
          28.663194444444440000
          736.423611111111100000
          1882.951388888889000000
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
        Top = 854
        Width = 26
        Height = 13
        Size.Values = (
          28.663194444444440000
          921.631944444444400000
          1882.951388888889000000
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
        Top = 854
        Width = 96
        Height = 13
        Size.Values = (
          28.663194444444440000
          1047.309027777778000000
          1882.951388888889000000
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
        Top = 854
        Width = 84
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1882.951388888889000000
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
        Top = 884
        Width = 56
        Height = 13
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          1949.097222222222000000
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
        Top = 884
        Width = 20
        Height = 13
        Size.Values = (
          28.663194444444440000
          372.621527777777800000
          1949.097222222222000000
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
        Top = 884
        Width = 44
        Height = 10
        Size.Values = (
          22.048611111111110000
          500.503472222222200000
          1949.097222222222000000
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
        Top = 894
        Width = 73
        Height = 17
        Size.Values = (
          37.482638888888900000
          507.118055555556000000
          1971.145833333330000000
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
        Top = 884
        Width = 46
        Height = 13
        Size.Values = (
          28.663194444444440000
          698.940972222222200000
          1949.097222222222000000
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
        Top = 885
        Width = 41
        Height = 13
        Size.Values = (
          28.663194444444440000
          1305.277777777778000000
          1951.302083333333000000
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
        Top = 887
        Width = 10
        Height = 19
        Size.Values = (
          41.892361111111110000
          1270.000000000000000000
          1955.711805555556000000
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
        Top = 885
        Width = 94
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1951.302083333333000000
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
        Top = 914
        Width = 374
        Height = 13
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          2015.243055555556000000
          824.618055555555600000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel28: TQRLabel
        Left = 672
        Top = 914
        Width = 95
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          2015.243055555556000000
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
        Left = 671
        Top = 965
        Width = 55
        Height = 13
        Size.Values = (
          28.663194444444440000
          1479.461805555556000000
          2127.690972222222000000
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
        Top = 1012
        Width = 71
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          2231.319444444444000000
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
        Left = 2
        Top = 1046
        Width = 38
        Height = 13
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          2306.284722222222000000
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
        Left = 5
        Top = 1095
        Width = 74
        Height = 12
        Size.Values = (
          26.458333333333330000
          11.024305555555560000
          2414.322916666667000000
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
        Top = 1091
        Width = 74
        Height = 13
        Size.Values = (
          28.663194444444440000
          1486.076388888889000000
          2405.503472222222000000
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
        Left = 673
        Top = 1110
        Width = 163
        Height = 12
        Size.Values = (
          26.458333333333330000
          1483.871527777778000000
          2447.395833333333000000
          359.392361111111100000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Autentica'#231#227'o/FICHA DE COMPENSA'#199#195'O'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Left = 667
        Top = 963
        Width = 189
        Height = 1
        Size.Values = (
          2.204861111111110000
          1470.642361111110000000
          2123.281250000000000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape24: TQRShape
        Left = 668
        Top = 985
        Width = 189
        Height = 6
        Size.Values = (
          13.229166666666700000
          1472.847222222220000000
          2171.788194444440000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel35: TQRLabel
        Left = 51
        Top = 1047
        Width = 372
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          2308.489583333330000000
          820.208333333333000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLabel36: TQRLabel
        Left = 51
        Top = 1063
        Width = 372
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          2343.767361111110000000
          820.208333333333000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLabel37: TQRLabel
        Left = 51
        Top = 1080
        Width = 372
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          2381.250000000000000000
          820.208333333333000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRShape26: TQRShape
        Left = 666
        Top = 788
        Width = 3
        Height = 257
        Size.Values = (
          566.649305555556000000
          1468.437500000000000000
          1737.430555555560000000
          6.614583333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape27: TQRShape
        Left = 143
        Top = 854
        Width = 1
        Height = 27
        Size.Values = (
          59.531250000000000000
          315.295138888889000000
          1882.951388888890000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape29: TQRShape
        Left = 330
        Top = 853
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          727.604166666667000000
          1880.746527777780000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape30: TQRShape
        Left = 412
        Top = 853
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          908.402777777778000000
          1880.746527777780000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape31: TQRShape
        Left = 165
        Top = 883
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          363.802083333333000000
          1946.892361111110000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape32: TQRShape
        Left = 220
        Top = 883
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          485.069444444444000000
          1946.892361111110000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape33: TQRShape
        Left = 579
        Top = 883
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          1276.614583333330000000
          1946.892361111110000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape34: TQRShape
        Left = 668
        Top = 1009
        Width = 188
        Height = 6
        Size.Values = (
          13.229166666666700000
          1472.847222222220000000
          2224.704861111110000000
          414.513888888889000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape35: TQRShape
        Left = 312
        Top = 883
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          687.916666666667000000
          1946.892361111110000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel44: TQRLabel
        Left = 10
        Top = 892
        Width = 143
        Height = 20
        Size.Values = (
          44.097222222222200000
          22.048611111111100000
          1966.736111111110000000
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
        Top = 853
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          1031.875000000000000000
          1880.746527777780000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel45: TQRLabel
        Left = 446
        Top = 864
        Width = 10
        Height = 17
        Size.Values = (
          37.482638888888890000
          983.368055555555600000
          1905.000000000000000000
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
        Top = 939
        Width = 189
        Height = 1
        Size.Values = (
          2.204861111111110000
          1472.847222222220000000
          2070.364583333330000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel48: TQRLabel
        Left = 170
        Top = 893
        Width = 32
        Height = 19
        Size.Values = (
          41.892361111111110000
          374.826388888888900000
          1968.940972222222000000
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
        Left = 687
        Top = 804
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          1772.708333333330000000
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
        OnPrint = QRLabel50Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel52: TQRLabel
        Left = 14
        Top = 864
        Width = 120
        Height = 17
        Size.Values = (
          37.482638888888900000
          30.868055555555600000
          1905.000000000000000000
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
        Left = 158
        Top = 864
        Width = 164
        Height = 17
        Size.Values = (
          37.482638888888900000
          348.368055555556000000
          1905.000000000000000000
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
      object QRLabel55: TQRLabel
        Left = 338
        Top = 864
        Width = 65
        Height = 17
        Size.Values = (
          37.482638888888900000
          745.243055555556000000
          1905.000000000000000000
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
        Left = 478
        Top = 865
        Width = 169
        Height = 17
        Size.Values = (
          37.482638888888900000
          1053.923611111110000000
          1907.204861111110000000
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
        Left = 687
        Top = 834
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          1838.854166666670000000
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
        OnPrint = QRLabel70Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel71: TQRLabel
        Left = 687
        Top = 863
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          1902.795138888890000000
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
        OnPrint = QRLabel71Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel72: TQRLabel
        Left = 687
        Top = 895
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          1973.350694444440000000
          350.572916666667000000)
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
        Left = 755
        Top = 1090
        Width = 68
        Height = 13
        Size.Values = (
          28.663194444444440000
          1664.670138888889000000
          2403.298611111111000000
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
      object QRLabel80: TQRLabel
        Left = 822
        Top = 739
        Width = 19
        Height = 19
        Size.Values = (
          41.892361111111110000
          1812.395833333333000000
          1629.392361111111000000
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
        Top = 1132
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555560000
          70.555555555555560000
          2495.902777777778000000
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
        Left = 24
        Top = 176
        Width = 622
        Height = 13
        Size.Values = (
          28.663194444444400000
          52.916666666666700000
          388.055555555556000000
          1371.423611111110000000)
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
        Top = 190
        Width = 622
        Height = 13
        Size.Values = (
          28.663194444444400000
          52.916666666666700000
          418.923611111111000000
          1371.423611111110000000)
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
        Left = 454
        Top = 286
        Width = 211
        Height = 19
        Size.Values = (
          41.892361111111100000
          1001.006944444440000000
          630.590277777778000000
          465.225694444444000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLabel39: TQRLabel
        Left = 453
        Top = 1052
        Width = 212
        Height = 15
        Size.Values = (
          33.072916666666700000
          998.802083333333000000
          2319.513888888890000000
          467.430555555556000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLabel74: TQRLabel
        Left = 24
        Top = 964
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          2125.486111111110000000
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
        Top = 979
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          2158.559027777780000000
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
        Top = 996
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          2196.041666666670000000
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
        Top = 1010
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
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
        OnPrint = QRLabel64Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel85: TQRLabel
        Left = 24
        Top = 1027
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          2264.392361111110000000
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
        Left = 24
        Top = 931
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          2052.725694444440000000
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
        OnPrint = QRLabel83Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel87: TQRLabel
        Left = 24
        Top = 949
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          2092.413194444440000000
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
      object QRLabel41: TQRLabel
        Left = 33
        Top = 802
        Width = 389
        Height = 15
        Size.Values = (
          33.072916666666700000
          72.760416666666700000
          1768.298611111110000000
          857.690972222222000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'PAG'#193'VEL PREFERENCIALMENTE NAS COOP. DE CR'#201'DITO DO SICREDI'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLabel2: TQRLabel
        Left = 686
        Top = 11
        Width = 160
        Height = 20
        Size.Values = (
          44.979166666666700000
          1513.416666666670000000
          23.812500000000000000
          351.895833333333000000)
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
      object qrlLinDig: TQRLabel
        Left = 295
        Top = 764
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555600000
          650.434027777778000000
          1684.513888888890000000
          1221.493055555560000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRShape28: TQRShape
        Left = 3
        Top = 649
        Width = 854
        Height = 1
        Size.Values = (
          2.204861111111110000
          6.614583333333330000
          1430.954861111110000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape38: TQRShape
        Left = 3
        Top = 523
        Width = 854
        Height = 1
        Size.Values = (
          2.204861111111110000
          6.614583333333330000
          1153.142361111110000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape39: TQRShape
        Left = 3
        Top = 493
        Width = 854
        Height = 1
        Size.Values = (
          2.204861111111110000
          6.614583333333330000
          1086.996527777780000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape40: TQRShape
        Left = 3
        Top = 462
        Width = 854
        Height = 3
        Size.Values = (
          6.614583333333330000
          6.614583333333330000
          1018.645833333330000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape41: TQRShape
        Left = 3
        Top = 392
        Width = 854
        Height = 14
        Size.Values = (
          30.868055555555600000
          6.614583333333330000
          864.305555555556000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape42: TQRShape
        Left = 3
        Top = 433
        Width = 854
        Height = 3
        Size.Values = (
          6.614583333333330000
          6.614583333333330000
          954.704861111111000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape43: TQRShape
        Left = 191
        Top = 374
        Width = 12
        Height = 24
        Size.Values = (
          52.916666666666700000
          421.128472222222000000
          824.618055555556000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape44: TQRShape
        Left = 3
        Top = 708
        Width = 854
        Height = 4
        Size.Values = (
          8.819444444444440000
          6.614583333333330000
          1561.041666666670000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel4: TQRLabel
        Left = 201
        Top = 374
        Width = 81
        Height = 24
        Size.Values = (
          52.916666666666700000
          443.177083333333000000
          824.618055555556000000
          178.593750000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '748-X'
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
      object QRLabel5: TQRLabel
        Left = 672
        Top = 402
        Width = 48
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          886.354166666666700000
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
      object QRShape45: TQRShape
        Left = 279
        Top = 374
        Width = 9
        Height = 24
        Size.Values = (
          52.916666666666700000
          615.156250000000000000
          824.618055555556000000
          19.843750000000000000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel38: TQRLabel
        Left = 5
        Top = 401
        Width = 82
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          884.149305555555600000
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
      object QRLabel43: TQRLabel
        Left = 5
        Top = 438
        Width = 49
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          965.729166666666700000
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
      object QRLabel46: TQRLabel
        Left = 57
        Top = 439
        Width = 603
        Height = 22
        Size.Values = (
          48.506944444444440000
          125.677083333333300000
          967.934027777777800000
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
      object QRLabel47: TQRLabel
        Left = 672
        Top = 436
        Width = 89
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          961.319444444444400000
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
      object QRLabel67: TQRLabel
        Left = 5
        Top = 464
        Width = 78
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1023.055555555556000000
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
      object QRLabel79: TQRLabel
        Left = 145
        Top = 464
        Width = 70
        Height = 13
        Size.Values = (
          28.663194444444440000
          319.704861111111100000
          1023.055555555556000000
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
      object QRLabel91: TQRLabel
        Left = 335
        Top = 464
        Width = 54
        Height = 13
        Size.Values = (
          28.663194444444440000
          738.628472222222200000
          1023.055555555556000000
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
      object QRLabel92: TQRLabel
        Left = 415
        Top = 464
        Width = 26
        Height = 13
        Size.Values = (
          28.663194444444440000
          915.017361111111100000
          1023.055555555556000000
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
      object QRLabel93: TQRLabel
        Left = 475
        Top = 464
        Width = 96
        Height = 13
        Size.Values = (
          28.663194444444440000
          1047.309027777778000000
          1023.055555555556000000
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
      object QRLabel94: TQRLabel
        Left = 672
        Top = 464
        Width = 84
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1023.055555555556000000
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
      object QRLabel95: TQRLabel
        Left = 5
        Top = 495
        Width = 56
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1091.406250000000000000
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
      object QRLabel96: TQRLabel
        Left = 169
        Top = 495
        Width = 20
        Height = 13
        Size.Values = (
          28.663194444444440000
          372.621527777777800000
          1091.406250000000000000
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
      object QRLabel97: TQRLabel
        Left = 227
        Top = 495
        Width = 44
        Height = 11
        Size.Values = (
          24.253472222222220000
          500.503472222222200000
          1091.406250000000000000
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
      object QRLabel98: TQRLabel
        Left = 230
        Top = 504
        Width = 73
        Height = 17
        Size.Values = (
          37.482638888888900000
          507.118055555556000000
          1111.250000000000000000
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
      object QRLabel99: TQRLabel
        Left = 317
        Top = 495
        Width = 46
        Height = 13
        Size.Values = (
          28.663194444444440000
          698.940972222222200000
          1091.406250000000000000
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
      object QRLabel100: TQRLabel
        Left = 589
        Top = 495
        Width = 41
        Height = 13
        Size.Values = (
          28.663194444444440000
          1298.663194444444000000
          1091.406250000000000000
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
      object QRLabel101: TQRLabel
        Left = 576
        Top = 496
        Width = 10
        Height = 19
        Size.Values = (
          41.892361111111110000
          1270.000000000000000000
          1093.611111111111000000
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
      object QRLabel102: TQRLabel
        Left = 672
        Top = 495
        Width = 94
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1091.406250000000000000
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
      object QRLabel103: TQRLabel
        Left = 5
        Top = 525
        Width = 374
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1157.552083333333000000
          824.618055555555600000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel104: TQRLabel
        Left = 672
        Top = 525
        Width = 95
        Height = 9
        Size.Values = (
          19.843750000000000000
          1481.666666666667000000
          1157.552083333333000000
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
      object QRLabel105: TQRLabel
        Left = 672
        Top = 574
        Width = 55
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1265.590277777778000000
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
      object QRLabel106: TQRLabel
        Left = 672
        Top = 619
        Width = 71
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1364.809027777778000000
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
      object QRLabel107: TQRLabel
        Left = 5
        Top = 651
        Width = 38
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1435.364583333333000000
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
      object QRLabel108: TQRLabel
        Left = 2
        Top = 698
        Width = 74
        Height = 12
        Size.Values = (
          26.458333333333330000
          4.409722222222222000
          1538.993055555556000000
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
      object QRLabel109: TQRLabel
        Left = 682
        Top = 694
        Width = 74
        Height = 13
        Size.Values = (
          28.663194444444440000
          1503.715277777778000000
          1530.173611111111000000
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
      object QRLabel110: TQRLabel
        Left = 706
        Top = 712
        Width = 53
        Height = 12
        Size.Values = (
          26.458333333333330000
          1556.631944444444000000
          1569.861111111111000000
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
      object QRShape46: TQRShape
        Left = 668
        Top = 571
        Width = 189
        Height = 1
        Size.Values = (
          2.204861111111110000
          1472.847222222220000000
          1258.975694444440000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape47: TQRShape
        Left = 668
        Top = 592
        Width = 189
        Height = 6
        Size.Values = (
          13.229166666666700000
          1472.847222222220000000
          1305.277777777780000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel111: TQRLabel
        Left = 51
        Top = 652
        Width = 372
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          1437.569444444440000000
          820.208333333333000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLabel112: TQRLabel
        Left = 51
        Top = 667
        Width = 372
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          1470.642361111110000000
          820.208333333333000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLabel113: TQRLabel
        Left = 51
        Top = 684
        Width = 372
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          1508.125000000000000000
          820.208333333333000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRShape48: TQRShape
        Left = 666
        Top = 397
        Width = 3
        Height = 254
        Size.Values = (
          560.034722222222000000
          1468.437500000000000000
          875.329861111111000000
          6.614583333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel114: TQRLabel
        Left = 36
        Top = 412
        Width = 389
        Height = 15
        Size.Values = (
          33.072916666666700000
          79.375000000000000000
          908.402777777778000000
          857.690972222222000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'PAG'#193'VEL PREFERENCIALMENTE NAS COOP. DE CR'#201'DITO DO SICREDI'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRShape49: TQRShape
        Left = 143
        Top = 463
        Width = 1
        Height = 27
        Size.Values = (
          59.531250000000000000
          315.295138888889000000
          1020.850694444440000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape50: TQRShape
        Left = 330
        Top = 463
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          727.604166666667000000
          1020.850694444440000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape51: TQRShape
        Left = 412
        Top = 463
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          908.402777777778000000
          1020.850694444440000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape52: TQRShape
        Left = 165
        Top = 493
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          363.802083333333000000
          1086.996527777780000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape53: TQRShape
        Left = 220
        Top = 493
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          485.069444444444000000
          1086.996527777780000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape54: TQRShape
        Left = 579
        Top = 493
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          1276.614583333330000000
          1086.996527777780000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape55: TQRShape
        Left = 668
        Top = 615
        Width = 188
        Height = 6
        Size.Values = (
          13.229166666666700000
          1472.847222222220000000
          1355.989583333330000000
          414.513888888889000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape56: TQRShape
        Left = 312
        Top = 493
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          687.916666666667000000
          1086.996527777780000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel115: TQRLabel
        Left = 8
        Top = 504
        Width = 146
        Height = 17
        Size.Values = (
          37.482638888888900000
          17.638888888888900000
          1111.250000000000000000
          321.909722222222000000)
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
      object QRShape57: TQRShape
        Left = 468
        Top = 463
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          1031.875000000000000000
          1020.850694444440000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel116: TQRLabel
        Left = 440
        Top = 474
        Width = 10
        Height = 17
        Size.Values = (
          37.482638888888890000
          970.138888888888900000
          1045.104166666667000000
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
      object QRShape58: TQRShape
        Left = 668
        Top = 549
        Width = 189
        Height = 1
        Size.Values = (
          2.204861111111110000
          1472.847222222220000000
          1210.468750000000000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel117: TQRLabel
        Left = 170
        Top = 504
        Width = 32
        Height = 17
        Size.Values = (
          37.482638888888890000
          374.826388888888900000
          1111.250000000000000000
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
      object QRLabel118: TQRLabel
        Left = 687
        Top = 414
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          912.812500000000000000
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
        OnPrint = QRLabel50Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel119: TQRLabel
        Left = 14
        Top = 474
        Width = 120
        Height = 17
        Size.Values = (
          37.482638888888900000
          30.868055555555600000
          1045.104166666670000000
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
      object QRLabel120: TQRLabel
        Left = 158
        Top = 474
        Width = 164
        Height = 17
        Size.Values = (
          37.482638888888900000
          348.368055555556000000
          1045.104166666670000000
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
      object QRLabel121: TQRLabel
        Left = 338
        Top = 474
        Width = 65
        Height = 17
        Size.Values = (
          37.482638888888900000
          745.243055555556000000
          1045.104166666670000000
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
      object QRLabel122: TQRLabel
        Left = 478
        Top = 474
        Width = 169
        Height = 17
        Size.Values = (
          37.482638888888900000
          1053.923611111110000000
          1045.104166666670000000
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
      object QRLabel123: TQRLabel
        Left = 687
        Top = 444
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          978.958333333333000000
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
      object QRLabel124: TQRLabel
        Left = 686
        Top = 474
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1512.534722222220000000
          1045.104166666670000000
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
        OnPrint = QRLabel59Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel125: TQRLabel
        Left = 686
        Top = 504
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1512.534722222220000000
          1111.250000000000000000
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
      object QRLabel126: TQRLabel
        Left = 24
        Top = 570
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1256.770833333330000000
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
      object QRLabel127: TQRLabel
        Left = 24
        Top = 585
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1289.843750000000000000
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
      object QRLabel128: TQRLabel
        Left = 24
        Top = 601
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1325.121527777780000000
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
      object QRLabel129: TQRLabel
        Left = 24
        Top = 616
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1358.194444444440000000
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
      object QRLabel130: TQRLabel
        Left = 24
        Top = 631
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1391.267361111110000000
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
      object QRLabel131: TQRLabel
        Left = 762
        Top = 694
        Width = 68
        Height = 13
        Size.Values = (
          28.663194444444440000
          1680.104166666667000000
          1530.173611111111000000
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
      object QRLabel132: TQRLabel
        Left = 24
        Top = 541
        Width = 621
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          1192.829861111110000000
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
        OnPrint = QRLabel83Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel133: TQRLabel
        Left = 24
        Top = 554
        Width = 621
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          1221.493055555560000000
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
      object QRLabel134: TQRLabel
        Left = 453
        Top = 655
        Width = 212
        Height = 20
        Size.Values = (
          44.097222222222200000
          998.802083333333000000
          1444.184027777780000000
          467.430555555556000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLabel137: TQRLabel
        Left = 687
        Top = 374
        Width = 159
        Height = 21
        Size.Values = (
          46.302083333333300000
          1514.739583333330000000
          824.618055555556000000
          350.572916666667000000)
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
      object QRImage1: TQRImage
        Left = 6
        Top = 1
        Width = 147
        Height = 34
        Size.Values = (
          74.965277777777800000
          13.229166666666700000
          2.204861111111110000
          324.114583333333000000)
        XLColumn = 0
        Center = True
        Picture.Data = {
          0A544A504547496D61676523280000FFD8FFE000104A46494600010100000100
          010000FFDB0043000B08080A08070B0A090A0D0C0B0D111C12110F0F1122191A
          141C29242B2A282427272D3240372D303D302727384C393D43454849482B364F
          554E465440474845FFDB0043010C0D0D110F1121121221452E272E4545454545
          4545454545454545454545454545454545454545454545454545454545454545
          45454545454545454545454545FFC0001108009601C103012200021101031101
          FFC4001F0000010501010101010100000000000000000102030405060708090A
          0BFFC400B5100002010303020403050504040000017D01020300041105122131
          410613516107227114328191A1082342B1C11552D1F02433627282090A161718
          191A25262728292A3435363738393A434445464748494A535455565758595A63
          6465666768696A737475767778797A838485868788898A92939495969798999A
          A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
          D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
          01010101010101010000000000000102030405060708090A0BFFC400B5110002
          0102040403040705040400010277000102031104052131061241510761711322
          328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
          292A35363738393A434445464748494A535455565758595A636465666768696A
          737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
          A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
          E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F5CA
          28A2800A28A2800A28A2800A28A2803CD3C4DF146F345D6AEB4D874C8418240B
          E6CB216DC319CE063D73D6BA94B1F125DA2C926BD6B6E8C032FD96CB3907DDD8
          FE1C579C7C5FD3BECFE23B7BC51F2DDC0013EACA707F42B5E8FE04D43FB4FC1B
          A6CC4E5D22F25BEA9F2FF4A00B36FA15CA26DB8D77529F9CF2634C8F4CAA03FA
          D4BE1C7924D1A332CB24ACB2CC9BE462CC42CAC0649EBC015A9593E1AFF9032F
          FD779FFF00473D006B514310AA598E001926B81D17E232EB6F75630A2477ED71
          B2D3232AF197C6EC67AAAE491DF1401DF5150DBCC64DC922ED96338603A1F423
          D8FF0088ED535001451450014514500145145001451450014514500145145001
          4514500145145001451450014514500145145001451450014514500145145001
          4514500145145001451450014514500145145001451450014514500145145001
          45145001587A878B34ED33C4367A3DCC9B66B952DBC9C2A1FE107EBCFE9EB5A1
          ABEA9068DA5DCDFDD3011408588CE371EC07B93C5785E8B6177E3FF1A33DD963
          1CAE66B9607EE463F847E8A2803DA74CD79750BC788C2D145265ED2563C5C229
          C311E9CF3EEA41F5AD7ACFD474B4BCB0486122096DC87B69147FA975FBA47B76
          23B82453B49D40EA1685A58FC9BA89BCBB88739F2DC751EE0E4107B8228038FF
          008BBA7FDA7C310DDA8CB5A4E093E8ADC1FD76D51F835A8799A76A3A7B1E6195
          6651ECC307F55FD6BB8F12E9FF00DABE1CD46CF1969606DA3FDA0323F502BC6B
          E17EA474FF0019C1131C25E2340D9F5FBC3F51FAD219EF3593E1AFF9032FFD77
          9FFF00473D6B564F86BFE40CBFF5DE7FFD1CF4C4677C42D60E8FE11BB78DB6CD
          71FE8F1FD5BAFF00E3B9AE03E10693F69D72EB5275CA5A47B10FFB6FFF00D607
          F3A97E30EADE7EAB69A6237CB6D1F9B20CFF001374FC80FD6BB5F871A39D23C2
          16DE60C4D77FE92FFF0002FBA3FEF90290CE9AE216936BC6C1658CE549E87D41
          F63FE07B53A0984D1EEC6D71C3A1EAA7D0D49593657125FEB135C5BE16C61530
          97C7FAF901E71FECAF233DC93E94C46B51451400514514005145140051451400
          5145140051451400514514005145140051451400514514005145140051451400
          5145140051451400514514005145140051451400514514005145140051451400
          514514005145140051451401E3BF163C4DF6CBE4D12D5F30DB1DF3E3F8A4ECBF
          803F99F6AED3E1DF867FE11ED015EE23DB7D798926CF551FC2BF803F993543C5
          FF000D60D5E57D43477169A813BD9738491BAE7FD96CF7FF00F5D64683F10F50
          D06F7FB23C63148A63F97ED257E75F4DC07DE1FED0FD690CF54AC6D5627D3EED
          758B657608BB2EE1419F322FEF01DD97A8F5191E95A96D7305E5BA5C5ACA9343
          20CAC887208FAD4B4C43629526892589C3C6EA19594E4107A115F3BEB31B7867
          C71398C6DFB1DE09500FEEEEDC3F4AF70B56FEC4D496C1CE2C6E989B424711BF
          25A2CFA1E4AFE23B0AF30F8BFA77D9FC476F78A3E5BA80027D594E0FE85690CF
          668A559A24963394750CA477079ACAF0FC890E82649182A24D70CC4F60257CD5
          2F006A3FDA5E0CD3A466CBC49E43FD50E3F901585E23D5BFB2BE1B5C046C4B77
          713DBA7E333EEFFC741A623CE0197C69E391907FD3EEB91FDD8FFF00ACA2BE87
          4458D151000AA3000EC2BC83E0F68E67D56EF55917E4B64F26327FBEDD7F21FF
          00A157AA6A9A8AE9D6C1C21967958470420E0CAE7A0FEA4F6009A00ABAA5CCB7
          370BA55848527906E9E65EB6F17AFB33745FC4F6AD2B6B68ACEDA2B7B7411C31
          285451D80AADA569E6C2DD8CCFE6DDCEDE65C4BFDF7C76F4006001D80157A800
          A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800
          A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800
          A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800ACAD77C3
          7A6F88ED3C8D4600F8FB92AF0E9F43FD3A56AD1401E392D87897E18DDBDC58B7
          DB74876CB8C1287FDE1D50FB8E3F957A1F863C65A678A6DF36AFE55D28CC96B2
          11BD7DC7A8F71FA56FBA2CA8C92287461865619047A1AF36F147C32DB2FF0069
          F859DAD6EE33BC5BAB6D19F543FC27DBA7D2803D06FEC62D46CDEDA7076B7218
          7DE461C8607B107906B99D4B4083C6768961ACC8F0DFE9B27CED0606F0C38619
          CFCAC067D8823B554F09F8B3566B09078934F9A25B69040F78108C363AC8BD40
          E9961C73CE2BA1D241D46FE7D61B1E53A7916A077881C97CF7DC791EC07A9A00
          A7A47845F40864B5D2B559E0B377F33CB68D1D836003F3118C71D31F8D70FF00
          15B4CBBB2B4D3561567D322690990B65BCD762C7700063DBF1AF5DA86F2CEDEF
          ED64B5BB89668251B5D1C6411401C97C3636565E05865593681BE6B867057072
          7279EC02E33D38ADBD2E196FAE4EAF788C85D76DAC2DD618CF723FBCDC13E830
          3D6ADCBA3D84D690DAB5B27D9E0C6C8D78500608181D470383C7159BAFF8D346
          F0E230BCBA0F381C5BC5F339FA8EDF8E28037EB275BF13E93E1E877EA57691B6
          32B10F99DBE8A3F9F4AE2BFB77C5FE353E5E8767FD91A7B70D75292188F638CF
          FDF23F1AD5D13E19E996137DAF5691F56BD27717B8FB80FF00BBCE7F1CD00685
          8F8D60D5F4A7BDD2B4FBCB92BBC9429B000BEAC78E7D064FB57470C82685241D
          1D437E74D3020B53044AB1A6C28A146028C7A552F0E387F0E69A573816D1AF3E
          CA07F4A00D2A28AA5ACEAB6FA269371A85D93E540BB881D58F603DC9C0A0092F
          AF92C620CD1CB2BB9DA91429B9DCFB0FEA7007AD5158759BE50D71711E9A87FE
          595B812498F77618FC97F1A83C26D797BA60D575263F68BEFDEA47DA188FDC41
          F8724F726B7A803323D123595647BDD42561D775DB80DC7A2903F214B268B0BC
          DE68BABF43C7CAB7926DFCB359BA978FBC39A55C3DBDC6A48D321DAC91234854
          FBE062AAC5F13BC2D2C817FB41933FC4F0381F9E28036FFB2EE91B743AC5E8CB
          64AB88DC63D395CFEB4DB0B8BC6D66F6D669E39A08238D8308B6B2B367E5CE70
          7800F41D4556B5F1B7872F582C1AC5A962DB42B36D24FD0E2AC78788B8B59F50
          CE7EDD3B4AA7D507CA9FF8EAA9FC68035A8A28A0028A28A0028A824BDB58559A
          5B985027DE2D2018FAD4706ADA75C922DEFED652BD7CB995B1F91A00B745223A
          C8A1918329EE0E452D0014514500145145001451450014514500145145001451
          450014514330552CC4003924F6A0028A4565750C8C194F420E452D0014514500
          1451450014514500145145001451450014515E75E3FF001A6B1E16D6A186C4DB
          B413C01C2CB113B4E483C823DA803D168AE4FC3326ABAF787ACF52975A9A292E
          149648E188AA9048E32BED5AC34CD4B3FF0021EB93FF006C21FF00E228035A8A
          CE9AD753623C8D4E341DF7DB06CFE4C2A2FB1EB5FF00417B7FFC02FF00ECE803
          5A80000001803A015897726ABA558DC5ECF7B05D241197310B5285B1E8779C7E
          55B740051451401E6BF1675CD4B4CFB0DAD8DE496F0DCA399047C13823F8BAF7
          A77C32F0B69371A141ACDCDAADC5F48EFF003CDF305C310300F00FBF5AEA7C49
          E0ED37C5325BBEA2D3836E182794E17AE339C83E94DD2FC2D2E8964B65A6EAF7
          50DAA3332234513119393C95C9EB401D0D1595FD99A97FD076E3FEFC43FF00C4
          D1FD99A97FD076E3FEFC43FF00C4D006AD66787832E911A3A8431C92C6140C6D
          5591828C7D00A6FF00666A5FF41DB8FF00BF10FF00F135674CD3FF00B36D5A23
          33CECF23CAD23800966249E0003BD005CAF38F8C978D16876368A389E62EC7FD
          D1D3FF001EFD2BD1EB94F889E1E9BC41E1A64B55DF756CFE74683ABE010547BE
          0FE9401BDA3CD0DCE8D6335B00217811900EC368C0A9EEE16B9B39E0494C4F2C
          6C8B22F54246323E95E51F0EFC7B6DA4DB0D175A768A3473E44EFF007533FC0D
          E833D0FBF6AF5A8E449A3592275746190CA720FE3401C75B787B43D3ADFCAD47
          C311AF97C19E284DC2BFFB5C6587D08E3D4D4917853C15AC3482DAD2D5A423E6
          48A46464FF0080E463F2AEC2AA5EE9765A885FB5DBA48C8728FD1D0FAAB0E41F
          A1A00C4D27C03A2689AB47A8D845324D1A9555690B28C8C13CF39C1F5A8BC5BE
          285D166B4D1ED6DDA4BCD454C511460BE4E4ED0DD0F73FA56EC738B2B9B7B195
          DDC4AA443239C925464AB1EE71920F700FA73C027FC543F195891BA0D2A338EB
          805463FF004363F95007A043A3E9F0C2912D95B908A14168C1271EF5435EB0B4
          4D2258E1B5B649AE0ADBC6C225043390B9E9DB39FC2B72B9EF116A30595E5ACD
          72C45BD8C725ECB8F61B107D49738FA5006D4920B7448621BA52311A13D71DCF
          B0E327FA9159E344376376B172F78E7FE592931C2BEC101E7FE044D6778285D6
          A162FAF6A47377A8FCD1AE3886107E545F6EFEF9AE9A491228DA491D51101666
          638000EE4D00558348D3AD4E6DEC2D6238C65215048FCAA492C2D264292DAC0E
          87AAB460835C26A7F18349B59DA2B0B3B8BE553832822353F4CF27F2AA91FC68
          B52E04BA35C2A772B32B11F86050076D79A2E8F6F6F35CB5945088A32CCF0031
          10A393CAE0D731A6EBAFA96AF63E179629647B70B737734B26EDD85DFB0E7920
          3328EA7A55A83C54BE2ED166FB1E9B7715A995639A694A0458C10D264EEFEEE4
          7E3593F0AE26D4752D775E957E7B89B629F4C92CC3F55FCA803D07FB32C3FE7C
          ADBFEFD2FF00851FD9961FF3E56DFF007E97FC2AD579F78A3C53E29B5D6EE60F
          0FE9A2E6CED82ABC9F67693E7DBB88C823B11C50076FFD9961FF003E56DFF7E9
          7FC2A29B44D32E1364B616CCB9CFFAB039FC2B86F01F8F356F10EBF2E9DA9C56
          E1442D2031A15652A40C724FAD7A450063E9FE669DAA4FA7493B4B6CD179F6E6
          572CE801C3A927A804A904F3F37B562F85F571E32D42FEFA7B44169687ECD02B
          FCE1893B8B63D7013FC68F17EA4B62BAB5CA361ED74DF24153D1E67C007D08DA
          0FE3563E1C69DFD9DE0AB1CAE1EE019DFDF71E3F4C500741FD9961FF003E56DF
          F7E97FC28FECCB0FF9F2B6FF00BF4BFE15624758A367738550493E80579337C5
          4F10BB16834385A22728764872BD8FE5401EA3FD9961FF003E56DFF7E97FC2AA
          EA56FA7D869B73746C6DBF731B381E52F240E074F5AF37FF0085A5E26FFA0141
          FF007EE5AEB3C397FAAF8C747336A90C5631A5D27EE9236CC810ABF5278C9E3A
          50055BAD605BDFE99E0A8E1692678E1FB44E1F8551F338C73D554FE0D5D87F66
          587FCF95B7FDFA5FF0AF3CF0393AE7C42D7B5A63BA3873144C7D09C0C7FC057F
          5AF4DA00ABFD9961FF003E56DFF7E97FC291B4AD3D9486B0B520F50615FF000A
          E4FC5BF11E0F0C6AA74F5B06BB98441D984A142939C03C1ED83F8D5AF06F8F2D
          FC5B24D6E2D24B5B98503942DB959781907EA7A5006E3E83A5B85C58C3195042
          B42BE5B2E7AE0AE08A2DA66B3BD8F4D95E4903446486691B2CD838653EA46579
          EE0FB12746B0F58BB8EC757B3B9970120B5B9919B3D000868032D7C409E22F18
          36851DB660D364696794BE564C2ED0BB71FDE6FF00C76BA6FECCB0FF009F2B6F
          FBF4BFE15C1FC25B569AD755D666C996F2E36E7D8727F56FD2BD1A803125B5B7
          5F1269F0DB41144618E4B890C68173C6C5071D8EF63FF01F6ADBACAD2C9B9D53
          54BB3CA8916DA33FECA0C9FF00C79987E15AB400514514005145140051451400
          5796FC67B6261D2AE806C2B49193D867047E3C1FCABD4AB84F8B96DE77845260
          A4982E5189CFDD0411FCC8A007FC26B8F3BC18B1FCB982E244E0F38386E7FEFA
          AEE2BCC3E0C5D0365AADA123292A4A0639E4107FF4115E9CCC114B310AA06492
          7005002D36491228DA491D511465998E001EE6B14EBD2EA04A6836BF6B1D0DDC
          A4A5BAFD0F57FF00808C7B8A747E1E5B99166D6EE1B51941CAC6CBB6043FECC7
          D0FD5B26801B777CFADD8CF6BA4C2658AE2368CDE487644030C657BBFE031EF5
          B30A18A1442725540CFAD53D5F58B2D034E6BCBF93CA81085E064927800014D4
          D76C26B88A282613078C4A648FE64453F74B1ED9E71F43401A34514D97CC30BF
          92544BB4EC2E3201ED9F6A00CEFF00848B4AFB6DE599BD896E2CD77CC8C70557
          1927DF03AE3A54BA66AF69AB445ED9D83A805E2914A4899E9953C8FEB5E096C4
          69FE3A46F132B1F2EEF75D679C9CE727D57383EE2BDE6F34DB6D5123B84731CE
          AB986EE06C3A83CF07A1078E0E41A00D0A2B19352BAD2B116B615A1E02DFC4B8
          43DBF783F80F4E7EEF3D474AD8565750C8432B0C820E411400B4514500150CF7
          96D6AD1ADC5C450990E1048E1771F419EB53310AA589C00324D70FE10D4E5F18
          EA1A9DFEA10C32595BB1B6B5531F0549CB6724E4E025004DE24F875A47895E4B
          CB7736B77272658B051CFAB2F7FC315CA47F0F7C61A0BE743D594C6BCAA47314
          079FEE37CB5E967C3BA4191641A6DB2BAFDD648C291F4C547FF08DE9BFDCB8FF
          00C0B9BFF8AA00F38D1FC5FE2ED2FC556DA2EB319BA79A55568DD143853FC4AC
          BC103AF71C1AF5DAA365A369FA7CAD2DA5A471CCE30D2E32EDF563C9FCEAF500
          6278A2E12D2C6D6E18E1A2BA8DC1EF8192F8FF008007FC335CA7C25B5927B7D5
          B599F992F2E36827A9C727F56FD297E256A05B46B890A95823220B727FE5AC8D
          F7D87B040CB9EE58FA574FE0AD30E93E11D36D9861FCA123FF00BCDF31FE7401
          BD5E4FF142F9C5ADD052C16E6E52DC63A3244BB8FF00E3F27FE3BED5EA93CC96
          D6F24F21C244A5D89EC00C9AF24F88DA7CA9E14D0AE648B0ECF23CCC7A8797E7
          23F3CFE5401EABA640B6BA5DA4084958A14404FB28154FC4B1ACBA3B24C545B3
          4D109F7F4F2BCC5DD9F6C75F6CD51F026B89AEF85AD24DE0DC40A209D73C8651
          8C9FA8C1FC6BA2923496368E45574705595864107B114011258DAC68123B6855
          54602AC60002A0B8D0F4BBBDC6E34DB494B0C12F0A9247D7155A0D0459E16CB5
          1BEB7841F961DEB2228F41BD4903DB3C53DB4679198CBAAEA2EAD9CA095507E0
          55411F81A00C4F199B4F0C7817508F4E822B559FF74A91285059F827EBB73F95
          58F879A77F67782F4F52B879D4CEFF0056391FA62B82F18837B7163A45ACB2B4
          77F7EC543CACE76A911039249E5848DF8D7B0C51AC3124518C2228551E805001
          24890C4F248C151016663D001D4D67DB69AA2D9FEC9A85CAC570CD36E4F2CE4B
          9DD904AFBF1ED8AADE306B83E19BCB7B252F7574BF678941E496E0FE993F8572
          BF0AFC4E6EECDB41BD622EACD4984B7568C1C6DFAAF4FA7D2803752DBC37E043
          25E5CCC619AFA43BEEA7DCED237523206075CE0628B6F1C5A6B770D67E1C8DEF
          AE403991D1A38631FDE662338F40064D6C6BBA35B6BFA4CF6176A0A4832AD8C9
          461D187D2AB785E2B4B6D30DA5B59C5652DBB94B8823CFCAFD7393C90410413D
          88A00E2FE21DBBC361A66891CBE6DDEAD7BE64F285DBE61C8038E781B8003B05
          15E9504296D6F1C118C244A1140EC00C0AF3E933AE7C6445FBD0E936F9F60D8F
          F17FD2BD16802AEA1A8D96996DE76A37315BC04ECDF3300A49EDCD647FC253E1
          4FFA0A699FF7F16A4F14786A3F1459C1693DCBC30C72798CAAB9DE7040EFDB39
          AE63FE14FE95FF003F737FDF3FFD7A00E9E0F10F86AEA5115BDFD84D21C90919
          5663F80AA57174DA2F81350D41D0C334A92CE17182AD213B063B100A8FC2A0D0
          BC0167E19BE6D42CEE54CA232BBA78C90A0F53F787A5607C44D62EAF7C25A6DB
          B2A89B52B82D1AC608DF103F21C67A9CA1C5006CFC29D3CD9F8416E1C61EF266
          979F41F28FE59FC6BB7AA7A5592E9BA4D9D927DDB78523FC862A7B888CF6D2C4
          1DA332215DEBD57231919A00C6D32C6D353D32EAEAFADE2992FE5794891411E5
          FDD4EBDB6AA9FC6B86F83FA711A86AD7EA0F90A05BC67B373B8FE402FE75DEB6
          8570D6A2D1757B98AD44421F2A28E35C263180C5491C77CD5ED2F4BB3D1AC23B
          2D3E110DBC7D1473C9EA49EE6802E579D7C46D5561B0D4D908CAC71D82B03CEE
          73E6483FEF954FCCD7A05CCE2DADE494A96D8A4855EAC7B01EE7A5794F8B2D65
          BFF11E81A0CAC1A7B897ED77814F1BDCF23FE028A40F602803BEF05E9BFD93E1
          2D36D8821FC912383FDE6F98FF003AD8B99D2D6D66B890E12246763EC064D480
          00300600ACAF10FEF6C23B21D6FA64B73FEE9397FF00C7035004BA0DBBDBE8B6
          A25189A45F365CFF007DCEE6FD49AD1A3A514005145140051451400514514005
          6278C348975DF0C5E585B2A34F20531EF6C004303D7F3ADBACEBCD6ADEC6678A
          486EA428A199A1B777551EE40C500725E15F076A9E0E999ED9A2BD7BC8B6CD96
          D91C4C082A73CB1182DD07A74EB5D4AE8BF696126AF39BD607222DBB605FA277
          FAB13F8541FF0009658F97049E45F6CB82042DF6493126464638E7819A9FFE12
          087FE7C752FF00C0293FC280354000000600E8052332A296620281924F402B2F
          FE12087FE7C752FF00C0293FC2BCFBE2478E965B36D1B4F1344F27FC7D1950A3
          2AF50B83CF3DFDBEB401CFF8C7C4375E37F124561A62BC96C8FE55B463FE5A37
          773FE3D87E35EADA168B67E0DF0C34270E228DA5B9931FEB1B193F87602B9DF8
          61E0FF00ECAB11AC5F463EDB74BFBA561CC519FEA7F963DEBA4F135DAA2D9589
          8E5945D4C1A458632EDE52619B81D89DAA7FDEA00E5FC47E36BEF0758E9F60B6
          A92DE4D6FE73C92B1DB19663F2851D8741CF402B574CD5B5ED5FC2A9AD79F6D0
          E21695608612C652B9C86249C0383C019E7AD705F15EF52FB5DB2748A78B6DB6
          313C4D193F31E80D7A47C3C00F8134A046418DBFF436A4061FC48F0AAEBFA547
          AD69A9BEEA18C3154E7CE8BAFE2475FA67DAA87C2BF1879B1AE81A849FBC419B
          476FE25EE9F8751EDC76AEBF4BD623B2B3FB0496B7B23D9BB5B968AD9DD70A70
          BC81FDDDA7F1AF29F1BE90748D686ADA45BDEDADB48E2457781E2F265CE70091
          F88FCA803DDC80CA4300411820F7AC7FEC99F4B632E86CAB19259EC6427CA6FF
          0070FF00CB33F4F97DBBD55F0578A63F14E8AB31C2DE4184B88C766C7DE1EC7B
          7E3E95D1D302869FABDBDFBB438782EE31992DA61B5D3DFD08F7191EF57EB999
          755866F133BB5ADD4D0E9C8628E482DDA40656FBFC81FC2368FF00811F4AD1FF
          0084821FF9F1D4BFF00A4FF0A00ADE35D48E95E11D4AE158AC862F2D08EA19BE
          51FCEBCEBC21F1134AF0CF87E1D3DEC6F2498333CAE9B76B313DB27D303F0AF4
          96F11E9EFBE3960BADEAC8BE4BDABEF62DB88C2E3278563F85324D474E990A4B
          A3DE3A1EAADA73907FF1DA00E721F8C1A0BA9335B5FC4D9E0796AD9FC9AA5FF8
          5BDE1CFEE5FF00FDF81FE35ADBB42FFA1765FF00C151FF00E268DDA17FD0BB2F
          FE0A8FFF001340190BF15B4EBA9843A6697A95ECAC385488039F4EB9FC6B6B4F
          8F5BD65BCED61069969C14B3824DD23FFD747F4FF647E3E95621D5ECED90241A
          5DFC4A0630960EA31F80A97FE12087FE7C752FFC0293FC2803CEFE2D6A508D5F
          49D3A542D6B0013CC89C1209C6076E8A7F3AD21F18F48550A34DBE007007C9FF
          00C556FDEA683A8DCB5C5EF87EE6E266001924D39C938E9DAABFF66F85FF00E8
          5797FF00058FFF00C4D003EC75D3E38D0E7161652C16F24A2091E7651F2E417C
          019FE1247D4D6F6B7A35B6BDA4CFA75D83E54A3AAF55239047D0D50B1D434ED3
          6DC5BD8E937D6F0824EC8AC245193DFA559FF84821FF009F1D4BFF0000A4FF00
          0A00F17B8B4F117C37D60CB0B3471B3616503314EBE847AFB7515DC693F17F4A
          B88D5755B69ACE5039641E6213DF18E47E55D64DACDA5C46639F4DBF9636EAAF
          612107F022B9CBBF0E784EEC92DE1DBF8C939CC56B327E838A405A3F14FC2F8F
          F8FC98FF00DBBBFF00853F4BF1CAF89E59EDBC3D652BBC71EE69AE888D109E07
          4C93EB8F63505AE89E15B36568BC3776CCA00CC9652BFF00E840D6DC1AB595AA
          6CB6D2AFA141FC31E9EEA3F45A607955DEB967A1FC448E7B959AE6DB498C5B46
          B1E325953693CE3F88B1AEABFE172E93FF0040DBEFFC73FF008AAD896CBC3534
          AF2CBE1A99E4762CCC74D7C927A9E94DFECDF0BFFD0AF2FF00E0B1FF00F89A43
          352CE49B5E934BD48DB982CD10DC22C8C0BB332E172074C066FC715C07C42D1E
          E3C31E22B6F1469236ABCBBA418E164EF9F6619FD7D6BD1135DB78A358E3D3F5
          1545002AAD8C80003B0E2AAEABA8E9BAA6993D96A36B7D1DACEBB1E496D24554
          C9E1892303070727A5311A1A16B36FAFE8F6FA8DAF0932F2A7AA30E0A9FA1AAD
          AB21D2EEC6B70A332A2797791A0C9788721C0EE5393F42DED5E71E0ED46E3C0F
          E30B8F0F6A6FFE8B7320557FE10E7EE38F661807F0F4AF60232307A500789785
          3C7965A1EA5ABDFDF5ADC4F71A84BBC18B1855C938E4FA9FD2BA8FF85CBA4FFD
          036FBFF1CFFE2AB7EC747D36C354934CB9D36CDA294196CE4681492BFC519247
          552723FD923D0D6BFF0060E91FF40AB2FF00C074FF000A00E27FE172E93FF40D
          BEFF00C73FF8AA3FE172E93FF40DBEFF00C73FF8AAEDBFB0748FFA05597FE03A
          7F851FD83A47FD02ACBFF01D3FC2803074EF10378E749B84D3ACE6B6B7691619
          A59C8194382E1704F3B78FC45717E39D6ED6DBE23581B88DA4B3D2963CC5163E
          F7DEC0078EEBF957AEDB5ADBD9C7E5DAC11411E73B6240A33EB8159D71E16D0E
          EEE249EE34AB496690EE7778812C7D4D0071FF00F0B9749FFA06DF7FE39FFC55
          1FF0B9749FFA06DF7FE39FFC55759FF086F877FE80B65FF7E451FF00086F877F
          E80B65FF007E45007289F193472D86D3EF947AE10FFECD4B0FC537D526FB3E89
          E1EBCBB988E3730014F6CE3381EF5D5AF83FC3C8C19746B2C8391FB95AD4B7B5
          B7B48FCBB5822853FBB1A051F90A00A3A55A5FAC62E358B859AEDB9F2A25C450
          FB2F73D7193FA5793378BACAC7E266A1AD5DC52DC4519786110E3B0080F24718
          07F3AF6CAC53E0FF000F3124E8D6449EBFB91401C9FF00C2E5D27FE81B7DFF00
          8E7FF155D659B4FACDD69BA93DB982D520696357705CBB8014903FD92DDFBD1F
          F086F877FE80B65FF7E456CAAAA2855015546001D00A005A28A2800A28A2800A
          28A2800A28A2800AE4FC61773D9E83AE1B48A496795121558D0B1F98609C0F41
          935D65559B4F49A5924F3668CC800608F806803C24EB9AC9D23C3B6D158DDE34
          E98CB03F96C44E73940BC7385DC3E95EF96F30B8B78A60ACA2440E158608C8CE
          08EC6B2E3F0CD9450D9448F7023B020DB2F9A7F77F295E3D782473EB52DF2C1A
          6D94D79777F731C10A977632741F975A00CFF1AF8A63F0B68AD30C35E4F94B78
          CF76C7DE3EC3BFE1EB5E69F0F3C2F2F89B5A7D5F54DF2DAC12798ED273F6897A
          E09EE0753F80ACD7FED0F889E2F58A26902B70BE636EF2211D49FCFF00126BDD
          74CD36DB47D3A0B1B28C47042BB547AFA93EE4F2690CB75916205E6BD7F78794
          B702D223EE3E6908FC4A8FF8055FBEBB4B0B1B8BA97EE411B487F019AA1A5691
          25BE9B0ACD733ACEC3CC9423E0798C77376F526988F30F8C9FF231587FD7A7FE
          CED5E81F0F3FE445D2BFEB9B7FE86D5E79F1761F275FB11E649266D73991B27E
          F357A1FC3CFF0091174AFF00AE6DFF00A1B5219A1684DB788EFEDC9C25CC4972
          83FDA1F23FF24FCFDEADEA7A6DB6B1A74F637B189209976B0F4F423DC1E4550D
          6A2DBA969575E64910F35ADDD91B076B8E33FF000354FCEAFF00D83FE9EEEBFE
          FE7FF5A988F0C865D43E1AF8C8AC80C8A9C381C0B884F71EFF00C88AF69B8D76
          DFFB05752B3659D675516E33F7DD8E157DBE6383E9CFA551D7BC1763E21FB29B
          D9A766B7903862D9257BAFD0E2A41E1755D4D275BC985AA334E20F49C8DBBC1F
          4DB9E31D493401A9A6590D3AC22B7DFBDC65A490F577272CC7EA49356EAA7D83
          FE9EEEBFEFE7FF005A83A7E47FC7DDD7FDFCFF00EB50073FA47FC4C3C472DD1C
          945324E3F13E4C647B6D8E43FF0003EF5D5D62A786A2B7726CAFEF6D14AA26C8
          9D08C2AED1F7949E9EFD49F5A93FB127FF00A0DEA7FF007D45FF00C45006B515
          93FD893FFD06F53FFBEA2FFE228FEC49FF00E837A9FF00DF517FF11401AD4564
          FF00624FFF0041BD4FFEFA8BFF0088A3FB127FFA0DEA7FF7D45FFC45006B5159
          3FD893FF00D06F53FF00BEA2FF00E228FEC49FFE837A9FFDF517FF0011401AD4
          564FF624FF00F41BD4FF00EFA8BFF88A3FB127FF00A0DEA7FF007D45FF00C450
          06B51593FD893FFD06F53FFBEA2FFE228FEC49FF00E837A9FF00DF517FF11401
          AD4564FF00624FFF0041BD4FFEFA8BFF0088A3FB127FFA0DEA7FF7D45FFC4500
          6B51593FD893FF00D06F53FF00BEA2FF00E228FEC49FFE837A9FFDF517FF0011
          401AD4C9A18EE219219903C52295756E8C0F045667F624FF00F41BD4FF00EFA8
          BFF88A3FB127FF00A0DEA7FF007D45FF00C450070BE33F0CC9A96972403F79A9
          E929BA26FE2B9B524E3EACBD3EA3FDA1573C21F12B4C7D0A1875EBE16F7B07EE
          D9A40C7CD03A3703AFAFBD75D168016FEDEEE6D4AFAE24B7DDB048C98F986083
          85191D38F6159137C33F0C4F33CAD62EA5D8B10B330033E833C500597D6748F1
          3D948BA55F34B35B32C91CD0C0EDE4C9CED27E5E9D411DC6456D69B752DED845
          3CF6EF6F330C3C4EA41561C1EBDBD3DB1597A2F83347F0F5E35D69914B148CBB
          1B3333061EE09ADEA0028A28A0028A28A0028A28A0028A28A0028A28A0028A28
          A0028A28A0028A28A0028A28A0028A28A0028A28A002B0FC5DE1CFF849F4392C
          45C3C12021E320FCA58740C3B8FF00F5D6E51401E2BE11D664F87BAFDCE9BAF5
          98863B82BBE7032C9E8C08FBC9F4FF00EB57B2DBDC45756F1CF6F22CB0C8A191
          D0E4303DC5657897C2DA7F89EC4C3791E26507CA9D47CD19FEA3DAB91F02695E
          26F0E6B377A5DD82FA645199141E51C96E0C6DD89E4E0FE38CE6803B1D6585CD
          D69FA60E7ED12F9B20F48E3C31FCDB60FC4D6BD64E9E86EF58BDD41E3745455B
          6837A953B47CCE707D58E3FE015AD401E35F193FE461B1FF00AF5FFD9DABBFF8
          79FF00222E95FF005CDBFF00436AE03E327FC8C363FF005EBFFB3B577FF0F3FE
          445D2BFEB9B7FE86D4866A6BF0BCFA25D79233344BE74407F7D0EE5FD455EB79
          D2E6DE29E2398E540EA4770464513CD0C1133DC4891C407CCD230000F726B37C
          30E1B438515B7C70B3C51B8E8E8AE4291EA300734C46B5145140051451400514
          5140051451400514514005145140051451400514514005145140051451400514
          5140051451400514514005145140051451400514514005145140051451400514
          5140051451400514514005145140051451400514514005145140051451400514
          51401C678BBC047C59AD5B5D4B7A2DEDE18446CAA9B9D8EE278EC3A8AD0D2344
          D4B4DD362D32DAF61B7B3B72C91C8A9E64CEBB8904938553CFA1A28A00D083C3
          F6313ACB3A35E4E3FE5B5DB79AC0FA8CF0BF8015A74514005145140051451400
          5145140051451400514514005145140051451400514514005145140051451400
          5145140051451400514514005145140051451400514514005145140051451400
          51451400514514005145140051451401FFD9}
        Stretch = True
      end
      object QRImage2: TQRImage
        Left = 6
        Top = 363
        Width = 147
        Height = 34
        Size.Values = (
          74.965277777777800000
          13.229166666666700000
          800.364583333333000000
          324.114583333333000000)
        XLColumn = 0
        Center = True
        Picture.Data = {
          0A544A504547496D61676523280000FFD8FFE000104A46494600010100000100
          010000FFDB0043000B08080A08070B0A090A0D0C0B0D111C12110F0F1122191A
          141C29242B2A282427272D3240372D303D302727384C393D43454849482B364F
          554E465440474845FFDB0043010C0D0D110F1121121221452E272E4545454545
          4545454545454545454545454545454545454545454545454545454545454545
          45454545454545454545454545FFC0001108009601C103012200021101031101
          FFC4001F0000010501010101010100000000000000000102030405060708090A
          0BFFC400B5100002010303020403050504040000017D01020300041105122131
          410613516107227114328191A1082342B1C11552D1F02433627282090A161718
          191A25262728292A3435363738393A434445464748494A535455565758595A63
          6465666768696A737475767778797A838485868788898A92939495969798999A
          A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
          D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
          01010101010101010000000000000102030405060708090A0BFFC400B5110002
          0102040403040705040400010277000102031104052131061241510761711322
          328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
          292A35363738393A434445464748494A535455565758595A636465666768696A
          737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
          A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
          E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F5CA
          28A2800A28A2800A28A2800A28A2803CD3C4DF146F345D6AEB4D874C8418240B
          E6CB216DC319CE063D73D6BA94B1F125DA2C926BD6B6E8C032FD96CB3907DDD8
          FE1C579C7C5FD3BECFE23B7BC51F2DDC0013EACA707F42B5E8FE04D43FB4FC1B
          A6CC4E5D22F25BEA9F2FF4A00B36FA15CA26DB8D77529F9CF2634C8F4CAA03FA
          D4BE1C7924D1A332CB24ACB2CC9BE462CC42CAC0649EBC015A9593E1AFF9032F
          FD779FFF00473D006B514310AA598E001926B81D17E232EB6F75630A2477ED71
          B2D3232AF197C6EC67AAAE491DF1401DF5150DBCC64DC922ED96338603A1F423
          D8FF0088ED535001451450014514500145145001451450014514500145145001
          4514500145145001451450014514500145145001451450014514500145145001
          4514500145145001451450014514500145145001451450014514500145145001
          45145001587A878B34ED33C4367A3DCC9B66B952DBC9C2A1FE107EBCFE9EB5A1
          ABEA9068DA5DCDFDD3011408588CE371EC07B93C5785E8B6177E3FF1A33DD963
          1CAE66B9607EE463F847E8A2803DA74CD79750BC788C2D145265ED2563C5C229
          C311E9CF3EEA41F5AD7ACFD474B4BCB0486122096DC87B69147FA975FBA47B76
          23B82453B49D40EA1685A58FC9BA89BCBB88739F2DC751EE0E4107B8228038FF
          008BBA7FDA7C310DDA8CB5A4E093E8ADC1FD76D51F835A8799A76A3A7B1E6195
          6651ECC307F55FD6BB8F12E9FF00DABE1CD46CF1969606DA3FDA0323F502BC6B
          E17EA474FF0019C1131C25E2340D9F5FBC3F51FAD219EF3593E1AFF9032FFD77
          9FFF00473D6B564F86BFE40CBFF5DE7FFD1CF4C4677C42D60E8FE11BB78DB6CD
          71FE8F1FD5BAFF00E3B9AE03E10693F69D72EB5275CA5A47B10FFB6FFF00D607
          F3A97E30EADE7EAB69A6237CB6D1F9B20CFF001374FC80FD6BB5F871A39D23C2
          16DE60C4D77FE92FFF0002FBA3FEF90290CE9AE216936BC6C1658CE549E87D41
          F63FE07B53A0984D1EEC6D71C3A1EAA7D0D49593657125FEB135C5BE16C61530
          97C7FAF901E71FECAF233DC93E94C46B51451400514514005145140051451400
          5145140051451400514514005145140051451400514514005145140051451400
          5145140051451400514514005145140051451400514514005145140051451400
          514514005145140051451401E3BF163C4DF6CBE4D12D5F30DB1DF3E3F8A4ECBF
          803F99F6AED3E1DF867FE11ED015EE23DB7D798926CF551FC2BF803F993543C5
          FF000D60D5E57D43477169A813BD9738491BAE7FD96CF7FF00F5D64683F10F50
          D06F7FB23C63148A63F97ED257E75F4DC07DE1FED0FD690CF54AC6D5627D3EED
          758B657608BB2EE1419F322FEF01DD97A8F5191E95A96D7305E5BA5C5ACA9343
          20CAC887208FAD4B4C43629526892589C3C6EA19594E4107A115F3BEB31B7867
          C71398C6DFB1DE09500FEEEEDC3F4AF70B56FEC4D496C1CE2C6E989B424711BF
          25A2CFA1E4AFE23B0AF30F8BFA77D9FC476F78A3E5BA80027D594E0FE85690CF
          668A559A24963394750CA477079ACAF0FC890E82649182A24D70CC4F60257CD5
          2F006A3FDA5E0CD3A466CBC49E43FD50E3F901585E23D5BFB2BE1B5C046C4B77
          713DBA7E333EEFFC741A623CE0197C69E391907FD3EEB91FDD8FFF00ACA2BE87
          4458D151000AA3000EC2BC83E0F68E67D56EF55917E4B64F26327FBEDD7F21FF
          00A157AA6A9A8AE9D6C1C21967958470420E0CAE7A0FEA4F6009A00ABAA5CCB7
          370BA55848527906E9E65EB6F17AFB33745FC4F6AD2B6B68ACEDA2B7B7411C31
          285451D80AADA569E6C2DD8CCFE6DDCEDE65C4BFDF7C76F4006001D80157A800
          A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800
          A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800
          A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800ACAD77C3
          7A6F88ED3C8D4600F8FB92AF0E9F43FD3A56AD1401E392D87897E18DDBDC58B7
          DB74876CB8C1287FDE1D50FB8E3F957A1F863C65A678A6DF36AFE55D28CC96B2
          11BD7DC7A8F71FA56FBA2CA8C92287461865619047A1AF36F147C32DB2FF0069
          F859DAD6EE33BC5BAB6D19F543FC27DBA7D2803D06FEC62D46CDEDA7076B7218
          7DE461C8607B107906B99D4B4083C6768961ACC8F0DFE9B27CED0606F0C38619
          CFCAC067D8823B554F09F8B3566B09078934F9A25B69040F78108C363AC8BD40
          E9961C73CE2BA1D241D46FE7D61B1E53A7916A077881C97CF7DC791EC07A9A00
          A7A47845F40864B5D2B559E0B377F33CB68D1D836003F3118C71D31F8D70FF00
          15B4CBBB2B4D3561567D322690990B65BCD762C7700063DBF1AF5DA86F2CEDEF
          ED64B5BB89668251B5D1C6411401C97C3636565E05865593681BE6B867057072
          7279EC02E33D38ADBD2E196FAE4EAF788C85D76DAC2DD618CF723FBCDC13E830
          3D6ADCBA3D84D690DAB5B27D9E0C6C8D78500608181D470383C7159BAFF8D346
          F0E230BCBA0F381C5BC5F339FA8EDF8E28037EB275BF13E93E1E877EA57691B6
          32B10F99DBE8A3F9F4AE2BFB77C5FE353E5E8767FD91A7B70D75292188F638CF
          FDF23F1AD5D13E19E996137DAF5691F56BD27717B8FB80FF00BBCE7F1CD00685
          8F8D60D5F4A7BDD2B4FBCB92BBC9429B000BEAC78E7D064FB57470C82685241D
          1D437E74D3020B53044AB1A6C28A146028C7A552F0E387F0E69A573816D1AF3E
          CA07F4A00D2A28AA5ACEAB6FA269371A85D93E540BB881D58F603DC9C0A0092F
          AF92C620CD1CB2BB9DA91429B9DCFB0FEA7007AD5158759BE50D71711E9A87FE
          595B812498F77618FC97F1A83C26D797BA60D575263F68BEFDEA47DA188FDC41
          F8724F726B7A803323D123595647BDD42561D775DB80DC7A2903F214B268B0BC
          DE68BABF43C7CAB7926DFCB359BA978FBC39A55C3DBDC6A48D321DAC91234854
          FBE062AAC5F13BC2D2C817FB41933FC4F0381F9E28036FFB2EE91B743AC5E8CB
          64AB88DC63D395CFEB4DB0B8BC6D66F6D669E39A08238D8308B6B2B367E5CE70
          7800F41D4556B5F1B7872F582C1AC5A962DB42B36D24FD0E2AC78788B8B59F50
          CE7EDD3B4AA7D507CA9FF8EAA9FC68035A8A28A0028A28A0028A824BDB58559A
          5B985027DE2D2018FAD4706ADA75C922DEFED652BD7CB995B1F91A00B745223A
          C8A1918329EE0E452D0014514500145145001451450014514500145145001451
          450014514330552CC4003924F6A0028A4565750C8C194F420E452D0014514500
          1451450014514500145145001451450014515E75E3FF001A6B1E16D6A186C4DB
          B413C01C2CB113B4E483C823DA803D168AE4FC3326ABAF787ACF52975A9A292E
          149648E188AA9048E32BED5AC34CD4B3FF0021EB93FF006C21FF00E228035A8A
          CE9AD753623C8D4E341DF7DB06CFE4C2A2FB1EB5FF00417B7FFC02FF00ECE803
          5A80000001803A015897726ABA558DC5ECF7B05D241197310B5285B1E8779C7E
          55B740051451401E6BF1675CD4B4CFB0DAD8DE496F0DCA399047C13823F8BAF7
          A77C32F0B69371A141ACDCDAADC5F48EFF003CDF305C310300F00FBF5AEA7C49
          E0ED37C5325BBEA2D3836E182794E17AE339C83E94DD2FC2D2E8964B65A6EAF7
          50DAA3332234513119393C95C9EB401D0D1595FD99A97FD076E3FEFC43FF00C4
          D1FD99A97FD076E3FEFC43FF00C4D006AD66787832E911A3A8431C92C6140C6D
          5591828C7D00A6FF00666A5FF41DB8FF00BF10FF00F135674CD3FF00B36D5A23
          33CECF23CAD23800966249E0003BD005CAF38F8C978D16876368A389E62EC7FD
          D1D3FF001EFD2BD1EB94F889E1E9BC41E1A64B55DF756CFE74683ABE010547BE
          0FE9401BDA3CD0DCE8D6335B00217811900EC368C0A9EEE16B9B39E0494C4F2C
          6C8B22F54246323E95E51F0EFC7B6DA4DB0D175A768A3473E44EFF007533FC0D
          E833D0FBF6AF5A8E449A3592275746190CA720FE3401C75B787B43D3ADFCAD47
          C311AF97C19E284DC2BFFB5C6587D08E3D4D4917853C15AC3482DAD2D5A423E6
          48A46464FF0080E463F2AEC2AA5EE9765A885FB5DBA48C8728FD1D0FAAB0E41F
          A1A00C4D27C03A2689AB47A8D845324D1A9555690B28C8C13CF39C1F5A8BC5BE
          285D166B4D1ED6DDA4BCD454C511460BE4E4ED0DD0F73FA56EC738B2B9B7B195
          DDC4AA443239C925464AB1EE71920F700FA73C027FC543F195891BA0D2A338EB
          805463FF004363F95007A043A3E9F0C2912D95B908A14168C1271EF5435EB0B4
          4D2258E1B5B649AE0ADBC6C225043390B9E9DB39FC2B72B9EF116A30595E5ACD
          72C45BD8C725ECB8F61B107D49738FA5006D4920B7448621BA52311A13D71DCF
          B0E327FA9159E344376376B172F78E7FE592931C2BEC101E7FE044D6778285D6
          A162FAF6A47377A8FCD1AE3886107E545F6EFEF9AE9A491228DA491D51101666
          638000EE4D00558348D3AD4E6DEC2D6238C65215048FCAA492C2D264292DAC0E
          87AAB460835C26A7F18349B59DA2B0B3B8BE553832822353F4CF27F2AA91FC68
          B52E04BA35C2A772B32B11F86050076D79A2E8F6F6F35CB5945088A32CCF0031
          10A393CAE0D731A6EBAFA96AF63E179629647B70B737734B26EDD85DFB0E7920
          3328EA7A55A83C54BE2ED166FB1E9B7715A995639A694A0458C10D264EEFEEE4
          7E3593F0AE26D4752D775E957E7B89B629F4C92CC3F55FCA803D07FB32C3FE7C
          ADBFEFD2FF00851FD9961FF3E56DFF007E97FC2AD579F78A3C53E29B5D6EE60F
          0FE9A2E6CED82ABC9F67693E7DBB88C823B11C50076FFD9961FF003E56DFF7E9
          7FC2A29B44D32E1364B616CCB9CFFAB039FC2B86F01F8F356F10EBF2E9DA9C56
          E1442D2031A15652A40C724FAD7A450063E9FE669DAA4FA7493B4B6CD179F6E6
          572CE801C3A927A804A904F3F37B562F85F571E32D42FEFA7B44169687ECD02B
          FCE1893B8B63D7013FC68F17EA4B62BAB5CA361ED74DF24153D1E67C007D08DA
          0FE3563E1C69DFD9DE0AB1CAE1EE019DFDF71E3F4C500741FD9961FF003E56DF
          F7E97FC28FECCB0FF9F2B6FF00BF4BFE15624758A367738550493E80579337C5
          4F10BB16834385A22728764872BD8FE5401EA3FD9961FF003E56DFF7E97FC2AA
          EA56FA7D869B73746C6DBF731B381E52F240E074F5AF37FF0085A5E26FFA0141
          FF007EE5AEB3C397FAAF8C747336A90C5631A5D27EE9236CC810ABF5278C9E3A
          50055BAD605BDFE99E0A8E1692678E1FB44E1F8551F338C73D554FE0D5D87F66
          587FCF95B7FDFA5FF0AF3CF0393AE7C42D7B5A63BA3873144C7D09C0C7FC057F
          5AF4DA00ABFD9961FF003E56DFF7E97FC291B4AD3D9486B0B520F50615FF000A
          E4FC5BF11E0F0C6AA74F5B06BB98441D984A142939C03C1ED83F8D5AF06F8F2D
          FC5B24D6E2D24B5B98503942DB959781907EA7A5006E3E83A5B85C58C3195042
          B42BE5B2E7AE0AE08A2DA66B3BD8F4D95E4903446486691B2CD838653EA46579
          EE0FB12746B0F58BB8EC757B3B9970120B5B9919B3D000868032D7C409E22F18
          36851DB660D364696794BE564C2ED0BB71FDE6FF00C76BA6FECCB0FF009F2B6F
          FBF4BFE15C1FC25B569AD755D666C996F2E36E7D8727F56FD2BD1A803125B5B7
          5F1269F0DB41144618E4B890C68173C6C5071D8EF63FF01F6ADBACAD2C9B9D53
          54BB3CA8916DA33FECA0C9FF00C79987E15AB400514514005145140051451400
          5796FC67B6261D2AE806C2B49193D867047E3C1FCABD4AB84F8B96DE77845260
          A4982E5189CFDD0411FCC8A007FC26B8F3BC18B1FCB982E244E0F38386E7FEFA
          AEE2BCC3E0C5D0365AADA123292A4A0639E4107FF4115E9CCC114B310AA06492
          7005002D36491228DA491D511465998E001EE6B14EBD2EA04A6836BF6B1D0DDC
          A4A5BAFD0F57FF00808C7B8A747E1E5B99166D6EE1B51941CAC6CBB6043FECC7
          D0FD5B26801B777CFADD8CF6BA4C2658AE2368CDE487644030C657BBFE031EF5
          B30A18A1442725540CFAD53D5F58B2D034E6BCBF93CA81085E064927800014D4
          D76C26B88A282613078C4A648FE64453F74B1ED9E71F43401A34514D97CC30BF
          92544BB4EC2E3201ED9F6A00CEFF00848B4AFB6DE599BD896E2CD77CC8C70557
          1927DF03AE3A54BA66AF69AB445ED9D83A805E2914A4899E9953C8FEB5E096C4
          69FE3A46F132B1F2EEF75D679C9CE727D57383EE2BDE6F34DB6D5123B84731CE
          AB986EE06C3A83CF07A1078E0E41A00D0A2B19352BAD2B116B615A1E02DFC4B8
          43DBF783F80F4E7EEF3D474AD8565750C8432B0C820E411400B4514500150CF7
          96D6AD1ADC5C450990E1048E1771F419EB53310AA589C00324D70FE10D4E5F18
          EA1A9DFEA10C32595BB1B6B5531F0549CB6724E4E025004DE24F875A47895E4B
          CB7736B77272658B051CFAB2F7FC315CA47F0F7C61A0BE743D594C6BCAA47314
          079FEE37CB5E967C3BA4191641A6DB2BAFDD648C291F4C547FF08DE9BFDCB8FF
          00C0B9BFF8AA00F38D1FC5FE2ED2FC556DA2EB319BA79A55568DD143853FC4AC
          BC103AF71C1AF5DAA365A369FA7CAD2DA5A471CCE30D2E32EDF563C9FCEAF500
          6278A2E12D2C6D6E18E1A2BA8DC1EF8192F8FF008007FC335CA7C25B5927B7D5
          B599F992F2E36827A9C727F56FD297E256A05B46B890A95823220B727FE5AC8D
          F7D87B040CB9EE58FA574FE0AD30E93E11D36D9861FCA123FF00BCDF31FE7401
          BD5E4FF142F9C5ADD052C16E6E52DC63A3244BB8FF00E3F27FE3BED5EA93CC96
          D6F24F21C244A5D89EC00C9AF24F88DA7CA9E14D0AE648B0ECF23CCC7A8797E7
          23F3CFE5401EABA640B6BA5DA4084958A14404FB28154FC4B1ACBA3B24C545B3
          4D109F7F4F2BCC5DD9F6C75F6CD51F026B89AEF85AD24DE0DC40A209D73C8651
          8C9FA8C1FC6BA2923496368E45574705595864107B114011258DAC68123B6855
          54602AC60002A0B8D0F4BBBDC6E34DB494B0C12F0A9247D7155A0D0459E16CB5
          1BEB7841F961DEB2228F41BD4903DB3C53DB4679198CBAAEA2EAD9CA095507E0
          55411F81A00C4F199B4F0C7817508F4E822B559FF74A91285059F827EBB73F95
          58F879A77F67782F4F52B879D4CEFF0056391FA62B82F18837B7163A45ACB2B4
          77F7EC543CACE76A911039249E5848DF8D7B0C51AC3124518C2228551E805001
          24890C4F248C151016663D001D4D67DB69AA2D9FEC9A85CAC570CD36E4F2CE4B
          9DD904AFBF1ED8AADE306B83E19BCB7B252F7574BF678941E496E0FE993F8572
          BF0AFC4E6EECDB41BD622EACD4984B7568C1C6DFAAF4FA7D2803752DBC37E043
          25E5CCC619AFA43BEEA7DCED237523206075CE0628B6F1C5A6B770D67E1C8DEF
          AE403991D1A38631FDE662338F40064D6C6BBA35B6BFA4CF6176A0A4832AD8C9
          461D187D2AB785E2B4B6D30DA5B59C5652DBB94B8823CFCAFD7393C90410413D
          88A00E2FE21DBBC361A66891CBE6DDEAD7BE64F285DBE61C8038E781B8003B05
          15E9504296D6F1C118C244A1140EC00C0AF3E933AE7C6445FBD0E936F9F60D8F
          F17FD2BD16802AEA1A8D96996DE76A37315BC04ECDF3300A49EDCD647FC253E1
          4FFA0A699FF7F16A4F14786A3F1459C1693DCBC30C72798CAAB9DE7040EFDB39
          AE63FE14FE95FF003F737FDF3FFD7A00E9E0F10F86AEA5115BDFD84D21C90919
          5663F80AA57174DA2F81350D41D0C334A92CE17182AD213B063B100A8FC2A0D0
          BC0167E19BE6D42CEE54CA232BBA78C90A0F53F787A5607C44D62EAF7C25A6DB
          B2A89B52B82D1AC608DF103F21C67A9CA1C5006CFC29D3CD9F8416E1C61EF266
          979F41F28FE59FC6BB7AA7A5592E9BA4D9D927DDB78523FC862A7B888CF6D2C4
          1DA332215DEBD57231919A00C6D32C6D353D32EAEAFADE2992FE5794891411E5
          FDD4EBDB6AA9FC6B86F83FA711A86AD7EA0F90A05BC67B373B8FE402FE75DEB6
          8570D6A2D1757B98AD44421F2A28E35C263180C5491C77CD5ED2F4BB3D1AC23B
          2D3E110DBC7D1473C9EA49EE6802E579D7C46D5561B0D4D908CAC71D82B03CEE
          73E6483FEF954FCCD7A05CCE2DADE494A96D8A4855EAC7B01EE7A5794F8B2D65
          BFF11E81A0CAC1A7B897ED77814F1BDCF23FE028A40F602803BEF05E9BFD93E1
          2D36D8821FC912383FDE6F98FF003AD8B99D2D6D66B890E12246763EC064D480
          00300600ACAF10FEF6C23B21D6FA64B73FEE9397FF00C7035004BA0DBBDBE8B6
          A25189A45F365CFF007DCEE6FD49AD1A3A514005145140051451400514514005
          6278C348975DF0C5E585B2A34F20531EF6C004303D7F3ADBACEBCD6ADEC6678A
          486EA428A199A1B777551EE40C500725E15F076A9E0E999ED9A2BD7BC8B6CD96
          D91C4C082A73CB1182DD07A74EB5D4AE8BF696126AF39BD607222DBB605FA277
          FAB13F8541FF0009658F97049E45F6CB82042DF6493126464638E7819A9FFE12
          087FE7C752FF00C0293FC280354000000600E8052332A296620281924F402B2F
          FE12087FE7C752FF00C0293FC2BCFBE2478E965B36D1B4F1344F27FC7D1950A3
          2AF50B83CF3DFDBEB401CFF8C7C4375E37F124561A62BC96C8FE55B463FE5A37
          773FE3D87E35EADA168B67E0DF0C34270E228DA5B9931FEB1B193F87602B9DF8
          61E0FF00ECAB11AC5F463EDB74BFBA561CC519FEA7F963DEBA4F135DAA2D9589
          8E5945D4C1A458632EDE52619B81D89DAA7FDEA00E5FC47E36BEF0758E9F60B6
          A92DE4D6FE73C92B1DB19663F2851D8741CF402B574CD5B5ED5FC2A9AD79F6D0
          E21695608612C652B9C86249C0383C019E7AD705F15EF52FB5DB2748A78B6DB6
          313C4D193F31E80D7A47C3C00F8134A046418DBFF436A4061FC48F0AAEBFA547
          AD69A9BEEA18C3154E7CE8BAFE2475FA67DAA87C2BF1879B1AE81A849FBC419B
          476FE25EE9F8751EDC76AEBF4BD623B2B3FB0496B7B23D9BB5B968AD9DD70A70
          BC81FDDDA7F1AF29F1BE90748D686ADA45BDEDADB48E2457781E2F265CE70091
          F88FCA803DDC80CA4300411820F7AC7FEC99F4B632E86CAB19259EC6427CA6FF
          0070FF00CB33F4F97DBBD55F0578A63F14E8AB31C2DE4184B88C766C7DE1EC7B
          7E3E95D1D302869FABDBDFBB438782EE31992DA61B5D3DFD08F7191EF57EB999
          755866F133BB5ADD4D0E9C8628E482DDA40656FBFC81FC2368FF00811F4AD1FF
          0084821FF9F1D4BFF00A4FF0A00ADE35D48E95E11D4AE158AC862F2D08EA19BE
          51FCEBCEBC21F1134AF0CF87E1D3DEC6F2498333CAE9B76B313DB27D303F0AF4
          96F11E9EFBE3960BADEAC8BE4BDABEF62DB88C2E3278563F85324D474E990A4B
          A3DE3A1EAADA73907FF1DA00E721F8C1A0BA9335B5FC4D9E0796AD9FC9AA5FF8
          5BDE1CFEE5FF00FDF81FE35ADBB42FFA1765FF00C151FF00E268DDA17FD0BB2F
          FE0A8FFF001340190BF15B4EBA9843A6697A95ECAC385488039F4EB9FC6B6B4F
          8F5BD65BCED61069969C14B3824DD23FFD747F4FF647E3E95621D5ECED90241A
          5DFC4A0630960EA31F80A97FE12087FE7C752FFC0293FC2803CEFE2D6A508D5F
          49D3A542D6B0013CC89C1209C6076E8A7F3AD21F18F48550A34DBE007007C9FF
          00C556FDEA683A8DCB5C5EF87EE6E266001924D39C938E9DAABFF66F85FF00E8
          5797FF00058FFF00C4D003EC75D3E38D0E7161652C16F24A2091E7651F2E417C
          019FE1247D4D6F6B7A35B6BDA4CFA75D83E54A3AAF55239047D0D50B1D434ED3
          6DC5BD8E937D6F0824EC8AC245193DFA559FF84821FF009F1D4BFF0000A4FF00
          0A00F17B8B4F117C37D60CB0B3471B3616503314EBE847AFB7515DC693F17F4A
          B88D5755B69ACE5039641E6213DF18E47E55D64DACDA5C46639F4DBF9636EAAF
          612107F022B9CBBF0E784EEC92DE1DBF8C939CC56B327E838A405A3F14FC2F8F
          F8FC98FF00DBBBFF00853F4BF1CAF89E59EDBC3D652BBC71EE69AE888D109E07
          4C93EB8F63505AE89E15B36568BC3776CCA00CC9652BFF00E840D6DC1AB595AA
          6CB6D2AFA141FC31E9EEA3F45A607955DEB967A1FC448E7B959AE6DB498C5B46
          B1E325953693CE3F88B1AEABFE172E93FF0040DBEFFC73FF008AAD896CBC3534
          AF2CBE1A99E4762CCC74D7C927A9E94DFECDF0BFFD0AF2FF00E0B1FF00F89A43
          352CE49B5E934BD48DB982CD10DC22C8C0BB332E172074C066FC715C07C42D1E
          E3C31E22B6F1469236ABCBBA418E164EF9F6619FD7D6BD1135DB78A358E3D3F5
          1545002AAD8C80003B0E2AAEABA8E9BAA6993D96A36B7D1DACEBB1E496D24554
          C9E1892303070727A5311A1A16B36FAFE8F6FA8DAF0932F2A7AA30E0A9FA1AAD
          AB21D2EEC6B70A332A2797791A0C9788721C0EE5393F42DED5E71E0ED46E3C0F
          E30B8F0F6A6FFE8B7320557FE10E7EE38F661807F0F4AF60232307A500789785
          3C7965A1EA5ABDFDF5ADC4F71A84BBC18B1855C938E4FA9FD2BA8FF85CBA4FFD
          036FBFF1CFFE2AB7EC747D36C354934CB9D36CDA294196CE4681492BFC519247
          552723FD923D0D6BFF0060E91FF40AB2FF00C074FF000A00E27FE172E93FF40D
          BEFF00C73FF8AA3FE172E93FF40DBEFF00C73FF8AAEDBFB0748FFA05597FE03A
          7F851FD83A47FD02ACBFF01D3FC2803074EF10378E749B84D3ACE6B6B7691619
          A59C8194382E1704F3B78FC45717E39D6ED6DBE23581B88DA4B3D2963CC5163E
          F7DEC0078EEBF957AEDB5ADBD9C7E5DAC11411E73B6240A33EB8159D71E16D0E
          EEE249EE34AB496690EE7778812C7D4D0071FF00F0B9749FFA06DF7FE39FFC55
          1FF0B9749FFA06DF7FE39FFC55759FF086F877FE80B65FF7E451FF00086F877F
          E80B65FF007E45007289F193472D86D3EF947AE10FFECD4B0FC537D526FB3E89
          E1EBCBB988E3730014F6CE3381EF5D5AF83FC3C8C19746B2C8391FB95AD4B7B5
          B7B48FCBB5822853FBB1A051F90A00A3A55A5FAC62E358B859AEDB9F2A25C450
          FB2F73D7193FA5793378BACAC7E266A1AD5DC52DC4519786110E3B0080F24718
          07F3AF6CAC53E0FF000F3124E8D6449EBFB91401C9FF00C2E5D27FE81B7DFF00
          8E7FF155D659B4FACDD69BA93DB982D520696357705CBB8014903FD92DDFBD1F
          F086F877FE80B65FF7E456CAAAA2855015546001D00A005A28A2800A28A2800A
          28A2800A28A2800AE4FC61773D9E83AE1B48A496795121558D0B1F98609C0F41
          935D65559B4F49A5924F3668CC800608F806803C24EB9AC9D23C3B6D158DDE34
          E98CB03F96C44E73940BC7385DC3E95EF96F30B8B78A60ACA2440E158608C8CE
          08EC6B2E3F0CD9450D9448F7023B020DB2F9A7F77F295E3D782473EB52DF2C1A
          6D94D79777F731C10A977632741F975A00CFF1AF8A63F0B68AD30C35E4F94B78
          CF76C7DE3EC3BFE1EB5E69F0F3C2F2F89B5A7D5F54DF2DAC12798ED273F6897A
          E09EE0753F80ACD7FED0F889E2F58A26902B70BE636EF2211D49FCFF00126BDD
          74CD36DB47D3A0B1B28C47042BB547AFA93EE4F2690CB75916205E6BD7F78794
          B702D223EE3E6908FC4A8FF8055FBEBB4B0B1B8BA97EE411B487F019AA1A5691
          25BE9B0ACD733ACEC3CC9423E0798C77376F526988F30F8C9FF231587FD7A7FE
          CED5E81F0F3FE445D2BFEB9B7FE86D5E79F1761F275FB11E649266D73991B27E
          F357A1FC3CFF0091174AFF00AE6DFF00A1B5219A1684DB788EFEDC9C25CC4972
          83FDA1F23FF24FCFDEADEA7A6DB6B1A74F637B189209976B0F4F423DC1E4550D
          6A2DBA969575E64910F35ADDD91B076B8E33FF000354FCEAFF00D83FE9EEEBFE
          FE7FF5A988F0C865D43E1AF8C8AC80C8A9C381C0B884F71EFF00C88AF69B8D76
          DFFB05752B3659D675516E33F7DD8E157DBE6383E9CFA551D7BC1763E21FB29B
          D9A766B7903862D9257BAFD0E2A41E1755D4D275BC985AA334E20F49C8DBBC1F
          4DB9E31D493401A9A6590D3AC22B7DFBDC65A490F577272CC7EA49356EAA7D83
          FE9EEEBFEFE7FF005A83A7E47FC7DDD7FDFCFF00EB50073FA47FC4C3C472DD1C
          945324E3F13E4C647B6D8E43FF0003EF5D5D62A786A2B7726CAFEF6D14AA26C8
          9D08C2AED1F7949E9EFD49F5A93FB127FF00A0DEA7FF007D45FF00C45006B515
          93FD893FFD06F53FFBEA2FFE228FEC49FF00E837A9FF00DF517FF11401AD4564
          FF00624FFF0041BD4FFEFA8BFF0088A3FB127FFA0DEA7FF7D45FFC45006B5159
          3FD893FF00D06F53FF00BEA2FF00E228FEC49FFE837A9FFDF517FF0011401AD4
          564FF624FF00F41BD4FF00EFA8BFF88A3FB127FF00A0DEA7FF007D45FF00C450
          06B51593FD893FFD06F53FFBEA2FFE228FEC49FF00E837A9FF00DF517FF11401
          AD4564FF00624FFF0041BD4FFEFA8BFF0088A3FB127FFA0DEA7FF7D45FFC4500
          6B51593FD893FF00D06F53FF00BEA2FF00E228FEC49FFE837A9FFDF517FF0011
          401AD4C9A18EE219219903C52295756E8C0F045667F624FF00F41BD4FF00EFA8
          BFF88A3FB127FF00A0DEA7FF007D45FF00C450070BE33F0CC9A96972403F79A9
          E929BA26FE2B9B524E3EACBD3EA3FDA1573C21F12B4C7D0A1875EBE16F7B07EE
          D9A40C7CD03A3703AFAFBD75D168016FEDEEE6D4AFAE24B7DDB048C98F986083
          85191D38F6159137C33F0C4F33CAD62EA5D8B10B330033E833C500597D6748F1
          3D948BA55F34B35B32C91CD0C0EDE4C9CED27E5E9D411DC6456D69B752DED845
          3CF6EF6F330C3C4EA41561C1EBDBD3DB1597A2F83347F0F5E35D69914B148CBB
          1B3333061EE09ADEA0028A28A0028A28A0028A28A0028A28A0028A28A0028A28
          A0028A28A0028A28A0028A28A0028A28A0028A28A002B0FC5DE1CFF849F4392C
          45C3C12021E320FCA58740C3B8FF00F5D6E51401E2BE11D664F87BAFDCE9BAF5
          98863B82BBE7032C9E8C08FBC9F4FF00EB57B2DBDC45756F1CF6F22CB0C8A191
          D0E4303DC5657897C2DA7F89EC4C3791E26507CA9D47CD19FEA3DAB91F02695E
          26F0E6B377A5DD82FA645199141E51C96E0C6DD89E4E0FE38CE6803B1D6585CD
          D69FA60E7ED12F9B20F48E3C31FCDB60FC4D6BD64E9E86EF58BDD41E3745455B
          6837A953B47CCE707D58E3FE015AD401E35F193FE461B1FF00AF5FFD9DABBFF8
          79FF00222E95FF005CDBFF00436AE03E327FC8C363FF005EBFFB3B577FF0F3FE
          445D2BFEB9B7FE86D4866A6BF0BCFA25D79233344BE74407F7D0EE5FD455EB79
          D2E6DE29E2398E540EA4770464513CD0C1133DC4891C407CCD230000F726B37C
          30E1B438515B7C70B3C51B8E8E8AE4291EA300734C46B5145140051451400514
          5140051451400514514005145140051451400514514005145140051451400514
          5140051451400514514005145140051451400514514005145140051451400514
          5140051451400514514005145140051451400514514005145140051451400514
          51401C678BBC047C59AD5B5D4B7A2DEDE18446CAA9B9D8EE278EC3A8AD0D2344
          D4B4DD362D32DAF61B7B3B72C91C8A9E64CEBB8904938553CFA1A28A00D083C3
          F6313ACB3A35E4E3FE5B5DB79AC0FA8CF0BF8015A74514005145140051451400
          5145140051451400514514005145140051451400514514005145140051451400
          5145140051451400514514005145140051451400514514005145140051451400
          51451400514514005145140051451401FFD9}
        Stretch = True
      end
      object QRImage3: TQRImage
        Left = 6
        Top = 753
        Width = 147
        Height = 34
        Size.Values = (
          74.965277777777800000
          13.229166666666700000
          1660.260416666670000000
          324.114583333333000000)
        XLColumn = 0
        Center = True
        Picture.Data = {
          0A544A504547496D61676523280000FFD8FFE000104A46494600010100000100
          010000FFDB0043000B08080A08070B0A090A0D0C0B0D111C12110F0F1122191A
          141C29242B2A282427272D3240372D303D302727384C393D43454849482B364F
          554E465440474845FFDB0043010C0D0D110F1121121221452E272E4545454545
          4545454545454545454545454545454545454545454545454545454545454545
          45454545454545454545454545FFC0001108009601C103012200021101031101
          FFC4001F0000010501010101010100000000000000000102030405060708090A
          0BFFC400B5100002010303020403050504040000017D01020300041105122131
          410613516107227114328191A1082342B1C11552D1F02433627282090A161718
          191A25262728292A3435363738393A434445464748494A535455565758595A63
          6465666768696A737475767778797A838485868788898A92939495969798999A
          A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
          D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
          01010101010101010000000000000102030405060708090A0BFFC400B5110002
          0102040403040705040400010277000102031104052131061241510761711322
          328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
          292A35363738393A434445464748494A535455565758595A636465666768696A
          737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
          A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
          E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F5CA
          28A2800A28A2800A28A2800A28A2803CD3C4DF146F345D6AEB4D874C8418240B
          E6CB216DC319CE063D73D6BA94B1F125DA2C926BD6B6E8C032FD96CB3907DDD8
          FE1C579C7C5FD3BECFE23B7BC51F2DDC0013EACA707F42B5E8FE04D43FB4FC1B
          A6CC4E5D22F25BEA9F2FF4A00B36FA15CA26DB8D77529F9CF2634C8F4CAA03FA
          D4BE1C7924D1A332CB24ACB2CC9BE462CC42CAC0649EBC015A9593E1AFF9032F
          FD779FFF00473D006B514310AA598E001926B81D17E232EB6F75630A2477ED71
          B2D3232AF197C6EC67AAAE491DF1401DF5150DBCC64DC922ED96338603A1F423
          D8FF0088ED535001451450014514500145145001451450014514500145145001
          4514500145145001451450014514500145145001451450014514500145145001
          4514500145145001451450014514500145145001451450014514500145145001
          45145001587A878B34ED33C4367A3DCC9B66B952DBC9C2A1FE107EBCFE9EB5A1
          ABEA9068DA5DCDFDD3011408588CE371EC07B93C5785E8B6177E3FF1A33DD963
          1CAE66B9607EE463F847E8A2803DA74CD79750BC788C2D145265ED2563C5C229
          C311E9CF3EEA41F5AD7ACFD474B4BCB0486122096DC87B69147FA975FBA47B76
          23B82453B49D40EA1685A58FC9BA89BCBB88739F2DC751EE0E4107B8228038FF
          008BBA7FDA7C310DDA8CB5A4E093E8ADC1FD76D51F835A8799A76A3A7B1E6195
          6651ECC307F55FD6BB8F12E9FF00DABE1CD46CF1969606DA3FDA0323F502BC6B
          E17EA474FF0019C1131C25E2340D9F5FBC3F51FAD219EF3593E1AFF9032FFD77
          9FFF00473D6B564F86BFE40CBFF5DE7FFD1CF4C4677C42D60E8FE11BB78DB6CD
          71FE8F1FD5BAFF00E3B9AE03E10693F69D72EB5275CA5A47B10FFB6FFF00D607
          F3A97E30EADE7EAB69A6237CB6D1F9B20CFF001374FC80FD6BB5F871A39D23C2
          16DE60C4D77FE92FFF0002FBA3FEF90290CE9AE216936BC6C1658CE549E87D41
          F63FE07B53A0984D1EEC6D71C3A1EAA7D0D49593657125FEB135C5BE16C61530
          97C7FAF901E71FECAF233DC93E94C46B51451400514514005145140051451400
          5145140051451400514514005145140051451400514514005145140051451400
          5145140051451400514514005145140051451400514514005145140051451400
          514514005145140051451401E3BF163C4DF6CBE4D12D5F30DB1DF3E3F8A4ECBF
          803F99F6AED3E1DF867FE11ED015EE23DB7D798926CF551FC2BF803F993543C5
          FF000D60D5E57D43477169A813BD9738491BAE7FD96CF7FF00F5D64683F10F50
          D06F7FB23C63148A63F97ED257E75F4DC07DE1FED0FD690CF54AC6D5627D3EED
          758B657608BB2EE1419F322FEF01DD97A8F5191E95A96D7305E5BA5C5ACA9343
          20CAC887208FAD4B4C43629526892589C3C6EA19594E4107A115F3BEB31B7867
          C71398C6DFB1DE09500FEEEEDC3F4AF70B56FEC4D496C1CE2C6E989B424711BF
          25A2CFA1E4AFE23B0AF30F8BFA77D9FC476F78A3E5BA80027D594E0FE85690CF
          668A559A24963394750CA477079ACAF0FC890E82649182A24D70CC4F60257CD5
          2F006A3FDA5E0CD3A466CBC49E43FD50E3F901585E23D5BFB2BE1B5C046C4B77
          713DBA7E333EEFFC741A623CE0197C69E391907FD3EEB91FDD8FFF00ACA2BE87
          4458D151000AA3000EC2BC83E0F68E67D56EF55917E4B64F26327FBEDD7F21FF
          00A157AA6A9A8AE9D6C1C21967958470420E0CAE7A0FEA4F6009A00ABAA5CCB7
          370BA55848527906E9E65EB6F17AFB33745FC4F6AD2B6B68ACEDA2B7B7411C31
          285451D80AADA569E6C2DD8CCFE6DDCEDE65C4BFDF7C76F4006001D80157A800
          A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800
          A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800
          A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800ACAD77C3
          7A6F88ED3C8D4600F8FB92AF0E9F43FD3A56AD1401E392D87897E18DDBDC58B7
          DB74876CB8C1287FDE1D50FB8E3F957A1F863C65A678A6DF36AFE55D28CC96B2
          11BD7DC7A8F71FA56FBA2CA8C92287461865619047A1AF36F147C32DB2FF0069
          F859DAD6EE33BC5BAB6D19F543FC27DBA7D2803D06FEC62D46CDEDA7076B7218
          7DE461C8607B107906B99D4B4083C6768961ACC8F0DFE9B27CED0606F0C38619
          CFCAC067D8823B554F09F8B3566B09078934F9A25B69040F78108C363AC8BD40
          E9961C73CE2BA1D241D46FE7D61B1E53A7916A077881C97CF7DC791EC07A9A00
          A7A47845F40864B5D2B559E0B377F33CB68D1D836003F3118C71D31F8D70FF00
          15B4CBBB2B4D3561567D322690990B65BCD762C7700063DBF1AF5DA86F2CEDEF
          ED64B5BB89668251B5D1C6411401C97C3636565E05865593681BE6B867057072
          7279EC02E33D38ADBD2E196FAE4EAF788C85D76DAC2DD618CF723FBCDC13E830
          3D6ADCBA3D84D690DAB5B27D9E0C6C8D78500608181D470383C7159BAFF8D346
          F0E230BCBA0F381C5BC5F339FA8EDF8E28037EB275BF13E93E1E877EA57691B6
          32B10F99DBE8A3F9F4AE2BFB77C5FE353E5E8767FD91A7B70D75292188F638CF
          FDF23F1AD5D13E19E996137DAF5691F56BD27717B8FB80FF00BBCE7F1CD00685
          8F8D60D5F4A7BDD2B4FBCB92BBC9429B000BEAC78E7D064FB57470C82685241D
          1D437E74D3020B53044AB1A6C28A146028C7A552F0E387F0E69A573816D1AF3E
          CA07F4A00D2A28AA5ACEAB6FA269371A85D93E540BB881D58F603DC9C0A0092F
          AF92C620CD1CB2BB9DA91429B9DCFB0FEA7007AD5158759BE50D71711E9A87FE
          595B812498F77618FC97F1A83C26D797BA60D575263F68BEFDEA47DA188FDC41
          F8724F726B7A803323D123595647BDD42561D775DB80DC7A2903F214B268B0BC
          DE68BABF43C7CAB7926DFCB359BA978FBC39A55C3DBDC6A48D321DAC91234854
          FBE062AAC5F13BC2D2C817FB41933FC4F0381F9E28036FFB2EE91B743AC5E8CB
          64AB88DC63D395CFEB4DB0B8BC6D66F6D669E39A08238D8308B6B2B367E5CE70
          7800F41D4556B5F1B7872F582C1AC5A962DB42B36D24FD0E2AC78788B8B59F50
          CE7EDD3B4AA7D507CA9FF8EAA9FC68035A8A28A0028A28A0028A824BDB58559A
          5B985027DE2D2018FAD4706ADA75C922DEFED652BD7CB995B1F91A00B745223A
          C8A1918329EE0E452D0014514500145145001451450014514500145145001451
          450014514330552CC4003924F6A0028A4565750C8C194F420E452D0014514500
          1451450014514500145145001451450014515E75E3FF001A6B1E16D6A186C4DB
          B413C01C2CB113B4E483C823DA803D168AE4FC3326ABAF787ACF52975A9A292E
          149648E188AA9048E32BED5AC34CD4B3FF0021EB93FF006C21FF00E228035A8A
          CE9AD753623C8D4E341DF7DB06CFE4C2A2FB1EB5FF00417B7FFC02FF00ECE803
          5A80000001803A015897726ABA558DC5ECF7B05D241197310B5285B1E8779C7E
          55B740051451401E6BF1675CD4B4CFB0DAD8DE496F0DCA399047C13823F8BAF7
          A77C32F0B69371A141ACDCDAADC5F48EFF003CDF305C310300F00FBF5AEA7C49
          E0ED37C5325BBEA2D3836E182794E17AE339C83E94DD2FC2D2E8964B65A6EAF7
          50DAA3332234513119393C95C9EB401D0D1595FD99A97FD076E3FEFC43FF00C4
          D1FD99A97FD076E3FEFC43FF00C4D006AD66787832E911A3A8431C92C6140C6D
          5591828C7D00A6FF00666A5FF41DB8FF00BF10FF00F135674CD3FF00B36D5A23
          33CECF23CAD23800966249E0003BD005CAF38F8C978D16876368A389E62EC7FD
          D1D3FF001EFD2BD1EB94F889E1E9BC41E1A64B55DF756CFE74683ABE010547BE
          0FE9401BDA3CD0DCE8D6335B00217811900EC368C0A9EEE16B9B39E0494C4F2C
          6C8B22F54246323E95E51F0EFC7B6DA4DB0D175A768A3473E44EFF007533FC0D
          E833D0FBF6AF5A8E449A3592275746190CA720FE3401C75B787B43D3ADFCAD47
          C311AF97C19E284DC2BFFB5C6587D08E3D4D4917853C15AC3482DAD2D5A423E6
          48A46464FF0080E463F2AEC2AA5EE9765A885FB5DBA48C8728FD1D0FAAB0E41F
          A1A00C4D27C03A2689AB47A8D845324D1A9555690B28C8C13CF39C1F5A8BC5BE
          285D166B4D1ED6DDA4BCD454C511460BE4E4ED0DD0F73FA56EC738B2B9B7B195
          DDC4AA443239C925464AB1EE71920F700FA73C027FC543F195891BA0D2A338EB
          805463FF004363F95007A043A3E9F0C2912D95B908A14168C1271EF5435EB0B4
          4D2258E1B5B649AE0ADBC6C225043390B9E9DB39FC2B72B9EF116A30595E5ACD
          72C45BD8C725ECB8F61B107D49738FA5006D4920B7448621BA52311A13D71DCF
          B0E327FA9159E344376376B172F78E7FE592931C2BEC101E7FE044D6778285D6
          A162FAF6A47377A8FCD1AE3886107E545F6EFEF9AE9A491228DA491D51101666
          638000EE4D00558348D3AD4E6DEC2D6238C65215048FCAA492C2D264292DAC0E
          87AAB460835C26A7F18349B59DA2B0B3B8BE553832822353F4CF27F2AA91FC68
          B52E04BA35C2A772B32B11F86050076D79A2E8F6F6F35CB5945088A32CCF0031
          10A393CAE0D731A6EBAFA96AF63E179629647B70B737734B26EDD85DFB0E7920
          3328EA7A55A83C54BE2ED166FB1E9B7715A995639A694A0458C10D264EEFEEE4
          7E3593F0AE26D4752D775E957E7B89B629F4C92CC3F55FCA803D07FB32C3FE7C
          ADBFEFD2FF00851FD9961FF3E56DFF007E97FC2AD579F78A3C53E29B5D6EE60F
          0FE9A2E6CED82ABC9F67693E7DBB88C823B11C50076FFD9961FF003E56DFF7E9
          7FC2A29B44D32E1364B616CCB9CFFAB039FC2B86F01F8F356F10EBF2E9DA9C56
          E1442D2031A15652A40C724FAD7A450063E9FE669DAA4FA7493B4B6CD179F6E6
          572CE801C3A927A804A904F3F37B562F85F571E32D42FEFA7B44169687ECD02B
          FCE1893B8B63D7013FC68F17EA4B62BAB5CA361ED74DF24153D1E67C007D08DA
          0FE3563E1C69DFD9DE0AB1CAE1EE019DFDF71E3F4C500741FD9961FF003E56DF
          F7E97FC28FECCB0FF9F2B6FF00BF4BFE15624758A367738550493E80579337C5
          4F10BB16834385A22728764872BD8FE5401EA3FD9961FF003E56DFF7E97FC2AA
          EA56FA7D869B73746C6DBF731B381E52F240E074F5AF37FF0085A5E26FFA0141
          FF007EE5AEB3C397FAAF8C747336A90C5631A5D27EE9236CC810ABF5278C9E3A
          50055BAD605BDFE99E0A8E1692678E1FB44E1F8551F338C73D554FE0D5D87F66
          587FCF95B7FDFA5FF0AF3CF0393AE7C42D7B5A63BA3873144C7D09C0C7FC057F
          5AF4DA00ABFD9961FF003E56DFF7E97FC291B4AD3D9486B0B520F50615FF000A
          E4FC5BF11E0F0C6AA74F5B06BB98441D984A142939C03C1ED83F8D5AF06F8F2D
          FC5B24D6E2D24B5B98503942DB959781907EA7A5006E3E83A5B85C58C3195042
          B42BE5B2E7AE0AE08A2DA66B3BD8F4D95E4903446486691B2CD838653EA46579
          EE0FB12746B0F58BB8EC757B3B9970120B5B9919B3D000868032D7C409E22F18
          36851DB660D364696794BE564C2ED0BB71FDE6FF00C76BA6FECCB0FF009F2B6F
          FBF4BFE15C1FC25B569AD755D666C996F2E36E7D8727F56FD2BD1A803125B5B7
          5F1269F0DB41144618E4B890C68173C6C5071D8EF63FF01F6ADBACAD2C9B9D53
          54BB3CA8916DA33FECA0C9FF00C79987E15AB400514514005145140051451400
          5796FC67B6261D2AE806C2B49193D867047E3C1FCABD4AB84F8B96DE77845260
          A4982E5189CFDD0411FCC8A007FC26B8F3BC18B1FCB982E244E0F38386E7FEFA
          AEE2BCC3E0C5D0365AADA123292A4A0639E4107FF4115E9CCC114B310AA06492
          7005002D36491228DA491D511465998E001EE6B14EBD2EA04A6836BF6B1D0DDC
          A4A5BAFD0F57FF00808C7B8A747E1E5B99166D6EE1B51941CAC6CBB6043FECC7
          D0FD5B26801B777CFADD8CF6BA4C2658AE2368CDE487644030C657BBFE031EF5
          B30A18A1442725540CFAD53D5F58B2D034E6BCBF93CA81085E064927800014D4
          D76C26B88A282613078C4A648FE64453F74B1ED9E71F43401A34514D97CC30BF
          92544BB4EC2E3201ED9F6A00CEFF00848B4AFB6DE599BD896E2CD77CC8C70557
          1927DF03AE3A54BA66AF69AB445ED9D83A805E2914A4899E9953C8FEB5E096C4
          69FE3A46F132B1F2EEF75D679C9CE727D57383EE2BDE6F34DB6D5123B84731CE
          AB986EE06C3A83CF07A1078E0E41A00D0A2B19352BAD2B116B615A1E02DFC4B8
          43DBF783F80F4E7EEF3D474AD8565750C8432B0C820E411400B4514500150CF7
          96D6AD1ADC5C450990E1048E1771F419EB53310AA589C00324D70FE10D4E5F18
          EA1A9DFEA10C32595BB1B6B5531F0549CB6724E4E025004DE24F875A47895E4B
          CB7736B77272658B051CFAB2F7FC315CA47F0F7C61A0BE743D594C6BCAA47314
          079FEE37CB5E967C3BA4191641A6DB2BAFDD648C291F4C547FF08DE9BFDCB8FF
          00C0B9BFF8AA00F38D1FC5FE2ED2FC556DA2EB319BA79A55568DD143853FC4AC
          BC103AF71C1AF5DAA365A369FA7CAD2DA5A471CCE30D2E32EDF563C9FCEAF500
          6278A2E12D2C6D6E18E1A2BA8DC1EF8192F8FF008007FC335CA7C25B5927B7D5
          B599F992F2E36827A9C727F56FD297E256A05B46B890A95823220B727FE5AC8D
          F7D87B040CB9EE58FA574FE0AD30E93E11D36D9861FCA123FF00BCDF31FE7401
          BD5E4FF142F9C5ADD052C16E6E52DC63A3244BB8FF00E3F27FE3BED5EA93CC96
          D6F24F21C244A5D89EC00C9AF24F88DA7CA9E14D0AE648B0ECF23CCC7A8797E7
          23F3CFE5401EABA640B6BA5DA4084958A14404FB28154FC4B1ACBA3B24C545B3
          4D109F7F4F2BCC5DD9F6C75F6CD51F026B89AEF85AD24DE0DC40A209D73C8651
          8C9FA8C1FC6BA2923496368E45574705595864107B114011258DAC68123B6855
          54602AC60002A0B8D0F4BBBDC6E34DB494B0C12F0A9247D7155A0D0459E16CB5
          1BEB7841F961DEB2228F41BD4903DB3C53DB4679198CBAAEA2EAD9CA095507E0
          55411F81A00C4F199B4F0C7817508F4E822B559FF74A91285059F827EBB73F95
          58F879A77F67782F4F52B879D4CEFF0056391FA62B82F18837B7163A45ACB2B4
          77F7EC543CACE76A911039249E5848DF8D7B0C51AC3124518C2228551E805001
          24890C4F248C151016663D001D4D67DB69AA2D9FEC9A85CAC570CD36E4F2CE4B
          9DD904AFBF1ED8AADE306B83E19BCB7B252F7574BF678941E496E0FE993F8572
          BF0AFC4E6EECDB41BD622EACD4984B7568C1C6DFAAF4FA7D2803752DBC37E043
          25E5CCC619AFA43BEEA7DCED237523206075CE0628B6F1C5A6B770D67E1C8DEF
          AE403991D1A38631FDE662338F40064D6C6BBA35B6BFA4CF6176A0A4832AD8C9
          461D187D2AB785E2B4B6D30DA5B59C5652DBB94B8823CFCAFD7393C90410413D
          88A00E2FE21DBBC361A66891CBE6DDEAD7BE64F285DBE61C8038E781B8003B05
          15E9504296D6F1C118C244A1140EC00C0AF3E933AE7C6445FBD0E936F9F60D8F
          F17FD2BD16802AEA1A8D96996DE76A37315BC04ECDF3300A49EDCD647FC253E1
          4FFA0A699FF7F16A4F14786A3F1459C1693DCBC30C72798CAAB9DE7040EFDB39
          AE63FE14FE95FF003F737FDF3FFD7A00E9E0F10F86AEA5115BDFD84D21C90919
          5663F80AA57174DA2F81350D41D0C334A92CE17182AD213B063B100A8FC2A0D0
          BC0167E19BE6D42CEE54CA232BBA78C90A0F53F787A5607C44D62EAF7C25A6DB
          B2A89B52B82D1AC608DF103F21C67A9CA1C5006CFC29D3CD9F8416E1C61EF266
          979F41F28FE59FC6BB7AA7A5592E9BA4D9D927DDB78523FC862A7B888CF6D2C4
          1DA332215DEBD57231919A00C6D32C6D353D32EAEAFADE2992FE5794891411E5
          FDD4EBDB6AA9FC6B86F83FA711A86AD7EA0F90A05BC67B373B8FE402FE75DEB6
          8570D6A2D1757B98AD44421F2A28E35C263180C5491C77CD5ED2F4BB3D1AC23B
          2D3E110DBC7D1473C9EA49EE6802E579D7C46D5561B0D4D908CAC71D82B03CEE
          73E6483FEF954FCCD7A05CCE2DADE494A96D8A4855EAC7B01EE7A5794F8B2D65
          BFF11E81A0CAC1A7B897ED77814F1BDCF23FE028A40F602803BEF05E9BFD93E1
          2D36D8821FC912383FDE6F98FF003AD8B99D2D6D66B890E12246763EC064D480
          00300600ACAF10FEF6C23B21D6FA64B73FEE9397FF00C7035004BA0DBBDBE8B6
          A25189A45F365CFF007DCEE6FD49AD1A3A514005145140051451400514514005
          6278C348975DF0C5E585B2A34F20531EF6C004303D7F3ADBACEBCD6ADEC6678A
          486EA428A199A1B777551EE40C500725E15F076A9E0E999ED9A2BD7BC8B6CD96
          D91C4C082A73CB1182DD07A74EB5D4AE8BF696126AF39BD607222DBB605FA277
          FAB13F8541FF0009658F97049E45F6CB82042DF6493126464638E7819A9FFE12
          087FE7C752FF00C0293FC280354000000600E8052332A296620281924F402B2F
          FE12087FE7C752FF00C0293FC2BCFBE2478E965B36D1B4F1344F27FC7D1950A3
          2AF50B83CF3DFDBEB401CFF8C7C4375E37F124561A62BC96C8FE55B463FE5A37
          773FE3D87E35EADA168B67E0DF0C34270E228DA5B9931FEB1B193F87602B9DF8
          61E0FF00ECAB11AC5F463EDB74BFBA561CC519FEA7F963DEBA4F135DAA2D9589
          8E5945D4C1A458632EDE52619B81D89DAA7FDEA00E5FC47E36BEF0758E9F60B6
          A92DE4D6FE73C92B1DB19663F2851D8741CF402B574CD5B5ED5FC2A9AD79F6D0
          E21695608612C652B9C86249C0383C019E7AD705F15EF52FB5DB2748A78B6DB6
          313C4D193F31E80D7A47C3C00F8134A046418DBFF436A4061FC48F0AAEBFA547
          AD69A9BEEA18C3154E7CE8BAFE2475FA67DAA87C2BF1879B1AE81A849FBC419B
          476FE25EE9F8751EDC76AEBF4BD623B2B3FB0496B7B23D9BB5B968AD9DD70A70
          BC81FDDDA7F1AF29F1BE90748D686ADA45BDEDADB48E2457781E2F265CE70091
          F88FCA803DDC80CA4300411820F7AC7FEC99F4B632E86CAB19259EC6427CA6FF
          0070FF00CB33F4F97DBBD55F0578A63F14E8AB31C2DE4184B88C766C7DE1EC7B
          7E3E95D1D302869FABDBDFBB438782EE31992DA61B5D3DFD08F7191EF57EB999
          755866F133BB5ADD4D0E9C8628E482DDA40656FBFC81FC2368FF00811F4AD1FF
          0084821FF9F1D4BFF00A4FF0A00ADE35D48E95E11D4AE158AC862F2D08EA19BE
          51FCEBCEBC21F1134AF0CF87E1D3DEC6F2498333CAE9B76B313DB27D303F0AF4
          96F11E9EFBE3960BADEAC8BE4BDABEF62DB88C2E3278563F85324D474E990A4B
          A3DE3A1EAADA73907FF1DA00E721F8C1A0BA9335B5FC4D9E0796AD9FC9AA5FF8
          5BDE1CFEE5FF00FDF81FE35ADBB42FFA1765FF00C151FF00E268DDA17FD0BB2F
          FE0A8FFF001340190BF15B4EBA9843A6697A95ECAC385488039F4EB9FC6B6B4F
          8F5BD65BCED61069969C14B3824DD23FFD747F4FF647E3E95621D5ECED90241A
          5DFC4A0630960EA31F80A97FE12087FE7C752FFC0293FC2803CEFE2D6A508D5F
          49D3A542D6B0013CC89C1209C6076E8A7F3AD21F18F48550A34DBE007007C9FF
          00C556FDEA683A8DCB5C5EF87EE6E266001924D39C938E9DAABFF66F85FF00E8
          5797FF00058FFF00C4D003EC75D3E38D0E7161652C16F24A2091E7651F2E417C
          019FE1247D4D6F6B7A35B6BDA4CFA75D83E54A3AAF55239047D0D50B1D434ED3
          6DC5BD8E937D6F0824EC8AC245193DFA559FF84821FF009F1D4BFF0000A4FF00
          0A00F17B8B4F117C37D60CB0B3471B3616503314EBE847AFB7515DC693F17F4A
          B88D5755B69ACE5039641E6213DF18E47E55D64DACDA5C46639F4DBF9636EAAF
          612107F022B9CBBF0E784EEC92DE1DBF8C939CC56B327E838A405A3F14FC2F8F
          F8FC98FF00DBBBFF00853F4BF1CAF89E59EDBC3D652BBC71EE69AE888D109E07
          4C93EB8F63505AE89E15B36568BC3776CCA00CC9652BFF00E840D6DC1AB595AA
          6CB6D2AFA141FC31E9EEA3F45A607955DEB967A1FC448E7B959AE6DB498C5B46
          B1E325953693CE3F88B1AEABFE172E93FF0040DBEFFC73FF008AAD896CBC3534
          AF2CBE1A99E4762CCC74D7C927A9E94DFECDF0BFFD0AF2FF00E0B1FF00F89A43
          352CE49B5E934BD48DB982CD10DC22C8C0BB332E172074C066FC715C07C42D1E
          E3C31E22B6F1469236ABCBBA418E164EF9F6619FD7D6BD1135DB78A358E3D3F5
          1545002AAD8C80003B0E2AAEABA8E9BAA6993D96A36B7D1DACEBB1E496D24554
          C9E1892303070727A5311A1A16B36FAFE8F6FA8DAF0932F2A7AA30E0A9FA1AAD
          AB21D2EEC6B70A332A2797791A0C9788721C0EE5393F42DED5E71E0ED46E3C0F
          E30B8F0F6A6FFE8B7320557FE10E7EE38F661807F0F4AF60232307A500789785
          3C7965A1EA5ABDFDF5ADC4F71A84BBC18B1855C938E4FA9FD2BA8FF85CBA4FFD
          036FBFF1CFFE2AB7EC747D36C354934CB9D36CDA294196CE4681492BFC519247
          552723FD923D0D6BFF0060E91FF40AB2FF00C074FF000A00E27FE172E93FF40D
          BEFF00C73FF8AA3FE172E93FF40DBEFF00C73FF8AAEDBFB0748FFA05597FE03A
          7F851FD83A47FD02ACBFF01D3FC2803074EF10378E749B84D3ACE6B6B7691619
          A59C8194382E1704F3B78FC45717E39D6ED6DBE23581B88DA4B3D2963CC5163E
          F7DEC0078EEBF957AEDB5ADBD9C7E5DAC11411E73B6240A33EB8159D71E16D0E
          EEE249EE34AB496690EE7778812C7D4D0071FF00F0B9749FFA06DF7FE39FFC55
          1FF0B9749FFA06DF7FE39FFC55759FF086F877FE80B65FF7E451FF00086F877F
          E80B65FF007E45007289F193472D86D3EF947AE10FFECD4B0FC537D526FB3E89
          E1EBCBB988E3730014F6CE3381EF5D5AF83FC3C8C19746B2C8391FB95AD4B7B5
          B7B48FCBB5822853FBB1A051F90A00A3A55A5FAC62E358B859AEDB9F2A25C450
          FB2F73D7193FA5793378BACAC7E266A1AD5DC52DC4519786110E3B0080F24718
          07F3AF6CAC53E0FF000F3124E8D6449EBFB91401C9FF00C2E5D27FE81B7DFF00
          8E7FF155D659B4FACDD69BA93DB982D520696357705CBB8014903FD92DDFBD1F
          F086F877FE80B65FF7E456CAAAA2855015546001D00A005A28A2800A28A2800A
          28A2800A28A2800AE4FC61773D9E83AE1B48A496795121558D0B1F98609C0F41
          935D65559B4F49A5924F3668CC800608F806803C24EB9AC9D23C3B6D158DDE34
          E98CB03F96C44E73940BC7385DC3E95EF96F30B8B78A60ACA2440E158608C8CE
          08EC6B2E3F0CD9450D9448F7023B020DB2F9A7F77F295E3D782473EB52DF2C1A
          6D94D79777F731C10A977632741F975A00CFF1AF8A63F0B68AD30C35E4F94B78
          CF76C7DE3EC3BFE1EB5E69F0F3C2F2F89B5A7D5F54DF2DAC12798ED273F6897A
          E09EE0753F80ACD7FED0F889E2F58A26902B70BE636EF2211D49FCFF00126BDD
          74CD36DB47D3A0B1B28C47042BB547AFA93EE4F2690CB75916205E6BD7F78794
          B702D223EE3E6908FC4A8FF8055FBEBB4B0B1B8BA97EE411B487F019AA1A5691
          25BE9B0ACD733ACEC3CC9423E0798C77376F526988F30F8C9FF231587FD7A7FE
          CED5E81F0F3FE445D2BFEB9B7FE86D5E79F1761F275FB11E649266D73991B27E
          F357A1FC3CFF0091174AFF00AE6DFF00A1B5219A1684DB788EFEDC9C25CC4972
          83FDA1F23FF24FCFDEADEA7A6DB6B1A74F637B189209976B0F4F423DC1E4550D
          6A2DBA969575E64910F35ADDD91B076B8E33FF000354FCEAFF00D83FE9EEEBFE
          FE7FF5A988F0C865D43E1AF8C8AC80C8A9C381C0B884F71EFF00C88AF69B8D76
          DFFB05752B3659D675516E33F7DD8E157DBE6383E9CFA551D7BC1763E21FB29B
          D9A766B7903862D9257BAFD0E2A41E1755D4D275BC985AA334E20F49C8DBBC1F
          4DB9E31D493401A9A6590D3AC22B7DFBDC65A490F577272CC7EA49356EAA7D83
          FE9EEEBFEFE7FF005A83A7E47FC7DDD7FDFCFF00EB50073FA47FC4C3C472DD1C
          945324E3F13E4C647B6D8E43FF0003EF5D5D62A786A2B7726CAFEF6D14AA26C8
          9D08C2AED1F7949E9EFD49F5A93FB127FF00A0DEA7FF007D45FF00C45006B515
          93FD893FFD06F53FFBEA2FFE228FEC49FF00E837A9FF00DF517FF11401AD4564
          FF00624FFF0041BD4FFEFA8BFF0088A3FB127FFA0DEA7FF7D45FFC45006B5159
          3FD893FF00D06F53FF00BEA2FF00E228FEC49FFE837A9FFDF517FF0011401AD4
          564FF624FF00F41BD4FF00EFA8BFF88A3FB127FF00A0DEA7FF007D45FF00C450
          06B51593FD893FFD06F53FFBEA2FFE228FEC49FF00E837A9FF00DF517FF11401
          AD4564FF00624FFF0041BD4FFEFA8BFF0088A3FB127FFA0DEA7FF7D45FFC4500
          6B51593FD893FF00D06F53FF00BEA2FF00E228FEC49FFE837A9FFDF517FF0011
          401AD4C9A18EE219219903C52295756E8C0F045667F624FF00F41BD4FF00EFA8
          BFF88A3FB127FF00A0DEA7FF007D45FF00C450070BE33F0CC9A96972403F79A9
          E929BA26FE2B9B524E3EACBD3EA3FDA1573C21F12B4C7D0A1875EBE16F7B07EE
          D9A40C7CD03A3703AFAFBD75D168016FEDEEE6D4AFAE24B7DDB048C98F986083
          85191D38F6159137C33F0C4F33CAD62EA5D8B10B330033E833C500597D6748F1
          3D948BA55F34B35B32C91CD0C0EDE4C9CED27E5E9D411DC6456D69B752DED845
          3CF6EF6F330C3C4EA41561C1EBDBD3DB1597A2F83347F0F5E35D69914B148CBB
          1B3333061EE09ADEA0028A28A0028A28A0028A28A0028A28A0028A28A0028A28
          A0028A28A0028A28A0028A28A0028A28A0028A28A002B0FC5DE1CFF849F4392C
          45C3C12021E320FCA58740C3B8FF00F5D6E51401E2BE11D664F87BAFDCE9BAF5
          98863B82BBE7032C9E8C08FBC9F4FF00EB57B2DBDC45756F1CF6F22CB0C8A191
          D0E4303DC5657897C2DA7F89EC4C3791E26507CA9D47CD19FEA3DAB91F02695E
          26F0E6B377A5DD82FA645199141E51C96E0C6DD89E4E0FE38CE6803B1D6585CD
          D69FA60E7ED12F9B20F48E3C31FCDB60FC4D6BD64E9E86EF58BDD41E3745455B
          6837A953B47CCE707D58E3FE015AD401E35F193FE461B1FF00AF5FFD9DABBFF8
          79FF00222E95FF005CDBFF00436AE03E327FC8C363FF005EBFFB3B577FF0F3FE
          445D2BFEB9B7FE86D4866A6BF0BCFA25D79233344BE74407F7D0EE5FD455EB79
          D2E6DE29E2398E540EA4770464513CD0C1133DC4891C407CCD230000F726B37C
          30E1B438515B7C70B3C51B8E8E8AE4291EA300734C46B5145140051451400514
          5140051451400514514005145140051451400514514005145140051451400514
          5140051451400514514005145140051451400514514005145140051451400514
          5140051451400514514005145140051451400514514005145140051451400514
          51401C678BBC047C59AD5B5D4B7A2DEDE18446CAA9B9D8EE278EC3A8AD0D2344
          D4B4DD362D32DAF61B7B3B72C91C8A9E64CEBB8904938553CFA1A28A00D083C3
          F6313ACB3A35E4E3FE5B5DB79AC0FA8CF0BF8015A74514005145140051451400
          5145140051451400514514005145140051451400514514005145140051451400
          5145140051451400514514005145140051451400514514005145140051451400
          51451400514514005145140051451401FFD9}
        Stretch = True
      end
    end
  end
end
