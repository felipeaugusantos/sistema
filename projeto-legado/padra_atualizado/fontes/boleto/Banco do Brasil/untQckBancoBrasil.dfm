object frmQckBancoBrasil: TfrmQckBancoBrasil
  Left = 127
  Top = 24
  Width = 988
  Height = 788
  AutoScroll = True
  Caption = 'frmqckBoleto Banco do Brasil'
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
    BeforePrint = QckBoletoBeforePrint
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
      Top = 163
      Width = 861
      Height = 1138
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        2509.131944444444000000
        1898.385416666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object LinhaHorizontal6: TQRShape
        Left = 4
        Top = 272
        Width = 853
        Height = 2
        Size.Values = (
          4.409722222222220000
          8.819444444444440000
          599.722222222222000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal5: TQRShape
        Left = 4
        Top = 153
        Width = 853
        Height = 1
        Size.Values = (
          2.204861111111110000
          8.819444444444440000
          337.343750000000000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal4: TQRShape
        Left = 4
        Top = 124
        Width = 853
        Height = 1
        Size.Values = (
          2.204861111111110000
          8.819444444444440000
          273.402777777778000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal3: TQRShape
        Left = 4
        Top = 93
        Width = 853
        Height = 4
        Size.Values = (
          8.819444444444440000
          8.819444444444440000
          205.052083333333000000
          1880.746527777780000000)
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
        Top = 64
        Width = 853
        Height = 2
        Size.Values = (
          4.409722222222220000
          8.819444444444440000
          141.111111111111000000
          1880.746527777780000000)
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
        Top = 331
        Width = 853
        Height = 5
        Size.Values = (
          11.024305555555600000
          8.819444444444440000
          729.809027777778000000
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
        Caption = '001-9'
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
        Top = 66
        Width = 49
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          145.520833333333300000
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
        Top = 66
        Width = 603
        Height = 13
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          145.520833333333300000
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
        Top = 67
        Width = 89
        Height = 9
        Size.Values = (
          19.843750000000000000
          1481.666666666667000000
          147.725694444444400000
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
        Top = 97
        Width = 78
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          213.871527777777800000
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
        Top = 97
        Width = 70
        Height = 13
        Size.Values = (
          28.663194444444440000
          319.704861111111100000
          213.871527777777800000
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
        Top = 97
        Width = 54
        Height = 13
        Size.Values = (
          28.663194444444440000
          738.628472222222200000
          213.871527777777800000
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
        Top = 97
        Width = 26
        Height = 13
        Size.Values = (
          28.663194444444440000
          915.017361111111100000
          213.871527777777800000
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
        Top = 97
        Width = 96
        Height = 13
        Size.Values = (
          28.663194444444440000
          1047.309027777778000000
          213.871527777777800000
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
        Top = 97
        Width = 60
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          213.871527777777800000
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
        Top = 126
        Width = 56
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          277.812500000000000000
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
        Top = 126
        Width = 34
        Height = 13
        Size.Values = (
          28.663194444444440000
          372.621527777777800000
          277.812500000000000000
          74.965277777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Carteira'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Top = 126
        Width = 34
        Height = 11
        Size.Values = (
          24.253472222222220000
          500.503472222222200000
          277.812500000000000000
          74.965277777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Esp'#233'cie'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Top = 136
        Width = 73
        Height = 17
        Size.Values = (
          37.482638888888900000
          504.913194444444000000
          299.861111111111000000
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
        Top = 126
        Width = 46
        Height = 13
        Size.Values = (
          28.663194444444440000
          698.940972222222200000
          277.812500000000000000
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
        Top = 126
        Width = 23
        Height = 13
        Size.Values = (
          28.663194444444440000
          1298.663194444444000000
          277.812500000000000000
          50.711805555555560000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Top = 128
        Width = 10
        Height = 19
        Size.Values = (
          41.892361111111110000
          1270.000000000000000000
          282.222222222222200000
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
        Top = 126
        Width = 94
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          277.812500000000000000
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
        Top = 155
        Width = 374
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          341.753472222222200000
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
        Top = 155
        Width = 95
        Height = 9
        Size.Values = (
          19.843750000000000000
          1481.666666666667000000
          341.753472222222200000
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
        Top = 204
        Width = 55
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          449.791666666666700000
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
        Top = 248
        Width = 71
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          546.805555555555600000
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
        Top = 275
        Width = 38
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          606.336805555555600000
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
        Top = 320
        Width = 74
        Height = 12
        Size.Values = (
          26.458333333333330000
          4.409722222222222000
          705.555555555555600000
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
        Top = 318
        Width = 74
        Height = 13
        Size.Values = (
          28.663194444444440000
          1503.715277777778000000
          701.145833333333300000
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
        Top = 335
        Width = 53
        Height = 12
        Size.Values = (
          26.458333333333330000
          1556.631944444444000000
          738.628472222222200000
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
        Width = 188
        Height = 1
        Size.Values = (
          2.204861111111110000
          1472.847222222220000000
          445.381944444445000000
          414.513888888889000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 668
        Top = 221
        Width = 188
        Height = 6
        Size.Values = (
          13.229166666666700000
          1472.847222222220000000
          487.274305555556000000
          414.513888888889000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNomeTitular: TQRLabel
        Left = 52
        Top = 276
        Width = 372
        Height = 14
        Size.Values = (
          30.868055555555600000
          114.652777777778000000
          608.541666666667000000
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
        Top = 292
        Width = 797
        Height = 14
        Size.Values = (
          30.868055555555560000
          114.652777777777800000
          643.819444444444400000
          1757.274305555556000000)
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
        Top = 307
        Width = 372
        Height = 14
        Size.Values = (
          30.868055555555600000
          114.652777777778000000
          676.892361111111000000
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
        Height = 240
        Size.Values = (
          529.166666666667000000
          1468.437500000000000000
          74.965277777777800000
          8.819444444444440000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelInformacao1: TQRLabel
        Left = 95
        Top = 46
        Width = 317
        Height = 11
        Size.Values = (
          24.253472222222220000
          209.461805555555600000
          101.423611111111100000
          698.940972222222300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'PAG'#193'VEL EM QUALQUER BANCO AT'#201' O VENCIMENTO'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Top = 96
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          315.295138888889000000
          211.666666666667000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 330
        Top = 95
        Width = 1
        Height = 29
        Size.Values = (
          63.940972222222200000
          727.604166666667000000
          209.461805555556000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape6: TQRShape
        Left = 413
        Top = 95
        Width = 1
        Height = 29
        Size.Values = (
          63.940972222222200000
          910.607638888889000000
          209.461805555556000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape8: TQRShape
        Left = 164
        Top = 124
        Width = 1
        Height = 29
        Size.Values = (
          63.940972222222200000
          361.597222222222000000
          273.402777777778000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 221
        Top = 124
        Width = 1
        Height = 29
        Size.Values = (
          63.940972222222200000
          487.274305555556000000
          273.402777777778000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape12: TQRShape
        Left = 578
        Top = 124
        Width = 1
        Height = 29
        Size.Values = (
          63.940972222222200000
          1274.409722222220000000
          273.402777777778000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape16: TQRShape
        Left = 668
        Top = 245
        Width = 188
        Height = 6
        Size.Values = (
          13.229166666666700000
          1472.847222222220000000
          540.190972222222000000
          414.513888888889000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape17: TQRShape
        Left = 312
        Top = 124
        Width = 1
        Height = 29
        Size.Values = (
          63.940972222222200000
          687.916666666667000000
          273.402777777778000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel40: TQRLabel
        Left = 7
        Top = 136
        Width = 145
        Height = 17
        Size.Values = (
          37.482638888888900000
          15.434027777777800000
          299.861111111111000000
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
        Top = 95
        Width = 1
        Height = 29
        Size.Values = (
          63.940972222222200000
          1031.875000000000000000
          209.461805555556000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel42: TQRLabel
        Left = 440
        Top = 105
        Width = 10
        Height = 17
        Size.Values = (
          37.482638888888890000
          970.138888888888900000
          231.510416666666700000
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
        Top = 711
        Width = 853
        Height = 6
        Size.Values = (
          13.229166666666700000
          6.614583333333330000
          1567.656250000000000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRImage2: TQRImage
        Left = 7
        Top = 2
        Width = 122
        Height = 30
        Size.Values = (
          66.145833333333300000
          15.434027777777800000
          4.409722222222220000
          268.993055555556000000)
        XLColumn = 0
        Picture.Data = {
          07544269746D61702A340000424D2A3400000000000036000000280000007E00
          0000230000000100180000000000F43300000000000000000000000000000000
          000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F5FF00FAFE00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FAFE00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F5FF18E3D9
          38C6AB08F2F100FAFE00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00FAFE0FECE748B79438C6AB04F8F700FAFE00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000FAFE20DBCDA5641479
          8B5318E3D900FAFE00FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FAFE
          20DBCD798B53B65602AE5D0D57A9800FECE700FAFE00FAFE00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F5FF000000FAFE20DBCDAE5D0DBE4F009275
          3048B79406F4F500FAFE00F2FF00F2FF00F5FF00FAFE0AEFEE48B7949D6C21B6
          5602AE5D01AE5D01B656028481432AD3BF00FAFE00FAFE00F5FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F5FF000000FAFE20DBCDAE5D0DB65602B65602B65602
          798B532AD3BF00F2FF00FAFE00FAFE20DBCD798B53B65602B65602AE5D01B656
          02B65602AE5D01BE4F00A5641457A9800FECE700FFFF00FAFE00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF000000F5FF14E7E0798B53B65602B65602BE4F00C8470162
          9F7000FFFF04F8F748B7949D6C21BE4F00B65602AE5D01B656029D6C21927530
          AE5D0DB65602B65602BE4F008481432AD3BF00FAFE00FFFF00F5FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF000000F2FF00FAFE14E7E0629F70AE5D0DAE5D0D57A98014E7E020DB
          CD6E9561B65602BE4F00AE5D01B65602BE4F008481432AD3BF14E7E057A980AE
          5D0DB65602B65602BE4F00A3662157A9800FECE700FFFF00FAFE00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          000000F2FF00F2FF00FAFE04F8F738C6AB2AD3BF04F8F738C6AB927530BE4F00
          AE5D01AE5D01BE4F00A5641457A98014E7E000FFFF00FFFF04F8F738C6AB8481
          43AE5D0DAE5D01B65602BE4F00798B532AD3BF04F8F700FAFE00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F2FF00F2FF00FAFE00FFFF18E3D9629F70AE5D0DB65602AE5D01AE5D01B6
          56028481432AD3BF00FAFE00FFFF00F2FF00F2FF00FFFF00FFFF38C6AB9D6C21
          AE5D01AE5D01AE5D01BE4F00A3662157A9800FECE700FFFF00FAFE00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F5FF
          00FFFF08F2F148B794927530BE4F00B65602AE5D01BE4F00AE5D0D57A9800FEC
          E718E3D92AD3BF04F8F700FFFF00F5FF0FECE748B794848143A56414AE5D01AE
          5D01AE5D01AE5D01B65602AE5D01798B532AD3BF00FFFF00FAFE00F2FF00F2FF
          00F2FF00FAFE00FAFE00FAFE00FAFE00FAFE00FAFE00F2FF00F2FF00FAFE00FA
          FE00F2FF00F2FF00F2FF00FAFE00FAFE00F5FF00FAFE00F5FF00F2FF00F2FF00
          FAFE00FAFE00F5FF00F2FF00FAFE00FFFF00FFFF00FAFE00F5FF00F2FF00F2FF
          00FAFE00FFFF00FFFF00FAFE00F5FF00F2FF00F2FF00F5FF00FAFE00FAFE00FA
          FE00FAFE00F2FF00F2FF00F2FF00F5FF00FFFF00FFFF00FFFF00FAFE00F2FF00
          F2FF00F5FF00FAFE00FAFE00FAFE00FAFE00FAFE00F5FF00F5FF00F2FF00F5FF
          00FAFE00F2FF00F2FF00F5FF00FAFE00FAFE00FAFE00F2FF00F2FF00F2FF00FA
          FE00FAFE00FAFE00FAFE00FAFE00FAFE00F5FF00F2FF00F5FF00FAFE00FAFE00
          F5FF00F5FF00FAFE00FAFE00FAFE00F5FF00F2FF000000F5FF00FAFE2AD3BF6E
          9561AE5D0DB65602AE5D01AE5D01AE5D0D92753038C6AB0FECE748B7949D6C21
          A5641457A9800AEFEE00FFFF38C6ABBE4F00C84701AE5D01AE5D01AE5D01AE5D
          01AE5D01AE5D01AE5D01BE4F009D6C2157A98018E3D900F2FF00F2FF00F5FF06
          F4F506F4F506F4F506F4F506F4F504F8F700FFFF00F2FF08F2F106F4F500F5FF
          00F5FF00F2FF06F4F506F4F508F2F104F8F706F4F500F5FF00F5FF08F2F106F4
          F500F5FF00FAFE04F8F718E3D920DBCD0AEFEE00FAFE00F5FF00FFFF0AEFEE20
          DBCD20DBCD08F2F100FFFF00F2FF00F2FF00F2FF06F4F508F2F108F2F100FAFE
          00FFFF00F5FF00FAFE00FAFE14E7E020DBCD14E7E000FAFE00FAFE00F2FF00F2
          FF06F4F506F4F506F4F506F4F506F4F504F8F700FFFF00F2FF08F2F108F2F100
          F5FF00F5FF00F5FF08F2F106F4F506F4F500F2FF00F2FF00F5FF06F4F506F4F5
          08F2F108F2F108F2F108F2F104F8F700FAFE00F2FF06F4F506F4F500F2FF06F4
          F506F4F508F2F108F2F106F4F500F5FF000000F5FF04F8F7629F70C84701BE4F
          00AE5D01AE5D01AE5D0192753018E3D900FFFF48B794BE4F00BE4F00B65602B6
          5602798B532AD3BF14E7E057A980A56414BE4F00AE5D01AE5D01AE5D01AE5D01
          AE5D01AE5D01AE5D01C84701BE4F0048B79400F2FF00FAFE06F4F548B794798B
          53798B53848143798B536E956138C6AB18E3D9629F706E956114E7E000FFFF14
          E7E0629F70798B5338C6AB798B5348B79400FFFF2AD3BF798B53798B532AD3BF
          08F2F1629F709D6C219D6C2184814338C6AB00FFFF2AD3BF798B539D6C219275
          30798B532AD3BF00FAFE00F5FF48B794798B53798B538481436E95612AD3BF00
          FAFE04F8F748B7949275309D6C2192753057A9800AEFEE00FFFF20DBCD6E9561
          798B53798B53848143798B53629F7020DBCD08F2F157A980798B5320DBCD00FF
          FF48B794848143798B536E956118E3D900FFFF0AEFEE57A980798B53798B5379
          8B53848143848143629F7018E3D920DBCD798B5357A98018E3D957A980798B53
          798B5384814348B79400FAFE000000F2FF00F5FF14E7E057A980A36621BE4F00
          AE5D01AE5D01A56414629F7018E3D914E7E06E9561B65602B65602AE5D01BE4F
          00A5641448B79400FAFE20DBCD848143B65602B65602AE5D01AE5D01AE5D01B6
          5602BE4F009D6C2157A98014E7E000F2FF00FAFE06F4F5798B53C84701B65602
          9D6C21A56414BE4F00A5641457A980848143BE4F0057A9800AEFEE48B794B656
          02AE5D0157A980BE4F006E956100FAFE6E9561C84701BE4F0048B79448B794C8
          47019275306E9561C84701A3662120DBCD848143C847016E95616E9561C84701
          8481430AEFEE00FFFF6E9561C847019D6C21848143BE4F009D6C2118E3D92AD3
          BFAE5D0DAE5D0D629F709D6C21C8470157A98000FFFF2AD3BFAE5D0DBE4F00A5
          6414927530AE5D0DC847019275302AD3BF848143C8470138C6AB0AEFEE9D6C21
          B65602A56414BE4F0057A9800FECE738C6ABAE5D0DBE4F00798B536E95616E95
          61927530C847016E956138C6ABBE4F00798B532AD3BF9D6C21C8470184814379
          8B5348B79400F5FF000000F2FF00F2FF00FAFE00FFFF2AD3BF848143BE4F00B6
          5602AE5D01B6560292753038C6AB04F8F738C6AB9D6C21BE4F00AE5D01AE5D01
          AE5D01798B5320DBCD04F8F757A980AE5D0DB65602AE5D01B65602B65602798B
          5320DBCD00FFFF00FAFE00F2FF00FAFE08F2F16E9561C8470184814314E7E020
          DBCD927530C84701798B5357A980AE5D0DA564149275309D6C21BE4F006E9561
          2AD3BFB65602629F7014E7E09D6C21BE4F00A5641448B794798B53C8470138C6
          AB0FECE7798B53A3662157A980AE5D0DA3662118E3D918E3D9A56414AE5D0D20
          DBCD00FFFF629F70BE4F0057A98006F4F5798B53C8470157A98057A980C84701
          6E956104F8F757A980BE4F00798B5300FAFE20DBCDA56414B6560257A98006F4
          F548B794AE5D0DB65602629F70798B53AE5D0D2AD3BF38C6ABBE4F0057A98048
          B794AE5D0DAE5D0D9275309D6C21B6560284814306F4F500FFFF00FAFE48B794
          C847019D6C2148B794AE5D01798B5320DBCD927530AE5D0D2AD3BF00FAFE00F5
          FF00F2FF000000F2FF00F2FF00F2FF00F5FF00FFFF0FECE757A980A56414B656
          02AE5D01B65602AE5D0D629F700FECE714E7E06E9561B65602B65602AE5D01B6
          56029D6C2148B79404F8F72AD3BF848143BE4F00A3662148B7940FECE700FFFF
          00F5FF00F2FF00F2FF00FAFE08F2F16E9561C8470184814300FAFE08F2F1798B
          53C8470184814338C6ABA56414A36621629F70927530BE4F0048B79420DBCDAE
          5D01629F7048B794B65602AE5D0D9D6C2148B794798B53BE4F0038C6AB00FFFF
          20DBCD20DBCD48B794B6560292753018E3D914E7E09D6C21AE5D0D2AD3BF00FF
          FF629F70BE4F00629F7004F8F7629F70BE4F006E95616E9561BE4F00629F7000
          FAFE48B794BE4F00798B5304F8F720DBCDA56414BE4F0048B79400FFFF2AD3BF
          A36621BE4F00629F70798B53A5641448B794927530A5641418E3D920DBCDA564
          14A36621629F70927530BE4F0057A98000FFFF14E7E048B7949D6C21C847016E
          956138C6ABAE5D01798B5320DBCD927530AE5D0D2AD3BF00FFFF00F5FF00F2FF
          000000F2FF00F2FF00F2FF00F2FF00F5FF00FAFE00FAFE2AD3BF848143B65602
          B65602AE5D01B6560292753038C6AB04F8F738C6AB9D6C21BE4F00AE5D01AE5D
          01B6560284814320DBCD0FECE748B7942AD3BF00FAFE00FAFE00F2FF00F2FF00
          F2FF00F2FF00FAFE08F2F16E9561C847019D6C2148B79457A980A56414AE5D0D
          48B79408F2F192753092753020DBCD848143B6560220DBCD20DBCDAE5D0D8481
          43927530A564146E95619D6C2148B794798B53BE4F0038C6AB00FFFF00FFFF00
          FFFF2AD3BFB6560292753018E3D914E7E0927530AE5D0D2AD3BF00FFFF629F70
          BE4F00629F7004F8F7629F70BE4F006E95616E9561BE4F00629F7000FAFE48B7
          94BE4F00798B5304F8F720DBCDA56414AE5D01798B5348B794798B53B6560292
          753038C6AB848143AE5D0D629F70848143A5641448B7940AEFEE927530927530
          20DBCD798B53B656022AD3BF38C6AB927530BE4F00B656026E956114E7E02AD3
          BFB65602798B5320DBCD927530AE5D0D2AD3BF00FAFE00F2FF00F2FF000000F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FFFF0AEFEE57A980A56414B6
          5602AE5D01B65602AE5D0D629F700FECE70FECE76E9561AE5D0DAE5D01AE5D01
          B65602A5641457A98008F2F100FFFF00F5FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00FAFE08F2F16E9561BE4F00AE5D01AE5D0DBE4F00BE4F00798B530AEFEE00
          FAFE629F70A56414629F70AE5D0D8481430FECE72AD3BFAE5D0DA56414AE5D01
          629F7048B794AE5D0D48B794798B53BE4F0038C6AB00FAFE20DBCD20DBCD38C6
          ABAE5D0192753014E7E018E3D9927530B656022AD3BF00FFFF629F70BE4F0062
          9F7000FAFE57A980BE4F00629F70629F70BE4F0057A98000FAFE48B794BE4F00
          84814304F8F720DBCDA56414AE5D01AE5D0DB65602BE4F00AE5D0D48B79408F2
          F1848143B6560238C6AB18E3D9A36621AE5D0D18E3D957A980A564146E95619D
          6C2192753020DBCD9D6C21BE4F009275302AD3BF00FAFE00FFFF38C6ABB65602
          798B5320DBCD927530AE5D0D2AD3BF00FAFE00F2FF00F2FF000000F2FF00F2FF
          00F2FF00F2FF00F5FF00FAFE06F4F538C6AB48B79408F2F120DBCD848143B656
          02B65602AE5D01B6560292753038C6AB00FAFE38C6AB9D6C21B65602AE5D01AE
          5D01B65602798B532AD3BF00FAFE00FAFE00F2FF00F2FF00F2FF00F2FF00FAFE
          08F2F16E9561C8470192753048B79457A980AE5D0DA3662138C6AB00FFFF38C6
          ABA56414AE5D0DBE4F00629F7000FAFE2AD3BFAE5D0DB65602AE5D0D2AD3BF48
          B794AE5D0D48B7946E9561C8470148B79414E7E08481439D6C2148B794AE5D0D
          AE5D0D20DBCD20DBCDA56414AE5D0D20DBCD00FFFF629F70BE4F00629F700FEC
          E7798B53C8470148B79448B794C84701798B5306F4F5629F70C84701798B5300
          FAFE20DBCDA56414AE5D01798B5338C6AB798B53B6560284814320DBCD848143
          BE4F0038C6AB18E3D9A36621BE4F002AD3BF20DBCDA56414AE5D0DBE4F0057A9
          8020DBCDBE4F00B65602629F7000FAFE00FAFE00FAFE38C6ABB65602798B5320
          DBCD927530AE5D0D2AD3BF00FAFE00F2FF00F2FF000000F2FF00F2FF00F2FF00
          F5FF00FFFF18E3D9629F70AE5D0DBE4F00798B5320DBCD08F2F157A980A56414
          B65602AE5D01B65602AE5D0D629F700FECE718E3D96E9561AE5D01B65602AE5D
          01B656029D6C2148B79408F2F100FFFF00F5FF00F2FF00F2FF00FAFE08F2F16E
          9561C84701798B5300FFFF0FECE7927530C847016E956100FAFE14E7E0927530
          C84701B6560238C6AB00FFFF2AD3BFB65602BE4F0084814306F4F557A980C847
          0138C6AB38C6ABB656029D6C21848143BE4F0084814314E7E0798B53BE4F0084
          8143848143BE4F006E956106F4F500FFFF6E9561C84701A36621927530BE4F00
          92753014E7E020DBCD9D6C21B65602848143AE5D0DAE5D0D38C6AB00FFFF20DB
          CDA56414B6560248B79400FFFF38C6ABAE5D0DB6560248B794798B53C847019D
          6C219D6C21C8470192753014E7E00FECE7927530C84701BE4F0038C6AB0AEFEE
          927530BE4F00A5641492753084814320DBCD2AD3BFC8470184814320DBCDA366
          21BE4F002AD3BF00FFFF00F2FF00F2FF000000F2FF00F2FF00FFFF00FAFE38C6
          AB927530B65602B65602AE5D01BE4F00A5641448B79400FAFE2AD3BF848143B6
          5602AE5D01B65602BE4F009275302AD3BF00FAFE48B7949D6C21BE4F00AE5D01
          B65602B65602798B5320DBCD00FFFF00FAFE00F2FF00FAFE06F4F5798B53C847
          019D6C2138C6AB629F70AE5D0DC84701629F7000FAFE00FAFE38C6AB629F7057
          A9800FECE700FAFE18E3D957A980629F702AD3BF00FAFE2AD3BF629F7020DBCD
          04F8F748B794798B53848143629F7018E3D900FFFF18E3D957A9808481438481
          4357A98014E7E000FAFE00FAFE38C6AB629F706E95616E956157A98020DBCD00
          FAFE00FAFE2AD3BF6E95618481436E956138C6AB06F4F500FFFF2AD3BFAE5D0D
          B65602798B5338C6AB798B53BE4F00A5641438C6AB38C6AB629F70629F70629F
          7057A98020DBCD00F5FF04F8F738C6AB629F7057A98014E7E000FAFE18E3D957
          A980629F70629F70629F7018E3D914E7E0629F7038C6AB14E7E048B79457A980
          18E3D900F5FF00F2FF00F2FF000000F2FF00F5FF20DBCD6E9561A56414BE4F00
          AE5D01AE5D01AE5D01AE5D01B65602BE4F00798B5320DBCD06F4F557A980AE5D
          0DBE4F00AE5D01B65602AE5D0D629F7014E7E020DBCD6E9561AE5D0DAE5D01B6
          5602B656029D6C2157A98014E7E000F5FF00FAFE06F4F5798B53C84701AE5D0D
          AE5D0DB65602B656029275302AD3BF00FAFE00F2FF00F5FF04F8F700F5FF00F2
          FF00F2FF00F2FF04F8F704F8F700FAFE00F2FF06F4F504F8F700F5FF00F5FF00
          FAFE08F2F10FECE704F8F700F5FF00F2FF00FAFE04F8F70AEFEE0FECE704F8F7
          00F5FF00F2FF00F2FF04F8F704F8F704F8F704F8F704F8F700FAFE00F2FF00F5
          FF00FAFE06F4F50AEFEE06F4F500FAFE00F5FF00FFFF2AD3BFA56414B65602AE
          5D0DAE5D0DAE5D0DAE5D0D6E95610AEFEE00FAFE04F8F704F8F704F8F700FAFE
          00FAFE00F2FF00F2FF00F5FF04F8F700FAFE00F5FF00F2FF00FAFE00FAFE04F8
          F704F8F704F8F700F2FF00F2FF04F8F704F8F700F5FF04F8F704F8F700F2FF00
          F2FF00F2FF00F2FF000000F5FF04F8F7629F70BE4F00BE4F00AE5D01AE5D01AE
          5D01AE5D01AE5D01AE5D01AE5D01B65602A5641457A98008F2F12AD3BF848143
          B65602AE5D01BE4F00B6560238C6AB00FFFF38C6ABA56414AE5D01AE5D01AE5D
          01BE4F00BE4F0048B79400FAFE00F5FF06F4F52AD3BF57A98048B79448B79448
          B79448B79418E3D900F5FF00F5FF00F2FF00F2FF00F5FF00F5FF00F2FF00F2FF
          00F2FF00F5FF00F5FF00F5FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2FF00F5
          FF00F5FF00F5FF00F2FF00F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00
          F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F5FF00F2FF00F2FF00F2FF00F2FF
          00F5FF00F5FF00F5FF00F5FF00F2FF00F5FF0FECE748B79448B79448B79448B7
          9448B79438C6AB0AEFEE00F5FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00
          F2FF00F2FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2FF00F2FF00F5FF00F5FF
          00F5FF00F2FF00F2FF00F5FF00F5FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2
          FF00F2FF000000F2FF00FAFE18E3D9629F70A56414B65602AE5D01AE5D01AE5D
          01AE5D01AE5D01AE5D01AE5D01C84701A564142AD3BF00FFFF0FECE7629F70AE
          5D0D8481432AD3BF0FECE757A9809D6C21AE5D01AE5D01AE5D01B65602927530
          48B7940FECE700F5FF00F2FF00F2FF00FAFE00FFFF00FFFF00FFFF00FFFF00FF
          FF00FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F5FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          000000F2FF00F2FF00FAFE00FAFE38C6AB848143B65602AE5D01AE5D01AE5D01
          AE5D01AE5D01A56414798B532AD3BF00F5FF00F5FF00FAFE08F2F120DBCD0FEC
          E718E3D9798B53B65602AE5D01AE5D01AE5D01AE5D0D6E956120DBCD00FFFF00
          FAFE00F2FF00F2FF00F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F2FF00F2FF00F5FF00FFFF18E3D9629F70A56414B65602AE5D01AE5D01AE
          5D0184814318E3D900FFFF00FAFE00F2FF00F5FF00FFFF06F4F548B7949D6C21
          B65602AE5D01AE5D01B6560292753048B79404F8F700FFFF00FAFE00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF
          00F2FF00F2FF00F2FF00FAFE00FAFE38C6AB848143B65602B65602AE5D01AE5D
          0D798B532AD3BF00FFFF00FFFF00FFFF2AD3BF798B53B65602B65602AE5D01B6
          5602B65602798B5318E3D908F2F157A98057A9800FECE700FFFF00F5FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00FAFE00FFFF18E3D9629F70A56414B65602B65602BE4F00
          A3662148B79418E3D948B794A36621BE4F00AE5D01AE5D01B65602A3662157A9
          800AEFEE2AD3BF848143B65602BE4F00798B5320DBCD00F5FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F5FF00FFFF00FAFE38C6AB927530B65602B65602B65602AE
          5D0D927530AE5D0DBE4F00AE5D01B65602B656028481432AD3BF00FFFF00FAFE
          798B53C84701B65602AE5D01BE4F008481430FECE700FAFE00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00FAFE00FFFF18E3D9629F70AE5D0DBE4F00B65602B656
          02AE5D01AE5D01BE4F00A5641457A9800FECE700FFFF00FAFE00F5FF18E3D957
          A9809D6C21B65602BE4F009D6C2114E7E000FAFE00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00FAFE04F8F738C6AB927530B65602AE5D01B65602
          BE4F0084814338C6AB00FAFE00FFFF00F2FF00F2FF00F2FF00FFFF00FAFE2AD3
          BF848143BE4F009D6C2114E7E000FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F5FF00FAFE18E3D9629F70AE5D0DAE5D0D57A9800F
          ECE700FFFF00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FFFF0FECE7
          629F7092753018E3D900FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F5FF00FFFF06F4F538C6AB38C6AB00FAFE00FAFE00F5
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00FFFF06F4F520
          DBCD0AEFEE00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F5FF00FFFF00FFFF00F5FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FAFE00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF0000}
        Stretch = True
      end
      object QRShape13: TQRShape
        Left = 668
        Top = 179
        Width = 188
        Height = 1
        Size.Values = (
          2.204861111111110000
          1472.847222222220000000
          394.670138888889000000
          414.513888888889000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel6: TQRLabel
        Left = 169
        Top = 136
        Width = 32
        Height = 17
        Size.Values = (
          37.482638888888890000
          372.621527777777800000
          299.861111111111100000
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
        Top = 48
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1512.534722222220000000
          105.833333333333000000
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
        Top = 105
        Width = 120
        Height = 17
        Size.Values = (
          37.482638888888900000
          28.663194444444400000
          231.510416666667000000
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
        Top = 105
        Width = 163
        Height = 17
        Size.Values = (
          37.482638888888900000
          346.163194444444000000
          231.510416666667000000
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
        Top = 105
        Width = 65
        Height = 17
        Size.Values = (
          37.482638888888900000
          743.038194444444000000
          231.510416666667000000
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
        Top = 105
        Width = 169
        Height = 17
        Size.Values = (
          37.482638888888900000
          1056.128472222220000000
          231.510416666667000000
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
        Top = 77
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1512.534722222220000000
          169.774305555556000000
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
        Top = 106
        Width = 161
        Height = 17
        Size.Values = (
          37.482638888888900000
          1510.329861111110000000
          233.715277777778000000
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
        Top = 136
        Width = 161
        Height = 17
        Size.Values = (
          37.482638888888900000
          1510.329861111110000000
          299.861111111111000000
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
        Top = 198
        Width = 622
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          436.562500000000000000
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
        Top = 213
        Width = 622
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          469.635416666667000000
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
        Top = 228
        Width = 622
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          502.708333333333000000
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
        Top = 243
        Width = 622
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          535.781250000000000000
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
        Top = 258
        Width = 622
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          568.854166666667000000
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
        Top = 318
        Width = 68
        Height = 13
        Size.Values = (
          28.663194444444440000
          1680.104166666667000000
          701.145833333333300000
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
        Top = 1071
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555600000
          70.555555555555600000
          2361.406250000000000000
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
        Top = 1003
        Width = 854
        Height = 1
        Size.Values = (
          2.204861111111110000
          6.614583333333330000
          2211.475694444440000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape11: TQRShape
        Left = 3
        Top = 871
        Width = 854
        Height = 1
        Size.Values = (
          2.204861111111110000
          6.614583333333330000
          1920.434027777780000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape14: TQRShape
        Left = 3
        Top = 841
        Width = 854
        Height = 1
        Size.Values = (
          2.204861111111110000
          6.614583333333330000
          1854.288194444440000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape15: TQRShape
        Left = 3
        Top = 809
        Width = 854
        Height = 3
        Size.Values = (
          6.614583333333330000
          6.614583333333330000
          1783.732638888890000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape18: TQRShape
        Left = 3
        Top = 742
        Width = 853
        Height = 14
        Size.Values = (
          30.868055555555600000
          6.614583333333330000
          1636.006944444440000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape19: TQRShape
        Left = 3
        Top = 781
        Width = 854
        Height = 3
        Size.Values = (
          6.614583333333330000
          6.614583333333330000
          1721.996527777780000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape20: TQRShape
        Left = 191
        Top = 724
        Width = 12
        Height = 24
        Size.Values = (
          52.916666666666700000
          421.128472222222000000
          1596.319444444440000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape21: TQRShape
        Left = 3
        Top = 1064
        Width = 854
        Height = 4
        Size.Values = (
          8.819444444444440000
          6.614583333333330000
          2345.972222222220000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel7: TQRLabel
        Left = 201
        Top = 724
        Width = 81
        Height = 24
        Size.Values = (
          52.916666666666700000
          443.177083333333000000
          1596.319444444440000000
          178.593750000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '001-9'
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
        Top = 752
        Width = 48
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1658.055555555556000000
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
        Top = 724
        Width = 9
        Height = 24
        Size.Values = (
          52.916666666666700000
          615.156250000000000000
          1596.319444444440000000
          19.843750000000000000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel9: TQRLabel
        Left = 5
        Top = 751
        Width = 82
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1655.850694444444000000
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
        Top = 783
        Width = 49
        Height = 13
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          1726.406250000000000000
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
        Top = 783
        Width = 603
        Height = 13
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          1726.406250000000000000
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
        Top = 784
        Width = 89
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1728.611111111111000000
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
        Top = 812
        Width = 78
        Height = 13
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          1790.347222222222000000
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
        Top = 812
        Width = 70
        Height = 13
        Size.Values = (
          28.663194444444440000
          319.704861111111100000
          1790.347222222222000000
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
        Top = 812
        Width = 54
        Height = 13
        Size.Values = (
          28.663194444444440000
          736.423611111111100000
          1790.347222222222000000
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
        Top = 812
        Width = 26
        Height = 13
        Size.Values = (
          28.663194444444440000
          921.631944444444400000
          1790.347222222222000000
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
        Top = 812
        Width = 96
        Height = 13
        Size.Values = (
          28.663194444444440000
          1047.309027777778000000
          1790.347222222222000000
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
        Top = 812
        Width = 60
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1790.347222222222000000
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
        Top = 842
        Width = 56
        Height = 13
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          1856.493055555556000000
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
        Top = 842
        Width = 34
        Height = 13
        Size.Values = (
          28.663194444444440000
          372.621527777777800000
          1856.493055555556000000
          74.965277777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Carteira'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Top = 842
        Width = 34
        Height = 10
        Size.Values = (
          22.048611111111110000
          500.503472222222200000
          1856.493055555556000000
          74.965277777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Esp'#233'cie'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Top = 852
        Width = 73
        Height = 17
        Size.Values = (
          37.482638888888900000
          507.118055555556000000
          1878.541666666670000000
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
        Top = 842
        Width = 46
        Height = 13
        Size.Values = (
          28.663194444444440000
          698.940972222222200000
          1856.493055555556000000
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
        Top = 843
        Width = 23
        Height = 13
        Size.Values = (
          28.663194444444440000
          1305.277777777778000000
          1858.697916666667000000
          50.711805555555560000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Top = 845
        Width = 10
        Height = 19
        Size.Values = (
          41.892361111111110000
          1270.000000000000000000
          1863.107638888889000000
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
        Top = 843
        Width = 94
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1858.697916666667000000
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
        Top = 872
        Width = 374
        Height = 13
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          1922.638888888889000000
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
        Top = 872
        Width = 95
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1922.638888888889000000
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
        Top = 923
        Width = 55
        Height = 13
        Size.Values = (
          28.663194444444440000
          1479.461805555556000000
          2035.086805555556000000
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
        Top = 970
        Width = 71
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          2138.715277777778000000
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
        Top = 1005
        Width = 38
        Height = 13
        Size.Values = (
          28.663194444444440000
          4.409722222222222000
          2215.885416666667000000
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
        Top = 1054
        Width = 74
        Height = 12
        Size.Values = (
          26.458333333333330000
          11.024305555555560000
          2323.923611111111000000
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
        Top = 1050
        Width = 74
        Height = 13
        Size.Values = (
          28.663194444444440000
          1486.076388888889000000
          2315.104166666667000000
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
        Left = 657
        Top = 1069
        Width = 203
        Height = 12
        Size.Values = (
          26.458333333333330000
          1448.593750000000000000
          2356.996527777778000000
          447.586805555555600000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Autentica'#231#227'o Mec'#226'nica/FICHA DE COMPENSA'#199#195'O'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Top = 921
        Width = 189
        Height = 1
        Size.Values = (
          2.204861111111110000
          1470.642361111110000000
          2030.677083333330000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape24: TQRShape
        Left = 668
        Top = 943
        Width = 189
        Height = 6
        Size.Values = (
          13.229166666666700000
          1472.847222222220000000
          2079.184027777780000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel35: TQRLabel
        Left = 51
        Top = 1006
        Width = 372
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          2218.090277777780000000
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
        Top = 1022
        Width = 806
        Height = 15
        Size.Values = (
          33.072916666666670000
          112.447916666666700000
          2253.368055555556000000
          1777.118055555556000000)
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
        Top = 1039
        Width = 372
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          2290.850694444440000000
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
        Top = 749
        Width = 3
        Height = 255
        Size.Values = (
          562.239583333333000000
          1468.437500000000000000
          1651.440972222220000000
          6.614583333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape27: TQRShape
        Left = 143
        Top = 811
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          315.295138888889000000
          1788.142361111110000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape29: TQRShape
        Left = 330
        Top = 811
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          727.604166666667000000
          1788.142361111110000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape30: TQRShape
        Left = 412
        Top = 811
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          908.402777777778000000
          1788.142361111110000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape31: TQRShape
        Left = 165
        Top = 841
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          363.802083333333000000
          1854.288194444440000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape32: TQRShape
        Left = 220
        Top = 841
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          485.069444444444000000
          1854.288194444440000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape33: TQRShape
        Left = 579
        Top = 841
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          1276.614583333330000000
          1854.288194444440000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape34: TQRShape
        Left = 668
        Top = 967
        Width = 188
        Height = 6
        Size.Values = (
          13.229166666666700000
          1472.847222222220000000
          2132.100694444440000000
          414.513888888889000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape35: TQRShape
        Left = 312
        Top = 841
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          687.916666666667000000
          1854.288194444440000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel44: TQRLabel
        Left = 10
        Top = 850
        Width = 143
        Height = 20
        Size.Values = (
          44.097222222222200000
          22.048611111111100000
          1874.131944444440000000
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
        Top = 811
        Width = 1
        Height = 30
        Size.Values = (
          66.145833333333300000
          1031.875000000000000000
          1788.142361111110000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel45: TQRLabel
        Left = 446
        Top = 822
        Width = 10
        Height = 17
        Size.Values = (
          37.482638888888890000
          983.368055555555600000
          1812.395833333333000000
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
        Top = 715
        Width = 122
        Height = 30
        Size.Values = (
          66.145833333333300000
          15.434027777777800000
          1576.475694444440000000
          268.993055555556000000)
        XLColumn = 0
        Picture.Data = {
          07544269746D61702A340000424D2A3400000000000036000000280000007E00
          0000230000000100180000000000F43300000000000000000000000000000000
          000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F5FF00FAFE00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FAFE00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F5FF18E3D9
          38C6AB08F2F100FAFE00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00FAFE0FECE748B79438C6AB04F8F700FAFE00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000FAFE20DBCDA5641479
          8B5318E3D900FAFE00FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FAFE
          20DBCD798B53B65602AE5D0D57A9800FECE700FAFE00FAFE00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F5FF000000FAFE20DBCDAE5D0DBE4F009275
          3048B79406F4F500FAFE00F2FF00F2FF00F5FF00FAFE0AEFEE48B7949D6C21B6
          5602AE5D01AE5D01B656028481432AD3BF00FAFE00FAFE00F5FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F5FF000000FAFE20DBCDAE5D0DB65602B65602B65602
          798B532AD3BF00F2FF00FAFE00FAFE20DBCD798B53B65602B65602AE5D01B656
          02B65602AE5D01BE4F00A5641457A9800FECE700FFFF00FAFE00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF000000F5FF14E7E0798B53B65602B65602BE4F00C8470162
          9F7000FFFF04F8F748B7949D6C21BE4F00B65602AE5D01B656029D6C21927530
          AE5D0DB65602B65602BE4F008481432AD3BF00FAFE00FFFF00F5FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF000000F2FF00FAFE14E7E0629F70AE5D0DAE5D0D57A98014E7E020DB
          CD6E9561B65602BE4F00AE5D01B65602BE4F008481432AD3BF14E7E057A980AE
          5D0DB65602B65602BE4F00A3662157A9800FECE700FFFF00FAFE00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          000000F2FF00F2FF00FAFE04F8F738C6AB2AD3BF04F8F738C6AB927530BE4F00
          AE5D01AE5D01BE4F00A5641457A98014E7E000FFFF00FFFF04F8F738C6AB8481
          43AE5D0DAE5D01B65602BE4F00798B532AD3BF04F8F700FAFE00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F2FF00F2FF00FAFE00FFFF18E3D9629F70AE5D0DB65602AE5D01AE5D01B6
          56028481432AD3BF00FAFE00FFFF00F2FF00F2FF00FFFF00FFFF38C6AB9D6C21
          AE5D01AE5D01AE5D01BE4F00A3662157A9800FECE700FFFF00FAFE00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F5FF
          00FFFF08F2F148B794927530BE4F00B65602AE5D01BE4F00AE5D0D57A9800FEC
          E718E3D92AD3BF04F8F700FFFF00F5FF0FECE748B794848143A56414AE5D01AE
          5D01AE5D01AE5D01B65602AE5D01798B532AD3BF00FFFF00FAFE00F2FF00F2FF
          00F2FF00FAFE00FAFE00FAFE00FAFE00FAFE00FAFE00F2FF00F2FF00FAFE00FA
          FE00F2FF00F2FF00F2FF00FAFE00FAFE00F5FF00FAFE00F5FF00F2FF00F2FF00
          FAFE00FAFE00F5FF00F2FF00FAFE00FFFF00FFFF00FAFE00F5FF00F2FF00F2FF
          00FAFE00FFFF00FFFF00FAFE00F5FF00F2FF00F2FF00F5FF00FAFE00FAFE00FA
          FE00FAFE00F2FF00F2FF00F2FF00F5FF00FFFF00FFFF00FFFF00FAFE00F2FF00
          F2FF00F5FF00FAFE00FAFE00FAFE00FAFE00FAFE00F5FF00F5FF00F2FF00F5FF
          00FAFE00F2FF00F2FF00F5FF00FAFE00FAFE00FAFE00F2FF00F2FF00F2FF00FA
          FE00FAFE00FAFE00FAFE00FAFE00FAFE00F5FF00F2FF00F5FF00FAFE00FAFE00
          F5FF00F5FF00FAFE00FAFE00FAFE00F5FF00F2FF000000F5FF00FAFE2AD3BF6E
          9561AE5D0DB65602AE5D01AE5D01AE5D0D92753038C6AB0FECE748B7949D6C21
          A5641457A9800AEFEE00FFFF38C6ABBE4F00C84701AE5D01AE5D01AE5D01AE5D
          01AE5D01AE5D01AE5D01BE4F009D6C2157A98018E3D900F2FF00F2FF00F5FF06
          F4F506F4F506F4F506F4F506F4F504F8F700FFFF00F2FF08F2F106F4F500F5FF
          00F5FF00F2FF06F4F506F4F508F2F104F8F706F4F500F5FF00F5FF08F2F106F4
          F500F5FF00FAFE04F8F718E3D920DBCD0AEFEE00FAFE00F5FF00FFFF0AEFEE20
          DBCD20DBCD08F2F100FFFF00F2FF00F2FF00F2FF06F4F508F2F108F2F100FAFE
          00FFFF00F5FF00FAFE00FAFE14E7E020DBCD14E7E000FAFE00FAFE00F2FF00F2
          FF06F4F506F4F506F4F506F4F506F4F504F8F700FFFF00F2FF08F2F108F2F100
          F5FF00F5FF00F5FF08F2F106F4F506F4F500F2FF00F2FF00F5FF06F4F506F4F5
          08F2F108F2F108F2F108F2F104F8F700FAFE00F2FF06F4F506F4F500F2FF06F4
          F506F4F508F2F108F2F106F4F500F5FF000000F5FF04F8F7629F70C84701BE4F
          00AE5D01AE5D01AE5D0192753018E3D900FFFF48B794BE4F00BE4F00B65602B6
          5602798B532AD3BF14E7E057A980A56414BE4F00AE5D01AE5D01AE5D01AE5D01
          AE5D01AE5D01AE5D01C84701BE4F0048B79400F2FF00FAFE06F4F548B794798B
          53798B53848143798B536E956138C6AB18E3D9629F706E956114E7E000FFFF14
          E7E0629F70798B5338C6AB798B5348B79400FFFF2AD3BF798B53798B532AD3BF
          08F2F1629F709D6C219D6C2184814338C6AB00FFFF2AD3BF798B539D6C219275
          30798B532AD3BF00FAFE00F5FF48B794798B53798B538481436E95612AD3BF00
          FAFE04F8F748B7949275309D6C2192753057A9800AEFEE00FFFF20DBCD6E9561
          798B53798B53848143798B53629F7020DBCD08F2F157A980798B5320DBCD00FF
          FF48B794848143798B536E956118E3D900FFFF0AEFEE57A980798B53798B5379
          8B53848143848143629F7018E3D920DBCD798B5357A98018E3D957A980798B53
          798B5384814348B79400FAFE000000F2FF00F5FF14E7E057A980A36621BE4F00
          AE5D01AE5D01A56414629F7018E3D914E7E06E9561B65602B65602AE5D01BE4F
          00A5641448B79400FAFE20DBCD848143B65602B65602AE5D01AE5D01AE5D01B6
          5602BE4F009D6C2157A98014E7E000F2FF00FAFE06F4F5798B53C84701B65602
          9D6C21A56414BE4F00A5641457A980848143BE4F0057A9800AEFEE48B794B656
          02AE5D0157A980BE4F006E956100FAFE6E9561C84701BE4F0048B79448B794C8
          47019275306E9561C84701A3662120DBCD848143C847016E95616E9561C84701
          8481430AEFEE00FFFF6E9561C847019D6C21848143BE4F009D6C2118E3D92AD3
          BFAE5D0DAE5D0D629F709D6C21C8470157A98000FFFF2AD3BFAE5D0DBE4F00A5
          6414927530AE5D0DC847019275302AD3BF848143C8470138C6AB0AEFEE9D6C21
          B65602A56414BE4F0057A9800FECE738C6ABAE5D0DBE4F00798B536E95616E95
          61927530C847016E956138C6ABBE4F00798B532AD3BF9D6C21C8470184814379
          8B5348B79400F5FF000000F2FF00F2FF00FAFE00FFFF2AD3BF848143BE4F00B6
          5602AE5D01B6560292753038C6AB04F8F738C6AB9D6C21BE4F00AE5D01AE5D01
          AE5D01798B5320DBCD04F8F757A980AE5D0DB65602AE5D01B65602B65602798B
          5320DBCD00FFFF00FAFE00F2FF00FAFE08F2F16E9561C8470184814314E7E020
          DBCD927530C84701798B5357A980AE5D0DA564149275309D6C21BE4F006E9561
          2AD3BFB65602629F7014E7E09D6C21BE4F00A5641448B794798B53C8470138C6
          AB0FECE7798B53A3662157A980AE5D0DA3662118E3D918E3D9A56414AE5D0D20
          DBCD00FFFF629F70BE4F0057A98006F4F5798B53C8470157A98057A980C84701
          6E956104F8F757A980BE4F00798B5300FAFE20DBCDA56414B6560257A98006F4
          F548B794AE5D0DB65602629F70798B53AE5D0D2AD3BF38C6ABBE4F0057A98048
          B794AE5D0DAE5D0D9275309D6C21B6560284814306F4F500FFFF00FAFE48B794
          C847019D6C2148B794AE5D01798B5320DBCD927530AE5D0D2AD3BF00FAFE00F5
          FF00F2FF000000F2FF00F2FF00F2FF00F5FF00FFFF0FECE757A980A56414B656
          02AE5D01B65602AE5D0D629F700FECE714E7E06E9561B65602B65602AE5D01B6
          56029D6C2148B79404F8F72AD3BF848143BE4F00A3662148B7940FECE700FFFF
          00F5FF00F2FF00F2FF00FAFE08F2F16E9561C8470184814300FAFE08F2F1798B
          53C8470184814338C6ABA56414A36621629F70927530BE4F0048B79420DBCDAE
          5D01629F7048B794B65602AE5D0D9D6C2148B794798B53BE4F0038C6AB00FFFF
          20DBCD20DBCD48B794B6560292753018E3D914E7E09D6C21AE5D0D2AD3BF00FF
          FF629F70BE4F00629F7004F8F7629F70BE4F006E95616E9561BE4F00629F7000
          FAFE48B794BE4F00798B5304F8F720DBCDA56414BE4F0048B79400FFFF2AD3BF
          A36621BE4F00629F70798B53A5641448B794927530A5641418E3D920DBCDA564
          14A36621629F70927530BE4F0057A98000FFFF14E7E048B7949D6C21C847016E
          956138C6ABAE5D01798B5320DBCD927530AE5D0D2AD3BF00FFFF00F5FF00F2FF
          000000F2FF00F2FF00F2FF00F2FF00F5FF00FAFE00FAFE2AD3BF848143B65602
          B65602AE5D01B6560292753038C6AB04F8F738C6AB9D6C21BE4F00AE5D01AE5D
          01B6560284814320DBCD0FECE748B7942AD3BF00FAFE00FAFE00F2FF00F2FF00
          F2FF00F2FF00FAFE08F2F16E9561C847019D6C2148B79457A980A56414AE5D0D
          48B79408F2F192753092753020DBCD848143B6560220DBCD20DBCDAE5D0D8481
          43927530A564146E95619D6C2148B794798B53BE4F0038C6AB00FFFF00FFFF00
          FFFF2AD3BFB6560292753018E3D914E7E0927530AE5D0D2AD3BF00FFFF629F70
          BE4F00629F7004F8F7629F70BE4F006E95616E9561BE4F00629F7000FAFE48B7
          94BE4F00798B5304F8F720DBCDA56414AE5D01798B5348B794798B53B6560292
          753038C6AB848143AE5D0D629F70848143A5641448B7940AEFEE927530927530
          20DBCD798B53B656022AD3BF38C6AB927530BE4F00B656026E956114E7E02AD3
          BFB65602798B5320DBCD927530AE5D0D2AD3BF00FAFE00F2FF00F2FF000000F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FFFF0AEFEE57A980A56414B6
          5602AE5D01B65602AE5D0D629F700FECE70FECE76E9561AE5D0DAE5D01AE5D01
          B65602A5641457A98008F2F100FFFF00F5FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00FAFE08F2F16E9561BE4F00AE5D01AE5D0DBE4F00BE4F00798B530AEFEE00
          FAFE629F70A56414629F70AE5D0D8481430FECE72AD3BFAE5D0DA56414AE5D01
          629F7048B794AE5D0D48B794798B53BE4F0038C6AB00FAFE20DBCD20DBCD38C6
          ABAE5D0192753014E7E018E3D9927530B656022AD3BF00FFFF629F70BE4F0062
          9F7000FAFE57A980BE4F00629F70629F70BE4F0057A98000FAFE48B794BE4F00
          84814304F8F720DBCDA56414AE5D01AE5D0DB65602BE4F00AE5D0D48B79408F2
          F1848143B6560238C6AB18E3D9A36621AE5D0D18E3D957A980A564146E95619D
          6C2192753020DBCD9D6C21BE4F009275302AD3BF00FAFE00FFFF38C6ABB65602
          798B5320DBCD927530AE5D0D2AD3BF00FAFE00F2FF00F2FF000000F2FF00F2FF
          00F2FF00F2FF00F5FF00FAFE06F4F538C6AB48B79408F2F120DBCD848143B656
          02B65602AE5D01B6560292753038C6AB00FAFE38C6AB9D6C21B65602AE5D01AE
          5D01B65602798B532AD3BF00FAFE00FAFE00F2FF00F2FF00F2FF00F2FF00FAFE
          08F2F16E9561C8470192753048B79457A980AE5D0DA3662138C6AB00FFFF38C6
          ABA56414AE5D0DBE4F00629F7000FAFE2AD3BFAE5D0DB65602AE5D0D2AD3BF48
          B794AE5D0D48B7946E9561C8470148B79414E7E08481439D6C2148B794AE5D0D
          AE5D0D20DBCD20DBCDA56414AE5D0D20DBCD00FFFF629F70BE4F00629F700FEC
          E7798B53C8470148B79448B794C84701798B5306F4F5629F70C84701798B5300
          FAFE20DBCDA56414AE5D01798B5338C6AB798B53B6560284814320DBCD848143
          BE4F0038C6AB18E3D9A36621BE4F002AD3BF20DBCDA56414AE5D0DBE4F0057A9
          8020DBCDBE4F00B65602629F7000FAFE00FAFE00FAFE38C6ABB65602798B5320
          DBCD927530AE5D0D2AD3BF00FAFE00F2FF00F2FF000000F2FF00F2FF00F2FF00
          F5FF00FFFF18E3D9629F70AE5D0DBE4F00798B5320DBCD08F2F157A980A56414
          B65602AE5D01B65602AE5D0D629F700FECE718E3D96E9561AE5D01B65602AE5D
          01B656029D6C2148B79408F2F100FFFF00F5FF00F2FF00F2FF00FAFE08F2F16E
          9561C84701798B5300FFFF0FECE7927530C847016E956100FAFE14E7E0927530
          C84701B6560238C6AB00FFFF2AD3BFB65602BE4F0084814306F4F557A980C847
          0138C6AB38C6ABB656029D6C21848143BE4F0084814314E7E0798B53BE4F0084
          8143848143BE4F006E956106F4F500FFFF6E9561C84701A36621927530BE4F00
          92753014E7E020DBCD9D6C21B65602848143AE5D0DAE5D0D38C6AB00FFFF20DB
          CDA56414B6560248B79400FFFF38C6ABAE5D0DB6560248B794798B53C847019D
          6C219D6C21C8470192753014E7E00FECE7927530C84701BE4F0038C6AB0AEFEE
          927530BE4F00A5641492753084814320DBCD2AD3BFC8470184814320DBCDA366
          21BE4F002AD3BF00FFFF00F2FF00F2FF000000F2FF00F2FF00FFFF00FAFE38C6
          AB927530B65602B65602AE5D01BE4F00A5641448B79400FAFE2AD3BF848143B6
          5602AE5D01B65602BE4F009275302AD3BF00FAFE48B7949D6C21BE4F00AE5D01
          B65602B65602798B5320DBCD00FFFF00FAFE00F2FF00FAFE06F4F5798B53C847
          019D6C2138C6AB629F70AE5D0DC84701629F7000FAFE00FAFE38C6AB629F7057
          A9800FECE700FAFE18E3D957A980629F702AD3BF00FAFE2AD3BF629F7020DBCD
          04F8F748B794798B53848143629F7018E3D900FFFF18E3D957A9808481438481
          4357A98014E7E000FAFE00FAFE38C6AB629F706E95616E956157A98020DBCD00
          FAFE00FAFE2AD3BF6E95618481436E956138C6AB06F4F500FFFF2AD3BFAE5D0D
          B65602798B5338C6AB798B53BE4F00A5641438C6AB38C6AB629F70629F70629F
          7057A98020DBCD00F5FF04F8F738C6AB629F7057A98014E7E000FAFE18E3D957
          A980629F70629F70629F7018E3D914E7E0629F7038C6AB14E7E048B79457A980
          18E3D900F5FF00F2FF00F2FF000000F2FF00F5FF20DBCD6E9561A56414BE4F00
          AE5D01AE5D01AE5D01AE5D01B65602BE4F00798B5320DBCD06F4F557A980AE5D
          0DBE4F00AE5D01B65602AE5D0D629F7014E7E020DBCD6E9561AE5D0DAE5D01B6
          5602B656029D6C2157A98014E7E000F5FF00FAFE06F4F5798B53C84701AE5D0D
          AE5D0DB65602B656029275302AD3BF00FAFE00F2FF00F5FF04F8F700F5FF00F2
          FF00F2FF00F2FF04F8F704F8F700FAFE00F2FF06F4F504F8F700F5FF00F5FF00
          FAFE08F2F10FECE704F8F700F5FF00F2FF00FAFE04F8F70AEFEE0FECE704F8F7
          00F5FF00F2FF00F2FF04F8F704F8F704F8F704F8F704F8F700FAFE00F2FF00F5
          FF00FAFE06F4F50AEFEE06F4F500FAFE00F5FF00FFFF2AD3BFA56414B65602AE
          5D0DAE5D0DAE5D0DAE5D0D6E95610AEFEE00FAFE04F8F704F8F704F8F700FAFE
          00FAFE00F2FF00F2FF00F5FF04F8F700FAFE00F5FF00F2FF00FAFE00FAFE04F8
          F704F8F704F8F700F2FF00F2FF04F8F704F8F700F5FF04F8F704F8F700F2FF00
          F2FF00F2FF00F2FF000000F5FF04F8F7629F70BE4F00BE4F00AE5D01AE5D01AE
          5D01AE5D01AE5D01AE5D01AE5D01B65602A5641457A98008F2F12AD3BF848143
          B65602AE5D01BE4F00B6560238C6AB00FFFF38C6ABA56414AE5D01AE5D01AE5D
          01BE4F00BE4F0048B79400FAFE00F5FF06F4F52AD3BF57A98048B79448B79448
          B79448B79418E3D900F5FF00F5FF00F2FF00F2FF00F5FF00F5FF00F2FF00F2FF
          00F2FF00F5FF00F5FF00F5FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2FF00F5
          FF00F5FF00F5FF00F2FF00F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00
          F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F5FF00F2FF00F2FF00F2FF00F2FF
          00F5FF00F5FF00F5FF00F5FF00F2FF00F5FF0FECE748B79448B79448B79448B7
          9448B79438C6AB0AEFEE00F5FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00
          F2FF00F2FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2FF00F2FF00F5FF00F5FF
          00F5FF00F2FF00F2FF00F5FF00F5FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2
          FF00F2FF000000F2FF00FAFE18E3D9629F70A56414B65602AE5D01AE5D01AE5D
          01AE5D01AE5D01AE5D01AE5D01C84701A564142AD3BF00FFFF0FECE7629F70AE
          5D0D8481432AD3BF0FECE757A9809D6C21AE5D01AE5D01AE5D01B65602927530
          48B7940FECE700F5FF00F2FF00F2FF00FAFE00FFFF00FFFF00FFFF00FFFF00FF
          FF00FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F5FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          000000F2FF00F2FF00FAFE00FAFE38C6AB848143B65602AE5D01AE5D01AE5D01
          AE5D01AE5D01A56414798B532AD3BF00F5FF00F5FF00FAFE08F2F120DBCD0FEC
          E718E3D9798B53B65602AE5D01AE5D01AE5D01AE5D0D6E956120DBCD00FFFF00
          FAFE00F2FF00F2FF00F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F2FF00F2FF00F5FF00FFFF18E3D9629F70A56414B65602AE5D01AE5D01AE
          5D0184814318E3D900FFFF00FAFE00F2FF00F5FF00FFFF06F4F548B7949D6C21
          B65602AE5D01AE5D01B6560292753048B79404F8F700FFFF00FAFE00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF
          00F2FF00F2FF00F2FF00FAFE00FAFE38C6AB848143B65602B65602AE5D01AE5D
          0D798B532AD3BF00FFFF00FFFF00FFFF2AD3BF798B53B65602B65602AE5D01B6
          5602B65602798B5318E3D908F2F157A98057A9800FECE700FFFF00F5FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00FAFE00FFFF18E3D9629F70A56414B65602B65602BE4F00
          A3662148B79418E3D948B794A36621BE4F00AE5D01AE5D01B65602A3662157A9
          800AEFEE2AD3BF848143B65602BE4F00798B5320DBCD00F5FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F5FF00FFFF00FAFE38C6AB927530B65602B65602B65602AE
          5D0D927530AE5D0DBE4F00AE5D01B65602B656028481432AD3BF00FFFF00FAFE
          798B53C84701B65602AE5D01BE4F008481430FECE700FAFE00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00FAFE00FFFF18E3D9629F70AE5D0DBE4F00B65602B656
          02AE5D01AE5D01BE4F00A5641457A9800FECE700FFFF00FAFE00F5FF18E3D957
          A9809D6C21B65602BE4F009D6C2114E7E000FAFE00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00FAFE04F8F738C6AB927530B65602AE5D01B65602
          BE4F0084814338C6AB00FAFE00FFFF00F2FF00F2FF00F2FF00FFFF00FAFE2AD3
          BF848143BE4F009D6C2114E7E000FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F5FF00FAFE18E3D9629F70AE5D0DAE5D0D57A9800F
          ECE700FFFF00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FFFF0FECE7
          629F7092753018E3D900FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F5FF00FFFF06F4F538C6AB38C6AB00FAFE00FAFE00F5
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00FFFF06F4F520
          DBCD0AEFEE00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F5FF00FFFF00FFFF00F5FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FAFE00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF0000}
        Stretch = True
      end
      object QRShape37: TQRShape
        Left = 668
        Top = 897
        Width = 189
        Height = 1
        Size.Values = (
          2.204861111111110000
          1472.847222222220000000
          1977.760416666670000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel48: TQRLabel
        Left = 170
        Top = 851
        Width = 32
        Height = 19
        Size.Values = (
          41.892361111111110000
          374.826388888888900000
          1876.336805555556000000
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
        Top = 764
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          1684.513888888890000000
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
        Top = 822
        Width = 120
        Height = 17
        Size.Values = (
          37.482638888888900000
          30.868055555555600000
          1812.395833333330000000
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
        Top = 822
        Width = 164
        Height = 17
        Size.Values = (
          37.482638888888900000
          348.368055555556000000
          1812.395833333330000000
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
        Top = 822
        Width = 65
        Height = 17
        Size.Values = (
          37.482638888888900000
          745.243055555556000000
          1812.395833333330000000
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
        Top = 823
        Width = 169
        Height = 17
        Size.Values = (
          37.482638888888900000
          1053.923611111110000000
          1814.600694444440000000
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
        Top = 792
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          1746.250000000000000000
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
        Top = 821
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          1810.190972222220000000
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
        Top = 853
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          1880.746527777780000000
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
        Top = 1049
        Width = 68
        Height = 13
        Size.Values = (
          28.663194444444440000
          1664.670138888889000000
          2312.899305555556000000
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
        Top = 705
        Width = 19
        Height = 19
        Size.Values = (
          41.892361111111110000
          1812.395833333333000000
          1554.427083333333000000
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
        Top = 1091
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555600000
          70.555555555555600000
          2405.503472222220000000
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
        Top = 1111
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555600000
          70.555555555555600000
          2449.600694444440000000
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
      object QRLabel83: TQRLabel
        Left = 24
        Top = 170
        Width = 622
        Height = 13
        Size.Values = (
          28.663194444444400000
          52.916666666666700000
          374.826388888889000000
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
        Top = 184
        Width = 622
        Height = 13
        Size.Values = (
          28.663194444444400000
          52.916666666666700000
          405.694444444444000000
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
        Top = 276
        Width = 211
        Height = 14
        Size.Values = (
          30.868055555555560000
          1001.006944444444000000
          608.541666666666600000
          465.225694444444500000)
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
        Top = 1006
        Width = 212
        Height = 14
        Size.Values = (
          30.868055555555560000
          998.802083333333400000
          2218.090277777778000000
          467.430555555555600000)
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
        Top = 922
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          2032.881944444440000000
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
        Top = 937
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          2065.954861111110000000
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
        Top = 954
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          2103.437500000000000000
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
        Top = 968
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          2134.305555555560000000
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
        Top = 985
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          2171.788194444440000000
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
        Top = 889
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1960.121527777780000000
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
        Top = 907
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1999.809027777780000000
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
        Left = 95
        Top = 761
        Width = 310
        Height = 12
        Size.Values = (
          26.458333333333330000
          209.461805555555600000
          1677.899305555556000000
          683.506944444444400000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'PAG'#193'VEL EM QUALQUER BANCO AT'#201' O VENCIMENTO'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object qrlLinDig: TQRLabel
        Left = 295
        Top = 725
        Width = 554
        Height = 23
        Size.Values = (
          50.711805555555600000
          650.434027777778000000
          1598.524305555560000000
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
        Top = 627
        Width = 854
        Height = 1
        Size.Values = (
          2.204861111111110000
          6.614583333333330000
          1382.447916666670000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape38: TQRShape
        Left = 3
        Top = 501
        Width = 854
        Height = 1
        Size.Values = (
          2.204861111111110000
          6.614583333333330000
          1104.635416666670000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape39: TQRShape
        Left = 3
        Top = 473
        Width = 854
        Height = 1
        Size.Values = (
          2.204861111111110000
          6.614583333333330000
          1042.899305555560000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape40: TQRShape
        Left = 3
        Top = 443
        Width = 854
        Height = 3
        Size.Values = (
          6.614583333333330000
          6.614583333333330000
          976.753472222222000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape41: TQRShape
        Left = 3
        Top = 376
        Width = 854
        Height = 14
        Size.Values = (
          30.868055555555600000
          6.614583333333330000
          829.027777777778000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape42: TQRShape
        Left = 3
        Top = 415
        Width = 854
        Height = 3
        Size.Values = (
          6.614583333333330000
          6.614583333333330000
          915.017361111111000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape43: TQRShape
        Left = 191
        Top = 358
        Width = 12
        Height = 24
        Size.Values = (
          52.916666666666700000
          421.128472222222000000
          789.340277777778000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape44: TQRShape
        Left = 3
        Top = 686
        Width = 854
        Height = 4
        Size.Values = (
          8.819444444444440000
          6.614583333333330000
          1512.534722222220000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel4: TQRLabel
        Left = 201
        Top = 358
        Width = 81
        Height = 24
        Size.Values = (
          52.916666666666700000
          443.177083333333000000
          789.340277777778000000
          178.593750000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '001-9'
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
        Top = 386
        Width = 48
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          851.076388888888900000
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
        Top = 358
        Width = 9
        Height = 24
        Size.Values = (
          52.916666666666700000
          615.156250000000000000
          789.340277777778000000
          19.843750000000000000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel38: TQRLabel
        Left = 5
        Top = 385
        Width = 82
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          848.871527777777800000
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
        Top = 417
        Width = 49
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          919.427083333333300000
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
        Top = 417
        Width = 603
        Height = 13
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          919.427083333333300000
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
      object QRLabel47: TQRLabel
        Left = 672
        Top = 418
        Width = 89
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          921.631944444444400000
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
        Top = 446
        Width = 78
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          983.368055555555600000
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
        Top = 446
        Width = 70
        Height = 13
        Size.Values = (
          28.663194444444440000
          319.704861111111100000
          983.368055555555600000
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
        Top = 446
        Width = 54
        Height = 13
        Size.Values = (
          28.663194444444440000
          738.628472222222200000
          983.368055555555600000
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
        Top = 446
        Width = 26
        Height = 13
        Size.Values = (
          28.663194444444440000
          915.017361111111100000
          983.368055555555600000
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
        Top = 446
        Width = 96
        Height = 13
        Size.Values = (
          28.663194444444440000
          1047.309027777778000000
          983.368055555555600000
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
        Top = 446
        Width = 60
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          983.368055555555600000
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
      object QRLabel95: TQRLabel
        Left = 5
        Top = 475
        Width = 56
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1047.309027777778000000
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
        Top = 475
        Width = 34
        Height = 13
        Size.Values = (
          28.663194444444440000
          372.621527777777800000
          1047.309027777778000000
          74.965277777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Carteira'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Top = 475
        Width = 34
        Height = 11
        Size.Values = (
          24.253472222222220000
          500.503472222222200000
          1047.309027777778000000
          74.965277777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Esp'#233'cie'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Top = 484
        Width = 73
        Height = 17
        Size.Values = (
          37.482638888888900000
          507.118055555556000000
          1067.152777777780000000
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
        Top = 475
        Width = 46
        Height = 13
        Size.Values = (
          28.663194444444440000
          698.940972222222200000
          1047.309027777778000000
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
        Top = 475
        Width = 23
        Height = 13
        Size.Values = (
          28.663194444444440000
          1298.663194444444000000
          1047.309027777778000000
          50.711805555555560000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Top = 476
        Width = 10
        Height = 19
        Size.Values = (
          41.892361111111110000
          1270.000000000000000000
          1049.513888888889000000
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
        Top = 475
        Width = 94
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1047.309027777778000000
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
        Top = 503
        Width = 374
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1109.045138888889000000
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
        Top = 503
        Width = 95
        Height = 9
        Size.Values = (
          19.843750000000000000
          1481.666666666667000000
          1109.045138888889000000
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
        Top = 555
        Width = 55
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1223.697916666667000000
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
        Top = 600
        Width = 71
        Height = 13
        Size.Values = (
          28.663194444444440000
          1481.666666666667000000
          1322.916666666667000000
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
        Top = 629
        Width = 38
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          1386.857638888889000000
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
        Top = 676
        Width = 74
        Height = 12
        Size.Values = (
          26.458333333333330000
          4.409722222222222000
          1490.486111111111000000
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
        Top = 672
        Width = 74
        Height = 13
        Size.Values = (
          28.663194444444440000
          1503.715277777778000000
          1481.666666666667000000
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
        Top = 690
        Width = 53
        Height = 12
        Size.Values = (
          26.458333333333330000
          1556.631944444444000000
          1521.354166666667000000
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
        Top = 552
        Width = 189
        Height = 1
        Size.Values = (
          2.204861111111110000
          1472.847222222220000000
          1217.083333333330000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape47: TQRShape
        Left = 668
        Top = 573
        Width = 189
        Height = 6
        Size.Values = (
          13.229166666666700000
          1472.847222222220000000
          1263.385416666670000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel111: TQRLabel
        Left = 51
        Top = 630
        Width = 372
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          1389.062500000000000000
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
        Top = 645
        Width = 806
        Height = 15
        Size.Values = (
          33.072916666666670000
          112.447916666666700000
          1422.135416666667000000
          1777.118055555556000000)
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
        Top = 662
        Width = 372
        Height = 15
        Size.Values = (
          33.072916666666700000
          112.447916666667000000
          1459.618055555560000000
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
        Top = 383
        Width = 3
        Height = 244
        Size.Values = (
          537.986111111111000000
          1468.437500000000000000
          844.461805555556000000
          6.614583333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape49: TQRShape
        Left = 143
        Top = 445
        Width = 1
        Height = 27
        Size.Values = (
          59.531250000000000000
          315.295138888889000000
          981.163194444445100000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape50: TQRShape
        Left = 330
        Top = 445
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          727.604166666667000000
          981.163194444445100000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape51: TQRShape
        Left = 412
        Top = 445
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          908.402777777778000000
          981.163194444445100000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape52: TQRShape
        Left = 165
        Top = 473
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          363.802083333333000000
          1042.899305555560000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape53: TQRShape
        Left = 220
        Top = 473
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          485.069444444444000000
          1042.899305555560000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape54: TQRShape
        Left = 579
        Top = 473
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          1276.614583333330000000
          1042.899305555560000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape55: TQRShape
        Left = 668
        Top = 596
        Width = 189
        Height = 6
        Size.Values = (
          13.229166666666700000
          1472.847222222220000000
          1314.097222222220000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape56: TQRShape
        Left = 312
        Top = 473
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          687.916666666667000000
          1042.899305555560000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel115: TQRLabel
        Left = 8
        Top = 484
        Width = 146
        Height = 17
        Size.Values = (
          37.482638888888900000
          17.638888888888900000
          1067.152777777780000000
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
        Top = 445
        Width = 1
        Height = 28
        Size.Values = (
          61.736111111111100000
          1031.875000000000000000
          981.163194444445100000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel116: TQRLabel
        Left = 440
        Top = 456
        Width = 10
        Height = 17
        Size.Values = (
          37.482638888888890000
          970.138888888888900000
          1005.416666666667000000
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
        Left = 8
        Top = 351
        Width = 122
        Height = 30
        Size.Values = (
          66.145833333333300000
          17.638888888888900000
          773.906250000000000000
          268.993055555556000000)
        XLColumn = 0
        Picture.Data = {
          07544269746D61702A340000424D2A3400000000000036000000280000007E00
          0000230000000100180000000000F43300000000000000000000000000000000
          000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F5FF00FAFE00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FAFE00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F5FF18E3D9
          38C6AB08F2F100FAFE00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00FAFE0FECE748B79438C6AB04F8F700FAFE00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000FAFE20DBCDA5641479
          8B5318E3D900FAFE00FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FAFE
          20DBCD798B53B65602AE5D0D57A9800FECE700FAFE00FAFE00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F5FF000000FAFE20DBCDAE5D0DBE4F009275
          3048B79406F4F500FAFE00F2FF00F2FF00F5FF00FAFE0AEFEE48B7949D6C21B6
          5602AE5D01AE5D01B656028481432AD3BF00FAFE00FAFE00F5FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F5FF000000FAFE20DBCDAE5D0DB65602B65602B65602
          798B532AD3BF00F2FF00FAFE00FAFE20DBCD798B53B65602B65602AE5D01B656
          02B65602AE5D01BE4F00A5641457A9800FECE700FFFF00FAFE00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF000000F5FF14E7E0798B53B65602B65602BE4F00C8470162
          9F7000FFFF04F8F748B7949D6C21BE4F00B65602AE5D01B656029D6C21927530
          AE5D0DB65602B65602BE4F008481432AD3BF00FAFE00FFFF00F5FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF000000F2FF00FAFE14E7E0629F70AE5D0DAE5D0D57A98014E7E020DB
          CD6E9561B65602BE4F00AE5D01B65602BE4F008481432AD3BF14E7E057A980AE
          5D0DB65602B65602BE4F00A3662157A9800FECE700FFFF00FAFE00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          000000F2FF00F2FF00FAFE04F8F738C6AB2AD3BF04F8F738C6AB927530BE4F00
          AE5D01AE5D01BE4F00A5641457A98014E7E000FFFF00FFFF04F8F738C6AB8481
          43AE5D0DAE5D01B65602BE4F00798B532AD3BF04F8F700FAFE00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F2FF00F2FF00FAFE00FFFF18E3D9629F70AE5D0DB65602AE5D01AE5D01B6
          56028481432AD3BF00FAFE00FFFF00F2FF00F2FF00FFFF00FFFF38C6AB9D6C21
          AE5D01AE5D01AE5D01BE4F00A3662157A9800FECE700FFFF00FAFE00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F5FF
          00FFFF08F2F148B794927530BE4F00B65602AE5D01BE4F00AE5D0D57A9800FEC
          E718E3D92AD3BF04F8F700FFFF00F5FF0FECE748B794848143A56414AE5D01AE
          5D01AE5D01AE5D01B65602AE5D01798B532AD3BF00FFFF00FAFE00F2FF00F2FF
          00F2FF00FAFE00FAFE00FAFE00FAFE00FAFE00FAFE00F2FF00F2FF00FAFE00FA
          FE00F2FF00F2FF00F2FF00FAFE00FAFE00F5FF00FAFE00F5FF00F2FF00F2FF00
          FAFE00FAFE00F5FF00F2FF00FAFE00FFFF00FFFF00FAFE00F5FF00F2FF00F2FF
          00FAFE00FFFF00FFFF00FAFE00F5FF00F2FF00F2FF00F5FF00FAFE00FAFE00FA
          FE00FAFE00F2FF00F2FF00F2FF00F5FF00FFFF00FFFF00FFFF00FAFE00F2FF00
          F2FF00F5FF00FAFE00FAFE00FAFE00FAFE00FAFE00F5FF00F5FF00F2FF00F5FF
          00FAFE00F2FF00F2FF00F5FF00FAFE00FAFE00FAFE00F2FF00F2FF00F2FF00FA
          FE00FAFE00FAFE00FAFE00FAFE00FAFE00F5FF00F2FF00F5FF00FAFE00FAFE00
          F5FF00F5FF00FAFE00FAFE00FAFE00F5FF00F2FF000000F5FF00FAFE2AD3BF6E
          9561AE5D0DB65602AE5D01AE5D01AE5D0D92753038C6AB0FECE748B7949D6C21
          A5641457A9800AEFEE00FFFF38C6ABBE4F00C84701AE5D01AE5D01AE5D01AE5D
          01AE5D01AE5D01AE5D01BE4F009D6C2157A98018E3D900F2FF00F2FF00F5FF06
          F4F506F4F506F4F506F4F506F4F504F8F700FFFF00F2FF08F2F106F4F500F5FF
          00F5FF00F2FF06F4F506F4F508F2F104F8F706F4F500F5FF00F5FF08F2F106F4
          F500F5FF00FAFE04F8F718E3D920DBCD0AEFEE00FAFE00F5FF00FFFF0AEFEE20
          DBCD20DBCD08F2F100FFFF00F2FF00F2FF00F2FF06F4F508F2F108F2F100FAFE
          00FFFF00F5FF00FAFE00FAFE14E7E020DBCD14E7E000FAFE00FAFE00F2FF00F2
          FF06F4F506F4F506F4F506F4F506F4F504F8F700FFFF00F2FF08F2F108F2F100
          F5FF00F5FF00F5FF08F2F106F4F506F4F500F2FF00F2FF00F5FF06F4F506F4F5
          08F2F108F2F108F2F108F2F104F8F700FAFE00F2FF06F4F506F4F500F2FF06F4
          F506F4F508F2F108F2F106F4F500F5FF000000F5FF04F8F7629F70C84701BE4F
          00AE5D01AE5D01AE5D0192753018E3D900FFFF48B794BE4F00BE4F00B65602B6
          5602798B532AD3BF14E7E057A980A56414BE4F00AE5D01AE5D01AE5D01AE5D01
          AE5D01AE5D01AE5D01C84701BE4F0048B79400F2FF00FAFE06F4F548B794798B
          53798B53848143798B536E956138C6AB18E3D9629F706E956114E7E000FFFF14
          E7E0629F70798B5338C6AB798B5348B79400FFFF2AD3BF798B53798B532AD3BF
          08F2F1629F709D6C219D6C2184814338C6AB00FFFF2AD3BF798B539D6C219275
          30798B532AD3BF00FAFE00F5FF48B794798B53798B538481436E95612AD3BF00
          FAFE04F8F748B7949275309D6C2192753057A9800AEFEE00FFFF20DBCD6E9561
          798B53798B53848143798B53629F7020DBCD08F2F157A980798B5320DBCD00FF
          FF48B794848143798B536E956118E3D900FFFF0AEFEE57A980798B53798B5379
          8B53848143848143629F7018E3D920DBCD798B5357A98018E3D957A980798B53
          798B5384814348B79400FAFE000000F2FF00F5FF14E7E057A980A36621BE4F00
          AE5D01AE5D01A56414629F7018E3D914E7E06E9561B65602B65602AE5D01BE4F
          00A5641448B79400FAFE20DBCD848143B65602B65602AE5D01AE5D01AE5D01B6
          5602BE4F009D6C2157A98014E7E000F2FF00FAFE06F4F5798B53C84701B65602
          9D6C21A56414BE4F00A5641457A980848143BE4F0057A9800AEFEE48B794B656
          02AE5D0157A980BE4F006E956100FAFE6E9561C84701BE4F0048B79448B794C8
          47019275306E9561C84701A3662120DBCD848143C847016E95616E9561C84701
          8481430AEFEE00FFFF6E9561C847019D6C21848143BE4F009D6C2118E3D92AD3
          BFAE5D0DAE5D0D629F709D6C21C8470157A98000FFFF2AD3BFAE5D0DBE4F00A5
          6414927530AE5D0DC847019275302AD3BF848143C8470138C6AB0AEFEE9D6C21
          B65602A56414BE4F0057A9800FECE738C6ABAE5D0DBE4F00798B536E95616E95
          61927530C847016E956138C6ABBE4F00798B532AD3BF9D6C21C8470184814379
          8B5348B79400F5FF000000F2FF00F2FF00FAFE00FFFF2AD3BF848143BE4F00B6
          5602AE5D01B6560292753038C6AB04F8F738C6AB9D6C21BE4F00AE5D01AE5D01
          AE5D01798B5320DBCD04F8F757A980AE5D0DB65602AE5D01B65602B65602798B
          5320DBCD00FFFF00FAFE00F2FF00FAFE08F2F16E9561C8470184814314E7E020
          DBCD927530C84701798B5357A980AE5D0DA564149275309D6C21BE4F006E9561
          2AD3BFB65602629F7014E7E09D6C21BE4F00A5641448B794798B53C8470138C6
          AB0FECE7798B53A3662157A980AE5D0DA3662118E3D918E3D9A56414AE5D0D20
          DBCD00FFFF629F70BE4F0057A98006F4F5798B53C8470157A98057A980C84701
          6E956104F8F757A980BE4F00798B5300FAFE20DBCDA56414B6560257A98006F4
          F548B794AE5D0DB65602629F70798B53AE5D0D2AD3BF38C6ABBE4F0057A98048
          B794AE5D0DAE5D0D9275309D6C21B6560284814306F4F500FFFF00FAFE48B794
          C847019D6C2148B794AE5D01798B5320DBCD927530AE5D0D2AD3BF00FAFE00F5
          FF00F2FF000000F2FF00F2FF00F2FF00F5FF00FFFF0FECE757A980A56414B656
          02AE5D01B65602AE5D0D629F700FECE714E7E06E9561B65602B65602AE5D01B6
          56029D6C2148B79404F8F72AD3BF848143BE4F00A3662148B7940FECE700FFFF
          00F5FF00F2FF00F2FF00FAFE08F2F16E9561C8470184814300FAFE08F2F1798B
          53C8470184814338C6ABA56414A36621629F70927530BE4F0048B79420DBCDAE
          5D01629F7048B794B65602AE5D0D9D6C2148B794798B53BE4F0038C6AB00FFFF
          20DBCD20DBCD48B794B6560292753018E3D914E7E09D6C21AE5D0D2AD3BF00FF
          FF629F70BE4F00629F7004F8F7629F70BE4F006E95616E9561BE4F00629F7000
          FAFE48B794BE4F00798B5304F8F720DBCDA56414BE4F0048B79400FFFF2AD3BF
          A36621BE4F00629F70798B53A5641448B794927530A5641418E3D920DBCDA564
          14A36621629F70927530BE4F0057A98000FFFF14E7E048B7949D6C21C847016E
          956138C6ABAE5D01798B5320DBCD927530AE5D0D2AD3BF00FFFF00F5FF00F2FF
          000000F2FF00F2FF00F2FF00F2FF00F5FF00FAFE00FAFE2AD3BF848143B65602
          B65602AE5D01B6560292753038C6AB04F8F738C6AB9D6C21BE4F00AE5D01AE5D
          01B6560284814320DBCD0FECE748B7942AD3BF00FAFE00FAFE00F2FF00F2FF00
          F2FF00F2FF00FAFE08F2F16E9561C847019D6C2148B79457A980A56414AE5D0D
          48B79408F2F192753092753020DBCD848143B6560220DBCD20DBCDAE5D0D8481
          43927530A564146E95619D6C2148B794798B53BE4F0038C6AB00FFFF00FFFF00
          FFFF2AD3BFB6560292753018E3D914E7E0927530AE5D0D2AD3BF00FFFF629F70
          BE4F00629F7004F8F7629F70BE4F006E95616E9561BE4F00629F7000FAFE48B7
          94BE4F00798B5304F8F720DBCDA56414AE5D01798B5348B794798B53B6560292
          753038C6AB848143AE5D0D629F70848143A5641448B7940AEFEE927530927530
          20DBCD798B53B656022AD3BF38C6AB927530BE4F00B656026E956114E7E02AD3
          BFB65602798B5320DBCD927530AE5D0D2AD3BF00FAFE00F2FF00F2FF000000F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FFFF0AEFEE57A980A56414B6
          5602AE5D01B65602AE5D0D629F700FECE70FECE76E9561AE5D0DAE5D01AE5D01
          B65602A5641457A98008F2F100FFFF00F5FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00FAFE08F2F16E9561BE4F00AE5D01AE5D0DBE4F00BE4F00798B530AEFEE00
          FAFE629F70A56414629F70AE5D0D8481430FECE72AD3BFAE5D0DA56414AE5D01
          629F7048B794AE5D0D48B794798B53BE4F0038C6AB00FAFE20DBCD20DBCD38C6
          ABAE5D0192753014E7E018E3D9927530B656022AD3BF00FFFF629F70BE4F0062
          9F7000FAFE57A980BE4F00629F70629F70BE4F0057A98000FAFE48B794BE4F00
          84814304F8F720DBCDA56414AE5D01AE5D0DB65602BE4F00AE5D0D48B79408F2
          F1848143B6560238C6AB18E3D9A36621AE5D0D18E3D957A980A564146E95619D
          6C2192753020DBCD9D6C21BE4F009275302AD3BF00FAFE00FFFF38C6ABB65602
          798B5320DBCD927530AE5D0D2AD3BF00FAFE00F2FF00F2FF000000F2FF00F2FF
          00F2FF00F2FF00F5FF00FAFE06F4F538C6AB48B79408F2F120DBCD848143B656
          02B65602AE5D01B6560292753038C6AB00FAFE38C6AB9D6C21B65602AE5D01AE
          5D01B65602798B532AD3BF00FAFE00FAFE00F2FF00F2FF00F2FF00F2FF00FAFE
          08F2F16E9561C8470192753048B79457A980AE5D0DA3662138C6AB00FFFF38C6
          ABA56414AE5D0DBE4F00629F7000FAFE2AD3BFAE5D0DB65602AE5D0D2AD3BF48
          B794AE5D0D48B7946E9561C8470148B79414E7E08481439D6C2148B794AE5D0D
          AE5D0D20DBCD20DBCDA56414AE5D0D20DBCD00FFFF629F70BE4F00629F700FEC
          E7798B53C8470148B79448B794C84701798B5306F4F5629F70C84701798B5300
          FAFE20DBCDA56414AE5D01798B5338C6AB798B53B6560284814320DBCD848143
          BE4F0038C6AB18E3D9A36621BE4F002AD3BF20DBCDA56414AE5D0DBE4F0057A9
          8020DBCDBE4F00B65602629F7000FAFE00FAFE00FAFE38C6ABB65602798B5320
          DBCD927530AE5D0D2AD3BF00FAFE00F2FF00F2FF000000F2FF00F2FF00F2FF00
          F5FF00FFFF18E3D9629F70AE5D0DBE4F00798B5320DBCD08F2F157A980A56414
          B65602AE5D01B65602AE5D0D629F700FECE718E3D96E9561AE5D01B65602AE5D
          01B656029D6C2148B79408F2F100FFFF00F5FF00F2FF00F2FF00FAFE08F2F16E
          9561C84701798B5300FFFF0FECE7927530C847016E956100FAFE14E7E0927530
          C84701B6560238C6AB00FFFF2AD3BFB65602BE4F0084814306F4F557A980C847
          0138C6AB38C6ABB656029D6C21848143BE4F0084814314E7E0798B53BE4F0084
          8143848143BE4F006E956106F4F500FFFF6E9561C84701A36621927530BE4F00
          92753014E7E020DBCD9D6C21B65602848143AE5D0DAE5D0D38C6AB00FFFF20DB
          CDA56414B6560248B79400FFFF38C6ABAE5D0DB6560248B794798B53C847019D
          6C219D6C21C8470192753014E7E00FECE7927530C84701BE4F0038C6AB0AEFEE
          927530BE4F00A5641492753084814320DBCD2AD3BFC8470184814320DBCDA366
          21BE4F002AD3BF00FFFF00F2FF00F2FF000000F2FF00F2FF00FFFF00FAFE38C6
          AB927530B65602B65602AE5D01BE4F00A5641448B79400FAFE2AD3BF848143B6
          5602AE5D01B65602BE4F009275302AD3BF00FAFE48B7949D6C21BE4F00AE5D01
          B65602B65602798B5320DBCD00FFFF00FAFE00F2FF00FAFE06F4F5798B53C847
          019D6C2138C6AB629F70AE5D0DC84701629F7000FAFE00FAFE38C6AB629F7057
          A9800FECE700FAFE18E3D957A980629F702AD3BF00FAFE2AD3BF629F7020DBCD
          04F8F748B794798B53848143629F7018E3D900FFFF18E3D957A9808481438481
          4357A98014E7E000FAFE00FAFE38C6AB629F706E95616E956157A98020DBCD00
          FAFE00FAFE2AD3BF6E95618481436E956138C6AB06F4F500FFFF2AD3BFAE5D0D
          B65602798B5338C6AB798B53BE4F00A5641438C6AB38C6AB629F70629F70629F
          7057A98020DBCD00F5FF04F8F738C6AB629F7057A98014E7E000FAFE18E3D957
          A980629F70629F70629F7018E3D914E7E0629F7038C6AB14E7E048B79457A980
          18E3D900F5FF00F2FF00F2FF000000F2FF00F5FF20DBCD6E9561A56414BE4F00
          AE5D01AE5D01AE5D01AE5D01B65602BE4F00798B5320DBCD06F4F557A980AE5D
          0DBE4F00AE5D01B65602AE5D0D629F7014E7E020DBCD6E9561AE5D0DAE5D01B6
          5602B656029D6C2157A98014E7E000F5FF00FAFE06F4F5798B53C84701AE5D0D
          AE5D0DB65602B656029275302AD3BF00FAFE00F2FF00F5FF04F8F700F5FF00F2
          FF00F2FF00F2FF04F8F704F8F700FAFE00F2FF06F4F504F8F700F5FF00F5FF00
          FAFE08F2F10FECE704F8F700F5FF00F2FF00FAFE04F8F70AEFEE0FECE704F8F7
          00F5FF00F2FF00F2FF04F8F704F8F704F8F704F8F704F8F700FAFE00F2FF00F5
          FF00FAFE06F4F50AEFEE06F4F500FAFE00F5FF00FFFF2AD3BFA56414B65602AE
          5D0DAE5D0DAE5D0DAE5D0D6E95610AEFEE00FAFE04F8F704F8F704F8F700FAFE
          00FAFE00F2FF00F2FF00F5FF04F8F700FAFE00F5FF00F2FF00FAFE00FAFE04F8
          F704F8F704F8F700F2FF00F2FF04F8F704F8F700F5FF04F8F704F8F700F2FF00
          F2FF00F2FF00F2FF000000F5FF04F8F7629F70BE4F00BE4F00AE5D01AE5D01AE
          5D01AE5D01AE5D01AE5D01AE5D01B65602A5641457A98008F2F12AD3BF848143
          B65602AE5D01BE4F00B6560238C6AB00FFFF38C6ABA56414AE5D01AE5D01AE5D
          01BE4F00BE4F0048B79400FAFE00F5FF06F4F52AD3BF57A98048B79448B79448
          B79448B79418E3D900F5FF00F5FF00F2FF00F2FF00F5FF00F5FF00F2FF00F2FF
          00F2FF00F5FF00F5FF00F5FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2FF00F5
          FF00F5FF00F5FF00F2FF00F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00
          F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F5FF00F2FF00F2FF00F2FF00F2FF
          00F5FF00F5FF00F5FF00F5FF00F2FF00F5FF0FECE748B79448B79448B79448B7
          9448B79438C6AB0AEFEE00F5FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00
          F2FF00F2FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2FF00F2FF00F5FF00F5FF
          00F5FF00F2FF00F2FF00F5FF00F5FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2
          FF00F2FF000000F2FF00FAFE18E3D9629F70A56414B65602AE5D01AE5D01AE5D
          01AE5D01AE5D01AE5D01AE5D01C84701A564142AD3BF00FFFF0FECE7629F70AE
          5D0D8481432AD3BF0FECE757A9809D6C21AE5D01AE5D01AE5D01B65602927530
          48B7940FECE700F5FF00F2FF00F2FF00FAFE00FFFF00FFFF00FFFF00FFFF00FF
          FF00FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F5FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          000000F2FF00F2FF00FAFE00FAFE38C6AB848143B65602AE5D01AE5D01AE5D01
          AE5D01AE5D01A56414798B532AD3BF00F5FF00F5FF00FAFE08F2F120DBCD0FEC
          E718E3D9798B53B65602AE5D01AE5D01AE5D01AE5D0D6E956120DBCD00FFFF00
          FAFE00F2FF00F2FF00F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F2FF00F2FF00F5FF00FFFF18E3D9629F70A56414B65602AE5D01AE5D01AE
          5D0184814318E3D900FFFF00FAFE00F2FF00F5FF00FFFF06F4F548B7949D6C21
          B65602AE5D01AE5D01B6560292753048B79404F8F700FFFF00FAFE00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF
          00F2FF00F2FF00F2FF00FAFE00FAFE38C6AB848143B65602B65602AE5D01AE5D
          0D798B532AD3BF00FFFF00FFFF00FFFF2AD3BF798B53B65602B65602AE5D01B6
          5602B65602798B5318E3D908F2F157A98057A9800FECE700FFFF00F5FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00FAFE00FFFF18E3D9629F70A56414B65602B65602BE4F00
          A3662148B79418E3D948B794A36621BE4F00AE5D01AE5D01B65602A3662157A9
          800AEFEE2AD3BF848143B65602BE4F00798B5320DBCD00F5FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F5FF00FFFF00FAFE38C6AB927530B65602B65602B65602AE
          5D0D927530AE5D0DBE4F00AE5D01B65602B656028481432AD3BF00FFFF00FAFE
          798B53C84701B65602AE5D01BE4F008481430FECE700FAFE00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00FAFE00FFFF18E3D9629F70AE5D0DBE4F00B65602B656
          02AE5D01AE5D01BE4F00A5641457A9800FECE700FFFF00FAFE00F5FF18E3D957
          A9809D6C21B65602BE4F009D6C2114E7E000FAFE00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00FAFE04F8F738C6AB927530B65602AE5D01B65602
          BE4F0084814338C6AB00FAFE00FFFF00F2FF00F2FF00F2FF00FFFF00FAFE2AD3
          BF848143BE4F009D6C2114E7E000FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F5FF00FAFE18E3D9629F70AE5D0DAE5D0D57A9800F
          ECE700FFFF00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FFFF0FECE7
          629F7092753018E3D900FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F5FF00FFFF06F4F538C6AB38C6AB00FAFE00FAFE00F5
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00FFFF06F4F520
          DBCD0AEFEE00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F5FF00FFFF00FFFF00F5FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FAFE00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF0000}
        Stretch = True
      end
      object QRShape58: TQRShape
        Left = 668
        Top = 530
        Width = 189
        Height = 1
        Size.Values = (
          2.204861111111110000
          1472.847222222220000000
          1168.576388888890000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel117: TQRLabel
        Left = 170
        Top = 484
        Width = 32
        Height = 17
        Size.Values = (
          37.482638888888890000
          374.826388888888900000
          1067.152777777778000000
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
        Top = 398
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          877.534722222222000000
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
        Top = 456
        Width = 120
        Height = 17
        Size.Values = (
          37.482638888888900000
          30.868055555555600000
          1005.416666666670000000
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
        Top = 456
        Width = 164
        Height = 17
        Size.Values = (
          37.482638888888900000
          348.368055555556000000
          1005.416666666670000000
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
        Top = 456
        Width = 65
        Height = 17
        Size.Values = (
          37.482638888888900000
          745.243055555556000000
          1005.416666666670000000
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
        Top = 456
        Width = 169
        Height = 17
        Size.Values = (
          37.482638888888900000
          1053.923611111110000000
          1005.416666666670000000
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
        Top = 426
        Width = 159
        Height = 17
        Size.Values = (
          37.482638888888900000
          1514.739583333330000000
          939.270833333333000000
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
        Top = 456
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1512.534722222220000000
          1005.416666666670000000
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
        Top = 484
        Width = 160
        Height = 17
        Size.Values = (
          37.482638888888900000
          1512.534722222220000000
          1067.152777777780000000
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
        Top = 548
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1208.263888888890000000
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
        Top = 563
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1241.336805555560000000
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
        Top = 579
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1276.614583333330000000
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
        Top = 594
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1309.687500000000000000
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
        Top = 609
        Width = 621
        Height = 15
        Size.Values = (
          33.072916666666700000
          52.916666666666700000
          1342.760416666670000000
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
        Top = 672
        Width = 68
        Height = 13
        Size.Values = (
          28.663194444444440000
          1680.104166666667000000
          1481.666666666667000000
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
        Top = 519
        Width = 621
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          1144.322916666670000000
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
        Top = 532
        Width = 621
        Height = 14
        Size.Values = (
          30.868055555555600000
          52.916666666666700000
          1172.986111111110000000
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
        Top = 630
        Width = 212
        Height = 14
        Size.Values = (
          30.868055555555560000
          998.802083333333400000
          1389.062500000000000000
          467.430555555555600000)
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
        Top = 358
        Width = 159
        Height = 21
        Size.Values = (
          46.302083333333300000
          1514.739583333330000000
          789.340277777778000000
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
      object QRLabel89: TQRLabel
        Left = 95
        Top = 395
        Width = 317
        Height = 11
        Size.Values = (
          24.253472222222220000
          209.461805555555600000
          870.920138888889000000
          698.940972222222300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'PAG'#193'VEL EM QUALQUER BANCO AT'#201' O VENCIMENTO'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel90: TQRLabel
        Left = 57
        Top = 80
        Width = 603
        Height = 13
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          176.388888888888900000
          1329.531250000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Endereco do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel90Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel114: TQRLabel
        Left = 57
        Top = 431
        Width = 603
        Height = 13
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          950.295138888888900000
          1329.531250000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Endereco do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel90Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel136: TQRLabel
        Left = 57
        Top = 797
        Width = 603
        Height = 13
        Size.Values = (
          28.663194444444440000
          125.677083333333300000
          1757.274305555556000000
          1329.531250000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Endereco do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel90Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
    end
    object qrBandaComprovante: TQRBand
      Left = 45
      Top = 23
      Width = 861
      Height = 140
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        308.680555555555600000
        1898.385416666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRShape61: TQRShape
        Left = 4
        Top = 23
        Width = 853
        Height = 13
        Size.Values = (
          28.663194444444400000
          8.819444444444440000
          50.711805555555600000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel73: TQRLabel
        Left = 294
        Top = 8
        Width = 555
        Height = 20
        Size.Values = (
          44.097222222222200000
          648.229166666667000000
          17.638888888888900000
          1223.697916666670000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Comprovante de Entrega'
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
      object QRLabel138: TQRLabel
        Left = 5
        Top = 31
        Width = 48
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          68.350694444444440000
          105.833333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Benefici'#225'rio'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape62: TQRShape
        Left = 4
        Top = 55
        Width = 527
        Height = 2
        Size.Values = (
          4.409722222222220000
          8.819444444444440000
          121.267361111111000000
          1161.961805555560000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel139: TQRLabel
        Left = 5
        Top = 57
        Width = 34
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          125.677083333333300000
          74.965277777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Pagador'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel140: TQRLabel
        Left = 57
        Top = 37
        Width = 304
        Height = 17
        Size.Values = (
          37.482638888888890000
          125.677083333333300000
          81.579861111111110000
          670.277777777777800000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nome do Cedente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = LabelNomeCedentePrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRShape59: TQRShape
        Left = 191
        Top = 5
        Width = 12
        Height = 24
        Size.Values = (
          52.916666666666700000
          421.128472222222000000
          11.024305555555600000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel3: TQRLabel
        Left = 200
        Top = 5
        Width = 82
        Height = 24
        Size.Values = (
          52.916666666666700000
          440.972222222222000000
          11.024305555555600000
          180.798611111111000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '001-9'
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
      object QRShape60: TQRShape
        Left = 280
        Top = 5
        Width = 10
        Height = 24
        Size.Values = (
          52.916666666666700000
          617.361111111111000000
          11.024305555555600000
          22.048611111111100000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRImage4: TQRImage
        Left = 7
        Top = 1
        Width = 120
        Height = 28
        Size.Values = (
          61.736111111111100000
          15.434027777777800000
          2.204861111111110000
          264.583333333333000000)
        XLColumn = 0
        Picture.Data = {
          07544269746D61702A340000424D2A3400000000000036000000280000007E00
          0000230000000100180000000000F43300000000000000000000000000000000
          000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F5FF00FAFE00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FAFE00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F5FF18E3D9
          38C6AB08F2F100FAFE00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00FAFE0FECE748B79438C6AB04F8F700FAFE00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000FAFE20DBCDA5641479
          8B5318E3D900FAFE00FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FAFE
          20DBCD798B53B65602AE5D0D57A9800FECE700FAFE00FAFE00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F5FF000000FAFE20DBCDAE5D0DBE4F009275
          3048B79406F4F500FAFE00F2FF00F2FF00F5FF00FAFE0AEFEE48B7949D6C21B6
          5602AE5D01AE5D01B656028481432AD3BF00FAFE00FAFE00F5FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F5FF000000FAFE20DBCDAE5D0DB65602B65602B65602
          798B532AD3BF00F2FF00FAFE00FAFE20DBCD798B53B65602B65602AE5D01B656
          02B65602AE5D01BE4F00A5641457A9800FECE700FFFF00FAFE00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF000000F5FF14E7E0798B53B65602B65602BE4F00C8470162
          9F7000FFFF04F8F748B7949D6C21BE4F00B65602AE5D01B656029D6C21927530
          AE5D0DB65602B65602BE4F008481432AD3BF00FAFE00FFFF00F5FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF000000F2FF00FAFE14E7E0629F70AE5D0DAE5D0D57A98014E7E020DB
          CD6E9561B65602BE4F00AE5D01B65602BE4F008481432AD3BF14E7E057A980AE
          5D0DB65602B65602BE4F00A3662157A9800FECE700FFFF00FAFE00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          000000F2FF00F2FF00FAFE04F8F738C6AB2AD3BF04F8F738C6AB927530BE4F00
          AE5D01AE5D01BE4F00A5641457A98014E7E000FFFF00FFFF04F8F738C6AB8481
          43AE5D0DAE5D01B65602BE4F00798B532AD3BF04F8F700FAFE00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F2FF00F2FF00FAFE00FFFF18E3D9629F70AE5D0DB65602AE5D01AE5D01B6
          56028481432AD3BF00FAFE00FFFF00F2FF00F2FF00FFFF00FFFF38C6AB9D6C21
          AE5D01AE5D01AE5D01BE4F00A3662157A9800FECE700FFFF00FAFE00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F5FF
          00FFFF08F2F148B794927530BE4F00B65602AE5D01BE4F00AE5D0D57A9800FEC
          E718E3D92AD3BF04F8F700FFFF00F5FF0FECE748B794848143A56414AE5D01AE
          5D01AE5D01AE5D01B65602AE5D01798B532AD3BF00FFFF00FAFE00F2FF00F2FF
          00F2FF00FAFE00FAFE00FAFE00FAFE00FAFE00FAFE00F2FF00F2FF00FAFE00FA
          FE00F2FF00F2FF00F2FF00FAFE00FAFE00F5FF00FAFE00F5FF00F2FF00F2FF00
          FAFE00FAFE00F5FF00F2FF00FAFE00FFFF00FFFF00FAFE00F5FF00F2FF00F2FF
          00FAFE00FFFF00FFFF00FAFE00F5FF00F2FF00F2FF00F5FF00FAFE00FAFE00FA
          FE00FAFE00F2FF00F2FF00F2FF00F5FF00FFFF00FFFF00FFFF00FAFE00F2FF00
          F2FF00F5FF00FAFE00FAFE00FAFE00FAFE00FAFE00F5FF00F5FF00F2FF00F5FF
          00FAFE00F2FF00F2FF00F5FF00FAFE00FAFE00FAFE00F2FF00F2FF00F2FF00FA
          FE00FAFE00FAFE00FAFE00FAFE00FAFE00F5FF00F2FF00F5FF00FAFE00FAFE00
          F5FF00F5FF00FAFE00FAFE00FAFE00F5FF00F2FF000000F5FF00FAFE2AD3BF6E
          9561AE5D0DB65602AE5D01AE5D01AE5D0D92753038C6AB0FECE748B7949D6C21
          A5641457A9800AEFEE00FFFF38C6ABBE4F00C84701AE5D01AE5D01AE5D01AE5D
          01AE5D01AE5D01AE5D01BE4F009D6C2157A98018E3D900F2FF00F2FF00F5FF06
          F4F506F4F506F4F506F4F506F4F504F8F700FFFF00F2FF08F2F106F4F500F5FF
          00F5FF00F2FF06F4F506F4F508F2F104F8F706F4F500F5FF00F5FF08F2F106F4
          F500F5FF00FAFE04F8F718E3D920DBCD0AEFEE00FAFE00F5FF00FFFF0AEFEE20
          DBCD20DBCD08F2F100FFFF00F2FF00F2FF00F2FF06F4F508F2F108F2F100FAFE
          00FFFF00F5FF00FAFE00FAFE14E7E020DBCD14E7E000FAFE00FAFE00F2FF00F2
          FF06F4F506F4F506F4F506F4F506F4F504F8F700FFFF00F2FF08F2F108F2F100
          F5FF00F5FF00F5FF08F2F106F4F506F4F500F2FF00F2FF00F5FF06F4F506F4F5
          08F2F108F2F108F2F108F2F104F8F700FAFE00F2FF06F4F506F4F500F2FF06F4
          F506F4F508F2F108F2F106F4F500F5FF000000F5FF04F8F7629F70C84701BE4F
          00AE5D01AE5D01AE5D0192753018E3D900FFFF48B794BE4F00BE4F00B65602B6
          5602798B532AD3BF14E7E057A980A56414BE4F00AE5D01AE5D01AE5D01AE5D01
          AE5D01AE5D01AE5D01C84701BE4F0048B79400F2FF00FAFE06F4F548B794798B
          53798B53848143798B536E956138C6AB18E3D9629F706E956114E7E000FFFF14
          E7E0629F70798B5338C6AB798B5348B79400FFFF2AD3BF798B53798B532AD3BF
          08F2F1629F709D6C219D6C2184814338C6AB00FFFF2AD3BF798B539D6C219275
          30798B532AD3BF00FAFE00F5FF48B794798B53798B538481436E95612AD3BF00
          FAFE04F8F748B7949275309D6C2192753057A9800AEFEE00FFFF20DBCD6E9561
          798B53798B53848143798B53629F7020DBCD08F2F157A980798B5320DBCD00FF
          FF48B794848143798B536E956118E3D900FFFF0AEFEE57A980798B53798B5379
          8B53848143848143629F7018E3D920DBCD798B5357A98018E3D957A980798B53
          798B5384814348B79400FAFE000000F2FF00F5FF14E7E057A980A36621BE4F00
          AE5D01AE5D01A56414629F7018E3D914E7E06E9561B65602B65602AE5D01BE4F
          00A5641448B79400FAFE20DBCD848143B65602B65602AE5D01AE5D01AE5D01B6
          5602BE4F009D6C2157A98014E7E000F2FF00FAFE06F4F5798B53C84701B65602
          9D6C21A56414BE4F00A5641457A980848143BE4F0057A9800AEFEE48B794B656
          02AE5D0157A980BE4F006E956100FAFE6E9561C84701BE4F0048B79448B794C8
          47019275306E9561C84701A3662120DBCD848143C847016E95616E9561C84701
          8481430AEFEE00FFFF6E9561C847019D6C21848143BE4F009D6C2118E3D92AD3
          BFAE5D0DAE5D0D629F709D6C21C8470157A98000FFFF2AD3BFAE5D0DBE4F00A5
          6414927530AE5D0DC847019275302AD3BF848143C8470138C6AB0AEFEE9D6C21
          B65602A56414BE4F0057A9800FECE738C6ABAE5D0DBE4F00798B536E95616E95
          61927530C847016E956138C6ABBE4F00798B532AD3BF9D6C21C8470184814379
          8B5348B79400F5FF000000F2FF00F2FF00FAFE00FFFF2AD3BF848143BE4F00B6
          5602AE5D01B6560292753038C6AB04F8F738C6AB9D6C21BE4F00AE5D01AE5D01
          AE5D01798B5320DBCD04F8F757A980AE5D0DB65602AE5D01B65602B65602798B
          5320DBCD00FFFF00FAFE00F2FF00FAFE08F2F16E9561C8470184814314E7E020
          DBCD927530C84701798B5357A980AE5D0DA564149275309D6C21BE4F006E9561
          2AD3BFB65602629F7014E7E09D6C21BE4F00A5641448B794798B53C8470138C6
          AB0FECE7798B53A3662157A980AE5D0DA3662118E3D918E3D9A56414AE5D0D20
          DBCD00FFFF629F70BE4F0057A98006F4F5798B53C8470157A98057A980C84701
          6E956104F8F757A980BE4F00798B5300FAFE20DBCDA56414B6560257A98006F4
          F548B794AE5D0DB65602629F70798B53AE5D0D2AD3BF38C6ABBE4F0057A98048
          B794AE5D0DAE5D0D9275309D6C21B6560284814306F4F500FFFF00FAFE48B794
          C847019D6C2148B794AE5D01798B5320DBCD927530AE5D0D2AD3BF00FAFE00F5
          FF00F2FF000000F2FF00F2FF00F2FF00F5FF00FFFF0FECE757A980A56414B656
          02AE5D01B65602AE5D0D629F700FECE714E7E06E9561B65602B65602AE5D01B6
          56029D6C2148B79404F8F72AD3BF848143BE4F00A3662148B7940FECE700FFFF
          00F5FF00F2FF00F2FF00FAFE08F2F16E9561C8470184814300FAFE08F2F1798B
          53C8470184814338C6ABA56414A36621629F70927530BE4F0048B79420DBCDAE
          5D01629F7048B794B65602AE5D0D9D6C2148B794798B53BE4F0038C6AB00FFFF
          20DBCD20DBCD48B794B6560292753018E3D914E7E09D6C21AE5D0D2AD3BF00FF
          FF629F70BE4F00629F7004F8F7629F70BE4F006E95616E9561BE4F00629F7000
          FAFE48B794BE4F00798B5304F8F720DBCDA56414BE4F0048B79400FFFF2AD3BF
          A36621BE4F00629F70798B53A5641448B794927530A5641418E3D920DBCDA564
          14A36621629F70927530BE4F0057A98000FFFF14E7E048B7949D6C21C847016E
          956138C6ABAE5D01798B5320DBCD927530AE5D0D2AD3BF00FFFF00F5FF00F2FF
          000000F2FF00F2FF00F2FF00F2FF00F5FF00FAFE00FAFE2AD3BF848143B65602
          B65602AE5D01B6560292753038C6AB04F8F738C6AB9D6C21BE4F00AE5D01AE5D
          01B6560284814320DBCD0FECE748B7942AD3BF00FAFE00FAFE00F2FF00F2FF00
          F2FF00F2FF00FAFE08F2F16E9561C847019D6C2148B79457A980A56414AE5D0D
          48B79408F2F192753092753020DBCD848143B6560220DBCD20DBCDAE5D0D8481
          43927530A564146E95619D6C2148B794798B53BE4F0038C6AB00FFFF00FFFF00
          FFFF2AD3BFB6560292753018E3D914E7E0927530AE5D0D2AD3BF00FFFF629F70
          BE4F00629F7004F8F7629F70BE4F006E95616E9561BE4F00629F7000FAFE48B7
          94BE4F00798B5304F8F720DBCDA56414AE5D01798B5348B794798B53B6560292
          753038C6AB848143AE5D0D629F70848143A5641448B7940AEFEE927530927530
          20DBCD798B53B656022AD3BF38C6AB927530BE4F00B656026E956114E7E02AD3
          BFB65602798B5320DBCD927530AE5D0D2AD3BF00FAFE00F2FF00F2FF000000F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FFFF0AEFEE57A980A56414B6
          5602AE5D01B65602AE5D0D629F700FECE70FECE76E9561AE5D0DAE5D01AE5D01
          B65602A5641457A98008F2F100FFFF00F5FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00FAFE08F2F16E9561BE4F00AE5D01AE5D0DBE4F00BE4F00798B530AEFEE00
          FAFE629F70A56414629F70AE5D0D8481430FECE72AD3BFAE5D0DA56414AE5D01
          629F7048B794AE5D0D48B794798B53BE4F0038C6AB00FAFE20DBCD20DBCD38C6
          ABAE5D0192753014E7E018E3D9927530B656022AD3BF00FFFF629F70BE4F0062
          9F7000FAFE57A980BE4F00629F70629F70BE4F0057A98000FAFE48B794BE4F00
          84814304F8F720DBCDA56414AE5D01AE5D0DB65602BE4F00AE5D0D48B79408F2
          F1848143B6560238C6AB18E3D9A36621AE5D0D18E3D957A980A564146E95619D
          6C2192753020DBCD9D6C21BE4F009275302AD3BF00FAFE00FFFF38C6ABB65602
          798B5320DBCD927530AE5D0D2AD3BF00FAFE00F2FF00F2FF000000F2FF00F2FF
          00F2FF00F2FF00F5FF00FAFE06F4F538C6AB48B79408F2F120DBCD848143B656
          02B65602AE5D01B6560292753038C6AB00FAFE38C6AB9D6C21B65602AE5D01AE
          5D01B65602798B532AD3BF00FAFE00FAFE00F2FF00F2FF00F2FF00F2FF00FAFE
          08F2F16E9561C8470192753048B79457A980AE5D0DA3662138C6AB00FFFF38C6
          ABA56414AE5D0DBE4F00629F7000FAFE2AD3BFAE5D0DB65602AE5D0D2AD3BF48
          B794AE5D0D48B7946E9561C8470148B79414E7E08481439D6C2148B794AE5D0D
          AE5D0D20DBCD20DBCDA56414AE5D0D20DBCD00FFFF629F70BE4F00629F700FEC
          E7798B53C8470148B79448B794C84701798B5306F4F5629F70C84701798B5300
          FAFE20DBCDA56414AE5D01798B5338C6AB798B53B6560284814320DBCD848143
          BE4F0038C6AB18E3D9A36621BE4F002AD3BF20DBCDA56414AE5D0DBE4F0057A9
          8020DBCDBE4F00B65602629F7000FAFE00FAFE00FAFE38C6ABB65602798B5320
          DBCD927530AE5D0D2AD3BF00FAFE00F2FF00F2FF000000F2FF00F2FF00F2FF00
          F5FF00FFFF18E3D9629F70AE5D0DBE4F00798B5320DBCD08F2F157A980A56414
          B65602AE5D01B65602AE5D0D629F700FECE718E3D96E9561AE5D01B65602AE5D
          01B656029D6C2148B79408F2F100FFFF00F5FF00F2FF00F2FF00FAFE08F2F16E
          9561C84701798B5300FFFF0FECE7927530C847016E956100FAFE14E7E0927530
          C84701B6560238C6AB00FFFF2AD3BFB65602BE4F0084814306F4F557A980C847
          0138C6AB38C6ABB656029D6C21848143BE4F0084814314E7E0798B53BE4F0084
          8143848143BE4F006E956106F4F500FFFF6E9561C84701A36621927530BE4F00
          92753014E7E020DBCD9D6C21B65602848143AE5D0DAE5D0D38C6AB00FFFF20DB
          CDA56414B6560248B79400FFFF38C6ABAE5D0DB6560248B794798B53C847019D
          6C219D6C21C8470192753014E7E00FECE7927530C84701BE4F0038C6AB0AEFEE
          927530BE4F00A5641492753084814320DBCD2AD3BFC8470184814320DBCDA366
          21BE4F002AD3BF00FFFF00F2FF00F2FF000000F2FF00F2FF00FFFF00FAFE38C6
          AB927530B65602B65602AE5D01BE4F00A5641448B79400FAFE2AD3BF848143B6
          5602AE5D01B65602BE4F009275302AD3BF00FAFE48B7949D6C21BE4F00AE5D01
          B65602B65602798B5320DBCD00FFFF00FAFE00F2FF00FAFE06F4F5798B53C847
          019D6C2138C6AB629F70AE5D0DC84701629F7000FAFE00FAFE38C6AB629F7057
          A9800FECE700FAFE18E3D957A980629F702AD3BF00FAFE2AD3BF629F7020DBCD
          04F8F748B794798B53848143629F7018E3D900FFFF18E3D957A9808481438481
          4357A98014E7E000FAFE00FAFE38C6AB629F706E95616E956157A98020DBCD00
          FAFE00FAFE2AD3BF6E95618481436E956138C6AB06F4F500FFFF2AD3BFAE5D0D
          B65602798B5338C6AB798B53BE4F00A5641438C6AB38C6AB629F70629F70629F
          7057A98020DBCD00F5FF04F8F738C6AB629F7057A98014E7E000FAFE18E3D957
          A980629F70629F70629F7018E3D914E7E0629F7038C6AB14E7E048B79457A980
          18E3D900F5FF00F2FF00F2FF000000F2FF00F5FF20DBCD6E9561A56414BE4F00
          AE5D01AE5D01AE5D01AE5D01B65602BE4F00798B5320DBCD06F4F557A980AE5D
          0DBE4F00AE5D01B65602AE5D0D629F7014E7E020DBCD6E9561AE5D0DAE5D01B6
          5602B656029D6C2157A98014E7E000F5FF00FAFE06F4F5798B53C84701AE5D0D
          AE5D0DB65602B656029275302AD3BF00FAFE00F2FF00F5FF04F8F700F5FF00F2
          FF00F2FF00F2FF04F8F704F8F700FAFE00F2FF06F4F504F8F700F5FF00F5FF00
          FAFE08F2F10FECE704F8F700F5FF00F2FF00FAFE04F8F70AEFEE0FECE704F8F7
          00F5FF00F2FF00F2FF04F8F704F8F704F8F704F8F704F8F700FAFE00F2FF00F5
          FF00FAFE06F4F50AEFEE06F4F500FAFE00F5FF00FFFF2AD3BFA56414B65602AE
          5D0DAE5D0DAE5D0DAE5D0D6E95610AEFEE00FAFE04F8F704F8F704F8F700FAFE
          00FAFE00F2FF00F2FF00F5FF04F8F700FAFE00F5FF00F2FF00FAFE00FAFE04F8
          F704F8F704F8F700F2FF00F2FF04F8F704F8F700F5FF04F8F704F8F700F2FF00
          F2FF00F2FF00F2FF000000F5FF04F8F7629F70BE4F00BE4F00AE5D01AE5D01AE
          5D01AE5D01AE5D01AE5D01AE5D01B65602A5641457A98008F2F12AD3BF848143
          B65602AE5D01BE4F00B6560238C6AB00FFFF38C6ABA56414AE5D01AE5D01AE5D
          01BE4F00BE4F0048B79400FAFE00F5FF06F4F52AD3BF57A98048B79448B79448
          B79448B79418E3D900F5FF00F5FF00F2FF00F2FF00F5FF00F5FF00F2FF00F2FF
          00F2FF00F5FF00F5FF00F5FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2FF00F5
          FF00F5FF00F5FF00F2FF00F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00
          F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F5FF00F2FF00F2FF00F2FF00F2FF
          00F5FF00F5FF00F5FF00F5FF00F2FF00F5FF0FECE748B79448B79448B79448B7
          9448B79438C6AB0AEFEE00F5FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00
          F2FF00F2FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2FF00F2FF00F5FF00F5FF
          00F5FF00F2FF00F2FF00F5FF00F5FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2
          FF00F2FF000000F2FF00FAFE18E3D9629F70A56414B65602AE5D01AE5D01AE5D
          01AE5D01AE5D01AE5D01AE5D01C84701A564142AD3BF00FFFF0FECE7629F70AE
          5D0D8481432AD3BF0FECE757A9809D6C21AE5D01AE5D01AE5D01B65602927530
          48B7940FECE700F5FF00F2FF00F2FF00FAFE00FFFF00FFFF00FFFF00FFFF00FF
          FF00FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F5FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          000000F2FF00F2FF00FAFE00FAFE38C6AB848143B65602AE5D01AE5D01AE5D01
          AE5D01AE5D01A56414798B532AD3BF00F5FF00F5FF00FAFE08F2F120DBCD0FEC
          E718E3D9798B53B65602AE5D01AE5D01AE5D01AE5D0D6E956120DBCD00FFFF00
          FAFE00F2FF00F2FF00F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F5FF00F5FF00F5FF00F5FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F2FF00F2FF00F5FF00FFFF18E3D9629F70A56414B65602AE5D01AE5D01AE
          5D0184814318E3D900FFFF00FAFE00F2FF00F5FF00FFFF06F4F548B7949D6C21
          B65602AE5D01AE5D01B6560292753048B79404F8F700FFFF00FAFE00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF
          00F2FF00F2FF00F2FF00FAFE00FAFE38C6AB848143B65602B65602AE5D01AE5D
          0D798B532AD3BF00FFFF00FFFF00FFFF2AD3BF798B53B65602B65602AE5D01B6
          5602B65602798B5318E3D908F2F157A98057A9800FECE700FFFF00F5FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00FAFE00FFFF18E3D9629F70A56414B65602B65602BE4F00
          A3662148B79418E3D948B794A36621BE4F00AE5D01AE5D01B65602A3662157A9
          800AEFEE2AD3BF848143B65602BE4F00798B5320DBCD00F5FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F5FF00FFFF00FAFE38C6AB927530B65602B65602B65602AE
          5D0D927530AE5D0DBE4F00AE5D01B65602B656028481432AD3BF00FFFF00FAFE
          798B53C84701B65602AE5D01BE4F008481430FECE700FAFE00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00FAFE00FFFF18E3D9629F70AE5D0DBE4F00B65602B656
          02AE5D01AE5D01BE4F00A5641457A9800FECE700FFFF00FAFE00F5FF18E3D957
          A9809D6C21B65602BE4F009D6C2114E7E000FAFE00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00FAFE04F8F738C6AB927530B65602AE5D01B65602
          BE4F0084814338C6AB00FAFE00FFFF00F2FF00F2FF00F2FF00FFFF00FAFE2AD3
          BF848143BE4F009D6C2114E7E000FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F5FF00FAFE18E3D9629F70AE5D0DAE5D0D57A9800F
          ECE700FFFF00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FFFF0FECE7
          629F7092753018E3D900FAFE00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          000000F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F5FF00FFFF06F4F538C6AB38C6AB00FAFE00FAFE00F5
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00FFFF06F4F520
          DBCD0AEFEE00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F5FF00FFFF00FFFF00F5FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00FAFE00FAFE00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF000000F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F5FF00F5FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF
          00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00
          F2FF00F2FF00F2FF00F2FF00F2FF00F2FF00F2FF0000}
        Stretch = True
      end
      object QRLabel88: TQRLabel
        Left = 57
        Top = 62
        Width = 304
        Height = 17
        Size.Values = (
          37.482638888888890000
          125.677083333333300000
          136.701388888888900000
          670.277777777777800000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nome do Sacado'
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
      object QRShape63: TQRShape
        Left = 4
        Top = 79
        Width = 527
        Height = 2
        Size.Values = (
          4.409722222222220000
          8.819444444444440000
          174.184027777778000000
          1161.961805555560000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel135: TQRLabel
        Left = 5
        Top = 81
        Width = 48
        Height = 9
        Size.Values = (
          19.843750000000000000
          11.024305555555560000
          178.593750000000000000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel141: TQRLabel
        Left = 5
        Top = 90
        Width = 124
        Height = 14
        Size.Values = (
          30.868055555555600000
          11.024305555555600000
          198.437500000000000000
          273.402777777778000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Vencimento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel50Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRShape64: TQRShape
        Left = 4
        Top = 103
        Width = 527
        Height = 2
        Size.Values = (
          4.409722222222220000
          8.819444444444440000
          227.100694444444000000
          1161.961805555560000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel142: TQRLabel
        Left = 5
        Top = 106
        Width = 120
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          233.715277777777800000
          264.583333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Recebi(emos) o bloqueto/t'#237'tulo'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel143: TQRLabel
        Left = 5
        Top = 116
        Width = 119
        Height = 13
        Size.Values = (
          28.663194444444440000
          11.024305555555560000
          255.763888888888900000
          262.378472222222200000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'com as caracter'#237'sticas acima.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape65: TQRShape
        Left = 3
        Top = 131
        Width = 853
        Height = 6
        Size.Values = (
          13.229166666666700000
          6.614583333333330000
          288.836805555556000000
          1880.746527777780000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel144: TQRLabel
        Left = 822
        Top = 127
        Width = 19
        Height = 19
        Size.Values = (
          41.892361111111110000
          1812.395833333333000000
          280.017361111111100000
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
      object QRShape66: TQRShape
        Left = 362
        Top = 29
        Width = 6
        Height = 76
        Size.Values = (
          167.569444444444000000
          798.159722222222000000
          63.940972222222200000
          13.229166666666700000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape67: TQRShape
        Left = 129
        Top = 81
        Width = 6
        Height = 49
        Size.Values = (
          108.038194444444000000
          284.427083333333000000
          178.593750000000000000
          13.229166666666700000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel145: TQRLabel
        Left = 137
        Top = 81
        Width = 70
        Height = 9
        Size.Values = (
          19.843750000000000000
          302.065972222222200000
          178.593750000000000000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel146: TQRLabel
        Left = 137
        Top = 90
        Width = 168
        Height = 14
        Size.Values = (
          30.868055555555600000
          302.065972222222000000
          198.437500000000000000
          370.416666666667000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel56Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLabel147: TQRLabel
        Left = 137
        Top = 106
        Width = 19
        Height = 9
        Size.Values = (
          19.843750000000000000
          302.065972222222200000
          233.715277777777800000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape68: TQRShape
        Left = 304
        Top = 81
        Width = 6
        Height = 49
        Size.Values = (
          108.038194444444000000
          670.277777777778000000
          178.593750000000000000
          13.229166666666700000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel148: TQRLabel
        Left = 311
        Top = 81
        Width = 34
        Height = 9
        Size.Values = (
          19.843750000000000000
          685.711805555555600000
          178.593750000000000000
          74.965277777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Esp'#233'cie'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel149: TQRLabel
        Left = 329
        Top = 90
        Width = 16
        Height = 14
        Size.Values = (
          30.868055555555560000
          725.399305555555600000
          198.437500000000000000
          35.277777777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'R$'
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
      object QRLabel150: TQRLabel
        Left = 311
        Top = 106
        Width = 43
        Height = 9
        Size.Values = (
          19.843750000000000000
          685.711805555555600000
          233.715277777777800000
          94.809027777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Assinatura'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape69: TQRShape
        Left = 527
        Top = 29
        Width = 6
        Height = 101
        Size.Values = (
          222.690972222222000000
          1161.961805555560000000
          63.940972222222200000
          13.229166666666700000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel151: TQRLabel
        Left = 369
        Top = 81
        Width = 92
        Height = 9
        Size.Values = (
          19.843750000000000000
          813.593750000000000000
          178.593750000000000000
          202.847222222222200000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(=) Valor do Documento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel152: TQRLabel
        Left = 369
        Top = 90
        Width = 155
        Height = 14
        Size.Values = (
          30.868055555555600000
          813.593750000000000000
          198.437500000000000000
          341.753472222222000000)
        XLColumn = 0
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor do Doc.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel60Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLabel153: TQRLabel
        Left = 369
        Top = 66
        Width = 155
        Height = 14
        Size.Values = (
          30.868055555555600000
          813.593750000000000000
          145.520833333333000000
          341.753472222222000000)
        XLColumn = 0
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nosso Numero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel59Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLabel154: TQRLabel
        Left = 369
        Top = 57
        Width = 91
        Height = 9
        Size.Values = (
          19.843750000000000000
          813.593750000000000000
          125.677083333333300000
          200.642361111111100000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Carteira/Nosso N'#250'mero'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel155: TQRLabel
        Left = 369
        Top = 40
        Width = 155
        Height = 14
        Size.Values = (
          30.868055555555600000
          813.593750000000000000
          88.194444444444510000
          341.753472222222000000)
        XLColumn = 0
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Agencia'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel58Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLabel156: TQRLabel
        Left = 369
        Top = 31
        Width = 89
        Height = 9
        Size.Values = (
          19.843750000000000000
          813.593750000000000000
          68.350694444444440000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel157: TQRLabel
        Left = 535
        Top = 31
        Width = 230
        Height = 9
        Size.Values = (
          19.843750000000000000
          1179.600694444444000000
          68.350694444444440000
          507.118055555555600000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Motivos de n'#227'o entrega. (Para uso da empresa entregadora)'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape70: TQRShape
        Left = 534
        Top = 46
        Width = 15
        Height = 10
        Size.Values = (
          22.048611111111100000
          1177.395833333330000000
          101.423611111111000000
          33.072916666666700000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel158: TQRLabel
        Left = 554
        Top = 46
        Width = 38
        Height = 9
        Size.Values = (
          19.843750000000000000
          1221.493055555556000000
          101.423611111111100000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel159: TQRLabel
        Left = 554
        Top = 58
        Width = 41
        Height = 9
        Size.Values = (
          19.843750000000000000
          1221.493055555556000000
          127.881944444444400000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape71: TQRShape
        Left = 534
        Top = 58
        Width = 15
        Height = 10
        Size.Values = (
          22.048611111111100000
          1177.395833333330000000
          127.881944444444000000
          33.072916666666700000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel160: TQRLabel
        Left = 554
        Top = 70
        Width = 34
        Height = 9
        Size.Values = (
          19.843750000000000000
          1221.493055555556000000
          154.340277777777800000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape72: TQRShape
        Left = 534
        Top = 70
        Width = 15
        Height = 10
        Size.Values = (
          22.048611111111100000
          1177.395833333330000000
          154.340277777778000000
          33.072916666666700000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape73: TQRShape
        Left = 622
        Top = 46
        Width = 15
        Height = 10
        Size.Values = (
          22.048611111111100000
          1371.423611111110000000
          101.423611111111000000
          33.072916666666700000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel161: TQRLabel
        Left = 642
        Top = 46
        Width = 35
        Height = 9
        Size.Values = (
          19.843750000000000000
          1415.520833333333000000
          101.423611111111100000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel162: TQRLabel
        Left = 642
        Top = 58
        Width = 58
        Height = 9
        Size.Values = (
          19.843750000000000000
          1415.520833333333000000
          127.881944444444400000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel163: TQRLabel
        Left = 642
        Top = 70
        Width = 58
        Height = 9
        Size.Values = (
          19.843750000000000000
          1415.520833333333000000
          154.340277777777800000
          127.881944444444400000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'N'#227'o procurado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape74: TQRShape
        Left = 622
        Top = 70
        Width = 15
        Height = 10
        Size.Values = (
          22.048611111111100000
          1371.423611111110000000
          154.340277777778000000
          33.072916666666700000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape75: TQRShape
        Left = 622
        Top = 58
        Width = 15
        Height = 10
        Size.Values = (
          22.048611111111100000
          1371.423611111110000000
          127.881944444444000000
          33.072916666666700000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape76: TQRShape
        Left = 727
        Top = 46
        Width = 15
        Height = 10
        Size.Values = (
          22.048611111111100000
          1602.934027777780000000
          101.423611111111000000
          33.072916666666700000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape77: TQRShape
        Left = 727
        Top = 58
        Width = 15
        Height = 10
        Size.Values = (
          22.048611111111100000
          1602.934027777780000000
          127.881944444444000000
          33.072916666666700000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel164: TQRLabel
        Left = 747
        Top = 46
        Width = 86
        Height = 9
        Size.Values = (
          19.843750000000000000
          1647.031250000000000000
          101.423611111111100000
          189.618055555555600000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Endere'#231'o Insuficiente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel165: TQRLabel
        Left = 747
        Top = 58
        Width = 97
        Height = 9
        Size.Values = (
          19.843750000000000000
          1647.031250000000000000
          127.881944444444400000
          213.871527777777800000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'N'#227'o existe o N'#186' indicado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel166: TQRLabel
        Left = 747
        Top = 70
        Width = 98
        Height = 9
        Size.Values = (
          19.843750000000000000
          1647.031250000000000000
          154.340277777777800000
          216.076388888888900000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Outros (Anotas no Verso)'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape78: TQRShape
        Left = 727
        Top = 70
        Width = 15
        Height = 10
        Size.Values = (
          22.048611111111100000
          1602.934027777780000000
          154.340277777778000000
          33.072916666666700000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape79: TQRShape
        Left = 538
        Top = 108
        Width = 315
        Height = 2
        Size.Values = (
          4.409722222222220000
          1186.215277777780000000
          238.125000000000000000
          694.531250000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel167: TQRLabel
        Left = 566
        Top = 112
        Width = 19
        Height = 9
        Size.Values = (
          19.843750000000000000
          1247.951388888889000000
          246.944444444444400000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel168: TQRLabel
        Left = 756
        Top = 112
        Width = 43
        Height = 9
        Size.Values = (
          19.843750000000000000
          1666.875000000000000000
          246.944444444444400000
          94.809027777777780000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Entregador'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
    end
  end
end
