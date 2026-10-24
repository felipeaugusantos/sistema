object frmQckCaixaE_F_J: TfrmQckCaixaE_F_J
  Left = 326
  Top = 66
  Width = 854
  Height = 696
  AutoScroll = True
  Caption = 'frmqckBoletoCEF'
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
    Width = 794
    Height = 1123
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
      50.000000000000000000
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
    Zoom = 100
    PrevFormStyle = fsNormal
    PreviewInitialState = wsNormal
    PrevInitialZoom = qrZoomToFit
    PreviewDefaultSaveType = stQRP
    PreviewLeft = 0
    PreviewTop = 0
    object TitleBand1: TQRBand
      Left = 38
      Top = 19
      Width = 718
      Height = 1054
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        2788.708333333333000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object LinhaHorizontal6: TQRShape
        Left = 4
        Top = 593
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          10.583333333333300000
          1568.979166666670000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal5: TQRShape
        Left = 2
        Top = 487
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          1288.520833333330000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal4: TQRShape
        Left = 2
        Top = 462
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          1222.375000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal3: TQRShape
        Left = 4
        Top = 437
        Width = 711
        Height = 4
        Size.Values = (
          10.583333333333300000
          10.583333333333300000
          1156.229166666670000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal1: TQRShape
        Left = 4
        Top = 382
        Width = 711
        Height = 11
        Size.Values = (
          29.104166666666700000
          10.583333333333300000
          1010.708333333330000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal2: TQRShape
        Left = 4
        Top = 413
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          10.583333333333300000
          1092.729166666670000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaVertical1: TQRShape
        Left = 159
        Top = 367
        Width = 10
        Height = 20
        Size.Values = (
          52.916666666666700000
          420.687500000000000000
          971.020833333333000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LinhaHorizontal7: TQRShape
        Left = 4
        Top = 641
        Width = 711
        Height = 4
        Size.Values = (
          10.583333333333300000
          10.583333333333300000
          1695.979166666670000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNrBanco: TQRLabel
        Left = 165
        Top = 356
        Width = 69
        Height = 31
        Size.Values = (
          82.020833333333340000
          436.562499999999900000
          941.916666666666800000
          182.562500000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '104-0'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -25
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 19
      end
      object LabelVencimento: TQRLabel
        Left = 560
        Top = 389
        Width = 40
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          1029.229166666667000000
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
        Left = 234
        Top = 367
        Width = 9
        Height = 20
        Size.Values = (
          52.916666666666700000
          619.125000000000000000
          971.020833333333000000
          23.812500000000000000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelLocalPagamento: TQRLabel
        Left = 4
        Top = 389
        Width = 68
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          1029.229166666667000000
          179.916666666666700000)
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
        Left = 4
        Top = 416
        Width = 41
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          1100.666666666667000000
          108.479166666666700000)
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
        Left = 49
        Top = 419
        Width = 500
        Height = 15
        Size.Values = (
          39.687500000000000000
          129.645833333333300000
          1108.604166666667000000
          1322.916666666667000000)
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
        Left = 560
        Top = 416
        Width = 74
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          1100.666666666667000000
          195.791666666666700000)
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
        Left = 4
        Top = 440
        Width = 65
        Height = 8
        Size.Values = (
          21.166666666666670000
          10.583333333333330000
          1164.166666666667000000
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
        Left = 121
        Top = 440
        Width = 58
        Height = 8
        Size.Values = (
          21.166666666666670000
          320.145833333333300000
          1164.166666666667000000
          153.458333333333300000)
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
        Left = 279
        Top = 440
        Width = 45
        Height = 8
        Size.Values = (
          21.166666666666670000
          738.187500000000000000
          1164.166666666667000000
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
        Left = 346
        Top = 440
        Width = 22
        Height = 8
        Size.Values = (
          21.166666666666670000
          915.458333333333300000
          1164.166666666667000000
          58.208333333333330000)
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
        Left = 396
        Top = 440
        Width = 80
        Height = 8
        Size.Values = (
          21.166666666666670000
          1047.750000000000000000
          1164.166666666667000000
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
        Left = 560
        Top = 440
        Width = 50
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          1164.166666666667000000
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
        Left = 4
        Top = 464
        Width = 47
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          1227.666666666667000000
          124.354166666666700000)
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
        Left = 141
        Top = 464
        Width = 17
        Height = 11
        Size.Values = (
          29.104166666666670000
          373.062500000000000000
          1227.666666666667000000
          44.979166666666670000)
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
        Left = 189
        Top = 464
        Width = 28
        Height = 9
        Size.Values = (
          23.812500000000000000
          500.062500000000000000
          1227.666666666667000000
          74.083333333333330000)
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
        Left = 191
        Top = 472
        Width = 62
        Height = 15
        Size.Values = (
          39.687500000000000000
          505.354166666667000000
          1248.833333333330000000
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
        Left = 264
        Top = 464
        Width = 38
        Height = 11
        Size.Values = (
          29.104166666666670000
          698.500000000000000000
          1227.666666666667000000
          100.541666666666700000)
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
        Left = 491
        Top = 464
        Width = 19
        Height = 11
        Size.Values = (
          29.104166666666670000
          1299.104166666667000000
          1227.666666666667000000
          50.270833333333330000)
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
        Left = 480
        Top = 464
        Width = 8
        Height = 16
        Size.Values = (
          42.333333333333330000
          1270.000000000000000000
          1227.666666666667000000
          21.166666666666670000)
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
        Left = 560
        Top = 464
        Width = 78
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          1227.666666666667000000
          206.375000000000000000)
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
        Left = 4
        Top = 488
        Width = 36
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          1291.166666666667000000
          95.250000000000000000)
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
        Left = 560
        Top = 489
        Width = 79
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1293.812500000000000000
          209.020833333333300000)
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
        Left = 560
        Top = 529
        Width = 46
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1399.645833333333000000
          121.708333333333300000)
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
        Left = 560
        Top = 568
        Width = 59
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1502.833333333333000000
          156.104166666666700000)
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
        Left = 6
        Top = 598
        Width = 32
        Height = 11
        Size.Values = (
          29.104166666666670000
          15.875000000000000000
          1582.208333333333000000
          84.666666666666670000)
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
        Top = 630
        Width = 62
        Height = 10
        Size.Values = (
          26.458333333333330000
          2.645833333333333000
          1666.875000000000000000
          164.041666666666700000)
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
        Left = 569
        Top = 630
        Width = 62
        Height = 11
        Size.Values = (
          29.104166666666670000
          1505.479166666667000000
          1666.875000000000000000
          164.041666666666700000)
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
        Left = 589
        Top = 645
        Width = 44
        Height = 10
        Size.Values = (
          26.458333333333330000
          1558.395833333333000000
          1706.562500000000000000
          116.416666666666700000)
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
        Left = 556
        Top = 527
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333330000
          1471.083333333330000000
          1394.354166666670000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 556
        Top = 543
        Width = 158
        Height = 5
        Size.Values = (
          13.229166666666700000
          1471.083333333330000000
          1436.687500000000000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNomeTitular: TQRLabel
        Left = 50
        Top = 599
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666700000
          132.291666666667000000
          1584.854166666670000000
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
        Left = 50
        Top = 610
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666700000
          132.291666666667000000
          1613.958333333330000000
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
        Left = 50
        Top = 620
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666700000
          132.291666666667000000
          1640.416666666670000000
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
        Left = 555
        Top = 387
        Width = 4
        Height = 206
        Size.Values = (
          545.041666666667000000
          1468.437500000000000000
          1023.937500000000000000
          10.583333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelInformacao1: TQRLabel
        Left = 5
        Top = 400
        Width = 544
        Height = 11
        Size.Values = (
          29.104166666666700000
          13.229166666666700000
          1058.333333333330000000
          1439.333333333330000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'PREFERENCIALMENTE NAS CASAS LOT'#201'RICAS AT'#201' O VALOR LIMITE'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Left = 119
        Top = 438
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          314.854166666667000000
          1158.875000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 275
        Top = 438
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          727.604166666667000000
          1158.875000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape6: TQRShape
        Left = 344
        Top = 438
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          910.166666666667000000
          1158.875000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape8: TQRShape
        Left = 138
        Top = 463
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          365.125000000000000000
          1225.020833333330000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 184
        Top = 463
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          486.833333333333000000
          1225.020833333330000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape12: TQRShape
        Left = 483
        Top = 463
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          1277.937500000000000000
          1225.020833333330000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape16: TQRShape
        Left = 556
        Top = 563
        Width = 156
        Height = 5
        Size.Values = (
          13.229166666666700000
          1471.083333333330000000
          1489.604166666670000000
          412.750000000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape17: TQRShape
        Left = 260
        Top = 463
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          687.916666666667000000
          1225.020833333330000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel40: TQRLabel
        Left = 8
        Top = 472
        Width = 121
        Height = 15
        Size.Values = (
          39.687500000000000000
          21.166666666666700000
          1248.833333333330000000
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
        Left = 390
        Top = 438
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          1031.875000000000000000
          1158.875000000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel42: TQRLabel
        Left = 370
        Top = 447
        Width = 8
        Height = 15
        Size.Values = (
          39.687500000000000000
          978.958333333333300000
          1182.687500000000000000
          21.166666666666670000)
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
        Left = 2
        Top = 677
        Width = 711
        Height = 5
        Size.Values = (
          13.229166666666700000
          5.291666666666670000
          1791.229166666670000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRImage2: TQRImage
        Left = 6
        Top = 361
        Width = 98
        Height = 24
        Size.Values = (
          63.500000000000000000
          15.875000000000000000
          955.145833333334000000
          259.291666666667000000)
        XLColumn = 0
        AutoSize = True
        Picture.Data = {
          07544269746D61708E0E0000424D8E0E00000000000036000000280000004800
          0000110000000100180000000000580E00000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFDFAF6F4FBF8F7FAF6F4FFFEFE
          FFFFFFFFFFFFFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFEFEFDFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFF9F3F0E3CBBDCFA690C39073C39074C28E71D0A892E0C5B6F1E4DED5B1
          9ED5B19DD5B19DD5B19DD6B19CDABBA9FEFCFCFFFFFFFFFFFFFFFFFFECDCD3D5
          B19DD5B19DD5B19DD5B19DD5B19DE8D4C9E2C9BBD5B19DD5B19DD5B19DD6B19C
          D9B6A3F9FAFFB2C7FB9EB6F9A4BAF9A4BAF9A4BAF9A2B8F9B2C7FBF7F9FFFFFF
          FFFFFFFFEFE2DAD5B19ED5B19DD5B19DD5B19DD5B19DD5B19DEFE2DAE7D3C7D4
          AF9AD5B19DD5B19DD5B19DD6B39FEEDFD6FFFFFFFFFFFFFFFFFFFEFEFDD6B3A0
          D5B19DD5B19DD5B19DD5B19DD6B3A0FFFFFFFFFFFFFFFFFFF1E4DEBF8869A456
          2BA4562BA4562BA4562BA4562BA4562BA4562BD0A892BA805FA4562BA4562BA4
          562BA4562BA5572DECDBD2FFFFFFFFFFFFFFFFFFD2AC97A4562BA4562BA4562B
          A4562BA4562BD3AD99C59478A4562BA4562BA4562BA3562DAC551CF4EDEBB2C7
          FB426CEE3A6AF23A6AF23A6AF23A6AF23A6AF290ABF8F9FAFFFFFFFFC48253A3
          562DA4562BA4562BA4562BA4562BA75B32F2E6E0DDBFAFA4562BA4562BA4562B
          A4562BA4562BC49175FFFFFFFFFFFFFFFFFFFFFFFFA4562BA4562BA4562BA456
          2BA4562BAB633CFFFFFFFFFFFFEFE1DAB2714CA4562BA4562BA4562BA4562BA4
          562BA4562BA4562BA4572CCEA48DE7D3C8A6592FA4562BA4562BA4562BA4562B
          B77957C99C82C99C82C99C82B3724FA4562BA4562BA4562BA4562BA4562BEDDE
          D5D9B9A7A4562BA4562BA4562BA4562BA8592CE4CDC1FFFFFFBECEFB4975F33A
          6AF23A6AF23A6AF23A6AF23B6AF188AEFFD8C6C5B2581BA3562DA4562BA4562B
          A4562BA4562BD1AA95FFFFFFFAF6F4BD8464A4562BA4562BA4562BA4562BAA62
          3AC99A81C99C82C99C82C39074A5572DA4562BA4562BA4562BA4562BC59377FF
          FFFFFCF9F8C7987DA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562B
          A4562BB87A59FDFCFBBF896BA4562BA4562BA4562BA4562BA4562BA4562BA456
          2BA4562BA4562BA4562BA4562BA4562BA4562BAB633CF9F4F2E9D6CBA4562BA4
          562BA4562BA4562BA45730DDB89EFFFFFFFFFFFFBECEFB4975F33A6AF23A6AF2
          3A6AF23B6AF1326DFD6365A9B45314A65625A3562DA4562BA4562BAD6741F5EC
          E7FFFFFFFFFFFFE0C5B6A5572DA4562BA4562BA4562BA4562BA4562BA4562BA4
          562BA4562BA4562BA4562BA4562BA4562BA4562BD7B5A3FFFFFFECDDD4A96037
          A4562BA4562BA4562BA4562BA4562BA4562BA5592EA5592EA4562BAB643CFDFC
          FBE3CBBDA6592FA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4
          562BA4562BA4562BA4562BB97E5DFDFAF9F3E8E3A4572CA4562BA4562BA4562B
          A4562BCA9D83FFFFFFFFFFFFFFFFFFBECEFB4975F3396AF33A6AF23A6AF23B6A
          F12C6CF96365A9B45314A65625A4562BA4562BD8B7A5FFFFFFFFFFFFFFFFFFFA
          F6F4BA805FA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562B
          A4562BA4562BA4562BA4562BE7D3C7FFFFFFE4CDC1A4562BA4562BA4562BA456
          2BA4562BA5592EC59377E8D4C9E8D4C9CDA38BB26F4BEAD7CDFEFEFDC18B6DA4
          562BA4562BA4562BA4562BA4562BAB633CAC653DA5572DA4562BA4562BA4562B
          A4562BC99A81FFFFFFF8F2EEB2714CA4562BA4562BA4562BA4562BBD8566FFFF
          FFFFFFFFFFFFFFFFFFFFBECEFB4975F33A6AF23B6AF13B6AF13A6AF52C6CF963
          65A9B05418A65625B77A58F5ECE8FFFFFFFFFFFFFFFFFFFFFFFFE1C7B9A75C32
          A4562BA4562BA4562BA4562BA85E35AD6741A75C32A4562BA4562BA4562BA456
          2BA6592FF3E9E4FFFFFFE4CDC1A4562BA4562BA4562BA4562BA4562BBF896BFF
          FEFEFFFFFFFFFFFFFFFFFFEFE1D9EDDED5FFFFFFEAD7CDA96037A4562BA4562B
          A4562BA4562BD7B5A3EAD8CEAA6139A4562BA4562BA4562BA4562BDAB9A8FFFF
          FFFAF5F3BC8364A4562BA4562BA4562BA4562BB06B45FDFBFAFFFFFFFFFFFFFF
          FFFFFFFFFFBECEFB4975F3326DFD326DFD326DFD326DFD246EFE6365A9AB541D
          DDB89EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF8869A4562BA4562BA456
          2BA4562BBC8263EFE1D9C18C6EA4562BA4562BA4562BA4562BB67855F8F1EEFF
          FFFFE4CCBFA4562BA4562BA4562BA4562BA4562BD4AF9AFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC18C6EA4562BA4562BA4562BA4562BCB9E
          86F3E8E3AD6741A4562BA4562BA4562BA5572DEAD7CDFFFFFFFDFBFACB9E86A4
          562BA4562BA4562BA4562BAD6741F2E6E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          C1D3FF7795EF748EE5748EE5748EE5748EE5698EEDAC9BADF5F1F1FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFE6D1C6A75B32A4562BA4562BA4562BAA6139F0
          E4DDCB9E86A4562BA4562BA4562BA4562BC99A81FDFBFAFFFFFFE9D5CBA65B31
          A4562BA4562BA4562BA4562BC59377FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFECDCD3A85D33A4562BA4562BA4562BAA623AD5B19EAD6741A4
          562BA4562BA4562BAE6944F0E3DCFFFFFFFFFFFFD8B7A5A4562BA4562BA4562B
          A4562BA96037E5CEC1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDC5A7A2B280
          6AB28271B28271B28271BB8061AF9090B2C7FBFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFBF8869A4562BA4562BA4562BA4562BD6B3A0B97E5DA4562B
          A4562BA4562BA4562BD9B9A7FFFFFFFFFFFFF7F0EDBB8061A4562BA4562BA456
          2BA4562BA85E35E1C7B9FFFFFFFFFFFFFFFFFFF6EFEBDBBBAAF8F2EEFFFFFFFF
          FFFFC39073A4562BA4562BA4562BA4562BB57654A85E35A4562BA4562BA4562B
          BD8464F7F0EDFFFFFFFFFFFFE3CBBDA4562BA4562BA4562BA4562BA6592FD8B7
          A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECD8CBB2581BAB541DAB541DAB541DAE
          5418B8520A6365A9326DFDAEC2FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          EBDAD0A4572CA4562BA4562BA4562BB67855A75C32A4562BA4562BA4562BA456
          2BE6D1C6FFFFFFFFFFFFFFFFFFD5B19EA4562BA4562BA4562BA4562BA4562BA9
          5F37C59478E6D1C6D9B9A7B3724FB57654F6EFEBFFFFFFFFFFFFEEDFD6A6592F
          A4562BA4562BA4562BA4572CA4572CA4562BA4562BA4562BCA9D83FEFEFDFFFF
          FFFFFFFFECDDD4A75B32A4562BA4562BA4562BA4562BCEA58EFFFFFFFFFFFFFF
          FFFFFFFFFFFCF9F8C7967CA3562DA3562DA3562DA3572EB054189859412E6DF7
          376AF7426FF1B2C7FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF896BA456
          2BA4562BA4562BA4572CA4562BA4562BA4562BA4562BAB633CEFE1D9FFFFFFFF
          FFFFFFFFFFF9F4F1BE8667A4562BA4562BA4562BA4562BA4562BA4562BA5592E
          A4572CA4562BAD6741EAD8CEFFFFFFFFFFFFFEFEFDC7967CA4562BA4562BA456
          2BA4562BA4562BA4562BA4562BA4562BDABBA9FFFFFFFFFFFFFFFFFFF1E6DFB0
          6B45A4562BA4562BA4562BA4562BBD8464FFFFFFFFFFFFFFFFFFFFFFFFECDBD2
          A5572DA4562BA4562BA4562BA65625AA54206365A92C6DFE3B6AF13A6AF23E6D
          F2AEC2FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAD8CEA5572DA4562BA4562BA4
          562BA4562BA4562BA4562BA4562BBC8263F7F0EDFFFFFFFFFFFFFFFFFFFFFFFF
          EAD8CEB06D48A4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562BAA61
          39E3CBBDFFFFFFFFFFFFFFFFFFEEDFD6A65B31A4562BA4562BA4562BA4562BA4
          562BA4562BA6592FE4CDC1FFFFFFFFFFFFFFFFFFF8F2EEBC8364A4562BA4562B
          A4562BA4562BB87A59FEFEFDFFFFFFFFFFFFFFFFFFC28E72A4562BA4562BA456
          2BA3562DAA54209D57392E6DF7396AF33A6AF23A6AF23A6AF23E6DF2AEC2FAFF
          FFFFFFFFFFFFFFFFFFFFFFFBF8F7C69479A4562BA4562BA4562BA4562BA4562B
          A4562BA4562BC99C82FEFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAD7CDB77A
          58A4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562BD8B7A5FFFFFFFF
          FFFFFFFFFFFDFAF9CA9D83A4562BA4562BA4562BA4562BA4562BA4562BB2714C
          F0E3DBFFFFFFFFFFFFFFFFFFFEFEFDC7987DA4562BA4562BA4562BA4562BB16F
          4AF2E6E0FFFFFFFFFFFFECDBD2A6592FA4562BA4562BA4562BA3562DAC551CAF
          90907FA6FD3B6AF13A6AF23A6AF23A6AF23A6AF2406FF2AEC2FAFFFFFFFFFFFF
          FFFFFFFFFFFFEFE1D9AB633CA4562BA4562BA4562BA4562BA4562BA4562BD7B4
          A1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5ECE7D1AA95AD6741A4
          562BA4562BA4562BA4562BA4562BA4562BD1AA95FFFFFFFFFFFFFFFFFFFFFFFF
          F1E4DEAC653EA4562BA4562BA4562BA4562BA4562BBD8464FDFAF9FFFFFFFFFF
          FFFFFFFFFFFFFFD1AA95A4562BA4562BA4562BA4562BA5572DE2C9BBFFFFFFFB
          F8F7B77A58A4562BA4562BA4562BA4562BA3562DAD5A27F5F1F1F9FAFF7F9EF6
          3A6AF23A6AF23A6AF23A6AF23A6AF23A6AF2A2B8F9F9FAFFFFFFFFFFFFFFFDFC
          FBCCA189A4562BA4562BA4562BA4562BA4562BA4562BE1C7B9FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE1DAE0C5B6CFA690C59377
          C39074D5B19EE1C7B9F3E8E3FFFFFFFFFFFFFFFFFFFFFFFFFEFCFCE4CCBFD4AF
          9AD5B19DD5B19DD5B19DD4AF9AE6D0C4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEE
          DFD6D4AF9AD5B19DD5B19DD5B19DD6B39FF0E3DBFFFFFFFDFBFAE7D3C8E6D1C6
          E6D1C6E6D1C6E6D1C6E6D1C6EBDAD0FFFFFFFFFFFFF3F6FEAEC2FAA2B8F9A4BA
          F9A4BAF9A4BAF99EB6F9AEC2FAF3F6FEFFFFFFFFFFFFFFFFFFF2E6E0D6B39FD5
          B19DD5B19DD5B19DD4AF9AD9B9A7F6EFEBFFFFFFFFFFFFFFFFFF}
        Stretch = True
      end
      object QRShape13: TQRShape
        Left = 556
        Top = 506
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333330000
          1471.083333333330000000
          1338.791666666670000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel4: TQRLabel
        Left = 559
        Top = 509
        Width = 66
        Height = 11
        Size.Values = (
          29.104166666666670000
          1479.020833333333000000
          1346.729166666667000000
          174.625000000000000000)
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
        Left = 560
        Top = 548
        Width = 75
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1449.916666666667000000
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
        Left = 141
        Top = 472
        Width = 27
        Height = 15
        Size.Values = (
          39.687500000000000000
          373.062500000000000000
          1248.833333333333000000
          71.437500000000000000)
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
        Left = 572
        Top = 398
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          1053.041666666670000000
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
      object QRLabel51: TQRLabel
        Left = 13
        Top = 447
        Width = 100
        Height = 15
        Size.Values = (
          39.687500000000000000
          34.395833333333300000
          1182.687500000000000000
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
        Left = 133
        Top = 447
        Width = 138
        Height = 15
        Size.Values = (
          39.687500000000000000
          351.895833333333000000
          1182.687500000000000000
          365.125000000000000000)
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
        Left = 282
        Top = 447
        Width = 52
        Height = 15
        Size.Values = (
          39.687500000000000000
          746.125000000000000000
          1182.687500000000000000
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
        Left = 398
        Top = 447
        Width = 142
        Height = 15
        Size.Values = (
          39.687500000000000000
          1053.041666666670000000
          1182.687500000000000000
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
        Left = 572
        Top = 424
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          1121.833333333330000000
          351.895833333333000000)
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
        Left = 572
        Top = 447
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          1182.687500000000000000
          351.895833333333000000)
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
        Left = 572
        Top = 472
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          1248.833333333330000000
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
        Left = 20
        Top = 534
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          1412.875000000000000000
          1373.187500000000000000)
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
        Left = 20
        Top = 546
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          1444.625000000000000000
          1373.187500000000000000)
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
        Left = 20
        Top = 558
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          1476.375000000000000000
          1373.187500000000000000)
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
        Left = 20
        Top = 569
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          1505.479166666670000000
          1373.187500000000000000)
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
        Left = 20
        Top = 580
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          1534.583333333330000000
          1373.187500000000000000)
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
        Left = 636
        Top = 630
        Width = 57
        Height = 11
        Size.Values = (
          29.104166666666670000
          1682.750000000000000000
          1666.875000000000000000
          150.812500000000000000)
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
        Left = 26
        Top = 1000
        Width = 469
        Height = 28
        Size.Values = (
          74.083333333333300000
          68.791666666666700000
          2645.833333333330000000
          1240.895833333330000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = '123456789012345678901234567890123456789012345'
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
        Top = 932
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          2465.916666666670000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape11: TQRShape
        Left = 2
        Top = 817
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          2161.645833333330000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape14: TQRShape
        Left = 2
        Top = 792
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          2095.500000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape15: TQRShape
        Left = 2
        Top = 766
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          2026.708333333330000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape18: TQRShape
        Left = 2
        Top = 708
        Width = 711
        Height = 11
        Size.Values = (
          29.104166666666700000
          5.291666666666670000
          1873.250000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape19: TQRShape
        Left = 2
        Top = 741
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          1960.562500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape20: TQRShape
        Left = 159
        Top = 693
        Width = 10
        Height = 20
        Size.Values = (
          52.916666666666700000
          420.687500000000000000
          1833.562500000000000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape21: TQRShape
        Left = 2
        Top = 991
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          2622.020833333330000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel7: TQRLabel
        Left = 165
        Top = 682
        Width = 68
        Height = 31
        Size.Values = (
          82.020833333333340000
          436.562499999999900000
          1804.458333333333000000
          179.916666666666700000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '104-0'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -25
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 19
      end
      object QRLabel8: TQRLabel
        Left = 560
        Top = 716
        Width = 40
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1894.416666666667000000
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
        Left = 232
        Top = 693
        Width = 8
        Height = 20
        Size.Values = (
          52.916666666666700000
          613.833333333333000000
          1833.562500000000000000
          21.166666666666700000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel9: TQRLabel
        Left = 4
        Top = 717
        Width = 68
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          1897.062500000000000000
          179.916666666666700000)
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
        Left = 49
        Top = 750
        Width = 500
        Height = 15
        Size.Values = (
          39.687500000000000000
          129.645833333333300000
          1984.375000000000000000
          1322.916666666667000000)
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
        Left = 560
        Top = 743
        Width = 74
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1965.854166666667000000
          195.791666666666700000)
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
        Top = 768
        Width = 65
        Height = 8
        Size.Values = (
          21.166666666666670000
          5.291666666666667000
          2032.000000000000000000
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
        Left = 121
        Top = 768
        Width = 58
        Height = 8
        Size.Values = (
          21.166666666666670000
          320.145833333333300000
          2032.000000000000000000
          153.458333333333300000)
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
        Left = 278
        Top = 768
        Width = 45
        Height = 8
        Size.Values = (
          21.166666666666670000
          735.541666666666700000
          2032.000000000000000000
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
        Left = 348
        Top = 768
        Width = 22
        Height = 8
        Size.Values = (
          21.166666666666670000
          920.750000000000000000
          2032.000000000000000000
          58.208333333333330000)
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
        Left = 396
        Top = 768
        Width = 80
        Height = 8
        Size.Values = (
          21.166666666666670000
          1047.750000000000000000
          2032.000000000000000000
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
        Left = 560
        Top = 768
        Width = 50
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          2032.000000000000000000
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
        Top = 793
        Width = 47
        Height = 8
        Size.Values = (
          21.166666666666670000
          5.291666666666667000
          2098.145833333333000000
          124.354166666666700000)
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
        Left = 141
        Top = 793
        Width = 17
        Height = 8
        Size.Values = (
          21.166666666666670000
          373.062500000000000000
          2098.145833333333000000
          44.979166666666670000)
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
        Left = 189
        Top = 793
        Width = 28
        Height = 8
        Size.Values = (
          21.166666666666670000
          500.062500000000000000
          2098.145833333333000000
          74.083333333333330000)
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
        Left = 192
        Top = 802
        Width = 61
        Height = 15
        Size.Values = (
          39.687500000000000000
          508.000000000000000000
          2121.958333333330000000
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
        Left = 264
        Top = 793
        Width = 38
        Height = 8
        Size.Values = (
          21.166666666666670000
          698.500000000000000000
          2098.145833333333000000
          100.541666666666700000)
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
        Left = 493
        Top = 793
        Width = 19
        Height = 8
        Size.Values = (
          21.166666666666670000
          1304.395833333333000000
          2098.145833333333000000
          50.270833333333330000)
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
        Left = 480
        Top = 796
        Width = 8
        Height = 18
        Size.Values = (
          47.625000000000000000
          1270.000000000000000000
          2106.083333333333000000
          21.166666666666670000)
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
        Left = 560
        Top = 793
        Width = 78
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          2098.145833333333000000
          206.375000000000000000)
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
        Left = 4
        Top = 818
        Width = 36
        Height = 9
        Size.Values = (
          23.812500000000000000
          10.583333333333330000
          2164.291666666667000000
          95.250000000000000000)
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
        Left = 560
        Top = 818
        Width = 40
        Height = 9
        Size.Values = (
          23.812500000000000000
          1481.666666666667000000
          2164.291666666667000000
          105.833333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(-) Desconto'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Left = 560
        Top = 858
        Width = 67
        Height = 9
        Size.Values = (
          23.812500000000000000
          1481.666666666667000000
          2270.125000000000000000
          177.270833333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(+) Mora/Multa/Juros'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Left = 560
        Top = 894
        Width = 59
        Height = 9
        Size.Values = (
          23.812500000000000000
          1481.666666666667000000
          2365.375000000000000000
          156.104166666666700000)
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
        Left = 6
        Top = 948
        Width = 32
        Height = 9
        Size.Values = (
          23.812500000000000000
          15.875000000000000000
          2508.250000000000000000
          84.666666666666670000)
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
        Top = 982
        Width = 62
        Height = 8
        Size.Values = (
          21.166666666666670000
          5.291666666666667000
          2598.208333333333000000
          164.041666666666700000)
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
        Left = 562
        Top = 977
        Width = 62
        Height = 13
        Size.Values = (
          34.395833333333330000
          1486.958333333333000000
          2584.979166666667000000
          164.041666666666700000)
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
        Left = 536
        Top = 994
        Width = 156
        Height = 8
        Size.Values = (
          21.166666666666670000
          1418.166666666667000000
          2629.958333333333000000
          412.750000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Autentica'#231#227'o Mecanica/Ficha de Compensa'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Left = 556
        Top = 856
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333330000
          1471.083333333330000000
          2264.833333333330000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape24: TQRShape
        Left = 556
        Top = 872
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333330000
          1471.083333333330000000
          2307.166666666670000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel35: TQRLabel
        Left = 43
        Top = 947
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666700000
          113.770833333333000000
          2505.604166666670000000
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
        Left = 43
        Top = 958
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666700000
          113.770833333333000000
          2534.708333333330000000
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
        Left = 43
        Top = 969
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666700000
          113.770833333333000000
          2563.812500000000000000
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
        Left = 555
        Top = 714
        Width = 2
        Height = 211
        Size.Values = (
          558.270833333333000000
          1468.437500000000000000
          1889.125000000000000000
          5.291666666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel41: TQRLabel
        Left = 5
        Top = 728
        Width = 542
        Height = 13
        Size.Values = (
          34.395833333333300000
          13.229166666666700000
          1926.166666666670000000
          1434.041666666670000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'PREFERENCIALMENTE NAS CASAS LOT'#201'RICAS AT'#201' O VALOR LIMITE'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Left = 119
        Top = 767
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          314.854166666667000000
          2029.354166666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape29: TQRShape
        Left = 275
        Top = 767
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          727.604166666667000000
          2029.354166666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape30: TQRShape
        Left = 343
        Top = 767
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          907.520833333333000000
          2029.354166666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape31: TQRShape
        Left = 137
        Top = 791
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          362.479166666667000000
          2092.854166666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape32: TQRShape
        Left = 183
        Top = 791
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          484.187500000000000000
          2092.854166666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape33: TQRShape
        Left = 482
        Top = 791
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          1275.291666666670000000
          2092.854166666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape34: TQRShape
        Left = 556
        Top = 894
        Width = 156
        Height = 1
        Size.Values = (
          2.645833333333330000
          1471.083333333330000000
          2365.375000000000000000
          412.750000000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape35: TQRShape
        Left = 260
        Top = 791
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          687.916666666667000000
          2092.854166666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel44: TQRLabel
        Left = 7
        Top = 802
        Width = 119
        Height = 15
        Size.Values = (
          39.687500000000000000
          18.520833333333300000
          2121.958333333330000000
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
        Left = 390
        Top = 767
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          1031.875000000000000000
          2029.354166666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel45: TQRLabel
        Left = 372
        Top = 777
        Width = 8
        Height = 15
        Size.Values = (
          39.687500000000000000
          984.250000000000000000
          2055.812500000000000000
          21.166666666666670000)
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
        Left = 6
        Top = 689
        Width = 97
        Height = 24
        Size.Values = (
          63.500000000000000000
          15.875000000000000000
          1822.979166666670000000
          256.645833333333000000)
        XLColumn = 0
        AutoSize = True
        Picture.Data = {
          07544269746D61708E0E0000424D8E0E00000000000036000000280000004800
          0000110000000100180000000000580E00000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFDFAF6F4FBF8F7FAF6F4FFFEFE
          FFFFFFFFFFFFFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFEFEFDFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFF9F3F0E3CBBDCFA690C39073C39074C28E71D0A892E0C5B6F1E4DED5B1
          9ED5B19DD5B19DD5B19DD6B19CDABBA9FEFCFCFFFFFFFFFFFFFFFFFFECDCD3D5
          B19DD5B19DD5B19DD5B19DD5B19DE8D4C9E2C9BBD5B19DD5B19DD5B19DD6B19C
          D9B6A3F9FAFFB2C7FB9EB6F9A4BAF9A4BAF9A4BAF9A2B8F9B2C7FBF7F9FFFFFF
          FFFFFFFFEFE2DAD5B19ED5B19DD5B19DD5B19DD5B19DD5B19DEFE2DAE7D3C7D4
          AF9AD5B19DD5B19DD5B19DD6B39FEEDFD6FFFFFFFFFFFFFFFFFFFEFEFDD6B3A0
          D5B19DD5B19DD5B19DD5B19DD6B3A0FFFFFFFFFFFFFFFFFFF1E4DEBF8869A456
          2BA4562BA4562BA4562BA4562BA4562BA4562BD0A892BA805FA4562BA4562BA4
          562BA4562BA5572DECDBD2FFFFFFFFFFFFFFFFFFD2AC97A4562BA4562BA4562B
          A4562BA4562BD3AD99C59478A4562BA4562BA4562BA3562DAC551CF4EDEBB2C7
          FB426CEE3A6AF23A6AF23A6AF23A6AF23A6AF290ABF8F9FAFFFFFFFFC48253A3
          562DA4562BA4562BA4562BA4562BA75B32F2E6E0DDBFAFA4562BA4562BA4562B
          A4562BA4562BC49175FFFFFFFFFFFFFFFFFFFFFFFFA4562BA4562BA4562BA456
          2BA4562BAB633CFFFFFFFFFFFFEFE1DAB2714CA4562BA4562BA4562BA4562BA4
          562BA4562BA4562BA4572CCEA48DE7D3C8A6592FA4562BA4562BA4562BA4562B
          B77957C99C82C99C82C99C82B3724FA4562BA4562BA4562BA4562BA4562BEDDE
          D5D9B9A7A4562BA4562BA4562BA4562BA8592CE4CDC1FFFFFFBECEFB4975F33A
          6AF23A6AF23A6AF23A6AF23B6AF188AEFFD8C6C5B2581BA3562DA4562BA4562B
          A4562BA4562BD1AA95FFFFFFFAF6F4BD8464A4562BA4562BA4562BA4562BAA62
          3AC99A81C99C82C99C82C39074A5572DA4562BA4562BA4562BA4562BC59377FF
          FFFFFCF9F8C7987DA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562B
          A4562BB87A59FDFCFBBF896BA4562BA4562BA4562BA4562BA4562BA4562BA456
          2BA4562BA4562BA4562BA4562BA4562BA4562BAB633CF9F4F2E9D6CBA4562BA4
          562BA4562BA4562BA45730DDB89EFFFFFFFFFFFFBECEFB4975F33A6AF23A6AF2
          3A6AF23B6AF1326DFD6365A9B45314A65625A3562DA4562BA4562BAD6741F5EC
          E7FFFFFFFFFFFFE0C5B6A5572DA4562BA4562BA4562BA4562BA4562BA4562BA4
          562BA4562BA4562BA4562BA4562BA4562BA4562BD7B5A3FFFFFFECDDD4A96037
          A4562BA4562BA4562BA4562BA4562BA4562BA5592EA5592EA4562BAB643CFDFC
          FBE3CBBDA6592FA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4
          562BA4562BA4562BA4562BB97E5DFDFAF9F3E8E3A4572CA4562BA4562BA4562B
          A4562BCA9D83FFFFFFFFFFFFFFFFFFBECEFB4975F3396AF33A6AF23A6AF23B6A
          F12C6CF96365A9B45314A65625A4562BA4562BD8B7A5FFFFFFFFFFFFFFFFFFFA
          F6F4BA805FA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562B
          A4562BA4562BA4562BA4562BE7D3C7FFFFFFE4CDC1A4562BA4562BA4562BA456
          2BA4562BA5592EC59377E8D4C9E8D4C9CDA38BB26F4BEAD7CDFEFEFDC18B6DA4
          562BA4562BA4562BA4562BA4562BAB633CAC653DA5572DA4562BA4562BA4562B
          A4562BC99A81FFFFFFF8F2EEB2714CA4562BA4562BA4562BA4562BBD8566FFFF
          FFFFFFFFFFFFFFFFFFFFBECEFB4975F33A6AF23B6AF13B6AF13A6AF52C6CF963
          65A9B05418A65625B77A58F5ECE8FFFFFFFFFFFFFFFFFFFFFFFFE1C7B9A75C32
          A4562BA4562BA4562BA4562BA85E35AD6741A75C32A4562BA4562BA4562BA456
          2BA6592FF3E9E4FFFFFFE4CDC1A4562BA4562BA4562BA4562BA4562BBF896BFF
          FEFEFFFFFFFFFFFFFFFFFFEFE1D9EDDED5FFFFFFEAD7CDA96037A4562BA4562B
          A4562BA4562BD7B5A3EAD8CEAA6139A4562BA4562BA4562BA4562BDAB9A8FFFF
          FFFAF5F3BC8364A4562BA4562BA4562BA4562BB06B45FDFBFAFFFFFFFFFFFFFF
          FFFFFFFFFFBECEFB4975F3326DFD326DFD326DFD326DFD246EFE6365A9AB541D
          DDB89EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF8869A4562BA4562BA456
          2BA4562BBC8263EFE1D9C18C6EA4562BA4562BA4562BA4562BB67855F8F1EEFF
          FFFFE4CCBFA4562BA4562BA4562BA4562BA4562BD4AF9AFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC18C6EA4562BA4562BA4562BA4562BCB9E
          86F3E8E3AD6741A4562BA4562BA4562BA5572DEAD7CDFFFFFFFDFBFACB9E86A4
          562BA4562BA4562BA4562BAD6741F2E6E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          C1D3FF7795EF748EE5748EE5748EE5748EE5698EEDAC9BADF5F1F1FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFE6D1C6A75B32A4562BA4562BA4562BAA6139F0
          E4DDCB9E86A4562BA4562BA4562BA4562BC99A81FDFBFAFFFFFFE9D5CBA65B31
          A4562BA4562BA4562BA4562BC59377FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFECDCD3A85D33A4562BA4562BA4562BAA623AD5B19EAD6741A4
          562BA4562BA4562BAE6944F0E3DCFFFFFFFFFFFFD8B7A5A4562BA4562BA4562B
          A4562BA96037E5CEC1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDC5A7A2B280
          6AB28271B28271B28271BB8061AF9090B2C7FBFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFBF8869A4562BA4562BA4562BA4562BD6B3A0B97E5DA4562B
          A4562BA4562BA4562BD9B9A7FFFFFFFFFFFFF7F0EDBB8061A4562BA4562BA456
          2BA4562BA85E35E1C7B9FFFFFFFFFFFFFFFFFFF6EFEBDBBBAAF8F2EEFFFFFFFF
          FFFFC39073A4562BA4562BA4562BA4562BB57654A85E35A4562BA4562BA4562B
          BD8464F7F0EDFFFFFFFFFFFFE3CBBDA4562BA4562BA4562BA4562BA6592FD8B7
          A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECD8CBB2581BAB541DAB541DAB541DAE
          5418B8520A6365A9326DFDAEC2FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          EBDAD0A4572CA4562BA4562BA4562BB67855A75C32A4562BA4562BA4562BA456
          2BE6D1C6FFFFFFFFFFFFFFFFFFD5B19EA4562BA4562BA4562BA4562BA4562BA9
          5F37C59478E6D1C6D9B9A7B3724FB57654F6EFEBFFFFFFFFFFFFEEDFD6A6592F
          A4562BA4562BA4562BA4572CA4572CA4562BA4562BA4562BCA9D83FEFEFDFFFF
          FFFFFFFFECDDD4A75B32A4562BA4562BA4562BA4562BCEA58EFFFFFFFFFFFFFF
          FFFFFFFFFFFCF9F8C7967CA3562DA3562DA3562DA3572EB054189859412E6DF7
          376AF7426FF1B2C7FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF896BA456
          2BA4562BA4562BA4572CA4562BA4562BA4562BA4562BAB633CEFE1D9FFFFFFFF
          FFFFFFFFFFF9F4F1BE8667A4562BA4562BA4562BA4562BA4562BA4562BA5592E
          A4572CA4562BAD6741EAD8CEFFFFFFFFFFFFFEFEFDC7967CA4562BA4562BA456
          2BA4562BA4562BA4562BA4562BA4562BDABBA9FFFFFFFFFFFFFFFFFFF1E6DFB0
          6B45A4562BA4562BA4562BA4562BBD8464FFFFFFFFFFFFFFFFFFFFFFFFECDBD2
          A5572DA4562BA4562BA4562BA65625AA54206365A92C6DFE3B6AF13A6AF23E6D
          F2AEC2FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAD8CEA5572DA4562BA4562BA4
          562BA4562BA4562BA4562BA4562BBC8263F7F0EDFFFFFFFFFFFFFFFFFFFFFFFF
          EAD8CEB06D48A4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562BAA61
          39E3CBBDFFFFFFFFFFFFFFFFFFEEDFD6A65B31A4562BA4562BA4562BA4562BA4
          562BA4562BA6592FE4CDC1FFFFFFFFFFFFFFFFFFF8F2EEBC8364A4562BA4562B
          A4562BA4562BB87A59FEFEFDFFFFFFFFFFFFFFFFFFC28E72A4562BA4562BA456
          2BA3562DAA54209D57392E6DF7396AF33A6AF23A6AF23A6AF23E6DF2AEC2FAFF
          FFFFFFFFFFFFFFFFFFFFFFFBF8F7C69479A4562BA4562BA4562BA4562BA4562B
          A4562BA4562BC99C82FEFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAD7CDB77A
          58A4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562BD8B7A5FFFFFFFF
          FFFFFFFFFFFDFAF9CA9D83A4562BA4562BA4562BA4562BA4562BA4562BB2714C
          F0E3DBFFFFFFFFFFFFFFFFFFFEFEFDC7987DA4562BA4562BA4562BA4562BB16F
          4AF2E6E0FFFFFFFFFFFFECDBD2A6592FA4562BA4562BA4562BA3562DAC551CAF
          90907FA6FD3B6AF13A6AF23A6AF23A6AF23A6AF2406FF2AEC2FAFFFFFFFFFFFF
          FFFFFFFFFFFFEFE1D9AB633CA4562BA4562BA4562BA4562BA4562BA4562BD7B4
          A1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5ECE7D1AA95AD6741A4
          562BA4562BA4562BA4562BA4562BA4562BD1AA95FFFFFFFFFFFFFFFFFFFFFFFF
          F1E4DEAC653EA4562BA4562BA4562BA4562BA4562BBD8464FDFAF9FFFFFFFFFF
          FFFFFFFFFFFFFFD1AA95A4562BA4562BA4562BA4562BA5572DE2C9BBFFFFFFFB
          F8F7B77A58A4562BA4562BA4562BA4562BA3562DAD5A27F5F1F1F9FAFF7F9EF6
          3A6AF23A6AF23A6AF23A6AF23A6AF23A6AF2A2B8F9F9FAFFFFFFFFFFFFFFFDFC
          FBCCA189A4562BA4562BA4562BA4562BA4562BA4562BE1C7B9FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE1DAE0C5B6CFA690C59377
          C39074D5B19EE1C7B9F3E8E3FFFFFFFFFFFFFFFFFFFFFFFFFEFCFCE4CCBFD4AF
          9AD5B19DD5B19DD5B19DD4AF9AE6D0C4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEE
          DFD6D4AF9AD5B19DD5B19DD5B19DD6B39FF0E3DBFFFFFFFDFBFAE7D3C8E6D1C6
          E6D1C6E6D1C6E6D1C6E6D1C6EBDAD0FFFFFFFFFFFFF3F6FEAEC2FAA2B8F9A4BA
          F9A4BAF9A4BAF99EB6F9AEC2FAF3F6FEFFFFFFFFFFFFFFFFFFF2E6E0D6B39FD5
          B19DD5B19DD5B19DD4AF9AD9B9A7F6EFEBFFFFFFFFFFFFFFFFFF}
        Stretch = True
      end
      object QRShape37: TQRShape
        Left = 556
        Top = 836
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333330000
          1471.083333333330000000
          2211.916666666670000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel46: TQRLabel
        Left = 558
        Top = 838
        Width = 109
        Height = 9
        Size.Values = (
          23.812500000000000000
          1476.375000000000000000
          2217.208333333333000000
          288.395833333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '(-) Outras Dedu'#231#245'es/Abatimentos'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Left = 560
        Top = 874
        Width = 75
        Height = 9
        Size.Values = (
          23.812500000000000000
          1481.666666666667000000
          2312.458333333333000000
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
        Left = 142
        Top = 800
        Width = 27
        Height = 15
        Size.Values = (
          39.687500000000000000
          375.708333333333300000
          2116.666666666667000000
          71.437500000000000000)
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
        Left = 572
        Top = 726
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          1920.875000000000000000
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
        Left = 11
        Top = 777
        Width = 100
        Height = 15
        Size.Values = (
          39.687500000000000000
          29.104166666666700000
          2055.812500000000000000
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
        Left = 130
        Top = 777
        Width = 136
        Height = 15
        Size.Values = (
          39.687500000000000000
          343.958333333333000000
          2055.812500000000000000
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
        Left = 281
        Top = 777
        Width = 54
        Height = 15
        Size.Values = (
          39.687500000000000000
          743.479166666667000000
          2055.812500000000000000
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
        Left = 399
        Top = 777
        Width = 141
        Height = 15
        Size.Values = (
          39.687500000000000000
          1055.687500000000000000
          2055.812500000000000000
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
        Left = 572
        Top = 751
        Width = 132
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          1987.020833333330000000
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
        OnPrint = QRLabel58Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel71: TQRLabel
        Left = 578
        Top = 777
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1529.291666666670000000
          2055.812500000000000000
          351.895833333333000000)
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
        Left = 572
        Top = 802
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          2121.958333333330000000
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
        Left = 628
        Top = 977
        Width = 57
        Height = 13
        Size.Values = (
          34.395833333333330000
          1661.583333333333000000
          2584.979166666667000000
          150.812500000000000000)
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
        Left = 244
        Top = 690
        Width = 468
        Height = 23
        Size.Values = (
          60.854166666666680000
          645.583333333333400000
          1825.625000000000000000
          1238.250000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Linha Digitavel'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel67Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 13
      end
      object QRLabel80: TQRLabel
        Left = 662
        Top = 672
        Width = 16
        Height = 16
        Size.Values = (
          42.333333333333330000
          1751.541666666667000000
          1778.000000000000000000
          42.333333333333330000)
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
        Left = 26
        Top = 1017
        Width = 469
        Height = 28
        Size.Values = (
          74.083333333333300000
          68.791666666666700000
          2690.812500000000000000
          1240.895833333330000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = '123456789012345678901234567890123456789012345'
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
        Left = 26
        Top = 1031
        Width = 469
        Height = 20
        Size.Values = (
          52.916666666666700000
          68.791666666666700000
          2727.854166666670000000
          1240.895833333330000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = '123456789012345678901234567890123456789012345'
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
        Left = 20
        Top = 500
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          1322.916666666670000000
          1373.187500000000000000)
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
        Left = 20
        Top = 523
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          1383.770833333330000000
          1373.187500000000000000)
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
        Left = 385
        Top = 602
        Width = 176
        Height = 11
        Size.Values = (
          29.104166666666700000
          1018.645833333330000000
          1592.791666666670000000
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
        Left = 371
        Top = 952
        Width = 176
        Height = 11
        Size.Values = (
          29.104166666666700000
          981.604166666667000000
          2518.833333333330000000
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
      object QRLabel73: TQRLabel
        Left = 20
        Top = 512
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          1354.666666666670000000
          1373.187500000000000000)
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
        Left = 20
        Top = 871
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666700000
          2304.520833333330000000
          1370.541666666670000000)
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
        Left = 20
        Top = 884
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666700000
          2338.916666666670000000
          1370.541666666670000000)
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
        Left = 20
        Top = 898
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666700000
          2375.958333333330000000
          1370.541666666670000000)
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
        Left = 20
        Top = 910
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666700000
          2407.708333333330000000
          1370.541666666670000000)
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
        Left = 20
        Top = 919
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666700000
          2431.520833333330000000
          1370.541666666670000000)
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
        Left = 20
        Top = 832
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666700000
          2201.333333333330000000
          1370.541666666670000000)
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
        Left = 20
        Top = 858
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666700000
          2270.125000000000000000
          1370.541666666670000000)
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
        Left = 20
        Top = 844
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666700000
          2233.083333333330000000
          1370.541666666670000000)
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
        Left = 550
        Top = 655
        Width = 133
        Height = 19
        Size.Values = (
          50.270833333333330000
          1455.208333333333000000
          1733.020833333333000000
          351.895833333333300000)
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
      object QRLabel145: TQRLabel
        Left = 4
        Top = 743
        Width = 41
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          1965.854166666667000000
          108.479166666666700000)
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
        Left = 44
        Top = 489
        Width = 495
        Height = 11
        Size.Values = (
          29.104166666666700000
          116.416666666667000000
          1293.812500000000000000
          1309.687500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Texto de Responsabilidade do Cedente'
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
      object QRLabel10: TQRLabel
        Left = 44
        Top = 819
        Width = 495
        Height = 11
        Size.Values = (
          29.104166666666700000
          116.416666666667000000
          2166.937500000000000000
          1309.687500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Texto de Responsabilidade do Cedente'
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
      object QRShape38: TQRShape
        Left = 4
        Top = 241
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          10.583333333333300000
          637.645833333333000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape39: TQRShape
        Left = 2
        Top = 135
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          357.187500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape40: TQRShape
        Left = 2
        Top = 110
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          291.041666666667000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape41: TQRShape
        Left = 4
        Top = 85
        Width = 711
        Height = 4
        Size.Values = (
          10.583333333333300000
          10.583333333333300000
          224.895833333333000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape42: TQRShape
        Left = 4
        Top = 30
        Width = 711
        Height = 11
        Size.Values = (
          29.104166666666700000
          10.583333333333300000
          79.375000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape43: TQRShape
        Left = 4
        Top = 61
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          10.583333333333300000
          161.395833333333000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape44: TQRShape
        Left = 159
        Top = 15
        Width = 10
        Height = 20
        Size.Values = (
          52.916666666666700000
          420.687500000000000000
          39.687500000000000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape45: TQRShape
        Left = 4
        Top = 288
        Width = 711
        Height = 4
        Size.Values = (
          10.583333333333300000
          10.583333333333300000
          762.000000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel38: TQRLabel
        Left = 166
        Top = 4
        Width = 69
        Height = 31
        Size.Values = (
          82.020833333333340000
          439.208333333333400000
          10.583333333333330000
          182.562500000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '104-0'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -25
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 19
      end
      object QRLabel43: TQRLabel
        Left = 560
        Top = 37
        Width = 40
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          97.895833333333330000
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
      object QRShape46: TQRShape
        Left = 234
        Top = 15
        Width = 9
        Height = 20
        Size.Values = (
          52.916666666666700000
          619.125000000000000000
          39.687500000000000000
          23.812500000000000000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel89: TQRLabel
        Left = 4
        Top = 37
        Width = 68
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          97.895833333333330000
          179.916666666666700000)
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
      object QRLabel90: TQRLabel
        Left = 4
        Top = 64
        Width = 41
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          169.333333333333300000
          108.479166666666700000)
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
      object QRLabel91: TQRLabel
        Left = 49
        Top = 67
        Width = 500
        Height = 15
        Size.Values = (
          39.687500000000000000
          129.645833333333300000
          177.270833333333300000
          1322.916666666667000000)
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
      object QRLabel92: TQRLabel
        Left = 560
        Top = 64
        Width = 74
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          169.333333333333300000
          195.791666666666700000)
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
      object QRLabel93: TQRLabel
        Left = 4
        Top = 88
        Width = 65
        Height = 8
        Size.Values = (
          21.166666666666670000
          10.583333333333330000
          232.833333333333300000
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
      object QRLabel94: TQRLabel
        Left = 121
        Top = 88
        Width = 58
        Height = 8
        Size.Values = (
          21.166666666666670000
          320.145833333333300000
          232.833333333333300000
          153.458333333333300000)
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
      object QRLabel95: TQRLabel
        Left = 279
        Top = 88
        Width = 45
        Height = 8
        Size.Values = (
          21.166666666666670000
          738.187500000000000000
          232.833333333333300000
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
      object QRLabel96: TQRLabel
        Left = 346
        Top = 88
        Width = 22
        Height = 8
        Size.Values = (
          21.166666666666670000
          915.458333333333300000
          232.833333333333300000
          58.208333333333330000)
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
      object QRLabel97: TQRLabel
        Left = 396
        Top = 88
        Width = 80
        Height = 8
        Size.Values = (
          21.166666666666670000
          1047.750000000000000000
          232.833333333333300000
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
      object QRLabel98: TQRLabel
        Left = 560
        Top = 88
        Width = 50
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          232.833333333333300000
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
      object QRLabel99: TQRLabel
        Left = 4
        Top = 112
        Width = 47
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          296.333333333333300000
          124.354166666666700000)
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
      object QRLabel100: TQRLabel
        Left = 141
        Top = 112
        Width = 17
        Height = 11
        Size.Values = (
          29.104166666666670000
          373.062500000000000000
          296.333333333333300000
          44.979166666666670000)
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
      object QRLabel101: TQRLabel
        Left = 189
        Top = 112
        Width = 28
        Height = 9
        Size.Values = (
          23.812500000000000000
          500.062500000000000000
          296.333333333333300000
          74.083333333333330000)
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
      object QRLabel102: TQRLabel
        Left = 191
        Top = 119
        Width = 62
        Height = 15
        Size.Values = (
          39.687500000000000000
          505.354166666667000000
          314.854166666667000000
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
      object QRLabel103: TQRLabel
        Left = 264
        Top = 112
        Width = 38
        Height = 11
        Size.Values = (
          29.104166666666670000
          698.500000000000000000
          296.333333333333300000
          100.541666666666700000)
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
      object QRLabel104: TQRLabel
        Left = 491
        Top = 112
        Width = 19
        Height = 11
        Size.Values = (
          29.104166666666670000
          1299.104166666667000000
          296.333333333333300000
          50.270833333333330000)
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
      object QRLabel105: TQRLabel
        Left = 480
        Top = 112
        Width = 8
        Height = 16
        Size.Values = (
          42.333333333333330000
          1270.000000000000000000
          296.333333333333300000
          21.166666666666670000)
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
      object QRLabel106: TQRLabel
        Left = 560
        Top = 112
        Width = 78
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          296.333333333333300000
          206.375000000000000000)
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
      object QRLabel107: TQRLabel
        Left = 4
        Top = 136
        Width = 36
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          359.833333333333300000
          95.250000000000000000)
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
      object QRLabel108: TQRLabel
        Left = 560
        Top = 137
        Width = 79
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          362.479166666666700000
          209.020833333333300000)
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
        Left = 560
        Top = 177
        Width = 46
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          468.312500000000000000
          121.708333333333300000)
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
        Left = 560
        Top = 216
        Width = 59
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          571.500000000000000000
          156.104166666666700000)
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
        Left = 6
        Top = 246
        Width = 32
        Height = 11
        Size.Values = (
          29.104166666666670000
          15.875000000000000000
          650.875000000000000000
          84.666666666666670000)
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
      object QRLabel112: TQRLabel
        Left = 1
        Top = 278
        Width = 62
        Height = 10
        Size.Values = (
          26.458333333333330000
          2.645833333333333000
          735.541666666666700000
          164.041666666666700000)
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
      object QRLabel113: TQRLabel
        Left = 569
        Top = 278
        Width = 62
        Height = 11
        Size.Values = (
          29.104166666666670000
          1505.479166666667000000
          735.541666666666700000
          164.041666666666700000)
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
      object QRLabel114: TQRLabel
        Left = 589
        Top = 292
        Width = 44
        Height = 10
        Size.Values = (
          26.458333333333330000
          1558.395833333333000000
          772.583333333333300000
          116.416666666666700000)
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
      object QRShape47: TQRShape
        Left = 556
        Top = 175
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333330000
          1471.083333333330000000
          463.020833333333000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape48: TQRShape
        Left = 556
        Top = 191
        Width = 158
        Height = 5
        Size.Values = (
          13.229166666666700000
          1471.083333333330000000
          505.354166666667000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel115: TQRLabel
        Left = 50
        Top = 247
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666700000
          132.291666666667000000
          653.520833333333000000
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
      object QRLabel116: TQRLabel
        Left = 50
        Top = 258
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666700000
          132.291666666667000000
          682.625000000000000000
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
      object QRLabel117: TQRLabel
        Left = 50
        Top = 268
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666700000
          132.291666666667000000
          709.083333333333000000
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
      object QRShape49: TQRShape
        Left = 555
        Top = 35
        Width = 4
        Height = 206
        Size.Values = (
          545.041666666667000000
          1468.437500000000000000
          92.604166666666700000
          10.583333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel118: TQRLabel
        Left = 5
        Top = 48
        Width = 544
        Height = 11
        Size.Values = (
          29.104166666666700000
          13.229166666666700000
          127.000000000000000000
          1439.333333333330000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'PREFERENCIALMENTE NAS CASAS LOT'#201'RICAS AT'#201' O VALOR LIMITE'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape50: TQRShape
        Left = 119
        Top = 86
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          314.854166666667000000
          227.541666666667000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape51: TQRShape
        Left = 275
        Top = 86
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          727.604166666667000000
          227.541666666667000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape52: TQRShape
        Left = 344
        Top = 86
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          910.166666666667000000
          227.541666666667000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape53: TQRShape
        Left = 138
        Top = 111
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          365.125000000000000000
          293.687500000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape54: TQRShape
        Left = 184
        Top = 111
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          486.833333333333000000
          293.687500000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape55: TQRShape
        Left = 483
        Top = 111
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          1277.937500000000000000
          293.687500000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape56: TQRShape
        Left = 556
        Top = 211
        Width = 156
        Height = 5
        Size.Values = (
          13.229166666666700000
          1471.083333333330000000
          558.270833333333000000
          412.750000000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape57: TQRShape
        Left = 260
        Top = 111
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          687.916666666667000000
          293.687500000000000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel119: TQRLabel
        Left = 8
        Top = 119
        Width = 121
        Height = 15
        Size.Values = (
          39.687500000000000000
          21.166666666666700000
          314.854166666667000000
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
      object QRShape58: TQRShape
        Left = 390
        Top = 86
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          1031.875000000000000000
          227.541666666667000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel120: TQRLabel
        Left = 370
        Top = 95
        Width = 8
        Height = 15
        Size.Values = (
          39.687500000000000000
          978.958333333333300000
          251.354166666666700000
          21.166666666666670000)
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
      object QRShape59: TQRShape
        Left = 2
        Top = 339
        Width = 711
        Height = 5
        Size.Values = (
          13.229166666666700000
          5.291666666666670000
          896.937500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRImage3: TQRImage
        Left = 6
        Top = 8
        Width = 98
        Height = 24
        Size.Values = (
          63.500000000000000000
          15.875000000000000000
          21.166666666666700000
          259.291666666667000000)
        XLColumn = 0
        AutoSize = True
        Picture.Data = {
          07544269746D61708E0E0000424D8E0E00000000000036000000280000004800
          0000110000000100180000000000580E00000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFDFAF6F4FBF8F7FAF6F4FFFEFE
          FFFFFFFFFFFFFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFEFEFDFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFF9F3F0E3CBBDCFA690C39073C39074C28E71D0A892E0C5B6F1E4DED5B1
          9ED5B19DD5B19DD5B19DD6B19CDABBA9FEFCFCFFFFFFFFFFFFFFFFFFECDCD3D5
          B19DD5B19DD5B19DD5B19DD5B19DE8D4C9E2C9BBD5B19DD5B19DD5B19DD6B19C
          D9B6A3F9FAFFB2C7FB9EB6F9A4BAF9A4BAF9A4BAF9A2B8F9B2C7FBF7F9FFFFFF
          FFFFFFFFEFE2DAD5B19ED5B19DD5B19DD5B19DD5B19DD5B19DEFE2DAE7D3C7D4
          AF9AD5B19DD5B19DD5B19DD6B39FEEDFD6FFFFFFFFFFFFFFFFFFFEFEFDD6B3A0
          D5B19DD5B19DD5B19DD5B19DD6B3A0FFFFFFFFFFFFFFFFFFF1E4DEBF8869A456
          2BA4562BA4562BA4562BA4562BA4562BA4562BD0A892BA805FA4562BA4562BA4
          562BA4562BA5572DECDBD2FFFFFFFFFFFFFFFFFFD2AC97A4562BA4562BA4562B
          A4562BA4562BD3AD99C59478A4562BA4562BA4562BA3562DAC551CF4EDEBB2C7
          FB426CEE3A6AF23A6AF23A6AF23A6AF23A6AF290ABF8F9FAFFFFFFFFC48253A3
          562DA4562BA4562BA4562BA4562BA75B32F2E6E0DDBFAFA4562BA4562BA4562B
          A4562BA4562BC49175FFFFFFFFFFFFFFFFFFFFFFFFA4562BA4562BA4562BA456
          2BA4562BAB633CFFFFFFFFFFFFEFE1DAB2714CA4562BA4562BA4562BA4562BA4
          562BA4562BA4562BA4572CCEA48DE7D3C8A6592FA4562BA4562BA4562BA4562B
          B77957C99C82C99C82C99C82B3724FA4562BA4562BA4562BA4562BA4562BEDDE
          D5D9B9A7A4562BA4562BA4562BA4562BA8592CE4CDC1FFFFFFBECEFB4975F33A
          6AF23A6AF23A6AF23A6AF23B6AF188AEFFD8C6C5B2581BA3562DA4562BA4562B
          A4562BA4562BD1AA95FFFFFFFAF6F4BD8464A4562BA4562BA4562BA4562BAA62
          3AC99A81C99C82C99C82C39074A5572DA4562BA4562BA4562BA4562BC59377FF
          FFFFFCF9F8C7987DA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562B
          A4562BB87A59FDFCFBBF896BA4562BA4562BA4562BA4562BA4562BA4562BA456
          2BA4562BA4562BA4562BA4562BA4562BA4562BAB633CF9F4F2E9D6CBA4562BA4
          562BA4562BA4562BA45730DDB89EFFFFFFFFFFFFBECEFB4975F33A6AF23A6AF2
          3A6AF23B6AF1326DFD6365A9B45314A65625A3562DA4562BA4562BAD6741F5EC
          E7FFFFFFFFFFFFE0C5B6A5572DA4562BA4562BA4562BA4562BA4562BA4562BA4
          562BA4562BA4562BA4562BA4562BA4562BA4562BD7B5A3FFFFFFECDDD4A96037
          A4562BA4562BA4562BA4562BA4562BA4562BA5592EA5592EA4562BAB643CFDFC
          FBE3CBBDA6592FA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4
          562BA4562BA4562BA4562BB97E5DFDFAF9F3E8E3A4572CA4562BA4562BA4562B
          A4562BCA9D83FFFFFFFFFFFFFFFFFFBECEFB4975F3396AF33A6AF23A6AF23B6A
          F12C6CF96365A9B45314A65625A4562BA4562BD8B7A5FFFFFFFFFFFFFFFFFFFA
          F6F4BA805FA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562B
          A4562BA4562BA4562BA4562BE7D3C7FFFFFFE4CDC1A4562BA4562BA4562BA456
          2BA4562BA5592EC59377E8D4C9E8D4C9CDA38BB26F4BEAD7CDFEFEFDC18B6DA4
          562BA4562BA4562BA4562BA4562BAB633CAC653DA5572DA4562BA4562BA4562B
          A4562BC99A81FFFFFFF8F2EEB2714CA4562BA4562BA4562BA4562BBD8566FFFF
          FFFFFFFFFFFFFFFFFFFFBECEFB4975F33A6AF23B6AF13B6AF13A6AF52C6CF963
          65A9B05418A65625B77A58F5ECE8FFFFFFFFFFFFFFFFFFFFFFFFE1C7B9A75C32
          A4562BA4562BA4562BA4562BA85E35AD6741A75C32A4562BA4562BA4562BA456
          2BA6592FF3E9E4FFFFFFE4CDC1A4562BA4562BA4562BA4562BA4562BBF896BFF
          FEFEFFFFFFFFFFFFFFFFFFEFE1D9EDDED5FFFFFFEAD7CDA96037A4562BA4562B
          A4562BA4562BD7B5A3EAD8CEAA6139A4562BA4562BA4562BA4562BDAB9A8FFFF
          FFFAF5F3BC8364A4562BA4562BA4562BA4562BB06B45FDFBFAFFFFFFFFFFFFFF
          FFFFFFFFFFBECEFB4975F3326DFD326DFD326DFD326DFD246EFE6365A9AB541D
          DDB89EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF8869A4562BA4562BA456
          2BA4562BBC8263EFE1D9C18C6EA4562BA4562BA4562BA4562BB67855F8F1EEFF
          FFFFE4CCBFA4562BA4562BA4562BA4562BA4562BD4AF9AFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC18C6EA4562BA4562BA4562BA4562BCB9E
          86F3E8E3AD6741A4562BA4562BA4562BA5572DEAD7CDFFFFFFFDFBFACB9E86A4
          562BA4562BA4562BA4562BAD6741F2E6E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          C1D3FF7795EF748EE5748EE5748EE5748EE5698EEDAC9BADF5F1F1FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFE6D1C6A75B32A4562BA4562BA4562BAA6139F0
          E4DDCB9E86A4562BA4562BA4562BA4562BC99A81FDFBFAFFFFFFE9D5CBA65B31
          A4562BA4562BA4562BA4562BC59377FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFECDCD3A85D33A4562BA4562BA4562BAA623AD5B19EAD6741A4
          562BA4562BA4562BAE6944F0E3DCFFFFFFFFFFFFD8B7A5A4562BA4562BA4562B
          A4562BA96037E5CEC1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDC5A7A2B280
          6AB28271B28271B28271BB8061AF9090B2C7FBFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFBF8869A4562BA4562BA4562BA4562BD6B3A0B97E5DA4562B
          A4562BA4562BA4562BD9B9A7FFFFFFFFFFFFF7F0EDBB8061A4562BA4562BA456
          2BA4562BA85E35E1C7B9FFFFFFFFFFFFFFFFFFF6EFEBDBBBAAF8F2EEFFFFFFFF
          FFFFC39073A4562BA4562BA4562BA4562BB57654A85E35A4562BA4562BA4562B
          BD8464F7F0EDFFFFFFFFFFFFE3CBBDA4562BA4562BA4562BA4562BA6592FD8B7
          A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECD8CBB2581BAB541DAB541DAB541DAE
          5418B8520A6365A9326DFDAEC2FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          EBDAD0A4572CA4562BA4562BA4562BB67855A75C32A4562BA4562BA4562BA456
          2BE6D1C6FFFFFFFFFFFFFFFFFFD5B19EA4562BA4562BA4562BA4562BA4562BA9
          5F37C59478E6D1C6D9B9A7B3724FB57654F6EFEBFFFFFFFFFFFFEEDFD6A6592F
          A4562BA4562BA4562BA4572CA4572CA4562BA4562BA4562BCA9D83FEFEFDFFFF
          FFFFFFFFECDDD4A75B32A4562BA4562BA4562BA4562BCEA58EFFFFFFFFFFFFFF
          FFFFFFFFFFFCF9F8C7967CA3562DA3562DA3562DA3572EB054189859412E6DF7
          376AF7426FF1B2C7FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF896BA456
          2BA4562BA4562BA4572CA4562BA4562BA4562BA4562BAB633CEFE1D9FFFFFFFF
          FFFFFFFFFFF9F4F1BE8667A4562BA4562BA4562BA4562BA4562BA4562BA5592E
          A4572CA4562BAD6741EAD8CEFFFFFFFFFFFFFEFEFDC7967CA4562BA4562BA456
          2BA4562BA4562BA4562BA4562BA4562BDABBA9FFFFFFFFFFFFFFFFFFF1E6DFB0
          6B45A4562BA4562BA4562BA4562BBD8464FFFFFFFFFFFFFFFFFFFFFFFFECDBD2
          A5572DA4562BA4562BA4562BA65625AA54206365A92C6DFE3B6AF13A6AF23E6D
          F2AEC2FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAD8CEA5572DA4562BA4562BA4
          562BA4562BA4562BA4562BA4562BBC8263F7F0EDFFFFFFFFFFFFFFFFFFFFFFFF
          EAD8CEB06D48A4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562BAA61
          39E3CBBDFFFFFFFFFFFFFFFFFFEEDFD6A65B31A4562BA4562BA4562BA4562BA4
          562BA4562BA6592FE4CDC1FFFFFFFFFFFFFFFFFFF8F2EEBC8364A4562BA4562B
          A4562BA4562BB87A59FEFEFDFFFFFFFFFFFFFFFFFFC28E72A4562BA4562BA456
          2BA3562DAA54209D57392E6DF7396AF33A6AF23A6AF23A6AF23E6DF2AEC2FAFF
          FFFFFFFFFFFFFFFFFFFFFFFBF8F7C69479A4562BA4562BA4562BA4562BA4562B
          A4562BA4562BC99C82FEFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAD7CDB77A
          58A4562BA4562BA4562BA4562BA4562BA4562BA4562BA4562BD8B7A5FFFFFFFF
          FFFFFFFFFFFDFAF9CA9D83A4562BA4562BA4562BA4562BA4562BA4562BB2714C
          F0E3DBFFFFFFFFFFFFFFFFFFFEFEFDC7987DA4562BA4562BA4562BA4562BB16F
          4AF2E6E0FFFFFFFFFFFFECDBD2A6592FA4562BA4562BA4562BA3562DAC551CAF
          90907FA6FD3B6AF13A6AF23A6AF23A6AF23A6AF2406FF2AEC2FAFFFFFFFFFFFF
          FFFFFFFFFFFFEFE1D9AB633CA4562BA4562BA4562BA4562BA4562BA4562BD7B4
          A1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5ECE7D1AA95AD6741A4
          562BA4562BA4562BA4562BA4562BA4562BD1AA95FFFFFFFFFFFFFFFFFFFFFFFF
          F1E4DEAC653EA4562BA4562BA4562BA4562BA4562BBD8464FDFAF9FFFFFFFFFF
          FFFFFFFFFFFFFFD1AA95A4562BA4562BA4562BA4562BA5572DE2C9BBFFFFFFFB
          F8F7B77A58A4562BA4562BA4562BA4562BA3562DAD5A27F5F1F1F9FAFF7F9EF6
          3A6AF23A6AF23A6AF23A6AF23A6AF23A6AF2A2B8F9F9FAFFFFFFFFFFFFFFFDFC
          FBCCA189A4562BA4562BA4562BA4562BA4562BA4562BE1C7B9FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE1DAE0C5B6CFA690C59377
          C39074D5B19EE1C7B9F3E8E3FFFFFFFFFFFFFFFFFFFFFFFFFEFCFCE4CCBFD4AF
          9AD5B19DD5B19DD5B19DD4AF9AE6D0C4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEE
          DFD6D4AF9AD5B19DD5B19DD5B19DD6B39FF0E3DBFFFFFFFDFBFAE7D3C8E6D1C6
          E6D1C6E6D1C6E6D1C6E6D1C6EBDAD0FFFFFFFFFFFFF3F6FEAEC2FAA2B8F9A4BA
          F9A4BAF9A4BAF99EB6F9AEC2FAF3F6FEFFFFFFFFFFFFFFFFFFF2E6E0D6B39FD5
          B19DD5B19DD5B19DD4AF9AD9B9A7F6EFEBFFFFFFFFFFFFFFFFFF}
        Stretch = True
      end
      object QRShape60: TQRShape
        Left = 556
        Top = 154
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333330000
          1471.083333333330000000
          407.458333333333000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel121: TQRLabel
        Left = 559
        Top = 157
        Width = 66
        Height = 11
        Size.Values = (
          29.104166666666670000
          1479.020833333333000000
          415.395833333333300000
          174.625000000000000000)
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
      object QRLabel122: TQRLabel
        Left = 560
        Top = 196
        Width = 75
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          518.583333333333300000
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
      object QRLabel123: TQRLabel
        Left = 141
        Top = 119
        Width = 27
        Height = 15
        Size.Values = (
          39.687500000000000000
          373.062500000000000000
          314.854166666666700000
          71.437500000000000000)
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
      object QRLabel124: TQRLabel
        Left = 572
        Top = 45
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666667000000
          119.062500000000000000
          351.895833333333400000)
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
      object QRLabel125: TQRLabel
        Left = 13
        Top = 95
        Width = 100
        Height = 15
        Size.Values = (
          39.687500000000000000
          34.395833333333300000
          251.354166666667000000
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
      object QRLabel126: TQRLabel
        Left = 133
        Top = 95
        Width = 138
        Height = 15
        Size.Values = (
          39.687500000000000000
          351.895833333333000000
          251.354166666667000000
          365.125000000000000000)
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
      object QRLabel127: TQRLabel
        Left = 282
        Top = 95
        Width = 52
        Height = 15
        Size.Values = (
          39.687500000000000000
          746.125000000000000000
          251.354166666667000000
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
      object QRLabel128: TQRLabel
        Left = 398
        Top = 95
        Width = 142
        Height = 15
        Size.Values = (
          39.687500000000000000
          1053.041666666670000000
          251.354166666667000000
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
      object QRLabel129: TQRLabel
        Left = 572
        Top = 71
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          187.854166666667000000
          351.895833333333000000)
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
      object QRLabel130: TQRLabel
        Left = 572
        Top = 95
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          251.354166666667000000
          351.895833333333000000)
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
      object QRLabel131: TQRLabel
        Left = 572
        Top = 119
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          314.854166666667000000
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
      object QRLabel132: TQRLabel
        Left = 20
        Top = 182
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          481.541666666667000000
          1373.187500000000000000)
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
      object QRLabel133: TQRLabel
        Left = 20
        Top = 194
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          513.291666666667000000
          1373.187500000000000000)
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
      object QRLabel134: TQRLabel
        Left = 20
        Top = 206
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          545.041666666667000000
          1373.187500000000000000)
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
      object QRLabel135: TQRLabel
        Left = 20
        Top = 217
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          574.145833333333000000
          1373.187500000000000000)
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
      object QRLabel136: TQRLabel
        Left = 20
        Top = 229
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          605.895833333333000000
          1373.187500000000000000)
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
      object QRLabel137: TQRLabel
        Left = 636
        Top = 278
        Width = 57
        Height = 11
        Size.Values = (
          29.104166666666670000
          1682.750000000000000000
          735.541666666666700000
          150.812500000000000000)
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
      object QRLabel138: TQRLabel
        Left = 662
        Top = 334
        Width = 16
        Height = 16
        Size.Values = (
          42.333333333333330000
          1751.541666666667000000
          883.708333333333300000
          42.333333333333330000)
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
      object QRLabel139: TQRLabel
        Left = 20
        Top = 148
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          391.583333333333000000
          1373.187500000000000000)
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
      object QRLabel140: TQRLabel
        Left = 20
        Top = 171
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          452.437500000000000000
          1373.187500000000000000)
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
      object QRLabel141: TQRLabel
        Left = 385
        Top = 250
        Width = 176
        Height = 11
        Size.Values = (
          29.104166666666700000
          1018.645833333330000000
          661.458333333333000000
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
      object QRLabel142: TQRLabel
        Left = 20
        Top = 160
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666700000
          52.916666666666700000
          423.333333333333000000
          1373.187500000000000000)
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
      object QRLabel143: TQRLabel
        Left = 572
        Top = 16
        Width = 133
        Height = 19
        Size.Values = (
          50.270833333333330000
          1513.416666666667000000
          42.333333333333340000
          351.895833333333400000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Via da Empresa'
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
      object QRLabel144: TQRLabel
        Left = 44
        Top = 137
        Width = 495
        Height = 11
        Size.Values = (
          29.104166666666700000
          116.416666666667000000
          362.479166666667000000
          1309.687500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Texto de Responsabilidade do Cedente'
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
      object QRLabel146: TQRLabel
        Left = 244
        Top = 364
        Width = 468
        Height = 23
        Size.Values = (
          60.854166666666670000
          645.583333333333300000
          963.083333333333300000
          1238.250000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Linha Digitavel'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel67Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 13
      end
      object QRLabel147: TQRLabel
        Left = 5
        Top = 645
        Width = 483
        Height = 21
        Size.Values = (
          55.562500000000000000
          13.229166666666670000
          1706.562500000000000000
          1277.937500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'SAC CAIXA: 0800 726 0101 (informa'#231#245'es, reclama'#231#245'es, sugest'#245'es e ' +
          ' elogios) Para pessoas com defici'#234'ncia auditiva ou de fala: 0800' +
          ' 726 2492 Ouvidoria: 0800 725 7474 (reclama'#231#245'es n'#227'o solucionadas' +
          ' e den'#250'ncias) caixa.gov.br'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
