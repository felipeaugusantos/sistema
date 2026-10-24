object frmQckBanCoob: TfrmQckBanCoob
  Left = 177
  Top = 60
  Width = 853
  Height = 586
  VertScrollBar.Position = 5
  AutoScroll = True
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
    Top = -5
    Width = 794
    Height = 1123
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
    Zoom = 100
    PrevFormStyle = fsNormal
    PreviewInitialState = wsNormal
    PrevInitialZoom = qrZoomToFit
    PreviewDefaultSaveType = stQRP
    PreviewLeft = 0
    PreviewTop = 0
    object TitleBand1: TQRBand
      Left = 38
      Top = 139
      Width = 718
      Height = 944
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        2497.666666666667000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object LinhaHorizontal6: TQRShape
        Left = 4
        Top = 227
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333333000
          10.583333333333330000
          600.604166666666800000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal5: TQRShape
        Left = 2
        Top = 131
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333333000
          5.291666666666667000
          346.604166666666700000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal4: TQRShape
        Left = 2
        Top = 106
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333333000
          5.291666666666667000
          280.458333333333400000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal3: TQRShape
        Left = 4
        Top = 81
        Width = 711
        Height = 4
        Size.Values = (
          10.583333333333330000
          10.583333333333330000
          214.312500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal1: TQRShape
        Left = 4
        Top = 26
        Width = 711
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          68.791666666666680000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaHorizontal2: TQRShape
        Left = 4
        Top = 57
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333333000
          10.583333333333330000
          150.812500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LinhaVertical1: TQRShape
        Left = 159
        Top = 11
        Width = 10
        Height = 20
        Size.Values = (
          52.916666666666660000
          420.687500000000000000
          29.104166666666670000
          26.458333333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LinhaHorizontal7: TQRShape
        Left = 4
        Top = 272
        Width = 711
        Height = 4
        Size.Values = (
          10.583333333333330000
          10.583333333333330000
          719.666666666666800000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNrBanco: TQRLabel
        Left = 166
        Top = 11
        Width = 69
        Height = 20
        Size.Values = (
          52.916666666666660000
          439.208333333333400000
          29.104166666666670000
          182.562500000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '756-0'
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
        Top = 33
        Width = 40
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          87.312500000000000000
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
        Top = 11
        Width = 9
        Height = 20
        Size.Values = (
          52.916666666666660000
          619.125000000000000000
          29.104166666666670000
          23.812500000000000000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelLocalPagamento: TQRLabel
        Left = 4
        Top = 33
        Width = 68
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          87.312500000000000000
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
        Top = 60
        Width = 41
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          158.750000000000000000
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
        Top = 63
        Width = 500
        Height = 15
        Size.Values = (
          39.687500000000000000
          129.645833333333300000
          166.687500000000000000
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
        Top = 60
        Width = 74
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          158.750000000000000000
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
        Top = 84
        Width = 65
        Height = 8
        Size.Values = (
          21.166666666666670000
          10.583333333333330000
          222.250000000000000000
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
        Top = 84
        Width = 58
        Height = 8
        Size.Values = (
          21.166666666666670000
          320.145833333333300000
          222.250000000000000000
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
        Top = 84
        Width = 45
        Height = 8
        Size.Values = (
          21.166666666666670000
          738.187500000000000000
          222.250000000000000000
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
        Top = 84
        Width = 22
        Height = 8
        Size.Values = (
          21.166666666666670000
          915.458333333333300000
          222.250000000000000000
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
        Top = 84
        Width = 80
        Height = 8
        Size.Values = (
          21.166666666666670000
          1047.750000000000000000
          222.250000000000000000
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
        Top = 84
        Width = 70
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          222.250000000000000000
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
        Top = 108
        Width = 47
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          285.750000000000000000
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
        Top = 108
        Width = 17
        Height = 11
        Size.Values = (
          29.104166666666670000
          373.062500000000000000
          285.750000000000000000
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
        Top = 108
        Width = 37
        Height = 9
        Size.Values = (
          23.812500000000000000
          500.062500000000000000
          285.750000000000000000
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
        Top = 116
        Width = 62
        Height = 15
        Size.Values = (
          39.687500000000000000
          505.354166666666700000
          306.916666666666700000
          164.041666666666700000)
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
        Top = 108
        Width = 38
        Height = 11
        Size.Values = (
          29.104166666666670000
          698.500000000000000000
          285.750000000000000000
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
        Top = 108
        Width = 34
        Height = 11
        Size.Values = (
          29.104166666666670000
          1299.104166666667000000
          285.750000000000000000
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
        Top = 108
        Width = 8
        Height = 16
        Size.Values = (
          42.333333333333330000
          1270.000000000000000000
          285.750000000000000000
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
        Top = 108
        Width = 78
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          285.750000000000000000
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
        Top = 132
        Width = 36
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          349.250000000000000000
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
        Top = 133
        Width = 79
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          351.895833333333300000
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
        Top = 173
        Width = 46
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          457.729166666666700000
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
        Top = 212
        Width = 59
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          560.916666666666700000
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
        Top = 230
        Width = 32
        Height = 11
        Size.Values = (
          29.104166666666670000
          15.875000000000000000
          608.541666666666700000
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
        Top = 263
        Width = 62
        Height = 10
        Size.Values = (
          26.458333333333330000
          2.645833333333333000
          695.854166666666700000
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
        Top = 262
        Width = 62
        Height = 11
        Size.Values = (
          29.104166666666670000
          1505.479166666667000000
          693.208333333333300000
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
        Top = 275
        Width = 44
        Height = 10
        Size.Values = (
          26.458333333333330000
          1558.395833333333000000
          727.604166666666700000
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
        Top = 171
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333333000
          1471.083333333333000000
          452.437500000000000000
          418.041666666666700000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 556
        Top = 187
        Width = 158
        Height = 5
        Size.Values = (
          13.229166666666670000
          1471.083333333333000000
          494.770833333333400000
          418.041666666666700000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object LabelNomeTitular: TQRLabel
        Left = 50
        Top = 231
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666670000
          132.291666666666700000
          611.187500000000000000
          820.208333333333500000)
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
        Top = 242
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666670000
          132.291666666666700000
          640.291666666666800000
          820.208333333333500000)
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
        Top = 252
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666670000
          132.291666666666700000
          666.750000000000000000
          820.208333333333500000)
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
        Top = 31
        Width = 4
        Height = 196
        Size.Values = (
          518.583333333333400000
          1468.437500000000000000
          82.020833333333340000
          10.583333333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object LabelInformacao1: TQRLabel
        Left = 5
        Top = 45
        Width = 544
        Height = 11
        Size.Values = (
          29.104166666666670000
          13.229166666666670000
          119.062500000000000000
          1439.333333333333000000)
        XLColumn = 0
        Alignment = taCenter
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
        Left = 119
        Top = 82
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          314.854166666666700000
          216.958333333333400000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 275
        Top = 82
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          727.604166666666800000
          216.958333333333400000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape6: TQRShape
        Left = 344
        Top = 82
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          910.166666666666600000
          216.958333333333400000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape8: TQRShape
        Left = 137
        Top = 107
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          362.479166666666700000
          283.104166666666700000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 184
        Top = 107
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          486.833333333333400000
          283.104166666666700000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape12: TQRShape
        Left = 482
        Top = 107
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          1275.291666666667000000
          283.104166666666700000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape16: TQRShape
        Left = 556
        Top = 207
        Width = 156
        Height = 5
        Size.Values = (
          13.229166666666670000
          1471.083333333333000000
          547.687500000000000000
          412.750000000000100000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape17: TQRShape
        Left = 260
        Top = 107
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          687.916666666666800000
          283.104166666666700000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel40: TQRLabel
        Left = 8
        Top = 116
        Width = 121
        Height = 15
        Size.Values = (
          39.687500000000000000
          21.166666666666670000
          306.916666666666700000
          320.145833333333400000)
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
        Top = 82
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          1031.875000000000000000
          216.958333333333400000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel42: TQRLabel
        Left = 370
        Top = 91
        Width = 8
        Height = 15
        Size.Values = (
          39.687500000000000000
          978.958333333333300000
          240.770833333333300000
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
        Top = 898
        Width = 150
        Height = 22
        Size.Values = (
          58.208333333333330000
          1394.354166666667000000
          2375.958333333333000000
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
        Top = 597
        Width = 711
        Height = 5
        Size.Values = (
          13.229166666666670000
          5.291666666666667000
          1579.562500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRImage2: TQRImage
        Left = 6
        Top = 4
        Width = 149
        Height = 26
        Size.Values = (
          68.791666666666680000
          15.875000000000000000
          10.583333333333330000
          394.229166666666700000)
        XLColumn = 0
        Picture.Data = {
          0A544A504547496D61676526080000FFD8FFE000104A46494600010101006000
          600000FFE1002245786966000049492A00080000000100005104000100000000
          00000000000000FFDB004300080606070605080707070909080A0C140D0C0B0B
          0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434
          341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C2132
          3232323232323232323232323232323232323232323232323232323232323232
          3232323232323232323232323232323232FFC0001108001D0079030122000211
          01031101FFC4001F000001050101010101010000000000000000010203040506
          0708090A0BFFC400B5100002010303020403050504040000017D010203000411
          05122131410613516107227114328191A1082342B1C11552D1F0243362728209
          0A161718191A25262728292A3435363738393A434445464748494A5354555657
          58595A636465666768696A737475767778797A838485868788898A9293949596
          9798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2
          D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F
          0100030101010101010101010000000000000102030405060708090A0BFFC400
          B511000201020404030407050404000102770001020311040521310612415107
          61711322328108144291A1B1C109233352F0156272D10A162434E125F1171819
          1A262728292A35363738393A434445464748494A535455565758595A63646566
          6768696A737475767778797A82838485868788898A92939495969798999AA2A3
          A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8
          D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C0301000211031100
          3F00F41F146A1ACE9DAC48A97B224120DD0EC000C7A7D41AE5AEBC47E23F3116
          DF52B967660AA8B83B89EDD2BD3FC4BA47F6B694EA83FD222F9E23EA7B8FC7FC
          2B81F0F5CE9D67ACACF7FBCBC4331A04CE1BA64FD2BC1C4FB4A1894DCED17ADD
          BD0E59C24E5CB7D19873F8ABC4B6D712413EA7731CB1B15746C6548EDD2B5BC2
          9ADF89358F115B5BAEA533C487CC9B760AEC1D73F5E9F8D2F8E34B5D77518B51
          D1B02575DB70B27C80E3A30F7EDF9575FE01F0D49E1FD14BDD85FB7DC9DD295E
          76AFF0AE7F5FA9AF7E963F0D5D354649BF23C8A597E2E389B4E4F913DEEF52D6
          BBE3BF0D786EE45B6A9AAC50CF8C989433B28F70A091F8D5AD33C53A2EB1A2CD
          ABD85FC7358C218CB200414DA327208C838E7A57CEB70B0786BE22EA0FE35D1E
          6D4219659091B88DDB9B2245E9B8638C67BFB57ADE89278466F87DE229FC268B
          1452DBCAD710927746FE5100104E4703E9D6ADC1247B51AAE4D9DAE8BE20D27C
          4568D75A45F45770AB6D668CFDD3E8475159FAE78EBC33E1C9FC8D4F568629FB
          C4B9771F555048AF1CF863ACCBE1FF0087FE31D560C79D0245E5923A390CAA7F
          322ACFC26F02E9BE2B82FB5CD783DEB79E5046EE70ED8CB3B11C93CD0E095EE0
          AACA4924B567B3683E25D23C4D64F79A45EA5CC28DB5C8054A1F420E08AC6D43
          E27F83B4DBC6B5B8D6A232A1C37948D2007D09504572DF11ACF4FF00007812F2
          3F0EDA8B17D567482568DDB2170738C938E011F8D57F86BF0D7C3DA978160BED
          52C85CDCDF2B36E2C4796B92005C74E06734B9636BB1B9CEFCAB73D4B4AD634E
          D72C56F34CBC86EADDB8DF136707D0FA1F6354B5EF17683E1954FED7D4A1B667
          E563396761EA1464E2BC5BE1D5C4FE11F8B57DA047333D9C8D342EA7F8BCB52E
          8DF5C023F1AAFE04D361F88FF11F52BFD78B5C4688D70622C406F982A2FF00BA
          076F614F912F427DB36924B53DAB42F1CF86FC4B706DF4AD5229A7033E53028E
          47B06009FC2935CF1E786BC397BF63D5353482E7686F2F6331C1E87806BC73E2
          CF866CFC15AE691AB680A6C8CC598246C711C88410CBE99CF4F6F7ACFF00881A
          95B5C7C40D1F55BF80CB6D2D9DACF3C207DE5392CBFCE9A827A8A55A51BA7BA3
          DC746F1FF85F5FBB5B4D3B58824B96FBB13028CDF40C067F0AE96BE6395B44F1
          67C47D2D3C356B1E876E24425A7611EE656CE5573C3760075AFA72A651B1AD39
          B95EE15C1788B415B3D61EFA15FDD5D1CB7FB2FDFF003EBF9D77B55EF6D23BEB
          47B79380DD0FA1EC6BCDCCB07F5BC3CA9ADFA7A9AC5D9DCE4F41D3BED97A19C6
          6187E66F73D857695574FB18F4FB55810EEE72CC46371AB559E5380FA9E1D45F
          C4F57FE5F21CA5767887887E2A4174F7DA5EB3E0B6BA08EE9179A08DCB9C03CA
          E57D78AA5F0D7C35AB58F873C55AB5D5ACD6D6D71A7490C30BA90D29DA4E76F5
          E3A0F5DC6BDE5A28D8E5A3527D48A7E06318E3D2BD6E7D2C91CFECAEEED9E0FF
          0008F413ADF843C55A45D24902DDAC7186742369DAD83CF5C1C1ACAF0E7883C4
          DF09EF6EF4ED4746967B495F240042961C6E47008208ED5F46000740052322BF
          DE50DF519A39F7B87B1B2567AA3C96EAFA6F8C5E07D52DA0D324B1BCB39524B5
          F349DB2B019C67000C8C8FC6B9AF0B7C4BD57C0DA1B787B53D02E649ED8B0B7C
          82A46493B5B8E9927915F402AAA8C2A803D8535A28DCE5A3527D48A3996D61BA
          6EF74F53C5FE15F84F56D43C5577E31D72DDEDFCCF31A149176991E4EAD83D14
          0240FAD610B7D6BE1078EEE6F934E92F3499C322BA0243C4CC08E4746040EBD7
          9F5AFA22919558618023D08A39F517B156567A9F3C6B775AE7C63F12D84365A5
          4F67A6DB657CC941DA8188DCEC7A6700600F4A6FC470BA17C4FD2E65B5965B4B
          082DB08133B9509E3D3B57D10A8A8308A147A018A1A38DFEF22B7D4669A989D1
          BF5D4F9BBC4525DFC4CF1558C9A078727B245C234ED16DC9C83B9C8E0631C77A
          FA4E915153EEA85FA0C52D4CA573484396EFB9FFD9}
      end
      object QRShape13: TQRShape
        Left = 556
        Top = 150
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333333000
          1471.083333333333000000
          396.875000000000000000
          418.041666666666700000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel4: TQRLabel
        Left = 559
        Top = 153
        Width = 66
        Height = 11
        Size.Values = (
          29.104166666666670000
          1479.020833333333000000
          404.812500000000000000
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
        Top = 192
        Width = 75
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          508.000000000000000000
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
        Top = 116
        Width = 27
        Height = 15
        Size.Values = (
          39.687500000000000000
          373.062500000000000000
          306.916666666666700000
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
        Top = 41
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666667000000
          108.479166666666700000
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
        Left = 12
        Top = 91
        Width = 100
        Height = 15
        Size.Values = (
          39.687500000000000000
          31.750000000000000000
          240.770833333333300000
          264.583333333333400000)
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
        Top = 91
        Width = 137
        Height = 15
        Size.Values = (
          39.687500000000000000
          351.895833333333400000
          240.770833333333300000
          362.479166666666700000)
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
        Top = 91
        Width = 52
        Height = 15
        Size.Values = (
          39.687500000000000000
          746.125000000000000000
          240.770833333333300000
          137.583333333333300000)
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
        Top = 91
        Width = 142
        Height = 15
        Size.Values = (
          39.687500000000000000
          1053.041666666667000000
          240.770833333333300000
          375.708333333333400000)
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
        Top = 66
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666667000000
          174.625000000000000000
          351.895833333333400000)
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
        Top = 90
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666667000000
          238.125000000000000000
          351.895833333333400000)
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
        Left = 573
        Top = 116
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1516.062500000000000000
          306.916666666666700000
          351.895833333333400000)
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
        Top = 168
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666670000
          52.916666666666660000
          444.500000000000000000
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
        Top = 180
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666670000
          52.916666666666660000
          476.250000000000000000
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
        Top = 192
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666670000
          52.916666666666660000
          508.000000000000000000
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
        Top = 203
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666670000
          52.916666666666660000
          537.104166666666800000
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
        Top = 214
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666670000
          52.916666666666660000
          566.208333333333400000
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
        Top = 262
        Width = 57
        Height = 11
        Size.Values = (
          29.104166666666670000
          1682.750000000000000000
          693.208333333333300000
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
        Top = 890
        Width = 461
        Height = 20
        Size.Values = (
          52.916666666666660000
          68.791666666666680000
          2354.791666666667000000
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
        Top = 838
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333333000
          5.291666666666667000
          2217.208333333333000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape11: TQRShape
        Left = 2
        Top = 730
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333333000
          5.291666666666667000
          1931.458333333333000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape14: TQRShape
        Left = 2
        Top = 705
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333333000
          5.291666666666667000
          1865.312500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape15: TQRShape
        Left = 2
        Top = 680
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333333000
          5.291666666666667000
          1799.166666666667000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape18: TQRShape
        Left = 2
        Top = 623
        Width = 711
        Height = 11
        Size.Values = (
          29.104166666666670000
          5.291666666666667000
          1648.354166666667000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape19: TQRShape
        Left = 2
        Top = 655
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333333000
          5.291666666666667000
          1733.020833333333000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape20: TQRShape
        Left = 159
        Top = 607
        Width = 10
        Height = 20
        Size.Values = (
          52.916666666666660000
          420.687500000000000000
          1606.020833333333000000
          26.458333333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape21: TQRShape
        Left = 2
        Top = 884
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333333000
          5.291666666666667000
          2338.916666666667000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel7: TQRLabel
        Left = 167
        Top = 607
        Width = 68
        Height = 20
        Size.Values = (
          52.916666666666660000
          441.854166666666700000
          1606.020833333333000000
          179.916666666666700000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '756-0'
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
        Top = 630
        Width = 40
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1666.875000000000000000
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
        Top = 607
        Width = 8
        Height = 20
        Size.Values = (
          52.916666666666660000
          613.833333333333400000
          1606.020833333333000000
          21.166666666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel9: TQRLabel
        Left = 4
        Top = 631
        Width = 68
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          1669.520833333333000000
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
        Top = 664
        Width = 500
        Height = 15
        Size.Values = (
          39.687500000000000000
          129.645833333333300000
          1756.833333333333000000
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
        Top = 657
        Width = 74
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1738.312500000000000000
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
        Top = 682
        Width = 65
        Height = 8
        Size.Values = (
          21.166666666666670000
          5.291666666666667000
          1804.458333333333000000
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
        Top = 682
        Width = 58
        Height = 8
        Size.Values = (
          21.166666666666670000
          320.145833333333300000
          1804.458333333333000000
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
        Top = 682
        Width = 45
        Height = 8
        Size.Values = (
          21.166666666666670000
          735.541666666666700000
          1804.458333333333000000
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
        Top = 682
        Width = 22
        Height = 8
        Size.Values = (
          21.166666666666670000
          920.750000000000000000
          1804.458333333333000000
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
        Top = 682
        Width = 80
        Height = 8
        Size.Values = (
          21.166666666666670000
          1047.750000000000000000
          1804.458333333333000000
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
        Top = 682
        Width = 70
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          1804.458333333333000000
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
        Top = 707
        Width = 47
        Height = 8
        Size.Values = (
          21.166666666666670000
          5.291666666666667000
          1870.604166666667000000
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
        Top = 707
        Width = 17
        Height = 8
        Size.Values = (
          21.166666666666670000
          373.062500000000000000
          1870.604166666667000000
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
        Top = 707
        Width = 37
        Height = 8
        Size.Values = (
          21.166666666666670000
          500.062500000000000000
          1870.604166666667000000
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
        Left = 192
        Top = 714
        Width = 61
        Height = 15
        Size.Values = (
          39.687500000000000000
          508.000000000000000000
          1889.125000000000000000
          161.395833333333300000)
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
        Top = 707
        Width = 38
        Height = 8
        Size.Values = (
          21.166666666666670000
          698.500000000000000000
          1870.604166666667000000
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
        Top = 707
        Width = 34
        Height = 8
        Size.Values = (
          21.166666666666670000
          1304.395833333333000000
          1870.604166666667000000
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
        Top = 709
        Width = 8
        Height = 18
        Size.Values = (
          47.625000000000000000
          1270.000000000000000000
          1875.895833333333000000
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
        Top = 708
        Width = 78
        Height = 8
        Size.Values = (
          21.166666666666670000
          1481.666666666667000000
          1873.250000000000000000
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
        Top = 732
        Width = 36
        Height = 9
        Size.Values = (
          23.812500000000000000
          5.291666666666667000
          1936.750000000000000000
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
        Top = 732
        Width = 79
        Height = 9
        Size.Values = (
          23.812500000000000000
          1481.666666666667000000
          1936.750000000000000000
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
        Top = 772
        Width = 46
        Height = 9
        Size.Values = (
          23.812500000000000000
          1481.666666666667000000
          2042.583333333333000000
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
        Top = 808
        Width = 59
        Height = 9
        Size.Values = (
          23.812500000000000000
          1481.666666666667000000
          2137.833333333333000000
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
        Left = 2
        Top = 841
        Width = 32
        Height = 9
        Size.Values = (
          23.812500000000000000
          5.291666666666667000
          2225.145833333333000000
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
        Top = 875
        Width = 62
        Height = 8
        Size.Values = (
          21.166666666666670000
          5.291666666666667000
          2315.104166666667000000
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
        Top = 871
        Width = 62
        Height = 12
        Size.Values = (
          31.750000000000000000
          1486.958333333333000000
          2304.520833333333000000
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
        Left = 587
        Top = 888
        Width = 44
        Height = 8
        Size.Values = (
          21.166666666666670000
          1553.104166666667000000
          2349.500000000000000000
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
        Top = 770
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333333000
          1471.083333333333000000
          2037.291666666667000000
          418.041666666666700000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape24: TQRShape
        Left = 556
        Top = 786
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333333000
          1471.083333333333000000
          2079.625000000000000000
          418.041666666666700000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel35: TQRLabel
        Left = 43
        Top = 840
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666670000
          113.770833333333300000
          2222.500000000000000000
          820.208333333333500000)
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
        Top = 851
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666670000
          113.770833333333300000
          2251.604166666667000000
          820.208333333333500000)
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
        Top = 862
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666670000
          113.770833333333300000
          2280.708333333333000000
          820.208333333333500000)
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
        Top = 628
        Width = 2
        Height = 211
        Size.Values = (
          558.270833333333400000
          1468.437500000000000000
          1661.583333333333000000
          5.291666666666667000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel41: TQRLabel
        Left = 5
        Top = 642
        Width = 542
        Height = 13
        Size.Values = (
          34.395833333333340000
          13.229166666666670000
          1698.625000000000000000
          1434.041666666667000000)
        XLColumn = 0
        Alignment = taCenter
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
      object QRShape27: TQRShape
        Left = 119
        Top = 681
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333340000
          314.854166666666700000
          1801.812500000000000000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape29: TQRShape
        Left = 275
        Top = 681
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333340000
          727.604166666666800000
          1801.812500000000000000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape30: TQRShape
        Left = 343
        Top = 681
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333340000
          907.520833333333400000
          1801.812500000000000000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape31: TQRShape
        Left = 137
        Top = 705
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333340000
          362.479166666666700000
          1865.312500000000000000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape32: TQRShape
        Left = 183
        Top = 705
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333340000
          484.187500000000000000
          1865.312500000000000000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape33: TQRShape
        Left = 482
        Top = 705
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333340000
          1275.291666666667000000
          1865.312500000000000000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape34: TQRShape
        Left = 556
        Top = 808
        Width = 156
        Height = 1
        Size.Values = (
          2.645833333333333000
          1471.083333333333000000
          2137.833333333333000000
          412.750000000000100000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape35: TQRShape
        Left = 260
        Top = 705
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333340000
          687.916666666666800000
          1865.312500000000000000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel44: TQRLabel
        Left = 7
        Top = 714
        Width = 119
        Height = 15
        Size.Values = (
          39.687500000000000000
          18.520833333333330000
          1889.125000000000000000
          314.854166666666700000)
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
        Top = 681
        Width = 1
        Height = 25
        Size.Values = (
          66.145833333333340000
          1031.875000000000000000
          1801.812500000000000000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel45: TQRLabel
        Left = 372
        Top = 691
        Width = 8
        Height = 15
        Size.Values = (
          39.687500000000000000
          984.250000000000000000
          1828.270833333333000000
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
        Top = 603
        Width = 149
        Height = 25
        Size.Values = (
          66.145833333333340000
          15.875000000000000000
          1595.437500000000000000
          394.229166666666700000)
        XLColumn = 0
        Picture.Data = {
          0A544A504547496D61676526080000FFD8FFE000104A46494600010101006000
          600000FFE1002245786966000049492A00080000000100005104000100000000
          00000000000000FFDB004300080606070605080707070909080A0C140D0C0B0B
          0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434
          341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C2132
          3232323232323232323232323232323232323232323232323232323232323232
          3232323232323232323232323232323232FFC0001108001D0079030122000211
          01031101FFC4001F000001050101010101010000000000000000010203040506
          0708090A0BFFC400B5100002010303020403050504040000017D010203000411
          05122131410613516107227114328191A1082342B1C11552D1F0243362728209
          0A161718191A25262728292A3435363738393A434445464748494A5354555657
          58595A636465666768696A737475767778797A838485868788898A9293949596
          9798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2
          D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F
          0100030101010101010101010000000000000102030405060708090A0BFFC400
          B511000201020404030407050404000102770001020311040521310612415107
          61711322328108144291A1B1C109233352F0156272D10A162434E125F1171819
          1A262728292A35363738393A434445464748494A535455565758595A63646566
          6768696A737475767778797A82838485868788898A92939495969798999AA2A3
          A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8
          D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C0301000211031100
          3F00F41F146A1ACE9DAC48A97B224120DD0EC000C7A7D41AE5AEBC47E23F3116
          DF52B967660AA8B83B89EDD2BD3FC4BA47F6B694EA83FD222F9E23EA7B8FC7FC
          2B81F0F5CE9D67ACACF7FBCBC4331A04CE1BA64FD2BC1C4FB4A1894DCED17ADD
          BD0E59C24E5CB7D19873F8ABC4B6D712413EA7731CB1B15746C6548EDD2B5BC2
          9ADF89358F115B5BAEA533C487CC9B760AEC1D73F5E9F8D2F8E34B5D77518B51
          D1B02575DB70B27C80E3A30F7EDF9575FE01F0D49E1FD14BDD85FB7DC9DD295E
          76AFF0AE7F5FA9AF7E963F0D5D354649BF23C8A597E2E389B4E4F913DEEF52D6
          BBE3BF0D786EE45B6A9AAC50CF8C989433B28F70A091F8D5AD33C53A2EB1A2CD
          ABD85FC7358C218CB200414DA327208C838E7A57CEB70B0786BE22EA0FE35D1E
          6D4219659091B88DDB9B2245E9B8638C67BFB57ADE89278466F87DE229FC268B
          1452DBCAD710927746FE5100104E4703E9D6ADC1247B51AAE4D9DAE8BE20D27C
          4568D75A45F45770AB6D668CFDD3E8475159FAE78EBC33E1C9FC8D4F568629FB
          C4B9771F555048AF1CF863ACCBE1FF0087FE31D560C79D0245E5923A390CAA7F
          322ACFC26F02E9BE2B82FB5CD783DEB79E5046EE70ED8CB3B11C93CD0E095EE0
          AACA4924B567B3683E25D23C4D64F79A45EA5CC28DB5C8054A1F420E08AC6D43
          E27F83B4DBC6B5B8D6A232A1C37948D2007D09504572DF11ACF4FF00007812F2
          3F0EDA8B17D567482568DDB2170738C938E011F8D57F86BF0D7C3DA978160BED
          52C85CDCDF2B36E2C4796B92005C74E06734B9636BB1B9CEFCAB73D4B4AD634E
          D72C56F34CBC86EADDB8DF136707D0FA1F6354B5EF17683E1954FED7D4A1B667
          E563396761EA1464E2BC5BE1D5C4FE11F8B57DA047333D9C8D342EA7F8BCB52E
          8DF5C023F1AAFE04D361F88FF11F52BFD78B5C4688D70622C406F982A2FF00BA
          076F614F912F427DB36924B53DAB42F1CF86FC4B706DF4AD5229A7033E53028E
          47B06009FC2935CF1E786BC397BF63D5353482E7686F2F6331C1E87806BC73E2
          CF866CFC15AE691AB680A6C8CC598246C711C88410CBE99CF4F6F7ACFF00881A
          95B5C7C40D1F55BF80CB6D2D9DACF3C207DE5392CBFCE9A827A8A55A51BA7BA3
          DC746F1FF85F5FBB5B4D3B58824B96FBB13028CDF40C067F0AE96BE6395B44F1
          67C47D2D3C356B1E876E24425A7611EE656CE5573C3760075AFA72A651B1AD39
          B95EE15C1788B415B3D61EFA15FDD5D1CB7FB2FDFF003EBF9D77B55EF6D23BEB
          47B79380DD0FA1EC6BCDCCB07F5BC3CA9ADFA7A9AC5D9DCE4F41D3BED97A19C6
          6187E66F73D857695574FB18F4FB55810EEE72CC46371AB559E5380FA9E1D45F
          C4F57FE5F21CA5767887887E2A4174F7DA5EB3E0B6BA08EE9179A08DCB9C03CA
          E57D78AA5F0D7C35AB58F873C55AB5D5ACD6D6D71A7490C30BA90D29DA4E76F5
          E3A0F5DC6BDE5A28D8E5A3527D48A7E06318E3D2BD6E7D2C91CFECAEEED9E0FF
          0008F413ADF843C55A45D24902DDAC7186742369DAD83CF5C1C1ACAF0E7883C4
          DF09EF6EF4ED4746967B495F240042961C6E47008208ED5F46000740052322BF
          DE50DF519A39F7B87B1B2567AA3C96EAFA6F8C5E07D52DA0D324B1BCB39524B5
          F349DB2B019C67000C8C8FC6B9AF0B7C4BD57C0DA1B787B53D02E649ED8B0B7C
          82A46493B5B8E9927915F402AAA8C2A803D8535A28DCE5A3527D48A3996D61BA
          6EF74F53C5FE15F84F56D43C5577E31D72DDEDFCCF31A149176991E4EAD83D14
          0240FAD610B7D6BE1078EEE6F934E92F3499C322BA0243C4CC08E4746040EBD7
          9F5AFA22919558618023D08A39F517B156567A9F3C6B775AE7C63F12D84365A5
          4F67A6DB657CC941DA8188DCEC7A6700600F4A6FC470BA17C4FD2E65B5965B4B
          082DB08133B9509E3D3B57D10A8A8308A147A018A1A38DFEF22B7D4669A989D1
          BF5D4F9BBC4525DFC4CF1558C9A078727B245C234ED16DC9C83B9C8E0631C77A
          FA4E915153EEA85FA0C52D4CA573484396EFB9FFD9}
      end
      object QRShape37: TQRShape
        Left = 556
        Top = 750
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333333000
          1471.083333333333000000
          1984.375000000000000000
          418.041666666666700000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel46: TQRLabel
        Left = 558
        Top = 752
        Width = 66
        Height = 9
        Size.Values = (
          23.812500000000000000
          1476.375000000000000000
          1989.666666666667000000
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
        Top = 788
        Width = 75
        Height = 9
        Size.Values = (
          23.812500000000000000
          1481.666666666667000000
          2084.916666666667000000
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
        Top = 715
        Width = 27
        Height = 15
        Size.Values = (
          39.687500000000000000
          375.708333333333300000
          1891.770833333333000000
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
        Top = 638
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666667000000
          1688.041666666667000000
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
      object QRLabel52: TQRLabel
        Left = 11
        Top = 689
        Width = 100
        Height = 15
        Size.Values = (
          39.687500000000000000
          29.104166666666670000
          1822.979166666667000000
          264.583333333333400000)
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
        Top = 689
        Width = 136
        Height = 15
        Size.Values = (
          39.687500000000000000
          343.958333333333400000
          1822.979166666667000000
          359.833333333333400000)
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
        Top = 689
        Width = 54
        Height = 15
        Size.Values = (
          39.687500000000000000
          743.479166666666800000
          1822.979166666667000000
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
        Top = 689
        Width = 141
        Height = 15
        Size.Values = (
          39.687500000000000000
          1055.687500000000000000
          1822.979166666667000000
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
        Top = 664
        Width = 132
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666667000000
          1756.833333333333000000
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
        Left = 578
        Top = 689
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1529.291666666667000000
          1822.979166666667000000
          351.895833333333400000)
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
        Top = 714
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666667000000
          1889.125000000000000000
          351.895833333333400000)
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
        Top = 871
        Width = 57
        Height = 12
        Size.Values = (
          31.750000000000000000
          1661.583333333333000000
          2304.520833333333000000
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
        Left = 249
        Top = 609
        Width = 448
        Height = 19
        Size.Values = (
          50.270833333333330000
          658.812500000000000000
          1611.312500000000000000
          1185.333333333333000000)
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
        Left = 685
        Top = 592
        Width = 16
        Height = 16
        Size.Values = (
          42.333333333333330000
          1812.395833333333000000
          1566.333333333333000000
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
        Top = 905
        Width = 461
        Height = 20
        Size.Values = (
          52.916666666666660000
          68.791666666666680000
          2394.479166666667000000
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
        Top = 920
        Width = 461
        Height = 20
        Size.Values = (
          52.916666666666660000
          68.791666666666680000
          2434.166666666667000000
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
        Top = 135
        Width = 495
        Height = 11
        Size.Values = (
          29.104166666666670000
          116.416666666666700000
          357.187500000000000000
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
        Left = 20
        Top = 157
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666670000
          52.916666666666660000
          415.395833333333400000
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
        Top = 234
        Width = 176
        Height = 11
        Size.Values = (
          29.104166666666670000
          1018.645833333333000000
          619.125000000000000000
          465.666666666666800000)
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
        Top = 845
        Width = 176
        Height = 11
        Size.Values = (
          29.104166666666670000
          981.604166666666800000
          2235.729166666667000000
          465.666666666666800000)
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
        Top = 146
        Width = 519
        Height = 11
        Size.Values = (
          29.104166666666670000
          52.916666666666660000
          386.291666666666700000
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
        Top = 775
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666660000
          2050.520833333333000000
          1370.541666666667000000)
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
        Top = 788
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666660000
          2084.916666666667000000
          1370.541666666667000000)
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
        Top = 802
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666660000
          2121.958333333333000000
          1370.541666666667000000)
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
        Top = 814
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666660000
          2153.708333333333000000
          1370.541666666667000000)
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
        Top = 823
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666660000
          2177.520833333333000000
          1370.541666666667000000)
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
        Top = 735
        Width = 495
        Height = 12
        Size.Values = (
          31.750000000000000000
          113.770833333333300000
          1944.687500000000000000
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
        Left = 20
        Top = 762
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666660000
          2016.125000000000000000
          1370.541666666667000000)
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
        Top = 748
        Width = 518
        Height = 12
        Size.Values = (
          31.750000000000000000
          52.916666666666660000
          1979.083333333333000000
          1370.541666666667000000)
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
        Top = 286
        Width = 711
        Height = 5
        Size.Values = (
          13.229166666666670000
          5.291666666666667000
          756.708333333333400000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape39: TQRShape
        Left = 2
        Top = 527
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333333000
          5.291666666666667000
          1394.354166666667000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape40: TQRShape
        Left = 2
        Top = 422
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333333000
          5.291666666666667000
          1116.541666666667000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape41: TQRShape
        Left = 2
        Top = 397
        Width = 711
        Height = 1
        Size.Values = (
          2.645833333333333000
          5.291666666666667000
          1050.395833333333000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape42: TQRShape
        Left = 2
        Top = 371
        Width = 711
        Height = 2
        Size.Values = (
          5.291666666666667000
          5.291666666666667000
          981.604166666666800000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape43: TQRShape
        Left = 2
        Top = 315
        Width = 711
        Height = 11
        Size.Values = (
          29.104166666666670000
          5.291666666666667000
          833.437500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape44: TQRShape
        Left = 2
        Top = 347
        Width = 711
        Height = 2
        Size.Values = (
          5.291666666666667000
          5.291666666666667000
          918.104166666666800000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape45: TQRShape
        Left = 159
        Top = 300
        Width = 10
        Height = 20
        Size.Values = (
          52.916666666666660000
          420.687500000000000000
          793.750000000000000000
          26.458333333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape46: TQRShape
        Left = 2
        Top = 573
        Width = 711
        Height = 4
        Size.Values = (
          10.583333333333330000
          5.291666666666667000
          1516.062500000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel89: TQRLabel
        Left = 167
        Top = 300
        Width = 68
        Height = 20
        Size.Values = (
          52.916666666666660000
          441.854166666666700000
          793.750000000000000000
          179.916666666666700000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '756-0'
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
        Top = 323
        Width = 40
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          854.604166666666700000
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
        Top = 300
        Width = 8
        Height = 20
        Size.Values = (
          52.916666666666660000
          613.833333333333400000
          793.750000000000000000
          21.166666666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel91: TQRLabel
        Left = 4
        Top = 322
        Width = 68
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          851.958333333333300000
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
        Top = 353
        Width = 501
        Height = 15
        Size.Values = (
          39.687500000000000000
          127.000000000000000000
          933.979166666666700000
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
      object QRLabel93: TQRLabel
        Left = 560
        Top = 349
        Width = 74
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          923.395833333333300000
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
        Top = 373
        Width = 65
        Height = 11
        Size.Values = (
          29.104166666666670000
          5.291666666666667000
          986.895833333333300000
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
        Top = 373
        Width = 58
        Height = 11
        Size.Values = (
          29.104166666666670000
          320.145833333333300000
          986.895833333333300000
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
        Top = 373
        Width = 45
        Height = 11
        Size.Values = (
          29.104166666666670000
          735.541666666666700000
          986.895833333333300000
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
        Top = 373
        Width = 22
        Height = 11
        Size.Values = (
          29.104166666666670000
          920.750000000000000000
          986.895833333333300000
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
        Top = 373
        Width = 80
        Height = 11
        Size.Values = (
          29.104166666666670000
          1047.750000000000000000
          986.895833333333300000
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
        Top = 373
        Width = 70
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          986.895833333333300000
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
        Left = 8
        Top = 400
        Width = 47
        Height = 11
        Size.Values = (
          29.104166666666670000
          21.166666666666670000
          1058.333333333333000000
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
        Top = 399
        Width = 17
        Height = 11
        Size.Values = (
          29.104166666666670000
          373.062500000000000000
          1055.687500000000000000
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
        Top = 399
        Width = 37
        Height = 11
        Size.Values = (
          29.104166666666670000
          500.062500000000000000
          1055.687500000000000000
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
        Top = 406
        Width = 61
        Height = 15
        Size.Values = (
          39.687500000000000000
          510.645833333333300000
          1074.208333333333000000
          161.395833333333300000)
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
        Top = 400
        Width = 38
        Height = 11
        Size.Values = (
          29.104166666666670000
          698.500000000000000000
          1058.333333333333000000
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
        Top = 400
        Width = 34
        Height = 11
        Size.Values = (
          29.104166666666670000
          1304.395833333333000000
          1058.333333333333000000
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
        Top = 400
        Width = 8
        Height = 16
        Size.Values = (
          42.333333333333330000
          1270.000000000000000000
          1058.333333333333000000
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
        Top = 400
        Width = 78
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1058.333333333333000000
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
        Top = 424
        Width = 79
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1121.833333333333000000
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
        Top = 463
        Width = 46
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1225.020833333333000000
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
        Top = 500
        Width = 59
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1322.916666666667000000
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
        Top = 565
        Width = 62
        Height = 10
        Size.Values = (
          26.458333333333330000
          5.291666666666667000
          1494.895833333333000000
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
      object QRLabel112: TQRLabel
        Left = 562
        Top = 564
        Width = 62
        Height = 11
        Size.Values = (
          29.104166666666670000
          1486.958333333333000000
          1492.250000000000000000
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
      object QRShape48: TQRShape
        Left = 556
        Top = 458
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333333000
          1471.083333333333000000
          1211.791666666667000000
          418.041666666666700000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape49: TQRShape
        Left = 556
        Top = 475
        Width = 158
        Height = 5
        Size.Values = (
          13.229166666666670000
          1471.083333333333000000
          1256.770833333333000000
          418.041666666666700000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel113: TQRLabel
        Left = 43
        Top = 530
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666670000
          113.770833333333300000
          1402.291666666667000000
          820.208333333333500000)
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
        Left = 43
        Top = 541
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666670000
          113.770833333333300000
          1431.395833333333000000
          820.208333333333500000)
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
        Left = 43
        Top = 552
        Width = 310
        Height = 11
        Size.Values = (
          29.104166666666670000
          113.770833333333300000
          1460.500000000000000000
          820.208333333333500000)
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
        Left = 555
        Top = 320
        Width = 2
        Height = 209
        Size.Values = (
          552.979166666666800000
          1468.437500000000000000
          846.666666666666600000
          5.291666666666667000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel116: TQRLabel
        Left = 5
        Top = 334
        Width = 542
        Height = 13
        Size.Values = (
          34.395833333333340000
          13.229166666666670000
          883.708333333333400000
          1434.041666666667000000)
        XLColumn = 0
        Alignment = taCenter
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
      object QRShape51: TQRShape
        Left = 119
        Top = 374
        Width = 1
        Height = 22
        Size.Values = (
          58.208333333333340000
          314.854166666666700000
          989.541666666666800000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape52: TQRShape
        Left = 275
        Top = 373
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          727.604166666666800000
          986.895833333333400000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape53: TQRShape
        Left = 344
        Top = 373
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          910.166666666666600000
          986.895833333333400000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape54: TQRShape
        Left = 137
        Top = 397
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          362.479166666666700000
          1050.395833333333000000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape55: TQRShape
        Left = 184
        Top = 397
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          486.833333333333400000
          1050.395833333333000000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape56: TQRShape
        Left = 482
        Top = 397
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          1275.291666666667000000
          1050.395833333333000000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape57: TQRShape
        Left = 556
        Top = 494
        Width = 156
        Height = 5
        Size.Values = (
          13.229166666666670000
          1471.083333333333000000
          1307.041666666667000000
          412.750000000000100000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape58: TQRShape
        Left = 260
        Top = 397
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          687.916666666666800000
          1050.395833333333000000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel118: TQRLabel
        Left = 7
        Top = 406
        Width = 119
        Height = 15
        Size.Values = (
          39.687500000000000000
          18.520833333333330000
          1074.208333333333000000
          314.854166666666700000)
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
        Left = 390
        Top = 373
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          1031.875000000000000000
          986.895833333333400000
          2.645833333333333000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel119: TQRLabel
        Left = 372
        Top = 378
        Width = 8
        Height = 15
        Size.Values = (
          39.687500000000000000
          984.250000000000000000
          1000.125000000000000000
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
      object QRImage3: TQRImage
        Left = 6
        Top = 293
        Width = 149
        Height = 25
        Size.Values = (
          66.145833333333340000
          15.875000000000000000
          775.229166666666800000
          394.229166666666700000)
        XLColumn = 0
        Picture.Data = {
          0A544A504547496D61676526080000FFD8FFE000104A46494600010101006000
          600000FFE1002245786966000049492A00080000000100005104000100000000
          00000000000000FFDB004300080606070605080707070909080A0C140D0C0B0B
          0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434
          341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C2132
          3232323232323232323232323232323232323232323232323232323232323232
          3232323232323232323232323232323232FFC0001108001D0079030122000211
          01031101FFC4001F000001050101010101010000000000000000010203040506
          0708090A0BFFC400B5100002010303020403050504040000017D010203000411
          05122131410613516107227114328191A1082342B1C11552D1F0243362728209
          0A161718191A25262728292A3435363738393A434445464748494A5354555657
          58595A636465666768696A737475767778797A838485868788898A9293949596
          9798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2
          D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F
          0100030101010101010101010000000000000102030405060708090A0BFFC400
          B511000201020404030407050404000102770001020311040521310612415107
          61711322328108144291A1B1C109233352F0156272D10A162434E125F1171819
          1A262728292A35363738393A434445464748494A535455565758595A63646566
          6768696A737475767778797A82838485868788898A92939495969798999AA2A3
          A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8
          D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C0301000211031100
          3F00F41F146A1ACE9DAC48A97B224120DD0EC000C7A7D41AE5AEBC47E23F3116
          DF52B967660AA8B83B89EDD2BD3FC4BA47F6B694EA83FD222F9E23EA7B8FC7FC
          2B81F0F5CE9D67ACACF7FBCBC4331A04CE1BA64FD2BC1C4FB4A1894DCED17ADD
          BD0E59C24E5CB7D19873F8ABC4B6D712413EA7731CB1B15746C6548EDD2B5BC2
          9ADF89358F115B5BAEA533C487CC9B760AEC1D73F5E9F8D2F8E34B5D77518B51
          D1B02575DB70B27C80E3A30F7EDF9575FE01F0D49E1FD14BDD85FB7DC9DD295E
          76AFF0AE7F5FA9AF7E963F0D5D354649BF23C8A597E2E389B4E4F913DEEF52D6
          BBE3BF0D786EE45B6A9AAC50CF8C989433B28F70A091F8D5AD33C53A2EB1A2CD
          ABD85FC7358C218CB200414DA327208C838E7A57CEB70B0786BE22EA0FE35D1E
          6D4219659091B88DDB9B2245E9B8638C67BFB57ADE89278466F87DE229FC268B
          1452DBCAD710927746FE5100104E4703E9D6ADC1247B51AAE4D9DAE8BE20D27C
          4568D75A45F45770AB6D668CFDD3E8475159FAE78EBC33E1C9FC8D4F568629FB
          C4B9771F555048AF1CF863ACCBE1FF0087FE31D560C79D0245E5923A390CAA7F
          322ACFC26F02E9BE2B82FB5CD783DEB79E5046EE70ED8CB3B11C93CD0E095EE0
          AACA4924B567B3683E25D23C4D64F79A45EA5CC28DB5C8054A1F420E08AC6D43
          E27F83B4DBC6B5B8D6A232A1C37948D2007D09504572DF11ACF4FF00007812F2
          3F0EDA8B17D567482568DDB2170738C938E011F8D57F86BF0D7C3DA978160BED
          52C85CDCDF2B36E2C4796B92005C74E06734B9636BB1B9CEFCAB73D4B4AD634E
          D72C56F34CBC86EADDB8DF136707D0FA1F6354B5EF17683E1954FED7D4A1B667
          E563396761EA1464E2BC5BE1D5C4FE11F8B57DA047333D9C8D342EA7F8BCB52E
          8DF5C023F1AAFE04D361F88FF11F52BFD78B5C4688D70622C406F982A2FF00BA
          076F614F912F427DB36924B53DAB42F1CF86FC4B706DF4AD5229A7033E53028E
          47B06009FC2935CF1E786BC397BF63D5353482E7686F2F6331C1E87806BC73E2
          CF866CFC15AE691AB680A6C8CC598246C711C88410CBE99CF4F6F7ACFF00881A
          95B5C7C40D1F55BF80CB6D2D9DACF3C207DE5392CBFCE9A827A8A55A51BA7BA3
          DC746F1FF85F5FBB5B4D3B58824B96FBB13028CDF40C067F0AE96BE6395B44F1
          67C47D2D3C356B1E876E24425A7611EE656CE5573C3760075AFA72A651B1AD39
          B95EE15C1788B415B3D61EFA15FDD5D1CB7FB2FDFF003EBF9D77B55EF6D23BEB
          47B79380DD0FA1EC6BCDCCB07F5BC3CA9ADFA7A9AC5D9DCE4F41D3BED97A19C6
          6187E66F73D857695574FB18F4FB55810EEE72CC46371AB559E5380FA9E1D45F
          C4F57FE5F21CA5767887887E2A4174F7DA5EB3E0B6BA08EE9179A08DCB9C03CA
          E57D78AA5F0D7C35AB58F873C55AB5D5ACD6D6D71A7490C30BA90D29DA4E76F5
          E3A0F5DC6BDE5A28D8E5A3527D48A7E06318E3D2BD6E7D2C91CFECAEEED9E0FF
          0008F413ADF843C55A45D24902DDAC7186742369DAD83CF5C1C1ACAF0E7883C4
          DF09EF6EF4ED4746967B495F240042961C6E47008208ED5F46000740052322BF
          DE50DF519A39F7B87B1B2567AA3C96EAFA6F8C5E07D52DA0D324B1BCB39524B5
          F349DB2B019C67000C8C8FC6B9AF0B7C4BD57C0DA1B787B53D02E649ED8B0B7C
          82A46493B5B8E9927915F402AAA8C2A803D8535A28DCE5A3527D48A3996D61BA
          6EF74F53C5FE15F84F56D43C5577E31D72DDEDFCCF31A149176991E4EAD83D14
          0240FAD610B7D6BE1078EEE6F934E92F3499C322BA0243C4CC08E4746040EBD7
          9F5AFA22919558618023D08A39F517B156567A9F3C6B775AE7C63F12D84365A5
          4F67A6DB657CC941DA8188DCEC7A6700600F4A6FC470BA17C4FD2E65B5965B4B
          082DB08133B9509E3D3B57D10A8A8308A147A018A1A38DFEF22B7D4669A989D1
          BF5D4F9BBC4525DFC4CF1558C9A078727B245C234ED16DC9C83B9C8E0631C77A
          FA4E915153EEA85FA0C52D4CA573484396EFB9FFD9}
      end
      object QRShape60: TQRShape
        Left = 556
        Top = 440
        Width = 158
        Height = 1
        Size.Values = (
          2.645833333333333000
          1471.083333333333000000
          1164.166666666667000000
          418.041666666666700000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel120: TQRLabel
        Left = 558
        Top = 443
        Width = 66
        Height = 11
        Size.Values = (
          29.104166666666670000
          1476.375000000000000000
          1172.104166666667000000
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
        Top = 482
        Width = 75
        Height = 11
        Size.Values = (
          29.104166666666670000
          1481.666666666667000000
          1275.291666666667000000
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
        Top = 407
        Width = 27
        Height = 15
        Size.Values = (
          39.687500000000000000
          375.708333333333300000
          1076.854166666667000000
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
        Top = 331
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666667000000
          875.770833333333400000
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
      object QRLabel124: TQRLabel
        Left = 13
        Top = 381
        Width = 100
        Height = 15
        Size.Values = (
          39.687500000000000000
          34.395833333333340000
          1008.062500000000000000
          264.583333333333400000)
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
        Top = 382
        Width = 137
        Height = 15
        Size.Values = (
          39.687500000000000000
          351.895833333333400000
          1010.708333333333000000
          362.479166666666700000)
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
        Left = 283
        Top = 381
        Width = 54
        Height = 15
        Size.Values = (
          39.687500000000000000
          748.770833333333400000
          1008.062500000000000000
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
        Left = 398
        Top = 382
        Width = 141
        Height = 15
        Size.Values = (
          39.687500000000000000
          1053.041666666667000000
          1010.708333333333000000
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
        Left = 573
        Top = 357
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1516.062500000000000000
          944.562500000000000000
          351.895833333333400000)
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
        Left = 573
        Top = 382
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1516.062500000000000000
          1010.708333333333000000
          351.895833333333400000)
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
        Left = 573
        Top = 407
        Width = 133
        Height = 15
        Size.Values = (
          39.687500000000000000
          1516.062500000000000000
          1076.854166666667000000
          351.895833333333400000)
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
        Left = 628
        Top = 564
        Width = 57
        Height = 11
        Size.Values = (
          29.104166666666670000
          1661.583333333333000000
          1492.250000000000000000
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
      object QRLabel133: TQRLabel
        Left = 685
        Top = 281
        Width = 16
        Height = 16
        Size.Values = (
          42.333333333333330000
          1812.395833333333000000
          743.479166666666700000
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
      object QRLabel134: TQRLabel
        Left = 379
        Top = 535
        Width = 176
        Height = 16
        Size.Values = (
          42.333333333333340000
          1002.770833333333000000
          1415.520833333333000000
          465.666666666666800000)
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
        Left = 20
        Top = 463
        Width = 518
        Height = 13
        Size.Values = (
          34.395833333333340000
          52.916666666666660000
          1225.020833333333000000
          1370.541666666667000000)
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
        Left = 20
        Top = 476
        Width = 518
        Height = 13
        Size.Values = (
          34.395833333333340000
          52.916666666666660000
          1259.416666666667000000
          1370.541666666667000000)
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
        Left = 20
        Top = 488
        Width = 518
        Height = 13
        Size.Values = (
          34.395833333333340000
          52.916666666666660000
          1291.166666666667000000
          1370.541666666667000000)
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
        Left = 20
        Top = 501
        Width = 518
        Height = 13
        Size.Values = (
          34.395833333333340000
          52.916666666666660000
          1325.562500000000000000
          1370.541666666667000000)
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
        Left = 20
        Top = 513
        Width = 518
        Height = 13
        Size.Values = (
          34.395833333333340000
          52.916666666666660000
          1357.312500000000000000
          1370.541666666667000000)
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
        Left = 43
        Top = 426
        Width = 495
        Height = 13
        Size.Values = (
          34.395833333333340000
          113.770833333333300000
          1127.125000000000000000
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
        Left = 20
        Top = 451
        Width = 518
        Height = 13
        Size.Values = (
          34.395833333333340000
          52.916666666666660000
          1193.270833333333000000
          1370.541666666667000000)
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
        Left = 20
        Top = 438
        Width = 518
        Height = 13
        Size.Values = (
          34.395833333333340000
          52.916666666666660000
          1158.875000000000000000
          1370.541666666667000000)
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
        Top = 12
        Width = 133
        Height = 19
        Size.Values = (
          50.270833333333330000
          1513.416666666667000000
          31.750000000000000000
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
        Top = 301
        Width = 133
        Height = 18
        Size.Values = (
          47.625000000000000000
          1513.416666666667000000
          796.395833333333400000
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
        Top = 427
        Width = 36
        Height = 11
        Size.Values = (
          29.104166666666670000
          5.291666666666667000
          1129.770833333333000000
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
        Top = 577
        Width = 44
        Height = 10
        Size.Values = (
          26.458333333333330000
          1558.395833333333000000
          1526.645833333333000000
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
        Top = 349
        Width = 41
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          923.395833333333300000
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
        Top = 657
        Width = 41
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          1738.312500000000000000
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
        Left = 6
        Top = 530
        Width = 32
        Height = 11
        Size.Values = (
          29.104166666666670000
          15.875000000000000000
          1402.291666666667000000
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
    end
    object qrBandaComprovante: TQRBand
      Left = 38
      Top = 19
      Width = 718
      Height = 120
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        317.500000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRShape61: TQRShape
        Left = 3
        Top = 24
        Width = 711
        Height = 11
        Size.Values = (
          29.104166666666670000
          7.937500000000000000
          63.500000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel10: TQRLabel
        Left = 245
        Top = 12
        Width = 463
        Height = 17
        Size.Values = (
          44.979166666666670000
          648.229166666666800000
          31.750000000000000000
          1225.020833333333000000)
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
      object QRLabel146: TQRLabel
        Left = 4
        Top = 31
        Width = 40
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          82.020833333333330000
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
        Left = 3
        Top = 50
        Width = 439
        Height = 2
        Size.Values = (
          5.291666666666667000
          7.937500000000000000
          132.291666666666700000
          1161.520833333333000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel147: TQRLabel
        Left = 4
        Top = 53
        Width = 28
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          140.229166666666700000
          74.083333333333330000)
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
      object QRLabel148: TQRLabel
        Left = 48
        Top = 36
        Width = 253
        Height = 14
        Size.Values = (
          37.041666666666670000
          127.000000000000000000
          95.250000000000000000
          669.395833333333300000)
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
      object QRShape28: TQRShape
        Left = 159
        Top = 9
        Width = 10
        Height = 20
        Size.Values = (
          52.916666666666660000
          420.687500000000000000
          23.812500000000000000
          26.458333333333330000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel149: TQRLabel
        Left = 167
        Top = 9
        Width = 68
        Height = 21
        Size.Values = (
          55.562500000000000000
          441.854166666666700000
          23.812500000000000000
          179.916666666666700000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '756-9'
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
      object QRShape63: TQRShape
        Left = 233
        Top = 9
        Width = 8
        Height = 20
        Size.Values = (
          52.916666666666660000
          616.479166666666800000
          23.812500000000000000
          21.166666666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel150: TQRLabel
        Left = 48
        Top = 57
        Width = 253
        Height = 14
        Size.Values = (
          37.041666666666670000
          127.000000000000000000
          150.812500000000000000
          669.395833333333300000)
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
      object QRShape64: TQRShape
        Left = 3
        Top = 71
        Width = 439
        Height = 2
        Size.Values = (
          5.291666666666667000
          7.937500000000000000
          187.854166666666700000
          1161.520833333333000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel151: TQRLabel
        Left = 4
        Top = 73
        Width = 40
        Height = 9
        Size.Values = (
          23.812500000000000000
          10.583333333333330000
          193.145833333333300000
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
      object QRLabel152: TQRLabel
        Left = 4
        Top = 80
        Width = 103
        Height = 13
        Size.Values = (
          34.395833333333340000
          10.583333333333330000
          211.666666666666700000
          272.520833333333400000)
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
      object QRShape65: TQRShape
        Left = 3
        Top = 91
        Width = 439
        Height = 2
        Size.Values = (
          5.291666666666667000
          7.937500000000000000
          240.770833333333300000
          1161.520833333333000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel153: TQRLabel
        Left = 4
        Top = 93
        Width = 100
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          246.062500000000000000
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
      object QRLabel154: TQRLabel
        Left = 4
        Top = 102
        Width = 99
        Height = 11
        Size.Values = (
          29.104166666666670000
          10.583333333333330000
          269.875000000000000000
          261.937500000000000000)
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
      object QRShape66: TQRShape
        Left = 2
        Top = 114
        Width = 711
        Height = 5
        Size.Values = (
          13.229166666666670000
          5.291666666666667000
          301.625000000000000000
          1881.187500000000000000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel155: TQRLabel
        Left = 685
        Top = 109
        Width = 16
        Height = 17
        Size.Values = (
          44.979166666666670000
          1812.395833333333000000
          288.395833333333300000
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
      object QRShape67: TQRShape
        Left = 302
        Top = 29
        Width = 5
        Height = 63
        Size.Values = (
          166.687500000000000000
          799.041666666666800000
          76.729166666666680000
          13.229166666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape68: TQRShape
        Left = 107
        Top = 73
        Width = 5
        Height = 41
        Size.Values = (
          108.479166666666700000
          283.104166666666700000
          193.145833333333300000
          13.229166666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel156: TQRLabel
        Left = 114
        Top = 73
        Width = 58
        Height = 9
        Size.Values = (
          23.812500000000000000
          301.625000000000000000
          193.145833333333300000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel157: TQRLabel
        Left = 114
        Top = 80
        Width = 140
        Height = 12
        Size.Values = (
          31.750000000000000000
          301.625000000000000000
          211.666666666666700000
          370.416666666666700000)
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
      object QRLabel158: TQRLabel
        Left = 114
        Top = 93
        Width = 16
        Height = 9
        Size.Values = (
          23.812500000000000000
          301.625000000000000000
          246.062500000000000000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape69: TQRShape
        Left = 253
        Top = 73
        Width = 5
        Height = 41
        Size.Values = (
          108.479166666666700000
          669.395833333333400000
          193.145833333333300000
          13.229166666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel159: TQRLabel
        Left = 259
        Top = 73
        Width = 39
        Height = 9
        Size.Values = (
          23.812500000000000000
          685.270833333333300000
          193.145833333333300000
          103.187500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Esp. Moeda'
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
      object QRLabel160: TQRLabel
        Left = 274
        Top = 80
        Width = 13
        Height = 12
        Size.Values = (
          31.750000000000000000
          724.958333333333300000
          211.666666666666700000
          34.395833333333330000)
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
      object QRLabel161: TQRLabel
        Left = 259
        Top = 93
        Width = 36
        Height = 9
        Size.Values = (
          23.812500000000000000
          685.270833333333300000
          246.062500000000000000
          95.250000000000000000)
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
      object QRShape70: TQRShape
        Left = 439
        Top = 29
        Width = 5
        Height = 84
        Size.Values = (
          222.250000000000000000
          1161.520833333333000000
          76.729166666666680000
          13.229166666666670000)
        XLColumn = 0
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel162: TQRLabel
        Left = 308
        Top = 73
        Width = 77
        Height = 9
        Size.Values = (
          23.812500000000000000
          814.916666666666700000
          193.145833333333300000
          203.729166666666700000)
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
      object QRLabel163: TQRLabel
        Left = 308
        Top = 80
        Width = 129
        Height = 12
        Size.Values = (
          31.750000000000000000
          814.916666666666800000
          211.666666666666700000
          341.312500000000000000)
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
      object QRLabel164: TQRLabel
        Left = 308
        Top = 59
        Width = 129
        Height = 12
        Size.Values = (
          31.750000000000000000
          814.916666666666800000
          156.104166666666700000
          341.312500000000000000)
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
      object QRLabel165: TQRLabel
        Left = 308
        Top = 52
        Width = 76
        Height = 9
        Size.Values = (
          23.812500000000000000
          814.916666666666700000
          137.583333333333300000
          201.083333333333300000)
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
      object QRLabel166: TQRLabel
        Left = 308
        Top = 37
        Width = 129
        Height = 13
        Size.Values = (
          34.395833333333340000
          814.916666666666800000
          97.895833333333340000
          341.312500000000000000)
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
      object QRLabel167: TQRLabel
        Left = 308
        Top = 31
        Width = 74
        Height = 9
        Size.Values = (
          23.812500000000000000
          814.916666666666700000
          82.020833333333330000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel168: TQRLabel
        Left = 446
        Top = 31
        Width = 192
        Height = 9
        Size.Values = (
          23.812500000000000000
          1180.041666666667000000
          82.020833333333330000
          508.000000000000000000)
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
      object QRShape71: TQRShape
        Left = 445
        Top = 43
        Width = 13
        Height = 8
        Size.Values = (
          21.166666666666670000
          1177.395833333333000000
          113.770833333333300000
          34.395833333333340000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel169: TQRLabel
        Left = 462
        Top = 43
        Width = 32
        Height = 9
        Size.Values = (
          23.812500000000000000
          1222.375000000000000000
          113.770833333333300000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel170: TQRLabel
        Left = 462
        Top = 53
        Width = 34
        Height = 9
        Size.Values = (
          23.812500000000000000
          1222.375000000000000000
          140.229166666666700000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape72: TQRShape
        Left = 445
        Top = 53
        Width = 13
        Height = 8
        Size.Values = (
          21.166666666666670000
          1177.395833333333000000
          140.229166666666700000
          34.395833333333340000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel171: TQRLabel
        Left = 462
        Top = 63
        Width = 28
        Height = 9
        Size.Values = (
          23.812500000000000000
          1222.375000000000000000
          166.687500000000000000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRShape73: TQRShape
        Left = 445
        Top = 63
        Width = 13
        Height = 8
        Size.Values = (
          21.166666666666670000
          1177.395833333333000000
          166.687500000000000000
          34.395833333333340000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape74: TQRShape
        Left = 518
        Top = 43
        Width = 13
        Height = 8
        Size.Values = (
          21.166666666666670000
          1370.541666666667000000
          113.770833333333300000
          34.395833333333340000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel172: TQRLabel
        Left = 535
        Top = 43
        Width = 29
        Height = 9
        Size.Values = (
          23.812500000000000000
          1415.520833333333000000
          113.770833333333300000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel173: TQRLabel
        Left = 535
        Top = 53
        Width = 48
        Height = 9
        Size.Values = (
          23.812500000000000000
          1415.520833333333000000
          140.229166666666700000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel174: TQRLabel
        Left = 535
        Top = 63
        Width = 48
        Height = 9
        Size.Values = (
          23.812500000000000000
          1415.520833333333000000
          166.687500000000000000
          127.000000000000000000)
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
      object QRShape75: TQRShape
        Left = 518
        Top = 63
        Width = 13
        Height = 8
        Size.Values = (
          21.166666666666670000
          1370.541666666667000000
          166.687500000000000000
          34.395833333333340000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape76: TQRShape
        Left = 518
        Top = 53
        Width = 13
        Height = 8
        Size.Values = (
          21.166666666666670000
          1370.541666666667000000
          140.229166666666700000
          34.395833333333340000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape77: TQRShape
        Left = 606
        Top = 43
        Width = 13
        Height = 8
        Size.Values = (
          21.166666666666670000
          1603.375000000000000000
          113.770833333333300000
          34.395833333333340000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape78: TQRShape
        Left = 606
        Top = 53
        Width = 13
        Height = 8
        Size.Values = (
          21.166666666666670000
          1603.375000000000000000
          140.229166666666700000
          34.395833333333340000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel175: TQRLabel
        Left = 622
        Top = 43
        Width = 72
        Height = 9
        Size.Values = (
          23.812500000000000000
          1645.708333333333000000
          113.770833333333300000
          190.500000000000000000)
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
      object QRLabel176: TQRLabel
        Left = 622
        Top = 53
        Width = 81
        Height = 9
        Size.Values = (
          23.812500000000000000
          1645.708333333333000000
          140.229166666666700000
          214.312500000000000000)
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
      object QRLabel177: TQRLabel
        Left = 622
        Top = 63
        Width = 82
        Height = 9
        Size.Values = (
          23.812500000000000000
          1645.708333333333000000
          166.687500000000000000
          216.958333333333300000)
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
      object QRShape79: TQRShape
        Left = 606
        Top = 63
        Width = 13
        Height = 8
        Size.Values = (
          21.166666666666670000
          1603.375000000000000000
          166.687500000000000000
          34.395833333333340000)
        XLColumn = 0
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape80: TQRShape
        Left = 448
        Top = 95
        Width = 262
        Height = 2
        Size.Values = (
          5.291666666666667000
          1185.333333333333000000
          251.354166666666700000
          693.208333333333400000)
        XLColumn = 0
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel178: TQRLabel
        Left = 472
        Top = 98
        Width = 16
        Height = 9
        Size.Values = (
          23.812500000000000000
          1248.833333333333000000
          259.291666666666700000
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLabel179: TQRLabel
        Left = 630
        Top = 98
        Width = 36
        Height = 9
        Size.Values = (
          23.812500000000000000
          1666.875000000000000000
          259.291666666666700000
          95.250000000000000000)
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
      object QRImage4: TQRImage
        Left = 6
        Top = 2
        Width = 149
        Height = 26
        Size.Values = (
          68.791666666666680000
          15.875000000000000000
          5.291666666666667000
          394.229166666666700000)
        XLColumn = 0
        Picture.Data = {
          0A544A504547496D61676526080000FFD8FFE000104A46494600010101006000
          600000FFE1002245786966000049492A00080000000100005104000100000000
          00000000000000FFDB004300080606070605080707070909080A0C140D0C0B0B
          0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434
          341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C2132
          3232323232323232323232323232323232323232323232323232323232323232
          3232323232323232323232323232323232FFC0001108001D0079030122000211
          01031101FFC4001F000001050101010101010000000000000000010203040506
          0708090A0BFFC400B5100002010303020403050504040000017D010203000411
          05122131410613516107227114328191A1082342B1C11552D1F0243362728209
          0A161718191A25262728292A3435363738393A434445464748494A5354555657
          58595A636465666768696A737475767778797A838485868788898A9293949596
          9798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2
          D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F
          0100030101010101010101010000000000000102030405060708090A0BFFC400
          B511000201020404030407050404000102770001020311040521310612415107
          61711322328108144291A1B1C109233352F0156272D10A162434E125F1171819
          1A262728292A35363738393A434445464748494A535455565758595A63646566
          6768696A737475767778797A82838485868788898A92939495969798999AA2A3
          A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8
          D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C0301000211031100
          3F00F41F146A1ACE9DAC48A97B224120DD0EC000C7A7D41AE5AEBC47E23F3116
          DF52B967660AA8B83B89EDD2BD3FC4BA47F6B694EA83FD222F9E23EA7B8FC7FC
          2B81F0F5CE9D67ACACF7FBCBC4331A04CE1BA64FD2BC1C4FB4A1894DCED17ADD
          BD0E59C24E5CB7D19873F8ABC4B6D712413EA7731CB1B15746C6548EDD2B5BC2
          9ADF89358F115B5BAEA533C487CC9B760AEC1D73F5E9F8D2F8E34B5D77518B51
          D1B02575DB70B27C80E3A30F7EDF9575FE01F0D49E1FD14BDD85FB7DC9DD295E
          76AFF0AE7F5FA9AF7E963F0D5D354649BF23C8A597E2E389B4E4F913DEEF52D6
          BBE3BF0D786EE45B6A9AAC50CF8C989433B28F70A091F8D5AD33C53A2EB1A2CD
          ABD85FC7358C218CB200414DA327208C838E7A57CEB70B0786BE22EA0FE35D1E
          6D4219659091B88DDB9B2245E9B8638C67BFB57ADE89278466F87DE229FC268B
          1452DBCAD710927746FE5100104E4703E9D6ADC1247B51AAE4D9DAE8BE20D27C
          4568D75A45F45770AB6D668CFDD3E8475159FAE78EBC33E1C9FC8D4F568629FB
          C4B9771F555048AF1CF863ACCBE1FF0087FE31D560C79D0245E5923A390CAA7F
          322ACFC26F02E9BE2B82FB5CD783DEB79E5046EE70ED8CB3B11C93CD0E095EE0
          AACA4924B567B3683E25D23C4D64F79A45EA5CC28DB5C8054A1F420E08AC6D43
          E27F83B4DBC6B5B8D6A232A1C37948D2007D09504572DF11ACF4FF00007812F2
          3F0EDA8B17D567482568DDB2170738C938E011F8D57F86BF0D7C3DA978160BED
          52C85CDCDF2B36E2C4796B92005C74E06734B9636BB1B9CEFCAB73D4B4AD634E
          D72C56F34CBC86EADDB8DF136707D0FA1F6354B5EF17683E1954FED7D4A1B667
          E563396761EA1464E2BC5BE1D5C4FE11F8B57DA047333D9C8D342EA7F8BCB52E
          8DF5C023F1AAFE04D361F88FF11F52BFD78B5C4688D70622C406F982A2FF00BA
          076F614F912F427DB36924B53DAB42F1CF86FC4B706DF4AD5229A7033E53028E
          47B06009FC2935CF1E786BC397BF63D5353482E7686F2F6331C1E87806BC73E2
          CF866CFC15AE691AB680A6C8CC598246C711C88410CBE99CF4F6F7ACFF00881A
          95B5C7C40D1F55BF80CB6D2D9DACF3C207DE5392CBFCE9A827A8A55A51BA7BA3
          DC746F1FF85F5FBB5B4D3B58824B96FBB13028CDF40C067F0AE96BE6395B44F1
          67C47D2D3C356B1E876E24425A7611EE656CE5573C3760075AFA72A651B1AD39
          B95EE15C1788B415B3D61EFA15FDD5D1CB7FB2FDFF003EBF9D77B55EF6D23BEB
          47B79380DD0FA1EC6BCDCCB07F5BC3CA9ADFA7A9AC5D9DCE4F41D3BED97A19C6
          6187E66F73D857695574FB18F4FB55810EEE72CC46371AB559E5380FA9E1D45F
          C4F57FE5F21CA5767887887E2A4174F7DA5EB3E0B6BA08EE9179A08DCB9C03CA
          E57D78AA5F0D7C35AB58F873C55AB5D5ACD6D6D71A7490C30BA90D29DA4E76F5
          E3A0F5DC6BDE5A28D8E5A3527D48A7E06318E3D2BD6E7D2C91CFECAEEED9E0FF
          0008F413ADF843C55A45D24902DDAC7186742369DAD83CF5C1C1ACAF0E7883C4
          DF09EF6EF4ED4746967B495F240042961C6E47008208ED5F46000740052322BF
          DE50DF519A39F7B87B1B2567AA3C96EAFA6F8C5E07D52DA0D324B1BCB39524B5
          F349DB2B019C67000C8C8FC6B9AF0B7C4BD57C0DA1B787B53D02E649ED8B0B7C
          82A46493B5B8E9927915F402AAA8C2A803D8535A28DCE5A3527D48A3996D61BA
          6EF74F53C5FE15F84F56D43C5577E31D72DDEDFCCF31A149176991E4EAD83D14
          0240FAD610B7D6BE1078EEE6F934E92F3499C322BA0243C4CC08E4746040EBD7
          9F5AFA22919558618023D08A39F517B156567A9F3C6B775AE7C63F12D84365A5
          4F67A6DB657CC941DA8188DCEC7A6700600F4A6FC470BA17C4FD2E65B5965B4B
          082DB08133B9509E3D3B57D10A8A8308A147A018A1A38DFEF22B7D4669A989D1
          BF5D4F9BBC4525DFC4CF1558C9A078727B245C234ED16DC9C83B9C8E0631C77A
          FA4E915153EEA85FA0C52D4CA573484396EFB9FFD9}
      end
    end
  end
end
