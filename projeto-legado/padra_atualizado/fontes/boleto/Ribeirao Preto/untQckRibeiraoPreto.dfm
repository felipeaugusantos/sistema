object frmQckRibeiraoPreto: TfrmQckRibeiraoPreto
  Left = 187
  Top = 14
  Width = 839
  Height = 769
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
      Height = 1068
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        2825.750000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object QRShape70: TQRShape
        Left = 2
        Top = 77
        Width = 412
        Height = 12
        Size.Values = (
          30.868055555555600000
          6.614583333333330000
          202.847222222222000000
          1091.406250000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape67: TQRShape
        Left = 2
        Top = 51
        Width = 412
        Height = 12
        Size.Values = (
          30.868055555555600000
          6.614583333333330000
          134.496527777778000000
          1091.406250000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape64: TQRShape
        Left = 413
        Top = 0
        Width = 3
        Height = 120
        Size.Values = (
          317.500000000000000000
          1093.611111111110000000
          0.000000000000000000
          8.819444444444440000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape63: TQRShape
        Left = 2
        Top = 24
        Width = 412
        Height = 12
        Size.Values = (
          30.868055555555600000
          6.614583333333330000
          63.940972222222200000
          1091.406250000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal6: TQRShape
        Left = 4
        Top = 349
        Width = 711
        Height = 1
        Size.Values = (
          3.307291666666670000
          9.921875000000000000
          922.734375000000000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal5: TQRShape
        Left = 2
        Top = 253
        Width = 711
        Height = 1
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          668.072916666667000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal4: TQRShape
        Left = 2
        Top = 227
        Width = 711
        Height = 1
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          601.927083333333000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal3: TQRShape
        Left = 4
        Top = 202
        Width = 711
        Height = 4
        Size.Values = (
          9.921875000000000000
          9.921875000000000000
          535.781250000000000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal1: TQRShape
        Left = 3
        Top = 148
        Width = 712
        Height = 12
        Size.Values = (
          30.868055555555600000
          8.819444444444440000
          390.260416666667000000
          1882.951388888890000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal2: TQRShape
        Left = 4
        Top = 179
        Width = 711
        Height = 1
        Size.Values = (
          3.307291666666670000
          9.921875000000000000
          472.942708333333000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaVertical1: TQRShape
        Left = 159
        Top = 133
        Width = 10
        Height = 20
        Size.Values = (
          52.916666666666700000
          420.026041666667000000
          350.572916666667000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LinhaHorizontal7: TQRShape
        Left = 4
        Top = 373
        Width = 711
        Height = 4
        Size.Values = (
          9.921875000000000000
          9.921875000000000000
          985.572916666667000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNrBanco: TQRLabel
        Left = 166
        Top = 133
        Width = 69
        Height = 20
        Size.Values = (
          52.916666666666700000
          439.869791666667000000
          350.572916666667000000
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
        Left = 560
        Top = 155
        Width = 40
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          410.104166666666700000
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
        Top = 133
        Width = 9
        Height = 20
        Size.Values = (
          52.916666666666700000
          618.463541666667000000
          350.572916666667000000
          23.151041666666700000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelLocalPagamento: TQRLabel
        Left = 4
        Top = 155
        Width = 68
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          410.104166666666700000
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
        Top = 181
        Width = 41
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          478.895833333333300000
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
        Top = 185
        Width = 387
        Height = 15
        Size.Values = (
          39.687500000000000000
          129.645833333333300000
          489.479166666666700000
          1023.937500000000000000)
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
        Left = 447
        Top = 181
        Width = 74
        Height = 8
        Size.Values = (
          21.166666666666670000
          1182.687500000000000000
          478.895833333333300000
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
        Top = 206
        Width = 65
        Height = 8
        Size.Values = (
          21.166666666666670000
          10.583333333333330000
          545.041666666666700000
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
        Top = 206
        Width = 58
        Height = 8
        Size.Values = (
          21.166666666666670000
          320.145833333333300000
          545.041666666666700000
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
        Top = 206
        Width = 45
        Height = 8
        Size.Values = (
          21.166666666666670000
          738.187500000000000000
          545.041666666666700000
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
        Top = 206
        Width = 22
        Height = 8
        Size.Values = (
          21.166666666666670000
          915.458333333333300000
          545.041666666666700000
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
        Top = 206
        Width = 80
        Height = 8
        Size.Values = (
          21.166666666666670000
          1047.750000000000000000
          545.041666666666700000
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
        Top = 181
        Width = 70
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          478.895833333333300000
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
        Left = 4
        Top = 230
        Width = 47
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          608.541666666666700000
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
        Top = 230
        Width = 17
        Height = 11
        Size.Values = (
          29.104166666666670000
          373.062500000000000000
          608.541666666666700000
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
        Top = 230
        Width = 37
        Height = 9
        Size.Values = (
          23.812500000000000000
          500.062500000000000000
          608.541666666666700000
          97.895833333333330000)
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
        Left = 191
        Top = 238
        Width = 62
        Height = 15
        Size.Values = (
          39.687500000000000000
          506.015625000000000000
          628.385416666667000000
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
        Left = 264
        Top = 230
        Width = 38
        Height = 11
        Size.Values = (
          29.104166666666670000
          698.500000000000000000
          608.541666666666700000
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
        Top = 230
        Width = 34
        Height = 11
        Size.Values = (
          29.104166666666670000
          1299.104166666667000000
          608.541666666666700000
          89.958333333333330000)
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
        Left = 480
        Top = 230
        Width = 8
        Height = 16
        Size.Values = (
          42.333333333333330000
          1270.000000000000000000
          608.541666666666700000
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
        Top = 206
        Width = 78
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          545.041666666666700000
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
        Top = 254
        Width = 36
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          672.041666666666700000
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
        Top = 231
        Width = 79
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          611.187500000000000000
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
        Top = 273
        Width = 46
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          722.312500000000000000
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
        Top = 315
        Width = 59
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          833.437500000000000000
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
        Top = 351
        Width = 32
        Height = 11
        Size.Values = (
          29.104166666666670000
          15.875000000000000000
          928.687500000000000000
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
        Top = 364
        Width = 62
        Height = 10
        Size.Values = (
          26.458333333333330000
          2.645833333333333000
          963.083333333333300000
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
      object LabelAutenticacaoMecanica: TQRLabel
        Left = 589
        Top = 376
        Width = 44
        Height = 10
        Size.Values = (
          26.458333333333330000
          1558.395833333333000000
          994.833333333333300000
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
        Top = 292
        Width = 158
        Height = 1
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          773.906250000000000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 556
        Top = 309
        Width = 158
        Height = 5
        Size.Values = (
          13.229166666666700000
          1471.744791666670000000
          816.901041666667000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNomeTitular: TQRLabel
        Left = 70
        Top = 350
        Width = 310
        Height = 13
        Size.Values = (
          34.395833333333300000
          185.208333333333000000
          926.041666666667000000
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
      object QRShape1: TQRShape
        Left = 555
        Top = 152
        Width = 4
        Height = 196
        Size.Values = (
          519.244791666667000000
          1468.437500000000000000
          403.489583333333000000
          9.921875000000000000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelInformacao1: TQRLabel
        Left = 5
        Top = 166
        Width = 544
        Height = 11
        Size.Values = (
          29.765625000000000000
          13.229166666666700000
          439.869791666667000000
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
        Left = 188
        Top = 154
        Width = 243
        Height = 8
        Size.Values = (
          22.048611111111100000
          498.298611111111000000
          407.899305555556000000
          643.819444444444000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pag'#225'vel preferencialmente em qualquer Ag'#234'ncia Bradesco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Top = 204
        Width = 1
        Height = 24
        Size.Values = (
          62.838541666666700000
          314.192708333333000000
          539.088541666667000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 275
        Top = 204
        Width = 1
        Height = 24
        Size.Values = (
          62.838541666666700000
          727.604166666667000000
          539.088541666667000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape6: TQRShape
        Left = 344
        Top = 204
        Width = 1
        Height = 24
        Size.Values = (
          62.838541666666700000
          909.505208333333000000
          539.088541666667000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape8: TQRShape
        Left = 137
        Top = 229
        Width = 1
        Height = 24
        Size.Values = (
          62.838541666666700000
          363.802083333333000000
          605.234375000000000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 184
        Top = 229
        Width = 1
        Height = 24
        Size.Values = (
          62.838541666666700000
          486.171875000000000000
          605.234375000000000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape12: TQRShape
        Left = 482
        Top = 229
        Width = 1
        Height = 24
        Size.Values = (
          62.838541666666700000
          1276.614583333330000000
          605.234375000000000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape16: TQRShape
        Left = 556
        Top = 329
        Width = 156
        Height = 5
        Size.Values = (
          13.229166666666700000
          1471.744791666670000000
          869.817708333334000000
          413.411458333333000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape17: TQRShape
        Left = 260
        Top = 229
        Width = 1
        Height = 24
        Size.Values = (
          62.838541666666700000
          687.916666666667000000
          605.234375000000000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel40: TQRLabel
        Left = 8
        Top = 238
        Width = 121
        Height = 15
        Size.Values = (
          39.687500000000000000
          19.843750000000000000
          628.385416666667000000
          320.807291666667000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Opera'#231#227'o 1345'
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
        Top = 204
        Width = 1
        Height = 24
        Size.Values = (
          62.838541666666700000
          1031.875000000000000000
          539.088541666667000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel42: TQRLabel
        Left = 370
        Top = 212
        Width = 8
        Height = 15
        Size.Values = (
          39.687500000000000000
          978.958333333333300000
          560.916666666666700000
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
      object QRLabel3: TQRLabel
        Left = 527
        Top = 1017
        Width = 150
        Height = 22
        Size.Values = (
          58.208333333333330000
          1394.354166666667000000
          2690.812500000000000000
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
        Top = 711
        Width = 711
        Height = 5
        Size.Values = (
          13.229166666666700000
          6.614583333333330000
          1881.848958333330000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRImage2: TQRImage
        Left = 6
        Top = 126
        Width = 121
        Height = 25
        Size.Values = (
          66.145833333333300000
          16.536458333333300000
          334.036458333333000000
          320.807291666667000000)
        XLColumn = 0
        Picture.Data = {
          07544269746D6170428A0000424D428A0000000000003600000028000000CE00
          00003900000001001800000000000C8A00000000000000000000000000000000
          0000FDFCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FDFCFBFDFCFBFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFECEDEBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FDFCFBFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFF3F4F3A4A1A1B4B4B3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FDFCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F4F3ADACAA6C6F68AFAFAEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FDFCFBFDFCFBFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F4F3ADACAA
          80807F5B5A58AFAFAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FDFC
          FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFF9FAF9AFAFAE8686827F7E7D484746AFAFAEFFFFFFFFFFFFFFFFFFFCFC
          FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FDFCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF1EDE99E89768686828E8C8A6C6F68484746AFAF
          AEFFFFFFFFFFFFFFFFFFDEE8D792AB86F9FAF9FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FDFCFBFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1EDE9927A646947278E8C
          8A8E8C8A62615F484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E9597A48889382FC
          FCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FDFCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1ED
          E9907761603F227657399C98968686825B5A58484746AFAFAEFFFFFFFFFFFFFF
          FFFFEEF2E9749A591F2D17939C8DFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFF1EDE9907761603F226947277657399C989680807F5B5A5848
          4746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E98FB270324F221F2D17939C8DFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FDFCFBFDFCFB
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF9F7F6F8F4F09A836F603F2269472776512785
          643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E999BB77
          5F86471F2D171F2D17889382F8F9F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FDFCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F0EE927A6460
          3F2269472779542A815B2A85643E9C989680807F5B5A58484746AFAFAEFFFFFF
          FFFFFFFFFFFFEEF2E999BB778FB2703B592C1F2D171F2D17889382FCFCFBFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FDFCFBFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFF1EDE9927A64603F2269472779542A815B2A815B2A85643E9C989680807F
          5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E997B875AAC48E698B572741
          1A1F2D171F2D17939C8DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFF2F0EE927A64603F22694727765229815B2A815B2A
          805A2A85643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2
          E995B773AAC48E80A566355A2327411A1F2D171F2D17939C8DFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F4F0927A64603F22694727
          765229815B2A815B2A805A2A805A2A85643E9C989680807F5B5A58484746AFAF
          AEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88AB6C477A30355A2327411A1F
          2D171F2D17939C8DFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFAFFFFFFFFFFFFF8F4F0
          9E8976603F22694727765229815B2A805A2A815B2A805A2A7F592885643E9C98
          9680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88
          AB6C4A7E30477A30355A2327411A1F2D171F2D17939C8DFBFBFAFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF9F7FFFFFFFFFFFF
          FFFFFFFFFFFFF1EDE9927A64603F2269472779542A815B2A815B2A805A2A805A
          2A805A2A7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFF
          FFFFEEF2E995B773AAC48E88AB6C4A7E304A7E30477A30355A2327411A1F2D17
          1F2D17868682FCFCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFBFBFAF1EDE9927A64603F2269472779542A815B
          2A815B2A815B2A815B2A815B2A815B2A7F592885643E9C989680807F5B5A5848
          4746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88AB6C4A7E30497D30
          497D30477A30355A2327411A1F2D171F2D17939C8DFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1EDE9927A64603F
          22694727765229815B2A815B2A805A2A805A2A815B2A805A2A815B2A7F592885
          643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773
          AAC48E88AB6C4A7E30477A30497D304A7E30477A30355A2327411A1F2D171F2D
          17939C8DFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFF6F7F59A836F603F22694727765229815B2A815B2A815B2A805A2A805A2A81
          5B2A805A2A805A2A7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFF
          FFFFFFFFFFFFEEF2E995B773AAC48E88AB6C4A7E30497D30497D30497D304A7E
          30477A30375F2527411A1F2D171F2D17D1D9CCFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFF1EDE99A836F603F2269472779542A815B2A815B2A80
          5A2A805A2A815B2A805A2A805A2A805A2A805A2A805A2A85643E9C989680807F
          5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88AB6C4A7E
          30497D30497D30497D30497D30497D30406D2C355A2327411A27411AD1D9CCFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1EDE9907761603F2269472779
          542A815B2A815B2A815B2A815B2A815B2A805A2A815B2A805A2A815B2A815B2A
          7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2
          E995B773AAC48E88AB6C4A7E30497D304A7E304A7E30477A303C6529355A232C
          4B1D3D5C30C9CDC8F8F9F7F9FAF9CCD9C4FBFBFAFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1EDE992
          7A64603F22694727765229815B2A815B2A805A2A805A2A805A2A805A2A805A2A
          805A2A805A2A805A2A805A2A7F592885643E9C989680807F5B5A58484746AFAF
          AEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88AB6C497D30497D304A7E3045
          772D3C6529355A232C4B1D3B592CBFCABBFFFFFFFFFFFFFCFCFB749A59889382
          FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFF2F0EE927A64603F22694727765229815B2A815B2A815B2A805A2A
          805A2A805A2A805A2A805A2A805A2A815B2A815B2A805A2A7F592885643E9C98
          9680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88
          AB6C4A7E30497D3045772D3C65293254222C4B1D325422C9CDC8FFFFFFFFFFFF
          FCFCFBB0BFAB3C65291F2D17939C8DFCFCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFCFE8FF9B5F529B5F1B9B5F1B9B5F1B9B5F1BDF9C1BFFFFFFCFE8FF9B5F52F0
          B752FFFFFFFFFFFFBFCFFF9B5F1BDF9C1BDFFFFF9B5F7BDF9C1BFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F529B5F1B9B5F
          1B9B5F1B9B5F1BDF9C1BFFFFFFF0FFFF9B7FA09B5F1B9B5F1BBF9C529B5F52FF
          CF7BBFCFFF9B5F1BFFCF7BFFFFFFBFCFFF9B5F1BF0B752FFFFFFCFE8FF9B5F52
          9B5F1B9B5F1BDF9C1BFFFFFFFFFFFFCFE8FF9B5F529B5F1BAD5F1BFFE8A0FFFF
          FFFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFBFCFFF9B5F1BDF
          9C1BADB7E1AD5F1BFFE8A0BFCFFF9B5F1BBF9C7B9B5F1B9B5F1BF0B752FFFFFF
          FFFFFFCFE8FF9B5F529B5F1B9B5F1BF0B752FFFFFFADB7E1AD5F1BFFE8A0CFE8
          FF9B5F52F0B752FFFFFFFFFFFFF0FFFF9B7FA09B5F1B9B5F1BBF9C529B5F52FF
          CF7BFFFFFFCFE8FF9B5F529B5F1BAD5F1BFFE8A0FFFFFFFFFFFFFFFFFFFFFFFF
          DFFFFF9B5F7BDF9C1BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B7
          52FFFFFFFFFFFFFFFFFFCFE8FF9B5F529B5F1B9B5F1BF0B752FFFFFFFFFFFF9B
          9CC29B5F1BBF5F1BFFFFC2CFE8FF9B5F529B5F1BAD5F1BFFE8A0FFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFF8F9F79E8976603F22694727765229815B2A
          815B2A805A2A815B2A815B2A805A2A815B2A805A2A815B2A815B2A805A2A815B
          2A805A2A7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFF
          FFFFEEF2E995B773AAC48E88AB6C4A7E3045772D3C65293254222C4B1D3D5C30
          D6DBD4FFFFFFFFFFFFFFFFFFB0BFAB40652F355A231F2D171F2D17939C8DFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFBFCFFF9B
          5F1BF0B752CFE8FF9B5F52F0B752FFFFFFF0FFFF9B7FA0AD5F1BFFE8A0DFFFFF
          9B5F7BDF9C1BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFCFE8FF9B5F52F0B752FFFFFFFFFFFFBFCFFF9B5F1BF0B752ADB7E19B5F1BFF
          CF7BDFFFFF9B5F7BAD5F1BFFE8A0BFCFFF9B5F1BFFCF7BFFFFFFBFCFFF9B5F1B
          F0B752CFE8FF9B5F52DF9C1BFFFFFFBFCFFF9B5F1BF0B752CFE8FF9B5F52F0B7
          52FFFFFFADB7E1AD5F1BFFE8A0FFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752FF
          FFFFF0FFFF9B7FA0AD5F1BFFE8A0ADB7E1AD5F1BFFE8A0BFCFFF9B5F1BCF7F1B
          FFFFE1ADB7E19B5F1BFFCF7BCFE8FF9B5F52DF9C1BFFFFFFBFCFFF9B5F1BFFCF
          7BADB7E1AD5F1BFFE8A0CFE8FF9B5F52F0B752FFFFFFFFFFFFADB7E19B5F1BFF
          CF7BDFFFFF9B5F7BAD5F1BFFE8A0CFE8FF9B5F52F0B752FFFFFFADB7E1AD5F1B
          FFE8A0FFFFFFFFFFFFFFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFCFE8FF9B5F52DF9C1BFFFFFFBF
          CFFF9B5F1BFFCF7BDFFFFF9B5F7BDF9C1BFFFFFFCFE8FF9B5F52F0B752FFFFFF
          ADB7E1AD5F1BFFE8A0FFFFFF0000FFFFFFFFFFFFFFFFFFF1EDE9927A64603F22
          69472779542A815B2A815B2A805A2A815B2A815B2A815B2A815B2A815B2A815B
          2A815B2A815B2A805A2A815B2A805A2A805A2A85643E9C989680807F5B5A5848
          4746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88AB6C45772D375F25
          32542227411A597A48D6DBD4FFFFFFFFFFFFF8F9F7839879355A23375F253C65
          2927411A1F2D171F2D1780807FFCFCFBFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0
          B752FFFFFFFFFFFFDFFFFF9B5F7BDF9C1BCFE8FF9B5F52F0B752FFFFFFBFCFFF
          9B5F1BDF9C1BFFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFBFCFFF9B5F1B9B5F1BCF7F1BCFE8E19B5F52F0B752FFFFFFFFFFFFDFFFFF9B
          5F7BDF9C1BADB7E1AD5F1BFFE8A0FFFFFFADB7E1AD5F1BFFE8A0BFCFFF9B5F1B
          FFCF7BFFFFFFBFCFFF9B5F1BF0B752ADB7E1AD5F1BFFE8A0FFFFFFFFFFFFFFFF
          FFFFFFFFADB7E1AD5F1BFFE8A0FFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFFFF
          FFFFCFE8FF9B5F52F0B752FFFFFFBFCFFF9B5F1BDF9C1BFFFFFFADB7E1AD5F1B
          FFE8A0BFCFFF9B5F1BFFCF7BFFFFFFDFFFFF9B5F7BDF9C1BADB7E1AD5F1BFFE8
          A0FFFFFFFFFFFFFFFFFFFFFFFFADB7E1AD5F1BFFE8A0CFE8FF9B5F52F0B752FF
          FFFFFFFFFFADB7E1AD5F1BFFE8A0FFFFFFADB7E1AD5F1BFFE8A0ADB7E1AD5F1B
          FFE8A0FFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFFFFFFFFDFFFFF9B5F7BDF9C
          1BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFAD
          B7E1AD5F1BFFE8A0FFFFFFFFFFFFFFFFFFFFFFFFDFFFFF9B5F7BDF9C1BFFFFFF
          ADB7E1AD5F1BFFE8A0FFFFFFDFFFFF9B5F7BDF9C1BFFFFFF0000FFFFFFFFFFFF
          F1EDE9927A64603F2269472779542A815B2A815B2A815B2A805A2A815B2A815B
          2A805A2A815B2A815B2A805A2A805A2A805A2A805A2A815B2A815B2A7F592885
          643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773
          AAC48E80A566375F25324F222C4B1D839879E5E9E2FFFFFFFFFFFFF9FAF9A1B1
          994E723E597A484E7B3845772D375F2527411A1F2D171F2D17939C8DFCFCFBFF
          FFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFBFCFFF9B5F1BF0B752CFE8FF
          9B5F52F0B752DFFFFF9B5F7BBF5F1BFFFFC2FFFFFFDFFFFF9B5F7B9B5F1B9B5F
          1B9B5F1B9B5F1BFFCF7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0
          B752FFFFFFFFFFFFBFCFFF9B5F1BF0B752CFE8FF9B5F52BF5F1BFFFFC2ADB7E1
          AD5F1BFFE8A0BFCFFF9B5F1BFFCF7BFFFFFFBFCFFF9B5F1BF0B752ADB7E1AD5F
          1BFFE8A0FFFFFFFFFFFFFFFFFFFFFFFF9B9CC2BF5F1BFFFFC2FFFFFFDFFFFF9B
          5F7BDF9C1BFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752DFFFFF9B5F7BBF5F1B
          FFFFC2FFFFFFADB7E1AD5F1BFFE8A0BFCFFF9B5F1BFFCF7BFFFFFFDFFFFF9B5F
          7BDF9C1BADB7E19B5F1B9B5F1B9B5F1B9B5F1B9B5F1BDF9C1BADB7E1AD5F1BFF
          E8A0CFE8FF9B5F52F0B752FFFFFFFFFFFFCFE8FF9B5F52BF5F1BFFFFC2ADB7E1
          AD5F1BFFE8A09B9CC2BF5F1BFFFFC2FFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFF
          FFFFFFFFDFFFFF9B5F7B9B5F1B9B5F1B9B5F1B9B5F1BFFCF7BFFFFFFCFE8FF9B
          5F52F0B752FFFFFFFFFFFFADB7E19B5F1B9B5F1B9B5F1B9B5F1B9B5F1BDF9C1B
          DFFFFF9B5F7BDF9C1BFFFFFF9B9CC2BF5F1BFFFFC2FFFFFFDFFFFF9B5F7BDF9C
          1BFFFFFF0000FFFFFFEBECE78F765F603F22603F22765127815B2A815B2A815B
          2A805A2A815B2A805A2A815B2A805A2A805A2A805A2A815B2A805A2A815B2A81
          5B2A815B2A805A2A805A2A85643E9C989680807F5B5A58484746AFAFAEFFFFFF
          FFFFFFFFFFFFEEF2E997B875AAC48E5F86472C4B1D2C4B1D708C62FBFBFAFFFF
          FFFFFFFFFFFFFFFCFCFBDAE5D3B7C9ADCCD9C4C7D5B9749A5945772D375F2527
          411A1F2D171F2D17939C8DFCFCFBFFFFFFCFE8FF9B5F529B5F1B9B5F1B9B5F1B
          9B5F1BF0B752FFFFFFCFE8FF9B5F529B5F1B9B5F1B9B5F1B9B5F1BFFCF7BFFFF
          FFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFF9B9CC2AD5F1BFFE8A0FFFFFFFFFFFFFF
          FFFFFFFFFFCFE8FF9B5F529B5F1B9B5F1B9B5F1B9B5F1BF0B752FFFFFFFFFFFF
          FFFFFFBFCFFF9B5F1B9B5F1BAD5F1BFFE8A0BFCFFF9B5F1BFFCF7BFFFFFFBFCF
          FF9B5F1BF0B752ADB7E1AD5F1BFFE8A0FFFFFFFFFFFFFFFFFFFFFFFFADB7E1AD
          5F1BFFE8A0FFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFFFFFFFFCFE8FF9B5F52
          9B5F1B9B5F1B9B5F1B9B5F1BFFCF7BFFFFFFADB7E1AD5F1BFFE8A0BFCFFF9B5F
          1BFFCF7BFFFFFFDFFFFF9B5F7BDF9C1BADB7E1AD5F1BFFE8A0FFFFFFCFE8FF9B
          5F52F0B752ADB7E1AD5F1BFFE8A0CFE8FF9B5F52F0B752FFFFFFFFFFFFFFFFFF
          FFFFFFBFCFFF9B5F1B9B5F1BAD5F1BFFE8A0ADB7E1AD5F1BFFE8A0FFFFFFDFFF
          FF9B5F7BDF9C1BFFFFFFFFFFFFFFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFF9B
          9CC2AD5F1BFFE8A0CFE8FF9B5F52F0B752FFFFFFFFFFFFADB7E1AD5F1BFFE8A0
          FFFFFFCFE8FF9B5F52F0B752DFFFFF9B5F7BDF9C1BFFFFFFADB7E1AD5F1BFFE8
          A0FFFFFFDFFFFF9B5F7BDF9C1BFFFFFF0000FFFFFFDACDC1AE937AB59B81C9AA
          85AA895E815A257F5928815B2A815B2A805A2A815B2A805A2A815B2A815B2A81
          5B2A815B2A815B2A805A2A805A2A815B2A805A2A7F592885643E9C989680807F
          5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E9A0BE8496B283355A232741
          1A839879ECEDEBFFFFFFFFFFFFFBFBFAFFFFFFFFFFFFFEFEFEE2EBDBCCD9C4EE
          F2E9CCD9C4749A5945772D355A232C4B1D1F2D1727411AD1D9CCFFFFFFCFE8FF
          9B5F52F0B752FFFFFFFFFFFF9B9CC2BF5F1BFFFFC2CFE8FF9B5F52F0B752FFFF
          FFFFFFFF9B9CC2AD5F1BFFE8A0DFFFFF9B5F7BDF9C1BFFFFFFFFFFFFCFE8FF9B
          5F52F0B752FFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFF
          9B9CC2BF5F1BFFFFC2CFE8FFAD5F52FFE8A0FFFFFFADB7E1AD5F1BFFE8A0BFCF
          FF9B5F1BDF9C1BFFFFFFADB7E19B5F1BFFCF7BCFE8FF9B5F52F0B752FFFFFFBF
          CFFF9B5F1BFFCF7BCFE8FF9B5F52F0B752FFFFFFADB7E1AD5F1BFFE8A0FFFFFF
          FFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFF9B9CC2AD5F1BFFE8A0ADB7
          E1AD5F1BFFE8A0BFCFFF9B5F1BDF9C1BFFFFFFADB7E19B5F1BFFCF7BCFE8FF9B
          5F52F0B752FFFFFFADB7E1AD5F1BFFE8A0ADB7E1AD5F1BFFE8A0CFE8FF9B5F52
          CF7F1BFFFFE1FFFFFFCFE8FFAD5F52FFE8A0FFFFFFADB7E1AD5F1BFFE8A0CFE8
          FF9B5F52F0B752FFFFFFADB7E1AD5F1BFFE8A0FFFFFFFFFFFFFFFFFFDFFFFF9B
          5F7BDF9C1BFFFFFFFFFFFFCFE8FF9B5F52F0B752CFE8FF9B5F52CF7F1BFFFFE1
          FFFFFFCFE8FF9B5F52F0B752FFFFFFADB7E1AD5F1BFFE8A0DFFFFF9B5F7BDF9C
          1BFFFFFFCFE8FF9B5F52F0B752FFFFFFADB7E1AD5F1BFFE8A0FFFFFF0000FFFF
          FFFEFEFEF1EAE2E4D4C2EFE7DCECE3D6AA895E7F57237F5928815B2A815B2A80
          5A2A815B2A805A2A815B2A815B2A815B2A805A2A805A2A815B2A815B2A805A2A
          7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2
          E9A0BE84597A482C4B1D939C8DF8F9F7FFFFFFFFFFFFD1D9CC839879C9CDC8FF
          FFFFFFFFFFFEFEFEDEE8D7C7D5B9EEF2E9CCD9C44E7B38355A232C4B1D324F22
          A1B199F9FAF9FFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFBFCFFF9B5F1BFFCF
          7BCFE8FF9B5F52F0B752FFFFFFFFFFFFBFCFFF9B5F1BFFCF7BDFFFFF9B5F7BDF
          9C1BFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFFFFFFFFFFFFFCFE8FF
          9B5F52F0B752FFFFFFFFFFFFBFCFFF9B5F1BFFCF7BFFFFFFADB7E19B5F1B9B5F
          1B9B5F1BF0B752FFFFFFBFCFFF9B5F1BCFB77B9B5F529B5F1BCF7F1BFFFFE1FF
          FFFFCFE8FF9B5F529B5F1B9B5F1BF0B752FFFFFFFFFFFFCFE8FF9B5F529B5F1B
          9B5F1BFFCF7BFFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFF
          FFBFCFFF9B5F1BFFCF7BADB7E1AD5F1BFFE8A0BFCFFF9B5F1BBF9C7B9B5F1B9B
          5F1BDF9C1BFFFFFFFFFFFFCFE8FF9B5F529B5F1B9B5F1BFFCF7BFFFFFFADB7E1
          AD5F1BFFE8A0CFE8FF9B5F52BF9C529B5F52AD5F1BFFE8A0ADB7E19B5F1B9B5F
          1B9B5F1BF0B752FFFFFFFFFFFFCFE8FF9B5F529B5F1B9B5F1BFFCF7BFFFFFFFF
          FFFFFFFFFFFFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFFCFE8FF9B5F52F0B752
          CFE8FF9B5F52BF9C529B5F52AD5F1BFFE8A0CFE8FF9B5F529B5F1B9B5F1BFFCF
          7BF0FFFF9B7FA09B5F1B9B5F1BCF7F1BFFFFE1CFE8FF9B5F529B5F1B9B5F1BFF
          CF7BFFFFFFFFFFFF0000FFFFFFFFFFFFFEFEFEF1EAE2DECBB3EDE5DAEDE5DAB1
          926A815A257F5928815B2A805A2A815B2A815B2A805A2A805A2A805A2A805A2A
          815B2A815B2A805A2A805A2A7F592885643E9C989680807F5B5A58484746AFAF
          AEFFFFFFFFFFFFFFFFFFEEF2E996B283325422B7C9ADFCFCFBFFFFFFFFFFFFB7
          C9AD4E723E27411A3B4835D6DBD4FFFFFFFFFFFFFEFEFEDEE8D7C7D5B9CCD9C4
          597A4827411A324F22B0BFABFBFBFAFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFF
          FFFFFFFFADB7E1AD5F1BFFE8A0CFE8FF9B5F52F0B752FFFFFFFFFFFFADB7E1AD
          5F1BFFE8A0DFFFFF9B5F7BDF9C1BFFFFFFFFFFFF9B9CC2AD5F1BFFE8A0FFFFFF
          FFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFADB7E1AD5F1BFFE8
          A0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFE8
          FF9B5F52F0B752FFFFFFFFFFFFADB7E1AD5F1BFFE8A0FFFFFFFFFFFFFFFFFFBF
          CFFF9B5F1BFFCF7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFF9B5F7BDF9C1BFFFFFF
          FFFFFF9B9CC2AD5F1BFFE8A0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFE
          FEFEF1EAE2DDCAB0EFE7DCEFE8DFB1926A815A25805A2A815B2A805A2A815B2A
          815B2A805A2A815B2A805A2A815B2A805A2A815B2A805A2A805A2A85643E9C98
          9680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E992AB86B0BFABFE
          FEFEFFFFFFFFFFFFC7D5B9355A23375F252C4B1D1F2D175B5A58EBECE7FFFFFF
          FFFFFFFEFEFEDAE5D3B7C9AD4E723E27411AABB9A5FEFEFEFFFFFFFFFFFFFFFF
          FFCFE8FF9B5F529B5F1B9B5F1B9B5F1B9B5F1BF0B752FFFFFFCFE8FF9B5F529B
          5F1B9B5F1B9B5F1B9B5F1BF0B752FFFFFFDFFFFF9B5F7B9B5F1B9B5F1B9B5F1B
          9B5F1BF0B752FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F529B5F1B9B5F
          1B9B5F1B9B5F1BF0B752FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFCFE8FF9B5F529B5F1B9B5F1B9B5F1B9B5F1BF0B752FF
          FFFFADB7E1AD5F1BFFE8A0BFCFFF9B5F1BFFCF7BFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB7E1AD5F1BFFE8A0FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFBF7FA0FFFFC29B9CC2BF5F1BFFFFC2FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          DFFFFF9B5F7B9B5F1B9B5F1B9B5F1B9B5F1BF0B752FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF
          E8FFDF9C52FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEEFE8DFDECBB3EFE7DCEDE5DAB5976F
          815B2A7F5928815B2A805A2A815B2A805A2A805A2A815B2A805A2A815B2A805A
          2A815B2A7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFF
          FFFFEEF2E9CCD9C4FFFFFFFFFFFFFFFFFFB7C9AD375F253C6529406D2C325422
          1F2D171F2D17606B5AECEDEBFFFFFFFFFFFFFEFEFEDAE5D34E723EA1B199FEFE
          FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9B9CC2AD
          5F1BFFE8A09B9CC2FFCF7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE
          ECE3D6DDCAB0EFE7DCEFE8DFAC8C627C541F7F5928815B2A815B2A805A2A815B
          2A805A2A815B2A805A2A815B2A805A2A805A2A85643E9C989680807F5B5A5848
          4746AFAFAEFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFCFCFBB0BFAB40652F
          3C6529406D2C477A30406D2C27411A1F2D171F2D176C6F68FCFCFBFFFFFFFFFF
          FFE5E9E2B0BFABFBFBFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEEFE8DFDFCEB6ECE3D6EBDFD1B1926A815A
          257F5928815B2A815B2A815B2A815B2A805A2A815B2A815B2A805A2A805A2A85
          643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          EBECE789A47B355A233C6529406D2C497D304A7E30497D30406D2C27411A1F2D
          171F2D17F3F4F3FFFFFFFFFFFFFBFBFAFCFCFBFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF1EA
          E2DDCAB0EDE5DAEFE7DCAC8C62815B2A7F5928815B2A805A2A815B2A805A2A81
          5B2A805A2A815B2A7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFF
          FFFFFFFFFFFFFFFFFFE5E9E2708C62375F253C6529406D2C497D304A7E30497D
          304A7E30477A302C4B1D1F2D1727411AF3F4F3FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFEFEFEF1EAE2DFCEB6EFE7DCEFE7DCB5976F815A257F
          5928815B2A815B2A815B2A815B2A815B2A805A2A805A2A85643E9C989680807F
          5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFF3F4F3698B57355A233C65294577
          2D497D304A7E30497D30497D304A7E30477A30324F221F2D1727411AF9FAF9FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEEDE5DADE
          CBB3EFE7DCEFE7DCB1926A815A257F5928805A2A805A2A815B2A805A2A805A2A
          7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2
          E9749A595F86474A7E30497D304A7E30497D30497D30497D30497D30406D2C32
          542227411A2C4B1DFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFBF9F7FEFEFEEDE5DADECBB3EDE5DAEFE7DCAA895E7F57237F5928
          815B2A805A2A815B2A805A2A7F592885643E9C989680807F5B5A58484746AFAF
          AEFFFFFFFFFFFFFFFFFFEEF2E997B875AAC48E80A5664A7E30497D30497D304A
          7E30477A30406D2C355A232C4B1D324F22B0BFABFEFEFEFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF9F7FEFEFEEFE8DFDFCEB6
          ECE3D6EBDFD1B1926A815B2A7F5928805A2A815B2A805A2A7F592885643E9C98
          9680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88
          AB6C4A7E30497D304A7E30477A303C6529355A232C4B1D39552BB0BFABFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFEFEFEF1EDE9DDCAB0EFE7DCEFE8DFB1926A815A257F5928805A
          2A815B2A7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFF
          FFFFEEF2E995B773AAC48E88AB6C4A7E30497D30477A303C65293254222C4B1D
          2C4B1DB0BFABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF9F7FEFEFEF1EAE2DDCAB0EDE5
          DAEFE8DFB5976F815B2A7F5928815B2A7F592885643E9C989680807F5B5A5848
          4746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88AB6C4A7E30497D30
          406D2C3254222C4B1D324F22ABB9A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFBF9F7FEFEFEEDE5DADECBB3EDE5DAEFE8DFB1926A7F57237F5928805A2A85
          643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773
          AAC48E88AB6C497D30406D2C355A232C4B1D324F22ABB9A5FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEEDE5DADECBB3EFE7DCEB
          DFD1AC8C627F57237F592685643E9C989680807F5B5A58484746AFAFAEFFFFFF
          FFFFFFFFFFFFEEF2E995B773AAC48E88AB6C406D2C355A232C4B1D39552BABB9
          A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFEFEFEF1EAE2DDCAB0ECE3D6EFE7DCAC8C62815A2585643E9C989680807F
          5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E749A593254
          222C4B1D324F22D1D9CCFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF1EDE9DFCEB6EDE5DAEFE8DF
          B5976F85643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2
          E999BB77A0BE844E723E27411A324F22B0BFABFEFEFEFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FEFEFEF1EAE2DDCAB0EFE7DCECE3D6B59B819C989680807F5B5A58484746AFAF
          AEFFFFFFFFFFFFFFFFFFEEF2E9A0BE8489A47B2C4B1D2C4B1DABB9A5FCFCFBFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEEDE5DADDCAB0EDE5DAF1EDE9C2C0
          BF7F7E7D5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E9A0BE844E723E27
          411AB0BFABFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
          FEEDE5DADFCEB6EDE5DAECEDEB9C98965B5A58484746AFAFAEFFFFFFFFFFFFFF
          FFFFEEF2E996B2833D5C30B0BFABFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF1EAE2DFCEB6F6F7F5C9CDC862615F48
          4746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E989A47BBFCABBFCFCFBFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF2
          F0EEECEDEBF2F0EE868682484746AFAFAEFFFFFFFFFFFFFFFFFFE5E9E2CCD9C4
          FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFEFEFEF3F4F3F2F0EEADACAA484746AFAFAEFFFFFF
          FFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF3F4F3
          D6DBD462615FAFAFAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEF8F9F7A4A1A1B4B4B3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFC9CD
          C8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
          FFFFFFFFFFFFFFFFFFFFFFFF0000}
        Stretch = True
      end
      object QRShape13: TQRShape
        Left = 557
        Top = 271
        Width = 158
        Height = 1
        Size.Values = (
          3.307291666666670000
          1475.052083333330000000
          717.682291666667000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel4: TQRLabel
        Left = 559
        Top = 255
        Width = 66
        Height = 11
        Size.Values = (
          29.104166666666670000
          1479.020833333333000000
          674.687500000000000000
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
        Top = 296
        Width = 75
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          783.166666666666700000
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
        Top = 238
        Width = 27
        Height = 15
        Size.Values = (
          39.687500000000000000
          373.062500000000000000
          629.708333333333300000
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
        Top = 164
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666667000000
          433.916666666666800000
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
      object QRLabel51: TQRLabel
        Left = 13
        Top = 212
        Width = 100
        Height = 15
        Size.Values = (
          39.687500000000000000
          33.072916666666700000
          562.239583333333000000
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
        Top = 212
        Width = 137
        Height = 15
        Size.Values = (
          39.687500000000000000
          350.572916666667000000
          562.239583333333000000
          363.802083333333000000)
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
        Left = 283
        Top = 212
        Width = 52
        Height = 15
        Size.Values = (
          39.687500000000000000
          747.447916666667000000
          562.239583333333000000
          138.906250000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Outros'
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
      object QRLabel57: TQRLabel
        Left = 398
        Top = 212
        Width = 142
        Height = 15
        Size.Values = (
          39.687500000000000000
          1051.718750000000000000
          562.239583333333000000
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
        Left = 446
        Top = 189
        Width = 108
        Height = 15
        Size.Values = (
          39.687500000000000000
          1180.041666666670000000
          500.062500000000000000
          285.750000000000000000)
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
        Top = 188
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1514.739583333330000000
          496.093750000000000000
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
        Left = 572
        Top = 213
        Width = 132
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          563.562500000000000000
          349.250000000000000000)
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
        Left = 44
        Top = 290
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          115.755208333333000000
          767.291666666667000000
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
        Left = 44
        Top = 301
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          115.755208333333000000
          797.057291666667000000
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
        Left = 44
        Top = 314
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          115.755208333333000000
          830.130208333334000000
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
        Left = 44
        Top = 325
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          115.755208333333000000
          859.895833333333000000
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
        Left = 44
        Top = 336
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          115.755208333333000000
          889.661458333334000000
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
      object QRLabel68: TQRLabel
        Left = 26
        Top = 1010
        Width = 461
        Height = 20
        Size.Values = (
          52.916666666666670000
          68.791666666666670000
          2672.291666666667000000
          1219.729166666667000000)
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
        Top = 958
        Width = 711
        Height = 1
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          2533.385416666670000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape11: TQRShape
        Left = 2
        Top = 850
        Width = 711
        Height = 1
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          2248.958333333330000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape14: TQRShape
        Left = 2
        Top = 825
        Width = 711
        Height = 1
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          2182.812500000000000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape15: TQRShape
        Left = 2
        Top = 800
        Width = 711
        Height = 1
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          2116.666666666670000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape18: TQRShape
        Left = 2
        Top = 742
        Width = 711
        Height = 11
        Size.Values = (
          29.765625000000000000
          6.614583333333330000
          1964.531250000000000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape19: TQRShape
        Left = 2
        Top = 775
        Width = 711
        Height = 1
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          2050.520833333330000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape20: TQRShape
        Left = 159
        Top = 728
        Width = 10
        Height = 20
        Size.Values = (
          52.916666666666700000
          420.026041666667000000
          1924.843750000000000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape21: TQRShape
        Left = 2
        Top = 1004
        Width = 711
        Height = 1
        Size.Values = (
          3.307291666666670000
          6.614583333333330000
          2655.755208333330000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel7: TQRLabel
        Left = 167
        Top = 728
        Width = 68
        Height = 20
        Size.Values = (
          52.916666666666700000
          443.177083333333000000
          1924.843750000000000000
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
        Left = 560
        Top = 750
        Width = 40
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1984.375000000000000000
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
        Top = 728
        Width = 8
        Height = 20
        Size.Values = (
          52.916666666666700000
          615.156250000000000000
          1924.843750000000000000
          19.843750000000000000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel9: TQRLabel
        Left = 4
        Top = 751
        Width = 68
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          1987.020833333333000000
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
        Left = 48
        Top = 784
        Width = 501
        Height = 15
        Size.Values = (
          39.687500000000000000
          127.000000000000000000
          2074.333333333333000000
          1325.562500000000000000)
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
        Top = 778
        Width = 74
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          2058.458333333333000000
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
        Top = 802
        Width = 65
        Height = 8
        Size.Values = (
          21.166666666666670000
          5.291666666666667000
          2121.958333333333000000
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
        Top = 802
        Width = 58
        Height = 8
        Size.Values = (
          21.166666666666670000
          320.145833333333300000
          2121.958333333333000000
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
        Top = 802
        Width = 45
        Height = 8
        Size.Values = (
          21.166666666666670000
          735.541666666666700000
          2121.958333333333000000
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
        Top = 802
        Width = 22
        Height = 8
        Size.Values = (
          21.166666666666670000
          920.750000000000000000
          2121.958333333333000000
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
        Top = 802
        Width = 80
        Height = 8
        Size.Values = (
          21.166666666666670000
          1047.750000000000000000
          2121.958333333333000000
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
        Top = 801
        Width = 70
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          2119.312500000000000000
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
        Top = 826
        Width = 47
        Height = 8
        Size.Values = (
          21.166666666666670000
          5.291666666666667000
          2185.458333333333000000
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
        Top = 826
        Width = 17
        Height = 8
        Size.Values = (
          21.166666666666670000
          373.062500000000000000
          2185.458333333333000000
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
        Top = 826
        Width = 37
        Height = 8
        Size.Values = (
          21.166666666666670000
          500.062500000000000000
          2185.458333333333000000
          97.895833333333330000)
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
        Left = 193
        Top = 835
        Width = 61
        Height = 15
        Size.Values = (
          39.687500000000000000
          509.322916666667000000
          2209.270833333330000000
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
        Left = 264
        Top = 826
        Width = 38
        Height = 8
        Size.Values = (
          21.166666666666670000
          698.500000000000000000
          2185.458333333333000000
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
        Top = 826
        Width = 34
        Height = 8
        Size.Values = (
          21.166666666666670000
          1304.395833333333000000
          2185.458333333333000000
          89.958333333333330000)
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
        Left = 480
        Top = 829
        Width = 8
        Height = 18
        Size.Values = (
          47.625000000000000000
          1270.000000000000000000
          2193.395833333333000000
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
        Top = 827
        Width = 78
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          2188.104166666667000000
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
        Left = 2
        Top = 853
        Width = 36
        Height = 9
        Size.Values = (
          23.812500000000000000
          5.291666666666667000
          2256.895833333333000000
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
        Top = 853
        Width = 79
        Height = 9
        Size.Values = (
          23.812500000000000000
          1481.666666666667000000
          2256.895833333333000000
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
      object QRLabel29: TQRLabel
        Left = 560
        Top = 892
        Width = 46
        Height = 9
        Size.Values = (
          23.812500000000000000
          1481.666666666667000000
          2360.083333333333000000
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
      object QRLabel30: TQRLabel
        Left = 560
        Top = 927
        Width = 59
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          2452.687500000000000000
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
        Left = 4
        Top = 961
        Width = 32
        Height = 8
        Size.Values = (
          21.166666666666670000
          10.583333333333330000
          2542.645833333333000000
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
        Top = 995
        Width = 62
        Height = 8
        Size.Values = (
          21.166666666666670000
          5.291666666666667000
          2632.604166666667000000
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
      object QRLabel34: TQRLabel
        Left = 588
        Top = 1007
        Width = 44
        Height = 8
        Size.Values = (
          21.166666666666670000
          1555.750000000000000000
          2664.354166666667000000
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
      object QRShape23: TQRShape
        Left = 556
        Top = 890
        Width = 158
        Height = 1
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          2354.791666666670000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape24: TQRShape
        Left = 556
        Top = 906
        Width = 158
        Height = 1
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          2397.786458333330000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel35: TQRLabel
        Left = 43
        Top = 960
        Width = 310
        Height = 11
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2540.000000000000000000
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
        Top = 971
        Width = 310
        Height = 11
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2569.765625000000000000
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
        Top = 982
        Width = 310
        Height = 11
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2599.531250000000000000
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
        Top = 749
        Width = 2
        Height = 211
        Size.Values = (
          558.932291666667000000
          1468.437500000000000000
          1981.067708333330000000
          6.614583333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel41: TQRLabel
        Left = 5
        Top = 763
        Width = 542
        Height = 13
        Size.Values = (
          33.072916666666700000
          13.229166666666700000
          2017.447916666670000000
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
        Left = 189
        Top = 750
        Width = 244
        Height = 8
        Size.Values = (
          19.843750000000000000
          499.401041666667000000
          1984.375000000000000000
          644.921875000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pag'#225'vel preferencialmente em qualquer Ag'#234'ncia Bradesco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Top = 801
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          314.192708333333000000
          2119.973958333330000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape29: TQRShape
        Left = 275
        Top = 801
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          727.604166666667000000
          2119.973958333330000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape30: TQRShape
        Left = 344
        Top = 801
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          909.505208333333000000
          2119.973958333330000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape31: TQRShape
        Left = 137
        Top = 825
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          363.802083333333000000
          2182.812500000000000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape32: TQRShape
        Left = 184
        Top = 825
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          486.171875000000000000
          2182.812500000000000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape33: TQRShape
        Left = 482
        Top = 825
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          1276.614583333330000000
          2182.812500000000000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape34: TQRShape
        Left = 556
        Top = 928
        Width = 156
        Height = 1
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          2454.010416666670000000
          413.411458333333000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape35: TQRShape
        Left = 260
        Top = 825
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          687.916666666667000000
          2182.812500000000000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel44: TQRLabel
        Left = 8
        Top = 835
        Width = 119
        Height = 15
        Size.Values = (
          39.687500000000000000
          21.166666666666700000
          2209.270833333330000000
          314.854166666667000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Opera'#231#227'o 1345'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel44Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRShape36: TQRShape
        Left = 390
        Top = 801
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333300000
          1031.875000000000000000
          2119.973958333330000000
          3.307291666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel45: TQRLabel
        Left = 372
        Top = 810
        Width = 8
        Height = 15
        Size.Values = (
          39.687500000000000000
          984.250000000000000000
          2143.125000000000000000
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
      object QRShape37: TQRShape
        Left = 556
        Top = 870
        Width = 158
        Height = 1
        Size.Values = (
          3.307291666666670000
          1471.744791666670000000
          2301.875000000000000000
          416.718750000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel46: TQRLabel
        Left = 558
        Top = 872
        Width = 66
        Height = 9
        Size.Values = (
          23.812500000000000000
          1476.375000000000000000
          2307.166666666667000000
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
      object QRLabel47: TQRLabel
        Left = 560
        Top = 908
        Width = 75
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          2402.416666666667000000
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
        Top = 835
        Width = 27
        Height = 15
        Size.Values = (
          39.687500000000000000
          375.708333333333300000
          2209.270833333333000000
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
        Left = 571
        Top = 760
        Width = 134
        Height = 15
        Size.Values = (
          39.687500000000000000
          1511.432291666670000000
          2010.833333333330000000
          353.880208333333000000)
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
        Left = 12
        Top = 810
        Width = 100
        Height = 15
        Size.Values = (
          39.687500000000000000
          31.750000000000000000
          2143.125000000000000000
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
        Top = 810
        Width = 137
        Height = 15
        Size.Values = (
          39.687500000000000000
          343.958333333333000000
          2143.125000000000000000
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
      object QRLabel55: TQRLabel
        Left = 282
        Top = 810
        Width = 54
        Height = 15
        Size.Values = (
          39.687500000000000000
          746.125000000000000000
          2143.125000000000000000
          142.875000000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Outros'
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
      object QRLabel69: TQRLabel
        Left = 398
        Top = 810
        Width = 141
        Height = 15
        Size.Values = (
          39.687500000000000000
          1053.041666666670000000
          2143.125000000000000000
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
        Left = 571
        Top = 785
        Width = 131
        Height = 15
        Size.Values = (
          39.687500000000000000
          1511.432291666670000000
          2076.979166666670000000
          347.265625000000000000)
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
        Left = 577
        Top = 808
        Width = 130
        Height = 15
        Size.Values = (
          39.687500000000000000
          1526.645833333330000000
          2137.833333333330000000
          343.958333333333000000)
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
        Top = 834
        Width = 132
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          2206.625000000000000000
          349.250000000000000000)
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
      object QRLabel79: TQRLabel
        Left = 249
        Top = 728
        Width = 448
        Height = 19
        Size.Values = (
          49.609375000000000000
          658.151041666667000000
          1924.843750000000000000
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
        Left = 681
        Top = 709
        Width = 16
        Height = 16
        Size.Values = (
          42.333333333333330000
          1801.812500000000000000
          1875.895833333333000000
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
        Top = 1025
        Width = 461
        Height = 20
        Size.Values = (
          52.916666666666670000
          68.791666666666670000
          2711.979166666667000000
          1219.729166666667000000)
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
        Left = 26
        Top = 1040
        Width = 461
        Height = 20
        Size.Values = (
          52.916666666666670000
          68.791666666666670000
          2751.666666666667000000
          1219.729166666667000000)
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
        Left = 44
        Top = 256
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          115.755208333333000000
          677.994791666667000000
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
        Left = 44
        Top = 279
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          115.755208333333000000
          737.526041666667000000
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
      object QRLabel39: TQRLabel
        Left = 371
        Top = 965
        Width = 176
        Height = 11
        Size.Values = (
          29.765625000000000000
          982.265625000000000000
          2553.229166666670000000
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
        OnPrint = QRLabel39Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel73: TQRLabel
        Left = 44
        Top = 268
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          115.755208333333000000
          707.760416666667000000
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
        Left = 43
        Top = 895
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2368.020833333330000000
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
        Left = 43
        Top = 909
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2404.401041666670000000
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
        Left = 43
        Top = 921
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2437.473958333330000000
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
        Left = 43
        Top = 934
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2470.546875000000000000
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
        Left = 43
        Top = 944
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2497.005208333330000000
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
        Left = 43
        Top = 855
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
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
        OnPrint = QRLabel83Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel87: TQRLabel
        Left = 43
        Top = 881
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2331.640625000000000000
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
        Left = 43
        Top = 869
        Width = 495
        Height = 11
        Size.Values = (
          29.765625000000000000
          112.447916666667000000
          2298.567708333330000000
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
        Top = 429
        Width = 711
        Height = 5
        Size.Values = (
          13.229166666666700000
          5.291666666666670000
          1135.062500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape39: TQRShape
        Left = 2
        Top = 666
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          1762.125000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape40: TQRShape
        Left = 2
        Top = 561
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          1484.312500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape41: TQRShape
        Left = 2
        Top = 536
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333330000
          5.291666666666670000
          1418.166666666670000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape42: TQRShape
        Left = 2
        Top = 510
        Width = 711
        Height = 2
        Size.Values = (
          5.291666666666670000
          5.291666666666670000
          1349.375000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape43: TQRShape
        Left = 2
        Top = 453
        Width = 711
        Height = 11
        Size.Values = (
          29.104166666666700000
          5.291666666666670000
          1198.562500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape44: TQRShape
        Left = 2
        Top = 486
        Width = 711
        Height = 2
        Size.Values = (
          5.291666666666670000
          5.291666666666670000
          1285.875000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape45: TQRShape
        Left = 159
        Top = 439
        Width = 10
        Height = 20
        Size.Values = (
          52.916666666666700000
          420.687500000000000000
          1161.520833333330000000
          26.458333333333300000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape46: TQRShape
        Left = 2
        Top = 688
        Width = 711
        Height = 4
        Size.Values = (
          10.583333333333300000
          5.291666666666670000
          1820.333333333330000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel89: TQRLabel
        Left = 167
        Top = 438
        Width = 68
        Height = 20
        Size.Values = (
          52.916666666666700000
          441.854166666667000000
          1158.875000000000000000
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
        Left = 560
        Top = 462
        Width = 40
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1222.375000000000000000
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
        Left = 232
        Top = 439
        Width = 8
        Height = 20
        Size.Values = (
          52.916666666666700000
          613.833333333333000000
          1161.520833333330000000
          21.166666666666700000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel91: TQRLabel
        Left = 4
        Top = 461
        Width = 68
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          1219.729166666667000000
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
      object QRLabel92: TQRLabel
        Left = 48
        Top = 493
        Width = 388
        Height = 15
        Size.Values = (
          39.687500000000000000
          127.000000000000000000
          1304.395833333333000000
          1026.583333333333000000)
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
        Left = 447
        Top = 489
        Width = 74
        Height = 11
        Size.Values = (
          29.104166666666670000
          1182.687500000000000000
          1293.812500000000000000
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
      object QRLabel94: TQRLabel
        Left = 2
        Top = 512
        Width = 65
        Height = 11
        Size.Values = (
          29.104166666666670000
          5.291666666666667000
          1354.666666666667000000
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
        Left = 121
        Top = 512
        Width = 58
        Height = 11
        Size.Values = (
          29.104166666666670000
          320.145833333333300000
          1354.666666666667000000
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
      object QRLabel96: TQRLabel
        Left = 278
        Top = 512
        Width = 45
        Height = 11
        Size.Values = (
          29.104166666666670000
          735.541666666666700000
          1354.666666666667000000
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
        Left = 348
        Top = 512
        Width = 22
        Height = 11
        Size.Values = (
          29.104166666666670000
          920.750000000000000000
          1354.666666666667000000
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
      object QRLabel98: TQRLabel
        Left = 396
        Top = 512
        Width = 80
        Height = 11
        Size.Values = (
          29.104166666666670000
          1047.750000000000000000
          1354.666666666667000000
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
        Left = 560
        Top = 488
        Width = 70
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1291.166666666667000000
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
        Left = 7
        Top = 537
        Width = 47
        Height = 11
        Size.Values = (
          29.104166666666670000
          18.520833333333330000
          1420.812500000000000000
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
      object QRLabel101: TQRLabel
        Left = 141
        Top = 537
        Width = 17
        Height = 11
        Size.Values = (
          29.104166666666670000
          373.062500000000000000
          1420.812500000000000000
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
      object QRLabel102: TQRLabel
        Left = 189
        Top = 537
        Width = 37
        Height = 11
        Size.Values = (
          29.104166666666670000
          500.062500000000000000
          1420.812500000000000000
          97.895833333333330000)
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
        Left = 193
        Top = 545
        Width = 61
        Height = 15
        Size.Values = (
          39.687500000000000000
          511.527777777778000000
          1441.979166666670000000
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
        Left = 264
        Top = 539
        Width = 38
        Height = 11
        Size.Values = (
          29.104166666666670000
          698.500000000000000000
          1426.104166666667000000
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
      object QRLabel105: TQRLabel
        Left = 493
        Top = 539
        Width = 34
        Height = 11
        Size.Values = (
          29.104166666666670000
          1304.395833333333000000
          1426.104166666667000000
          89.958333333333330000)
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
        Left = 480
        Top = 539
        Width = 8
        Height = 16
        Size.Values = (
          42.333333333333330000
          1270.000000000000000000
          1426.104166666667000000
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
      object QRLabel107: TQRLabel
        Left = 560
        Top = 512
        Width = 78
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1354.666666666667000000
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
      object QRLabel108: TQRLabel
        Left = 560
        Top = 539
        Width = 79
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1426.104166666667000000
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
        Top = 580
        Width = 46
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1534.583333333333000000
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
        Top = 618
        Width = 59
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1635.125000000000000000
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
        Left = 2
        Top = 679
        Width = 62
        Height = 10
        Size.Values = (
          26.458333333333330000
          5.291666666666667000
          1796.520833333333000000
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
      object QRShape48: TQRShape
        Left = 556
        Top = 597
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333330000
          1471.083333333330000000
          1579.562500000000000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape49: TQRShape
        Left = 556
        Top = 613
        Width = 158
        Height = 5
        Size.Values = (
          13.229166666666700000
          1471.083333333330000000
          1621.895833333330000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel113: TQRLabel
        Left = 70
        Top = 668
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666700000
          185.208333333333000000
          1767.416666666670000000
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
      object QRShape50: TQRShape
        Left = 555
        Top = 459
        Width = 2
        Height = 209
        Size.Values = (
          552.979166666667000000
          1468.437500000000000000
          1214.437500000000000000
          5.291666666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel116: TQRLabel
        Left = 5
        Top = 473
        Width = 542
        Height = 13
        Size.Values = (
          34.395833333333300000
          13.229166666666700000
          1251.479166666670000000
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
        Left = 189
        Top = 461
        Width = 244
        Height = 8
        Size.Values = (
          21.166666666666700000
          500.062500000000000000
          1219.729166666670000000
          645.583333333333000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pag'#225'vel preferencialmente em qualquer Ag'#234'ncia Bradesco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Left = 119
        Top = 514
        Width = 1
        Height = 22
        Size.Values = (
          58.208333333333300000
          314.854166666667000000
          1359.958333333330000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape52: TQRShape
        Left = 275
        Top = 512
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          727.604166666667000000
          1354.666666666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape53: TQRShape
        Left = 344
        Top = 512
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          910.166666666667000000
          1354.666666666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape54: TQRShape
        Left = 138
        Top = 536
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          365.125000000000000000
          1418.166666666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape55: TQRShape
        Left = 184
        Top = 536
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          486.833333333333000000
          1418.166666666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape56: TQRShape
        Left = 483
        Top = 536
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          1277.937500000000000000
          1418.166666666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape57: TQRShape
        Left = 556
        Top = 633
        Width = 156
        Height = 5
        Size.Values = (
          13.229166666666700000
          1471.083333333330000000
          1674.812500000000000000
          412.750000000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape58: TQRShape
        Left = 260
        Top = 536
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          687.916666666667000000
          1418.166666666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel118: TQRLabel
        Left = 8
        Top = 544
        Width = 119
        Height = 15
        Size.Values = (
          39.687500000000000000
          21.166666666666700000
          1439.333333333330000000
          314.854166666667000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Opera'#231#227'o 1345'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel118Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRShape59: TQRShape
        Left = 390
        Top = 512
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          1031.875000000000000000
          1354.666666666670000000
          2.645833333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel119: TQRLabel
        Left = 372
        Top = 518
        Width = 8
        Height = 15
        Size.Values = (
          39.687500000000000000
          984.250000000000000000
          1370.541666666667000000
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
      object QRShape60: TQRShape
        Left = 556
        Top = 579
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333330000
          1471.083333333330000000
          1531.937500000000000000
          418.041666666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel120: TQRLabel
        Left = 558
        Top = 564
        Width = 66
        Height = 11
        Size.Values = (
          29.104166666666670000
          1476.375000000000000000
          1492.250000000000000000
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
      object QRLabel121: TQRLabel
        Left = 560
        Top = 599
        Width = 75
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1584.854166666667000000
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
        Left = 142
        Top = 545
        Width = 27
        Height = 15
        Size.Values = (
          39.687500000000000000
          375.708333333333300000
          1441.979166666667000000
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
      object QRLabel123: TQRLabel
        Left = 572
        Top = 470
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          1243.541666666670000000
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
        Left = 13
        Top = 520
        Width = 100
        Height = 15
        Size.Values = (
          39.687500000000000000
          34.395833333333300000
          1375.833333333330000000
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
        Left = 133
        Top = 521
        Width = 138
        Height = 15
        Size.Values = (
          39.687500000000000000
          351.895833333333000000
          1378.479166666670000000
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
      object QRLabel126: TQRLabel
        Left = 282
        Top = 520
        Width = 54
        Height = 15
        Size.Values = (
          39.687500000000000000
          746.125000000000000000
          1375.833333333330000000
          142.875000000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Outros'
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
      object QRLabel127: TQRLabel
        Left = 398
        Top = 521
        Width = 141
        Height = 15
        Size.Values = (
          39.687500000000000000
          1053.041666666670000000
          1378.479166666670000000
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
        Left = 446
        Top = 496
        Width = 108
        Height = 15
        Size.Values = (
          39.687500000000000000
          1179.600694444440000000
          1311.892361111110000000
          286.631944444444000000)
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
        Left = 572
        Top = 495
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          1309.687500000000000000
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
      object QRLabel130: TQRLabel
        Left = 572
        Top = 521
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666670000000
          1378.479166666670000000
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
      object QRLabel133: TQRLabel
        Left = 681
        Top = 424
        Width = 16
        Height = 16
        Size.Values = (
          42.333333333333330000
          1801.812500000000000000
          1121.833333333333000000
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
      object QRLabel135: TQRLabel
        Left = 42
        Top = 602
        Width = 495
        Height = 13
        Size.Values = (
          34.395833333333300000
          111.125000000000000000
          1592.791666666670000000
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
        Left = 42
        Top = 615
        Width = 495
        Height = 13
        Size.Values = (
          34.395833333333300000
          111.125000000000000000
          1627.187500000000000000
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
        Left = 42
        Top = 627
        Width = 495
        Height = 13
        Size.Values = (
          34.395833333333300000
          111.125000000000000000
          1658.937500000000000000
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
        Left = 42
        Top = 640
        Width = 495
        Height = 13
        Size.Values = (
          34.395833333333300000
          111.125000000000000000
          1693.333333333330000000
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
        Left = 42
        Top = 652
        Width = 495
        Height = 13
        Size.Values = (
          34.395833333333300000
          111.125000000000000000
          1725.083333333330000000
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
        Left = 42
        Top = 565
        Width = 495
        Height = 13
        Size.Values = (
          34.395833333333300000
          111.125000000000000000
          1494.895833333330000000
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
        Left = 42
        Top = 590
        Width = 495
        Height = 13
        Size.Values = (
          34.395833333333300000
          111.125000000000000000
          1561.041666666670000000
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
        Left = 42
        Top = 577
        Width = 495
        Height = 13
        Size.Values = (
          34.395833333333300000
          111.125000000000000000
          1526.645833333330000000
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
        Left = 572
        Top = 134
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666667000000
          354.541666666666700000
          351.895833333333400000)
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
        Left = 572
        Top = 441
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666667000000
          1166.812500000000000000
          351.895833333333400000)
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
        Top = 566
        Width = 36
        Height = 11
        Size.Values = (
          29.104166666666670000
          5.291666666666667000
          1497.541666666667000000
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
      object QRLabel143: TQRLabel
        Left = 589
        Top = 692
        Width = 44
        Height = 10
        Size.Values = (
          26.458333333333330000
          1558.395833333333000000
          1830.916666666667000000
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
      object QRLabel144: TQRLabel
        Left = 4
        Top = 489
        Width = 41
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          1293.812500000000000000
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
      object QRLabel145: TQRLabel
        Left = 4
        Top = 778
        Width = 41
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          2058.458333333333000000
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
      object QRShape28: TQRShape
        Left = 2
        Top = 118
        Width = 711
        Height = 5
        Size.Values = (
          13.229166666666700000
          6.614583333333330000
          310.885416666667000000
          1881.848958333330000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel10: TQRLabel
        Left = 681
        Top = 116
        Width = 16
        Height = 16
        Size.Values = (
          42.333333333333330000
          1801.812500000000000000
          306.916666666666700000
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
      object QRImage4: TQRImage
        Left = 6
        Top = 433
        Width = 126
        Height = 25
        Size.Values = (
          66.145833333333300000
          15.434027777777800000
          1144.322916666670000000
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
      object QRImage1: TQRImage
        Left = 6
        Top = 721
        Width = 126
        Height = 25
        Size.Values = (
          66.145833333333300000
          16.536458333333300000
          1908.307291666670000000
          334.036458333333000000)
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
      object QRShape61: TQRShape
        Left = 159
        Top = 9
        Width = 10
        Height = 20
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
        Left = 167
        Top = 9
        Width = 68
        Height = 20
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
        Left = 234
        Top = 9
        Width = 8
        Height = 20
        Size.Values = (
          52.916666666666700000
          619.565972222222000000
          24.253472222222200000
          22.048611111111100000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRImage3: TQRImage
        Left = 7
        Top = 2
        Width = 122
        Height = 25
        Size.Values = (
          66.145833333333300000
          17.638888888888900000
          6.614583333333330000
          321.909722222222000000)
        XLColumn = 0
        Picture.Data = {
          07544269746D6170428A0000424D428A0000000000003600000028000000CE00
          00003900000001001800000000000C8A00000000000000000000000000000000
          0000FDFCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FDFCFBFDFCFBFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFECEDEBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FDFCFBFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFF3F4F3A4A1A1B4B4B3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FDFCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F4F3ADACAA6C6F68AFAFAEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FDFCFBFDFCFBFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F4F3ADACAA
          80807F5B5A58AFAFAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FDFC
          FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFF9FAF9AFAFAE8686827F7E7D484746AFAFAEFFFFFFFFFFFFFFFFFFFCFC
          FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FDFCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF1EDE99E89768686828E8C8A6C6F68484746AFAF
          AEFFFFFFFFFFFFFFFFFFDEE8D792AB86F9FAF9FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FDFCFBFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1EDE9927A646947278E8C
          8A8E8C8A62615F484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E9597A48889382FC
          FCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FDFCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1ED
          E9907761603F227657399C98968686825B5A58484746AFAFAEFFFFFFFFFFFFFF
          FFFFEEF2E9749A591F2D17939C8DFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFF1EDE9907761603F226947277657399C989680807F5B5A5848
          4746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E98FB270324F221F2D17939C8DFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FDFCFBFDFCFB
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF9F7F6F8F4F09A836F603F2269472776512785
          643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E999BB77
          5F86471F2D171F2D17889382F8F9F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FDFCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F0EE927A6460
          3F2269472779542A815B2A85643E9C989680807F5B5A58484746AFAFAEFFFFFF
          FFFFFFFFFFFFEEF2E999BB778FB2703B592C1F2D171F2D17889382FCFCFBFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FDFCFBFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFF1EDE9927A64603F2269472779542A815B2A815B2A85643E9C989680807F
          5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E997B875AAC48E698B572741
          1A1F2D171F2D17939C8DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFF2F0EE927A64603F22694727765229815B2A815B2A
          805A2A85643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2
          E995B773AAC48E80A566355A2327411A1F2D171F2D17939C8DFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F4F0927A64603F22694727
          765229815B2A815B2A805A2A805A2A85643E9C989680807F5B5A58484746AFAF
          AEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88AB6C477A30355A2327411A1F
          2D171F2D17939C8DFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFAFFFFFFFFFFFFF8F4F0
          9E8976603F22694727765229815B2A805A2A815B2A805A2A7F592885643E9C98
          9680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88
          AB6C4A7E30477A30355A2327411A1F2D171F2D17939C8DFBFBFAFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF9F7FFFFFFFFFFFF
          FFFFFFFFFFFFF1EDE9927A64603F2269472779542A815B2A815B2A805A2A805A
          2A805A2A7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFF
          FFFFEEF2E995B773AAC48E88AB6C4A7E304A7E30477A30355A2327411A1F2D17
          1F2D17868682FCFCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFBFBFAF1EDE9927A64603F2269472779542A815B
          2A815B2A815B2A815B2A815B2A815B2A7F592885643E9C989680807F5B5A5848
          4746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88AB6C4A7E30497D30
          497D30477A30355A2327411A1F2D171F2D17939C8DFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1EDE9927A64603F
          22694727765229815B2A815B2A805A2A805A2A815B2A805A2A815B2A7F592885
          643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773
          AAC48E88AB6C4A7E30477A30497D304A7E30477A30355A2327411A1F2D171F2D
          17939C8DFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFF6F7F59A836F603F22694727765229815B2A815B2A815B2A805A2A805A2A81
          5B2A805A2A805A2A7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFF
          FFFFFFFFFFFFEEF2E995B773AAC48E88AB6C4A7E30497D30497D30497D304A7E
          30477A30375F2527411A1F2D171F2D17D1D9CCFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFF1EDE99A836F603F2269472779542A815B2A815B2A80
          5A2A805A2A815B2A805A2A805A2A805A2A805A2A805A2A85643E9C989680807F
          5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88AB6C4A7E
          30497D30497D30497D30497D30497D30406D2C355A2327411A27411AD1D9CCFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1EDE9907761603F2269472779
          542A815B2A815B2A815B2A815B2A815B2A805A2A815B2A805A2A815B2A815B2A
          7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2
          E995B773AAC48E88AB6C4A7E30497D304A7E304A7E30477A303C6529355A232C
          4B1D3D5C30C9CDC8F8F9F7F9FAF9CCD9C4FBFBFAFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1EDE992
          7A64603F22694727765229815B2A815B2A805A2A805A2A805A2A805A2A805A2A
          805A2A805A2A805A2A805A2A7F592885643E9C989680807F5B5A58484746AFAF
          AEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88AB6C497D30497D304A7E3045
          772D3C6529355A232C4B1D3B592CBFCABBFFFFFFFFFFFFFCFCFB749A59889382
          FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFF2F0EE927A64603F22694727765229815B2A815B2A815B2A805A2A
          805A2A805A2A805A2A805A2A805A2A815B2A815B2A805A2A7F592885643E9C98
          9680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88
          AB6C4A7E30497D3045772D3C65293254222C4B1D325422C9CDC8FFFFFFFFFFFF
          FCFCFBB0BFAB3C65291F2D17939C8DFCFCFBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFCFE8FF9B5F529B5F1B9B5F1B9B5F1B9B5F1BDF9C1BFFFFFFCFE8FF9B5F52F0
          B752FFFFFFFFFFFFBFCFFF9B5F1BDF9C1BDFFFFF9B5F7BDF9C1BFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F529B5F1B9B5F
          1B9B5F1B9B5F1BDF9C1BFFFFFFF0FFFF9B7FA09B5F1B9B5F1BBF9C529B5F52FF
          CF7BBFCFFF9B5F1BFFCF7BFFFFFFBFCFFF9B5F1BF0B752FFFFFFCFE8FF9B5F52
          9B5F1B9B5F1BDF9C1BFFFFFFFFFFFFCFE8FF9B5F529B5F1BAD5F1BFFE8A0FFFF
          FFFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFBFCFFF9B5F1BDF
          9C1BADB7E1AD5F1BFFE8A0BFCFFF9B5F1BBF9C7B9B5F1B9B5F1BF0B752FFFFFF
          FFFFFFCFE8FF9B5F529B5F1B9B5F1BF0B752FFFFFFADB7E1AD5F1BFFE8A0CFE8
          FF9B5F52F0B752FFFFFFFFFFFFF0FFFF9B7FA09B5F1B9B5F1BBF9C529B5F52FF
          CF7BFFFFFFCFE8FF9B5F529B5F1BAD5F1BFFE8A0FFFFFFFFFFFFFFFFFFFFFFFF
          DFFFFF9B5F7BDF9C1BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B7
          52FFFFFFFFFFFFFFFFFFCFE8FF9B5F529B5F1B9B5F1BF0B752FFFFFFFFFFFF9B
          9CC29B5F1BBF5F1BFFFFC2CFE8FF9B5F529B5F1BAD5F1BFFE8A0FFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFF8F9F79E8976603F22694727765229815B2A
          815B2A805A2A815B2A815B2A805A2A815B2A805A2A815B2A815B2A805A2A815B
          2A805A2A7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFF
          FFFFEEF2E995B773AAC48E88AB6C4A7E3045772D3C65293254222C4B1D3D5C30
          D6DBD4FFFFFFFFFFFFFFFFFFB0BFAB40652F355A231F2D171F2D17939C8DFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFBFCFFF9B
          5F1BF0B752CFE8FF9B5F52F0B752FFFFFFF0FFFF9B7FA0AD5F1BFFE8A0DFFFFF
          9B5F7BDF9C1BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFCFE8FF9B5F52F0B752FFFFFFFFFFFFBFCFFF9B5F1BF0B752ADB7E19B5F1BFF
          CF7BDFFFFF9B5F7BAD5F1BFFE8A0BFCFFF9B5F1BFFCF7BFFFFFFBFCFFF9B5F1B
          F0B752CFE8FF9B5F52DF9C1BFFFFFFBFCFFF9B5F1BF0B752CFE8FF9B5F52F0B7
          52FFFFFFADB7E1AD5F1BFFE8A0FFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752FF
          FFFFF0FFFF9B7FA0AD5F1BFFE8A0ADB7E1AD5F1BFFE8A0BFCFFF9B5F1BCF7F1B
          FFFFE1ADB7E19B5F1BFFCF7BCFE8FF9B5F52DF9C1BFFFFFFBFCFFF9B5F1BFFCF
          7BADB7E1AD5F1BFFE8A0CFE8FF9B5F52F0B752FFFFFFFFFFFFADB7E19B5F1BFF
          CF7BDFFFFF9B5F7BAD5F1BFFE8A0CFE8FF9B5F52F0B752FFFFFFADB7E1AD5F1B
          FFE8A0FFFFFFFFFFFFFFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFCFE8FF9B5F52DF9C1BFFFFFFBF
          CFFF9B5F1BFFCF7BDFFFFF9B5F7BDF9C1BFFFFFFCFE8FF9B5F52F0B752FFFFFF
          ADB7E1AD5F1BFFE8A0FFFFFF0000FFFFFFFFFFFFFFFFFFF1EDE9927A64603F22
          69472779542A815B2A815B2A805A2A815B2A815B2A815B2A815B2A815B2A815B
          2A815B2A815B2A805A2A815B2A805A2A805A2A85643E9C989680807F5B5A5848
          4746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88AB6C45772D375F25
          32542227411A597A48D6DBD4FFFFFFFFFFFFF8F9F7839879355A23375F253C65
          2927411A1F2D171F2D1780807FFCFCFBFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0
          B752FFFFFFFFFFFFDFFFFF9B5F7BDF9C1BCFE8FF9B5F52F0B752FFFFFFBFCFFF
          9B5F1BDF9C1BFFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFBFCFFF9B5F1B9B5F1BCF7F1BCFE8E19B5F52F0B752FFFFFFFFFFFFDFFFFF9B
          5F7BDF9C1BADB7E1AD5F1BFFE8A0FFFFFFADB7E1AD5F1BFFE8A0BFCFFF9B5F1B
          FFCF7BFFFFFFBFCFFF9B5F1BF0B752ADB7E1AD5F1BFFE8A0FFFFFFFFFFFFFFFF
          FFFFFFFFADB7E1AD5F1BFFE8A0FFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFFFF
          FFFFCFE8FF9B5F52F0B752FFFFFFBFCFFF9B5F1BDF9C1BFFFFFFADB7E1AD5F1B
          FFE8A0BFCFFF9B5F1BFFCF7BFFFFFFDFFFFF9B5F7BDF9C1BADB7E1AD5F1BFFE8
          A0FFFFFFFFFFFFFFFFFFFFFFFFADB7E1AD5F1BFFE8A0CFE8FF9B5F52F0B752FF
          FFFFFFFFFFADB7E1AD5F1BFFE8A0FFFFFFADB7E1AD5F1BFFE8A0ADB7E1AD5F1B
          FFE8A0FFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFFFFFFFFDFFFFF9B5F7BDF9C
          1BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFAD
          B7E1AD5F1BFFE8A0FFFFFFFFFFFFFFFFFFFFFFFFDFFFFF9B5F7BDF9C1BFFFFFF
          ADB7E1AD5F1BFFE8A0FFFFFFDFFFFF9B5F7BDF9C1BFFFFFF0000FFFFFFFFFFFF
          F1EDE9927A64603F2269472779542A815B2A815B2A815B2A805A2A815B2A815B
          2A805A2A815B2A815B2A805A2A805A2A805A2A805A2A815B2A815B2A7F592885
          643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773
          AAC48E80A566375F25324F222C4B1D839879E5E9E2FFFFFFFFFFFFF9FAF9A1B1
          994E723E597A484E7B3845772D375F2527411A1F2D171F2D17939C8DFCFCFBFF
          FFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFBFCFFF9B5F1BF0B752CFE8FF
          9B5F52F0B752DFFFFF9B5F7BBF5F1BFFFFC2FFFFFFDFFFFF9B5F7B9B5F1B9B5F
          1B9B5F1B9B5F1BFFCF7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0
          B752FFFFFFFFFFFFBFCFFF9B5F1BF0B752CFE8FF9B5F52BF5F1BFFFFC2ADB7E1
          AD5F1BFFE8A0BFCFFF9B5F1BFFCF7BFFFFFFBFCFFF9B5F1BF0B752ADB7E1AD5F
          1BFFE8A0FFFFFFFFFFFFFFFFFFFFFFFF9B9CC2BF5F1BFFFFC2FFFFFFDFFFFF9B
          5F7BDF9C1BFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752DFFFFF9B5F7BBF5F1B
          FFFFC2FFFFFFADB7E1AD5F1BFFE8A0BFCFFF9B5F1BFFCF7BFFFFFFDFFFFF9B5F
          7BDF9C1BADB7E19B5F1B9B5F1B9B5F1B9B5F1B9B5F1BDF9C1BADB7E1AD5F1BFF
          E8A0CFE8FF9B5F52F0B752FFFFFFFFFFFFCFE8FF9B5F52BF5F1BFFFFC2ADB7E1
          AD5F1BFFE8A09B9CC2BF5F1BFFFFC2FFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFF
          FFFFFFFFDFFFFF9B5F7B9B5F1B9B5F1B9B5F1B9B5F1BFFCF7BFFFFFFCFE8FF9B
          5F52F0B752FFFFFFFFFFFFADB7E19B5F1B9B5F1B9B5F1B9B5F1B9B5F1BDF9C1B
          DFFFFF9B5F7BDF9C1BFFFFFF9B9CC2BF5F1BFFFFC2FFFFFFDFFFFF9B5F7BDF9C
          1BFFFFFF0000FFFFFFEBECE78F765F603F22603F22765127815B2A815B2A815B
          2A805A2A815B2A805A2A815B2A805A2A805A2A805A2A815B2A805A2A815B2A81
          5B2A815B2A805A2A805A2A85643E9C989680807F5B5A58484746AFAFAEFFFFFF
          FFFFFFFFFFFFEEF2E997B875AAC48E5F86472C4B1D2C4B1D708C62FBFBFAFFFF
          FFFFFFFFFFFFFFFCFCFBDAE5D3B7C9ADCCD9C4C7D5B9749A5945772D375F2527
          411A1F2D171F2D17939C8DFCFCFBFFFFFFCFE8FF9B5F529B5F1B9B5F1B9B5F1B
          9B5F1BF0B752FFFFFFCFE8FF9B5F529B5F1B9B5F1B9B5F1B9B5F1BFFCF7BFFFF
          FFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFF9B9CC2AD5F1BFFE8A0FFFFFFFFFFFFFF
          FFFFFFFFFFCFE8FF9B5F529B5F1B9B5F1B9B5F1B9B5F1BF0B752FFFFFFFFFFFF
          FFFFFFBFCFFF9B5F1B9B5F1BAD5F1BFFE8A0BFCFFF9B5F1BFFCF7BFFFFFFBFCF
          FF9B5F1BF0B752ADB7E1AD5F1BFFE8A0FFFFFFFFFFFFFFFFFFFFFFFFADB7E1AD
          5F1BFFE8A0FFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFFFFFFFFCFE8FF9B5F52
          9B5F1B9B5F1B9B5F1B9B5F1BFFCF7BFFFFFFADB7E1AD5F1BFFE8A0BFCFFF9B5F
          1BFFCF7BFFFFFFDFFFFF9B5F7BDF9C1BADB7E1AD5F1BFFE8A0FFFFFFCFE8FF9B
          5F52F0B752ADB7E1AD5F1BFFE8A0CFE8FF9B5F52F0B752FFFFFFFFFFFFFFFFFF
          FFFFFFBFCFFF9B5F1B9B5F1BAD5F1BFFE8A0ADB7E1AD5F1BFFE8A0FFFFFFDFFF
          FF9B5F7BDF9C1BFFFFFFFFFFFFFFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFF9B
          9CC2AD5F1BFFE8A0CFE8FF9B5F52F0B752FFFFFFFFFFFFADB7E1AD5F1BFFE8A0
          FFFFFFCFE8FF9B5F52F0B752DFFFFF9B5F7BDF9C1BFFFFFFADB7E1AD5F1BFFE8
          A0FFFFFFDFFFFF9B5F7BDF9C1BFFFFFF0000FFFFFFDACDC1AE937AB59B81C9AA
          85AA895E815A257F5928815B2A815B2A805A2A815B2A805A2A815B2A815B2A81
          5B2A815B2A815B2A805A2A805A2A815B2A805A2A7F592885643E9C989680807F
          5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E9A0BE8496B283355A232741
          1A839879ECEDEBFFFFFFFFFFFFFBFBFAFFFFFFFFFFFFFEFEFEE2EBDBCCD9C4EE
          F2E9CCD9C4749A5945772D355A232C4B1D1F2D1727411AD1D9CCFFFFFFCFE8FF
          9B5F52F0B752FFFFFFFFFFFF9B9CC2BF5F1BFFFFC2CFE8FF9B5F52F0B752FFFF
          FFFFFFFF9B9CC2AD5F1BFFE8A0DFFFFF9B5F7BDF9C1BFFFFFFFFFFFFCFE8FF9B
          5F52F0B752FFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFF
          9B9CC2BF5F1BFFFFC2CFE8FFAD5F52FFE8A0FFFFFFADB7E1AD5F1BFFE8A0BFCF
          FF9B5F1BDF9C1BFFFFFFADB7E19B5F1BFFCF7BCFE8FF9B5F52F0B752FFFFFFBF
          CFFF9B5F1BFFCF7BCFE8FF9B5F52F0B752FFFFFFADB7E1AD5F1BFFE8A0FFFFFF
          FFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFF9B9CC2AD5F1BFFE8A0ADB7
          E1AD5F1BFFE8A0BFCFFF9B5F1BDF9C1BFFFFFFADB7E19B5F1BFFCF7BCFE8FF9B
          5F52F0B752FFFFFFADB7E1AD5F1BFFE8A0ADB7E1AD5F1BFFE8A0CFE8FF9B5F52
          CF7F1BFFFFE1FFFFFFCFE8FFAD5F52FFE8A0FFFFFFADB7E1AD5F1BFFE8A0CFE8
          FF9B5F52F0B752FFFFFFADB7E1AD5F1BFFE8A0FFFFFFFFFFFFFFFFFFDFFFFF9B
          5F7BDF9C1BFFFFFFFFFFFFCFE8FF9B5F52F0B752CFE8FF9B5F52CF7F1BFFFFE1
          FFFFFFCFE8FF9B5F52F0B752FFFFFFADB7E1AD5F1BFFE8A0DFFFFF9B5F7BDF9C
          1BFFFFFFCFE8FF9B5F52F0B752FFFFFFADB7E1AD5F1BFFE8A0FFFFFF0000FFFF
          FFFEFEFEF1EAE2E4D4C2EFE7DCECE3D6AA895E7F57237F5928815B2A815B2A80
          5A2A815B2A805A2A815B2A815B2A815B2A805A2A805A2A815B2A815B2A805A2A
          7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2
          E9A0BE84597A482C4B1D939C8DF8F9F7FFFFFFFFFFFFD1D9CC839879C9CDC8FF
          FFFFFFFFFFFEFEFEDEE8D7C7D5B9EEF2E9CCD9C44E7B38355A232C4B1D324F22
          A1B199F9FAF9FFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFBFCFFF9B5F1BFFCF
          7BCFE8FF9B5F52F0B752FFFFFFFFFFFFBFCFFF9B5F1BFFCF7BDFFFFF9B5F7BDF
          9C1BFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFFFFFFFFFFFFFCFE8FF
          9B5F52F0B752FFFFFFFFFFFFBFCFFF9B5F1BFFCF7BFFFFFFADB7E19B5F1B9B5F
          1B9B5F1BF0B752FFFFFFBFCFFF9B5F1BCFB77B9B5F529B5F1BCF7F1BFFFFE1FF
          FFFFCFE8FF9B5F529B5F1B9B5F1BF0B752FFFFFFFFFFFFCFE8FF9B5F529B5F1B
          9B5F1BFFCF7BFFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFF
          FFBFCFFF9B5F1BFFCF7BADB7E1AD5F1BFFE8A0BFCFFF9B5F1BBF9C7B9B5F1B9B
          5F1BDF9C1BFFFFFFFFFFFFCFE8FF9B5F529B5F1B9B5F1BFFCF7BFFFFFFADB7E1
          AD5F1BFFE8A0CFE8FF9B5F52BF9C529B5F52AD5F1BFFE8A0ADB7E19B5F1B9B5F
          1B9B5F1BF0B752FFFFFFFFFFFFCFE8FF9B5F529B5F1B9B5F1BFFCF7BFFFFFFFF
          FFFFFFFFFFFFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFFCFE8FF9B5F52F0B752
          CFE8FF9B5F52BF9C529B5F52AD5F1BFFE8A0CFE8FF9B5F529B5F1B9B5F1BFFCF
          7BF0FFFF9B7FA09B5F1B9B5F1BCF7F1BFFFFE1CFE8FF9B5F529B5F1B9B5F1BFF
          CF7BFFFFFFFFFFFF0000FFFFFFFFFFFFFEFEFEF1EAE2DECBB3EDE5DAEDE5DAB1
          926A815A257F5928815B2A805A2A815B2A815B2A805A2A805A2A805A2A805A2A
          815B2A815B2A805A2A805A2A7F592885643E9C989680807F5B5A58484746AFAF
          AEFFFFFFFFFFFFFFFFFFEEF2E996B283325422B7C9ADFCFCFBFFFFFFFFFFFFB7
          C9AD4E723E27411A3B4835D6DBD4FFFFFFFFFFFFFEFEFEDEE8D7C7D5B9CCD9C4
          597A4827411A324F22B0BFABFBFBFAFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFF
          FFFFFFFFADB7E1AD5F1BFFE8A0CFE8FF9B5F52F0B752FFFFFFFFFFFFADB7E1AD
          5F1BFFE8A0DFFFFF9B5F7BDF9C1BFFFFFFFFFFFF9B9CC2AD5F1BFFE8A0FFFFFF
          FFFFFFFFFFFFFFFFFFCFE8FF9B5F52F0B752FFFFFFFFFFFFADB7E1AD5F1BFFE8
          A0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFE8
          FF9B5F52F0B752FFFFFFFFFFFFADB7E1AD5F1BFFE8A0FFFFFFFFFFFFFFFFFFBF
          CFFF9B5F1BFFCF7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFF9B5F7BDF9C1BFFFFFF
          FFFFFF9B9CC2AD5F1BFFE8A0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFF9B5F7BDF9C1BFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFE
          FEFEF1EAE2DDCAB0EFE7DCEFE8DFB1926A815A25805A2A815B2A805A2A815B2A
          815B2A805A2A815B2A805A2A815B2A805A2A815B2A805A2A805A2A85643E9C98
          9680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E992AB86B0BFABFE
          FEFEFFFFFFFFFFFFC7D5B9355A23375F252C4B1D1F2D175B5A58EBECE7FFFFFF
          FFFFFFFEFEFEDAE5D3B7C9AD4E723E27411AABB9A5FEFEFEFFFFFFFFFFFFFFFF
          FFCFE8FF9B5F529B5F1B9B5F1B9B5F1B9B5F1BF0B752FFFFFFCFE8FF9B5F529B
          5F1B9B5F1B9B5F1B9B5F1BF0B752FFFFFFDFFFFF9B5F7B9B5F1B9B5F1B9B5F1B
          9B5F1BF0B752FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFE8FF9B5F529B5F1B9B5F
          1B9B5F1B9B5F1BF0B752FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFCFE8FF9B5F529B5F1B9B5F1B9B5F1B9B5F1BF0B752FF
          FFFFADB7E1AD5F1BFFE8A0BFCFFF9B5F1BFFCF7BFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB7E1AD5F1BFFE8A0FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFBF7FA0FFFFC29B9CC2BF5F1BFFFFC2FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          DFFFFF9B5F7B9B5F1B9B5F1B9B5F1B9B5F1BF0B752FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF
          E8FFDF9C52FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEEFE8DFDECBB3EFE7DCEDE5DAB5976F
          815B2A7F5928815B2A805A2A815B2A805A2A805A2A815B2A805A2A815B2A805A
          2A815B2A7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFF
          FFFFEEF2E9CCD9C4FFFFFFFFFFFFFFFFFFB7C9AD375F253C6529406D2C325422
          1F2D171F2D17606B5AECEDEBFFFFFFFFFFFFFEFEFEDAE5D34E723EA1B199FEFE
          FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9B9CC2AD
          5F1BFFE8A09B9CC2FFCF7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE
          ECE3D6DDCAB0EFE7DCEFE8DFAC8C627C541F7F5928815B2A815B2A805A2A815B
          2A805A2A815B2A805A2A815B2A805A2A805A2A85643E9C989680807F5B5A5848
          4746AFAFAEFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFCFCFBB0BFAB40652F
          3C6529406D2C477A30406D2C27411A1F2D171F2D176C6F68FCFCFBFFFFFFFFFF
          FFE5E9E2B0BFABFBFBFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEEFE8DFDFCEB6ECE3D6EBDFD1B1926A815A
          257F5928815B2A815B2A815B2A815B2A805A2A815B2A815B2A805A2A805A2A85
          643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          EBECE789A47B355A233C6529406D2C497D304A7E30497D30406D2C27411A1F2D
          171F2D17F3F4F3FFFFFFFFFFFFFBFBFAFCFCFBFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF1EA
          E2DDCAB0EDE5DAEFE7DCAC8C62815B2A7F5928815B2A805A2A815B2A805A2A81
          5B2A805A2A815B2A7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFF
          FFFFFFFFFFFFFFFFFFE5E9E2708C62375F253C6529406D2C497D304A7E30497D
          304A7E30477A302C4B1D1F2D1727411AF3F4F3FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFEFEFEF1EAE2DFCEB6EFE7DCEFE7DCB5976F815A257F
          5928815B2A815B2A815B2A815B2A815B2A805A2A805A2A85643E9C989680807F
          5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFF3F4F3698B57355A233C65294577
          2D497D304A7E30497D30497D304A7E30477A30324F221F2D1727411AF9FAF9FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEEDE5DADE
          CBB3EFE7DCEFE7DCB1926A815A257F5928805A2A805A2A815B2A805A2A805A2A
          7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2
          E9749A595F86474A7E30497D304A7E30497D30497D30497D30497D30406D2C32
          542227411A2C4B1DFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFBF9F7FEFEFEEDE5DADECBB3EDE5DAEFE7DCAA895E7F57237F5928
          815B2A805A2A815B2A805A2A7F592885643E9C989680807F5B5A58484746AFAF
          AEFFFFFFFFFFFFFFFFFFEEF2E997B875AAC48E80A5664A7E30497D30497D304A
          7E30477A30406D2C355A232C4B1D324F22B0BFABFEFEFEFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF9F7FEFEFEEFE8DFDFCEB6
          ECE3D6EBDFD1B1926A815B2A7F5928805A2A815B2A805A2A7F592885643E9C98
          9680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88
          AB6C4A7E30497D304A7E30477A303C6529355A232C4B1D39552BB0BFABFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFEFEFEF1EDE9DDCAB0EFE7DCEFE8DFB1926A815A257F5928805A
          2A815B2A7F592885643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFF
          FFFFEEF2E995B773AAC48E88AB6C4A7E30497D30477A303C65293254222C4B1D
          2C4B1DB0BFABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF9F7FEFEFEF1EAE2DDCAB0EDE5
          DAEFE8DFB5976F815B2A7F5928815B2A7F592885643E9C989680807F5B5A5848
          4746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E88AB6C4A7E30497D30
          406D2C3254222C4B1D324F22ABB9A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFBF9F7FEFEFEEDE5DADECBB3EDE5DAEFE8DFB1926A7F57237F5928805A2A85
          643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773
          AAC48E88AB6C497D30406D2C355A232C4B1D324F22ABB9A5FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEEDE5DADECBB3EFE7DCEB
          DFD1AC8C627F57237F592685643E9C989680807F5B5A58484746AFAFAEFFFFFF
          FFFFFFFFFFFFEEF2E995B773AAC48E88AB6C406D2C355A232C4B1D39552BABB9
          A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFEFEFEF1EAE2DDCAB0ECE3D6EFE7DCAC8C62815A2585643E9C989680807F
          5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E995B773AAC48E749A593254
          222C4B1D324F22D1D9CCFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF1EDE9DFCEB6EDE5DAEFE8DF
          B5976F85643E9C989680807F5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2
          E999BB77A0BE844E723E27411A324F22B0BFABFEFEFEFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FEFEFEF1EAE2DDCAB0EFE7DCECE3D6B59B819C989680807F5B5A58484746AFAF
          AEFFFFFFFFFFFFFFFFFFEEF2E9A0BE8489A47B2C4B1D2C4B1DABB9A5FCFCFBFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEEDE5DADDCAB0EDE5DAF1EDE9C2C0
          BF7F7E7D5B5A58484746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E9A0BE844E723E27
          411AB0BFABFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
          FEEDE5DADFCEB6EDE5DAECEDEB9C98965B5A58484746AFAFAEFFFFFFFFFFFFFF
          FFFFEEF2E996B2833D5C30B0BFABFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF1EAE2DFCEB6F6F7F5C9CDC862615F48
          4746AFAFAEFFFFFFFFFFFFFFFFFFEEF2E989A47BBFCABBFCFCFBFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF2
          F0EEECEDEBF2F0EE868682484746AFAFAEFFFFFFFFFFFFFFFFFFE5E9E2CCD9C4
          FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFEFEFEF3F4F3F2F0EEADACAA484746AFAFAEFFFFFF
          FFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF3F4F3
          D6DBD462615FAFAFAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEF8F9F7A4A1A1B4B4B3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFC9CD
          C8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
          FFFFFFFFFFFFFFFFFFFFFFFF0000}
        Stretch = True
      end
      object QRLabel147: TQRLabel
        Left = 8
        Top = 31
        Width = 40
        Height = 8
        Size.Values = (
          21.166666666666670000
          21.166666666666670000
          82.020833333333330000
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
      object QRLabel148: TQRLabel
        Left = 3
        Top = 40
        Width = 94
        Height = 15
        Size.Values = (
          39.687500000000000000
          7.937500000000000000
          105.833333333333000000
          248.708333333333000000)
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
      object QRLabel149: TQRLabel
        Left = 169
        Top = 32
        Width = 37
        Height = 9
        Size.Values = (
          23.812500000000000000
          447.145833333333300000
          84.666666666666670000
          97.895833333333330000)
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
      object QRLabel150: TQRLabel
        Left = 172
        Top = 41
        Width = 38
        Height = 15
        Size.Values = (
          39.687500000000000000
          454.201388888889000000
          108.038194444444000000
          99.218750000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'REAL'
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
      object QRShape65: TQRShape
        Left = 164
        Top = 30
        Width = 3
        Height = 28
        Size.Values = (
          72.760416666666700000
          434.357638888889000000
          79.375000000000000000
          8.819444444444440000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape66: TQRShape
        Left = 211
        Top = 30
        Width = 3
        Height = 28
        Size.Values = (
          72.760416666666700000
          557.829861111111000000
          79.375000000000000000
          8.819444444444440000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel151: TQRLabel
        Left = 220
        Top = 32
        Width = 78
        Height = 8
        Size.Values = (
          21.166666666666670000
          582.083333333333300000
          84.666666666666670000
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
      object QRLabel152: TQRLabel
        Left = 219
        Top = 41
        Width = 102
        Height = 15
        Size.Values = (
          39.687500000000000000
          579.878472222222000000
          108.038194444444000000
          268.993055555556000000)
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
      object QRLabel153: TQRLabel
        Left = 0
        Top = 58
        Width = 74
        Height = 8
        Size.Values = (
          21.166666666666670000
          0.000000000000000000
          153.458333333333300000
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
      object QRLabel154: TQRLabel
        Left = 6
        Top = 66
        Width = 128
        Height = 15
        Size.Values = (
          39.687500000000000000
          15.434027777777800000
          174.184027777778000000
          339.548611111111000000)
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
      object QRLabel155: TQRLabel
        Left = 140
        Top = 58
        Width = 70
        Height = 8
        Size.Values = (
          21.166666666666670000
          370.416666666666700000
          153.458333333333300000
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
      object QRLabel156: TQRLabel
        Left = 142
        Top = 66
        Width = 123
        Height = 15
        Size.Values = (
          39.687500000000000000
          374.826388888889000000
          174.184027777778000000
          326.319444444444000000)
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
      object QRShape68: TQRShape
        Left = 137
        Top = 57
        Width = 3
        Height = 27
        Size.Values = (
          70.555555555555600000
          363.802083333333000000
          149.930555555556000000
          8.819444444444440000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel157: TQRLabel
        Left = 334
        Top = 58
        Width = 58
        Height = 8
        Size.Values = (
          21.166666666666670000
          883.708333333333300000
          153.458333333333300000
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
      object QRLabel158: TQRLabel
        Left = 332
        Top = 66
        Width = 82
        Height = 15
        Size.Values = (
          39.687500000000000000
          879.739583333333000000
          174.184027777778000000
          216.076388888889000000)
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
      object QRShape69: TQRShape
        Left = 324
        Top = 57
        Width = 3
        Height = 27
        Size.Values = (
          70.555555555555600000
          857.690972222222000000
          149.930555555556000000
          8.819444444444440000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel159: TQRLabel
        Left = 4
        Top = 85
        Width = 32
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          224.895833333333300000
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
      object QRLabel160: TQRLabel
        Left = 48
        Top = 97
        Width = 250
        Height = 12
        Size.Values = (
          30.868055555555600000
          127.881944444444000000
          255.763888888889000000
          661.458333333333000000)
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
      object QRLabel161: TQRLabel
        Left = 48
        Top = 107
        Width = 250
        Height = 12
        Size.Values = (
          30.868055555555600000
          127.881944444444000000
          282.222222222222000000
          661.458333333333000000)
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
      object QRLabel162: TQRLabel
        Left = 301
        Top = 89
        Width = 111
        Height = 11
        Size.Values = (
          30.238095238095200000
          797.529761904762000000
          236.235119047619000000
          292.931547619048000000)
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
      object QRLabel163: TQRLabel
        Left = 48
        Top = 86
        Width = 250
        Height = 12
        Size.Values = (
          30.868055555555600000
          127.881944444444000000
          227.100694444444000000
          661.458333333333000000)
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
      object QRLabel164: TQRLabel
        Left = 655
        Top = 4
        Width = 54
        Height = 15
        Size.Values = (
          39.687500000000000000
          1733.020833333333000000
          10.583333333333330000
          142.875000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Protocolo'
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
      object QRLabel165: TQRLabel
        Left = 655
        Top = 16
        Width = 60
        Height = 15
        Size.Values = (
          39.687500000000000000
          1733.020833333333000000
          42.333333333333330000
          158.750000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'de Entrega'
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
      object QRLabel166: TQRLabel
        Left = 421
        Top = 5
        Width = 186
        Height = 8
        Size.Values = (
          21.166666666666670000
          1113.895833333333000000
          13.229166666666670000
          492.125000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Recebi(emos) o bloquete com as caracter'#237'sticas ao lado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Left = 422
        Top = 30
        Height = 12
        Size.Values = (
          30.868055555555600000
          1117.864583333330000000
          79.375000000000000000
          171.979166666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel167: TQRLabel
        Left = 434
        Top = 38
        Width = 16
        Height = 8
        Size.Values = (
          21.166666666666670000
          1148.291666666667000000
          100.541666666666700000
          42.333333333333330000)
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
      object QRShape72: TQRShape
        Left = 496
        Top = 30
        Width = 152
        Height = 12
        Size.Values = (
          30.868055555555600000
          1311.892361111110000000
          79.375000000000000000
          401.284722222222000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape73: TQRShape
        Left = 421
        Top = 47
        Width = 293
        Height = 72
        Size.Values = (
          190.500000000000000000
          1113.895833333330000000
          124.354166666667000000
          775.229166666667000000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel168: TQRLabel
        Left = 548
        Top = 38
        Width = 37
        Height = 8
        Size.Values = (
          21.166666666666670000
          1449.916666666667000000
          100.541666666666700000
          97.895833333333330000)
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
      object QRLabel169: TQRLabel
        Left = 512
        Top = 50
        Width = 99
        Height = 8
        Size.Values = (
          21.166666666666670000
          1354.666666666667000000
          132.291666666666700000
          261.937500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Uso da Empresa Entregadora'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Left = 448
        Top = 61
        Width = 32
        Height = 8
        Size.Values = (
          21.166666666666670000
          1185.333333333333000000
          161.395833333333300000
          84.666666666666670000)
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
        Left = 430
        Top = 61
        Width = 16
        Height = 7
        Size.Values = (
          18.898809523809500000
          1137.708333333330000000
          160.639880952381000000
          43.467261904761900000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape75: TQRShape
        Left = 430
        Top = 70
        Width = 16
        Height = 7
        Size.Values = (
          18.898809523809500000
          1137.708333333330000000
          185.208333333333000000
          43.467261904761900000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel171: TQRLabel
        Left = 448
        Top = 70
        Width = 34
        Height = 8
        Size.Values = (
          21.166666666666670000
          1185.333333333333000000
          185.208333333333300000
          89.958333333333330000)
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
        Left = 430
        Top = 79
        Width = 16
        Height = 7
        Size.Values = (
          18.898809523809500000
          1137.708333333330000000
          209.776785714286000000
          43.467261904761900000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel172: TQRLabel
        Left = 448
        Top = 79
        Width = 28
        Height = 8
        Size.Values = (
          21.166666666666670000
          1185.333333333333000000
          209.020833333333300000
          74.083333333333330000)
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
        Left = 527
        Top = 61
        Width = 29
        Height = 8
        Size.Values = (
          21.166666666666670000
          1394.354166666667000000
          161.395833333333300000
          76.729166666666670000)
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
        Left = 510
        Top = 61
        Width = 16
        Height = 7
        Size.Values = (
          18.898809523809500000
          1349.375000000000000000
          160.639880952381000000
          43.467261904761900000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape78: TQRShape
        Left = 510
        Top = 70
        Width = 16
        Height = 7
        Size.Values = (
          18.898809523809500000
          1349.375000000000000000
          185.208333333333000000
          43.467261904761900000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel174: TQRLabel
        Left = 527
        Top = 70
        Width = 48
        Height = 8
        Size.Values = (
          21.166666666666670000
          1394.354166666667000000
          185.208333333333300000
          127.000000000000000000)
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
        Left = 510
        Top = 79
        Width = 16
        Height = 7
        Size.Values = (
          18.898809523809500000
          1349.375000000000000000
          209.776785714286000000
          43.467261904761900000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel175: TQRLabel
        Left = 527
        Top = 79
        Width = 50
        Height = 8
        Size.Values = (
          21.166666666666670000
          1394.354166666667000000
          209.020833333333300000
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
        Left = 620
        Top = 61
        Width = 73
        Height = 9
        Size.Values = (
          23.812500000000000000
          1640.416666666667000000
          161.395833333333300000
          193.145833333333300000)
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
        Left = 601
        Top = 61
        Width = 16
        Height = 7
        Size.Values = (
          18.898809523809500000
          1591.279761904760000000
          160.639880952381000000
          43.467261904761900000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape81: TQRShape
        Left = 601
        Top = 70
        Width = 16
        Height = 7
        Size.Values = (
          18.898809523809500000
          1591.279761904760000000
          185.208333333333000000
          43.467261904761900000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel177: TQRLabel
        Left = 620
        Top = 70
        Width = 75
        Height = 9
        Size.Values = (
          23.812500000000000000
          1640.416666666667000000
          185.208333333333300000
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
        Left = 601
        Top = 79
        Width = 16
        Height = 7
        Size.Values = (
          18.898809523809500000
          1591.279761904760000000
          209.776785714286000000
          43.467261904761900000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel178: TQRLabel
        Left = 620
        Top = 79
        Width = 83
        Height = 9
        Size.Values = (
          23.812500000000000000
          1640.416666666667000000
          209.020833333333300000
          219.604166666666700000)
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
        Left = 445
        Top = 100
        Height = 11
        Size.Values = (
          30.238095238095200000
          1177.395833333330000000
          264.583333333333000000
          171.979166666667000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel179: TQRLabel
        Left = 458
        Top = 108
        Width = 16
        Height = 8
        Size.Values = (
          21.166666666666670000
          1211.791666666667000000
          285.750000000000000000
          42.333333333333330000)
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
        Left = 519
        Top = 100
        Width = 151
        Height = 11
        Size.Values = (
          30.238095238095200000
          1372.053571428570000000
          264.583333333333000000
          400.654761904762000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel180: TQRLabel
        Left = 570
        Top = 108
        Width = 38
        Height = 8
        Size.Values = (
          21.166666666666670000
          1508.125000000000000000
          285.750000000000000000
          100.541666666666700000)
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
      object QRLabel114: TQRLabel
        Left = 2
        Top = 669
        Width = 32
        Height = 10
        Size.Values = (
          26.458333333333330000
          5.291666666666667000
          1770.062500000000000000
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
      object QRLabel66: TQRLabel
        Left = 1
        Top = 378
        Width = 117
        Height = 10
        Size.Values = (
          26.458333333333330000
          2.645833333333333000
          1000.125000000000000000
          309.562500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Recebimento atr'#225'ves do cheque n'#186
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Top = 385
        Width = 31
        Height = 10
        Size.Values = (
          26.458333333333330000
          2.645833333333333000
          1018.645833333333000000
          82.020833333333330000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'do banco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel115: TQRLabel
        Left = 1
        Top = 393
        Width = 194
        Height = 10
        Size.Values = (
          26.458333333333330000
          2.645833333333333000
          1039.812500000000000000
          513.291666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Esta quita'#231#227'o s'#243' ter'#225' validade ap'#243's pagamento do cheque'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel131: TQRLabel
        Left = 1
        Top = 402
        Width = 68
        Height = 10
        Size.Values = (
          26.458333333333330000
          2.645833333333333000
          1063.625000000000000000
          179.916666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'pelo Banco Sacador'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape85: TQRShape
        Left = 442
        Top = 488
        Width = 1
        Height = 24
        Size.Values = (
          63.940972222222200000
          1170.781250000000000000
          1289.843750000000000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape86: TQRShape
        Left = 442
        Top = 179
        Width = 1
        Height = 23
        Size.Values = (
          61.736111111111100000
          1170.781250000000000000
          474.045138888889000000
          2.204861111111110000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel33: TQRLabel
        Left = 70
        Top = 361
        Width = 310
        Height = 13
        Size.Values = (
          34.395833333333300000
          185.208333333333000000
          955.145833333334000000
          820.208333333334000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'LabelNomeSacado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel33Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
      object QRLabel78: TQRLabel
        Left = 70
        Top = 677
        Width = 310
        Height = 13
        Size.Values = (
          34.395833333333300000
          185.208333333333000000
          1791.229166666670000000
          820.208333333334000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'LabelNomeSacado'
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
      object QRLabel134: TQRLabel
        Left = 68
        Top = 991
        Width = 310
        Height = 13
        Size.Values = (
          34.395833333333300000
          179.916666666667000000
          2622.020833333330000000
          820.208333333334000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'LabelNomeSacado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel33Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 6
      end
    end
  end
end
