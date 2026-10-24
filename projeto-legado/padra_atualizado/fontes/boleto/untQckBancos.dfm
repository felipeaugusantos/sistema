object frmQckBancos: TfrmQckBancos
  Left = 0
  Top = 0
  ClientHeight = 289
  ClientWidth = 503
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object frxBanco: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbNavigator]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41012.458176388900000000
    ReportOptions.LastChange = 44987.672521076390000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbFichaCaixaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        ' if ((rlbAgrupamento.Visible) and not(rlbReciboPagadorComImagem.' +
        'visible)) OR'
      
        '    (not(rlbAgrupamento.Visible) and not(rlbFichaCaixa.visible) ' +
        'and not(rlbReciboPagadorComImagem.visible)) then'
      '  begin'
      '    if (rlbTelSac.Visible) AND (rlbAgrupamento.Visible) then'
      '    begin'
      '      if (Engine.CurY >= 100) then'
      '      begin                                      '
      '        Engine.NewPage;'
      '      end;'
      '               '
      '      if (Engine.CurY < 99) then'
      '        Engine.CurY := 415;        '
      '    end'
      '    else'
      '    begin                                            '
      '      if (Engine.CurY >= 419) then'
      '        Engine.NewPage;'
      '            '
      '      if (Engine.CurY < 418) then'
      '        Engine.CurY := 418;  '
      '    end;                                '
      '  end;                          '
      'end;'
      '            '
      '      '
      
        'procedure rlbReciboPagadorComImagemOnBeforePrint(Sender: TfrxCom' +
        'ponent);'
      'begin'
      ' if rlbReciboPagadorComImagem.visible then'
      ' begin'
      '   if rlbAgrupamento.Visible then'
      '   begin'
      '     if(Engine.CurY >= 324) then'
      '       Engine.NewPage;  '
      '       '
      '     if(Engine.CurY < 323) then'
      '       Engine.CurY := 323;'
      '   end'
      '   else'
      '   begin               '
      '     if(Engine.CurY >= 306) then'
      '       Engine.NewPage;  '
      '       '
      '     if(Engine.CurY < 305) then'
      '       Engine.CurY := 305;         '
      '   end;               '
      ' end;                                '
      'end;           '
      ''
      'procedure rlbLayImpOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '//  Engine.NewPage;  '
      'end;'
      ''
      'procedure imgLog5OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  imgLog5.Picture := imgLog4.Picture;                           ' +
        '                     '
      'end;'
      ''
      'begin'
      '      '
      'end.                  ')
    Left = 16
    Top = 8
    Datasets = <
      item
        DataSet = frxAgrupamento
        DataSetName = 'frxAgrupamento'
      end
      item
        DataSet = frxQRCodePix
        DataSetName = 'frxQRCodePix'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object frxPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 5.000000000000000000
      LargeDesignHeight = True
      HGuides.Strings = (
        '1625,1979')
      VGuides.Strings = (
        '54')
      object rlbLayImp: TfrxReportTitle
        FillType = ftBrush
        Height = 12.094488190000000000
        Top = 18.897650000000000000
        Visible = False
        Width = 718.110700000000000000
        OnAfterPrint = 'rlbLayImpOnAfterPrint'
        AllowSplit = True
        Child = frxBanco.rlbCompEntr
        PrintChildIfInvisible = True
        Stretched = True
        object sbrLayImp: TfrxSubreport
          Width = 75.590551180000000000
          Height = 11.338582680000000000
          Page = frxBanco.Page3
          PrintOnParent = True
        end
      end
      object rlbCompEntr: TfrxChild
        FillType = ftBrush
        Height = 111.496119130000000000
        Top = 52.913420000000000000
        Width = 718.110700000000000000
        AllowSplit = True
        Child = frxBanco.rlbCompEntrCut
        PrintChildIfInvisible = True
        object Memo32: TfrxMemoView
          Left = 321.260050000000000000
          Top = 71.811070000000000000
          Width = 143.622140000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Top = 71.811070000000000000
          Width = 124.724490000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 111.496119130000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          ParentFont = False
        end
        object Line6: TfrxLineView
          Top = 68.811070000000000000
          Width = 464.882190000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo1: TfrxMemoView
          Left = 128.504020000000000000
          Top = 1.779530000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODBCO]')
          ParentFont = False
        end
        object imgLog1: TfrxPictureView
          Left = 3.779530000000000000
          Top = 1.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Picture.Data = {
            07544269746D6170F6130000424DF61300000000000036040000280000009000
            00001C0000000100080000000000C00F0000C40E0000C40E0000000100000000
            00009C9EFF001010FF00CECFFF0010101000EFEFEF00CECFCE0021202100BDBE
            BD00313031007B7DFF004241FF009C9E9C00BDBEFF006361630052515200DEDF
            DE008C8E8C0073717300ADAEAD008C8EFF006361FF00DEDFFF00ADAEFF007B7D
            7B0042414200000000000000FF00FFFFFF000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00001B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B171717171717171717171B1B1B1B0F171717171717171717171B11041B
            1B1B120D1803180E0B1B1B1B1B1B17171717171717171717171717120F1B1B1B
            1B1B1B1B1B1B1B1B1B1B040B0E081919031810041B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B160909090909090909090909090909090909090909
            09090909021B1B1B1B1B1B1B1B1B1B1B1B1B1B07070E191919190E07071B1B1B
            1B0407070E191919190D07071B180D0510061919191919191906051B1B1B0707
            0D19191919061811180819191918071B1B1B1B1B1B1B1B1B0411191919191919
            19191903171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A001A1A1A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A011301021B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B061919061B1B1B1B1B1B1B1B1B1B04031919081B1B1B1B181919
            19080B041B1B0708191903051B1B1B1B1B061919181B1B1B1B1B051819191911
            1B1B1B1B1B1B1B0703191919030D120504070B0E1908041B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B001A1A1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
            1A01020C1A01021B1B1B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1819190D1B1B1B1B1B1B0408191906041B1B1B
            1B181919181B1B1B1B1B1B1B0E191919101B1B1B1B1B0B1919191911041B1B1B
            1B1B1B1B051808041B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1B1B001A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01021B0C1A1A01021B1B1B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B181918
            1B1B1B1B1B1B1B1B0F1919190B1B1B1B1B181919181B1B1B1B1B1B1B04031919
            031B1B1B1B07191919190B1B1B1B1B1B1B1B1B1B1B1B0D08041B1B1B1B1B1B1B
            1B1B1B1B1B1B1B001A1A1A1A1B1B1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01
            021B1B0C1A1A1A01021B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B18030F1B1B1B1B1B1B1B1B1B0619190E1B1B1B
            1B181919181B1B1B1B1B1B1B1B0D191919071B1B0403191919101B1B1B1B1B1B
            1B1B1B1B1B1B1B0D0D1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1B1B1B1B
            001A1A1A1A1A1A1A1A1A1A1A1A1A01021B1B1B0C1A1A1A1A01021B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B180D1B
            1B1B1B1B1B1B1B1B1B081919181B1B1B1B181919181B1B1B1B1B1B1B1B171919
            190B1B1B17191919181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B0F1B1B1B1B1B1B1B
            1B1B1B1B1B001A1A1A1A1A1A1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A01021B
            1B1B1B0C1A1A1A1A1A01021B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B18071B1B1B1B1B1B1B1B1B04191919181B1B1B
            1B181919181B1B1B1B1B1B1B1B171919190B1B1B06191919121B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1B1B1B1B
            1B1B001A1A1A1A1A1A1A1A1A01021B1B1B1B1B0C1A1A1A1A1A1A01021B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B111B1B
            1B1B1B1B1B1B1B1B0D1919190D1B1B1B1B181919181B1B1B1B1B1B1B1B0E1919
            19051B05191919031B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B001A1A1A1A1A1A1A1A1B1B1B1B1B1B1B001A1A1A1A1A1A1A01021B1B1B
            1B1B1B0C1A1A1A1A1A1A1A01021B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B1B1B040E19191919071B1B1B
            1B181919181B1B1B1B1B1B1B05191919061B1B10191919181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B001A1A1A1A1A01021B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A01021B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B1B
            1B1B1B1B1B120319191919111B1B1B1B1B181919181B1B1B1B1B1B0408191919
            071B1B11191919171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B001A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B001A1A1A01021B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A01021B1B1B1B1B1B1B18191906171717171717
            1717171717061919181B1B1B1B1B1B1B1B1B1B0F1819191919190D1B1B1B1B1B
            1B181919181B1B1B1B1B0B06191903121B1B1B18191919171B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B1B1B001A01021B1B1B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A1A0102
            1B1B1B1B1B1B181919191919191919191919191919191919181B1B1B1B1B1B1B
            1B1B0B0319191919030B1B1B1B1B1B1B1B18191919181818081919190311041B
            1B1B1B18191919171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B15
            1A1A1A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B1B1B14001B1B1B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A1A1A011B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B1B1B040E191919191908051B1B1B1B1B1B1B
            1B18191906171717171819191908051B1B1B1B0D191919171B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B1B1B001A01021B1B1B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A1A1A00
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B05
            061919191919171B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B050619190305
            1B1B1B17191919111B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B001A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B001A1A1A01021B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A1A001B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B05031919191908051B1B1B1B1B1B1B1B1B1B
            1B181919181B1B1B1B1B1B0F031919181B1B1B0B191919181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B001A1A1A1A1A01021B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A001B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B0619
            191919171B1B1B1B1B1B040F1B1B1B1B1B181919181B1B1B1B1B1B1B17191919
            0F1B1B0F19191919041B1B1B1B1B1B1B1B1B1B1B1B1B1B181B1B1B1B1B1B1B1B
            1B1B1B001A1A1A1A1A1A1A1A1B1B1B1B1B1B1B001A1A1A1A1A1A1A01021B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A001B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1219191903051B1B1B1B1B1B1B07171B1B1B1B
            1B181919181B1B1B1B1B1B1B0F191919071B1B1B081919190B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B191B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1B1B1B1B
            1B1B001A1A1A1A1A1A1A1A1A01021B1B1B1B1B0C1A1A1A1A1A1A1A001B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B171919
            19121B1B1B1B1B1B1B1B17171B1B1B1B1B181919181B1B1B1B1B1B1B1B191919
            071B1B1B0B191919081B1B1B1B1B1B1B1B1B1B1B1B1B0B191B1B1B1B1B1B1B1B
            1B1B1B1B1B001A1A1A1A1A1A1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A01021B
            1B1B1B0C1A1A1A1A1A1A001B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B171919031B1B1B1B1B1B1B1B1B06171B1B1B1B
            1B181919181B1B1B1B1B1B1B05191919071B1B1B1B08191919101B1B1B1B1B1B
            1B1B1B1B1B0406191B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1B1B1B1B
            001A1A1A1A1A1A1A1A1A1A1A1A1A01021B1B1B0C1A1A1A1A1A001B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B0B1919
            191B1B1B1B1B1B1B1B0719171B1B1B1B1B181919181B1B1B1B1B1B1B17191906
            1B1B1B1B1B0503191903051B1B1B1B1B1B1B1B1B040819081B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B001A1A1A1A1B1B1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01
            021B1B0C1A1A1A1A001B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B04031919071B1B1B1B1B1B040619171B1B1B1B
            1B181919181B1B1B1B1B1B05191919121B1B1B1B1B1B0503191903101B1B1B1B
            1B1B1B05081919181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1B1B001A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01021B0C1A1A1A001B1B1B1B1B1B1B1B
            1B1B1B1B1B1B081919081B1B1B1B1B1B1B1B1B1B1B061919181B1B1B1B1B1719
            19030B1B1B1B1B05081919171B1B1B1B1B061919181B1B1B1B04170319190B1B
            1B1B1B1B1B1B1B0F081919190610071B0F120D19190619181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B001A1A1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
            1A01020C1A1A001B1B1B1B1B1B1B1B1B1B1B1B1B1B1019191919101B1B1B1B1B
            1B1B1B1B0D19191919101B1B1B1B1B1719191903180D0819061706171B1B1B04
            1119191919081818181919190E051B1B1B1B1B1B1B1B1B1B1B0B061919191919
            191919060B1B05181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A001A1A1A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01131A001B1B1B1B1B1B1B1B1B1B
            1B1B1B181818181818181818181B1B1B1B05181818181818181818181B1B1B1B
            070E031919190E0B1B1B12171B1B17171717171717171717171707041B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B05101718181117051B1B1B1B051B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B000A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A
            0A0A0A0A001B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Line1: TfrxLineView
          Top = 22.456710000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line2: TfrxLineView
          Left = 113.385900000000000000
          Top = 22.677180000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line3: TfrxLineView
          Left = 219.212740000000000000
          Top = 22.677180000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo2: TfrxMemoView
          Left = 230.551330000000000000
          Top = 1.779530000000000000
          Width = 480.000310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Comprovante de Entrega')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Top = 47.133890000000000000
          Width = 464.882190000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line5: TfrxLineView
          Left = 464.882190000000000000
          Top = 22.456710000000000000
          Height = 86.929190000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          Top = 90.488250000000000000
          Width = 464.882190000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line8: TfrxLineView
          Left = 321.260050000000000000
          Top = 90.488250000000000000
          Height = -68.031540000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line9: TfrxLineView
          Left = 257.008040000000000000
          Top = 109.385900000000000000
          Height = -41.574830000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line10: TfrxLineView
          Left = 124.724490000000000000
          Top = 109.385900000000000000
          Height = -41.574830000000000000
          Color = clBlack
          Diagonal = True
        end
        object Shape1: TfrxShapeView
          Left = 472.441250000000000000
          Top = 38.354360000000000000
          Width = 11.338590000000000000
          Height = 7.559060000000000000
        end
        object Shape2: TfrxShapeView
          Left = 472.441250000000000000
          Top = 49.692950000000000000
          Width = 11.338590000000000000
          Height = 7.559060000000000000
        end
        object Shape3: TfrxShapeView
          Left = 472.441250000000000000
          Top = 61.031540000000000000
          Width = 11.338590000000000000
          Height = 7.559060000000000000
        end
        object Memo4: TfrxMemoView
          Left = 472.441250000000000000
          Top = 23.795300000000000000
          Width = 238.110390000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Motivos de n'#227'o entrega. (Para uso da empresa entregadora)')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 472.441250000000000000
          Top = 94.047310000000000000
          Width = 238.110390000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            
              '             Data                                               ' +
              '     Entregador')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 485.559370000000000000
          Top = 36.354360000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Mudou-se')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 485.779840000000000000
          Top = 46.913420000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Recusado')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 485.779840000000000000
          Top = 59.252010000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ausente')
          ParentFont = False
        end
        object Shape4: TfrxShapeView
          Left = 534.693260000000000000
          Top = 38.354330710000000000
          Width = 11.338590000000000000
          Height = 7.559060000000000000
        end
        object Shape5: TfrxShapeView
          Left = 534.693260000000000000
          Top = 49.692913390000000000
          Width = 11.338590000000000000
          Height = 7.559060000000000000
        end
        object Shape6: TfrxShapeView
          Left = 534.693260000000000000
          Top = 61.031496060000000000
          Width = 11.338590000000000000
          Height = 7.559060000000000000
        end
        object Memo9: TfrxMemoView
          Left = 547.811380000000000000
          Top = 36.354360000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Falecido')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 548.031850000000000000
          Top = 46.913420000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Desconhecido')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 548.031850000000000000
          Top = 59.252010000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#227'o procurado')
          ParentFont = False
        end
        object Shape7: TfrxShapeView
          Left = 611.063390000000000000
          Top = 38.354330710000000000
          Width = 11.338590000000000000
          Height = 7.559060000000000000
        end
        object Shape8: TfrxShapeView
          Left = 611.063390000000000000
          Top = 49.692913390000000000
          Width = 11.338590000000000000
          Height = 7.559060000000000000
        end
        object Shape9: TfrxShapeView
          Left = 611.063390000000000000
          Top = 61.031496060000000000
          Width = 11.338590000000000000
          Height = 7.559060000000000000
        end
        object Memo12: TfrxMemoView
          Left = 624.181510000000000000
          Top = 36.354360000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o insuficiente')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 624.401980000000000000
          Top = 46.913420000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#227'o existe n'#186' indicado')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 624.377952760000000000
          Top = 59.252010000000000000
          Width = 91.842519690000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Outros (Anotar no verso)')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 3.779530000000000000
          Top = 23.456710000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BENEFI]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 53.897650000000000000
          Top = 23.795300000000000000
          Width = 260.787570000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCED]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 3.779530000000000000
          Top = 47.133890000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PAGADO]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Top = 56.472480000000000000
          Width = 309.921460000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NOMSAC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 325.039580000000000000
          Top = 23.795300000000000000
          Width = 136.063080000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia/[CEDENT]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 325.039580000000000000
          Top = 34.795300000000000000
          Width = 136.063080000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[AGECED]')
          ParentFont = False
          WordWrap = False
        end
        object rllCarNN1: TfrxMemoView
          Left = 325.039580000000000000
          Top = 47.133890000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira/Nosso N'#250'mero')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 325.039580000000000000
          Top = 56.472480000000000000
          Width = 136.063080000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[CARNOSNUM]')
          ParentFont = False
        end
        object lblVencimentoAceite: TfrxMemoView
          Left = 3.779530000000000000
          Top = 68.811070000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 3.779530000000000000
          Top = 78.149660000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTAVEN]')
          ParentFont = False
          WordWrap = False
        end
        object lblNumDocumentoAceite: TfrxMemoView
          Left = 128.504020000000000000
          Top = 68.811070000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#176' do Documento')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 128.504020000000000000
          Top = 78.149660000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NUMDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 260.787570000000000000
          Top = 68.811070000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ESPMOE]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 260.787570000000000000
          Top = 78.149660000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'R$')
          ParentFont = False
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 325.039580000000000000
          Top = 68.811070000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor do Documento')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 325.039580000000000000
          Top = 78.149660000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[VALDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 3.779530000000000000
          Top = 90.488250000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Recebi o bloqueto / T'#237'tulo com as caracter'#237'sticas acima')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 128.504020000000000000
          Top = 94.488250000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 260.787570000000000000
          Top = 94.488250000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Assinatura')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Left = 53.897650000000000000
          Top = 34.795300000000000000
          Width = 260.787570000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCED]')
          ParentFont = False
        end
      end
      object rlbFichaCaixa: TfrxChild
        FillType = ftBrush
        Height = 287.244280000000000000
        Top = 253.228510000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbFichaCaixaOnBeforePrint'
        Child = frxBanco.rlbFichaCaixaCut
        PrintChildIfInvisible = True
        object Memo52: TfrxMemoView
          Left = 578.268090000000000000
          Top = 94.488250000000500000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 578.268090000000000000
          Top = 26.456710000000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 287.244280000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 128.504020000000000000
          Top = 3.779529999999820000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODBCO]')
          ParentFont = False
        end
        object imgLog2: TfrxPictureView
          Left = 3.779530000000000000
          Top = 3.779529999999820000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Picture.Data = {
            07544269746D6170F6130000424DF61300000000000036040000280000009000
            00001C0000000100080000000000C00F0000C40E0000C40E0000000100000000
            00009C9EFF001010FF00CECFFF0010101000EFEFEF00CECFCE0021202100BDBE
            BD00313031007B7DFF004241FF009C9E9C00BDBEFF006361630052515200DEDF
            DE008C8E8C0073717300ADAEAD008C8EFF006361FF00DEDFFF00ADAEFF007B7D
            7B0042414200000000000000FF00FFFFFF000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00001B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B171717171717171717171B1B1B1B0F171717171717171717171B11041B
            1B1B120D1803180E0B1B1B1B1B1B17171717171717171717171717120F1B1B1B
            1B1B1B1B1B1B1B1B1B1B040B0E081919031810041B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B160909090909090909090909090909090909090909
            09090909021B1B1B1B1B1B1B1B1B1B1B1B1B1B07070E191919190E07071B1B1B
            1B0407070E191919190D07071B180D0510061919191919191906051B1B1B0707
            0D19191919061811180819191918071B1B1B1B1B1B1B1B1B0411191919191919
            19191903171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A001A1A1A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A011301021B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B061919061B1B1B1B1B1B1B1B1B1B04031919081B1B1B1B181919
            19080B041B1B0708191903051B1B1B1B1B061919181B1B1B1B1B051819191911
            1B1B1B1B1B1B1B0703191919030D120504070B0E1908041B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B001A1A1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
            1A01020C1A01021B1B1B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1819190D1B1B1B1B1B1B0408191906041B1B1B
            1B181919181B1B1B1B1B1B1B0E191919101B1B1B1B1B0B1919191911041B1B1B
            1B1B1B1B051808041B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1B1B001A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01021B0C1A1A01021B1B1B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B181918
            1B1B1B1B1B1B1B1B0F1919190B1B1B1B1B181919181B1B1B1B1B1B1B04031919
            031B1B1B1B07191919190B1B1B1B1B1B1B1B1B1B1B1B0D08041B1B1B1B1B1B1B
            1B1B1B1B1B1B1B001A1A1A1A1B1B1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01
            021B1B0C1A1A1A01021B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B18030F1B1B1B1B1B1B1B1B1B0619190E1B1B1B
            1B181919181B1B1B1B1B1B1B1B0D191919071B1B0403191919101B1B1B1B1B1B
            1B1B1B1B1B1B1B0D0D1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1B1B1B1B
            001A1A1A1A1A1A1A1A1A1A1A1A1A01021B1B1B0C1A1A1A1A01021B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B180D1B
            1B1B1B1B1B1B1B1B1B081919181B1B1B1B181919181B1B1B1B1B1B1B1B171919
            190B1B1B17191919181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B0F1B1B1B1B1B1B1B
            1B1B1B1B1B001A1A1A1A1A1A1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A01021B
            1B1B1B0C1A1A1A1A1A01021B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B18071B1B1B1B1B1B1B1B1B04191919181B1B1B
            1B181919181B1B1B1B1B1B1B1B171919190B1B1B06191919121B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1B1B1B1B
            1B1B001A1A1A1A1A1A1A1A1A01021B1B1B1B1B0C1A1A1A1A1A1A01021B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B111B1B
            1B1B1B1B1B1B1B1B0D1919190D1B1B1B1B181919181B1B1B1B1B1B1B1B0E1919
            19051B05191919031B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B001A1A1A1A1A1A1A1A1B1B1B1B1B1B1B001A1A1A1A1A1A1A01021B1B1B
            1B1B1B0C1A1A1A1A1A1A1A01021B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B1B1B040E19191919071B1B1B
            1B181919181B1B1B1B1B1B1B05191919061B1B10191919181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B001A1A1A1A1A01021B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A01021B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B1B
            1B1B1B1B1B120319191919111B1B1B1B1B181919181B1B1B1B1B1B0408191919
            071B1B11191919171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B001A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B001A1A1A01021B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A01021B1B1B1B1B1B1B18191906171717171717
            1717171717061919181B1B1B1B1B1B1B1B1B1B0F1819191919190D1B1B1B1B1B
            1B181919181B1B1B1B1B0B06191903121B1B1B18191919171B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B1B1B001A01021B1B1B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A1A0102
            1B1B1B1B1B1B181919191919191919191919191919191919181B1B1B1B1B1B1B
            1B1B0B0319191919030B1B1B1B1B1B1B1B18191919181818081919190311041B
            1B1B1B18191919171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B15
            1A1A1A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B1B1B14001B1B1B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A1A1A011B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B1B1B040E191919191908051B1B1B1B1B1B1B
            1B18191906171717171819191908051B1B1B1B0D191919171B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B1B1B001A01021B1B1B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A1A1A00
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B05
            061919191919171B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B050619190305
            1B1B1B17191919111B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B001A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B001A1A1A01021B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A1A001B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B05031919191908051B1B1B1B1B1B1B1B1B1B
            1B181919181B1B1B1B1B1B0F031919181B1B1B0B191919181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B001A1A1A1A1A01021B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A001B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B0619
            191919171B1B1B1B1B1B040F1B1B1B1B1B181919181B1B1B1B1B1B1B17191919
            0F1B1B0F19191919041B1B1B1B1B1B1B1B1B1B1B1B1B1B181B1B1B1B1B1B1B1B
            1B1B1B001A1A1A1A1A1A1A1A1B1B1B1B1B1B1B001A1A1A1A1A1A1A01021B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A001B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1219191903051B1B1B1B1B1B1B07171B1B1B1B
            1B181919181B1B1B1B1B1B1B0F191919071B1B1B081919190B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B191B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1B1B1B1B
            1B1B001A1A1A1A1A1A1A1A1A01021B1B1B1B1B0C1A1A1A1A1A1A1A001B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B171919
            19121B1B1B1B1B1B1B1B17171B1B1B1B1B181919181B1B1B1B1B1B1B1B191919
            071B1B1B0B191919081B1B1B1B1B1B1B1B1B1B1B1B1B0B191B1B1B1B1B1B1B1B
            1B1B1B1B1B001A1A1A1A1A1A1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A01021B
            1B1B1B0C1A1A1A1A1A1A001B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B171919031B1B1B1B1B1B1B1B1B06171B1B1B1B
            1B181919181B1B1B1B1B1B1B05191919071B1B1B1B08191919101B1B1B1B1B1B
            1B1B1B1B1B0406191B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1B1B1B1B
            001A1A1A1A1A1A1A1A1A1A1A1A1A01021B1B1B0C1A1A1A1A1A001B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B0B1919
            191B1B1B1B1B1B1B1B0719171B1B1B1B1B181919181B1B1B1B1B1B1B17191906
            1B1B1B1B1B0503191903051B1B1B1B1B1B1B1B1B040819081B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B001A1A1A1A1B1B1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01
            021B1B0C1A1A1A1A001B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B04031919071B1B1B1B1B1B040619171B1B1B1B
            1B181919181B1B1B1B1B1B05191919121B1B1B1B1B1B0503191903101B1B1B1B
            1B1B1B05081919181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1B1B001A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01021B0C1A1A1A001B1B1B1B1B1B1B1B
            1B1B1B1B1B1B081919081B1B1B1B1B1B1B1B1B1B1B061919181B1B1B1B1B1719
            19030B1B1B1B1B05081919171B1B1B1B1B061919181B1B1B1B04170319190B1B
            1B1B1B1B1B1B1B0F081919190610071B0F120D19190619181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B001A1A1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
            1A01020C1A1A001B1B1B1B1B1B1B1B1B1B1B1B1B1B1019191919101B1B1B1B1B
            1B1B1B1B0D19191919101B1B1B1B1B1719191903180D0819061706171B1B1B04
            1119191919081818181919190E051B1B1B1B1B1B1B1B1B1B1B0B061919191919
            191919060B1B05181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A001A1A1A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01131A001B1B1B1B1B1B1B1B1B1B
            1B1B1B181818181818181818181B1B1B1B05181818181818181818181B1B1B1B
            070E031919190E0B1B1B12171B1B17171717171717171717171707041B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B05101718181117051B1B1B1B051B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B000A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A
            0A0A0A0A001B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Line11: TfrxLineView
          Top = 26.456710000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line12: TfrxLineView
          Left = 113.385900000000000000
          Top = 26.456710000000000000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line13: TfrxLineView
          Left = 219.212740000000000000
          Top = 26.456710000000000000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo40: TfrxMemoView
          Left = 230.551330000000000000
          Top = 3.779529999999820000
          Width = 480.000310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Ficha de Caixa')
          ParentFont = False
        end
        object Line14: TfrxLineView
          Top = 49.133889999999900000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line15: TfrxLineView
          Top = 71.811070000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line16: TfrxLineView
          Top = 94.488250000000500000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line17: TfrxLineView
          Left = 578.268090000000000000
          Top = 211.653680000000000000
          Height = -185.196970000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo41: TfrxMemoView
          Left = 3.779530000000000000
          Top = 26.456710000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Local de Pagamento')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 3.779530000000000000
          Top = 35.795300000000100000
          Width = 566.929500000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LOCPAG]')
          ParentFont = False
          WordWrap = False
        end
        object Memo43: TfrxMemoView
          Left = 3.779530000000000000
          Top = 49.133889999999900000
          Width = 49.133858270000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BENEFI]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 55.181102360000000000
          Top = 49.133889999999900000
          Width = 517.795275590000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCED]')
          ParentFont = False
          WordWrap = False
        end
        object lblVencimentoCX: TfrxMemoView
          Left = 582.047620000000000000
          Top = 26.456710000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 582.047620000000000000
          Top = 35.795300000000100000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTAVEN]')
          ParentFont = False
          WordWrap = False
        end
        object Memo48: TfrxMemoView
          Left = 582.047620000000000000
          Top = 49.133889999999900000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia/[CEDENT]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 582.047620000000000000
          Top = 58.472479999999900000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[AGECED]')
          ParentFont = False
          WordWrap = False
        end
        object rllNN1: TfrxMemoView
          Left = 582.047620000000000000
          Top = 71.811070000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira/Nosso N'#250'mero')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 582.047620000000000000
          Top = 81.149660000000200000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NOSNUM]')
          ParentFont = False
          WordWrap = False
        end
        object Line18: TfrxLineView
          Top = 117.165430000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo53: TfrxMemoView
          Left = 582.047620000000000000
          Top = 94.488250000000500000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor do Documento')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 582.047620000000000000
          Top = 103.826840000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[VALDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Left = 3.779530000000000000
          Top = 71.811070000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Documento')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 3.779530000000000000
          Top = 81.149660000000200000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTADOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line19: TfrxLineView
          Left = 132.283550000000000000
          Top = 94.488250000000500000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object lblNumDocumentoCX: TfrxMemoView
          Left = 136.063080000000000000
          Top = 71.811070000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#176' do Documento')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 136.063080000000000000
          Top = 81.149660000000200000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NUMDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line20: TfrxLineView
          Left = 268.346630000000000000
          Top = 94.488250000000500000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo59: TfrxMemoView
          Left = 272.126160000000000000
          Top = 71.811070000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Esp'#233'cie Doc.')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 272.126160000000000000
          Top = 81.149660000000200000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESPDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line21: TfrxLineView
          Left = 351.496290000000000000
          Top = 94.488250000000500000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo61: TfrxMemoView
          Left = 355.275820000000000000
          Top = 71.811070000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aceite')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 355.275820000000000000
          Top = 81.149660000000200000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ACEITE]')
          ParentFont = False
          WordWrap = False
        end
        object Line22: TfrxLineView
          Left = 423.307360000000000000
          Top = 94.488250000000500000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo63: TfrxMemoView
          Left = 427.086890000000000000
          Top = 71.811070000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Processamento')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 427.086890000000000000
          Top = 81.149660000000200000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTAPRO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo65: TfrxMemoView
          Left = 3.779530000000000000
          Top = 94.488250000000500000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Uso do Banco')
          ParentFont = False
        end
        object Line23: TfrxLineView
          Left = 240.669450000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo66: TfrxMemoView
          Left = 249.448980000000000000
          Top = 94.488250000000500000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 249.448980000000000000
          Top = 103.826840000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CARTEI]')
          ParentFont = False
          WordWrap = False
        end
        object Line24: TfrxLineView
          Left = 338.378170000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo69: TfrxMemoView
          Left = 340.157700000000000000
          Top = 103.826840000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'R$')
          ParentFont = False
          WordWrap = False
        end
        object Line25: TfrxLineView
          Left = 404.409710000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object MemQtd1: TfrxMemoView
          Left = 408.189240000000000000
          Top = 94.488250000000500000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 408.189240000000000000
          Top = 103.937000550000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
        end
        object Line26: TfrxLineView
          Left = 468.661720000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo72: TfrxMemoView
          Left = 472.441250000000000000
          Top = 94.488250000000500000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALMOE]')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 3.779530000000000000
          Top = 117.165430000000000000
          Width = 566.929500000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'INSTRU'#199#213'ES (Instru'#231#245'es de responsabilidade do benefici'#225'rio. Qual' +
              'quer d'#250'vida sobre este boleto, contate o benefici'#225'rio)')
          ParentFont = False
        end
        object lblInst1Cx: TfrxMemoView
          Left = 3.779530000000000000
          Top = 134.165430000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST01]')
          ParentFont = False
          WordWrap = False
        end
        object lblInst2Cx: TfrxMemoView
          Left = 3.779530000000000000
          Top = 143.504020000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST02]')
          ParentFont = False
          WordWrap = False
        end
        object lblInst3Cx: TfrxMemoView
          Left = 3.779530000000000000
          Top = 152.842610000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST03]')
          ParentFont = False
          WordWrap = False
        end
        object lblInst4Cx: TfrxMemoView
          Left = 3.779530000000000000
          Top = 162.181200000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST04]')
          ParentFont = False
          WordWrap = False
        end
        object lblInst5Cx: TfrxMemoView
          Left = 3.779530000000000000
          Top = 171.519790000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST05]')
          ParentFont = False
          WordWrap = False
        end
        object lblInst6Cx: TfrxMemoView
          Left = 3.779530000000000000
          Top = 180.858380000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST06]')
          ParentFont = False
          WordWrap = False
        end
        object lblInst7Cx: TfrxMemoView
          Left = 3.779530000000000000
          Top = 190.196970000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST07]')
          ParentFont = False
          WordWrap = False
        end
        object lblInst8Cx: TfrxMemoView
          Left = 3.779530000000000000
          Top = 199.535560000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST08]')
          ParentFont = False
          WordWrap = False
        end
        object Line27: TfrxLineView
          Top = 211.653680000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line28: TfrxLineView
          Left = 578.268090000000000000
          Top = 136.063080000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line29: TfrxLineView
          Left = 578.268090000000000000
          Top = 153.960730000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line30: TfrxLineView
          Left = 578.268090000000000000
          Top = 170.858380000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line31: TfrxLineView
          Left = 578.268090000000000000
          Top = 193.756030000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo84: TfrxMemoView
          Left = 582.047620000000000000
          Top = 117.165430000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Desconto/Abatimento')
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Left = 582.047620000000000000
          Top = 136.063080000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Outras Dedu'#231#245'es')
          ParentFont = False
        end
        object lblMoraMultaJurosCX: TfrxMemoView
          Left = 582.047620000000000000
          Top = 153.960730000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Mora/Multa/Juros')
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          Left = 582.047620000000000000
          Top = 170.858380000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Outros Acr'#233'cimos')
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          Left = 582.047620000000000000
          Top = 193.756030000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor Cobrado')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 41.354360000000000000
          Top = 211.653680000000000000
          Width = 411.968770000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMSAC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo92: TfrxMemoView
          Left = 41.354360000000000000
          Top = 235.110390000000000000
          Width = 665.197118900000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDSAC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo93: TfrxMemoView
          Left = 3.779527559055120000
          Top = 247.669450000001000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Sacador/Avalista:')
          ParentFont = False
        end
        object Memo94: TfrxMemoView
          Left = 461.102660000000000000
          Top = 211.653680000000000000
          Width = 249.448980000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSSAC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo95: TfrxMemoView
          Left = 461.102660000000000000
          Top = 258.669450000000000000
          Width = 249.448980000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[NOSNUM]')
          ParentFont = False
        end
        object Line32: TfrxLineView
          Top = 271.787570000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo96: TfrxMemoView
          Left = 527.354670000000000000
          Top = 271.787570000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Autentica'#231#227'o')
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          Left = 55.181107240000000000
          Top = 60.472479999999900000
          Width = 517.795610000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCED]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 582.047620000000000000
          Top = 180.637910000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[OUTACR]')
          ParentFont = False
          WordWrap = False
        end
        object Memo68: TfrxMemoView
          Left = 340.157700000000000000
          Top = 94.488250000000500000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ESPMOE]')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 3.779530000000000000
          Top = 211.653680000000000000
          Width = 34.015748030000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PAGADO]')
          ParentFont = False
        end
        object Memo204: TfrxMemoView
          Left = 76.346456690000000000
          Top = 247.330860000001000000
          Width = 631.181510000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SACAVA]')
          ParentFont = False
          WordWrap = False
        end
        object Memo220: TfrxMemoView
          Left = 241.889920000000000000
          Top = 105.826840000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CART02]')
          ParentFont = False
          WordWrap = False
        end
        object Memo219: TfrxMemoView
          Left = 76.346456690000000000
          Top = 258.669450000000000000
          Width = 381.732530000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDAVA]')
          ParentFont = False
          WordWrap = False
        end
        object Memo225: TfrxMemoView
          Left = 98.267780000000000000
          Top = 105.826840000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[USOBCO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo91: TfrxMemoView
          Left = 41.354360000000000000
          Top = 222.992270000001000000
          Width = 676.535433070000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDSAC]')
          ParentFont = False
        end
        object lblCodBaixaCX: TfrxMemoView
          Left = 527.354670000000000000
          Top = 259.787570000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo de Baixa')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 90.708720000000000000
          Top = 25.456710000000000000
          Width = 480.000310000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LOCEXT]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbFichaCaixaCut: TfrxChild
        FillType = ftBrush
        Height = 7.559060000000000000
        Top = 563.149970000000000000
        Width = 718.110700000000000000
        Child = frxBanco.rlbCompEntrN1
        PrintChildIfInvisible = True
        object Memo97: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 7.559060000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - -')
          ParentFont = False
        end
        object Memo98: TfrxMemoView
          Left = 695.433520000000000000
          Top = 1.000000000000000000
          Width = 15.118120000000000000
          Height = 7.559060000000000000
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #61474)
          ParentFont = False
        end
      end
      object rlbReciboSac: TfrxChild
        FillType = ftBrush
        Height = 284.244280000000000000
        Top = 759.685530000000000000
        Width = 718.110700000000000000
        Child = frxBanco.rlbCompEntrN2
        PrintChildIfInvisible = True
        object Memo100: TfrxMemoView
          Left = 578.268090000000000000
          Top = 26.456709999999800000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo99: TfrxMemoView
          Left = 578.268090000000000000
          Top = 94.488250000000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 284.244280000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          Left = 128.504020000000000000
          Top = 3.779529999999800000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODBCO]')
          ParentFont = False
        end
        object imgLog3: TfrxPictureView
          Left = 3.779530000000000000
          Top = 3.779529999999800000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Picture.Data = {
            07544269746D6170F6130000424DF61300000000000036040000280000009000
            00001C0000000100080000000000C00F0000C40E0000C40E0000000100000000
            00009C9EFF001010FF00CECFFF0010101000EFEFEF00CECFCE0021202100BDBE
            BD00313031007B7DFF004241FF009C9E9C00BDBEFF006361630052515200DEDF
            DE008C8E8C0073717300ADAEAD008C8EFF006361FF00DEDFFF00ADAEFF007B7D
            7B0042414200000000000000FF00FFFFFF000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00001B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B171717171717171717171B1B1B1B0F171717171717171717171B11041B
            1B1B120D1803180E0B1B1B1B1B1B17171717171717171717171717120F1B1B1B
            1B1B1B1B1B1B1B1B1B1B040B0E081919031810041B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B160909090909090909090909090909090909090909
            09090909021B1B1B1B1B1B1B1B1B1B1B1B1B1B07070E191919190E07071B1B1B
            1B0407070E191919190D07071B180D0510061919191919191906051B1B1B0707
            0D19191919061811180819191918071B1B1B1B1B1B1B1B1B0411191919191919
            19191903171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A001A1A1A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A011301021B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B061919061B1B1B1B1B1B1B1B1B1B04031919081B1B1B1B181919
            19080B041B1B0708191903051B1B1B1B1B061919181B1B1B1B1B051819191911
            1B1B1B1B1B1B1B0703191919030D120504070B0E1908041B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B001A1A1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
            1A01020C1A01021B1B1B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1819190D1B1B1B1B1B1B0408191906041B1B1B
            1B181919181B1B1B1B1B1B1B0E191919101B1B1B1B1B0B1919191911041B1B1B
            1B1B1B1B051808041B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1B1B001A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01021B0C1A1A01021B1B1B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B181918
            1B1B1B1B1B1B1B1B0F1919190B1B1B1B1B181919181B1B1B1B1B1B1B04031919
            031B1B1B1B07191919190B1B1B1B1B1B1B1B1B1B1B1B0D08041B1B1B1B1B1B1B
            1B1B1B1B1B1B1B001A1A1A1A1B1B1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01
            021B1B0C1A1A1A01021B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B18030F1B1B1B1B1B1B1B1B1B0619190E1B1B1B
            1B181919181B1B1B1B1B1B1B1B0D191919071B1B0403191919101B1B1B1B1B1B
            1B1B1B1B1B1B1B0D0D1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1B1B1B1B
            001A1A1A1A1A1A1A1A1A1A1A1A1A01021B1B1B0C1A1A1A1A01021B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B180D1B
            1B1B1B1B1B1B1B1B1B081919181B1B1B1B181919181B1B1B1B1B1B1B1B171919
            190B1B1B17191919181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B0F1B1B1B1B1B1B1B
            1B1B1B1B1B001A1A1A1A1A1A1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A01021B
            1B1B1B0C1A1A1A1A1A01021B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B18071B1B1B1B1B1B1B1B1B04191919181B1B1B
            1B181919181B1B1B1B1B1B1B1B171919190B1B1B06191919121B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1B1B1B1B
            1B1B001A1A1A1A1A1A1A1A1A01021B1B1B1B1B0C1A1A1A1A1A1A01021B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B111B1B
            1B1B1B1B1B1B1B1B0D1919190D1B1B1B1B181919181B1B1B1B1B1B1B1B0E1919
            19051B05191919031B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B001A1A1A1A1A1A1A1A1B1B1B1B1B1B1B001A1A1A1A1A1A1A01021B1B1B
            1B1B1B0C1A1A1A1A1A1A1A01021B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B1B1B040E19191919071B1B1B
            1B181919181B1B1B1B1B1B1B05191919061B1B10191919181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B001A1A1A1A1A01021B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A01021B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B1B
            1B1B1B1B1B120319191919111B1B1B1B1B181919181B1B1B1B1B1B0408191919
            071B1B11191919171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B001A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B001A1A1A01021B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A01021B1B1B1B1B1B1B18191906171717171717
            1717171717061919181B1B1B1B1B1B1B1B1B1B0F1819191919190D1B1B1B1B1B
            1B181919181B1B1B1B1B0B06191903121B1B1B18191919171B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B1B1B001A01021B1B1B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A1A0102
            1B1B1B1B1B1B181919191919191919191919191919191919181B1B1B1B1B1B1B
            1B1B0B0319191919030B1B1B1B1B1B1B1B18191919181818081919190311041B
            1B1B1B18191919171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B15
            1A1A1A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B1B1B14001B1B1B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A1A1A011B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B1B1B040E191919191908051B1B1B1B1B1B1B
            1B18191906171717171819191908051B1B1B1B0D191919171B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B1B1B001A01021B1B1B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A1A1A00
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B05
            061919191919171B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B050619190305
            1B1B1B17191919111B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B001A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B001A1A1A01021B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A1A001B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B05031919191908051B1B1B1B1B1B1B1B1B1B
            1B181919181B1B1B1B1B1B0F031919181B1B1B0B191919181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B001A1A1A1A1A01021B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A001B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B0619
            191919171B1B1B1B1B1B040F1B1B1B1B1B181919181B1B1B1B1B1B1B17191919
            0F1B1B0F19191919041B1B1B1B1B1B1B1B1B1B1B1B1B1B181B1B1B1B1B1B1B1B
            1B1B1B001A1A1A1A1A1A1A1A1B1B1B1B1B1B1B001A1A1A1A1A1A1A01021B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A001B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1219191903051B1B1B1B1B1B1B07171B1B1B1B
            1B181919181B1B1B1B1B1B1B0F191919071B1B1B081919190B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B191B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1B1B1B1B
            1B1B001A1A1A1A1A1A1A1A1A01021B1B1B1B1B0C1A1A1A1A1A1A1A001B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B171919
            19121B1B1B1B1B1B1B1B17171B1B1B1B1B181919181B1B1B1B1B1B1B1B191919
            071B1B1B0B191919081B1B1B1B1B1B1B1B1B1B1B1B1B0B191B1B1B1B1B1B1B1B
            1B1B1B1B1B001A1A1A1A1A1A1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A01021B
            1B1B1B0C1A1A1A1A1A1A001B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B171919031B1B1B1B1B1B1B1B1B06171B1B1B1B
            1B181919181B1B1B1B1B1B1B05191919071B1B1B1B08191919101B1B1B1B1B1B
            1B1B1B1B1B0406191B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1B1B1B1B
            001A1A1A1A1A1A1A1A1A1A1A1A1A01021B1B1B0C1A1A1A1A1A001B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B0B1919
            191B1B1B1B1B1B1B1B0719171B1B1B1B1B181919181B1B1B1B1B1B1B17191906
            1B1B1B1B1B0503191903051B1B1B1B1B1B1B1B1B040819081B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B001A1A1A1A1B1B1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01
            021B1B0C1A1A1A1A001B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B04031919071B1B1B1B1B1B040619171B1B1B1B
            1B181919181B1B1B1B1B1B05191919121B1B1B1B1B1B0503191903101B1B1B1B
            1B1B1B05081919181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1B1B001A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01021B0C1A1A1A001B1B1B1B1B1B1B1B
            1B1B1B1B1B1B081919081B1B1B1B1B1B1B1B1B1B1B061919181B1B1B1B1B1719
            19030B1B1B1B1B05081919171B1B1B1B1B061919181B1B1B1B04170319190B1B
            1B1B1B1B1B1B1B0F081919190610071B0F120D19190619181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B001A1A1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
            1A01020C1A1A001B1B1B1B1B1B1B1B1B1B1B1B1B1B1019191919101B1B1B1B1B
            1B1B1B1B0D19191919101B1B1B1B1B1719191903180D0819061706171B1B1B04
            1119191919081818181919190E051B1B1B1B1B1B1B1B1B1B1B0B061919191919
            191919060B1B05181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A001A1A1A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01131A001B1B1B1B1B1B1B1B1B1B
            1B1B1B181818181818181818181B1B1B1B05181818181818181818181B1B1B1B
            070E031919190E0B1B1B12171B1B17171717171717171717171707041B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B05101718181117051B1B1B1B051B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B000A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A
            0A0A0A0A001B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Line33: TfrxLineView
          Top = 26.456709999999800000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line34: TfrxLineView
          Left = 113.385900000000000000
          Top = 26.456709999999800000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line35: TfrxLineView
          Left = 219.212740000000000000
          Top = 26.456709999999800000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo103: TfrxMemoView
          Left = 604.724800000000000000
          Top = 3.779529999999800000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Recibo do Pagador')
          ParentFont = False
        end
        object Line36: TfrxLineView
          Top = 49.133890000000400000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line37: TfrxLineView
          Top = 71.811070000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line38: TfrxLineView
          Top = 94.488250000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line39: TfrxLineView
          Left = 578.268090000000000000
          Top = 211.653680000001000000
          Height = -185.196970000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo104: TfrxMemoView
          Left = 3.779530000000000000
          Top = 26.456709999999800000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Local de Pagamento')
          ParentFont = False
        end
        object Memo105: TfrxMemoView
          Left = 3.779530000000000000
          Top = 35.795300000000000000
          Width = 566.929500000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LOCPAG]')
          ParentFont = False
          WordWrap = False
        end
        object Memo107: TfrxMemoView
          Left = 56.692950000000000000
          Top = 49.133890000000000000
          Width = 514.016080000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCED]')
          ParentFont = False
          WordWrap = False
        end
        object lblVencimentoRecibo: TfrxMemoView
          Left = 582.047620000000000000
          Top = 26.456709999999800000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo109: TfrxMemoView
          Left = 582.047620000000000000
          Top = 35.795299999999600000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTAVEN]')
          ParentFont = False
          WordWrap = False
        end
        object Memo110: TfrxMemoView
          Left = 582.047620000000000000
          Top = 49.133890000000400000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia/[CEDENT]')
          ParentFont = False
        end
        object Memo111: TfrxMemoView
          Left = 582.047620000000000000
          Top = 58.472480000000200000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[AGECED]')
          ParentFont = False
          WordWrap = False
        end
        object rllNN2: TfrxMemoView
          Left = 582.047620000000000000
          Top = 71.811070000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira/Nosso N'#250'mero')
          ParentFont = False
        end
        object Memo113: TfrxMemoView
          Left = 582.047620000000000000
          Top = 81.149660000000200000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NOSNUM]')
          ParentFont = False
          WordWrap = False
        end
        object Line40: TfrxLineView
          Top = 117.165430000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo114: TfrxMemoView
          Left = 582.047620000000000000
          Top = 94.488250000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor do Documento')
          ParentFont = False
        end
        object Memo115: TfrxMemoView
          Left = 582.047620000000000000
          Top = 103.826840000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[VALDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo116: TfrxMemoView
          Left = 3.779530000000000000
          Top = 71.811070000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Documento')
          ParentFont = False
        end
        object Memo117: TfrxMemoView
          Left = 3.779530000000000000
          Top = 81.149660000000200000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTADOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line41: TfrxLineView
          Left = 132.283550000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object lblNumDocumentoRecibo: TfrxMemoView
          Left = 136.063080000000000000
          Top = 71.811070000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#176' do Documento')
          ParentFont = False
        end
        object Memo119: TfrxMemoView
          Left = 136.063080000000000000
          Top = 81.149660000000200000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NUMDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line42: TfrxLineView
          Left = 268.346630000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo120: TfrxMemoView
          Left = 272.126160000000000000
          Top = 71.811070000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Esp'#233'cie Doc.')
          ParentFont = False
        end
        object Memo121: TfrxMemoView
          Left = 272.126160000000000000
          Top = 81.149660000000200000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESPDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line43: TfrxLineView
          Left = 351.496290000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo122: TfrxMemoView
          Left = 355.275820000000000000
          Top = 71.811070000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aceite')
          ParentFont = False
        end
        object Memo123: TfrxMemoView
          Left = 355.275820000000000000
          Top = 81.149660000000200000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ACEITE]')
          ParentFont = False
          WordWrap = False
        end
        object Line44: TfrxLineView
          Left = 423.307360000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo124: TfrxMemoView
          Left = 427.086890000000000000
          Top = 71.811070000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Processamento')
          ParentFont = False
        end
        object Memo125: TfrxMemoView
          Left = 427.086890000000000000
          Top = 81.149660000000200000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTAPRO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo126: TfrxMemoView
          Left = 3.779530000000000000
          Top = 94.488250000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Uso do Banco')
          ParentFont = False
        end
        object Line45: TfrxLineView
          Left = 240.669450000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo127: TfrxMemoView
          Left = 249.448980000000000000
          Top = 94.488250000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira')
          ParentFont = False
        end
        object Memo128: TfrxMemoView
          Left = 249.448980000000000000
          Top = 103.826840000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CARTEI]')
          ParentFont = False
          WordWrap = False
        end
        object Line46: TfrxLineView
          Left = 338.378170000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo130: TfrxMemoView
          Left = 340.157700000000000000
          Top = 103.826840000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'R$')
          ParentFont = False
          WordWrap = False
        end
        object Line47: TfrxLineView
          Left = 404.409710000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object MemQtd2: TfrxMemoView
          Left = 408.189240000000000000
          Top = 94.488250000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Memo132: TfrxMemoView
          Left = 408.189240000000000000
          Top = 103.937000550000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
        end
        object Line48: TfrxLineView
          Left = 468.661720000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object lblInst1Pg: TfrxMemoView
          Left = 3.779530000000000000
          Top = 132.165430000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST01]')
          ParentFont = False
        end
        object lblInst2Pg: TfrxMemoView
          Left = 3.779530000000000000
          Top = 141.504020000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST02]')
          ParentFont = False
        end
        object lblInst3Pg: TfrxMemoView
          Left = 3.779530000000000000
          Top = 150.842610000001000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST03]')
          ParentFont = False
        end
        object lblInst4Pg: TfrxMemoView
          Left = 3.779530000000000000
          Top = 160.181200000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST04]')
          ParentFont = False
        end
        object lblInst5Pg: TfrxMemoView
          Left = 3.779530000000000000
          Top = 169.519790000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST05]')
          ParentFont = False
        end
        object lblInst6Pg: TfrxMemoView
          Left = 3.779530000000000000
          Top = 178.858380000001000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST06]')
          ParentFont = False
        end
        object lblInst7Pg: TfrxMemoView
          Left = 3.779530000000000000
          Top = 188.196970000001000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST07]')
          ParentFont = False
        end
        object lblInst8Pg: TfrxMemoView
          Left = 3.779530000000000000
          Top = 197.535560000001000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST08]')
          ParentFont = False
        end
        object Line49: TfrxLineView
          Top = 211.653680000001000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line50: TfrxLineView
          Left = 578.268090000000000000
          Top = 134.063080000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line51: TfrxLineView
          Left = 578.268090000000000000
          Top = 151.960730000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line52: TfrxLineView
          Left = 578.268090000000000000
          Top = 170.637910000001000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line53: TfrxLineView
          Left = 578.268090000000000000
          Top = 193.756030000001000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo145: TfrxMemoView
          Left = 582.047620000000000000
          Top = 117.165430000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Desconto/Abatimento')
          ParentFont = False
        end
        object Memo146: TfrxMemoView
          Left = 582.047620000000000000
          Top = 134.063080000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Outras Dedu'#231#245'es')
          ParentFont = False
        end
        object lblMoraMultaJurosRecibo: TfrxMemoView
          Left = 582.047620000000000000
          Top = 151.960730000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Mora/Multa/Juros')
          ParentFont = False
        end
        object Memo148: TfrxMemoView
          Left = 582.047620000000000000
          Top = 170.858380000001000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Outros Acr'#233'cimos')
          ParentFont = False
        end
        object Memo149: TfrxMemoView
          Left = 582.047620000000000000
          Top = 193.756030000001000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor Cobrado')
          ParentFont = False
        end
        object Memo151: TfrxMemoView
          Left = 41.354360000000000000
          Top = 211.653680000001000000
          Width = 411.968770000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMSAC]')
          ParentFont = False
        end
        object Memo153: TfrxMemoView
          Left = 41.354360000000000000
          Top = 236.110390000001000000
          Width = 665.197118900000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDSAC]')
          ParentFont = False
        end
        object Memo154: TfrxMemoView
          Left = 3.779527559055120000
          Top = 248.669450000001000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Sacador/Avalista:')
          ParentFont = False
        end
        object Memo155: TfrxMemoView
          Left = 461.102660000000000000
          Top = 211.653680000001000000
          Width = 249.448980000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSSAC]')
          ParentFont = False
        end
        object Memo156: TfrxMemoView
          Left = 461.102660000000000000
          Top = 259.669450000001000000
          Width = 249.448980000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[NOSNUM]')
          ParentFont = False
        end
        object Line54: TfrxLineView
          Top = 271.787570000001000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo157: TfrxMemoView
          Left = 527.354670000000000000
          Top = 271.787570000001000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Autentica'#231#227'o')
          ParentFont = False
        end
        object Memo143: TfrxMemoView
          Left = 56.692950000000000000
          Top = 60.472479999999800000
          Width = 514.016080000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCED]')
          ParentFont = False
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Left = 582.047620000000000000
          Top = 181.417440000001000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[OUTACR]')
          ParentFont = False
          WordWrap = False
        end
        object Memo129: TfrxMemoView
          Left = 340.157700000000000000
          Top = 94.488250000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ESPMOE]')
          ParentFont = False
        end
        object Memo106: TfrxMemoView
          Left = 3.779530000000000000
          Top = 49.133890000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BENEFI]')
          ParentFont = False
        end
        object Memo150: TfrxMemoView
          Left = 3.779530000000000000
          Top = 211.653680000001000000
          Width = 34.015748030000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PAGADO]')
          ParentFont = False
        end
        object Memo133: TfrxMemoView
          Left = 472.441250000000000000
          Top = 94.488250000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALMOE]')
          ParentFont = False
        end
        object Memo205: TfrxMemoView
          Left = 76.346456690000000000
          Top = 248.669450000001000000
          Width = 634.961040000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SACAVA]')
          ParentFont = False
          WordWrap = False
        end
        object rllLinDig: TfrxMemoView
          Left = 220.551330000000000000
          Top = 3.779529999999800000
          Width = 381.732530000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LINDIG]')
          ParentFont = False
        end
        object Memo221: TfrxMemoView
          Left = 241.889920000000000000
          Top = 105.826840000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CART02]')
          ParentFont = False
          WordWrap = False
        end
        object Memo223: TfrxMemoView
          Left = 76.346456690000000000
          Top = 259.669450000001000000
          Width = 381.732530000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDAVA]')
          ParentFont = False
          WordWrap = False
        end
        object Memo226: TfrxMemoView
          Left = 98.267780000000000000
          Top = 105.826840000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[USOBCO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo74: TfrxMemoView
          Left = 3.779530000000000000
          Top = 117.165430000000000000
          Width = 566.929500000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'INSTRU'#199#213'ES (Instru'#231#245'es de responsabilidade do benefici'#225'rio. Qual' +
              'quer d'#250'vida sobre este boleto, contate o benefici'#225'rio)')
          ParentFont = False
        end
        object Memo152: TfrxMemoView
          Left = 41.354360000000000000
          Top = 223.992270000001000000
          Width = 676.535433070000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDSAC]')
          ParentFont = False
        end
        object lblCodBaixaRecibo: TfrxMemoView
          Left = 527.354670000000000000
          Top = 257.008040000002000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo de Baixa')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 90.708720000000000000
          Top = 26.456709999999800000
          Width = 480.000310000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LOCEXT]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbReciboSacCut: TfrxChild
        FillType = ftBrush
        Height = 7.559060000000000000
        Top = 1141.418060000000000000
        Width = 718.110700000000000000
        Child = frxBanco.rlbFichaComp
        PrintChildIfInvisible = True
        object Memo158: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 7.559060000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - -')
          ParentFont = False
        end
        object Memo159: TfrxMemoView
          Left = 695.433520000000000000
          Width = 15.118120000000000000
          Height = 7.559060000000000000
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #61474)
          ParentFont = False
        end
      end
      object rlbFichaComp: TfrxChild
        FillType = ftBrush
        Height = 332.598640000000000000
        Top = 1171.654300000000000000
        Width = 718.110700000000000000
        Child = frxBanco.rlbFichaCompensacaoPix
        PrintChildIfInvisible = True
        object Memo162: TfrxMemoView
          Left = 578.268090000000000000
          Top = 26.456709999999900000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo161: TfrxMemoView
          Left = 578.268090000000000000
          Top = 94.488250000000100000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo160: TfrxMemoView
          Width = 718.110236220000000000
          Height = 272.125935430000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          ParentFont = False
        end
        object Memo163: TfrxMemoView
          Left = 128.504020000000000000
          Top = 1.779530000000020000
          Width = 75.590600000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODBCO]')
          ParentFont = False
        end
        object imgLog4: TfrxPictureView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Picture.Data = {
            07544269746D6170F6130000424DF61300000000000036040000280000009000
            00001C0000000100080000000000C00F0000C40E0000C40E0000000100000000
            00009C9EFF001010FF00CECFFF0010101000EFEFEF00CECFCE0021202100BDBE
            BD00313031007B7DFF004241FF009C9E9C00BDBEFF006361630052515200DEDF
            DE008C8E8C0073717300ADAEAD008C8EFF006361FF00DEDFFF00ADAEFF007B7D
            7B0042414200000000000000FF00FFFFFF000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00001B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B171717171717171717171B1B1B1B0F171717171717171717171B11041B
            1B1B120D1803180E0B1B1B1B1B1B17171717171717171717171717120F1B1B1B
            1B1B1B1B1B1B1B1B1B1B040B0E081919031810041B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B160909090909090909090909090909090909090909
            09090909021B1B1B1B1B1B1B1B1B1B1B1B1B1B07070E191919190E07071B1B1B
            1B0407070E191919190D07071B180D0510061919191919191906051B1B1B0707
            0D19191919061811180819191918071B1B1B1B1B1B1B1B1B0411191919191919
            19191903171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A001A1A1A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A011301021B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B061919061B1B1B1B1B1B1B1B1B1B04031919081B1B1B1B181919
            19080B041B1B0708191903051B1B1B1B1B061919181B1B1B1B1B051819191911
            1B1B1B1B1B1B1B0703191919030D120504070B0E1908041B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B001A1A1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
            1A01020C1A01021B1B1B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1819190D1B1B1B1B1B1B0408191906041B1B1B
            1B181919181B1B1B1B1B1B1B0E191919101B1B1B1B1B0B1919191911041B1B1B
            1B1B1B1B051808041B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1B1B001A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01021B0C1A1A01021B1B1B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B181918
            1B1B1B1B1B1B1B1B0F1919190B1B1B1B1B181919181B1B1B1B1B1B1B04031919
            031B1B1B1B07191919190B1B1B1B1B1B1B1B1B1B1B1B0D08041B1B1B1B1B1B1B
            1B1B1B1B1B1B1B001A1A1A1A1B1B1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01
            021B1B0C1A1A1A01021B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B18030F1B1B1B1B1B1B1B1B1B0619190E1B1B1B
            1B181919181B1B1B1B1B1B1B1B0D191919071B1B0403191919101B1B1B1B1B1B
            1B1B1B1B1B1B1B0D0D1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1B1B1B1B
            001A1A1A1A1A1A1A1A1A1A1A1A1A01021B1B1B0C1A1A1A1A01021B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B180D1B
            1B1B1B1B1B1B1B1B1B081919181B1B1B1B181919181B1B1B1B1B1B1B1B171919
            190B1B1B17191919181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B0F1B1B1B1B1B1B1B
            1B1B1B1B1B001A1A1A1A1A1A1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A01021B
            1B1B1B0C1A1A1A1A1A01021B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B18071B1B1B1B1B1B1B1B1B04191919181B1B1B
            1B181919181B1B1B1B1B1B1B1B171919190B1B1B06191919121B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1B1B1B1B
            1B1B001A1A1A1A1A1A1A1A1A01021B1B1B1B1B0C1A1A1A1A1A1A01021B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B111B1B
            1B1B1B1B1B1B1B1B0D1919190D1B1B1B1B181919181B1B1B1B1B1B1B1B0E1919
            19051B05191919031B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B001A1A1A1A1A1A1A1A1B1B1B1B1B1B1B001A1A1A1A1A1A1A01021B1B1B
            1B1B1B0C1A1A1A1A1A1A1A01021B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B1B1B040E19191919071B1B1B
            1B181919181B1B1B1B1B1B1B05191919061B1B10191919181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B001A1A1A1A1A01021B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A01021B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B1B
            1B1B1B1B1B120319191919111B1B1B1B1B181919181B1B1B1B1B1B0408191919
            071B1B11191919171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B001A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B001A1A1A01021B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A01021B1B1B1B1B1B1B18191906171717171717
            1717171717061919181B1B1B1B1B1B1B1B1B1B0F1819191919190D1B1B1B1B1B
            1B181919181B1B1B1B1B0B06191903121B1B1B18191919171B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B1B1B001A01021B1B1B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A1A0102
            1B1B1B1B1B1B181919191919191919191919191919191919181B1B1B1B1B1B1B
            1B1B0B0319191919030B1B1B1B1B1B1B1B18191919181818081919190311041B
            1B1B1B18191919171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B15
            1A1A1A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B1B1B14001B1B1B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A1A1A011B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B1B1B040E191919191908051B1B1B1B1B1B1B
            1B18191906171717171819191908051B1B1B1B0D191919171B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B1B1B001A01021B1B1B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A1A1A00
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B05
            061919191919171B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B050619190305
            1B1B1B17191919111B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B001A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B001A1A1A01021B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A1A001B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B05031919191908051B1B1B1B1B1B1B1B1B1B
            1B181919181B1B1B1B1B1B0F031919181B1B1B0B191919181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B001A1A1A1A1A01021B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A001B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B0619
            191919171B1B1B1B1B1B040F1B1B1B1B1B181919181B1B1B1B1B1B1B17191919
            0F1B1B0F19191919041B1B1B1B1B1B1B1B1B1B1B1B1B1B181B1B1B1B1B1B1B1B
            1B1B1B001A1A1A1A1A1A1A1A1B1B1B1B1B1B1B001A1A1A1A1A1A1A01021B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A001B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1219191903051B1B1B1B1B1B1B07171B1B1B1B
            1B181919181B1B1B1B1B1B1B0F191919071B1B1B081919190B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B191B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1B1B1B1B
            1B1B001A1A1A1A1A1A1A1A1A01021B1B1B1B1B0C1A1A1A1A1A1A1A001B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B171919
            19121B1B1B1B1B1B1B1B17171B1B1B1B1B181919181B1B1B1B1B1B1B1B191919
            071B1B1B0B191919081B1B1B1B1B1B1B1B1B1B1B1B1B0B191B1B1B1B1B1B1B1B
            1B1B1B1B1B001A1A1A1A1A1A1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A01021B
            1B1B1B0C1A1A1A1A1A1A001B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B171919031B1B1B1B1B1B1B1B1B06171B1B1B1B
            1B181919181B1B1B1B1B1B1B05191919071B1B1B1B08191919101B1B1B1B1B1B
            1B1B1B1B1B0406191B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1B1B1B1B
            001A1A1A1A1A1A1A1A1A1A1A1A1A01021B1B1B0C1A1A1A1A1A001B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B0B1919
            191B1B1B1B1B1B1B1B0719171B1B1B1B1B181919181B1B1B1B1B1B1B17191906
            1B1B1B1B1B0503191903051B1B1B1B1B1B1B1B1B040819081B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B001A1A1A1A1B1B1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01
            021B1B0C1A1A1A1A001B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B04031919071B1B1B1B1B1B040619171B1B1B1B
            1B181919181B1B1B1B1B1B05191919121B1B1B1B1B1B0503191903101B1B1B1B
            1B1B1B05081919181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1B1B001A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01021B0C1A1A1A001B1B1B1B1B1B1B1B
            1B1B1B1B1B1B081919081B1B1B1B1B1B1B1B1B1B1B061919181B1B1B1B1B1719
            19030B1B1B1B1B05081919171B1B1B1B1B061919181B1B1B1B04170319190B1B
            1B1B1B1B1B1B1B0F081919190610071B0F120D19190619181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B001A1A1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
            1A01020C1A1A001B1B1B1B1B1B1B1B1B1B1B1B1B1B1019191919101B1B1B1B1B
            1B1B1B1B0D19191919101B1B1B1B1B1719191903180D0819061706171B1B1B04
            1119191919081818181919190E051B1B1B1B1B1B1B1B1B1B1B0B061919191919
            191919060B1B05181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A001A1A1A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01131A001B1B1B1B1B1B1B1B1B1B
            1B1B1B181818181818181818181B1B1B1B05181818181818181818181B1B1B1B
            070E031919190E0B1B1B12171B1B17171717171717171717171707041B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B05101718181117051B1B1B1B051B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B000A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A
            0A0A0A0A001B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Line55: TfrxLineView
          Top = 26.456709999999900000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line56: TfrxLineView
          Left = 113.385900000000000000
          Top = 26.456709999999900000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line57: TfrxLineView
          Left = 219.212740000000000000
          Top = 26.456709999999900000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo164: TfrxMemoView
          Left = 220.551330000000000000
          Top = 3.779530000000020000
          Width = 381.732530000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LINDIG]')
          ParentFont = False
        end
        object Line58: TfrxLineView
          Top = 49.133890000000100000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line59: TfrxLineView
          Top = 71.811070000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line60: TfrxLineView
          Top = 94.488250000000100000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line61: TfrxLineView
          Left = 578.268090000000000000
          Top = 211.653680000000000000
          Height = -185.196970000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo165: TfrxMemoView
          Left = 3.779530000000000000
          Top = 26.456709999999900000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Local de Pagamento')
          ParentFont = False
        end
        object Memo166: TfrxMemoView
          Left = 3.779530000000000000
          Top = 35.795300000000000000
          Width = 566.929500000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LOCPAG]')
          ParentFont = False
          WordWrap = False
        end
        object Memo168: TfrxMemoView
          Left = 56.692950000000000000
          Top = 49.133890000000100000
          Width = 514.016080000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCED]')
          ParentFont = False
          WordWrap = False
        end
        object lblVencimentoFicha: TfrxMemoView
          Left = 582.047620000000000000
          Top = 26.456709999999900000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo170: TfrxMemoView
          Left = 582.047620000000000000
          Top = 35.795300000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTAVEN]')
          ParentFont = False
          WordWrap = False
        end
        object Memo171: TfrxMemoView
          Left = 582.047620000000000000
          Top = 49.133890000000100000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia/[CEDENT]')
          ParentFont = False
        end
        object Memo172: TfrxMemoView
          Left = 582.047620000000000000
          Top = 58.472479999999900000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[AGECED]')
          ParentFont = False
          WordWrap = False
        end
        object rllNN3: TfrxMemoView
          Left = 582.047620000000000000
          Top = 71.811070000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira/Nosso N'#250'mero')
          ParentFont = False
        end
        object Memo174: TfrxMemoView
          Left = 582.047620000000000000
          Top = 81.149660000000000000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NOSNUM]')
          ParentFont = False
          WordWrap = False
        end
        object Line62: TfrxLineView
          Top = 117.165430000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo175: TfrxMemoView
          Left = 582.047620000000000000
          Top = 94.488250000000100000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor do Documento')
          ParentFont = False
        end
        object Memo176: TfrxMemoView
          Left = 582.047620000000000000
          Top = 103.826840000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[VALDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo177: TfrxMemoView
          Left = 3.779530000000000000
          Top = 71.811070000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Documento')
          ParentFont = False
        end
        object Memo178: TfrxMemoView
          Left = 3.779530000000000000
          Top = 81.149660000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTADOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line63: TfrxLineView
          Left = 132.283550000000000000
          Top = 94.488250000000100000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object lblNumDocumentoFicha: TfrxMemoView
          Left = 136.063080000000000000
          Top = 71.811070000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#176' do Documento')
          ParentFont = False
        end
        object Memo180: TfrxMemoView
          Left = 136.063080000000000000
          Top = 81.149660000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NUMDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line64: TfrxLineView
          Left = 268.346630000000000000
          Top = 94.488250000000100000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo181: TfrxMemoView
          Left = 272.126160000000000000
          Top = 71.811070000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Esp'#233'cie Doc.')
          ParentFont = False
        end
        object Memo182: TfrxMemoView
          Left = 272.126160000000000000
          Top = 81.149660000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESPDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line65: TfrxLineView
          Left = 351.496290000000000000
          Top = 94.488250000000100000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo183: TfrxMemoView
          Left = 355.275820000000000000
          Top = 71.811070000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aceite')
          ParentFont = False
        end
        object Memo184: TfrxMemoView
          Left = 355.275820000000000000
          Top = 81.149660000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ACEITE]')
          ParentFont = False
          WordWrap = False
        end
        object Line66: TfrxLineView
          Left = 423.307360000000000000
          Top = 94.488250000000100000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo185: TfrxMemoView
          Left = 427.086890000000000000
          Top = 71.811070000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Processamento')
          ParentFont = False
        end
        object Memo186: TfrxMemoView
          Left = 427.086890000000000000
          Top = 81.149660000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTAPRO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo187: TfrxMemoView
          Left = 3.779530000000000000
          Top = 94.488250000000100000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Uso do Banco')
          ParentFont = False
        end
        object Line67: TfrxLineView
          Left = 240.669450000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo188: TfrxMemoView
          Left = 249.448980000000000000
          Top = 94.488250000000100000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira')
          ParentFont = False
        end
        object Memo189: TfrxMemoView
          Left = 249.448980000000000000
          Top = 103.826840000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CARTEI]')
          ParentFont = False
          WordWrap = False
        end
        object Line68: TfrxLineView
          Left = 338.378170000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo191: TfrxMemoView
          Left = 340.157700000000000000
          Top = 103.826840000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'R$')
          ParentFont = False
          WordWrap = False
        end
        object Line69: TfrxLineView
          Left = 404.409710000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object MemQtd3: TfrxMemoView
          Left = 408.189240000000000000
          Top = 94.488250000000100000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Memo193: TfrxMemoView
          Left = 408.189240000000000000
          Top = 103.937000550000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
        end
        object Line70: TfrxLineView
          Left = 468.661720000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object lblInst1Cp: TfrxMemoView
          Left = 3.779530000000000000
          Top = 131.165430000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST01]')
          ParentFont = False
        end
        object lblInst2Cp: TfrxMemoView
          Left = 3.779530000000000000
          Top = 140.504020000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST02]')
          ParentFont = False
        end
        object lblInst3Cp: TfrxMemoView
          Left = 3.779530000000000000
          Top = 149.842610000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST03]')
          ParentFont = False
        end
        object lblInst4Cp: TfrxMemoView
          Left = 3.779530000000000000
          Top = 159.181200000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST04]')
          ParentFont = False
        end
        object lblInst5Cp: TfrxMemoView
          Left = 3.779530000000000000
          Top = 168.519790000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST05]')
          ParentFont = False
        end
        object lblInst6Cp: TfrxMemoView
          Left = 3.779530000000000000
          Top = 177.858380000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST06]')
          ParentFont = False
        end
        object lblInst7Cp: TfrxMemoView
          Left = 3.779530000000000000
          Top = 187.196970000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST07]')
          ParentFont = False
        end
        object lblInst8Cp: TfrxMemoView
          Left = 3.779530000000000000
          Top = 197.535560000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST08]')
          ParentFont = False
        end
        object Line71: TfrxLineView
          Top = 211.653680000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line72: TfrxLineView
          Left = 578.268090000000000000
          Top = 136.063080000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line73: TfrxLineView
          Left = 578.268090000000000000
          Top = 152.960730000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line74: TfrxLineView
          Left = 578.268090000000000000
          Top = 171.637910000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line75: TfrxLineView
          Left = 578.268090000000000000
          Top = 194.756030000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo206: TfrxMemoView
          Left = 582.047620000000000000
          Top = 117.165430000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Desconto/Abatimento')
          ParentFont = False
        end
        object Memo207: TfrxMemoView
          Left = 582.047620000000000000
          Top = 136.063080000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Outras Dedu'#231#245'es')
          ParentFont = False
        end
        object lblMoraMultaJurosFicha: TfrxMemoView
          Left = 582.047620000000000000
          Top = 152.960730000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Mora/Multa/Juros')
          ParentFont = False
        end
        object Memo209: TfrxMemoView
          Left = 582.047620000000000000
          Top = 171.858380000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Outros Acr'#233'cimos')
          ParentFont = False
        end
        object Memo210: TfrxMemoView
          Left = 582.047620000000000000
          Top = 194.756030000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor Cobrado')
          ParentFont = False
        end
        object Memo212: TfrxMemoView
          Left = 41.354360000000000000
          Top = 212.653680000000000000
          Width = 411.968770000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMSAC]')
          ParentFont = False
        end
        object Memo214: TfrxMemoView
          Left = 41.354360000000000000
          Top = 236.110390000000000000
          Width = 665.197118900000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDSAC]')
          ParentFont = False
        end
        object Memo215: TfrxMemoView
          Left = 3.779527559055120000
          Top = 247.669450000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Sacador/Avalista:')
          ParentFont = False
        end
        object Memo216: TfrxMemoView
          Left = 461.102660000000000000
          Top = 212.653680000000000000
          Width = 249.448980000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSSAC]')
          ParentFont = False
        end
        object Memo217: TfrxMemoView
          Left = 461.102660000000000000
          Top = 259.669450000000000000
          Width = 249.448980000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[NOSNUM]')
          ParentFont = False
        end
        object lblAutentMec: TfrxMemoView
          Left = 527.268090000000000000
          Top = 272.787570000000000000
          Width = 177.637910000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Autentica'#231#227'o mec'#226'nica /')
          ParentFont = False
        end
        object barCodigo: TfrxBarCodeView
          Left = 5.669291340000000000
          Top = 283.126160000000000000
          Width = 474.000000000000000000
          Height = 49.133858270000000000
          BarType = bcCode_2_5_interleaved
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '12345678901234567890123456789012345678901234'
          WideBarRatio = 1.000000000000000000
          Zoom = 1.500000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object lblFichaComp2: TfrxMemoView
          Left = 617.622450000000000000
          Top = 272.787570000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ficha de Compensa'#231#227'o')
          ParentFont = False
        end
        object Memo144: TfrxMemoView
          Left = 56.692920710000000000
          Top = 60.472479999999900000
          Width = 514.016080000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCED]')
          ParentFont = False
          WordWrap = False
        end
        object Memo112: TfrxMemoView
          Left = 582.047620000000000000
          Top = 182.417440000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[OUTACR]')
          ParentFont = False
          WordWrap = False
        end
        object Memo173: TfrxMemoView
          Left = 340.157700000000000000
          Top = 94.488250000000100000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ESPMOE]')
          ParentFont = False
        end
        object Memo167: TfrxMemoView
          Left = 3.779530000000000000
          Top = 49.133890000000100000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BENEFI]')
          ParentFont = False
        end
        object Memo190: TfrxMemoView
          Left = 3.779530000000000000
          Top = 212.653680000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PAGADO]')
          ParentFont = False
        end
        object Memo211: TfrxMemoView
          Left = 76.346456690000000000
          Top = 247.669450000000000000
          Width = 634.961040000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SACAVA]')
          ParentFont = False
          WordWrap = False
        end
        object Memo222: TfrxMemoView
          Left = 241.889920000000000000
          Top = 105.826840000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CART02]')
          ParentFont = False
          WordWrap = False
        end
        object Memo224: TfrxMemoView
          Left = 76.346456690000000000
          Top = 259.669450000000000000
          Width = 381.732530000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDAVA]')
          ParentFont = False
          WordWrap = False
        end
        object Memo227: TfrxMemoView
          Left = 98.267780000000000000
          Top = 105.826840000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[USOBCO]')
          ParentFont = False
          WordWrap = False
        end
        object lblFichaComp: TfrxMemoView
          Left = 617.622450000000000000
          Top = 212.653680000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ficha de Compensa'#231#227'o')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 3.779530000000000000
          Top = 118.165430000000000000
          Width = 566.929500000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'INSTRU'#199#213'ES (Instru'#231#245'es de responsabilidade do benefici'#225'rio. Qual' +
              'quer d'#250'vida sobre este boleto, contate o benefici'#225'rio)')
          ParentFont = False
        end
        object Memo213: TfrxMemoView
          Left = 41.354360000000000000
          Top = 224.992270000000000000
          Width = 676.535870000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDSAC]')
          ParentFont = False
        end
        object lblCodBaixaFicha: TfrxMemoView
          Left = 527.354670000000000000
          Top = 260.787570000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo de Baixa')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 90.708720000000000000
          Top = 26.456709999999900000
          Width = 480.000310000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LOCEXT]')
          ParentFont = False
          WordWrap = False
        end
        object Memo194: TfrxMemoView
          Left = 472.441250000000000000
          Top = 94.488250000000100000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALMOE]')
          ParentFont = False
        end
      end
      object rlbCompEntrN1: TfrxChild
        FillType = ftBrush
        Height = 105.826752130000000000
        Top = 593.386210000000000000
        Width = 718.110700000000000000
        Child = frxBanco.rlbReciboPagadorComImagem
        PrintChildIfInvisible = True
      end
      object rlbCompEntrN2: TfrxChild
        FillType = ftBrush
        Height = 5.669281570000000000
        Top = 1065.827460000000000000
        Width = 718.110700000000000000
        Child = frxBanco.rlbTelSac
        PrintChildIfInvisible = True
      end
      object rlbTelSac: TfrxChild
        FillType = ftBrush
        Height = 20.787399130000000000
        Top = 1096.063700000000000000
        Width = 718.110700000000000000
        Child = frxBanco.rlbReciboSacCut
        PrintChildIfInvisible = True
        object rllTelSac: TfrxMemoView
          Left = 3.779530000000000000
          Width = 287.244280000000000000
          Height = 20.787399130000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -5
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'SAC CAIXA: 0800 726 0101 (informa'#231#245'es, reclama'#231#245'es, sugest'#245'es e ' +
              'elogios)'
            'Para pessoas com defici'#234'ncia auditiva ou de fala: 0800 726 2492'
            
              'Ouvidoria: 0800 725 7474                                        ' +
              '  caixa.gov.br')
          ParentFont = False
        end
      end
      object rlbAgrupamento: TfrxChild
        FillType = ftBrush
        Height = 12.094312440000000000
        Top = 219.212740000000000000
        Visible = False
        Width = 718.110700000000000000
        AllowSplit = True
        Child = frxBanco.rlbFichaCaixa
        PrintChildIfInvisible = True
        Stretched = True
        object sbrAgrupamento: TfrxSubreport
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          Page = frxBanco.Page1
          PrintOnParent = True
        end
      end
      object rlbReciboPagadorComImagem: TfrxChild
        FillType = ftBrush
        Height = 15.118112680000000000
        Top = 721.890230000000000000
        Visible = False
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbReciboPagadorComImagemOnBeforePrint'
        AllowSplit = True
        Child = frxBanco.rlbReciboSac
        PrintChildIfInvisible = True
        Stretched = True
        object sbrReciboPagadorComImagem: TfrxSubreport
          Align = baLeft
          Width = 117.165430000000000000
          Height = 11.338582680000000000
          Page = frxBanco.Page2
          PrintOnParent = True
        end
      end
      object rlbCompEntrCut: TfrxChild
        FillType = ftBrush
        Height = 7.559060000000000000
        Top = 188.976500000000000000
        Width = 718.110700000000000000
        AllowSplit = True
        Child = frxBanco.rlbAgrupamento
        PrintChildIfInvisible = True
        Stretched = True
        object Memo36: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 7.559060000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - -')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 695.433520000000000000
          Width = 15.118120000000000000
          Height = 7.559060000000000000
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #61474)
          ParentFont = False
        end
      end
      object rlbFichaCompensacaoPix: TfrxChild
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 1526.930120000000000000
        Visible = False
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object Subreport1: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxBanco.sbrFichaCompensacaoQRCodePix
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 5.000000000000000000
      EndlessHeight = True
      LargeDesignHeight = True
      object rlbHeaderAgrupamento: TfrxHeader
        FillType = ftBrush
        Height = 109.606370000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo200: TfrxMemoView
          Align = baLeft
          Top = 94.488250000000000000
          Width = 86.929133860000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'm. dup.')
          ParentFont = False
        end
        object Memo201: TfrxMemoView
          Align = baLeft
          Left = 86.929133860000000000
          Top = 94.488250000000000000
          Width = 37.795275590000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Parc.')
          ParentFont = False
        end
        object Memo202: TfrxMemoView
          Align = baLeft
          Left = 124.724409450000000000
          Top = 94.488250000000000000
          Width = 37.795275590000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Esp.')
          ParentFont = False
        end
        object Memo203: TfrxMemoView
          Align = baLeft
          Left = 162.519685040000000000
          Top = 94.488250000000000000
          Width = 37.795275590000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Emp.')
          ParentFont = False
        end
        object Memo218: TfrxMemoView
          Align = baLeft
          Left = 200.314960630000000000
          Top = 94.488250000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo228: TfrxMemoView
          Align = baLeft
          Left = 283.464620630000000000
          Top = 94.488250000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo229: TfrxMemoView
          Align = baLeft
          Left = 359.055220630000000000
          Top = 94.488250000000000000
          Width = 86.929133860000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'm. dup.')
          ParentFont = False
        end
        object Memo230: TfrxMemoView
          Align = baLeft
          Left = 445.984354490000000000
          Top = 94.488250000000000000
          Width = 37.795275590000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Parc.')
          ParentFont = False
        end
        object Memo231: TfrxMemoView
          Align = baLeft
          Left = 483.779630080000000000
          Top = 94.488250000000000000
          Width = 37.795275590000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Esp.')
          ParentFont = False
        end
        object Memo232: TfrxMemoView
          Align = baLeft
          Left = 521.574905670000000000
          Top = 94.488250000000000000
          Width = 37.795275590000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Emp.')
          ParentFont = False
        end
        object Memo233: TfrxMemoView
          Align = baLeft
          Left = 559.370181260000000000
          Top = 94.488250000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo234: TfrxMemoView
          Align = baLeft
          Left = 642.519841260000000000
          Top = 94.488250000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Top = 71.811023620000000000
          Width = 487.559370000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8W = (
            '[NOMSAC]')
          ParentFont = False
          VAlign = vaBottom
        end
        object imgLogo: TfrxPictureView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 68.031540000000000000
          Height = 64.252010000000000000
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo81: TfrxMemoView
          Left = 3.779530000000000000
          Top = 71.811070000000000000
          Width = 154.960730000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome do cliente')
          ParentFont = False
        end
        object Memo134: TfrxMemoView
          Left = 487.559370000000000000
          Top = 71.811023620000000000
          Width = 230.551281180000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8W = (
            '[MAILCLI]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo135: TfrxMemoView
          Left = 491.338900000000000000
          Top = 71.811023620000000000
          Width = 75.590551180000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'E-Mail do cliente')
          ParentFont = False
        end
        object Memo136: TfrxMemoView
          Left = 75.590600000000000000
          Top = 49.133890000000000000
          Width = 566.929500000000000000
          Height = 18.897650000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'T'#237'tulos agrupados')
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 15.874015750000000000
        Top = 151.181200000000000000
        Width = 718.110700000000000000
        Columns = 2
        ColumnWidth = 359.055118110236000000
        DataSet = frxAgrupamento
        DataSetName = 'frxAgrupamento'
        RowCount = 0
        object Memo235: TfrxMemoView
          Align = baLeft
          Width = 86.929133860000000000
          Height = 13.984251970000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxAgrupamento."CTR_NUMDUP"]')
          ParentFont = False
        end
        object Memo236: TfrxMemoView
          Align = baLeft
          Left = 86.929133860000000000
          Width = 37.795275590000000000
          Height = 13.984251970000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxAgrupamento."CTR_PARCEL"]')
          ParentFont = False
        end
        object Memo237: TfrxMemoView
          Align = baLeft
          Left = 124.724409450000000000
          Width = 37.795275590000000000
          Height = 13.984251970000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxAgrupamento."CTR_ESPDOC"]')
          ParentFont = False
        end
        object Memo238: TfrxMemoView
          Align = baLeft
          Left = 162.519685040000000000
          Width = 37.795275590000000000
          Height = 13.984251970000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxAgrupamento."CTR_CODEMP"]')
          ParentFont = False
        end
        object Memo239: TfrxMemoView
          Align = baLeft
          Left = 200.314960630000000000
          Width = 83.149633150000000000
          Height = 13.984251970000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxAgrupamento."CTR_DTAVEN"]')
          ParentFont = False
        end
        object Memo240: TfrxMemoView
          Align = baLeft
          Left = 283.464593780000000000
          Width = 75.590551180000000000
          Height = 15.874015750000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxAgrupamento."CTR_VALCOR"]')
          ParentFont = False
        end
        object Line81: TfrxLineView
          Align = baLeft
          Height = 15.874015750000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line82: TfrxLineView
          Align = baRight
          Left = 718.110700000000000000
          Height = 15.874015750000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 188.976500000000000000
        Width = 718.110700000000000000
        object Memo241: TfrxMemoView
          Align = baRight
          Left = 642.520126850000000000
          Width = 75.590573150000000000
          Height = 14.038254290000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxAgrupamento."CTR_VALCOR">,MasterData2)]')
          ParentFont = False
        end
        object Memo242: TfrxMemoView
          Align = baRight
          Left = 566.929553700000000000
          Width = 75.590573150000000000
          Height = 14.038254290000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Total Geral: ')
          ParentFont = False
        end
        object Line84: TfrxLineView
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo77: TfrxMemoView
          Align = baRight
          Left = 642.520126850000000000
          Top = 14.118120000000000000
          Width = 75.590573150000000000
          Height = 14.038254290000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VALDOC]')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Align = baRight
          Left = 642.520126850000000000
          Top = 28.236240000000000000
          Width = 75.590573150000000000
          Height = 14.038254290000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[DTAVEN]')
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Align = baRight
          Left = 502.677543700000000000
          Top = 14.118120000000000000
          Width = 139.842583150000000000
          Height = 14.038254290000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Parcela [NUMPARC] de [TOTPARC]: ')
          ParentFont = False
        end
        object Memo80: TfrxMemoView
          Align = baRight
          Left = 502.677543700000000000
          Top = 28.236240000000000000
          Width = 139.842583150000000000
          Height = 14.038254290000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vencimento desta parcela: ')
          ParentFont = False
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 5.000000000000000000
      EndlessHeight = True
      LargeDesignHeight = True
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight, ftTop]
        Height = 379.953000000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        RowCount = 1
        object Line78: TfrxLineView
          Width = 718.110236220471900000
          Color = clBlack
          Diagonal = True
        end
        object Memo57: TfrxMemoView
          Left = 577.488560000000000000
          Top = 116.622140000000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 577.488560000000000000
          Top = 184.653680000000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo108: TfrxMemoView
          Left = 127.724490000000000000
          Top = 3.779530000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODBCO]')
          ParentFont = False
        end
        object imgLogo2: TfrxPictureView
          Left = 9.000000000000000000
          Top = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Picture.Data = {
            07544269746D6170F6130000424DF61300000000000036040000280000009000
            00001C0000000100080000000000C00F0000C40E0000C40E0000000100000000
            00009C9EFF001010FF00CECFFF0010101000EFEFEF00CECFCE0021202100BDBE
            BD00313031007B7DFF004241FF009C9E9C00BDBEFF006361630052515200DEDF
            DE008C8E8C0073717300ADAEAD008C8EFF006361FF00DEDFFF00ADAEFF007B7D
            7B0042414200000000000000FF00FFFFFF000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00001B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B171717171717171717171B1B1B1B0F171717171717171717171B11041B
            1B1B120D1803180E0B1B1B1B1B1B17171717171717171717171717120F1B1B1B
            1B1B1B1B1B1B1B1B1B1B040B0E081919031810041B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B160909090909090909090909090909090909090909
            09090909021B1B1B1B1B1B1B1B1B1B1B1B1B1B07070E191919190E07071B1B1B
            1B0407070E191919190D07071B180D0510061919191919191906051B1B1B0707
            0D19191919061811180819191918071B1B1B1B1B1B1B1B1B0411191919191919
            19191903171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A001A1A1A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A011301021B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B061919061B1B1B1B1B1B1B1B1B1B04031919081B1B1B1B181919
            19080B041B1B0708191903051B1B1B1B1B061919181B1B1B1B1B051819191911
            1B1B1B1B1B1B1B0703191919030D120504070B0E1908041B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B001A1A1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
            1A01020C1A01021B1B1B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1819190D1B1B1B1B1B1B0408191906041B1B1B
            1B181919181B1B1B1B1B1B1B0E191919101B1B1B1B1B0B1919191911041B1B1B
            1B1B1B1B051808041B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1B1B001A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01021B0C1A1A01021B1B1B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B181918
            1B1B1B1B1B1B1B1B0F1919190B1B1B1B1B181919181B1B1B1B1B1B1B04031919
            031B1B1B1B07191919190B1B1B1B1B1B1B1B1B1B1B1B0D08041B1B1B1B1B1B1B
            1B1B1B1B1B1B1B001A1A1A1A1B1B1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01
            021B1B0C1A1A1A01021B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B18030F1B1B1B1B1B1B1B1B1B0619190E1B1B1B
            1B181919181B1B1B1B1B1B1B1B0D191919071B1B0403191919101B1B1B1B1B1B
            1B1B1B1B1B1B1B0D0D1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1B1B1B1B
            001A1A1A1A1A1A1A1A1A1A1A1A1A01021B1B1B0C1A1A1A1A01021B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B180D1B
            1B1B1B1B1B1B1B1B1B081919181B1B1B1B181919181B1B1B1B1B1B1B1B171919
            190B1B1B17191919181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B0F1B1B1B1B1B1B1B
            1B1B1B1B1B001A1A1A1A1A1A1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A01021B
            1B1B1B0C1A1A1A1A1A01021B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B18071B1B1B1B1B1B1B1B1B04191919181B1B1B
            1B181919181B1B1B1B1B1B1B1B171919190B1B1B06191919121B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1B1B1B1B
            1B1B001A1A1A1A1A1A1A1A1A01021B1B1B1B1B0C1A1A1A1A1A1A01021B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B111B1B
            1B1B1B1B1B1B1B1B0D1919190D1B1B1B1B181919181B1B1B1B1B1B1B1B0E1919
            19051B05191919031B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B001A1A1A1A1A1A1A1A1B1B1B1B1B1B1B001A1A1A1A1A1A1A01021B1B1B
            1B1B1B0C1A1A1A1A1A1A1A01021B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B1B1B040E19191919071B1B1B
            1B181919181B1B1B1B1B1B1B05191919061B1B10191919181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B001A1A1A1A1A01021B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A01021B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B1B
            1B1B1B1B1B120319191919111B1B1B1B1B181919181B1B1B1B1B1B0408191919
            071B1B11191919171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B001A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B001A1A1A01021B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A01021B1B1B1B1B1B1B18191906171717171717
            1717171717061919181B1B1B1B1B1B1B1B1B1B0F1819191919190D1B1B1B1B1B
            1B181919181B1B1B1B1B0B06191903121B1B1B18191919171B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B1B1B001A01021B1B1B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A1A0102
            1B1B1B1B1B1B181919191919191919191919191919191919181B1B1B1B1B1B1B
            1B1B0B0319191919030B1B1B1B1B1B1B1B18191919181818081919190311041B
            1B1B1B18191919171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B15
            1A1A1A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B1B1B14001B1B1B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A1A1A011B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B1B1B040E191919191908051B1B1B1B1B1B1B
            1B18191906171717171819191908051B1B1B1B0D191919171B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B1B1B001A01021B1B1B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A1A1A00
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B05
            061919191919171B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B050619190305
            1B1B1B17191919111B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B001A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B001A1A1A01021B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A1A001B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B05031919191908051B1B1B1B1B1B1B1B1B1B
            1B181919181B1B1B1B1B1B0F031919181B1B1B0B191919181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B001A1A1A1A1A01021B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A001B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B0619
            191919171B1B1B1B1B1B040F1B1B1B1B1B181919181B1B1B1B1B1B1B17191919
            0F1B1B0F19191919041B1B1B1B1B1B1B1B1B1B1B1B1B1B181B1B1B1B1B1B1B1B
            1B1B1B001A1A1A1A1A1A1A1A1B1B1B1B1B1B1B001A1A1A1A1A1A1A01021B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A001B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1219191903051B1B1B1B1B1B1B07171B1B1B1B
            1B181919181B1B1B1B1B1B1B0F191919071B1B1B081919190B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B191B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1B1B1B1B
            1B1B001A1A1A1A1A1A1A1A1A01021B1B1B1B1B0C1A1A1A1A1A1A1A001B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B171919
            19121B1B1B1B1B1B1B1B17171B1B1B1B1B181919181B1B1B1B1B1B1B1B191919
            071B1B1B0B191919081B1B1B1B1B1B1B1B1B1B1B1B1B0B191B1B1B1B1B1B1B1B
            1B1B1B1B1B001A1A1A1A1A1A1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A01021B
            1B1B1B0C1A1A1A1A1A1A001B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B171919031B1B1B1B1B1B1B1B1B06171B1B1B1B
            1B181919181B1B1B1B1B1B1B05191919071B1B1B1B08191919101B1B1B1B1B1B
            1B1B1B1B1B0406191B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1B1B1B1B
            001A1A1A1A1A1A1A1A1A1A1A1A1A01021B1B1B0C1A1A1A1A1A001B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B0B1919
            191B1B1B1B1B1B1B1B0719171B1B1B1B1B181919181B1B1B1B1B1B1B17191906
            1B1B1B1B1B0503191903051B1B1B1B1B1B1B1B1B040819081B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B001A1A1A1A1B1B1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01
            021B1B0C1A1A1A1A001B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B04031919071B1B1B1B1B1B040619171B1B1B1B
            1B181919181B1B1B1B1B1B05191919121B1B1B1B1B1B0503191903101B1B1B1B
            1B1B1B05081919181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1B1B001A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01021B0C1A1A1A001B1B1B1B1B1B1B1B
            1B1B1B1B1B1B081919081B1B1B1B1B1B1B1B1B1B1B061919181B1B1B1B1B1719
            19030B1B1B1B1B05081919171B1B1B1B1B061919181B1B1B1B04170319190B1B
            1B1B1B1B1B1B1B0F081919190610071B0F120D19190619181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B001A1A1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
            1A01020C1A1A001B1B1B1B1B1B1B1B1B1B1B1B1B1B1019191919101B1B1B1B1B
            1B1B1B1B0D19191919101B1B1B1B1B1719191903180D0819061706171B1B1B04
            1119191919081818181919190E051B1B1B1B1B1B1B1B1B1B1B0B061919191919
            191919060B1B05181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A001A1A1A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01131A001B1B1B1B1B1B1B1B1B1B
            1B1B1B181818181818181818181B1B1B1B05181818181818181818181B1B1B1B
            070E031919190E0B1B1B12171B1B17171717171717171717171707041B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B05101718181117051B1B1B1B051B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B000A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A
            0A0A0A0A001B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Line76: TfrxLineView
          Top = 26.456710000000000000
          Width = 718.110236220471900000
          Color = clBlack
          Diagonal = True
        end
        object Line77: TfrxLineView
          Left = 112.606370000000000000
          Top = 26.456710000000000000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line79: TfrxLineView
          Left = 218.433210000000000000
          Top = 26.456710000000000000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo118: TfrxMemoView
          Left = 603.945270000000000000
          Top = 3.779530000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Recibo do Pagador')
          ParentFont = False
        end
        object Line80: TfrxLineView
          Top = 49.133890000000000000
          Width = 576.377952755906000000
          Color = clBlack
          Diagonal = True
        end
        object Line83: TfrxLineView
          Top = 71.811070000000000000
          Width = 576.377952755906000000
          Color = clBlack
          Diagonal = True
        end
        object Line85: TfrxLineView
          Top = 94.488250000000000000
          Width = 576.377952755906000000
          Color = clBlack
          Diagonal = True
        end
        object Line86: TfrxLineView
          Left = 577.488560000000000000
          Top = 302.362400000000000000
          Height = -275.905690000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo131: TfrxMemoView
          Left = 3.000000000000000000
          Top = 26.456710000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Local de Pagamento')
          ParentFont = False
        end
        object Memo137: TfrxMemoView
          Left = 3.000000000000000000
          Top = 35.795300000000000000
          Width = 566.929500000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LOCPAG]')
          ParentFont = False
          WordWrap = False
        end
        object Memo138: TfrxMemoView
          Left = 55.913420000000000000
          Top = 49.133890000000000000
          Width = 514.016080000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCED]')
          ParentFont = False
          WordWrap = False
        end
        object Memo139: TfrxMemoView
          Left = 581.268090000000000000
          Top = 116.622140000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo140: TfrxMemoView
          Left = 581.268090000000000000
          Top = 125.960730000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTAVEN]')
          ParentFont = False
          WordWrap = False
        end
        object Memo141: TfrxMemoView
          Left = 581.268090000000000000
          Top = 139.299320000000000000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia/[CEDENT]')
          ParentFont = False
        end
        object Memo142: TfrxMemoView
          Left = 581.268090000000000000
          Top = 148.637910000000000000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[AGECED]')
          ParentFont = False
          WordWrap = False
        end
        object Memo147: TfrxMemoView
          Left = 581.268090000000000000
          Top = 161.976500000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira/Nosso N'#250'mero')
          ParentFont = False
        end
        object Memo169: TfrxMemoView
          Left = 581.268090000000000000
          Top = 171.315090000000000000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NOSNUM]')
          ParentFont = False
          WordWrap = False
        end
        object Line87: TfrxLineView
          Top = 117.165430000000000000
          Width = 718.110236220471900000
          Color = clBlack
          Diagonal = True
        end
        object Memo179: TfrxMemoView
          Left = 581.268090000000000000
          Top = 184.653680000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor do Documento')
          ParentFont = False
        end
        object Memo192: TfrxMemoView
          Left = 581.268090000000000000
          Top = 193.992270000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[VALDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo195: TfrxMemoView
          Left = 3.000000000000000000
          Top = 71.811070000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Documento')
          ParentFont = False
        end
        object Memo196: TfrxMemoView
          Left = 3.000000000000000000
          Top = 81.149660000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTADOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line88: TfrxLineView
          Left = 131.504020000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo197: TfrxMemoView
          Left = 135.283550000000000000
          Top = 71.811070000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#176' do Documento')
          ParentFont = False
        end
        object Memo198: TfrxMemoView
          Left = 135.283550000000000000
          Top = 81.149660000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NUMDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line89: TfrxLineView
          Left = 267.567100000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo199: TfrxMemoView
          Left = 271.346630000000000000
          Top = 71.811070000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Esp'#233'cie Doc.')
          ParentFont = False
        end
        object Memo208: TfrxMemoView
          Left = 271.346630000000000000
          Top = 81.149660000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESPDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line90: TfrxLineView
          Left = 350.716760000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo243: TfrxMemoView
          Left = 354.496290000000000000
          Top = 71.811070000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aceite')
          ParentFont = False
        end
        object Memo244: TfrxMemoView
          Left = 354.496290000000000000
          Top = 81.149660000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ACEITE]')
          ParentFont = False
          WordWrap = False
        end
        object Line91: TfrxLineView
          Left = 422.527830000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo245: TfrxMemoView
          Left = 426.307360000000000000
          Top = 71.811070000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Processamento')
          ParentFont = False
        end
        object Memo246: TfrxMemoView
          Left = 426.307360000000000000
          Top = 81.149660000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTAPRO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo247: TfrxMemoView
          Left = 3.000000000000000000
          Top = 94.488250000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Uso do Banco')
          ParentFont = False
        end
        object Line92: TfrxLineView
          Left = 239.889920000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo248: TfrxMemoView
          Left = 248.669450000000000000
          Top = 94.488250000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira')
          ParentFont = False
        end
        object Memo249: TfrxMemoView
          Left = 248.669450000000000000
          Top = 103.826840000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CARTEI]')
          ParentFont = False
          WordWrap = False
        end
        object Line93: TfrxLineView
          Left = 337.598640000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo250: TfrxMemoView
          Left = 339.378170000000000000
          Top = 103.826840000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'R$')
          ParentFont = False
          WordWrap = False
        end
        object Line94: TfrxLineView
          Left = 403.630180000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo251: TfrxMemoView
          Left = 407.409710000000000000
          Top = 94.488250000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Memo252: TfrxMemoView
          Left = 407.409710000000000000
          Top = 103.937000550000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
        end
        object Line95: TfrxLineView
          Left = 467.882190000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo253: TfrxMemoView
          Left = 3.000000000000000000
          Top = 132.165430000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST01]')
          ParentFont = False
        end
        object Memo254: TfrxMemoView
          Left = 3.000000000000000000
          Top = 141.504020000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST02]')
          ParentFont = False
        end
        object Memo255: TfrxMemoView
          Left = 3.000000000000000000
          Top = 150.842610000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST03]')
          ParentFont = False
        end
        object Memo256: TfrxMemoView
          Left = 3.000000000000000000
          Top = 160.181200000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST04]')
          ParentFont = False
        end
        object Memo257: TfrxMemoView
          Left = 3.000000000000000000
          Top = 169.519790000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST05]')
          ParentFont = False
        end
        object Memo258: TfrxMemoView
          Left = 3.000000000000000000
          Top = 178.858380000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST06]')
          ParentFont = False
        end
        object Memo259: TfrxMemoView
          Left = 3.000000000000000000
          Top = 188.196970000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST07]')
          ParentFont = False
        end
        object Memo260: TfrxMemoView
          Left = 3.000000000000000000
          Top = 197.535560000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST08]')
          ParentFont = False
        end
        object Line96: TfrxLineView
          Top = 302.362400000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line97: TfrxLineView
          Left = 577.488560000000000000
          Top = 224.228510000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line98: TfrxLineView
          Left = 577.488560000000000000
          Top = 242.126160000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line99: TfrxLineView
          Left = 577.488560000000000000
          Top = 260.803340000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line100: TfrxLineView
          Left = 577.488560000000000000
          Top = 283.921460000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo261: TfrxMemoView
          Left = 581.268090000000000000
          Top = 207.330860000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Desconto/Abatimento')
          ParentFont = False
        end
        object Memo262: TfrxMemoView
          Left = 581.268090000000000000
          Top = 224.228510000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Outras Dedu'#231#245'es')
          ParentFont = False
        end
        object Memo263: TfrxMemoView
          Left = 581.268090000000000000
          Top = 242.126160000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Mora/Multa/Juros')
          ParentFont = False
        end
        object Memo264: TfrxMemoView
          Left = 581.268090000000000000
          Top = 261.023810000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Outros Acr'#233'cimos')
          ParentFont = False
        end
        object Memo265: TfrxMemoView
          Left = 581.268090000000000000
          Top = 283.921460000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor Cobrado')
          ParentFont = False
        end
        object Memo266: TfrxMemoView
          Left = 40.574830000000000000
          Top = 304.921460000000000000
          Width = 411.968770000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMSAC]')
          ParentFont = False
        end
        object Memo267: TfrxMemoView
          Left = 40.574830000000000000
          Top = 329.378170000000000000
          Width = 665.197118900000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDSAC]')
          ParentFont = False
        end
        object Memo268: TfrxMemoView
          Left = 2.999997560000000000
          Top = 341.937230000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Sacador/Avalista:')
          ParentFont = False
        end
        object Memo269: TfrxMemoView
          Left = 460.323130000000000000
          Top = 304.921460000000000000
          Width = 249.448980000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSSAC]')
          ParentFont = False
        end
        object Memo270: TfrxMemoView
          Left = 460.323130000000000000
          Top = 352.937230000000000000
          Width = 249.448980000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[NOSNUM]')
          ParentFont = False
        end
        object Line101: TfrxLineView
          Top = 365.055350000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo271: TfrxMemoView
          Left = 526.575140000000000000
          Top = 365.055350000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Autentica'#231#227'o')
          ParentFont = False
        end
        object Memo272: TfrxMemoView
          Left = 55.913420000000000000
          Top = 60.472480000000000000
          Width = 514.016080000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCED]')
          ParentFont = False
          WordWrap = False
        end
        object Memo273: TfrxMemoView
          Left = 581.268090000000000000
          Top = 271.582870000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[OUTACR]')
          ParentFont = False
          WordWrap = False
        end
        object Memo274: TfrxMemoView
          Left = 339.378170000000000000
          Top = 94.488250000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ESPMOE]')
          ParentFont = False
        end
        object Memo275: TfrxMemoView
          Left = 3.000000000000000000
          Top = 49.133890000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BENEFI]')
          ParentFont = False
        end
        object Memo276: TfrxMemoView
          Left = 3.000000000000000000
          Top = 304.921460000000000000
          Width = 34.015748030000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PAGADO]')
          ParentFont = False
        end
        object Memo277: TfrxMemoView
          Left = 471.661720000000000000
          Top = 94.488250000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALMOE]')
          ParentFont = False
        end
        object Memo278: TfrxMemoView
          Left = 75.566926690000000000
          Top = 341.937230000000000000
          Width = 634.961040000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SACAVA]')
          ParentFont = False
          WordWrap = False
        end
        object rllLinDig2: TfrxMemoView
          Left = 219.771800000000000000
          Top = 3.779530000000000000
          Width = 381.732530000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LINDIG]')
          ParentFont = False
        end
        object Memo280: TfrxMemoView
          Left = 241.110390000000000000
          Top = 105.826840000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CART02]')
          ParentFont = False
          WordWrap = False
        end
        object Memo281: TfrxMemoView
          Left = 75.566926690000000000
          Top = 352.937230000000000000
          Width = 381.732530000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDAVA]')
          ParentFont = False
          WordWrap = False
        end
        object Memo282: TfrxMemoView
          Left = 97.488250000000000000
          Top = 105.826840000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[USOBCO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo283: TfrxMemoView
          Left = 3.000000000000000000
          Top = 117.165430000000000000
          Width = 566.929500000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'INSTRU'#199#213'ES (Instru'#231#245'es de responsabilidade do benefici'#225'rio. Qual' +
              'quer d'#250'vida sobre este boleto, contate o benefici'#225'rio)')
          ParentFont = False
        end
        object Memo284: TfrxMemoView
          Left = 40.574830000000000000
          Top = 317.260050000000000000
          Width = 676.535433070000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDSAC]')
          ParentFont = False
        end
        object Memo285: TfrxMemoView
          Left = 526.575140000000000000
          Top = 350.275820000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo de Baixa')
          ParentFont = False
        end
        object Memo286: TfrxMemoView
          Left = 89.929190000000000000
          Top = 26.456710000000000000
          Width = 480.000310000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LOCEXT]')
          ParentFont = False
          WordWrap = False
        end
        object Line102: TfrxLineView
          Top = 379.953000000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line103: TfrxLineView
          Left = 578.268090000000000000
          Top = 139.842610000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line104: TfrxLineView
          Left = 578.268090000000000000
          Top = 162.519790000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line105: TfrxLineView
          Left = 578.268090000000000000
          Top = 185.196970000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line106: TfrxLineView
          Left = 578.268090000000000000
          Top = 207.874150000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object imgLogoEmpresa: TfrxPictureView
          Left = 582.047620000000000000
          Top = 30.236240000000000000
          Width = 128.504020000000000000
          Height = 75.590600000000000000
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
    end
    object Page3: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 5.000000000000000000
      LargeDesignHeight = True
      object Memo86: TfrxMemoView
        Left = 302.362400000000000000
        Top = 15.118120000000000000
        Width = 68.031540000000000000
        Height = 11.338590000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Memo.UTF8W = (
          'CONTEUDO LAYIMP')
        ParentFont = False
      end
    end
    object sbrFichaCompensacaoQRCodePix: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 5.000000000000000000
      LargeDesignHeight = True
      object rlbFichaCompensacaoQRCodePix: TfrxMasterData
        FillType = ftBrush
        Height = 336.378170000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        DataSet = frxQRCodePix
        DataSetName = 'frxQRCodePix'
        RowCount = 0
        object Memo279: TfrxMemoView
          Left = 578.268090000000000000
          Top = 26.456710000000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo287: TfrxMemoView
          Left = 578.268090000000000000
          Top = 94.488250000000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo288: TfrxMemoView
          Width = 718.110236220000000000
          Height = 272.125935430000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          ParentFont = False
        end
        object Memo289: TfrxMemoView
          Left = 128.504020000000000000
          Top = 1.779530000000000000
          Width = 75.590600000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODBCO]')
          ParentFont = False
        end
        object imgLog5: TfrxPictureView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'imgLog5OnBeforePrint'
          Picture.Data = {
            07544269746D6170F6130000424DF61300000000000036040000280000009000
            00001C0000000100080000000000C00F0000C40E0000C40E0000000100000000
            00009C9EFF001010FF00CECFFF0010101000EFEFEF00CECFCE0021202100BDBE
            BD00313031007B7DFF004241FF009C9E9C00BDBEFF006361630052515200DEDF
            DE008C8E8C0073717300ADAEAD008C8EFF006361FF00DEDFFF00ADAEFF007B7D
            7B0042414200000000000000FF00FFFFFF000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00001B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B171717171717171717171B1B1B1B0F171717171717171717171B11041B
            1B1B120D1803180E0B1B1B1B1B1B17171717171717171717171717120F1B1B1B
            1B1B1B1B1B1B1B1B1B1B040B0E081919031810041B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B160909090909090909090909090909090909090909
            09090909021B1B1B1B1B1B1B1B1B1B1B1B1B1B07070E191919190E07071B1B1B
            1B0407070E191919190D07071B180D0510061919191919191906051B1B1B0707
            0D19191919061811180819191918071B1B1B1B1B1B1B1B1B0411191919191919
            19191903171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A001A1A1A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A011301021B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B061919061B1B1B1B1B1B1B1B1B1B04031919081B1B1B1B181919
            19080B041B1B0708191903051B1B1B1B1B061919181B1B1B1B1B051819191911
            1B1B1B1B1B1B1B0703191919030D120504070B0E1908041B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B001A1A1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
            1A01020C1A01021B1B1B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1819190D1B1B1B1B1B1B0408191906041B1B1B
            1B181919181B1B1B1B1B1B1B0E191919101B1B1B1B1B0B1919191911041B1B1B
            1B1B1B1B051808041B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1B1B001A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01021B0C1A1A01021B1B1B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B181918
            1B1B1B1B1B1B1B1B0F1919190B1B1B1B1B181919181B1B1B1B1B1B1B04031919
            031B1B1B1B07191919190B1B1B1B1B1B1B1B1B1B1B1B0D08041B1B1B1B1B1B1B
            1B1B1B1B1B1B1B001A1A1A1A1B1B1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01
            021B1B0C1A1A1A01021B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B18030F1B1B1B1B1B1B1B1B1B0619190E1B1B1B
            1B181919181B1B1B1B1B1B1B1B0D191919071B1B0403191919101B1B1B1B1B1B
            1B1B1B1B1B1B1B0D0D1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1B1B1B1B
            001A1A1A1A1A1A1A1A1A1A1A1A1A01021B1B1B0C1A1A1A1A01021B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B180D1B
            1B1B1B1B1B1B1B1B1B081919181B1B1B1B181919181B1B1B1B1B1B1B1B171919
            190B1B1B17191919181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B0F1B1B1B1B1B1B1B
            1B1B1B1B1B001A1A1A1A1A1A1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A01021B
            1B1B1B0C1A1A1A1A1A01021B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B18071B1B1B1B1B1B1B1B1B04191919181B1B1B
            1B181919181B1B1B1B1B1B1B1B171919190B1B1B06191919121B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1B1B1B1B
            1B1B001A1A1A1A1A1A1A1A1A01021B1B1B1B1B0C1A1A1A1A1A1A01021B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B111B1B
            1B1B1B1B1B1B1B1B0D1919190D1B1B1B1B181919181B1B1B1B1B1B1B1B0E1919
            19051B05191919031B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B001A1A1A1A1A1A1A1A1B1B1B1B1B1B1B001A1A1A1A1A1A1A01021B1B1B
            1B1B1B0C1A1A1A1A1A1A1A01021B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B1B1B040E19191919071B1B1B
            1B181919181B1B1B1B1B1B1B05191919061B1B10191919181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B001A1A1A1A1A01021B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A01021B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B1B
            1B1B1B1B1B120319191919111B1B1B1B1B181919181B1B1B1B1B1B0408191919
            071B1B11191919171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B001A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B001A1A1A01021B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A01021B1B1B1B1B1B1B18191906171717171717
            1717171717061919181B1B1B1B1B1B1B1B1B1B0F1819191919190D1B1B1B1B1B
            1B181919181B1B1B1B1B0B06191903121B1B1B18191919171B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B1B1B001A01021B1B1B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A1A0102
            1B1B1B1B1B1B181919191919191919191919191919191919181B1B1B1B1B1B1B
            1B1B0B0319191919030B1B1B1B1B1B1B1B18191919181818081919190311041B
            1B1B1B18191919171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B15
            1A1A1A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B1B1B14001B1B1B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A1A1A011B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B1B1B040E191919191908051B1B1B1B1B1B1B
            1B18191906171717171819191908051B1B1B1B0D191919171B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B1B1B001A01021B1B1B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A1A1A00
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B05
            061919191919171B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B050619190305
            1B1B1B17191919111B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B001A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B001A1A1A01021B1B1B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A1A1A001B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1B05031919191908051B1B1B1B1B1B1B1B1B1B
            1B181919181B1B1B1B1B1B0F031919181B1B1B0B191919181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1B1B1B1B
            1B1B1B1B001A1A1A1A1A01021B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A001B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B0619
            191919171B1B1B1B1B1B040F1B1B1B1B1B181919181B1B1B1B1B1B1B17191919
            0F1B1B0F19191919041B1B1B1B1B1B1B1B1B1B1B1B1B1B181B1B1B1B1B1B1B1B
            1B1B1B001A1A1A1A1A1A1A1A1B1B1B1B1B1B1B001A1A1A1A1A1A1A01021B1B1B
            1B1B1B0C1A1A1A1A1A1A1A1A001B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B1219191903051B1B1B1B1B1B1B07171B1B1B1B
            1B181919181B1B1B1B1B1B1B0F191919071B1B1B081919190B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B191B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1B1B1B1B
            1B1B001A1A1A1A1A1A1A1A1A01021B1B1B1B1B0C1A1A1A1A1A1A1A001B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B171919
            19121B1B1B1B1B1B1B1B17171B1B1B1B1B181919181B1B1B1B1B1B1B1B191919
            071B1B1B0B191919081B1B1B1B1B1B1B1B1B1B1B1B1B0B191B1B1B1B1B1B1B1B
            1B1B1B1B1B001A1A1A1A1A1A1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A01021B
            1B1B1B0C1A1A1A1A1A1A001B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B171919031B1B1B1B1B1B1B1B1B06171B1B1B1B
            1B181919181B1B1B1B1B1B1B05191919071B1B1B1B08191919101B1B1B1B1B1B
            1B1B1B1B1B0406191B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1B1B1B1B
            001A1A1A1A1A1A1A1A1A1A1A1A1A01021B1B1B0C1A1A1A1A1A001B1B1B1B1B1B
            1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B0B1919
            191B1B1B1B1B1B1B1B0719171B1B1B1B1B181919181B1B1B1B1B1B1B17191906
            1B1B1B1B1B0503191903051B1B1B1B1B1B1B1B1B040819081B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B001A1A1A1A1B1B1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01
            021B1B0C1A1A1A1A001B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
            1B1B1B1B1B181919181B1B1B1B04031919071B1B1B1B1B1B040619171B1B1B1B
            1B181919181B1B1B1B1B1B05191919121B1B1B1B1B1B0503191903101B1B1B1B
            1B1B1B05081919181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1B1B001A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01021B0C1A1A1A001B1B1B1B1B1B1B1B
            1B1B1B1B1B1B081919081B1B1B1B1B1B1B1B1B1B1B061919181B1B1B1B1B1719
            19030B1B1B1B1B05081919171B1B1B1B1B061919181B1B1B1B04170319190B1B
            1B1B1B1B1B1B1B0F081919190610071B0F120D19190619181B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B001A1A1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
            1A01020C1A1A001B1B1B1B1B1B1B1B1B1B1B1B1B1B1019191919101B1B1B1B1B
            1B1B1B1B0D19191919101B1B1B1B1B1719191903180D0819061706171B1B1B04
            1119191919081818181919190E051B1B1B1B1B1B1B1B1B1B1B0B061919191919
            191919060B1B05181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A001A1A1A
            1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01131A001B1B1B1B1B1B1B1B1B1B
            1B1B1B181818181818181818181B1B1B1B05181818181818181818181B1B1B1B
            070E031919190E0B1B1B12171B1B17171717171717171717171707041B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B05101718181117051B1B1B1B051B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B000A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A
            0A0A0A0A001B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
            1B1B}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Line107: TfrxLineView
          Top = 26.456710000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line108: TfrxLineView
          Left = 113.385900000000000000
          Top = 26.456710000000000000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line109: TfrxLineView
          Left = 219.212740000000000000
          Top = 26.456710000000000000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo290: TfrxMemoView
          Left = 220.551330000000000000
          Top = 3.779530000000000000
          Width = 381.732530000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LINDIG]')
          ParentFont = False
        end
        object Line110: TfrxLineView
          Top = 49.133890000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line111: TfrxLineView
          Top = 71.811070000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line112: TfrxLineView
          Top = 94.488250000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line113: TfrxLineView
          Left = 578.268090000000000000
          Top = 211.653680000000000000
          Height = -185.196970000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo291: TfrxMemoView
          Left = 3.779530000000000000
          Top = 26.456710000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Local de Pagamento')
          ParentFont = False
        end
        object Memo292: TfrxMemoView
          Left = 3.779530000000000000
          Top = 35.795300000000000000
          Width = 566.929500000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LOCPAG]')
          ParentFont = False
          WordWrap = False
        end
        object Memo293: TfrxMemoView
          Left = 56.692950000000000000
          Top = 49.133890000000000000
          Width = 514.016080000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCED]')
          ParentFont = False
          WordWrap = False
        end
        object Memo294: TfrxMemoView
          Left = 582.047620000000000000
          Top = 26.456710000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo295: TfrxMemoView
          Left = 582.047620000000000000
          Top = 35.795300000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTAVEN]')
          ParentFont = False
          WordWrap = False
        end
        object Memo296: TfrxMemoView
          Left = 582.047620000000000000
          Top = 49.133890000000000000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia/[CEDENT]')
          ParentFont = False
        end
        object Memo297: TfrxMemoView
          Left = 582.047620000000000000
          Top = 58.472480000000000000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[AGECED]')
          ParentFont = False
          WordWrap = False
        end
        object Memo298: TfrxMemoView
          Left = 582.047620000000000000
          Top = 71.811070000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira/Nosso N'#250'mero')
          ParentFont = False
        end
        object Memo299: TfrxMemoView
          Left = 582.047620000000000000
          Top = 81.149660000000000000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NOSNUM]')
          ParentFont = False
          WordWrap = False
        end
        object Line114: TfrxLineView
          Top = 117.165430000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo300: TfrxMemoView
          Left = 582.047620000000000000
          Top = 94.488250000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor do Documento')
          ParentFont = False
        end
        object Memo301: TfrxMemoView
          Left = 582.047620000000000000
          Top = 103.826840000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[VALDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo302: TfrxMemoView
          Left = 3.779530000000000000
          Top = 71.811070000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Documento')
          ParentFont = False
        end
        object Memo303: TfrxMemoView
          Left = 3.779530000000000000
          Top = 81.149660000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTADOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line115: TfrxLineView
          Left = 132.283550000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo304: TfrxMemoView
          Left = 136.063080000000000000
          Top = 71.811070000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#176' do Documento')
          ParentFont = False
        end
        object Memo305: TfrxMemoView
          Left = 136.063080000000000000
          Top = 81.149660000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NUMDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line116: TfrxLineView
          Left = 268.346630000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo306: TfrxMemoView
          Left = 272.126160000000000000
          Top = 71.811070000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Esp'#233'cie Doc.')
          ParentFont = False
        end
        object Memo307: TfrxMemoView
          Left = 272.126160000000000000
          Top = 81.149660000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESPDOC]')
          ParentFont = False
          WordWrap = False
        end
        object Line117: TfrxLineView
          Left = 351.496290000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo308: TfrxMemoView
          Left = 355.275820000000000000
          Top = 71.811070000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aceite')
          ParentFont = False
        end
        object Memo309: TfrxMemoView
          Left = 355.275820000000000000
          Top = 81.149660000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ACEITE]')
          ParentFont = False
          WordWrap = False
        end
        object Line118: TfrxLineView
          Left = 423.307360000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo310: TfrxMemoView
          Left = 427.086890000000000000
          Top = 71.811070000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Processamento')
          ParentFont = False
        end
        object Memo311: TfrxMemoView
          Left = 427.086890000000000000
          Top = 81.149660000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTAPRO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo312: TfrxMemoView
          Left = 3.779530000000000000
          Top = 94.488250000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Uso do Banco')
          ParentFont = False
        end
        object Line119: TfrxLineView
          Left = 240.669450000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo313: TfrxMemoView
          Left = 249.448980000000000000
          Top = 94.488250000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira')
          ParentFont = False
        end
        object Memo314: TfrxMemoView
          Left = 249.448980000000000000
          Top = 103.826840000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CARTEI]')
          ParentFont = False
          WordWrap = False
        end
        object Line120: TfrxLineView
          Left = 338.378170000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo315: TfrxMemoView
          Left = 340.157700000000000000
          Top = 103.826840000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'R$')
          ParentFont = False
          WordWrap = False
        end
        object Line121: TfrxLineView
          Left = 404.409710000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo316: TfrxMemoView
          Left = 408.189240000000000000
          Top = 94.488250000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Memo317: TfrxMemoView
          Left = 408.189240000000000000
          Top = 103.937000550000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
        end
        object Line122: TfrxLineView
          Left = 468.661720000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo318: TfrxMemoView
          Left = 3.779530000000000000
          Top = 131.165430000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST01]')
          ParentFont = False
        end
        object Memo319: TfrxMemoView
          Left = 3.779530000000000000
          Top = 140.504020000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST02]')
          ParentFont = False
        end
        object Memo320: TfrxMemoView
          Left = 3.779530000000000000
          Top = 149.842610000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST03]')
          ParentFont = False
        end
        object Memo321: TfrxMemoView
          Left = 3.779530000000000000
          Top = 159.181200000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST04]')
          ParentFont = False
        end
        object Memo322: TfrxMemoView
          Left = 3.779530000000000000
          Top = 168.519790000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST05]')
          ParentFont = False
        end
        object Memo323: TfrxMemoView
          Left = 3.779530000000000000
          Top = 177.858380000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST06]')
          ParentFont = False
        end
        object Memo324: TfrxMemoView
          Left = 3.779530000000000000
          Top = 187.196970000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST07]')
          ParentFont = False
        end
        object Memo325: TfrxMemoView
          Left = 3.779530000000000000
          Top = 197.535560000000000000
          Width = 566.929500000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INST08]')
          ParentFont = False
        end
        object Line123: TfrxLineView
          Top = 211.653680000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line124: TfrxLineView
          Left = 578.268090000000000000
          Top = 136.063080000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line125: TfrxLineView
          Left = 578.268090000000000000
          Top = 152.960730000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line126: TfrxLineView
          Left = 578.268090000000000000
          Top = 171.637910000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line127: TfrxLineView
          Left = 578.268090000000000000
          Top = 194.756030000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo326: TfrxMemoView
          Left = 582.047620000000000000
          Top = 117.165430000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Desconto/Abatimento')
          ParentFont = False
        end
        object Memo327: TfrxMemoView
          Left = 582.047620000000000000
          Top = 136.063080000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Outras Dedu'#231#245'es')
          ParentFont = False
        end
        object Memo328: TfrxMemoView
          Left = 582.047620000000000000
          Top = 152.960730000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Mora/Multa/Juros')
          ParentFont = False
        end
        object Memo329: TfrxMemoView
          Left = 582.047620000000000000
          Top = 171.858380000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Outros Acr'#233'cimos')
          ParentFont = False
        end
        object Memo330: TfrxMemoView
          Left = 582.047620000000000000
          Top = 194.756030000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor Cobrado')
          ParentFont = False
        end
        object Memo331: TfrxMemoView
          Left = 41.354360000000000000
          Top = 212.653680000000000000
          Width = 411.968770000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMSAC]')
          ParentFont = False
        end
        object Memo332: TfrxMemoView
          Left = 41.354360000000000000
          Top = 236.110390000000000000
          Width = 532.913568900000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDSAC]')
          ParentFont = False
        end
        object Memo333: TfrxMemoView
          Left = 3.779527560000000000
          Top = 247.669450000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Sacador/Avalista:')
          ParentFont = False
        end
        object Memo334: TfrxMemoView
          Left = 461.102660000000000000
          Top = 212.653680000000000000
          Width = 113.385900000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSSAC]')
          ParentFont = False
        end
        object Memo335: TfrxMemoView
          Left = 461.102660000000000000
          Top = 259.669450000000000000
          Width = 113.385900000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[NOSNUM]')
          ParentFont = False
        end
        object Memo336: TfrxMemoView
          Left = 490.472790000000000000
          Top = 284.126160000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Autentica'#231#227'o mec'#226'nica ')
          ParentFont = False
        end
        object BarCode1: TfrxBarCodeView
          Left = 5.669291340000000000
          Top = 283.126160000000000000
          Width = 474.000000000000000000
          Height = 49.133858270000000000
          BarType = bcCode_2_5_interleaved
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '12345678901234567890123456789012345678901234'
          WideBarRatio = 1.000000000000000000
          Zoom = 1.500000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object Memo337: TfrxMemoView
          Left = 487.897960000000000000
          Top = 313.362400000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ficha de Compensa'#231#227'o')
          ParentFont = False
        end
        object Memo338: TfrxMemoView
          Left = 56.692920710000000000
          Top = 60.472480000000000000
          Width = 514.016080000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCED]')
          ParentFont = False
          WordWrap = False
        end
        object Memo339: TfrxMemoView
          Left = 582.047620000000000000
          Top = 182.417440000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[OUTACR]')
          ParentFont = False
          WordWrap = False
        end
        object Memo340: TfrxMemoView
          Left = 340.157700000000000000
          Top = 94.488250000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ESPMOE]')
          ParentFont = False
        end
        object Memo341: TfrxMemoView
          Left = 3.779530000000000000
          Top = 49.133890000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BENEFI]')
          ParentFont = False
        end
        object Memo342: TfrxMemoView
          Left = 3.779530000000000000
          Top = 212.653680000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PAGADO]')
          ParentFont = False
        end
        object Memo343: TfrxMemoView
          Left = 76.346456690000000000
          Top = 247.669450000000000000
          Width = 377.953000000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SACAVA]')
          ParentFont = False
          WordWrap = False
        end
        object Memo344: TfrxMemoView
          Left = 241.889920000000000000
          Top = 105.826840000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CART02]')
          ParentFont = False
          WordWrap = False
        end
        object Memo345: TfrxMemoView
          Left = 76.346456690000000000
          Top = 259.669450000000000000
          Width = 381.732530000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDAVA]')
          ParentFont = False
          WordWrap = False
        end
        object Memo346: TfrxMemoView
          Left = 98.267780000000000000
          Top = 105.826840000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[USOBCO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo348: TfrxMemoView
          Left = 3.779530000000000000
          Top = 118.165430000000000000
          Width = 566.929500000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'INSTRU'#199#213'ES (Instru'#231#245'es de responsabilidade do benefici'#225'rio. Qual' +
              'quer d'#250'vida sobre este boleto, contate o benefici'#225'rio)')
          ParentFont = False
        end
        object Memo349: TfrxMemoView
          Left = 41.354360000000000000
          Top = 224.992270000000000000
          Width = 532.913730000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDSAC]')
          ParentFont = False
        end
        object Memo350: TfrxMemoView
          Left = 462.102660000000000000
          Top = 247.669450000000000000
          Width = 113.385900000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo de Baixa')
          ParentFont = False
        end
        object Memo351: TfrxMemoView
          Left = 90.708720000000000000
          Top = 26.456710000000000000
          Width = 480.000310000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LOCEXT]')
          ParentFont = False
          WordWrap = False
        end
        object Memo352: TfrxMemoView
          Left = 472.441250000000000000
          Top = 94.488250000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALMOE]')
          ParentFont = False
        end
        object Shape10: TfrxShapeView
          Left = 578.268090000000000000
          Top = 211.653680000000000000
          Width = 139.842610000000000000
          Height = 124.724490000000000000
          Fill.BackColor = clWhite
          Frame.ShadowWidth = 4.500000000000000000
          Frame.LeftLine.Width = 1.500000000000000000
        end
        object barQRCodePixProd: TfrxBarcode2DView
          Left = 595.945270000000000000
          Top = 222.080520000000000000
          Width = 95.400000000000000000
          Height = 95.400000000000000000
          Restrictions = [rfDontSize]
          StretchMode = smActualHeight
          BarType = bcCodeQR
          BarProperties.Encoding = qrAuto
          BarProperties.QuietZone = 0
          BarProperties.ErrorLevels = ecL
          BarProperties.PixelSize = 2
          BarProperties.CodePage = 0
          DataField = 'QRCODEPIX'
          DataSet = frxQRCodePix
          DataSetName = 'frxQRCodePix'
          Rotation = 0
          ShowText = False
          Text = 
            '00020101021226900014br.gov.bcb.pix2568qrcodepix.bb.com.br/pix/v2' +
            '/cobv/d75e3236-eeeb-4e95-89d0-25e936e79b3d5204000053039865406100' +
            '.005802BR5925REZENDE MATERIAIS PARA CO6013NOVA FRIBURGO62070503*' +
            '**63044574'
          Zoom = 1.000000000000000000
          FontScaled = True
          QuietZone = 0
        end
      end
    end
  end
  object frxBarCodeObject: TfrxBarCodeObject
    Left = 96
    Top = 8
  end
  object frxPDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbeddedFonts = True
    PrintOptimized = True
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 300
    Transparency = False
    Author = 'Citel Software'
    Subject = 'FastReport PDF export'
    Creator = 'Citel Software'
    ProtectionFlags = [eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = True
    Left = 184
    Top = 8
  end
  object frxAgrupamento: TfrxDBDataset
    UserName = 'frxAgrupamento'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 272
    Top = 8
  end
  object frxBoletoCarne: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43735.688096388900000000
    ReportOptions.LastChange = 43738.710460474500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure barCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  barcodigo.Text := <dsBoletoCarne."CodigoDeBarras">;    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 30
    Top = 80
    Datasets = <
      item
        DataSet = dsBoletoCarne
        DataSetName = 'dsBoletoCarne'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 339.937230000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        DataSet = dsBoletoCarne
        DataSetName = 'dsBoletoCarne'
        RowCount = 0
        object Memo162: TfrxMemoView
          Left = 578.268090000000000000
          Top = 26.456710000000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo161: TfrxMemoView
          Left = 578.268090000000000000
          Top = 94.488250000000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo163: TfrxMemoView
          Left = 309.921460000000000000
          Top = 1.779530000000001000
          Width = 75.590600000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoletoCarne."CodigoBanco"]')
          ParentFont = False
        end
        object imgLog: TfrxPictureView
          Left = 185.196970000000000000
          Top = 3.779530000000001000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Line55: TfrxLineView
          Left = 177.637783070000000000
          Top = 26.456710000000000000
          Width = 540.472790000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line56: TfrxLineView
          Left = 294.803340000000000000
          Top = 26.456710000000000000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line57: TfrxLineView
          Left = 400.630180000000000000
          Top = 26.456710000000000000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo164: TfrxMemoView
          Left = 405.748300000000000000
          Top = 3.779530000000001000
          Width = 306.141930000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoletoCarne."LinhaDigitavel"]')
          ParentFont = False
        end
        object Line58: TfrxLineView
          Left = 177.637795280000000000
          Top = 49.133889999999990000
          Width = 540.472440940000000000
          Color = clBlack
          Diagonal = True
        end
        object Line59: TfrxLineView
          Left = 177.637795280000000000
          Top = 71.811070000000000000
          Width = 540.472440940000000000
          Color = clBlack
          Diagonal = True
        end
        object Line60: TfrxLineView
          Left = 177.637795280000000000
          Top = 94.488250000000000000
          Width = 540.472440940000000000
          Color = clBlack
          Diagonal = True
        end
        object Line61: TfrxLineView
          Left = 584.268090000000000000
          Top = 211.653680000000000000
          Height = -185.196970000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo165: TfrxMemoView
          Left = 178.417440000000000000
          Top = 26.456710000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Local de Pagamento')
          ParentFont = False
        end
        object Memo166: TfrxMemoView
          Left = 175.748031500000000000
          Top = 35.795300000000000000
          Width = 408.189240000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoletoCarne."LocalPagamento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo168: TfrxMemoView
          Left = 233.330860000000000000
          Top = 49.133890000000000000
          Width = 347.716760000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."NomeCedente"]')
          ParentFont = False
          WordWrap = False
        end
        object lblVencimentoFicha: TfrxMemoView
          Left = 586.047620000000000000
          Top = 26.456710000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo170: TfrxMemoView
          Left = 586.047620000000000000
          Top = 35.795300000000000000
          Width = 128.504020000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoletoCarne."DataVencimento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo171: TfrxMemoView
          Left = 586.047620000000000000
          Top = 49.133890000000010000
          Width = 128.504020000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia/[dsBoletoCarne."Cedente"]')
          ParentFont = False
        end
        object Memo172: TfrxMemoView
          Left = 586.047620000000000000
          Top = 58.472479999999990000
          Width = 128.504020000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoletoCarne."AgenciaCedente"]')
          ParentFont = False
          WordWrap = False
        end
        object rllNN3: TfrxMemoView
          Left = 586.047620000000000000
          Top = 71.811070000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira/Nosso N'#250'mero')
          ParentFont = False
        end
        object Memo174: TfrxMemoView
          Left = 586.047620000000000000
          Top = 81.149660000000000000
          Width = 128.504020000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoletoCarne."NossoNumero"]')
          ParentFont = False
          WordWrap = False
        end
        object Line62: TfrxLineView
          Left = 177.637795280000000000
          Top = 117.165430000000000000
          Width = 540.472440939999900000
          Color = clBlack
          Diagonal = True
        end
        object Memo175: TfrxMemoView
          Left = 586.047620000000000000
          Top = 94.488250000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor do Documento')
          ParentFont = False
        end
        object Memo176: TfrxMemoView
          Left = 586.047620000000000000
          Top = 103.826840000000000000
          Width = 128.504020000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoletoCarne."ValorDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo177: TfrxMemoView
          Left = 179.417440000000000000
          Top = 71.811070000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Documento')
          ParentFont = False
        end
        object Memo178: TfrxMemoView
          Left = 179.417440000000000000
          Top = 81.149660000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoletoCarne."DataDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Line63: TfrxLineView
          Left = 264.567100000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object lblNumDocumentoFicha: TfrxMemoView
          Left = 268.346630000000000000
          Top = 71.811070000000000000
          Width = 113.385900000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#176' do Documento')
          ParentFont = False
        end
        object Memo180: TfrxMemoView
          Left = 268.346630000000000000
          Top = 81.149660000000000000
          Width = 113.385900000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoletoCarne."NumeroDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Line64: TfrxLineView
          Left = 385.512060000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo181: TfrxMemoView
          Left = 388.512060000000000000
          Top = 71.811023622047220000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Esp'#233'cie Doc.')
          ParentFont = False
        end
        object Memo182: TfrxMemoView
          Left = 388.512060000000000000
          Top = 81.929190000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoletoCarne."EspecieDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Line65: TfrxLineView
          Left = 443.645950000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo183: TfrxMemoView
          Left = 446.205010000000000000
          Top = 71.811070000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aceite')
          ParentFont = False
        end
        object Memo184: TfrxMemoView
          Left = 446.205010000000000000
          Top = 81.149660000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoletoCarne."Aceite"]')
          ParentFont = False
          WordWrap = False
        end
        object Line66: TfrxLineView
          Left = 476.220780000000000000
          Top = 94.488250000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo185: TfrxMemoView
          Left = 479.220780000000000000
          Top = 71.811070000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Processamento')
          ParentFont = False
        end
        object Memo186: TfrxMemoView
          Left = 483.779840000000000000
          Top = 81.149660000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoletoCarne."DataProcessamento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo187: TfrxMemoView
          Left = 179.417440000000000000
          Top = 94.488250000000000000
          Width = 56.692950000000010000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Uso do Banco')
          ParentFont = False
        end
        object Line67: TfrxLineView
          Left = 240.669450000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo188: TfrxMemoView
          Left = 249.448980000000000000
          Top = 94.488250000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira')
          ParentFont = False
        end
        object Memo189: TfrxMemoView
          Left = 249.448980000000000000
          Top = 103.826840000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoletoCarne."Carteira"]')
          ParentFont = False
          WordWrap = False
        end
        object Line68: TfrxLineView
          Left = 338.378170000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo191: TfrxMemoView
          Left = 340.157700000000000000
          Top = 103.826840000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'R$')
          ParentFont = False
          WordWrap = False
        end
        object Line69: TfrxLineView
          Left = 404.409710000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object MemQtd3: TfrxMemoView
          Left = 408.189240000000000000
          Top = 94.488250000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Memo193: TfrxMemoView
          Left = 408.189240000000000000
          Top = 103.937000550000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
        end
        object Line70: TfrxLineView
          Left = 468.661720000000000000
          Top = 117.165430000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object lblInst1Cp: TfrxMemoView
          Left = 179.417322830000000000
          Top = 131.165430000000000000
          Width = 396.850405910000100000
          Height = 9.448818899999999000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."Instrucao1"]')
          ParentFont = False
        end
        object lblInst2Cp: TfrxMemoView
          Left = 179.417322830000000000
          Top = 140.504020000000000000
          Width = 396.850405910000100000
          Height = 9.448818899999999000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."Instrucao2"]')
          ParentFont = False
        end
        object lblInst3Cp: TfrxMemoView
          Left = 179.417322830000000000
          Top = 149.842610000000000000
          Width = 396.850405910000100000
          Height = 9.448818899999999000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."Instrucao3"]')
          ParentFont = False
        end
        object lblInst4Cp: TfrxMemoView
          Left = 179.417322830000000000
          Top = 159.181200000000000000
          Width = 396.850405910000100000
          Height = 9.448818899999999000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."Instrucao4"]')
          ParentFont = False
        end
        object lblInst5Cp: TfrxMemoView
          Left = 179.417322830000000000
          Top = 168.519790000000000000
          Width = 396.850405910000100000
          Height = 9.448818899999999000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."Instrucao5"]')
          ParentFont = False
        end
        object lblInst6Cp: TfrxMemoView
          Left = 179.417322830000000000
          Top = 177.858380000000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."Instrucao6"]')
          ParentFont = False
        end
        object lblInst7Cp: TfrxMemoView
          Left = 179.417322830000000000
          Top = 187.196970000000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."Instrucao7"]')
          ParentFont = False
        end
        object lblInst8Cp: TfrxMemoView
          Left = 179.417322830000000000
          Top = 197.535560000000000000
          Width = 396.850405910000100000
          Height = 9.448818899999999000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."Instrucao8"]')
          ParentFont = False
        end
        object Line71: TfrxLineView
          Left = 177.637795280000000000
          Top = 211.653680000000000000
          Width = 540.472440939999900000
          Color = clBlack
          Diagonal = True
        end
        object Line72: TfrxLineView
          Left = 584.268090000000000000
          Top = 136.063080000000000000
          Width = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line73: TfrxLineView
          Left = 584.268090000000000000
          Top = 152.960730000000000000
          Width = 134.173228346456700000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line74: TfrxLineView
          Left = 584.268090000000000000
          Top = 171.637910000000000000
          Width = 134.173228346456700000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line75: TfrxLineView
          Left = 584.314960630000000000
          Top = 194.756030000000000000
          Width = 134.173228346456700000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo206: TfrxMemoView
          Left = 586.047620000000000000
          Top = 117.165430000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Desconto/Abatimento')
          ParentFont = False
        end
        object Memo207: TfrxMemoView
          Left = 586.047620000000000000
          Top = 136.063080000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Outras Dedu'#231#245'es')
          ParentFont = False
        end
        object lblMoraMultaJurosFicha: TfrxMemoView
          Left = 586.047620000000000000
          Top = 152.960730000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Mora/Multa/Juros')
          ParentFont = False
        end
        object Memo209: TfrxMemoView
          Left = 586.047620000000000000
          Top = 171.858380000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Outros Acr'#233'cimos')
          ParentFont = False
        end
        object Memo210: TfrxMemoView
          Left = 586.047620000000000000
          Top = 194.756030000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor Cobrado')
          ParentFont = False
        end
        object Memo212: TfrxMemoView
          Left = 218.992270000000000000
          Top = 212.653680000000000000
          Width = 238.110390000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."NomeSacador"]')
          ParentFont = False
        end
        object Memo214: TfrxMemoView
          Left = 179.196970000000000000
          Top = 236.110390000000000000
          Width = 529.134038899999900000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."CidadeSacador"]')
          ParentFont = False
        end
        object Memo215: TfrxMemoView
          Left = 179.417437560000000000
          Top = 247.669450000000000000
          Width = 68.031540000000010000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Sacador/Avalista:')
          ParentFont = False
        end
        object Memo216: TfrxMemoView
          Left = 461.102660000000000000
          Top = 212.653680000000000000
          Width = 249.448980000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."INSSAC"]')
          ParentFont = False
        end
        object Memo217: TfrxMemoView
          Left = 597.165740000000000000
          Top = 259.669450000000000000
          Width = 113.385900000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoletoCarne."NossoNumero"]')
          ParentFont = False
        end
        object lblAutentMec: TfrxMemoView
          Left = 527.268090000000000000
          Top = 272.787570000000000000
          Width = 177.637910000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Autentica'#231#227'o mec'#226'nica /')
          ParentFont = False
        end
        object barCodigo: TfrxBarCodeView
          Left = 183.307201340000000000
          Top = 288.685220000000000000
          Width = 270.000000000000000000
          Height = 41.574798270000000000
          OnBeforePrint = 'barCodigoOnBeforePrint'
          BarType = bcCode_2_5_interleaved
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '[dsBoletoCarne."CodigoDeBarras"]'
          WideBarRatio = 1.000000000000000000
          Zoom = 1.500000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object lblFichaComp2: TfrxMemoView
          Left = 617.622450000000000000
          Top = 272.787570000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ficha de Compensa'#231#227'o')
          ParentFont = False
        end
        object Memo144: TfrxMemoView
          Left = 178.315060710000000000
          Top = 60.472480000000000000
          Width = 404.409710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."EnderecoCedente"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo112: TfrxMemoView
          Left = 586.047620000000000000
          Top = 182.417440000000000000
          Width = 128.504020000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoletoCarne."OutrosAcrescimos"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo173: TfrxMemoView
          Left = 340.157700000000000000
          Top = 94.488250000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."EspecieMoeda"]')
          ParentFont = False
        end
        object Memo167: TfrxMemoView
          Left = 178.417440000000000000
          Top = 49.133890000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."Beneficiario"]')
          ParentFont = False
        end
        object Memo190: TfrxMemoView
          Left = 179.417440000000000000
          Top = 212.653680000000000000
          Width = 34.015770000000010000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."Pagador"]')
          ParentFont = False
        end
        object Memo194: TfrxMemoView
          Left = 472.441250000000000000
          Top = 94.488250000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."ValorDaMoeda"]')
          ParentFont = False
        end
        object Memo211: TfrxMemoView
          Left = 253.984366690000000000
          Top = 247.669450000000000000
          Width = 457.323130000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."SacadorAvalista"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo222: TfrxMemoView
          Left = 241.889920000000000000
          Top = 104.826840000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoletoCarne."Carteira2"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo224: TfrxMemoView
          Left = 180.173296690000000000
          Top = 259.669450000000000000
          Width = 336.378170000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."EnderecoAvalista"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo227: TfrxMemoView
          Left = 179.417440000000000000
          Top = 105.826840000000000000
          Width = 56.692950000000010000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoletoCarne."UsoDoBanco"]')
          ParentFont = False
          WordWrap = False
        end
        object lblFichaComp: TfrxMemoView
          Left = 617.622450000000000000
          Top = 212.653680000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ficha de Compensa'#231#227'o')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 179.417322830000000000
          Top = 119.165430000000000000
          Width = 396.850405910000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'INSTRU'#199#213'ES (Instru'#231#245'es de responsabilidade do benefici'#225'rio. Qual' +
              'quer d'#250'vida sobre este boleto, contate o benefici'#225'rio)')
          ParentFont = False
        end
        object Memo213: TfrxMemoView
          Left = 179.196970000000000000
          Top = 224.992270000000000000
          Width = 529.134199999999900000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."EnderecoSacador"]')
          ParentFont = False
        end
        object lblCodBaixaFicha: TfrxMemoView
          Left = 527.354670000000100000
          Top = 260.787570000000000000
          Width = 68.031540000000010000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo de Baixa')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 259.346630000000000000
          Top = 26.456710000000000000
          Width = 321.260050000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoletoCarne."LocalExtensao"]')
          ParentFont = False
          WordWrap = False
        end
        object imgLog2: TfrxPictureView
          Left = 11.338590000000000000
          Top = 3.779530000000001000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Line1: TfrxLineView
          Left = 3.779530000000000000
          Top = 26.456710000000000000
          Width = 170.078850000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line2: TfrxLineView
          Left = 3.779530000000000000
          Top = 49.133889999999990000
          Width = 170.078850000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line3: TfrxLineView
          Left = 3.779530000000000000
          Top = 71.811070000000000000
          Width = 170.078850000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line4: TfrxLineView
          Left = 3.779530000000000000
          Top = 94.488250000000000000
          Width = 170.078850000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line5: TfrxLineView
          Left = 3.779530000000000000
          Top = 117.165430000000000000
          Width = 170.078850000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line9: TfrxLineView
          Left = 3.779530000000000000
          Top = 211.653680000000000000
          Width = 170.078850000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line10: TfrxLineView
          Left = 3.779530000000000000
          Top = 272.126160000000000000
          Width = 170.078850000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line6: TfrxLineView
          Left = 3.779530000000000000
          Top = 136.062992130000000000
          Width = 170.078850000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line7: TfrxLineView
          Left = 3.779530000000000000
          Top = 153.070866140000000000
          Width = 170.078850000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line8: TfrxLineView
          Left = 3.779530000000000000
          Top = 171.590551181102300000
          Width = 170.078850000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line12: TfrxLineView
          Left = 3.779530000000000000
          Top = 194.645669290000000000
          Width = 170.078850000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo1: TfrxMemoView
          Left = 7.559060000000000000
          Top = 117.944960000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Desconto/Abatimento')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 7.559060000000000000
          Top = 136.842610000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Outras Dedu'#231#245'es')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 7.559060000000000000
          Top = 153.740260000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Mora/Multa/Juros')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 7.559060000000000000
          Top = 172.637910000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Outros Acr'#233'cimos')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 7.559060000000000000
          Top = 195.535560000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor Cobrado')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 7.559060000000000000
          Top = 183.196970000000000000
          Width = 162.519790000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoletoCarne."OutrosAcrescimos"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 7.559060000000000000
          Top = 26.456710000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 35.795300000000000000
          Width = 166.299320000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoletoCarne."DataVencimento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 7.559060000000000000
          Top = 49.133890000000000000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia/[dsBoletoCarne."Cedente"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 7.559060000000000000
          Top = 58.472479999999990000
          Width = 162.519790000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoletoCarne."AgenciaCedente"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 7.559060000000000000
          Top = 71.811070000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira/Nosso N'#250'mero')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 7.559060000000000000
          Top = 81.149660000000000000
          Width = 162.519790000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoletoCarne."NossoNumero"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 7.559060000000000000
          Top = 94.488250000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor do Documento')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 7.559060000000000000
          Top = 103.826840000000000000
          Width = 162.519790000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoletoCarne."ValorDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Line13: TfrxLineView
          Left = 3.779530000000000000
          Width = 170.078850000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo15: TfrxMemoView
          Left = 7.559060000000000000
          Top = 211.653680000000000000
          Width = 34.015770000000010000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."Pagador"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 7.559060000000000000
          Top = 222.992270000000000000
          Width = 162.519790000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."NomeSacador"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 7.559060000000000000
          Top = 272.126160000000000000
          Width = 162.519790000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#250'mero da Parcela / Total de Parcelas')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 7.559060000000000000
          Top = 255.008040000000000000
          Width = 162.519790000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."INSSAC"]')
          ParentFont = False
        end
        object Line11: TfrxLineView
          Left = 175.637910000000000000
          Top = 272.126160000000000000
          Width = 540.472790000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line14: TfrxLineView
          Left = 177.637910000000000000
          Width = 540.472790000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line15: TfrxLineView
          Left = 175.858380000000000000
          Height = 272.126160000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo19: TfrxMemoView
          Left = 7.559060000000000000
          Top = 287.244280000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoletoCarne."NumeroDaParcela"] / ')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 80.149660000000000000
          Top = 287.244280000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoletoCarne."TotalDeParcelas"]')
          ParentFont = False
        end
      end
    end
    object frxQRCodePix: TfrxDBDataset
      UserName = 'frxQRCodePix'
      CloseDataSource = False
      BCDToCurrency = False
      Left = 32
      Top = 144
      pLeft = 0
      pTop = 0
    end
  end
  object dsBoletoCarne: TfrxDBDataset
    UserName = 'dsBoletoCarne'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 128
    Top = 80
  end
  object frxDuplicataMercantil: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39527.747396736100000000
    ReportOptions.LastChange = 43871.730560266200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  stUltDupImp: String;'
      '  intUltAgrImp: Integer;'
      ''
      'procedure lblPontualidadeOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (<PONTUALIDADE> = '#39'S'#39') And (<frxRelatorio."CTR_PERDPO"> > 0' +
        ') Then'
      '  Begin              '
      
        '    lblPontualidade.Text := '#39'Desconto na pontualidade de '#39' + For' +
        'matFloat('#39'#,##0.00'#39', <frxRelatorio."CTR_PERDPO">) + '#39'%'#39';'
      '  End'
      '  Else'
      '  Begin'
      '    lblPontualidade.Text := '#39#39';  '
      '  End;'
      'end;'
      ''
      'procedure Memo235OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    intUltAgrImp := intUltAgrImp + 1;  '
      'end;'
      ''
      'procedure MasterData2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If stUltDupImp <> <frxRelatorio."CTR_NUMDUP"> + '#39'_'#39' + <frxRela' +
        'torio."CTR_ESPDOC"> + '#39'_'#39' + <frxRelatorio."CTR_CODEMP"> Then'
      '  Begin'
      
        '    stUltDupImp := <frxRelatorio."CTR_NUMDUP"> + '#39'_'#39' + <frxRelat' +
        'orio."CTR_ESPDOC"> + '#39'_'#39' + <frxRelatorio."CTR_CODEMP">;'
      '    intUltAgrImp := 0;'
      '  End;'
      '  intUltAgrImp := 0;                                        '
      
        '  fCarregaDupAgrupadasNaoImpressas(<frxRelatorio."NRODUP">, <frx' +
        'Relatorio."CTR_ESPDOC">, <frxRelatorio."CTR_CODEMP">, intUltAgrI' +
        'mp, <frxRelatorio."CTR_CODCLI">);'
      
        '  sbrAgrupamento.Visible := (<frxRelatorio."CTR_ESPDOC"> = '#39'AG'#39')' +
        ' And (Pos('#39'1'#39', lblConfAgr.Text) > 0);                         '
      'end;'
      ''
      'procedure Child1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (Engine.CurY > (Engine.PageHeight / 2)) then     '
      '    Engine.NewPage;'
      '      '
      
        '  if (Engine.CurY > 1) and (Engine.CurY < (Engine.PageHeight / 2' +
        ')) then'
      '    Engine.CurY := (Engine.PageHeight / 2);        '
      'end;'
      ''
      'procedure memParcelaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  memParcela.Text := '#39'Parcela '#39' + fRetNumParcela(<frxRelatorio."' +
        'CTR_PARCEL">) + '#39' de '#39' +       '
      
        '    IntToStr(fQtdParcelas(Copy(<frxRelatorio."CTR_NUMDUP">, 1, L' +
        'ength(<frxRelatorio."CTR_NUMDUP">) - 1), '
      '                          <frxRelatorio."CTR_CODEMP">, '
      '                          <frxRelatorio."CTR_ESPDOC">, '
      
        '                          <frxRelatorio."CTR_CODCLI">)) + '#39': '#39'; ' +
        '             '
      'end;'
      ''
      
        'procedure rlbHeaderAgrupamentoOnBeforePrint(Sender: TfrxComponen' +
        't);'
      'begin'
      '  If ((<Page> <> 1)) Then'
      '  Begin'
      '    rlbHeaderAgrupamento.StartNewPage := True;'
      '  End'
      '  Else'
      '  Begin'
      '    rlbHeaderAgrupamento.StartNewPage := False;  '
      '  End;                    '
      'end;'
      ''
      'procedure Memo40OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<PRACAPAGAMENTO> = '#39'1'#39') Then'
      
        '    Memo40.Text := <frxRelatorio."PRCCID"> + '#39' - '#39' + <frxRelator' +
        'io."PRCEST">'
      '  Else'
      
        '    Memo40.Text := <frxRelatorio."CID_NOMCID"> + '#39' - '#39' + <frxRel' +
        'atorio."CID_ESTADO">;'
      'end;'
      ''
      'begin'
      '  stUltDupImp := '#39#39';'
      'end.    ')
    Left = 432
    Top = 6
    Datasets = <
      item
        DataSet = frxDupAgrupadas
        DataSetName = 'frxDupAgrupadas'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxRelatorioDups
        DataSetName = 'frxRelatorioDups'
      end>
    Variables = <
      item
        Name = ' AUTCOM'
        Value = Null
      end
      item
        Name = 'CAMINHOIMG: String'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 0.559060000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'MasterData2OnBeforePrint'
        Child = frxDuplicataMercantil.Child2
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 533.118408040000000000
        Top = 64.252010000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'Child1OnBeforePrint'
        object Shape1: TfrxShapeView
          Top = 18.897650000000000000
          Width = 328.819110000000000000
          Height = 147.401670000000000000
          Curve = 2
          Shape = skRoundRectangle
        end
        object imgImagem: TfrxPictureView
          Left = 9.338590000000000000
          Top = 30.236239999999990000
          Width = 309.921460000000000000
          Height = 124.724490000000000000
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Shape2: TfrxShapeView
          Left = 335.378170000000000000
          Top = 18.897650000000000000
          Width = 419.905528900000000000
          Height = 147.401670000000000000
          Curve = 1
          Shape = skRoundRectangle
        end
        object Memo20: TfrxMemoView
          Left = 341.937230000000000000
          Top = 22.677180000000010000
          Width = 211.653543310000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 339.157700000000000000
          Top = 62.987101420000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRelatorio."EMP_ENDERE"], [frxRelatorio."EMP_ENDNUM"] - Cep: ' +
              '[frxRelatorio."EMP_C_E_P_"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo22: TfrxMemoView
          Left = 339.157700000000000000
          Top = 79.781827140000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRelatorio."EMP_BAIRRO"] - [frxRelatorio."CID_NOMCID"] - [frx' +
              'Relatorio."CID_ESTADO"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo23: TfrxMemoView
          Left = 339.157700000000000000
          Top = 96.576552850000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMP_C_G_C_"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 339.157700000000000000
          Top = 113.371278570000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Inscr. Est.: [frxRelatorio."EMP_I_E_S_"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 339.157700000000000000
          Top = 144.960730000000000000
          Width = 325.039580000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data de Emiss'#227'o: [frxRelatorio."CTR_DTACAD"]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 339.157700000000000000
          Top = 46.192375709999990000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 339.157700000000000000
          Top = 130.166004280000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Fone: [frxRelatorio."EMP_FONE01"]   Email: [frxRelatorio."EMP_EM' +
              'AIL_"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Shape4: TfrxShapeView
          Left = 112.763598900000000000
          Top = 172.259959690000000000
          Width = 515.905511810000000000
          Height = 49.133890000000000000
          Curve = 1
          Shape = skRoundRectangle
        end
        object Shape6: TfrxShapeView
          Left = 632.071090710000000000
          Top = 172.259959690000000000
          Width = 123.212608190000000000
          Height = 90.708720000000000000
          Curve = 1
          Shape = skRoundRectangle
        end
        object Shape3: TfrxShapeView
          Top = 172.259959690000000000
          Width = 109.606370000000000000
          Height = 359.055350000000000000
          Curve = 1
          Shape = skRoundRectangle
        end
        object Shape5: TfrxShapeView
          Left = 112.763598900000000000
          Top = 225.173379690000000000
          Width = 515.905511810000000000
          Height = 37.795300000000000000
          Curve = 1
          Shape = skRoundRectangle
        end
        object Shape7: TfrxShapeView
          Left = 112.763598900000000000
          Top = 266.748209690000000000
          Width = 642.520100000000000000
          Height = 120.944960000000000000
          Curve = 1
          Shape = skRoundRectangle
        end
        object Shape8: TfrxShapeView
          Left = 112.763598900000000000
          Top = 391.252229690000100000
          Width = 642.520100000000000000
          Height = 49.133890000000000000
          Curve = 1
          Shape = skRoundRectangle
        end
        object Shape9: TfrxShapeView
          Left = 112.763598900000000000
          Top = 445.165649690000000000
          Width = 642.519685040000000000
          Height = 86.173228350000000000
          Curve = 1
          Shape = skRoundRectangle
        end
        object Line1: TfrxLineView
          Left = 73.700777640000000000
          Top = 245.960794690000000000
          Height = 211.653680000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo1: TfrxMemoView
          Left = 77.480305200000000000
          Top = 281.866329690000000000
          Width = 18.897650000000000000
          Height = 139.842610000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Assinatura do Emitente')
          ParentFont = False
          Rotation = 90
        end
        object Memo2: TfrxMemoView
          Left = 6.338590000000000000
          Top = 242.181335480000000000
          Width = 18.897650000000000000
          Height = 219.212598430000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
          Rotation = 90
        end
        object Memo3: TfrxMemoView
          Left = 117.519790000000000000
          Top = 445.165649690000000000
          Width = 631.181510000000000000
          Height = 22.677180000000000000
          DataField = 'TEXTOR'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."TEXTOR"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 117.519790000000000000
          Top = 468.960949690000100000
          Width = 396.850650000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NOTA - n'#227'o sendo paga no vencimento ser'#225' cobrado juros de mora')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 631.961040000000000000
          Top = 176.039489690000000000
          Width = 120.944960000000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Para Uso da '
            'Institui'#231#227'o Financeira')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 117.519790000000000000
          Top = 396.031759690000000000
          Width = 60.472480000000000000
          Height = 37.795300000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR '
            'POR '
            'EXTENSO')
          ParentFont = False
        end
        object Shape10: TfrxShapeView
          Left = 184.574668900000000000
          Top = 391.252229690000100000
          Width = 570.709030000000000000
          Height = 49.133890000000000000
          Curve = 1
          Fill.BackColor = 15790320
          Shape = skRoundRectangle
        end
        object Memo7: TfrxMemoView
          Left = 117.519790000000000000
          Top = 274.307269690000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'S a c a d o :')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 117.519790000000000000
          Top = 297.128117520000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'E n d e r e '#231' o :')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 117.519790000000000000
          Top = 319.948965360000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'M u n i c '#237' p i o :')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 524.882190000000000000
          Top = 319.948965360000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP:')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 664.417750000000000000
          Top = 319.948965360000000000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Est.:')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 117.519790000000000000
          Top = 342.769813190000100000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'P r a '#231' a  P a g a m e n t o :')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 117.519790000000000000
          Top = 227.952909690000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCONTO DE')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 117.519790000000000000
          Top = 244.071029690000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONDI'#199#213'ES ESPECIAIS')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 525.882190000000000000
          Top = 365.590661030000100000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Inscr. Est. :')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 112.740260000000000000
          Top = 198.378079690000000000
          Width = 515.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo17: TfrxMemoView
          Left = 158.874106060000000000
          Top = 179.480429690000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FATURA N'#186)
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 549.590910000000000000
          Top = 179.480429690000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENCIMENTO')
          ParentFont = False
        end
        object Shape11: TfrxShapeView
          Left = 264.921460000000000000
          Top = 172.259959690000000000
          Width = 275.905690000000000000
          Height = 49.133890000000000000
        end
        object Memo18: TfrxMemoView
          Left = 270.700990000000000000
          Top = 172.480429690000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'FATURA / DUPLICATA')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 264.669450000000000000
          Top = 185.819019690000000000
          Width = 275.905690000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo26: TfrxMemoView
          Left = 431.543600000000000000
          Top = 172.480429690000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Left = 383.527830000000000000
          Top = 172.700899690000000000
          Height = 49.133890000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo27: TfrxMemoView
          Left = 274.480520000000000000
          Top = 186.208784690000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR R$')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 408.866420000000000000
          Top = 186.208784690000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#186' DE ORDEM')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 117.519790000000000000
          Top = 504.520009690000000000
          Width = 181.417440000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Em _________/_________/___________'
            'DATA DO ACEITE')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 419.882190000000000000
          Top = 504.520009690000000000
          Width = 272.126160000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '_____________________________________________'
            'Assinatura do Sacado')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 117.299320000000000000
          Top = 200.937139690000000000
          Width = 143.622052130000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."NRODUP"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 266.921460000000000000
          Top = 200.937139690000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 386.189240000000000000
          Top = 200.937139690000000000
          Width = 151.181200000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 545.811380000000000000
          Top = 200.937139690000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 187.330860000000000000
          Top = 274.307269690000000000
          Width = 559.370440000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODCLI"] - [frxRelatorio."NOMCLI"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo36: TfrxMemoView
          Left = 202.448980000000000000
          Top = 297.128117520000000000
          Width = 321.260050000000000000
          Height = 18.897650000000000000
          DataField = 'ENDERE'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ENDERE"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 202.448980000000000000
          Top = 319.948965360000000000
          Width = 321.260050000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CIDADE"] - [frxRelatorio."ESTADO"]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 564.457020000000000000
          Top = 319.948965360000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'C_E_P_'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."C_E_P_"]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 700.213050000000000000
          Top = 319.948965360000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ESTADO"]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 262.921460000000000000
          Top = 342.769813190000100000
          Width = 483.779840000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo40OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CID_NOMCID"] - [frxRelatorio."CID_ESTADO"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo41: TfrxMemoView
          Left = 117.519790000000000000
          Top = 365.590661030000100000
          Width = 404.409710000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ / CPF: [frxRelatorio."C_G_C_"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 595.693260000000000000
          Top = 365.590661030000100000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          DataField = 'I_E_S_'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."I_E_S_"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 191.110390000000000000
          Top = 394.693169690000000000
          Width = 555.590910000000000000
          Height = 45.354360000000000000
          OnBeforePrint = 'Memo43OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fRetExtensoNumero(<frxRelatorio."CTR_VALDUP">)]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 117.519790000000000000
          Top = 482.000310000000100000
          Width = 396.850650000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'A duplicata encontra-se em carteira')
          ParentFont = False
        end
        object lblPontualidade: TfrxMemoView
          Left = 117.519790000000000000
          Top = 492.338900000000000000
          Width = 631.181510000000000000
          Height = 11.338590000000000000
          OnBeforePrint = 'lblPontualidadeOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 525.354670000000000000
          Top = 297.128117520000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'B a i r r o :')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 584.945270000000000000
          Top = 297.128117520000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DataField = 'BAIRRO'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."BAIRRO"]')
          ParentFont = False
        end
        object lblConfAgr: TfrxMemoView
          Left = 151.181200000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Visible = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Top = 41.574830000000000000
        Width = 755.906000000000000000
        Child = frxDuplicataMercantil.Child1
        PrintChildIfInvisible = True
        object sbrAgrupamento: TfrxSubreport
          Width = 102.047310000000000000
          Page = frxDuplicataMercantil.Page2
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      object rlbHeaderAgrupamento: TfrxHeader
        FillType = ftBrush
        Height = 124.724490000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'rlbHeaderAgrupamentoOnBeforePrint'
        object Memo200: TfrxMemoView
          Align = baLeft
          Top = 109.606370000000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'm. dup.')
          ParentFont = False
        end
        object Memo201: TfrxMemoView
          Align = baLeft
          Left = 79.370078740000000000
          Top = 109.606370000000000000
          Width = 30.236215590000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Parc.')
          ParentFont = False
        end
        object Memo202: TfrxMemoView
          Align = baLeft
          Left = 109.606294330000000000
          Top = 109.606370000000000000
          Width = 30.236215590000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Esp.')
          ParentFont = False
        end
        object Memo203: TfrxMemoView
          Align = baLeft
          Left = 139.842509920000000000
          Top = 109.606370000000000000
          Width = 34.015745590000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Emp.')
          ParentFont = False
        end
        object Memo218: TfrxMemoView
          Align = baLeft
          Left = 173.858255510000000000
          Top = 109.606370000000000000
          Width = 60.472443390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Emiss'#227'o')
          ParentFont = False
        end
        object Memo228: TfrxMemoView
          Align = baLeft
          Left = 302.362194960000000000
          Top = 109.606370000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo229: TfrxMemoView
          Align = baLeft
          Left = 377.952794960000000000
          Top = 109.606370000000000000
          Width = 79.370078740157480000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'm. dup.')
          ParentFont = False
        end
        object Memo230: TfrxMemoView
          Align = baLeft
          Left = 457.322873700157500000
          Top = 109.606370000000000000
          Width = 30.236218029999990000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Parc.')
          ParentFont = False
        end
        object Memo231: TfrxMemoView
          Align = baLeft
          Left = 487.559091730157500000
          Top = 109.606370000000000000
          Width = 30.236220470000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Esp.')
          ParentFont = False
        end
        object Memo232: TfrxMemoView
          Align = baLeft
          Left = 517.795312200157500000
          Top = 109.606370000000000000
          Width = 34.015748030000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Emp.')
          ParentFont = False
        end
        object Memo233: TfrxMemoView
          Align = baLeft
          Left = 551.811060230157500000
          Top = 109.606370000000000000
          Width = 60.472443390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Emiss'#227'o')
          ParentFont = False
        end
        object Memo234: TfrxMemoView
          Align = baLeft
          Left = 680.314999680157400000
          Top = 109.606370000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Top = 86.929143620000000000
          Width = 377.953000000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          GapX = 4.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object imgLogo: TfrxPictureView
          Left = 3.779530000000000000
          Top = 18.897650000000000000
          Width = 68.031540000000000000
          Height = 64.252010000000000000
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo81: TfrxMemoView
          Left = 3.779530000000000000
          Top = 86.929190000000000000
          Width = 154.960730000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome do cliente')
          ParentFont = False
        end
        object Memo134: TfrxMemoView
          Left = 491.338582677165300000
          Top = 86.929143620000000000
          Width = 264.567051180000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          GapX = 4.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."EMAIL_"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo135: TfrxMemoView
          Left = 495.559370000000000000
          Top = 86.929143620000000000
          Width = 75.590551180000000000
          Height = 9.448818899999999000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'E-Mail do cliente')
          ParentFont = False
        end
        object Memo136: TfrxMemoView
          Left = 75.590600000000000000
          Top = 64.252010000000000000
          Width = 604.724800000000000000
          Height = 18.897650000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'T'#237'tulos agrupados')
        end
        object Memo48: TfrxMemoView
          Align = baLeft
          Left = 234.330698900000000000
          Top = 109.606370000000000000
          Width = 68.031496060000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Align = baLeft
          Left = 612.283503620157400000
          Top = 109.606370000000000000
          Width = 68.031496060000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 377.952755910000000000
          Top = 86.929190000000000000
          Width = 113.385900000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          GapX = 4.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo52: TfrxMemoView
          Left = 381.732530000000000000
          Top = 86.929190000000000000
          Width = 75.590551180000000000
          Height = 9.448818899999999000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Duplicata')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.874015750000000000
        Top = 166.299320000000000000
        Width = 755.906000000000000000
        Columns = 2
        ColumnWidth = 377.952755905512000000
        DataSet = frxDupAgrupadas
        DataSetName = 'frxDupAgrupadas'
        RowCount = 0
        object Memo235: TfrxMemoView
          Align = baLeft
          Width = 79.370078740000000000
          Height = 13.984251970000000000
          OnBeforePrint = 'Memo235OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDupAgrupadas."CTR_NUMDUP"]')
          ParentFont = False
        end
        object Memo236: TfrxMemoView
          Align = baLeft
          Left = 79.370078740000000000
          Width = 30.236215590000000000
          Height = 13.984251970000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDupAgrupadas."CTR_PARCEL"]')
          ParentFont = False
        end
        object Memo237: TfrxMemoView
          Align = baLeft
          Left = 109.606294330000000000
          Width = 30.236215590000000000
          Height = 13.984251970000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDupAgrupadas."CTR_ESPDOC"]')
          ParentFont = False
        end
        object Memo238: TfrxMemoView
          Align = baLeft
          Left = 139.842509920000000000
          Width = 34.015745590000000000
          Height = 13.984251970000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDupAgrupadas."CTR_CODEMP"]')
          ParentFont = False
        end
        object Memo239: TfrxMemoView
          Align = baLeft
          Left = 173.858255510000000000
          Width = 60.472443390000000000
          Height = 13.984251970000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDupAgrupadas."CTR_DTACAD"]')
          ParentFont = False
        end
        object Memo240: TfrxMemoView
          Align = baLeft
          Left = 302.362194960000000000
          Width = 75.590551180000000000
          Height = 15.874015750000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDupAgrupadas."CTR_VALCOR"]')
          ParentFont = False
        end
        object Line81: TfrxLineView
          Align = baLeft
          Height = 15.874015750000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line82: TfrxLineView
          Align = baRight
          Left = 755.906000000000000000
          Height = 15.874015750000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo49: TfrxMemoView
          Align = baLeft
          Left = 234.330698900000000000
          Width = 68.031496060000000000
          Height = 13.984251970000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDupAgrupadas."CTR_DTAVEN"]')
          ParentFont = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 204.094620000000000000
        Width = 755.906000000000000000
        object Memo241: TfrxMemoView
          Align = baRight
          Left = 680.315426850000000000
          Width = 75.590573150000000000
          Height = 14.038254290000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDupAgrupadas."CTR_VALCOR">,MasterData1)]')
          ParentFont = False
        end
        object Memo242: TfrxMemoView
          Align = baRight
          Left = 604.724853700000000000
          Width = 75.590573150000000000
          Height = 14.038254290000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Total Geral: ')
          ParentFont = False
        end
        object Line84: TfrxLineView
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo77: TfrxMemoView
          Align = baRight
          Left = 680.315426850000000000
          Top = 14.118120000000000000
          Width = 75.590573150000000000
          Height = 14.038254290000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Align = baRight
          Left = 680.315426850000000000
          Top = 28.236240000000010000
          Width = 75.590573150000000000
          Height = 14.038254290000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          ParentFont = False
        end
        object memParcela: TfrxMemoView
          Align = baRight
          Left = 321.260103700000000000
          Top = 14.118120000000000000
          Width = 359.055323150000000000
          Height = 14.038254290000000000
          OnBeforePrint = 'memParcelaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo80: TfrxMemoView
          Align = baRight
          Left = 540.472843700000000000
          Top = 28.236240000000010000
          Width = 139.842583150000000000
          Height = 14.038254290000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vencimento desta parcela: ')
          ParentFont = False
        end
      end
    end
  end
  object frxDupAgrupadas: TfrxDBDataset
    UserName = 'frxDupAgrupadas'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 432
    Top = 104
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 432
    Top = 54
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL'
      'EMP_C_G_C_'
      'EMP_ENDERE'
      'EMP_C_E_P_'
      'EMP_I_E_S_'
      'EMP_BAIRRO'
      'CID_NOMCID'
      'CID_ESTADO'
      'EMP_FONE01'
      'EMP_EMAIL_')
    Left = 432
    Top = 158
  end
  object frxDotMatrixExport1: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 432
    Top = 208
  end
  object frxItensMercantil: TfrxDBDataset
    UserName = 'frxItensMercantil'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 316
    Top = 108
  end
  object frxEmpresaMercantil: TfrxDBDataset
    UserName = 'frxEmpresaMercantil'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 312
    Top = 164
  end
  object frxRelatorioDups: TfrxDBDataset
    UserName = 'frxRelatorioDups'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 312
    Top = 230
  end
  object frxQRCodePix: TfrxDBDataset
    UserName = 'frxQRCodePix'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 32
    Top = 144
  end
  object dsBoleto1Via_Comprovante: TfrxDBDataset
    UserName = 'dsBoleto1Via_Comprovante'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 128
    Top = 232
  end
  object frxBoleto1Via_Comprovante: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43735.688096388900000000
    ReportOptions.LastChange = 45170.720893738430000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var i: Integer;                                  '
      ''
      'procedure barCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  barcode1.Text := <dsBoleto1Via_Comprovante."CodigoDeBarras">;'
      
        '  barcode2.Text := <dsBoleto1Via_Comprovante."CodigoDeBarras">; ' +
        '     '
      'end;'
      ''
      'procedure chdFichaComImagemOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (chdFichaComImagem.visible) Then    '
      '      i := i + 1;'
      'end;'
      ''
      'procedure Page1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  i := 0;                '
      'end;'
      ''
      'procedure chdFichaSemImagemOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (chdFichaSemImagem.visible) Then    '
      '      i := i + 1;  '
      'end;'
      ''
      
        'procedure chdFichaComImagemCutOnBeforePrint(Sender: TfrxComponen' +
        't);'
      'begin'
      '  If (chdFichaComImagem.visible) Then'
      '  Begin   '
      '    if (i mod 2) = 0 then'
      '       chdFichaComImagemCut.visible := False               '
      '    else'
      '       chdFichaComImagemCut.visible := True;'
      '  End;                 '
      'end;'
      ''
      
        'procedure chdFichaSemImagemCutOnBeforePrint(Sender: TfrxComponen' +
        't);'
      'begin'
      '  '
      '  If (chdFichaSemImagem.visible) Then'
      '  Begin   '
      '    if (i mod 2) = 0 then'
      '       chdFichaSemImagemCut.visible := False       '
      '    else'
      '       chdFichaSemImagemCut.visible := True;'
      '  End;  '
      '       '
      'end;'
      ''
      'procedure BarCode2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  barcode2.Text := <dsBoleto1Via_Comprovante."CodigoDeBarras">;'
      'end;'
      ''
      'procedure BarCode1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  barcode1.Text := <dsBoleto1Via_Comprovante."CodigoDeBarras">; ' +
        ' '
      'end;'
      ''
      'begin'
      ''
      'end.'
      '           ')
    Left = 134
    Top = 184
    Datasets = <
      item
        DataSet = dsBoleto1Via_Comprovante
        DataSetName = 'dsBoleto1Via_Comprovante'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 8.000000000000000000
      BottomMargin = 5.000000000000000000
      OnBeforePrint = 'Page1OnBeforePrint'
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 145.133858270000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxBoleto1Via_Comprovante.chdFichaRecebedorCut
        DataSet = dsBoleto1Via_Comprovante
        DataSetName = 'dsBoleto1Via_Comprovante'
        RowCount = 0
        object Memo354: TfrxMemoView
          Top = 1.833333330000000000
          Width = 718.110700000000000000
          Height = 143.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          ParentFont = False
        end
        object Shape20: TfrxShapeView
          Left = 394.166666670000000000
          Top = 74.369820000000000000
          Width = 323.864829390000000000
          Height = 40.897650000000000000
          Fill.BackColor = cl3DLight
        end
        object Line129: TfrxLineView
          Left = 3.000000000000000000
          Top = 27.724180000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line130: TfrxLineView
          Left = 116.385900000000000000
          Top = 27.944650000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line131: TfrxLineView
          Left = 222.212740000000000000
          Top = 27.944650000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line133: TfrxLineView
          Left = 393.882190000000000000
          Top = 28.724180000000000000
          Height = 84.149660000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo357: TfrxMemoView
          Left = 473.441250000000000000
          Top = 30.062770000000000000
          Width = 180.110390000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Autentica'#231#227'o Mec'#226'nica - RECIBO PAGADOR')
          ParentFont = False
        end
        object Memo368: TfrxMemoView
          Left = 4.779530000000000000
          Top = 88.724180000000000000
          Width = 126.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Cedente"]')
          ParentFont = False
        end
        object Memo370: TfrxMemoView
          Left = 3.779527559055118000
          Top = 30.401360000000000000
          Width = 46.795300000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pagador')
          ParentFont = False
        end
        object Memo372: TfrxMemoView
          Left = 6.039580000000000000
          Top = 117.188729840000000000
          Width = 101.063080000000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia/[dsBoleto1Via_Comprovante."Cedente"]')
          ParentFont = False
        end
        object Memo374: TfrxMemoView
          Left = 116.039580000000000000
          Top = 117.188729840000000000
          Width = 111.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira/Nosso N'#250'mero')
          ParentFont = False
        end
        object Memo376: TfrxMemoView
          Left = 370.779530000000000000
          Top = 117.188729840000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo378: TfrxMemoView
          Left = 238.811712310000000000
          Top = 117.188729840000000000
          Width = 117.298677690000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#176' do Documento')
          ParentFont = False
        end
        object Memo382: TfrxMemoView
          Left = 499.039580000000000000
          Top = 117.188729840000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor do Documento')
          ParentFont = False
        end
        object Memo393: TfrxMemoView
          Left = 396.850393700000000000
          Top = 82.369820000000000000
          Width = 271.748031500000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Recebimento atrav'#233's do cheque n'#250'mero                         do ' +
              'banco')
          ParentFont = False
        end
        object Memo394: TfrxMemoView
          Left = 396.850393700787400000
          Top = 100.369820000000000000
          Width = 271.748031496063000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Esta quita'#231#227'o s'#243' ter'#225' validade ap'#243's o pagamento do cheque pelo b' +
              'anco.')
          ParentFont = False
        end
        object Line132: TfrxLineView
          Left = 1.000000000000000000
          Top = 86.369820000000000000
          Width = 392.692913390000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line138: TfrxLineView
          Left = 4.000000000000000000
          Top = 115.369820000000000000
          Width = 408.189240000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo395: TfrxMemoView
          Left = 3.779527559055118000
          Top = 73.369820000000000000
          Width = 85.626968460000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Sacador / Avalista')
          ParentFont = False
          WordWrap = False
        end
        object Memo396: TfrxMemoView
          Left = 617.000000000000000000
          Top = 117.188729840000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor do Pagamento')
          ParentFont = False
        end
        object Line139: TfrxLineView
          Left = 113.000000000000000000
          Top = 142.488188976378000000
          Height = -27.590551181102360000
          Color = clBlack
          Diagonal = True
        end
        object Line140: TfrxLineView
          Left = 233.000000000000000000
          Top = 142.488188976378000000
          Height = -27.590551181102360000
          Color = clBlack
          Diagonal = True
        end
        object Line141: TfrxLineView
          Left = 360.000000000000000000
          Top = 142.488188976378000000
          Height = -27.590551181102360000
          Color = clBlack
          Diagonal = True
        end
        object Line142: TfrxLineView
          Left = 488.000000000000000000
          Top = 142.488188976378000000
          Height = -27.590551181102360000
          Color = clBlack
          Diagonal = True
        end
        object Line143: TfrxLineView
          Left = 610.333333340000000000
          Top = 142.488188976378000000
          Width = 0.666666660000000000
          Height = -27.590551181102360000
          Color = clBlack
          Diagonal = True
        end
        object imglog: TfrxPictureView
          Left = 5.384615380000000000
          Top = 5.421316150000000000
          Width = 105.863208460000000000
          Height = 18.897650000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo21: TfrxMemoView
          Left = 126.923076920000000000
          Top = 4.421316150000000000
          Width = 75.590600000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."CodigoBanco"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 231.538461540000000000
          Top = 3.652085380000000000
          Width = 483.834237690000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."LinhaDigitavel"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 53.718376920000000000
          Top = 30.575162310000000000
          Width = 339.023622047244100000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NomeSacador"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 3.779527560000000000
          Top = 43.990675390000000000
          Width = 388.535433070000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."EnderecoSacador"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 3.779527560000000000
          Top = 56.959777690000000000
          Width = 388.535433070866100000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."CidadeSacador"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 94.615384610000000000
          Top = 73.267470000000000000
          Width = 297.826771653543300000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."SacadorAvalista"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 4.615384620000000000
          Top = 102.267470000000000000
          Width = 387.332144620000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NomeCedente"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 5.692307690000000000
          Top = 130.267470000000000000
          Width = 102.519790000000000000
          Height = 10.582677170000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."AgenciaCedente"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 116.153846150000000000
          Top = 130.267470000000000000
          Width = 111.750559230000000000
          Height = 10.582677165354330000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NossoNumero"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 238.461538460000000000
          Top = 129.729008460000000000
          Width = 118.770515380000000000
          Height = 10.582677165354330000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NumeroDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 362.307692310000000000
          Top = 129.498239230000000000
          Width = 120.914704620000000000
          Height = 10.582677165354330000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."DataVencimento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 492.307692310000000000
          Top = 129.498239230000000000
          Width = 112.519790000000000000
          Height = 10.582677165354330000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."ValorDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 672.500000000000000000
          Top = 77.769016670000000000
          Width = 40.818902520000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Parcela')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 675.833333330000000000
          Top = 95.211286090000000000
          Width = 18.374015750000000000
          Height = 16.629921260000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NumeroDaParcela"] / ')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 696.484251970000000000
          Top = 95.211286090000000000
          Width = 19.207349080000000000
          Height = 16.629921260000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."TotalDeParcelas"]')
          ParentFont = False
        end
      end
      object chdFichaSemImagem: TfrxChild
        FillType = ftBrush
        Height = 334.677180000000000000
        Top = 219.212740000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'chdFichaSemImagemOnBeforePrint'
        Child = frxBoleto1Via_Comprovante.chdFichaSemImagemCut
        PrintChildIfInvisible = True
        object Memo347: TfrxMemoView
          Left = 578.268090000000000000
          Top = 26.306740000000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo353: TfrxMemoView
          Left = 578.268090000000000000
          Top = 94.338280000000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Line128: TfrxLineView
          Top = 26.306740000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line134: TfrxLineView
          Left = 113.385900000000000000
          Top = 26.306740000000000000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line135: TfrxLineView
          Left = 219.212740000000000000
          Top = 26.306740000000000000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line136: TfrxLineView
          Top = 48.983920000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line137: TfrxLineView
          Top = 71.661100000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line144: TfrxLineView
          Top = 94.338280000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line145: TfrxLineView
          Left = 578.268090000000000000
          Top = 211.503710000000000000
          Height = -185.196970000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo361: TfrxMemoView
          Left = 3.779530000000000000
          Top = 26.306740000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Local de Pagamento')
          ParentFont = False
        end
        object Memo364: TfrxMemoView
          Left = 582.047620000000000000
          Top = 26.306740000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo366: TfrxMemoView
          Left = 582.047620000000000000
          Top = 48.983920000000000000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia/[dsBoleto1Via_Comprovante."Cedente"]')
          ParentFont = False
        end
        object rllNN3: TfrxMemoView
          Left = 582.047620000000000000
          Top = 71.661100000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira/Nosso N'#250'mero')
          ParentFont = False
        end
        object Line146: TfrxLineView
          Top = 117.015460000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo384: TfrxMemoView
          Left = 582.047620000000000000
          Top = 94.338280000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor do Documento')
          ParentFont = False
        end
        object Memo386: TfrxMemoView
          Left = 3.779530000000000000
          Top = 71.661100000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Documento')
          ParentFont = False
        end
        object Line147: TfrxLineView
          Left = 132.283550000000000000
          Top = 94.338280000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo390: TfrxMemoView
          Left = 136.063080000000000000
          Top = 71.661100000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#176' do Documento')
          ParentFont = False
        end
        object Line148: TfrxLineView
          Left = 268.346630000000000000
          Top = 94.338280000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo398: TfrxMemoView
          Left = 272.126160000000000000
          Top = 71.661100000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Esp'#233'cie Doc.')
          ParentFont = False
        end
        object Line149: TfrxLineView
          Left = 351.496290000000000000
          Top = 94.338280000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo400: TfrxMemoView
          Left = 355.275820000000000000
          Top = 71.661100000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aceite')
          ParentFont = False
        end
        object Line150: TfrxLineView
          Left = 423.307360000000000000
          Top = 94.338280000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo402: TfrxMemoView
          Left = 427.086890000000000000
          Top = 71.661100000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Processamento')
          ParentFont = False
        end
        object Memo404: TfrxMemoView
          Left = 3.779530000000000000
          Top = 94.338280000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Uso do Banco')
          ParentFont = False
        end
        object Line151: TfrxLineView
          Left = 240.669450000000000000
          Top = 117.015460000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo405: TfrxMemoView
          Left = 249.448980000000000000
          Top = 94.338280000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira')
          ParentFont = False
        end
        object Line152: TfrxLineView
          Left = 338.378170000000000000
          Top = 117.015460000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo407: TfrxMemoView
          Left = 340.157700000000000000
          Top = 103.676870000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'R$')
          ParentFont = False
          WordWrap = False
        end
        object Line153: TfrxLineView
          Left = 404.409710000000000000
          Top = 117.015460000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object MemQtde01: TfrxMemoView
          Left = 408.189240000000000000
          Top = 94.338280000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Line154: TfrxLineView
          Left = 468.661720000000000000
          Top = 117.015460000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line155: TfrxLineView
          Top = 211.503710000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line157: TfrxLineView
          Left = 578.268090000000000000
          Top = 148.810760000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line159: TfrxLineView
          Left = 578.268090000000000000
          Top = 180.606060000000000000
          Width = 139.842610000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo418: TfrxMemoView
          Left = 582.047620000000000000
          Top = 117.015460000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Desconto/Abatimento')
          ParentFont = False
        end
        object Memo420: TfrxMemoView
          Left = 582.047620000000000000
          Top = 148.810760000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Mora/Multa/Juros')
          ParentFont = False
        end
        object Memo422: TfrxMemoView
          Left = 582.047620000000000000
          Top = 180.606060000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor Cobrado')
          ParentFont = False
        end
        object Memo426: TfrxMemoView
          Left = 496.629921260000000000
          Top = 225.811402310000000000
          Width = 209.448980000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."INSSAC"]')
          ParentFont = False
        end
        object Memo428: TfrxMemoView
          Left = 527.268090000000000000
          Top = 280.637600000000000000
          Width = 177.637910000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Autentica'#231#227'o mec'#226'nica - Ficha de compensa'#231#227'o')
          ParentFont = False
        end
        object BarCode2: TfrxBarCodeView
          Left = 5.669291340000000000
          Top = 282.976190000000000000
          Width = 474.000000000000000000
          Height = 49.133858270000000000
          OnBeforePrint = 'BarCode2OnBeforePrint'
          BarType = bcCode_2_5_interleaved
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '12345678901234567890123456789012345678901234'
          WideBarRatio = 1.000000000000000000
          Zoom = 1.500000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object Memo432: TfrxMemoView
          Left = 340.157700000000000000
          Top = 94.338280000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."EspecieMoeda"]')
          ParentFont = False
        end
        object Memo440: TfrxMemoView
          Left = 3.779530000000000000
          Top = 118.015460000000000000
          Width = 566.929500000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'INSTRU'#199#213'ES (Instru'#231#245'es de responsabilidade do benefici'#225'rio. Qual' +
              'quer d'#250'vida sobre este boleto, contate o benefici'#225'rio)')
          ParentFont = False
        end
        object Memo444: TfrxMemoView
          Left = 472.441250000000000000
          Top = 94.338280000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."ValorDaMoeda"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 124.615384620000000000
          Top = 2.234645380000000000
          Width = 75.590600000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."CodigoBanco"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 226.923076920000000000
          Top = 3.003876150000000000
          Width = 483.834237690000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."LinhaDigitavel"]')
          ParentFont = False
        end
        object imglog2: TfrxPictureView
          Left = 3.615384620000000000
          Top = 3.773106920000000000
          Width = 105.863208460000000000
          Height = 18.897650000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo35: TfrxMemoView
          Left = 581.538461540000000000
          Top = 36.080799230000000000
          Width = 120.914704620000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."DataVencimento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 582.307692310000000000
          Top = 56.850030000000000000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."AgenciaCedente"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 582.307692310000000000
          Top = 81.465414620000000000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NossoNumero"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 582.307692310000000000
          Top = 103.773106920000000000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."ValorDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 136.153846150000000000
          Top = 80.696183850000000000
          Width = 118.770515380000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NumeroDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 273.076923080000000000
          Top = 79.926953080000000000
          Width = 66.759573850000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."EspecieDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 356.923076920000000000
          Top = 80.696183850000000000
          Width = 58.764402310000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Aceite"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 426.923076920000000000
          Top = 80.696183850000000000
          Width = 139.236882310000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."DataProcessamento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo43: TfrxMemoView
          Left = 3.846153850000000000
          Top = 81.465414620000000000
          Width = 97.898292310000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."DataDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 4.615384620000000000
          Top = 103.003876150000000000
          Width = 228.231411540000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."UsoDoBanco"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 248.461538460000000000
          Top = 103.003876150000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Carteira"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 246.923076920000000000
          Top = 104.542337680000000000
          Width = 82.113933850000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Carteira2"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo48: TfrxMemoView
          Left = 407.692307690000000000
          Top = 103.003876150000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 3.846153850000000000
          Top = 132.234645380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao1"]')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 3.846153850000000000
          Top = 141.573235380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao2"]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 3.846153850000000000
          Top = 150.911825380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao3"]')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 3.846153850000000000
          Top = 160.250415380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao4"]')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 3.846153850000000000
          Top = 169.589005380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao5"]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 3.846153850000000000
          Top = 178.927595380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao6"]')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 3.846153850000000000
          Top = 188.266185380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao7"]')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 3.846153850000000000
          Top = 198.604775380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao8"]')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 48.641453850000000000
          Top = 213.773106920000000000
          Width = 238.110390000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NomeSacador"]')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 3.846153850000000000
          Top = 237.229816920000000000
          Width = 486.057115820000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."CidadeSacador"]')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 4.066623850000000000
          Top = 213.773106920000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Pagador"]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 3.846153850000000000
          Top = 226.111696920000000000
          Width = 486.057276920000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."EnderecoSacador"]')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 3.846153850000000000
          Top = 253.003876150000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Sacador/Avalista:')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 78.413082980000000000
          Top = 253.003876150000000000
          Width = 411.169283840000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."SacadorAvalista"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo63: TfrxMemoView
          Left = 3.602012980000000000
          Top = 266.003876150000000000
          Width = 336.378170000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."EnderecoAvalista"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo64: TfrxMemoView
          Left = 496.629921259843000000
          Top = 265.311568460000000000
          Width = 113.385900000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NossoNumero"]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 496.251968500000000000
          Top = 253.352765380000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo de Baixa')
          ParentFont = False
        end
        object Memo166: TfrxMemoView
          Left = 8.461538460000000000
          Top = 38.254269230000000000
          Width = 408.189240000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."LocalPagamento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo46: TfrxMemoView
          Left = 92.060136960000000000
          Top = 28.915679230000000000
          Width = 321.260050000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."LocalExtensao"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo168: TfrxMemoView
          Left = 58.861953140000000000
          Top = 49.684910000000000000
          Width = 347.716760000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NomeCedente"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo144: TfrxMemoView
          Left = 3.846153850000000000
          Top = 61.023500000000000000
          Width = 404.409710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."EnderecoCedente"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo167: TfrxMemoView
          Left = 3.948533140000000000
          Top = 49.684910000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Beneficiario"]')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 496.251968500000000000
          Top = 213.076613080000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CPF / CNPJ')
          ParentFont = False
        end
      end
      object chdFichaComImagem: TfrxChild
        FillType = ftBrush
        Height = 363.349103330000000000
        Top = 661.417750000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'chdFichaComImagemOnBeforePrint'
        Child = frxBoleto1Via_Comprovante.chdFichaComImagemCut
        PrintChildIfInvisible = True
        object Memo490: TfrxMemoView
          Left = 582.622450000000000000
          Top = 9.865490000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ficha de Compensa'#231#227'o')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          Left = 578.268090000000000000
          Top = 71.306740000000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 578.268090000000000000
          Top = 138.338280000000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Line16: TfrxLineView
          Top = 26.306740000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line17: TfrxLineView
          Left = 113.385900000000000000
          Top = 26.306740000000000000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line18: TfrxLineView
          Left = 219.212740000000000000
          Top = 26.306740000000000000
          Height = -26.456710000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line19: TfrxLineView
          Top = 47.983920000000000000
          Width = 578.268090000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line20: TfrxLineView
          Top = 70.661100000000000000
          Width = 578.268090000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line21: TfrxLineView
          Top = 93.338280000000000000
          Width = 578.268090000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line22: TfrxLineView
          Left = 577.601423330000000000
          Top = 243.298581800000000000
          Height = -216.325175130000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo68: TfrxMemoView
          Left = 3.779530000000000000
          Top = 26.306740000000000000
          Width = 82.313805380000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Local de Pagamento')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 582.047620000000000000
          Top = 93.306740000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 582.047620000000000000
          Top = 116.983920000000000000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia/[dsBoleto1Via_Comprovante."Cedente"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 581.380953330000000000
          Top = 140.661100000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira/Nosso N'#250'mero')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 582.047620000000000000
          Top = 164.338280000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor do Documento')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 3.779530000000000000
          Top = 71.661100000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Documento')
          ParentFont = False
        end
        object Line24: TfrxLineView
          Left = 132.283550000000000000
          Top = 94.338280000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo77: TfrxMemoView
          Left = 136.063080000000000000
          Top = 71.661100000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#176' do Documento')
          ParentFont = False
        end
        object Line25: TfrxLineView
          Left = 268.346630000000000000
          Top = 94.338280000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo78: TfrxMemoView
          Left = 272.126160000000000000
          Top = 71.661100000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Esp'#233'cie Doc.')
          ParentFont = False
        end
        object Line26: TfrxLineView
          Left = 351.496290000000000000
          Top = 94.338280000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo79: TfrxMemoView
          Left = 355.275820000000000000
          Top = 71.661100000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aceite')
          ParentFont = False
        end
        object Line27: TfrxLineView
          Left = 423.307360000000000000
          Top = 94.338280000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo80: TfrxMemoView
          Left = 427.086890000000000000
          Top = 71.661100000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Processamento')
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          Left = 3.779530000000000000
          Top = 94.338280000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Uso do Banco')
          ParentFont = False
        end
        object Line28: TfrxLineView
          Left = 240.669450000000000000
          Top = 116.015460000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo82: TfrxMemoView
          Left = 249.448980000000000000
          Top = 94.338280000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Carteira')
          ParentFont = False
        end
        object Line29: TfrxLineView
          Left = 338.378170000000000000
          Top = 116.015460000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo83: TfrxMemoView
          Left = 340.157700000000000000
          Top = 103.676870000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'R$')
          ParentFont = False
          WordWrap = False
        end
        object Line30: TfrxLineView
          Left = 404.409710000000000000
          Top = 116.015460000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object MemQtde02: TfrxMemoView
          Left = 408.189240000000000000
          Top = 94.338280000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Line31: TfrxLineView
          Left = 468.661720000000000000
          Top = 116.015460000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line32: TfrxLineView
          Left = -0.769230770000000000
          Top = 244.734479230000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
        object Line33: TfrxLineView
          Left = 578.267716540000000000
          Top = 205.810760000000000000
          Width = 139.842519690000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line34: TfrxLineView
          Left = 578.267716540000000000
          Top = 225.606060000000000000
          Width = 139.842519690000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo85: TfrxMemoView
          Left = 582.047620000000000000
          Top = 187.015460000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Desconto/Abatimento')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 582.047620000000000000
          Top = 206.810760000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Mora/Multa/Juros')
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          Left = 582.047620000000000000
          Top = 226.606060000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Valor Cobrado')
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          Left = 496.629921260000000000
          Top = 259.349863850000000000
          Width = 209.385826770000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."INSSAC"]')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 527.244094490000000000
          Top = 317.406830770000000000
          Width = 177.637910000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Autentica'#231#227'o mec'#226'nica - Ficha de compensa'#231#227'o')
          ParentFont = False
        end
        object BarCode1: TfrxBarCodeView
          Left = 4.900060570000000000
          Top = 311.206959230000000000
          Width = 474.000000000000000000
          Height = 49.133858270000000000
          OnBeforePrint = 'BarCode1OnBeforePrint'
          BarType = bcCode_2_5_interleaved
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '12345678901234567890123456789012345678901234'
          WideBarRatio = 1.000000000000000000
          Zoom = 1.500000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object Memo92: TfrxMemoView
          Left = 340.157700000000000000
          Top = 94.338280000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."EspecieMoeda"]')
          ParentFont = False
        end
        object Memo94: TfrxMemoView
          Left = 3.779530000000000000
          Top = 118.015460000000000000
          Width = 566.929500000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'INSTRU'#199#213'ES (Instru'#231#245'es de responsabilidade do benefici'#225'rio. Qual' +
              'quer d'#250'vida sobre este boleto, contate o benefici'#225'rio)')
          ParentFont = False
        end
        object Memo96: TfrxMemoView
          Left = 472.441250000000000000
          Top = 94.338280000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."ValorDaMoeda"]')
          ParentFont = False
        end
        object Memo98: TfrxMemoView
          Left = 230.769230770000000000
          Top = 4.542337690000000000
          Width = 483.834237690000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."LinhaDigitavel"]')
          ParentFont = False
        end
        object IMGlOG3: TfrxPictureView
          Left = 3.615384620000000000
          Top = 3.773106920000000000
          Width = 105.863208460000000000
          Height = 18.897650000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo99: TfrxMemoView
          Left = 581.538461540000000000
          Top = 103.080799230000000000
          Width = 120.914704620000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."DataVencimento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo100: TfrxMemoView
          Left = 582.307692310000000000
          Top = 124.850030000000000000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."AgenciaCedente"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo101: TfrxMemoView
          Left = 582.307692310000000000
          Top = 150.465414620000000000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NossoNumero"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo102: TfrxMemoView
          Left = 582.307692310000000000
          Top = 173.773106920000000000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."ValorDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo103: TfrxMemoView
          Left = 136.153846150000000000
          Top = 80.696183850000000000
          Width = 118.770515380000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NumeroDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo104: TfrxMemoView
          Left = 273.076923080000000000
          Top = 79.926953080000000000
          Width = 66.759573850000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."EspecieDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo105: TfrxMemoView
          Left = 356.923076920000000000
          Top = 80.696183850000000000
          Width = 58.764402310000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Aceite"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo106: TfrxMemoView
          Left = 426.923076920000000000
          Top = 80.696183850000000000
          Width = 139.236882310000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."DataProcessamento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo107: TfrxMemoView
          Left = 3.846153850000000000
          Top = 81.465414620000000000
          Width = 97.898292310000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."DataDocumento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo108: TfrxMemoView
          Left = 4.615384620000000000
          Top = 103.003876150000000000
          Width = 228.231411540000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."UsoDoBanco"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo109: TfrxMemoView
          Left = 248.461538460000000000
          Top = 103.003876150000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Carteira"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo110: TfrxMemoView
          Left = 248.461538460000000000
          Top = 104.003876150000000000
          Width = 82.113933850000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Carteira2"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo111: TfrxMemoView
          Left = 407.692307690000000000
          Top = 103.003876150000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
        end
        object Memo113: TfrxMemoView
          Left = 3.846153850000000000
          Top = 132.234645380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao1"]')
          ParentFont = False
        end
        object Memo114: TfrxMemoView
          Left = 3.846153850000000000
          Top = 141.573235380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao2"]')
          ParentFont = False
        end
        object Memo115: TfrxMemoView
          Left = 3.846153850000000000
          Top = 150.911825380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao3"]')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          Left = 3.846153850000000000
          Top = 160.250415380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao4"]')
          ParentFont = False
        end
        object Memo117: TfrxMemoView
          Left = 3.846153850000000000
          Top = 169.589005380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao5"]')
          ParentFont = False
        end
        object Memo118: TfrxMemoView
          Left = 3.846153850000000000
          Top = 178.927595380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao6"]')
          ParentFont = False
        end
        object Memo119: TfrxMemoView
          Left = 3.846153850000000000
          Top = 188.266185380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao7"]')
          ParentFont = False
        end
        object Memo120: TfrxMemoView
          Left = 3.846153850000000000
          Top = 198.604775380000000000
          Width = 396.850405910000000000
          Height = 9.448818900000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Instrucao8"]')
          ParentFont = False
        end
        object Memo121: TfrxMemoView
          Left = 47.641453850000000000
          Top = 246.773106920000000000
          Width = 238.110390000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NomeSacador"]')
          ParentFont = False
        end
        object Memo122: TfrxMemoView
          Left = 3.846153850000000000
          Top = 270.229816920000000000
          Width = 486.047244094488000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."CidadeSacador"]')
          ParentFont = False
        end
        object Memo123: TfrxMemoView
          Left = 4.066623850000000000
          Top = 246.773106920000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Pagador"]')
          ParentFont = False
        end
        object Memo124: TfrxMemoView
          Left = 3.846153850000000000
          Top = 259.111696920000000000
          Width = 486.047244094488000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."EnderecoSacador"]')
          ParentFont = False
        end
        object Memo125: TfrxMemoView
          Left = 3.846153850000000000
          Top = 284.003876150000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Sacador/Avalista:')
          ParentFont = False
        end
        object Memo126: TfrxMemoView
          Left = 78.413082980000000000
          Top = 284.003876150000000000
          Width = 411.212598430000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."SacadorAvalista"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo127: TfrxMemoView
          Left = 3.602012980000000000
          Top = 296.003876150000000000
          Width = 336.378170000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."EnderecoAvalista"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo128: TfrxMemoView
          Left = 496.629921260000000000
          Top = 296.311568460000000000
          Width = 209.539746150000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NossoNumero"]')
          ParentFont = False
        end
        object Memo129: TfrxMemoView
          Left = 496.251968500000000000
          Top = 284.352765380000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo de Baixa')
          ParentFont = False
        end
        object Memo97: TfrxMemoView
          Left = 126.153846150000000000
          Top = 2.410064620000000000
          Width = 75.590600000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."CodigoBanco"]')
          ParentFont = False
        end
        object Line23: TfrxLineView
          Left = 578.267716540000000000
          Top = 186.871603080000000000
          Width = 139.842519690000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line35: TfrxLineView
          Left = 578.267716540000000000
          Top = 163.563910770000000000
          Width = 139.842519690000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line36: TfrxLineView
          Left = 578.267716540000000000
          Top = 139.717756920000000000
          Width = 139.842519690000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line37: TfrxLineView
          Left = 578.267716540000000000
          Top = 116.179295380000000000
          Width = 139.842519690000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line38: TfrxLineView
          Left = 578.267716540000000000
          Top = 92.871603080000000000
          Width = 139.842519690000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object imgLogoEmpresa: TfrxPictureView
          Left = 589.846153850000000000
          Top = 29.025449230000000000
          Width = 108.047310000000000000
          Height = 59.795300000000000000
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo1: TfrxMemoView
          Left = 4.615384620000000000
          Top = 36.891226920000000000
          Width = 408.189240000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."LocalPagamento"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 88.213983120000000000
          Top = 27.552636920000000000
          Width = 321.260050000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."LocalExtensao"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 59.631183910000000000
          Top = 49.091098460000000000
          Width = 347.716760000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."NomeCedente"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 4.615384620000000000
          Top = 60.429688460000000000
          Width = 404.409710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."EnderecoCedente"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 4.717763910000000000
          Top = 49.091098460000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsBoleto1Via_Comprovante."Beneficiario"]')
          ParentFont = False
        end
        object Memo157: TfrxMemoView
          Left = 496.251968503937000000
          Top = 246.918270770000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CPF / CNPJ')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 0.666666670000000000
          Top = 115.603276670000000000
          Width = 578.268090000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object chdFichaSemImagemCut: TfrxChild
        FillType = ftBrush
        Height = 11.205342310000000000
        Top = 578.268090000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'chdFichaSemImagemCutOnBeforePrint'
        Child = frxBoleto1Via_Comprovante.chdEspacoEntreBoleto
        PrintChildIfInvisible = True
        object Memo155: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 11.205342310000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - -')
          ParentFont = False
        end
        object Memo156: TfrxMemoView
          Left = 2.307692310000000000
          Top = 1.525615380000000000
          Width = 15.118120000000000000
          Height = 7.559060000000000000
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #61474)
          ParentFont = False
        end
      end
      object chdFichaRecebedorCut: TfrxChild
        FillType = ftBrush
        Height = 11.205342310000000000
        Top = 185.196970000000000000
        Width = 718.110700000000000000
        Child = frxBoleto1Via_Comprovante.chdFichaSemImagem
        PrintChildIfInvisible = True
        object Memo158: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 11.205342310000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - -')
          ParentFont = False
        end
        object Memo159: TfrxMemoView
          Left = 2.307692310000000000
          Top = 1.525615380000000000
          Width = 15.118120000000000000
          Height = 7.559060000000000000
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #61474)
          ParentFont = False
        end
      end
      object chdFichaComImagemCut: TfrxChild
        FillType = ftBrush
        Height = 11.205342310000000000
        Top = 1046.929810000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'chdFichaComImagemCutOnBeforePrint'
        PrintChildIfInvisible = True
        object Memo6: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 11.205342310000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - -')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 2.307692310000000000
          Top = 1.525615380000000000
          Width = 15.118120000000000000
          Height = 7.559060000000000000
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #61474)
          ParentFont = False
        end
      end
      object chdEspacoEntreBoleto: TfrxChild
        FillType = ftBrush
        Height = 25.795275590000000000
        Top = 612.283860000000000000
        Width = 718.110700000000000000
        Child = frxBoleto1Via_Comprovante.chdFichaComImagem
        PrintChildIfInvisible = True
      end
    end
  end
end
