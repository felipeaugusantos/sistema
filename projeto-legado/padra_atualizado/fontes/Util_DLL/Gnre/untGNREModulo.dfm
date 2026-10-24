object GNREModulo: TGNREModulo
  Left = 0
  Top = 0
  ClientHeight = 171
  ClientWidth = 278
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  PixelsPerInch = 96
  TextHeight = 13
  object frxReport: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41367.473068715300000000
    ReportOptions.LastChange = 43328.498668819400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Page1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  Memo1.Visible := <Guia."Ambiente"> = '#39'2'#39';'
      '  Memo2.Visible := <Guia."Ambiente"> = '#39'2'#39';'
      '  Memo3.Visible := <Guia."Ambiente"> = '#39'2'#39';'
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  LogoPix1.Visible := False;'
      '  LogoPix2.Visible := False;'
      '      '
      '  qrCode1.Visible := False;'
      '  qrCode2.Visible := False;'
      '         '
      '  If Length(Trim(<Guia."QrCode">)) > 0 Then'
      '  begin'
      '    LogoPix1.Visible := True;'
      '    LogoPix2.Visible := True;'
      ''
      '    qrCode1.Visible := True;'
      '    qrCode2.Visible := True;         '
      '  end;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 79
    Top = 32
    Datasets = <
      item
        DataSet = frxDBDatasetGuia
        DataSetName = 'Guia'
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
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      OnBeforePrint = 'Page1OnBeforePrint'
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 1063.377962520000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxDBDatasetGuia
        DataSetName = 'Guia'
        RowCount = 0
        object Shape1: TfrxShapeView
          Left = 34.346400060000000000
          Top = 1.519666000000000000
          Width = 457.322834650000000000
          Height = 230.551185980000000000
        end
        object Memo4: TfrxMemoView
          Left = 53.243902380000000000
          Top = 7.078747970000000000
          Width = 411.968770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[Guia."Titulo"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Shape2: TfrxShapeView
          Left = 491.449104000000000000
          Top = 1.519692850000000000
          Width = 181.417322830000000000
          Height = 230.551185980000000000
        end
        object Line14: TfrxLineView
          Left = 571.039357390000000000
          Top = 2.519692850000000000
          Height = 22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo31: TfrxMemoView
          Left = 498.984242200000000000
          Top = 2.661434410000000000
          Width = 60.472480000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UF Favorecida')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo32: TfrxMemoView
          Left = 577.354320940000000000
          Top = 2.661436850000000000
          Width = 79.370130000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo da Receita')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo43: TfrxMemoView
          Left = 494.448806200000000000
          Top = 12.858282850000000000
          Width = 41.574830000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."UFFavorecido"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo44: TfrxMemoView
          Left = 572.818884940000000000
          Top = 12.858282850000000000
          Width = 52.913420000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."CodigoReceita"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo1: TfrxMemoView
          Left = 120.629994000000000000
          Top = 72.212616000000000000
          Width = 525.354670000000000000
          Height = 177.637910000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clSilver
          Font.Height = -60
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '   Guia Inv'#225'lida '
            'para Pagamento')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 121.629994000000000000
          Top = 808.189384500000000000
          Width = 506.457020000000000000
          Height = 177.637910000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clSilver
          Font.Height = -60
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '   Guia Inv'#225'lida '
            'para Pagamento')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 121.629994000000000000
          Top = 439.929334500000000000
          Width = 506.457020000000000000
          Height = 177.637910000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clSilver
          Font.Height = -60
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '   Guia Inv'#225'lida '
            'para Pagamento')
          ParentFont = False
        end
        object BarCode2: TfrxBarCodeView
          Left = 37.259907940000000000
          Top = 986.386276390000000000
          Width = 441.000000000000000000
          Height = 49.133860710000000000
          BarType = bcCode_2_5_interleaved
          Expression = '<Guia."CodigoBarrasBoleto">'
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '858000000011000000901300800120130328190000028004'
          WideBarRatio = 3.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object Memo173: TfrxMemoView
          Left = 84.818902030000000000
          Top = 972.165952850000000000
          Width = 291.023810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              '[FormatMaskText('#39'00000000000 0 00000000000 0 00000000000 0 00000' +
              '000000 0;0;'#39#39#39',<Guia."RepresentacaoNumerica">)]')
          ParentFont = False
        end
        object Memo171: TfrxMemoView
          Left = 590.953167940000000000
          Top = 970.606892850000000000
          Width = 82.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '3'#170' via - Contribuinte/Fisco')
          ParentFont = False
        end
        object Shape5: TfrxShapeView
          Left = 35.259864000000000000
          Top = 738.819254500000000000
          Width = 457.322834650000000000
          Height = 230.551181100000000000
        end
        object Shape6: TfrxShapeView
          Left = 492.362567940000000000
          Top = 738.819281350000000000
          Width = 181.417322830000000000
          Height = 230.551181100000000000
        end
        object Line32: TfrxLineView
          Left = 571.952821330000000000
          Top = 739.819281350000000000
          Height = 22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo118: TfrxMemoView
          Left = 573.732348880000000000
          Top = 739.598811350000000000
          Width = 79.370130000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo da Receita')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo119: TfrxMemoView
          Left = 494.889746200000000000
          Top = 739.598808910000000000
          Width = 60.472480000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UF Favorecida')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo120: TfrxMemoView
          Left = 54.157366330000000000
          Top = 743.378336470000000000
          Width = 411.968770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[Guia."Titulo"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo121: TfrxMemoView
          Left = 573.732348880000000000
          Top = 750.157871350000000000
          Width = 52.913420000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."CodigoReceita"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo122: TfrxMemoView
          Left = 494.889746200000000000
          Top = 750.157871350000000000
          Width = 41.574830000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."UFFavorecido"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Line33: TfrxLineView
          Left = 492.583037940000000000
          Top = 762.496461350000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line34: TfrxLineView
          Left = 35.259907940000000000
          Top = 762.496446700000000000
          Width = 457.323130000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo123: TfrxMemoView
          Left = 494.889746200000000000
          Top = 764.275991350000000000
          Width = 60.472480000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#176' de Controle')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo124: TfrxMemoView
          Left = 199.669271320000000000
          Top = 765.275974260000000000
          Width = 132.283550000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dados do Contribuinte Emitente')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo125: TfrxMemoView
          Left = 565.394107940000000000
          Top = 773.835051350000000000
          Width = 105.826840000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."NumeroControle"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo126: TfrxMemoView
          Left = 381.102474000000000000
          Top = 774.724793160000000000
          Width = 83.149660000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ/CPF/Insc. Est:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo127: TfrxMemoView
          Left = 37.818967940000000000
          Top = 774.724793160000000000
          Width = 56.692950000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Raz'#227'o Social:')
          ParentFont = False
          Wysiwyg = False
        end
        object Line35: TfrxLineView
          Left = 492.583037940000000000
          Top = 786.173612060000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo128: TfrxMemoView
          Left = 381.102474000000000000
          Top = 784.173612060000000000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<Guia."DocumentoEmitente">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo129: TfrxMemoView
          Left = 37.818967940000000000
          Top = 784.173612060000000000
          Width = 328.819110000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."RazaoSocialEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo130: TfrxMemoView
          Left = 494.889746200000000000
          Top = 786.953171350000000000
          Width = 86.929190000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data de Vencimento')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo131: TfrxMemoView
          Left = 591.850817940000000000
          Top = 795.512231350000000000
          Width = 79.370130000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<Guia."DataVencimento">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo132: TfrxMemoView
          Left = 86.952857940000000000
          Top = 795.512231350000000000
          Width = 393.071120000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."EnderecoEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo133: TfrxMemoView
          Left = 37.818967940000000000
          Top = 795.512194740000000000
          Width = 45.354360000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
          Wysiwyg = False
        end
        object Line36: TfrxLineView
          Left = 492.583037940000000000
          Top = 807.850821350000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo134: TfrxMemoView
          Left = 406.315257940000000000
          Top = 806.850821350000000000
          Width = 37.795300000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."UFEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo135: TfrxMemoView
          Left = 86.952857940000000000
          Top = 806.850821350000000000
          Width = 279.685220000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."MunicipioEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo136: TfrxMemoView
          Left = 386.197137940000000000
          Top = 806.661891350000000000
          Width = 18.897650000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UF:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo137: TfrxMemoView
          Left = 37.818967940000000000
          Top = 806.661891350000000000
          Width = 45.354360000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo138: TfrxMemoView
          Left = 494.889746200000000000
          Top = 808.874399460000000000
          Width = 105.826840000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#176' Documento de Origem')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo139: TfrxMemoView
          Left = 546.496457940000000000
          Top = 819.189411350000000000
          Width = 124.724490000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."NumeroDocumentoOrigem"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo140: TfrxMemoView
          Left = 407.315257940000000000
          Top = 818.189411350000000000
          Width = 83.149660000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[FormatMaskText('#39'(999\)00000-0000;0;_'#39',<Guia."TelefoneEmitente">' +
              ')]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo141: TfrxMemoView
          Left = 64.275677940000000000
          Top = 818.189411350000000000
          Width = 151.181200000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."CEPEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo142: TfrxMemoView
          Left = 364.519957940000000000
          Top = 818.189360090000000000
          Width = 41.574830000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Telefone:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo143: TfrxMemoView
          Left = 37.818967940000000000
          Top = 818.189360090000000000
          Width = 22.677180000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CEP:')
          ParentFont = False
        end
        object Line37: TfrxLineView
          Left = 594.629986680000000000
          Top = 832.528001350000000000
          Height = 22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line38: TfrxLineView
          Left = 492.583037940000000000
          Top = 831.527972060000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo144: TfrxMemoView
          Left = 218.566921320000000000
          Top = 833.528001350000000000
          Width = 94.488250000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Dados do Destinat'#225'rio')
          ParentFont = False
          Wysiwyg = False
        end
        object Line39: TfrxLineView
          Left = 35.480377940000000000
          Top = 831.772037260000000000
          Width = 457.323130000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo145: TfrxMemoView
          Left = 598.409514240000000000
          Top = 832.417706550000000000
          Width = 37.795300000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parcela')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo146: TfrxMemoView
          Left = 494.889746200000000000
          Top = 832.417706550000000000
          Width = 94.488250000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Per'#237'odo de Refer'#234'ncia')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo147: TfrxMemoView
          Left = 603.189407940000000000
          Top = 842.866591350000000000
          Width = 68.031540000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<Guia."Parcela"> <> '#39'0'#39', <Guia."Parcela">,'#39#39')]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo148: TfrxMemoView
          Left = 511.142097940000000000
          Top = 842.866591350000000000
          Width = 68.031540000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."PeriodoReferencia"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo149: TfrxMemoView
          Left = 123.968627940000000000
          Top = 842.866591350000000000
          Width = 359.055350000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<Guia."DocumentoDestinatario">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo150: TfrxMemoView
          Left = 37.818967940000000000
          Top = 842.866525440000000000
          Width = 83.149660000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ/CPF/Insc. Est:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo151: TfrxMemoView
          Left = 676.693427940000000000
          Top = 853.425651350000000000
          Width = 7.559060000000000000
          Height = 109.606370000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'A'
            'u'
            't'
            'e'
            'n'
            't'
            'i'
            'c'
            'a'
            #231
            #227
            'o')
          ParentFont = False
        end
        object Line40: TfrxLineView
          Left = 492.583037940000000000
          Top = 855.205181350000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo152: TfrxMemoView
          Left = 86.952857940000000000
          Top = 855.205181350000000000
          Width = 393.071120000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."MunicipioDestinatario"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo153: TfrxMemoView
          Left = 37.818967940000000000
          Top = 855.205108120000000000
          Width = 45.354360000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo154: TfrxMemoView
          Left = 494.889746200000000000
          Top = 856.094871900000000000
          Width = 71.811070000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Principal')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo155: TfrxMemoView
          Left = 580.512227940000000000
          Top = 863.764241350000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."Valor"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo156: TfrxMemoView
          Left = 209.118096320000000000
          Top = 869.543771350000000000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Reservado '#224' Fiscaliza'#231#227'o')
          ParentFont = False
          Wysiwyg = False
        end
        object Line41: TfrxLineView
          Left = 35.259907940000000000
          Top = 868.653927020000000000
          Width = 457.323130000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo157: TfrxMemoView
          Left = 494.889746200000000000
          Top = 877.882273480000000000
          Width = 98.267780000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Atualiza'#231#227'o Monet'#225'ria')
          ParentFont = False
          Wysiwyg = False
        end
        object Line42: TfrxLineView
          Left = 492.583037940000000000
          Top = 876.882332060000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo158: TfrxMemoView
          Left = 124.748157940000000000
          Top = 880.882427260000000000
          Width = 355.275820000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."Convenio"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo159: TfrxMemoView
          Left = 37.818967940000000000
          Top = 880.882361350000000000
          Width = 83.149660000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Conv'#234'nio/Protocolo:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo160: TfrxMemoView
          Left = 580.512227940000000000
          Top = 887.441421350000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."AtualizacaoMonetaria"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo161: TfrxMemoView
          Left = 79.952857940000000000
          Top = 892.221017260000000000
          Width = 400.630180000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."Produto"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo162: TfrxMemoView
          Left = 37.818967940000000000
          Top = 892.220944030000000000
          Width = 37.795300000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Produto:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo163: TfrxMemoView
          Left = 494.889746200000000000
          Top = 901.559438830000000000
          Width = 30.236240000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Juros')
          ParentFont = False
          Wysiwyg = False
        end
        object Line43: TfrxLineView
          Left = 492.583037940000000000
          Top = 900.559541350000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo164: TfrxMemoView
          Left = 580.512227940000000000
          Top = 911.118601350000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."Juros"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Line44: TfrxLineView
          Left = 35.259907940000000000
          Top = 913.118601350000000000
          Width = 457.323130000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo165: TfrxMemoView
          Left = 38.700847940000000000
          Top = 926.236787260000000000
          Width = 449.764070000000000000
          Height = 30.236232680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."InformacoesComplementares"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo166: TfrxMemoView
          Left = 38.818967940000000000
          Top = 914.898131350000000000
          Width = 128.504020000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Informa'#231#245'es Complementares:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo167: TfrxMemoView
          Left = 494.889746200000000000
          Top = 925.236604180000000000
          Width = 30.236240000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Multa')
          ParentFont = False
          Wysiwyg = False
        end
        object Line45: TfrxLineView
          Left = 492.583037940000000000
          Top = 925.236692060000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo168: TfrxMemoView
          Left = 580.512227940000000000
          Top = 933.795781350000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."Multa"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo169: TfrxMemoView
          Left = 494.889746200000000000
          Top = 948.913769540000000000
          Width = 71.811070000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total a Recolher')
          ParentFont = False
          Wysiwyg = False
        end
        object Line46: TfrxLineView
          Left = 492.583037940000000000
          Top = 946.913901350000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo170: TfrxMemoView
          Left = 580.425647940000000000
          Top = 955.252491350000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<Guia."ValorPrincipal">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo172: TfrxMemoView
          Left = 212.677347940000000000
          Top = 955.472961350000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<Guia."DataLimitePagamento">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo174: TfrxMemoView
          Left = 38.818967940000000000
          Top = 955.472824660000000000
          Width = 162.519790000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Documento V'#225'lido para pagamento at'#233':')
          ParentFont = False
          Wysiwyg = False
        end
        object Shape3: TfrxShapeView
          Left = 35.259864000000000000
          Top = 370.559204500000000000
          Width = 457.322834650000000000
          Height = 230.551181100000000000
        end
        object Shape4: TfrxShapeView
          Left = 492.362567940000000000
          Top = 370.559231350000000000
          Width = 181.417322830000000000
          Height = 230.551181100000000000
        end
        object Line30: TfrxLineView
          Left = 571.952821330000000000
          Top = 371.559231350000000000
          Height = 22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo117: TfrxMemoView
          Left = 573.818884940000000000
          Top = 371.338761350000000000
          Width = 79.370130000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo da Receita')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo116: TfrxMemoView
          Left = 495.448806200000000000
          Top = 371.338758910000000000
          Width = 60.472480000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UF Favorecida')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo115: TfrxMemoView
          Left = 54.157366330000000000
          Top = 375.118286470000000000
          Width = 411.968770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[Guia."Titulo"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo101: TfrxMemoView
          Left = 573.818884940000000000
          Top = 381.897821350000000000
          Width = 52.913420000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."CodigoReceita"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo100: TfrxMemoView
          Left = 495.448806200000000000
          Top = 381.897821350000000000
          Width = 41.574830000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."UFFavorecido"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Line21: TfrxLineView
          Left = 493.448806200000000000
          Top = 394.236411350000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line17: TfrxLineView
          Left = 35.259907940000000000
          Top = 394.236396700000000000
          Width = 457.323130000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo90: TfrxMemoView
          Left = 495.448806200000000000
          Top = 396.015941350000000000
          Width = 60.472480000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#176' de Controle')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo89: TfrxMemoView
          Left = 199.669271320000000000
          Top = 397.015924260000000000
          Width = 132.283550000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dados do Contribuinte Emitente')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo102: TfrxMemoView
          Left = 561.819234000000000000
          Top = 405.575001350000000000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."NumeroControle"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo88: TfrxMemoView
          Left = 381.102474000000000000
          Top = 406.464743160000000000
          Width = 83.149660000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ/CPF/Insc. Est:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo61: TfrxMemoView
          Left = 37.818967940000000000
          Top = 406.464743160000000000
          Width = 56.692950000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Raz'#227'o Social:')
          ParentFont = False
          Wysiwyg = False
        end
        object Line22: TfrxLineView
          Left = 492.583037940000000000
          Top = 417.913562060000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo71: TfrxMemoView
          Left = 381.102474000000000000
          Top = 415.913562060000000000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<Guia."DocumentoEmitente">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo70: TfrxMemoView
          Left = 37.818967940000000000
          Top = 415.913562060000000000
          Width = 328.819110000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."RazaoSocialEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo91: TfrxMemoView
          Left = 495.448806200000000000
          Top = 418.693121350000000000
          Width = 86.929190000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data de Vencimento')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo103: TfrxMemoView
          Left = 591.850817940000000000
          Top = 427.252181350000000000
          Width = 79.370130000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<Guia."DataVencimento">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo72: TfrxMemoView
          Left = 86.952857940000000000
          Top = 427.252181350000000000
          Width = 393.071120000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."EnderecoEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo62: TfrxMemoView
          Left = 37.818967940000000000
          Top = 427.252144740000000000
          Width = 45.354360000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
          Wysiwyg = False
        end
        object Line23: TfrxLineView
          Left = 492.583037940000000000
          Top = 439.590771350000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo74: TfrxMemoView
          Left = 406.315257940000000000
          Top = 438.590771350000000000
          Width = 37.795300000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."UFEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo73: TfrxMemoView
          Left = 86.952857940000000000
          Top = 438.590771350000000000
          Width = 279.685220000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."MunicipioEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo64: TfrxMemoView
          Left = 386.197137940000000000
          Top = 438.401841350000000000
          Width = 18.897650000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UF:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo63: TfrxMemoView
          Left = 37.818967940000000000
          Top = 438.401841350000000000
          Width = 45.354360000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo92: TfrxMemoView
          Left = 495.448806200000000000
          Top = 440.614349460000000000
          Width = 105.826840000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#176' Documento de Origem')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo104: TfrxMemoView
          Left = 546.496457940000000000
          Top = 450.929361350000000000
          Width = 124.724490000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."NumeroDocumentoOrigem"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo76: TfrxMemoView
          Left = 407.315257940000000000
          Top = 449.929361350000000000
          Width = 83.149660000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[FormatMaskText('#39'(999\)00000-0000;0;_'#39',<Guia."TelefoneEmitente">' +
              ')]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo75: TfrxMemoView
          Left = 64.275677940000000000
          Top = 449.929361350000000000
          Width = 151.181200000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."CEPEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo66: TfrxMemoView
          Left = 364.519957940000000000
          Top = 449.929310090000000000
          Width = 41.574830000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Telefone:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo65: TfrxMemoView
          Left = 37.818967940000000000
          Top = 449.929310090000000000
          Width = 22.677180000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CEP:')
          ParentFont = False
        end
        object Line31: TfrxLineView
          Left = 594.629986680000000000
          Top = 464.267951350000000000
          Height = 22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line24: TfrxLineView
          Left = 492.583037940000000000
          Top = 463.267922060000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo67: TfrxMemoView
          Left = 218.566921320000000000
          Top = 465.267951350000000000
          Width = 94.488250000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Dados do Destinat'#225'rio')
          ParentFont = False
          Wysiwyg = False
        end
        object Line18: TfrxLineView
          Left = 35.480377940000000000
          Top = 463.511987260000000000
          Width = 457.323130000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo94: TfrxMemoView
          Left = 598.409514240000000000
          Top = 464.157656550000000000
          Width = 37.795300000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parcela')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo93: TfrxMemoView
          Left = 495.448806200000000000
          Top = 464.157656550000000000
          Width = 94.488250000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Per'#237'odo de Refer'#234'ncia')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo106: TfrxMemoView
          Left = 603.189407940000000000
          Top = 474.606541350000000000
          Width = 68.031540000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<Guia."Parcela"> <> '#39'0'#39', <Guia."Parcela">,'#39#39')]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo105: TfrxMemoView
          Left = 511.142097940000000000
          Top = 474.606541350000000000
          Width = 68.031540000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."PeriodoReferencia"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo77: TfrxMemoView
          Left = 123.968627940000000000
          Top = 474.606475440000000000
          Width = 359.055350000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<Guia."DocumentoDestinatario">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo68: TfrxMemoView
          Left = 37.818967940000000000
          Top = 474.606475440000000000
          Width = 83.149660000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ/CPF/Insc. Est:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo112: TfrxMemoView
          Left = 676.693427940000000000
          Top = 485.165601350000000000
          Width = 7.559060000000000000
          Height = 109.606370000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'A'
            'u'
            't'
            'e'
            'n'
            't'
            'i'
            'c'
            'a'
            #231
            #227
            'o')
          ParentFont = False
        end
        object Line25: TfrxLineView
          Left = 492.583037940000000000
          Top = 486.945131350000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo78: TfrxMemoView
          Left = 86.952857940000000000
          Top = 486.945131350000000000
          Width = 393.071120000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."MunicipioDestinatario"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo69: TfrxMemoView
          Left = 37.818967940000000000
          Top = 486.945058120000000000
          Width = 45.354360000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo95: TfrxMemoView
          Left = 495.448806200000000000
          Top = 487.834821900000000000
          Width = 71.811070000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Principal')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo107: TfrxMemoView
          Left = 580.512227940000000000
          Top = 495.504191350000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."Valor"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo79: TfrxMemoView
          Left = 209.118096320000000000
          Top = 501.283721350000000000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Reservado '#224' Fiscaliza'#231#227'o')
          ParentFont = False
          Wysiwyg = False
        end
        object Line19: TfrxLineView
          Left = 35.259907940000000000
          Top = 500.393877020000000000
          Width = 457.323130000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo96: TfrxMemoView
          Left = 495.448806200000000000
          Top = 509.622223480000000000
          Width = 98.267780000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Atualiza'#231#227'o Monet'#225'ria')
          ParentFont = False
          Wysiwyg = False
        end
        object Line26: TfrxLineView
          Left = 492.583037940000000000
          Top = 508.622282060000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo82: TfrxMemoView
          Left = 124.748157940000000000
          Top = 512.622377260000000000
          Width = 355.275820000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."Convenio"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo80: TfrxMemoView
          Left = 37.818967940000000000
          Top = 512.622311350000000000
          Width = 83.149660000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Conv'#234'nio/Protocolo:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo108: TfrxMemoView
          Left = 580.512227940000000000
          Top = 519.181371350000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."AtualizacaoMonetaria"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo83: TfrxMemoView
          Left = 79.952857940000000000
          Top = 523.960967260000000000
          Width = 400.630180000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."Produto"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo81: TfrxMemoView
          Left = 37.818967940000000000
          Top = 523.960894030000000000
          Width = 37.795300000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Produto:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo97: TfrxMemoView
          Left = 495.448806200000000000
          Top = 533.299388830000000000
          Width = 30.236240000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Juros')
          ParentFont = False
          Wysiwyg = False
        end
        object Line27: TfrxLineView
          Left = 492.583037940000000000
          Top = 532.299491350000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo109: TfrxMemoView
          Left = 580.512227940000000000
          Top = 542.858551350000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."Juros"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Line20: TfrxLineView
          Left = 35.259907940000000000
          Top = 544.858551350000000000
          Width = 457.323130000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo85: TfrxMemoView
          Left = 38.700847940000000000
          Top = 557.976737260000000000
          Width = 449.764070000000000000
          Height = 30.236232680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."InformacoesComplementares"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo84: TfrxMemoView
          Left = 38.818967940000000000
          Top = 546.638081350000000000
          Width = 128.504020000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Informa'#231#245'es Complementares:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo98: TfrxMemoView
          Left = 495.448806200000000000
          Top = 556.976554180000000000
          Width = 30.236240000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Multa')
          ParentFont = False
          Wysiwyg = False
        end
        object Line28: TfrxLineView
          Left = 492.583037940000000000
          Top = 556.976642060000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo110: TfrxMemoView
          Left = 580.512227940000000000
          Top = 565.535731350000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."Multa"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo99: TfrxMemoView
          Left = 495.448806200000000000
          Top = 580.653719540000000000
          Width = 71.811070000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total a Recolher')
          ParentFont = False
          Wysiwyg = False
        end
        object Line29: TfrxLineView
          Left = 492.583037940000000000
          Top = 578.653851350000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo114: TfrxMemoView
          Left = 580.425647940000000000
          Top = 586.992441350000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<Guia."ValorPrincipal">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo87: TfrxMemoView
          Left = 212.677347940000000000
          Top = 587.212911350000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<Guia."DataLimitePagamento">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo86: TfrxMemoView
          Left = 38.818967940000000000
          Top = 587.212774660000000000
          Width = 162.519790000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Documento V'#225'lido para pagamento at'#233':')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo113: TfrxMemoView
          Left = 84.818902030000000000
          Top = 604.110561350000000000
          Width = 291.023810000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              '[FormatMaskText('#39'00000000000 0 00000000000 0 00000000000 0 00000' +
              '000000 0;0;'#39#39#39',<Guia."RepresentacaoNumerica">)]')
          ParentFont = False
        end
        object Memo111: TfrxMemoView
          Left = 597.512184000000000000
          Top = 602.551501350000000000
          Width = 74.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '2'#170' via - Contribuinte')
          ParentFont = False
        end
        object BarCode1: TfrxBarCodeView
          Left = 37.818967940000000000
          Top = 618.330884890000000000
          Width = 441.000000000000000000
          Height = 49.133860710000000000
          BarType = bcCode_2_5_interleaved
          Expression = '<Guia."CodigoBarrasBoleto">'
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '858000000011000000901300800120130328190000028004'
          WideBarRatio = 3.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object Memo5: TfrxMemoView
          Left = 36.818924000000000000
          Top = 59.771680890000000000
          Width = 45.354360000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo6: TfrxMemoView
          Left = 36.818924000000000000
          Top = 70.921377500000000000
          Width = 45.354360000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo7: TfrxMemoView
          Left = 386.197094000000000000
          Top = 70.921377500000000000
          Width = 18.897650000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UF:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo8: TfrxMemoView
          Left = 36.818924000000000000
          Top = 82.448846240000000000
          Width = 22.677180000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CEP:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 364.519914000000000000
          Top = 82.448846240000000000
          Width = 41.574830000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Telefone:')
          ParentFont = False
          Wysiwyg = False
        end
        object Line2: TfrxLineView
          Left = 34.480334000000000000
          Top = 96.031523400000000000
          Width = 457.323130000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line3: TfrxLineView
          Left = 34.259864000000000000
          Top = 130.913413170000000000
          Width = 457.323130000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo12: TfrxMemoView
          Left = 217.566877380000000000
          Top = 96.787487500000000000
          Width = 94.488250000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Dados do Destinat'#225'rio')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo13: TfrxMemoView
          Left = 36.818924000000000000
          Top = 106.126011590000000000
          Width = 83.149660000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ/CPF/Insc. Est:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo14: TfrxMemoView
          Left = 36.818924000000000000
          Top = 117.464594270000000000
          Width = 45.354360000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo10: TfrxMemoView
          Left = 36.818924000000000000
          Top = 48.433098210000000000
          Width = 328.819110000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."RazaoSocialEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo11: TfrxMemoView
          Left = 381.102474000000000000
          Top = 48.433098210000000000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<Guia."DocumentoEmitente">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo15: TfrxMemoView
          Left = 85.952814000000000000
          Top = 59.771717500000000000
          Width = 393.071120000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."EnderecoEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo16: TfrxMemoView
          Left = 85.952814000000000000
          Top = 71.110307500000000000
          Width = 279.685220000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."MunicipioEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo17: TfrxMemoView
          Left = 406.315214000000000000
          Top = 71.110307500000000000
          Width = 41.574830000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."UFEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo18: TfrxMemoView
          Left = 63.275634000000000000
          Top = 82.448897500000000000
          Width = 151.181200000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."CEPEmitente"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo19: TfrxMemoView
          Left = 407.315214000000000000
          Top = 82.448897500000000000
          Width = 79.370130000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[FormatMaskText('#39'(999\)00000-0000;0;_'#39',<Guia."TelefoneEmitente">' +
              ')]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo20: TfrxMemoView
          Left = 123.748114000000000000
          Top = 106.126077500000000000
          Width = 355.275820000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<Guia."DocumentoDestinatario">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo21: TfrxMemoView
          Left = 85.952814000000000000
          Top = 117.464667500000000000
          Width = 393.071120000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."MunicipioDestinatario"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo22: TfrxMemoView
          Left = 208.118052380000000000
          Top = 132.803257500000000000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Reservado '#224' Fiscaliza'#231#227'o')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo23: TfrxMemoView
          Left = 36.818924000000000000
          Top = 144.141847500000000000
          Width = 83.149660000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Conv'#234'nio/Protocolo:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo24: TfrxMemoView
          Left = 36.818924000000000000
          Top = 155.480430180000000000
          Width = 37.795300000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Produto:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo25: TfrxMemoView
          Left = 123.748114000000000000
          Top = 144.141913410000000000
          Width = 355.275820000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."Convenio"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo26: TfrxMemoView
          Left = 78.952814000000000000
          Top = 155.480503410000000000
          Width = 400.630180000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."Produto"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Line4: TfrxLineView
          Left = 34.259864000000000000
          Top = 176.378087500000000000
          Width = 457.323130000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo27: TfrxMemoView
          Left = 36.818924000000000000
          Top = 179.157617500000000000
          Width = 128.504020000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Informa'#231#245'es Complementares:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo28: TfrxMemoView
          Left = 36.700804000000000000
          Top = 190.496273410000000000
          Width = 449.764070000000000000
          Height = 30.236232680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Guia."InformacoesComplementares"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo29: TfrxMemoView
          Left = 36.818924000000000000
          Top = 218.732310810000000000
          Width = 162.519790000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Documento V'#225'lido para pagamento at'#233':')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo30: TfrxMemoView
          Left = 210.677304000000000000
          Top = 218.732447500000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<Guia."DataLimitePagamento">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Line6: TfrxLineView
          Left = 491.582994000000000000
          Top = 49.433098210000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line7: TfrxLineView
          Left = 491.582994000000000000
          Top = 72.110307500000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line8: TfrxLineView
          Left = 491.582994000000000000
          Top = 95.787458210000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line9: TfrxLineView
          Left = 491.582994000000000000
          Top = 119.464667500000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line10: TfrxLineView
          Left = 491.582994000000000000
          Top = 141.141818210000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line11: TfrxLineView
          Left = 491.582994000000000000
          Top = 163.819027500000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line12: TfrxLineView
          Left = 491.582994000000000000
          Top = 185.496178210000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line13: TfrxLineView
          Left = 491.582994000000000000
          Top = 208.173387500000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line15: TfrxLineView
          Left = 593.629942740000000000
          Top = 96.787487500000000000
          Height = 22.677165350000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo34: TfrxMemoView
          Left = 494.448806200000000000
          Top = 50.212657500000000000
          Width = 86.929190000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data de Vencimento')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo35: TfrxMemoView
          Left = 494.448806200000000000
          Top = 73.133885610000000000
          Width = 105.826840000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#176' Documento de Origem')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo36: TfrxMemoView
          Left = 494.448806200000000000
          Top = 96.677192700000000000
          Width = 94.488250000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Per'#237'odo de Refer'#234'ncia')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo37: TfrxMemoView
          Left = 597.409470300000000000
          Top = 96.677192700000000000
          Width = 37.795300000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parcela')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo38: TfrxMemoView
          Left = 494.448806200000000000
          Top = 120.354358050000000000
          Width = 71.811070000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Principal')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo39: TfrxMemoView
          Left = 494.448806200000000000
          Top = 142.141759630000000000
          Width = 98.267780000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Atualiza'#231#227'o Monet'#225'ria')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo40: TfrxMemoView
          Left = 494.448806200000000000
          Top = 164.818924980000000000
          Width = 30.236240000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Juros')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo41: TfrxMemoView
          Left = 494.448806200000000000
          Top = 186.496090330000000000
          Width = 30.236240000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Multa')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo42: TfrxMemoView
          Left = 494.448806200000000000
          Top = 210.173255690000000000
          Width = 71.811070000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total a Recolher')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo46: TfrxMemoView
          Left = 590.850774000000000000
          Top = 59.771717500000000000
          Width = 79.370130000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<Guia."DataVencimento">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo47: TfrxMemoView
          Left = 545.496414000000000000
          Top = 83.448897500000000000
          Width = 124.724490000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."NumeroDocumentoOrigem"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo48: TfrxMemoView
          Left = 510.142054000000000000
          Top = 107.126077500000000000
          Width = 68.031540000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."PeriodoReferencia"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo49: TfrxMemoView
          Left = 602.189364000000000000
          Top = 107.126077500000000000
          Width = 68.031540000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<Guia."Parcela"> <> '#39'0'#39', <Guia."Parcela">,'#39#39')]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo50: TfrxMemoView
          Left = 579.512184000000000000
          Top = 127.023727500000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."Valor"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo51: TfrxMemoView
          Left = 579.512184000000000000
          Top = 150.700907500000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."AtualizacaoMonetaria"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo52: TfrxMemoView
          Left = 579.512184000000000000
          Top = 172.378087500000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."Juros"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo53: TfrxMemoView
          Left = 579.512184000000000000
          Top = 194.055267500000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."Multa"]')
          ParentFont = False
          Wysiwyg = False
        end
        object BarCode: TfrxBarCodeView
          Left = 37.818967940000000000
          Top = 250.629951040000000000
          Width = 441.000000000000000000
          Height = 49.133860710000000000
          BarType = bcCode_2_5_interleaved
          Expression = '<Guia."CodigoBarrasBoleto">'
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '858000000011000000901300800120130328190000028004'
          WideBarRatio = 3.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object Memo54: TfrxMemoView
          Left = 602.512184000000000000
          Top = 233.071037500000000000
          Width = 70.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '1'#170' via - Banco')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 675.693384000000000000
          Top = 112.685137500000000000
          Width = 7.559060000000000000
          Height = 109.606370000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'A'
            'u'
            't'
            'e'
            'n'
            't'
            'i'
            'c'
            'a'
            #231
            #227
            'o')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 84.818902030000000000
          Top = 235.858291400000000000
          Width = 291.023810000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              '[FormatMaskText('#39'00000000000 0 00000000000 0 00000000000 0 00000' +
              '000000 0;0;'#39#39#39',<Guia."RepresentacaoNumerica">)]')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 579.425604000000000000
          Top = 217.511977500000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<Guia."ValorPrincipal">]')
          ParentFont = False
          Wysiwyg = False
        end
        object Line1: TfrxLineView
          Left = 34.464564000000000000
          Top = 25.519692850000000000
          Width = 457.323130000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo33: TfrxMemoView
          Left = 199.873927380000000000
          Top = 28.299220410000000000
          Width = 132.283550000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dados do Contribuinte Emitente')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo45: TfrxMemoView
          Left = 36.818924000000000000
          Top = 38.748039310000000000
          Width = 56.692950000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Raz'#227'o Social:')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo58: TfrxMemoView
          Left = 381.102474000000000000
          Top = 38.748039310000000000
          Width = 83.149660000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ/CPF/Insc. Est:')
          ParentFont = False
          Wysiwyg = False
        end
        object Line5: TfrxLineView
          Left = 492.787694000000000000
          Top = 25.519707500000000000
          Width = 181.417440000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo59: TfrxMemoView
          Left = 494.448806200000000000
          Top = 27.299237500000000000
          Width = 60.472480000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#176' de Controle')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo60: TfrxMemoView
          Left = 561.819234000000000000
          Top = 37.858297500000000000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Guia."NumeroControle"]')
          ParentFont = False
          Wysiwyg = False
        end
        object Memo175: TfrxMemoView
          Left = 492.000000000000000000
          Top = 234.000000000000000000
          Width = 102.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          ParentFont = False
        end
        object Memo176: TfrxMemoView
          Left = 492.000000000000000000
          Top = 602.551501350000000000
          Width = 102.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          ParentFont = False
        end
        object Memo177: TfrxMemoView
          Left = 492.000000000000000000
          Top = 971.000000000000000000
          Width = 102.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          ParentFont = False
        end
        object QrCode1: TfrxBarcode2DView
          Left = 563.149970000000000000
          Top = 245.448980000000000000
          Width = 114.000000000000000000
          Height = 114.000000000000000000
          StretchMode = smActualHeight
          BarType = bcCodeQR
          BarProperties.Encoding = qrUTF8NoBOM
          BarProperties.QuietZone = 0
          BarProperties.ErrorLevels = ecL
          BarProperties.PixelSize = 2
          BarProperties.CodePage = 0
          DataField = 'QrCode'
          DataSet = frxDBDatasetGuia
          DataSetName = 'Guia'
          Rotation = 0
          ShowText = False
          Text = 
            '00020101021226910014BR.GOV.BCB.PIX2569qrpix.bradesco.com.br/qr/v' +
            '2/cobv/936bbec2-d499-49db-99a8-59d0de9c5ac852040000530398654040.' +
            '465802BR5924SEFAZ RJ - SECRETARIA DE6014RIO DE JANEIROXXXXXXXXXX' +
            'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX62070503***6304F8DC'
          Zoom = 1.000000000000000000
          FontScaled = True
          QuietZone = 0
        end
        object QrCode2: TfrxBarcode2DView
          Left = 563.149970000000000000
          Top = 613.488560000000000000
          Width = 114.000000000000000000
          Height = 114.000000000000000000
          StretchMode = smActualHeight
          BarType = bcCodeQR
          BarProperties.Encoding = qrUTF8NoBOM
          BarProperties.QuietZone = 0
          BarProperties.ErrorLevels = ecL
          BarProperties.PixelSize = 2
          BarProperties.CodePage = 0
          DataField = 'QrCode'
          DataSet = frxDBDatasetGuia
          DataSetName = 'Guia'
          Rotation = 0
          ShowText = False
          Text = 
            '00020101021226910014BR.GOV.BCB.PIX2569qrpix.bradesco.com.br/qr/v' +
            '2/cobv/936bbec2-d499-49db-99a8-59d0de9c5ac852040000530398654040.' +
            '465802BR5924SEFAZ RJ - SECRETARIA DE6014RIO DE JANEIROXXXXXXXXXX' +
            'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX62070503***6304F8DC'
          Zoom = 1.000000000000000000
          FontScaled = True
          QuietZone = 0
        end
        object LogoPix1: TfrxPictureView
          Left = 532.134200000000000000
          Top = 259.448980000000000000
          Width = 26.456710000000000000
          Height = 68.031540000000000000
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000177
            000003F5080200000015453853000000017352474200AECE1CE9000000046741
            4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
            00442049444154785EED9D5DAEDD44DEAF7B083D0486D04360080CA187C00C7A
            087D73742E4EABD58DB82042E20D52A40445E1A349080A42900F89085A49D42D
            C8053B02B41162072EFAFC9AAAD7985A6BD9E5B2AB5CFFAAE7D14F51B6F7F2DA
            6BB9CA8FABCA65FB77FF0100C809960180BC601900C80B960180BC601900C80B
            960180BC601900C80B960180BC601900C80B960180BC601900C80B960180BC60
            1900C80B960180BC601900C80B960180BC601900C80B960180BC601900C80B96
            0180BC601900C80B960180BC601900C80B960180BC601900C80B960180BC6019
            00C80B960180BC601900C80B960180BC601900C80B960180BC601900C80B9601
            80BC601900C80B960180BC601900C80B960180BC601900C80B960180BC601900
            C80B960180BC601900C80B960180BC601900C80B960180BC601900C80B960180
            BC601900C80B960180BC601900C80B960180BC601900C80B960180BCB460992F
            BF7A7AF5DAF5BFFCF5EFFFE7FFFE3F974BAFBF71F7DE838B8BE7FE15609C870F
            3F57990EE5ABA8C455EEFED75037B62D238FDC78E7BD71E51BE795575F3B3B7B
            E65F0A365109067E1947AEE158523FB62D3351FF5CD4C041347651D98D9BA847
            A33A80682AC7B065EE7CF47150E18E462D1A6AA151668F222E376FDDF62B4095
            58B5CCF9F97950D526221FF9D5C00E0F1F7E1E94E344541FFC6A501F562D73F7
            DE83A09E4D44CD19BF1AD821B221E352797326F8B469B13BDA6DD53257AF5D0F
            CA603A749ACC1194E0742EBF79C5AF5625C1A74D0B96298D6A555006D3E1ACA7
            3982129CCE5FFEFA77BF5A95049F362D58A63458A67982129C8D5FAD4A828F9A
            162C531A2CD33C4109CEC6AF5625AAAEEB63774E0696814A094A70367E35A80F
            2C03951294E06CFC6A501F58062A2528C1D9F8D5A03EB00C544A5082B3F1AB41
            7D6019A894A00467E35783FAC03250294109CEC6AF668DF3F3F33B1F7DACFA3C
            1BCE3195461B3DA864D3C132E6084A70367E35532CBA56CB6E1DC63250294109
            CEC6AF6687478F9F045F613A58A63458A67982129C8D5FCD0EAFBCFA5AF015A6
            83654A83659A2728C1D9F8D58C7076F62CF8FCD351C3C7AF69102C03951294E0
            6CFC6A46086E5DF2F0E1E75A38D4EAA1BA0E379C357DA72E2C03951294E06CFC
            6A4618DFE971B8CBDA70FBD1A1BA0E325285774B2C8265A05282129C8D5FCD08
            E30A3CDCE86F58325457FD6758E8965804CB40A50425381BBF9A11C615D82F1A
            7DE5616ACCC5C5F3C385E6C03250294109CEC6AF6684A1025F7AFD0DBF68F495
            FDCFBF302CB43B008C65A05282129C8D5FCD084305D67FFCA2139619EE7F6CF7
            26F958062A2528C1D9F8D58C306D99F16DAA87576299D26099B6198F4744C6AF
            698469CB8CAB2B6D99DDC0326DA3F20A4A703AE37DD50443051E3FC667F83A77
            EF3D704BC6B6C532A5C1326DD3BC65A48CE1C3FB45BF55CFF9F9B914337E0C3C
            9629CD52CB0C070730419F96193BE5306E7EB045AC5AE6E6ADDB41194CC7EE71
            A04F163D3B5469C332D35769DB7D4AAF55CB8C0B292657AF5DF76B82059696AF
            B9CB7CA40CB5D75CFCA25F38F5DC5EAE63DA81A5C7BAF1DC27A89FA53DE266DA
            AA1717CF0F45A3AD313EB76D0EAB9659DA6F57FC9A6081E1BAC1C898BE31C221
            0F1F7E2E6FBA048D1D8B58B58C1A9C413D9B4D03A5D5094BEFBDA250B83563D5
            3262E9E1AE994675F32CED0E2B7E4D3BDCBC755BFD2097C61A628718B6CCD2AE
            3B433356B87AED7A5076D3B158B2E3DADB7C43CCB065D43619CA293276CF05F6
            43C2B50537DE79CFAF6C87B16568CBD4CBF4E482A3616E5EFD2C7A78888BC5E9
            6AE36364F37D79C3964938E88DAF19813A59DA11562C3651C732C53255935023
            3919513309A70E8D1E39C6E7D19A9F326ADB320927232426BF32D4C7F4853C47
            637752EC7092B4F926B66DCB241CFA149A337592569A76EF863B3E95667A6AEF
            2CB62D234E5DF731119A337592D090B1DB0A9056965EF16BF7E868DE32099D26
            85E64C6D24CCF755EC7697540383EF321B2CB31B09679A144E36D546C240BE62
            770214963146424B5BE182837A486B909AEEF96219632414988BDD626B09F595
            965E92E662F7DE7142DF5A965C14BBE3DC2D5846A80C822A1813F59BDA1EDBAF
            1F6DFF84F17B853EAF211AB14C7273467AF26F017B90D6DB554C37647AA311CB
            88B4E68C62F15ABB36587A2A77080D195BB46399E4E68C8268CA937055E4907E
            1A32E7276E0F6C8B762C2396DE97641C445392358A69A3933B3E284E1864BCA1
            18FDAD02893FED6C850BA229C31AC5287677B631919619BFCCEE6D689AB28C48
            B8B5D5388826372B156377B26F408265ECCEF06ACD3222EDCCE81044938F958A
            6969E60196B14DF22CAF218826072B15A34CEC8DE688B4CC78A36199BA489BB1
            3E0EA2D996F58A69EC8A9018CB04C74B2C531DD2C4503C6941345BB15E310D9C
            579232F42D868CFBF5FAFFF8572E871D7FBB77AD6ED632C953D7C74134EB59AF
            98368663C68D97B4D8BD00BD59CB889527B65D10CD1AD62B4625D8DEA9EB8498
            BE3770CB9611EB4782154493C67AC5281323A3B658631975A04CB7E61AB78C40
            34BBB08962F426FEEDEC338CCB2CAA8D6AC234B011DAB78CD8A4C6239A7850CC
            2CE3A64D33EDB55374611981688A816262C0326D82680A806222C132CD8268B2
            8262E2B9B8782EB9B83473D9C429FAB28C4034994031708AEE2C2310CDE6A018
            98A047CB0844B32128660DE7E7E777EF3DB87AEDBA3BCF3D11BBB3133BB58C40
            349B8062D67067C9ED90EC0E12F76B198168568262D6B0F4CE0158C62A882619
            14B3868B8BE74BA7A46319C3209A0450CC4A12362096B10DA259048A594FF02C
            AACB6F5EB12B9159B08C07D144826236415A19B6C6A5D7DFF04B1B05CBFC0AA2
            9905C56CC5D832CD6F102CF31B10CD04286643C69669B8AFE4C0322188E62828
            665BC6CF41C5323D82680250CCE68CE7E361994E413403282607E3AD6AF7E104
            916099933C7AFC845B79A2984C9C9D3D1BB64F338FE53D059699A2F37B06A398
            AC0C9BE8B2FDA74D4D836566E85634282637E3D34C7E51A36099793A140D8A29
            C07800589D26FD381D9EFAD6385D8906C51440356AE9B34FB98EA97D3A110D8A
            298394116CB4D960992E685E3428A61858064ED2B068504C49B00C4CD1A46850
            4C61C64F4A898CDD07AA6099141A130D8A81AC6099449A110D8A81DC6099741A
            100D8A810260995598160D8AA9938B8BE78D3DD316CBACC5A868504C3D68335E
            BD767D5C8BBEFCDFD349C3D0AFDD89BF02CB6C8039D1A0984A50CD393A0378B0
            CC70AD9334E4965804CB6C8321D1A0984A50B7E895575F0B36ACCB6099E1967A
            A6EF408E6536C38468504C3D040F4B1967B0CC9DD115956E8945B0CC96542E1A
            14530F6AC88CAB8AFE7FF44EC0E322E39A6CF0542B1A1453158F1E3F19B6AA8A
            DB9D541A960C96D17F0E179A03CB6C4F85A24131B5317485545586F3D6C3A63E
            6A19BBDB1FCB64A12AD1A0980A51E1BA0D3B2EE5616B0F969180868512935B68
            0E2C938B4A448362EA6438453D76C7B0C1C79DA36121968123EC2E1A14532D58
            06366347D1A0989A89B40C3D26886217D1A098CA89B48CFE332CC432304561D1
            A098FA5169BAED3C9ED43B6CFCC13277EF3D18166219986113D1C4ECF928C604
            52C6B0B55537DCC261C96099F12508761F748B65CAB189681E3D7EE2DFEE18FA
            13C1EB1382620A302E29D50AA79561897EBCB8783E9E0DEC16BA75CD81658AB2
            5E345AFDD44C73D5CB32CD25D884E052C971D91D5EA8ADDFFAD50C82654AB35E
            34974F3C563938F42504C5946451DFD6EEA08CC0323BB05E34873A185F179316
            14539E610C783AA66FFB20B0CC3EAC148DD61D2E7E719CBA53496450CC5E4CDC
            FFC1454DD4A0ACCD81657663A568C64DE8456DEFC3A0987D393F3F57A3E67098
            460BED8EF88EC1327BB246345AD1BFCBBA860C8A81DC60999D59231A27081DEE
            82E5F1413150002CB33FC9A2518F5DAB478E201E06C54019B04C154834810222
            A375D30C85624A727E7E7EE7A38F87F8A5738C3BC2D3B3312B07CBD48276FBA1
            4AC5475536581213145398A057EB97CE319E0015EFA60AC13215317B52F33009
            0D19D7CF8292A459667C08393515D30458A62236B9446036A69F526894B165D4
            0FF24BE718CFB48C5FAB42B04C5D24346716E5C6EA5B7C420269AD9260B4CE2F
            350896A98B35A7A563C288CC2E24F77D86B514D50DBFD41A58A63AC6156BF3E8
            F0E8FF0C1424D932E3D34C58063663A85539E2FF069425D9327AF1B0A2DEC42F
            B50696A98EA156E588FF1B50162C03157131BA677D8ED063DA052C0315B1FE36
            31D361F47717C69659744E1ACBC0F6245F941499450752D88A606277FCFD62B0
            0C6CCCF9F9F950A5F2854E537982090AF117258D67696219D880841BF78ECF74
            4686E64C7982E1B6C822085A403C2905D6327EBE577C828A181966009727782C
            C1EC0099C4141C42982F03AB4893859AD35A37A139A3209AC28C07805D2644A3
            BEF3E1C352FCEF0C8265F6274D318A3345F2A54F88A6244707DDA412B561D548
            19A2CA70B4E36CBAB0B0CCCE242B46714DE8E43B602988A62487CD99F898BE92
            1ECBECC91AC58CA75D8CCF772E0DA229C6C5C5F3C37E504CEC9E5D726099DD58
            A31845ABFB375A7D2537A2294682681A281D2CB30F2B1573387F744D73464134
            2551DB24E676652A65D3B7FB1DC0323BB052318A1B9119B3B239A3209A92A851
            73F7DE83A3C706C94565316EAB5A07CB9466BD624EDDB877FD7DF610CD5EE820
            A1483DFEE7B6C0324559AF181DE84ED5C5E4C1C571100D6C0E9629C77AC5A833
            3F7D15927EBBFEFEE48806B605CB1462BD629498BE3AA281DAC0322528A618C7
            2637A94134B01558263B8515E3D8E48F221AD8042C93975D14E3403450095826
            233B2AC68168A006B04C2E76578C03D1C0EE60992C54A21807A2817DC132DB53
            95621C88067604CB6C4C858A71201AD80B2CB325D52AC681686017B0CC6654AE
            1807A281F260996D30A11807A2A993F3F3737765767BD76763990D30A41807A2
            A907D9E4CE471FBF72EC4114975E7FA364ADC80796598B39C538104D0D9C9D3D
            9BBD59875E60BD5D8365566154310E44B32FF1F703B2FE38502C938E69C53810
            CD8E2C7A70CABEF564255826910614E340347B71781B20B5596EDEBA2DFB1CDE
            0F58AD1EBF9A41B04C0ACD28C68168CAF3E56FEF067FF5DAF560F0453F6A938E
            5F63F7C16F5866318D29C681680A33EE2E4DB453C6E79EEC3E3505CB2CA349C5
            38104D49C60F9C98A80F77EF3D185E2631F9A5D6C0320B6858310E44538CF1C8
            CBC489EA71C70ACBB44FF38A71209A328C2DE3179D60781996699C4E14E34034
            05C032F01BBA528C03D1E406CBC0AF74A81807A2C94AA4651897699F6E15E340
            34F9189F63924AFCD20338C7D4389D2BC68168322165C46C1FE6CBB40C8A1940
            343908E6FE1EAD2ADA68E3D730F7B729504C00A2C941701DD3A5D7DF5003479B
            5AFFAA3F15DC71463FFAD50C82654250CC5110CDE6044D95E9DCBDF7C0AF6610
            2CF31B50CC0488665B2E2E9E1F5E967D34A62FC81658E65750CC2C88665BCECE
            9ECD8A462FD0CBFC0A36C1321E141309A2D996F3F3F3ABD7AE07DB678836D4C4
            554E56C032FF05C52C02D16C8E54F2E8F1933B1F7D3CE4CB861E638065504C0A
            8806E2E9DD32282619445300B5685CEC4E96115D5B06C5AC04D124A34D77F9CD
            2B2E1383BBC3D8B05EE61719A45FCBA0984D403469DC195D61A0A68A5F7AC070
            51A574E31719A453CBA0980D4134098CAF969CE80D8D5F667730B847CBA098CD
            41344B191A298A5F748CC8264FE574671914930944B38848CBC82CC3CBECD6BA
            BE2C8362B28268E249B08CDA357EA9353AB20C8A2900A28904CB34088A2906A2
            89616C998933D958C60C28A6308866167DBBE19B4E54ADF196C432F582627661
            93CD6E77BF9A455F6DF89A6AD7F8A5078C9B3C58A65250CC8EB0F12778F4F8C9
            F86B1E6DB88D6F2DAED8BD9155CB965177775C486941316BD8443476EFAA3D4D
            706799575E7D4DAD9521C11D3915BB779969D632E7E7E7B3F7079A0D8A59CF7A
            D134701BA7A34825C1379DC844AFAA7EDAB4CCC5C5F34BAFBF1194D3D2A098AD
            582F1A1DD89BB9D9CA80BED16183E554EC4EFC156D5A667CF5475A50CCB6AC17
            CDD56BD7FD7B3584DA6831A2B15E1B1BB44C30AE9610149383F5A2317D1FFF53
            A84573E39DF74EF5EED55132DD8A71B4661995D9CAE11814938F95A251C99ABE
            99D334B2C978F45707CB66BE6C6B9699B851734C504C6E568AC6F42068B73465
            99F174EC84A09832AC140DC5648EA62C133F627F18EA6E49D68846FDA6F6CE37
            B54D3B9609264A2E0A8A29CF1AD1DC69EBCA83E01929A7627798A611CBAC19F4
            45317B912C9A668681E597F87A6BF76453239691E98322894CF37718A89C9E0B
            6EE9940B2CB327C90D194E58D440F26941EBA3334B2B2D96D993B486B7CA9841
            C41A5029A40DDBAB1DE4DFC220097347B1CC9EA4D55115B35F1FF6266D0A828E
            137E7D83045D45D5611D2CB51D2662F7A068DE32DAFAE3D28A4C9317C59826ED
            D233BB23F7E3DB5349316D37ABCD5B667C67C3C8E818D8F04475A368374B185C
            B33BB236B64C93D7678DB16D1955CDA1A8E263BA3FDF3069339E8C1E30C69651
            7BDC2F6D14DB964918F765D0B7661286D88C3604B08C19124E82D290A99984C3
            86D14ED378F417CB544D424F9E864CCDA48DCE582CD371F7D0EE187624862D93
            70768999BEF59370B2C9E2A48471ED6DBE7D6DD832C18C83983047A67E129E3C
            2131F9954D317C7EBB67CA22316C99F1F8594CD414F76B42DD2CBD33BC5EEFD7
            34C5F0359BAF99862DB3B4034F77C90A09AD54BFA629C67DC3D989BF8ADD2145
            AB96393F3F1F4A28327497AC90D069D24EE85736822AF0D233A4E6BEE38055CB
            688B0765301BCE2E19626943D5DC699A840A8C654AB3B4516DB4EBDE2D4B07DD
            CC9DA6C13206587ABE9341195B2C3D8A983B4D83650CD0FCB1AE73964E023667
            99F3F373D5C945B17B896F2F96B17B1CE893A5877AA629D48C55CB2CBDAC0ECB
            D8E262F9D5F67E4DA80FAB96096AD86C38C1648EA00467E35783FAE8C5327E35
            B0435082B3F1AB417D6019A894A00467E35783FAC03250294109CEC6AF668D2F
            BF7A7AE39DF7622EDDE24C76698202988D5F0DEC1094E06CFC6AA65874D76A2C
            539AA00066E357033B0425381BBF9A1D963E9209CB94262880D9F8D5C00E4109
            CEC6AF6687A5B331CECE9EF935AD8165A05282129C8D5FCD0887D79D4B3AC335
            A2975E7FE3F29B57946189E9BB766219A894A00467E35733C2F8BEBF5289EB0D
            0D33DA87CED1307063FA423C2C03951294E06CFC6A46B833BA1C7468A70C4B06
            CB0C32327D53012C03951294E06CFC6A46185F88375C06392C192CA3FF0C0BDD
            128B6019A894A00467E35733C2D8327ED1E82B8F077A8785837ACC8165A05282
            129C8D5FCD088365C65DA1A3DF655868770018CB40A50425381BBF9A1106CBE8
            3F7ED109CB0CAFBC63F61E4958062A2528C1D9F8D58C306D99F10DABB0CC6E0C
            E51119BF1AD82128C1D9F8D58C306D99F110CC30790FCB9466288FC8F8D5C00E
            4109CEC6AF6684C13292885F347A72C3DD7B0FDC12356ADC1205CB9466D8F491
            F1AB811D82129C8D5FCD08E3F9327ED1483DD2CDA3C74FD4A219962858A634C3
            A68F8C5F0DEC1094E06CFC6A46386A99E92773D87D6C2196814A094A70367E35
            231CB5CC780EDE6178826D698202988D5F0DEC1094E06CFC6AC6197791C6B1DB
            5D1258062A2528C1D9F8D58CA306CBA168D493F2BFB60996814A094A70367EB5
            26383B7B76F7DE03B55F1E3EFCDCEEC3DE06B00C544A5082B3F1AB417D6019A8
            94A00467E35783FAC03250294109CEC6AF06F58165A05282129C8D5FCD3EE7E7
            E75F7EF554696044C68165A052621E51348E5FCD326767CF82134CDA08766F2A
            3E60D532A7A6151C8D5EEC57033B5CBD763D28C7898CAF06AA192963FCBDF4B1
            8789306AB90CD7318DA385D64563D532E39B33CF66B8F60C0CF1F0E1E741394E
            C4C48C12C9E2A847DC9DC3279E0067C5A1A7B06A998B8BE7470BEC307A99DDA9
            D99D33DCF4603A2A62134318137DC0D9A3A6DD8B988455CB88C847F3992E9ECE
            D1C13F28CDA33171ABCAC8EA7A2A3C296537661BD5766F950A0EED9CD38D562B
            453C7DBDF5107D59770BABE052039E94B2273ADC1D1D09D642EB6366E0506FE8
            E898858AD8ED90260894E19AD8870E1D4B535F7CFC2BBFD420E62DE35079A878
            EE7CF47133977E4080CA54FBA4DD221EDB642CC7A027157CAFF1C8945F649046
            2C035039832C0E7D31F1AB710BC82F3208960128C1200B89C32FFA5F261A2C63
            CBD81D01C032002518647168998906CBF8578606A102B00C40090659601900C8
            C2200B2C0300591864816500200B832CB00C00646190059601802C0CB2C03200
            90854116C9C132003045A08C846019009822504642B00C004C11282321580600
            A6089491102C0300701C2C030079C1320090172C030079C1320090975C9679F2
            E30F7FFEF73F5FFCE47DE5A5FB1FEAFF5AE27F07003D91C5322F7F71FF776FFF
            CF61FEF4F833FF0A00E886ED2DF3C7CF3E0EE4328E7EEB5F07007DB0B165A615
            E3826800BA624BCBC428C605D100F4C3669689578C0BA201E8846D2CB354312E
            8806A00736B04C9A625C100D40F3ACB5CC1AC5B8201A80B6596599F58A71A944
            34E7E7E75F7EF554B97BEF817BEA3BA9368F1E3F31F740FE311717CF15FF43EB
            A45B662BC5B8EC251A55D69BB76E8FEFE14C0CE5D2EB6F18BDEB8A3EF65FFEFA
            77E9B207D7245A665BC5B89414CDC3879F5FBD763DA8B2C468749CF0E56A0759
            C67DF81E5C9362991C8A71C92D1A95A54A54E53A5450D246CC8926A88A6DBB66
            B165F229C6E5E52FEEFBBFB429F8A5F958EC3A75E29A659679F79BB3400A39A2
            BFE2FFDE463C7AFC04BF341F75817D795BA379D72CB3CC4BF73F0C8C90231BF6
            9B54548CBFF413D37B66C3AE596699400799F2C2076FF9BFB78EB3B3673461BA
            8AD1F34D639A744D8D9651FCDF5BC1C3879F0F958F7492062CE368CC356D5A06
            C5F499662CE39056EEDE7BF0CAABAFB96F67D735CB2CF3FB7F5C097490237FB8
            F3B6FF7B49A0986E63BD671110B4685CF4E3A3C74FFC2B8CB0CC32B94F63BBAC
            B971278AE93697DFBCE22B817D02BFB8568CEAF6D0AEB9F1CE7BFEA516586699
            273FFE90BB39A3F7FFF6E79FFCDF5B881CEFCA8074187347F8538C6D72D84BD2
            8FEE57FA8F5F543DCB2C23FEF6F45F8117B64DF26499F3F3F3A06D49FA89AD63
            FB29A6FD3270F7DE03F7022B3DC4C59611F944A377F67F6339975E7FC3150FE9
            2D0D2866EC17F78DA6AF38772FB6D27C4BB18CC8219A358A199A91A4ABE878AE
            03BBAF0436F9F2ABA78BFCE2B879EBB65E6CA5D3946819B1AD68D62846A53214
            D2FAA84D74F9CD2B2A3F5279AC0FC4C82FE35B8E44FAC5A1AFAF55F4AFFFB96E
            D22D23B612CD1AC588F57787D1215165DCCCF021D48F1433543F55E0A5337D3A
            B28C582F9A958A1997564226C6D800F2E1EA6D825F1CBDF49806D68866A562C4
            9A86CCD56BD7F10BEC823A47697E719C9D3DD3EA2D9F633A244D34EB15A36D1D
            88233ED6470D01ACB08D65C452D1AC578CB8F1CE7B813B22F3F0E1E7FE2D002A
            40C74BD549F58086AC69E9D4C6669611F1A2D94431E22F49D3F0500CD4C3A3C7
            4FC667B2C76966D0704BCB8818D16CA518154F502A31B178276A6895A0317EF9
            CD2B2EE329A6FABF75D16C6C1931219ADFFFE3CAE5AF376B0726749754607E65
            80BD71170A286ACB1CCEA29059D49071AD75EBF5767BCB884FBFFFEEC54FDE0F
            14A3254F7EFCC1BF620B4EB53327D2525F174C23890C069968AA0CF77B34DDCD
            CF6219879CF2EE37676ADAE8DF6DFD2212E6FBAA21EA5706D81B59C355CBD9F9
            BE6AD1E865A69B33192D9395844119A6F6423DB86975EAF5FB9F4FA3968EABC0
            F1D71FD48655CB38C1C747CD4EBF264005B8D9A4AAC6FEE749DC8BED1E26AD5A
            66E9D0AFDD87F540933871440E14BA636AA4922AC4AA655C21C5C76E09419360
            19032CB50C6797A02ADCC30823CF1C61997DC032609A45E2C032FB8065C0346E
            4A5ECC39268165F601CB80695421552D558DFDCF93B8D3DE76EF22806500F6C1
            D54CFFC324AEB6DBADC35806601F2EFD7249E4D9D933FFF369DC450676AF99C4
            3200FBE0E67CCDF6835CDF8A2B0C7600CB8021545D0FE32EF7D5BFC1F220EE65
            A6A795621980EC04B5312D76EB309601C8CE9DD1AD3693C3D592A5C1320056C0
            320090172C030079C1320090172C030079C1320090172C030079C1320090172C
            030079C1320090172C030079C1320090172C030079C1320090172C030079C132
            0090975E2C63F70E40D000C1FDA8D2C25DAC4AB3D4327E35803D086A635AECB6
            C7AD5AC63D072B32A6EFFF0E0DA083E261DCF34F543983E541DCCB6EBCF31E6D
            99D29C9D3D1B24321BBB0FE58386719573F6294BEA2B59AFC3562D23DCE36C66
            F3CAABAFD97D5C16B48ABA3FAA9C31ADEC478F9FE8953C29651FE40EF774BE89
            A8B519F3EC3E80C2B8A7F1ABE3EF7F3E8D3A4A7AA50E96FE678318B68C9068D4
            711D9C1244058362A04E5C3F48FFFA9F27E109B6FBF3F0E1E76A4F0E7251D4C6
            D1B1A2B65291F2D44ED6A775272695F120DF8ED1D61B3E92DAE7FA909CF8CF8D
            36BB2A6AE469A3452FAE90162C33E07663FFC3DE6847D51EEB54E21E426A2E92
            B51390B62A635BDBB2481C914FD4AE96A62CB33B328BAA82F64CD7C46D2C92CE
            CD5BB7A54E8CB39E459691E8F562FDEB7FB60696D900B5A1B4FB196DB0A4453B
            897C4AC72A192C0351681FEB4D2E87D1DEF2F0E1E7B46E96B2A81384657A44FB
            953B161117F510B5DB70462F1E278E9833D9422FD38BB14C17E888AD92EEBCF1
            321DC9F7D1E3277E7BC169D457D2E6525DF23F4FE2E6856199C6717E69724C37
            47B4F3A8B9E7B71D9CC055A7D9A119E723C56E5311CBCC805F92A32370E4E866
            9FA85E692BA96A4D0CA2ABFAB9864C64ABA74EB0CC143A20D33F5A19F5A13815
            751419C4D52E89E6E808FAB8FA99EE876299E3A875CAF8EE86D171FB702F0255
            B3713359556EC8B050B1DEFDC43247704D59B26D7458A6037588E43B71778136
            7A9D58E637E8D8E2BAC124536EDEBA4DA3E6106D13773DCA10B55F9AE9696299
            5FB9FBCBC5F82477D4A861664D576099FFA22349705537C91DBBD7FEC152B00C
            BDA4DD72E39DF7E83DF540EF965167B8E45C1875162EBF79457BD7D0F7FEF2AB
            A7BB67180B383CBB913BF23BA239FFE5527ED50AB7FDAD9F513AA46BCBA83883
            4ABF79A415D51ED521EDCCFEAF5A40F5DE0D4616904ECFC33432ACBB46691C6D
            76FFEB5F50CDD142F5E8FDCF06E9D7322ACB71D16E1BD50999A5997304AAE859
            AF3E5773B24FD10C5D756D5B6D61E7F4C032AA45EE05FE6783746A9989190A6B
            E29ABB0D7701E402ED0C39FA981D8A6638CE0D03E16E496019E15EE67F30488F
            96D95C31DA43B4EF35D372894132DDBC33D59B689CACC7E7DA4E59C63579EC6E
            9CEE2CB3AD6254515427BA1DBF544F6AF3EDD989681EFDF294A5A01F74CA324E
            E8B686F6C6F46599C391B6E474EE9731F2C286ED9A4E44E384A20AE97FFE8553
            9639B5DC0A1D5966C3334A3A80E397001D69B71A1EEE41346E166870A53596B1
            8D6BA0AE8F7AC89D34E9D3D09E2047041B2D21CDCFA339DA09C23286911736A9
            FA768BB924E7E7E79B74A0241AFF8E2D82659A4287C4F52D79BD034D9845B81D
            6365D433F56FD71C58A629D65F06A97760142601ED42EB9B90ED4DB777302ED3
            0E7757DFCCC16ED1D6807A4FC3F4D6B4B43A12ECC411798EC9357CB04C8DA876
            BA9A9A9C560FA4255133706573B2C9011A35F4F4D562E6CB6803BAED1074AF0C
            D1B265D61C457508B55BA815B272F29EDDC3F804AE3B393BF7D74DF2D28BFDCF
            0669D632AEC0D2D26A2B7D5F568AA6BD1219BAF313D7310DAF09D4638B362DB3
            A6AF8462F2B146344DF69B860DA2AE933CE27ED4BF6A47CB2F4363DCFA776FD3
            326BE66BD051CACA1AD1983E9E9F62F6AA97064E7136689935571230DC5B80E4
            63809A994D5EF8AE2F25D7049B45ED17D7A8F12FB24C6B9691F5DDA05A429A3C
            545688CA2879605E3B9E7F17B0436B969129827A1919B54BFD5B407E74F44E3E
            18B4316AA656B3EA6A934DB3439AB24C7243E695575FB3DEF53547F2F5ABEA59
            F8B7B08CEB1F753208D89465921B329C54DA85D981CF536960E77496E9641CB0
            1DCB243764188ED991B4019A069A33EE88D849DD6BC732690D19EB3311AC933C
            B3C97AF3D34DB7EB6430BB11CB243764E82BED4E5ABFC9FAFEE9F4DAC941AE11
            CBA4CD9151FDF6EBC37EE80891760320EB03F6EEB8D8C36987462C93D0BD5719
            F750C026483B48581FD4387A8B992669C132697D7B067DAB22E13811DC36C116
            3AC2B98B2D2EBF79455531267627D7B46099848EBDE90ADA245FFE72BF95A5B1
            7B4A3BE1FBDAFDB22D582661DC77B8D61EEAC14D215914BB63C06A80EBFB2E8A
            DD3315E62D9330859411993A49189D5151FA95A162CC5BC6756E17455D5CBF32
            5446C2C9A61E464FAD63DE3209F5B2934BD42C32DC1A2E3E4C47A81FDB964938
            BBC4B5D735A39E6C505EB36120BF7E6C5B26E1D0D7C9F569764978E0414B8DD3
            2FBF7ADA5E5BDBB6652E2F3C2BC1B86FFD248C019B3E72A842EA6039AEC9C1B8
            A15E20F5D83DC1246C5B662898C8D05DAA9F844E93E9F3D987F33002CBB89935
            D290FFD920862D9330284377C9044B3B4D468766D433728AD1BF376FDD964DDC
            FCD2C3B68C7B8DFFD920862D93D0B4A6BB648284E1368B25EB26615C7AFD8DE1
            C3CB2F5A7238D3C2C9C86EED356C99A51716702B192B24B452CDCDBE5743C67D
            F2F180CB29CBB8511B73DF71C0B065960EFD32B1C21087A315D339DC332BC7B5
            C483D1965396B17EF5B661CBB8EA151F06650CB17468C6DC00F051A19CB2CCA9
            E556B06A193724B628A6CF05F686DBAFE263EE14CCD14E1096A90B777A6F51FC
            9A6081A517C19A3B0583650CB0B41632F46B8B840160BFA611B08C01DC768F8F
            B916350425381B5B13F3B18C01965AC66E0975CBD2ABED833DB672DC3C8CE06E
            6AA76CE266D66099D22C9D2C8365CCE18EF6F1B1651937F330383576CA32EEA6
            C8764F925AB5CCD22AC8696C732C2D625BD349865979E38EDE51CBC89EEE9576
            4F92F662195B073A10AE9B101F73CD555787C757F01E5AE6E2E2B96BC8983E7D
            8165A052DC2E171F7396191A29AACCAE9D125846CD1CA718C57405C6325029CD
            5B468CAFF87DE5D5D7DC80B7EAB6DA71835F14EBFD7D2C0395D28365845A3113
            9559DE69E0F6E958062AA513CB38E49ABBF71EDCBC755B155BD17FF475EC0EF7
            066019A894AE2CD33658062A05CB340396814A69DB32EA0DDD78E73D5B574524
            8365A052DAB68C2AA4FBD8AAC9CD4F19C53250296D5B46AD98711DFECB5FFFAE
            CFDF6AD306CB40A5B46D1987B472F3D6EDF1ED47AF5EBBDEC0A9EB002C0395D2
            836506D4691A57E9575E7DEDEEBD07761F5A108065A052BAB28CE3B06973E39D
            F71AA8BA58062AA543CB0C044D9B4BAFBFA1253C8FA93458A6797AB68CC3356D
            862F68B70E6319A894CE2DA3968BDA2FE31B06DABDE000CB40A5746B19F945DF
            65189DD17FACCFDFC33250291D5A462A19DFBBCB4DA269E04C1396814AE9CA32
            AA9FE3C7697226BB0AB04CF3746299C399325AE27FD70A58062AA56DCB1C0EEE
            AA4AB75A4BB10C544ADB9651851C3EB9FA4A6DD74F2C0395D28F651A6EC538B0
            0C544ADB9611AA93E36AACFFB73722E3C0325029CD5BC6119CBD76A3BFCD9C5D
            726019A8944E2CE37033F186C1E06666CA38B00C544A57961950436678125303
            B37E1D58062AA54FCB38545DC793F4ACDFFF01CB40A5F46C19871BB2192E68B2
            5B87B10C544AE796B9B8787EF7DE83F1B43D2C531A2CD33CDD5AC63D4465FCD5
            ACDF0C18CB40A5F4661977CDC1F821FCEA2BDDBC759BD1DFDDC032CDD38F655C
            E365187F5154BD5B9AA18765A0527AB08C5432AEC9EED475330FE11FC0325029
            6D5B462A19375E9A9CF23B8065A052DAB68C2AA4FBD8D6E7C2C48065A0529A6F
            CBE803B7DA7809C03250296D5BA62BB00C540A9669062C0395D28F65DC4C999B
            B76EAB560FD1D769E6B1FC58062AA513CBC82FE3934D415E79F5B5065C8365A0
            527AB0CCF801B5975E7FE3C63BEFE95B285A3E9E046C7D861E96814A69DE32AA
            93EE934B2847EBE7F9F9F9E01AD3D7196019A894E62DE3EAB03C32713E5BBF72
            A25133C72F320896814A69DB326A9BB88F3D5B3387268FFFD92058062AA56DCB
            DCBDF7409F59ED14FFF324EE2E3376EB3096814A69DB32EEDB457E667597CC7D
            C13158062AA56DCBB80A1C79967A91922A04CB40A5F46099C86A8965F601CB34
            0F9619C032FB80659A07CB0C60997DC032CDD383651897A91A2CD33C6D5B6691
            38DC13E0EEDE7BE07FB60696814A69DB320F1F7EAECFAC6AEC7F9EC45D4E69B7
            0E6319A894B62D33CCFD9DBD40C9F948A2F13F1B04CB40A5B46D19E1EAF07473
            66B80939D731ED0096699EE62DA33AE93EF9A5D7DF38FA7494E1D633FA976BB2
            7700CB344FF39611AE37E4F2CAABAF5DBD765DDFC2DD34CFF9C5C5FA8DACB00C
            544A0F9611AA99E347EE07513D6FE0217058062AA513CB38DC83536EBCF39E2A
            B6E26E9AD7805F1C58062AA52BCBB40D96814AC132CDD08B65A882E6C032CD60
            D53254C1E6E9AA88D5D6D6E71FE7D1E327CD3CDFB617CB5CBD76DDAF0946585A
            C47ABD5FD31477EF3D9838C774E39DF71A708D55CBB8DBA6C6473D2CBF2618A1
            07CBB85B6DBAFCE5AF7F572D1D322C97834C4FC913562DA316E6500C91F16B82
            119AB7CCF0052F1D7B1E939A303A94BAB979913721AF16AB96192E368B8FF503
            426FB46D1949C41964BA2F3F5CC764FAF192562D2386EA1519D3E5D4216D5B66
            B8D27A76D865D13355EAC4B065B4DD871A16939BB76EFB35C1026D5BC63D213B
            E64AEBA1D563B7316ED832E391B39858EFDCF646DB9671E3BB91B7BF732FB67B
            CDA461CB2C3DCDA4303463881E2C133925DD6D0A5B5F708C61CB249C666268C6
            10586600CBECC950C322C3DC3C43B46D9945370CC7327B329EBC149906665276
            42DB9659248E452FAE10DB96715B7F51E834596169E1DADA09DD99EC98734C02
            CBECC9D9D9B3A1924546CD1FBF32D44DDB9671A38A91E73DDD69EFC8EE5585D8
            B68C98B8D2EC5438D36482B62D23DCC7F63F4CB268A8B842CC5B66E9AC1925B2
            990AFBD2BC65DCB4D21877B85979768714CD5BE6D1E327433D8B4CCCB46ED89D
            E62D13D90F72C3025C61B033CEF48B62AE467648DB9651B7DDF583D4E5D77F26
            E2C60454C983E58A7FAFEA69C132EE98B0283467EA67E9DC6E5B13F013E6941E
            C6BF57F5B4609984334D0ACD99CAD1D13E28B2E9D81AD4D7414EA25919FF5ED5
            D38265C4D2EBB315356738D95439EA1404A5762ACCEAAE99462CE3E6382D0D55
            B372225BA91C302AA711CB88843160C550B3B34F628E1FCCE7AE9C762CB3F494
            84CB2BAFBEC63070E53C7AFCE4D42144CB394ED44F3B96912CD29A33DC43AF7E
            54B877EF3D180FD3E8FF5AC211C204ED5846A4356714BB772103A89FA62C93DC
            9CD15A0C1F0264A229CB88E4E60C770506C8446B96517326E12A6D17AEA204C8
            416B961109D74F0E614230C0E6346819113F67F4304CBE00D896362DB3F41298
            2088066043DAB48C481E06764134005BD1AC6544C22594E3201A804D68D932EA
            37A54D9F19C2B46080F5B46C19A1F648208EA5B97AED3AD3D801D6D0B86544C2
            EDC783A8E77576F6CCBF1D002CA47DCBA825B272804651CF8B611A8034DAB78C
            583F40E342EF0920812E2C23D4E5D94434346A0096D28B65C4FA91E02197DFBC
            C2CD930022E9C8326243D12837DE798FFB4500CCD29765C4B6A251E41ACE4001
            4CD09D65C4E6A251D48762BC06E0283D5A46E4108DF297BFFEFDE6ADDB346D00
            C6746A199149342EAFBCFA9A7A528F1E3FE1CC3740BF9611138FE0D830975E7F
            43C6B97BEF01A7A5A04FBAB68C50EF26F90E9E6991D72EBF794551DFEACE471F
            13B2283A56996B20F76E19A1325B736F3D42CA47AD6343AEC1321EB52C828224
            A4E6A8516CE53C0396F99532C334846C15555713F342B1CC6F502BF4EAB5EB41
            5912526DD4D9F775B762B0CC1168D41043A9BFDF84658EA346CD8DD5B7BF22A4
            40EABF6F2C9699E2CBAF9E72FA89549EFA3B4D58669E870F3F2F3CA78690F860
            9976C035A4CE6099D678F4F8097D28525518976993B3B36737DE798FF350A486
            D47F7D1C9649E7E2E2B9BA51CCAF213BA6FEEE92C0321B30E886D60D2919D537
            13171960998D51F3F5CE471F33764372C78A620496C9882A81DA384E3A9C9F22
            1BE686A93BDB6399A2A866A8B1A338FB10B234AA39E69E9C816500202F580600
            F2826500202F580600F2826500202F580600F2826500202F580600F282650020
            2F580600F2826500202F580600F2826500202F580600F2826500202F580600F2
            826500202F580600F2826500202F580600F2826500202F580600F2826500202F
            580600F2826500202F580600F2826500202F580600F2826500202F580600F282
            6500202F580600F2826500202F580600F2826500202F580600F2826500202F58
            0600F2826500202F580600F2826500202F580600F2826500202F580600F28265
            00202F580600F2826500202F580600F2826500202F580600F2826500202F5806
            00F2826500202F580600F2826500202F580600F2826500202F580600F2826500
            202F580600F2826500202F580600F2826500202F580600F28265608677BF393B
            CCA7DF7FE77F0D300796815F79F2E30F97BF7EFAA7C79FBD74FFC33FDC79FB77
            6FFFCF6C5EFCE47DBD58AB483DDFFEFC937F2380115806FE23B3BCFCC5FD173E
            782B304842E426BD152D1D188365FA45AD8F3F7EF6F1EFFF712530C52691B3D0
            0D38B04C77A85FF3E77FFF7393964B4CD4A5FADBD37FF9BF0D5D82653A427EF9
            D3E3CF32355EA623A9E19A6EC132BDA0F6CB2E7E1947AEB9FCF553FF81A01BB0
            4CFBBCFBCD59E409A332511FEAC98F3FF80F071D80655A465DA497BFB81FECE4
            3544AD2AB5ADFCA784D6C132CDF2E9F7DF55D584398C1A354CB1E9012CD3267F
            7BFAAFDD476162A20FC9D9EEE6C1320D52672F69229C7E6A1B2CD31A7FFCECE3
            601F36913F3DFECC7F01680E2CD30EDFFEFC9351C5B8E8C3FB6F026D8165DAC1
            B4625C104D936099466840312E88A63DB04C0B34A3181744D31858C63C8D29C6
            05D1B40496B14D938A714134CD80650CD3B0625C104D1B6019AB34AF181744D3
            0058C6249D28C605D15807CBD8A32BC5B8201AD360196374A818174463172C63
            896E15E382688C8265CCD0B9625C108D45B08C0D50CC1044630E2C6300141304
            D1D802CBD40E8A391A4463082C533528662288C60A58A65E50CC6C108D09B04C
            A5A098C8209AFAC1323582621605D1540E96A90E14931044533358A62E504C72
            104DB560998A40312B8368EA04CBD4028AD92488A642B04C15A0980D83686A03
            CBEC0F8AD93C88A62AB0CCCEA0984C4134F58065F604C5640DA2A9042CB31B28
            A640104D0D60997D4031C582687607CBEC008A291C44B32F58A634286697209A
            1DC1324541313B06D1EC059629078AD93D886617B04C21504C254134E5C13225
            F8F3BFFF19D475B2632E7FFDD4170C1401CB94E0DD6FCE828A4E76CCB73FFFE4
            0B068A80654AA06A1D5474B2637CA94029B04C21828A4E768C2F122805962944
            50D1C98EF14502A5C03285082A3AD931BE48A01458A6104145273BC617099402
            CB1422A8E864C7F822815260994204159DEC185F24500A2C5388A0A2931DE38B
            044A81650A115474B2637C914029B04C21828A4E768C2F12280596294450D1C9
            8EF14502A5C032E97CFBF34F7FB8F3B6FF618EA0A2931DE38B649277BF39E3EA
            EDADC0328938C544565931AEE564DFF82299C45DE08A683601CBA4302826B2CA
            0AF76252437C914C325C468F68D683651633564C649515C3EBC9EEF14532C9F8
            661D886625586619816214FF8B39C6AB907DE38B6492E0964088660D58660187
            8A51FCEFE608D6223BC617C92481651444930C9689E5A86214FFEB3982B5C85E
            79E183B77C914C72681905D1A48165A238A518C5BF628E602DB2575EFCE47D5F
            24931CB58C826812C032F34C2846F9F4FBEFFCEB2609D6227B65A5651444B314
            2C33C3B462145547FFD24954B98315C92E8974C4F4632710CD22B0CC14B38A51
            222DF3D2FD0F8315C92EF9D3E3CF7C914CA297052B064134F1609993C42846D9
            AAD69232897C18932412AC781844130996394EA4629497BFB8EFD79964A29F4F
            4A4625EB8B6492C81E2EA28901CB1C215E314AE468A2DE335891944FE4696C11
            AC381144330B960959A41817BFE61C0C00EF9EC886E7A7DF7F17AC381D44330D
            96F90D098A51224F66F3B4ECDD1359527F7BFAAF60C5D9209A09B0CCAFA42946
            913EFC5B4C42A769DFC47797A48C60DD98209A5360194FB2629497EE7FE8DF65
            8EB4EA4B3649E4D940211F05EB4606D11C05CBFC97358A71D13BF8F79A84334D
            7BE5F7FFB81259464B076582209A43B0CC068A51D493F76F370763C0BB24BE21
            F3F217F783759706D104F46E994D14A3C4779A68CE944F7C4346247797C64134
            63BAB6CC568A7179F2E30FFE7DE76074A6702287E7C586C7004433D0AF65B655
            8C12DF26D79FD6D135589D648A4AD96FF708B63D00201A47A796D95C314AFC89
            5271F9EBA7C1EA244764F3C8393242ADD160F5F54134A247CBE4508C4BFC18B0
            583FCA4866B3A84432F564114D7796C9A7186551734670BE296B22AF2770E468
            C80CE95C347D5926AB625CE2071A4581CFD36D96EED8991A32437A164D479629
            B34B2F3A692A104D8E2CDDA557CEC48B4CB7A2E9C5322577E6A59509D16C9B84
            9DB9DABAD1065D58A6FC6E1C799BCE0144B3551276E3C2D7CA77289AF62DB3CB
            0EFCC2076FE9EFFA4F1007A2599F841D587DA5F273977A134DE396D971D78DBF
            E66000D1AC49C2AEBBE306EF4A342D5B66F79D76D1F92607A2494BDA4EABB582
            F729997E44D3AC652AD95D970ED00844B33469BB6BC20DF1364F27A269D332F5
            ECA88B66B80F209AF8D8558C4B0FA269D032B5EDA288265FD276D15D467C27D2
            BC685AB34C9D3B27A2C9913614E3D2B6689AB24CCDBB25A2D9362D29C6A561D1
            B46399FA774844B355DA538C4BABA269C43256764544B33EAD2AC6A549D1B460
            195B3B21A25993B615E3D29E68CC5BC6E2EE8768D2D283625C1A138D6DCBD8DD
            F110CDD2F4A31897964463D832D6773944139FDE14E3D28C68AC5AA68D9D0DD1
            C4A44FC5B8B4211A93966969374334D3E959312E0D88C69E65DADBC110CDA9A0
            1817EBA231669956772D44731814338E69D158B24CDB3B15A21907C51CC6AE68
            CC58A6870E02A2714131A7625434362CD383625C100D8A998E45D118B04C3F8A
            71E95934282626E64453BB657A538C4B9FA24131F1B1259AAA2DD3A7625C7A13
            0D8A591A43A2A9D7323D2BC6A51FD1A098B458114DA59641312E3D8806C5AC89
            09D1546A99173F793FD89ADDA66DD1A098F5A95F34355A465B2DD88E9DA755D1
            A098AD52B968AAB30C8A399AF6448362B64DC2834C8B5197655EFEE27EB0EDC8
            909644836272E46F4FFFE5B754655464997A1EF7576DDA100D8AC99784EA5180
            5A2C431D8A8C75D1A098AC79E183B754D67EAB55431596A979F8A0C2D8150D8A
            299097EE7FE8375C35546119866396C6A268504CB1D43612BCBF65DEFDE62CD8
            462426B64483624A461BADAA7ED3FE96A1AF941C2BA24131E55355BF6967CBA8
            69176C1DB228F58B06C5EC15F512FCD6DC9B3D2DA3BA4E4D5A9F9A45836276CC
            8B9FBCEF37E8DEEC69993F3DFE2CD82E242D758A06C5EC9ECB5F3FF59B755776
            B30C0D996D539B68504C0DA9A439B39B651891D93CF58806C5D4931A466776B3
            CC0B1FBC156C0EB23E358806C554951A4E36ED6319E6C8E4CBBEA249ABD32826
            6B9EFCF883DFD03BB18F6574B80B3604D930C9A259B9ABCB537A13FF76D1A098
            DCD97D2AF03E96A156E54E9A68D6B431F517138E9928A640647FBFB9776207CB
            5CFEFA69B015488EA48926797A41C20113C514CBBE9DA61D2C4377A9581244A3
            2E4FC2C07CC2D112C594CCBE37B8DAC1329C5D2A9904D124DC4E6CE9E9521453
            38FB9E692A6D19B5DC82EF4F722741348B8E047AB15F2D0E14533EDAE07EEBEF
            4169CB3028B34B968A66D1E8CCA2111914B357761C9A296D19AE5DDA2B8B44B3
            A8C9195F7D51CC8ED9F19AA6D296E1716E3B467B78FC7C96C84E53FCB82F8AD9
            373AC0FB92284E69CB6C32C1942427FEF2B9C85381F1D71330EABF6F761C002E
            6D99E09B93F2893C1F1479396BE4A00C8FC1D93D3B5E9F8D65BA4B64EB23721E
            70A4B3E829EF1E75577D6114A7A865D64C60275B25F2C4F3B69609D622BBC417
            4671B04C8FF1E531C9B73FFF14AC753491279882B5C82EF185511C2CD3637C79
            CC11AC753458C6507C611407CB7497C8FE393DA6F6E20BA33858A6BB449ED1DC
            D632CC60A821BE308A8365BA4BE41CD06DCF6447BE1BC91A5F18C5C1327D257E
            D244E4C3CBF532BFC22469379420DBC6174671B04C47F9FD92DBD945F671E2AF
            30A0F4778F2F89E214B58C08BE3629162966F7AB259901BC6396DEA06343B04C
            1759A418B16818257268C68168F64A47571870AEA17C962A462C1A4389EF3439
            10CD2EE9E86A497DD5E0CB93AC49504C813B72229AF2E9E8CE0FDCC5AA641214
            23124E0625B4C6114DE17474172BEEC8592C698A493E0C245462445332F183F4
            9B53DA3291D7E0919549538C5609DE273EFA8BF137E21B403465B2E3092651DA
            328201E0DC4953CCFA8973696731104D81C4DFD230073B5826725229494BB262
            36B17F5A6D4634B9A32DECB7F51EEC6019E680E6CBBE8A7141341526A133BB21
            3B5846686708B602599F1A14E38268AACABE0F9614FB5846B530D8106465EA51
            8C0BA2A927FB7697C43E96D1FE106C08B226B529C605D154927DBB4B621FCB88
            ACF5BBABD4A9181744B37BD28A605B76B30C356993D4AC181744B36F12AAC7E6
            EC6619B1727606A95F312E8866AFEC781DF6983D2D43355A132B8A714134BB64
            E955AC99D8D33282E64C5A6C29C605D1144E250D19B1B365A84309B1A8181744
            5332358CC83876B68C907183AD43266257312E88A64C22EFFA5E86FD2DA37D26
            D840E454AC2BC605D1E4CE0B1FBCA542F71BAE02F6B78CE0D656316943312E88
            266B76BC61D551AAB08CA0DF349D9614E3826832A5AABE92A316CB3CF9F107ED
            48C1F6222EED29C605D16C1E9578557D25472D9611DC11E2685A558C0BA2D930
            AA2A3BDE7673828A2C23A83D41DA568C0BA2D92A0955A50C7559467027BD213D
            28C605D1AC8FB686DF2EF5519D6584EA5CB0053B4C3F8A7141346B52B362448D
            96119D8BA637C5B8209AB454AE1851A96544B7A2E953312E886669EA578CA8D7
            32A243D1F4AC181744131F138A11555B4674251A14E3826862624531A276CB88
            4E448362C64134D331A41861C032A279D1A098C3209A53B1A51861C332A261D1
            A0985341348731A71861C632A249D1A098E9209A712C2A4658B28C684C342826
            2688C6C5A8628431CB8866448362E28368EC2A46D8B38C6840342866697A168D
            69C508939611A6458362D2D2A768AC2B4658B58C302A1A14B326BD89A601C508
            C39611E6448362D6A71FD1B4A11861DB32C2906850CC56E94134CD284698B78C
            30211A14B36DDA164D4B8A112D5846542E1A149323AD8AA631C588462C23AA15
            0D8AC997F644D39E62443B9611158A06C5E44E4BA2695231A229CB88DA449350
            6F50CCD2A489A6B6279AB6AA18D19A65443DA2513DF69F291A14939634D1D453
            551A568C68D032A286DAF3D2FD0FFDA78906C5AC4982682AD9E06D2B46B46919
            B1AF687EFF8F2BAAC1FEA3C48162D62741349F7EFF5DF02685D3BC6244B39611
            3B8AE6DD6FCEFC878803C56C9504D1FCF9DFFF0CDEA4587A508C68D9326217D1
            2CADE82866DB24886697EDDF896244E396118545B3B4AF84627264A968CAF79B
            FA518C68DF32A2A468D4FCF67F350E1493294B4553B29274A518D1856544993A
            F4C2076FF9BF1747C99ADD6116CD2478F2E30F6A8706EF9023BD2946F4621951
            60975E54816A9B15D6642E7FFDD46FEE080A9448878A111D59466415CDA286CC
            BBDF9C05AB931C51F3448D14BFD1E7D02B83D5B74D9F8A117D5946E4134DFC88
            CCB73FFF54A6714E943FDC79DB6FF708F2558F6E1523BAB38CC85193169D5A2A
            D07723E3C41F00329D6CEA5931A247CB88CDF773BDA17FEB39E82B95CFA263C0
            E667FD3A578CE8D432625BD1C48F32BEF8C9FBC1BAA4405EFEE2BE2F8039B69D
            0A8C6244BF96115B8946874AFF8E73D090D93191C3C01B8E01A31847D796119B
            8826BEBBF4D2FD0F837549B1C44F9FD9A4D38462067AB78C582F9AC8FA94FB44
            29994E7C9353DDAB60DDA5413163B0CC7F59299AC8A6F88ED7FE1297C8E133BD
            2C587151504C0096F1248B267E321E972CED9EC8BEEDB73FFF14AC181F147308
            96F99534D144DE138FEE520D89EF34A51D1250CC51B0CC6F48104DE498A2EA5F
            B022D925918F944818A74731A7C032214B4513D9D54FEE91916D13390F78E995
            932866022C7384454688BCF92693F12A890AD717C9248BDA9E28661A2C739C78
            D1F815E608D6227B45BAF7453249FCFC4914330B963949A468FCABE708D6227B
            25F29C60A465504C0C58668A18D1F8974EC2850555C597CA243127B3514C2458
            668669D1449E19C53255C597CA1CC15A41504C3C58669E09D16CDEC92705E24B
            658E60AD7150CC22B04C14A74483652CC697CA1CC15A4350CC52B04C2C474583
            652CC697CA1CC15A2E2826012CB38043D160198BF1A53247B0968262D2C032CB
            084483652CC697CA1CC15A2826192CB398B168B08CC5F8529963BC0A8A590396
            4961100D96B1185F2A730CAF47312BC1328938D160198BF1A532877B318A590F
            964947A2C13216E34B650EBD12C56C02965945642DC43255C597CA1C28662BB0
            4C09B04C55F1A502A5C03225C03255C5970A9402CB9400CB54155F2A500A2C53
            022C53557CA94029B04C09B04C55F1A502A5C03225C03255C5970A9402CB9400
            CB54155F2A500A2C53022C53557CA94029B04C09B04C55F1A502A5C03225C032
            55C5970A9402CB9400CB54956F7FFEC9170C1401CB9460E9E35049D6443E7418
            B602CB94E0E52FEE07159DEC182C53182C5388E0569E64AF70A57579B04C3910
            CDEE4131BB80658A8268760C8AD90B2C531A44B34B50CC8E60991D4034858362
            F605CBEC03A2291614B33B586637104D81A0981AC0327B8268B206C5540296D9
            1944932928A61EB0CCFE209ACD8362AA02CB5401A2D93028A636B04C2D209A4D
            82622A04CB5404A2591914532758A62E104D72504CB56099EA40340941313583
            656A04D12C0A8AA91C2C532988263228A67EB04CBD209AD9A018136099AA4134
            13413156C032B583688E06C51802CB1800D1044131B6C03236403443508C39B0
            8C19108D82622C82652CD1B968508C51B08C31BA150D8AB10B96B14787A24131
            A6C13226E94A3428C63A58C62A9D8806C5340096314CF3A241316D80656CD3B0
            68504C336019F334291A14D31258A6051A130D8A690C2CD308CD8806C5B40796
            6987064483629A04CB348569D1A09856C132ADF1F217F783BDD744504CC36099
            06D11E1BECC335E7F7FFB8F2EE3767FEA3438B609936F9F4FBEFB4F706FB7385
            F9C39DB79FFCF883FFD0D02858A659BEFDF9A7173F793FD8ABAB8A3A77FA90FE
            E342BB6099C6F9F3BFFF5961A3461FE9F2D74FFD4784D6C132EDA32EC94BF73F
            0CF6F31D4313A637B04C2FBCFBCDD90B1FBC15ECF085A31EDCA7DF7FE73F1074
            0396E98BBF3DFDD72EAE915F3891D42D58A647B4C317EB43FDF1B38F69BF740E
            96E997273FFEF0E77FFFF30F77DE0EBCB049F4B66A3731FE0202CB80D78D5A37
            2BCF466975B55C900B046019F80DEADD48137F7AFCD98B9FBC3F3DDD464ED10B
            E426BDF8F2D74F995C07A7C0320090172C030079C1320090172C030079C13200
            90172C030079C1320090172C030079C1320090172C030079C1320090172C0300
            79C1320090172C030079C1320090172C030079C1320090172C030079C1320090
            172C030079C1320090172C030079C1320090172C030079C1320090172C030079
            C1320090172C030079C1320090172C030079C1320090172C030079C132009017
            2C030079C1320090172C030079C1320090172C030079C1320090172C030079C1
            320090172C030079C1320090172C030079C1320090172C030079C1320090172C
            030079C1320090172C030079C1320090172C030079C1320090172C030039F9CF
            7FFE3F873574C29F896A560000000049454E44AE426082}
          HightQuality = True
          Transparent = True
          TransparentColor = clWhite
        end
        object LogoPix2: TfrxPictureView
          Left = 531.134200000000000000
          Top = 629.047620000000000000
          Width = 26.456710000000000000
          Height = 68.031540000000000000
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000177
            000003F5080200000015453853000000017352474200AECE1CE9000000046741
            4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
            00442049444154785EED9D5DAEDD44DEAF7B083D0486D04360080CA187C00C7A
            087D73742E4EABD58DB82042E20D52A40445E1A349080A42900F89085A49D42D
            C8053B02B41162072EFAFC9AAAD7985A6BD9E5B2AB5CFFAAE7D14F51B6F7F2DA
            6BB9CA8FABCA65FB77FF0100C809960180BC601900C80B960180BC601900C80B
            960180BC601900C80B960180BC601900C80B960180BC601900C80B960180BC60
            1900C80B960180BC601900C80B960180BC601900C80B960180BC601900C80B96
            0180BC601900C80B960180BC601900C80B960180BC601900C80B960180BC6019
            00C80B960180BC601900C80B960180BC601900C80B960180BC601900C80B9601
            80BC601900C80B960180BC601900C80B960180BC601900C80B960180BC601900
            C80B960180BC601900C80B960180BC601900C80B960180BC601900C80B960180
            BC601900C80B960180BC601900C80B960180BC601900C80B960180BCB460992F
            BF7A7AF5DAF5BFFCF5EFFFE7FFFE3F974BAFBF71F7DE838B8BE7FE15609C870F
            3F57990EE5ABA8C455EEFED75037B62D238FDC78E7BD71E51BE795575F3B3B7B
            E65F0A365109067E1947AEE158523FB62D3351FF5CD4C041347651D98D9BA847
            A33A80682AC7B065EE7CF47150E18E462D1A6AA151668F222E376FDDF62B4095
            58B5CCF9F97950D526221FF9D5C00E0F1F7E1E94E344541FFC6A501F562D73F7
            DE83A09E4D44CD19BF1AD821B221E352797326F8B469B13BDA6DD53257AF5D0F
            CA603A749ACC1194E0742EBF79C5AF5625C1A74D0B96298D6A555006D3E1ACA7
            3982129CCE5FFEFA77BF5A95049F362D58A63458A67982129C8D5FAD4A828F9A
            162C531A2CD33C4109CEC6AF5625AAAEEB63774E0696814A094A70367E35A80F
            2C03951294E06CFC6A501F58062A2528C1D9F8D5A03EB00C544A5082B3F1AB41
            7D6019A894A00467E35783FAC03250294109CEC6AF668DF3F3F33B1F7DACFA3C
            1BCE3195461B3DA864D3C132E6084A70367E35532CBA56CB6E1DC63250294109
            CEC6AF6687478F9F045F613A58A63458A67982129C8D5FCD0EAFBCFA5AF015A6
            83654A83659A2728C1D9F8D58C7076F62CF8FCD351C3C7AF69102C03951294E0
            6CFC6A46086E5DF2F0E1E75A38D4EAA1BA0E379C357DA72E2C03951294E06CFC
            6A4618DFE971B8CBDA70FBD1A1BA0E325285774B2C8265A05282129C8D5FCD08
            E30A3CDCE86F58325457FD6758E8965804CB40A50425381BBF9A11C615D82F1A
            7DE5616ACCC5C5F3C385E6C03250294109CEC6AF6684A1025F7AFD0DBF68F495
            FDCFBF302CB43B008C65A05282129C8D5FCD084305D67FFCA2139619EE7F6CF7
            26F958062A2528C1D9F8D58C306D99F16DAA87576299D26099B6198F4744C6AF
            698469CB8CAB2B6D99DDC0326DA3F20A4A703AE37DD50443051E3FC667F83A77
            EF3D704BC6B6C532A5C1326DD3BC65A48CE1C3FB45BF55CFF9F9B914337E0C3C
            9629CD52CB0C070730419F96193BE5306E7EB045AC5AE6E6ADDB41194CC7EE71
            A04F163D3B5469C332D35769DB7D4AAF55CB8C0B292657AF5DF76B82059696AF
            B9CB7CA40CB5D75CFCA25F38F5DC5EAE63DA81A5C7BAF1DC27A89FA53DE266DA
            AA1717CF0F45A3AD313EB76D0EAB9659DA6F57FC9A6081E1BAC1C898BE31C221
            0F1F7E2E6FBA048D1D8B58B58C1A9C413D9B4D03A5D5094BEFBDA250B83563D5
            3262E9E1AE994675F32CED0E2B7E4D3BDCBC755BFD2097C61A628718B6CCD2AE
            3B433356B87AED7A5076D3B158B2E3DADB7C43CCB065D43619CA293276CF05F6
            43C2B50537DE79CFAF6C87B16568CBD4CBF4E482A3616E5EFD2C7A78888BC5E9
            6AE36364F37D79C3964938E88DAF19813A59DA11562C3651C732C53255935023
            3919513309A70E8D1E39C6E7D19A9F326ADB320927232426BF32D4C7F4853C47
            637752EC7092B4F926B66DCB241CFA149A337592569A76EF863B3E95667A6AEF
            2CB62D234E5DF731119A337592D090B1DB0A9056965EF16BF7E868DE32099D26
            85E64C6D24CCF755EC7697540383EF321B2CB31B09679A144E36D546C240BE62
            770214963146424B5BE182837A486B909AEEF96219632414988BDD626B09F595
            965E92E662F7DE7142DF5A965C14BBE3DC2D5846A80C822A1813F59BDA1EDBAF
            1F6DFF84F17B853EAF211AB14C7273467AF26F017B90D6DB554C37647AA311CB
            88B4E68C62F15ABB36587A2A77080D195BB46399E4E68C8268CA937055E4907E
            1A32E7276E0F6C8B762C2396DE97641C445392358A69A3933B3E284E1864BCA1
            18FDAD02893FED6C850BA229C31AC5287677B631919619BFCCEE6D689AB28C48
            B8B5D5388826372B156377B26F408265ECCEF06ACD3222EDCCE81044938F958A
            6969E60196B14DF22CAF218826072B15A34CEC8DE688B4CC78A36199BA489BB1
            3E0EA2D996F58A69EC8A9018CB04C74B2C531DD2C4503C6941345BB15E310D9C
            579232F42D868CFBF5FAFFF8572E871D7FBB77AD6ED632C953D7C74134EB59AF
            98368663C68D97B4D8BD00BD59CB889527B65D10CD1AD62B4625D8DEA9EB8498
            BE3770CB9611EB4782154493C67AC5281323A3B658631975A04CB7E61AB78C40
            34BBB08962F426FEEDEC338CCB2CAA8D6AC234B011DAB78CD8A4C6239A7850CC
            2CE3A64D33EDB55374611981688A816262C0326D82680A806222C132CD8268B2
            8262E2B9B8782EB9B83473D9C429FAB28C4034994031708AEE2C2310CDE6A018
            98A047CB0844B32128660DE7E7E777EF3DB87AEDBA3BCF3D11BBB3133BB58C40
            349B8062D67067C9ED90EC0E12F76B198168568262D6B0F4CE0158C62A882619
            14B3868B8BE74BA7A46319C3209A0450CC4A12362096B10DA259048A594FF02C
            AACB6F5EB12B9159B08C07D144826236415A19B6C6A5D7DFF04B1B05CBFC0AA2
            9905C56CC5D832CD6F102CF31B10CD04286643C69669B8AFE4C0322188E62828
            665BC6CF41C5323D82680250CCE68CE7E361994E413403282607E3AD6AF7E104
            916099933C7AFC845B79A2984C9C9D3D1BB64F338FE53D059699A2F37B06A398
            AC0C9BE8B2FDA74D4D836566E85634282637E3D34C7E51A36099793A140D8A29
            C07800589D26FD381D9EFAD6385D8906C51440356AE9B34FB98EA97D3A110D8A
            298394116CB4D960992E685E3428A61858064ED2B068504C49B00C4CD1A46850
            4C61C64F4A898CDD07AA6099141A130D8A81AC6099449A110D8A81DC6099741A
            100D8A810260995598160D8AA9938B8BE78D3DD316CBACC5A868504C3D68335E
            BD767D5C8BBEFCDFD349C3D0AFDD89BF02CB6C8039D1A0984A50CD393A0378B0
            CC70AD9334E4965804CB6C8321D1A0984A50B7E895575F0B36ACCB6099E1967A
            A6EF408E6536C38468504C3D040F4B1967B0CC9DD115956E8945B0CC96542E1A
            14530F6AC88CAB8AFE7FF44EC0E322E39A6CF0542B1A1453158F1E3F19B6AA8A
            DB9D541A960C96D17F0E179A03CB6C4F85A24131B5317485545586F3D6C3A63E
            6A19BBDB1FCB64A12AD1A0980A51E1BA0D3B2EE5616B0F969180868512935B68
            0E2C938B4A448362EA6438453D76C7B0C1C79DA36121968123EC2E1A14532D58
            06366347D1A0989A89B40C3D26886217D1A098CA89B48CFE332CC432304561D1
            A098FA5169BAED3C9ED43B6CFCC13277EF3D18166219986113D1C4ECF928C604
            52C6B0B55537DCC261C96099F12508761F748B65CAB189681E3D7EE2DFEE18FA
            13C1EB1382620A302E29D50AA79561897EBCB8783E9E0DEC16BA75CD81658AB2
            5E345AFDD44C73D5CB32CD25D884E052C971D91D5EA8ADDFFAD50C82654AB35E
            34974F3C563938F42504C5946451DFD6EEA08CC0323BB05E34873A185F179316
            14539E610C783AA66FFB20B0CC3EAC148DD61D2E7E719CBA53496450CC5E4CDC
            FFC1454DD4A0ACCD81657663A568C64DE8456DEFC3A0987D393F3F57A3E67098
            460BED8EF88EC1327BB246345AD1BFCBBA860C8A81DC60999D59231A27081DEE
            82E5F1413150002CB33FC9A2518F5DAB478E201E06C54019B04C154834810222
            A375D30C85624A727E7E7EE7A38F87F8A5738C3BC2D3B3312B07CBD48276FBA1
            4AC5475536581213145398A057EB97CE319E0015EFA60AC13215317B52F33009
            0D19D7CF8292A459667C08393515D30458A62236B9446036A69F526894B165D4
            0FF24BE718CFB48C5FAB42B04C5D24346716E5C6EA5B7C420269AD9260B4CE2F
            350896A98B35A7A563C288CC2E24F77D86B514D50DBFD41A58A63AC6156BF3E8
            F0E8FF0C1424D932E3D34C58063663A85539E2FF069425D9327AF1B0A2DEC42F
            B50696A98EA156E588FF1B50162C03157131BA677D8ED063DA052C0315B1FE36
            31D361F47717C69659744E1ACBC0F6245F941499450752D88A606277FCFD62B0
            0C6CCCF9F9F950A5F2854E537982090AF117258D67696219D880841BF78ECF74
            4686E64C7982E1B6C822085A403C2905D6327EBE577C828A181966009727782C
            C1EC0099C4141C42982F03AB4893859AD35A37A139A3209AC28C07805D2644A3
            BEF3E1C352FCEF0C8265F6274D318A3345F2A54F88A6244707DDA412B561D548
            19A2CA70B4E36CBAB0B0CCCE242B46714DE8E43B602988A62487CD99F898BE92
            1ECBECC91AC58CA75D8CCF772E0DA229C6C5C5F3C37E504CEC9E5D726099DD58
            A31845ABFB375A7D2537A2294682681A281D2CB30F2B1573387F744D73464134
            2551DB24E676652A65D3B7FB1DC0323BB052318A1B9119B3B239A3209A92A851
            73F7DE83A3C706C94565316EAB5A07CB9466BD624EDDB877FD7DF610CD5EE820
            A1483DFEE7B6C0324559AF181DE84ED5C5E4C1C571100D6C0E9629C77AC5A833
            3F7D15927EBBFEFEE48806B605CB1462BD629498BE3AA281DAC0322528A618C7
            2637A94134B01558263B8515E3D8E48F221AD8042C93975D14E3403450095826
            233B2AC68168A006B04C2E76578C03D1C0EE60992C54A21807A2817DC132DB53
            95621C88067604CB6C4C858A71201AD80B2CB325D52AC681686017B0CC6654AE
            1807A281F260996D30A11807A2A993F3F3737765767BD76763990D30A41807A2
            A907D9E4CE471FBF72EC4114975E7FA364ADC80796598B39C538104D0D9C9D3D
            9BBD59875E60BD5D8365566154310E44B32FF1F703B2FE38502C938E69C53810
            CD8E2C7A70CABEF564255826910614E340347B71781B20B5596EDEBA2DFB1CDE
            0F58AD1EBF9A41B04C0ACD28C68168CAF3E56FEF067FF5DAF560F0453F6A938E
            5F63F7C16F5866318D29C681680A33EE2E4DB453C6E79EEC3E3505CB2CA349C5
            38104D49C60F9C98A80F77EF3D185E2631F9A5D6C0320B6858310E44538CF1C8
            CBC489EA71C70ACBB44FF38A71209A328C2DE3179D60781996699C4E14E34034
            05C032F01BBA528C03D1E406CBC0AF74A81807A2C94AA4651897699F6E15E340
            34F9189F63924AFCD20338C7D4389D2BC68168322165C46C1FE6CBB40C8A1940
            343908E6FE1EAD2ADA68E3D730F7B729504C00A2C941701DD3A5D7DF5003479B
            5AFFAA3F15DC71463FFAD50C82654250CC5110CDE6044D95E9DCBDF7C0AF6610
            2CF31B50CC0488665B2E2E9E1F5E967D34A62FC81658E65750CC2C88665BCECE
            9ECD8A462FD0CBFC0A36C1321E141309A2D996F3F3F3ABD7AE07DB678836D4C4
            554E56C032FF05C52C02D16C8E54F2E8F1933B1F7D3CE4CB861E638065504C0A
            8806E2E9DD32282619445300B5685CEC4E96115D5B06C5AC04D124A34D77F9CD
            2B2E1383BBC3D8B05EE61719A45FCBA0984D403469DC195D61A0A68A5F7AC070
            51A574E31719A453CBA0980D4134098CAF969CE80D8D5F667730B847CBA098CD
            41344B191A298A5F748CC8264FE574671914930944B38848CBC82CC3CBECD6BA
            BE2C8362B28268E249B08CDA357EA9353AB20C8A2900A28904CB34088A2906A2
            89616C998933D958C60C28A6308866167DBBE19B4E54ADF196C432F582627661
            93CD6E77BF9A455F6DF89A6AD7F8A5078C9B3C58A65250CC8EB0F12778F4F8C9
            F86B1E6DB88D6F2DAED8BD9155CB965177775C486941316BD8443476EFAA3D4D
            706799575E7D4DAD9521C11D3915BB779969D632E7E7E7B3F7079A0D8A59CF7A
            D134701BA7A34825C1379DC844AFAA7EDAB4CCC5C5F34BAFBF1194D3D2A098AD
            582F1A1DD89BB9D9CA80BED16183E554EC4EFC156D5A667CF5475A50CCB6AC17
            CDD56BD7FD7B3584DA6831A2B15E1B1BB44C30AE9610149383F5A2317D1FFF53
            A84573E39DF74EF5EED55132DD8A71B4661995D9CAE11814938F95A251C99ABE
            99D334B2C978F45707CB66BE6C6B9699B851734C504C6E568AC6F42068B73465
            99F174EC84A09832AC140DC5648EA62C133F627F18EA6E49D68846FDA6F6CE37
            B54D3B9609264A2E0A8A29CF1AD1DC69EBCA83E01929A7627798A611CBAC19F4
            45317B912C9A668681E597F87A6BF76453239691E98322894CF37718A89C9E0B
            6EE9940B2CB327C90D194E58D440F26941EBA3334B2B2D96D993B486B7CA9841
            C41A5029A40DDBAB1DE4DFC220097347B1CC9EA4D55115B35F1FF6266D0A828E
            137E7D83045D45D5611D2CB51D2662F7A068DE32DAFAE3D28A4C9317C59826ED
            D233BB23F7E3DB5349316D37ABCD5B667C67C3C8E818D8F04475A368374B185C
            B33BB236B64C93D7678DB16D1955CDA1A8E263BA3FDF3069339E8C1E30C69651
            7BDC2F6D14DB964918F765D0B7661286D88C3604B08C19124E82D290A99984C3
            86D14ED378F417CB544D424F9E864CCDA48DCE582CD371F7D0EE187624862D93
            70768999BEF59370B2C9E2A48471ED6DBE7D6DD832C18C83983047A67E129E3C
            2131F9954D317C7EBB67CA22316C99F1F8594CD414F76B42DD2CBD33BC5EEFD7
            34C5F0359BAF99862DB3B4034F77C90A09AD54BFA629C67DC3D989BF8ADD2145
            AB96393F3F1F4A28327497AC90D069D24EE85736822AF0D233A4E6BEE38055CB
            688B0765301BCE2E19626943D5DC699A840A8C654AB3B4516DB4EBDE2D4B07DD
            CC9DA6C13206587ABE9341195B2C3D8A983B4D83650CD0FCB1AE73964E023667
            99F3F373D5C945B17B896F2F96B17B1CE893A5877AA629D48C55CB2CBDAC0ECB
            D8E262F9D5F67E4DA80FAB96096AD86C38C1648EA00467E35783FAE8C5327E35
            B0435082B3F1AB417D6019A894A00467E35783FAC03250294109CEC6AF668D2F
            BF7A7AE39DF7622EDDE24C76698202988D5F0DEC1094E06CFC6AA65874D76A2C
            539AA00066E357033B0425381BBF9A1D963E9209CB94262880D9F8D5C00E4109
            CEC6AF6687A5B331CECE9EF935AD8165A05282129C8D5FCD0887D79D4B3AC335
            A2975E7FE3F29B57946189E9BB766219A894A00467E35733C2F8BEBF5289EB0D
            0D33DA87CED1307063FA423C2C03951294E06CFC6A46B833BA1C7468A70C4B06
            CB0C32327D53012C03951294E06CFC6A46185F88375C06392C192CA3FF0C0BDD
            128B6019A894A00467E35733C2D8327ED1E82B8F077A8785837ACC8165A05282
            129C8D5FCD088365C65DA1A3DF655868770018CB40A50425381BBF9A1106CBE8
            3F7ED109CB0CAFBC63F61E4958062A2528C1D9F8D58C306D99F10DABB0CC6E0C
            E51119BF1AD82128C1D9F8D58C306D99F110CC30790FCB9466288FC8F8D5C00E
            4109CEC6AF6684C13292885F347A72C3DD7B0FDC12356ADC1205CB9466D8F491
            F1AB811D82129C8D5FCD08E3F9327ED1483DD2CDA3C74FD4A219962858A634C3
            A68F8C5F0DEC1094E06CFC6A46386A99E92773D87D6C2196814A094A70367E35
            231CB5CC780EDE6178826D698202988D5F0DEC1094E06CFC6AC6197791C6B1DB
            5D1258062A2528C1D9F8D58CA306CBA168D493F2BFB60996814A094A70367EB5
            26383B7B76F7DE03B55F1E3EFCDCEEC3DE06B00C544A5082B3F1AB417D6019A8
            94A00467E35783FAC03250294109CEC6AF06F58165A05282129C8D5FCD3EE7E7
            E75F7EF554696044C68165A052621E51348E5FCD326767CF82134CDA08766F2A
            3E60D532A7A6151C8D5EEC57033B5CBD763D28C7898CAF06AA192963FCBDF4B1
            8789306AB90CD7318DA385D64563D532E39B33CF66B8F60C0CF1F0E1E741394E
            C4C48C12C9E2A847DC9DC3279E0067C5A1A7B06A998B8BE7470BEC307A99DDA9
            D99D33DCF4603A2A62134318137DC0D9A3A6DD8B988455CB88C847F3992E9ECE
            D1C13F28CDA33171ABCAC8EA7A2A3C296537661BD5766F950A0EED9CD38D562B
            453C7DBDF5107D59770BABE052039E94B2273ADC1D1D09D642EB6366E0506FE8
            E898858AD8ED90260894E19AD8870E1D4B535F7CFC2BBFD420E62DE35079A878
            EE7CF47133977E4080CA54FBA4DD221EDB642CC7A027157CAFF1C8945F649046
            2C035039832C0E7D31F1AB710BC82F3208960128C1200B89C32FFA5F261A2C63
            CBD81D01C032002518647168998906CBF8578606A102B00C40090659601900C8
            C2200B2C0300591864816500200B832CB00C00646190059601802C0CB2C03200
            90854116C9C132003045A08C846019009822504642B00C004C11282321580600
            A6089491102C0300701C2C030079C1320090172C030079C1320090975C9679F2
            E30F7FFEF73F5FFCE47DE5A5FB1FEAFF5AE27F07003D91C5322F7F71FF776FFF
            CF61FEF4F833FF0A00E886ED2DF3C7CF3E0EE4328E7EEB5F07007DB0B165A615
            E3826800BA624BCBC428C605D100F4C3669689578C0BA201E8846D2CB354312E
            8806A00736B04C9A625C100D40F3ACB5CC1AC5B8201A80B6596599F58A71A944
            34E7E7E75F7EF554B97BEF817BEA3BA9368F1E3F31F740FE311717CF15FF43EB
            A45B662BC5B8EC251A55D69BB76E8FEFE14C0CE5D2EB6F18BDEB8A3EF65FFEFA
            77E9B207D7245A665BC5B89414CDC3879F5FBD763DA8B2C468749CF0E56A0759
            C67DF81E5C9362991C8A71C92D1A95A54A54E53A5450D246CC8926A88A6DBB66
            B165F229C6E5E52FEEFBBFB429F8A5F958EC3A75E29A659679F79BB3400A39A2
            BFE2FFDE463C7AFC04BF341F75817D795BA379D72CB3CC4BF73F0C8C90231BF6
            9B54548CBFF413D37B66C3AE596699400799F2C2076FF9BFB78EB3B3673461BA
            8AD1F34D639A744D8D9651FCDF5BC1C3879F0F958F7492062CE368CC356D5A06
            C5F499662CE39056EEDE7BF0CAABAFB96F67D735CB2CF3FB7F5C097490237FB8
            F3B6FF7B49A0986E63BD671110B4685CF4E3A3C74FFC2B8CB0CC32B94F63BBAC
            B971278AE93697DFBCE22B817D02BFB8568CEAF6D0AEB9F1CE7BFEA516586699
            273FFE90BB39A3F7FFF6E79FFCDF5B881CEFCA8074187347F8538C6D72D84BD2
            8FEE57FA8F5F543DCB2C23FEF6F45F8117B64DF26499F3F3F3A06D49FA89AD63
            FB29A6FD3270F7DE03F7022B3DC4C59611F944A377F67F6339975E7FC3150FE9
            2D0D2866EC17F78DA6AF38772FB6D27C4BB18CC8219A358A199A91A4ABE878AE
            03BBAF0436F9F2ABA78BFCE2B879EBB65E6CA5D3946819B1AD68D62846A53214
            D2FAA84D74F9CD2B2A3F5279AC0FC4C82FE35B8E44FAC5A1AFAF55F4AFFFB96E
            D22D23B612CD1AC588F57787D1215165DCCCF021D48F1433543F55E0A5337D3A
            B28C582F9A958A1997564226C6D800F2E1EA6D825F1CBDF49806D68866A562C4
            9A86CCD56BD7F10BEC823A47697E719C9D3DD3EA2D9F633A244D34EB15A36D1D
            88233ED6470D01ACB08D65C452D1AC578CB8F1CE7B813B22F3F0E1E7FE2D002A
            40C74BD549F58086AC69E9D4C6669611F1A2D94431E22F49D3F0500CD4C3A3C7
            4FC667B2C76966D0704BCB8818D16CA518154F502A31B178276A6895A0317EF9
            CD2B2EE329A6FABF75D16C6C1931219ADFFFE3CAE5AF376B0726749754607E65
            80BD71170A286ACB1CCEA29059D49071AD75EBF5767BCB884FBFFFEEC54FDE0F
            14A3254F7EFCC1BF620B4EB53327D2525F174C23890C069968AA0CF77B34DDCD
            CF6219879CF2EE37676ADAE8DF6DFD2212E6FBAA21EA5706D81B59C355CBD9F9
            BE6AD1E865A69B33192D9395844119A6F6423DB86975EAF5FB9F4FA3968EABC0
            F1D71FD48655CB38C1C747CD4EBF264005B8D9A4AAC6FEE749DC8BED1E26AD5A
            66E9D0AFDD87F540933871440E14BA636AA4922AC4AA655C21C5C76E09419360
            19032CB50C6797A02ADCC30823CF1C61997DC032609A45E2C032FB8065C0346E
            4A5ECC39268165F601CB80695421552D558DFDCF93B8D3DE76EF22806500F6C1
            D54CFFC324AEB6DBADC35806601F2EFD7249E4D9D933FFF369DC450676AF99C4
            3200FBE0E67CCDF6835CDF8A2B0C7600CB8021545D0FE32EF7D5BFC1F220EE65
            A6A795621980EC04B5312D76EB309601C8CE9DD1AD3693C3D592A5C1320056C0
            320090172C030079C1320090172C030079C1320090172C030079C1320090172C
            030079C1320090172C030079C1320090172C030079C1320090172C030079C132
            0090975E2C63F70E40D000C1FDA8D2C25DAC4AB3D4327E35803D086A635AECB6
            C7AD5AC63D072B32A6EFFF0E0DA083E261DCF34F543983E541DCCB6EBCF31E6D
            99D29C9D3D1B24321BBB0FE58386719573F6294BEA2B59AFC3562D23DCE36C66
            F3CAABAFD97D5C16B48ABA3FAA9C31ADEC478F9FE8953C29651FE40EF774BE89
            A8B519F3EC3E80C2B8A7F1ABE3EF7F3E8D3A4A7AA50E96FE678318B68C9068D4
            711D9C1244058362A04E5C3F48FFFA9F27E109B6FBF3F0E1E76A4F0E7251D4C6
            D1B1A2B65291F2D44ED6A775272695F120DF8ED1D61B3E92DAE7FA909CF8CF8D
            36BB2A6AE469A3452FAE90162C33E07663FFC3DE6847D51EEB54E21E426A2E92
            B51390B62A635BDBB2481C914FD4AE96A62CB33B328BAA82F64CD7C46D2C92CE
            CD5BB7A54E8CB39E459691E8F562FDEB7FB60696D900B5A1B4FB196DB0A4453B
            897C4AC72A192C0351681FEB4D2E87D1DEF2F0E1E7B46E96B2A81384657A44FB
            953B161117F510B5DB70462F1E278E9833D9422FD38BB14C17E888AD92EEBCF1
            321DC9F7D1E3277E7BC169D457D2E6525DF23F4FE2E6856199C6717E69724C37
            47B4F3A8B9E7B71D9CC055A7D9A119E723C56E5311CBCC805F92A32370E4E866
            9FA85E692BA96A4D0CA2ABFAB9864C64ABA74EB0CC143A20D33F5A19F5A13815
            751419C4D52E89E6E808FAB8FA99EE876299E3A875CAF8EE86D171FB702F0255
            B3713359556EC8B050B1DEFDC43247704D59B26D7458A6037588E43B71778136
            7A9D58E637E8D8E2BAC124536EDEBA4DA3E6106D13773DCA10B55F9AE9696299
            5FB9FBCBC5F82477D4A861664D576099FFA22349705537C91DBBD7FEC152B00C
            BDA4DD72E39DF7E83DF540EF965167B8E45C1875162EBF79457BD7D0F7FEF2AB
            A7BB67180B383CBB913BF23BA239FFE5527ED50AB7FDAD9F513AA46BCBA83883
            4ABF79A415D51ED521EDCCFEAF5A40F5DE0D4616904ECFC33432ACBB46691C6D
            76FFEB5F50CDD142F5E8FDCF06E9D7322ACB71D16E1BD50999A5997304AAE859
            AF3E5773B24FD10C5D756D5B6D61E7F4C032AA45EE05FE6783746A9989190A6B
            E29ABB0D7701E402ED0C39FA981D8A6638CE0D03E16E496019E15EE67F30488F
            96D95C31DA43B4EF35D372894132DDBC33D59B689CACC7E7DA4E59C63579EC6E
            9CEE2CB3AD6254515427BA1DBF544F6AF3EDD989681EFDF294A5A01F74CA324E
            E8B686F6C6F46599C391B6E474EE9731F2C286ED9A4E44E384A20AE97FFE8553
            9639B5DC0A1D5966C3334A3A80E397001D69B71A1EEE41346E166870A53596B1
            8D6BA0AE8F7AC89D34E9D3D09E2047041B2D21CDCFA339DA09C23286911736A9
            FA768BB924E7E7E79B74A0241AFF8E2D82659A4287C4F52D79BD034D9845B81D
            6365D433F56FD71C58A629D65F06A97760142601ED42EB9B90ED4DB777302ED3
            0E7757DFCCC16ED1D6807A4FC3F4D6B4B43A12ECC411798EC9357CB04C8DA876
            BA9A9A9C560FA4255133706573B2C9011A35F4F4D562E6CB6803BAED1074AF0C
            D1B265D61C457508B55BA815B272F29EDDC3F804AE3B393BF7D74DF2D28BFDCF
            0669D632AEC0D2D26A2B7D5F568AA6BD1219BAF313D7310DAF09D4638B362DB3
            A6AF8462F2B146344DF69B860DA2AE933CE27ED4BF6A47CB2F4363DCFA776FD3
            326BE66BD051CACA1AD1983E9E9F62F6AA97064E7136689935571230DC5B80E4
            63809A994D5EF8AE2F25D7049B45ED17D7A8F12FB24C6B9691F5DDA05A429A3C
            545688CA2879605E3B9E7F17B0436B969129827A1919B54BFD5B407E74F44E3E
            18B4316AA656B3EA6A934DB3439AB24C7243E695575FB3DEF53547F2F5ABEA59
            F8B7B08CEB1F753208D89465921B329C54DA85D981CF536960E77496E9641CB0
            1DCB243764188ED991B4019A069A33EE88D849DD6BC732690D19EB3311AC933C
            B3C97AF3D34DB7EB6430BB11CB243764E82BED4E5ABFC9FAFEE9F4DAC941AE11
            CBA4CD9151FDF6EBC37EE80891760320EB03F6EEB8D8C36987462C93D0BD5719
            F750C026483B48581FD4387A8B992669C132697D7B067DAB22E13811DC36C116
            3AC2B98B2D2EBF79455531267627D7B46099848EBDE90ADA245FFE72BF95A5B1
            7B4A3BE1FBDAFDB22D582661DC77B8D61EEAC14D215914BB63C06A80EBFB2E8A
            DD3315E62D9330859411993A49189D5151FA95A162CC5BC6756E17455D5CBF32
            5446C2C9A61E464FAD63DE3209F5B2934BD42C32DC1A2E3E4C47A81FDB964938
            BBC4B5D735A39E6C505EB36120BF7E6C5B26E1D0D7C9F569764978E0414B8DD3
            2FBF7ADA5E5BDBB6652E2F3C2BC1B86FFD248C019B3E72A842EA6039AEC9C1B8
            A15E20F5D83DC1246C5B662898C8D05DAA9F844E93E9F3D987F33002CBB89935
            D290FFD920862D9330284377C9044B3B4D468766D433728AD1BF376FDD964DDC
            FCD2C3B68C7B8DFFD920862D93D0B4A6BB648284E1368B25EB26615C7AFD8DE1
            C3CB2F5A7238D3C2C9C86EED356C99A51716702B192B24B452CDCDBE5743C67D
            F2F180CB29CBB8511B73DF71C0B065960EFD32B1C21087A315D339DC332BC7B5
            C483D1965396B17EF5B661CBB8EA151F06650CB17468C6DC00F051A19CB2CCA9
            E556B06A193724B628A6CF05F686DBAFE263EE14CCD14E1096A90B777A6F51FC
            9A6081A517C19A3B0583650CB0B41632F46B8B840160BFA611B08C01DC768F8F
            B916350425381B5B13F3B18C01965AC66E0975CBD2ABED833DB672DC3C8CE06E
            6AA76CE266D66099D22C9D2C8365CCE18EF6F1B1651937F330383576CA32EEA6
            C8764F925AB5CCD22AC8696C732C2D625BD349865979E38EDE51CBC89EEE9576
            4F92F662195B073A10AE9B101F73CD555787C757F01E5AE6E2E2B96BC8983E7D
            8165A052DC2E171F7396191A29AACCAE9D125846CD1CA718C57405C6325029CD
            5B468CAFF87DE5D5D7DC80B7EAB6DA71835F14EBFD7D2C0395D28365845A3113
            9559DE69E0F6E958062AA513CB38E49ABBF71EDCBC755B155BD17FF475EC0EF7
            066019A894AE2CD33658062A05CB340396814A69DB32EA0DDD78E73D5B574524
            8365A052DAB68C2AA4FBD8AAC9CD4F19C53250296D5B46AD98711DFECB5FFFAE
            CFDF6AD306CB40A5B46D1987B472F3D6EDF1ED47AF5EBBDEC0A9EB002C0395D2
            836506D4691A57E9575E7DEDEEBD07761F5A108065A052BAB28CE3B06973E39D
            F71AA8BA58062AA543CB0C044D9B4BAFBFA1253C8FA93458A6797AB68CC3356D
            862F68B70E6319A894CE2DA3968BDA2FE31B06DABDE000CB40A5746B19F945DF
            65189DD17FACCFDFC33250291D5A462A19DFBBCB4DA269E04C1396814AE9CA32
            AA9FE3C7697226BB0AB04CF3746299C399325AE27FD70A58062AA56DCB1C0EEE
            AA4AB75A4BB10C544ADB9651851C3EB9FA4A6DD74F2C0395D28F651A6EC538B0
            0C544ADB9611AA93E36AACFFB73722E3C0325029CD5BC6119CBD76A3BFCD9C5D
            726019A8944E2CE37033F186C1E06666CA38B00C544A57961950436678125303
            B37E1D58062AA54FCB38545DC793F4ACDFFF01CB40A5F46C19871BB2192E68B2
            5B87B10C544AE796B9B8787EF7DE83F1B43D2C531A2CD33CDD5AC63D4465FCD5
            ACDF0C18CB40A5F4661977CDC1F821FCEA2BDDBC759BD1DFDDC032CDD38F655C
            E365187F5154BD5B9AA18765A0527AB08C5432AEC9EED475330FE11FC0325029
            6D5B462A19375E9A9CF23B8065A052DAB68C2AA4FBD8D6E7C2C48065A0529A6F
            CBE803B7DA7809C03250296D5BA62BB00C540A9669062C0395D28F65DC4C999B
            B76EAB560FD1D769E6B1FC58062AA513CBC82FE3934D415E79F5B5065C8365A0
            527AB0CCF801B5975E7FE3C63BEFE95B285A3E9E046C7D861E96814A69DE32AA
            93EE934B2847EBE7F9F9F9E01AD3D7196019A894E62DE3EAB03C32713E5BBF72
            A25133C72F320896814A69DB326A9BB88F3D5B3387268FFFD92058062AA56DCB
            DCBDF7409F59ED14FFF324EE2E3376EB3096814A69DB32EEDB457E667597CC7D
            C13158062AA56DCBB80A1C79967A91922A04CB40A5F46099C86A8965F601CB34
            0F9619C032FB80659A07CB0C60997DC032CDD383651897A91A2CD33C6D5B6691
            38DC13E0EEDE7BE07FB60696814A69DB320F1F7EAECFAC6AEC7F9EC45D4E69B7
            0E6319A894B62D33CCFD9DBD40C9F948A2F13F1B04CB40A5B46D19E1EAF07473
            66B80939D731ED0096699EE62DA33AE93EF9A5D7DF38FA7494E1D633FA976BB2
            7700CB344FF39611AE37E4F2CAABAF5DBD765DDFC2DD34CFF9C5C5FA8DACB00C
            544A0F9611AA99E347EE07513D6FE0217058062AA513CB38DC83536EBCF39E2A
            B6E26E9AD7805F1C58062AA52BCBB40D96814AC132CDD08B65A882E6C032CD60
            D53254C1E6E9AA88D5D6D6E71FE7D1E327CD3CDFB617CB5CBD76DDAF0946585A
            C47ABD5FD31477EF3D9838C774E39DF71A708D55CBB8DBA6C6473D2CBF2618A1
            07CBB85B6DBAFCE5AF7F572D1D322C97834C4FC913562DA316E6500C91F16B82
            119AB7CCF0052F1D7B1E939A303A94BAB979913721AF16AB96192E368B8FF503
            426FB46D1949C41964BA2F3F5CC764FAF192562D2386EA1519D3E5D4216D5B66
            B8D27A76D865D13355EAC4B065B4DD871A16939BB76EFB35C1026D5BC63D213B
            E64AEBA1D563B7316ED832E391B39858EFDCF646DB9671E3BB91B7BF732FB67B
            CDA461CB2C3DCDA4303463881E2C133925DD6D0A5B5F708C61CB249C666268C6
            10586600CBECC950C322C3DC3C43B46D9945370CC7327B329EBC149906665276
            42DB9659248E452FAE10DB96715B7F51E834596169E1DADA09DD99EC98734C02
            CBECC9D9D9B3A1924546CD1FBF32D44DDB9671A38A91E73DDD69EFC8EE5585D8
            B68C98B8D2EC5438D36482B62D23DCC7F63F4CB268A8B842CC5B66E9AC1925B2
            990AFBD2BC65DCB4D21877B85979768714CD5BE6D1E327433D8B4CCCB46ED89D
            E62D13D90F72C3025C61B033CEF48B62AE467648DB9651B7DDF583D4E5D77F26
            E2C60454C983E58A7FAFEA69C132EE98B0283467EA67E9DC6E5B13F013E6941E
            C6BF57F5B4609984334D0ACD99CAD1D13E28B2E9D81AD4D7414EA25919FF5ED5
            D38265C4D2EBB315356738D95439EA1404A5762ACCEAAE99462CE3E6382D0D55
            B372225BA91C302AA711CB88843160C550B3B34F628E1FCCE7AE9C762CB3F494
            84CB2BAFBEC63070E53C7AFCE4D42144CB394ED44F3B96912CD29A33DC43AF7E
            54B877EF3D180FD3E8FF5AC211C204ED5846A4356714BB772103A89FA62C93DC
            9CD15A0C1F0264A229CB88E4E60C770506C8446B96517326E12A6D17AEA204C8
            416B961109D74F0E614230C0E6346819113F67F4304CBE00D896362DB3F41298
            2088066043DAB48C481E06764134005BD1AC6544C22594E3201A804D68D932EA
            37A54D9F19C2B46080F5B46C19A1F648208EA5B97AED3AD3D801D6D0B86544C2
            EDC783A8E77576F6CCBF1D002CA47DCBA825B272804651CF8B611A8034DAB78C
            583F40E342EF0920812E2C23D4E5D94434346A0096D28B65C4FA91E02197DFBC
            C2CD930022E9C8326243D12837DE798FFB4500CCD29765C4B6A251E41ACE4001
            4CD09D65C4E6A251D48762BC06E0283D5A46E4108DF297BFFEFDE6ADDB346D00
            C6746A199149342EAFBCFA9A7A528F1E3FE1CC3740BF9611138FE0D830975E7F
            43C6B97BEF01A7A5A04FBAB68C50EF26F90E9E6991D72EBF794551DFEACE471F
            13B2283A56996B20F76E19A1325B736F3D42CA47AD6343AEC1321EB52C828224
            A4E6A8516CE53C0396F99532C334846C15555713F342B1CC6F502BF4EAB5EB41
            5912526DD4D9F775B762B0CC1168D41043A9BFDF84658EA346CD8DD5B7BF22A4
            40EABF6F2C9699E2CBAF9E72FA89549EFA3B4D58669E870F3F2F3CA78690F860
            9976C035A4CE6099D678F4F8097D28525518976993B3B36737DE798FF350A486
            D47F7D1C9649E7E2E2B9BA51CCAF213BA6FEEE92C0321B30E886D60D2919D537
            13171960998D51F3F5CE471F33764372C78A620496C9882A81DA384E3A9C9F22
            1BE686A93BDB6399A2A866A8B1A338FB10B234AA39E69E9C816500202F580600
            F2826500202F580600F2826500202F580600F2826500202F580600F282650020
            2F580600F2826500202F580600F2826500202F580600F2826500202F580600F2
            826500202F580600F2826500202F580600F2826500202F580600F2826500202F
            580600F2826500202F580600F2826500202F580600F2826500202F580600F282
            6500202F580600F2826500202F580600F2826500202F580600F2826500202F58
            0600F2826500202F580600F2826500202F580600F2826500202F580600F28265
            00202F580600F2826500202F580600F2826500202F580600F2826500202F5806
            00F2826500202F580600F2826500202F580600F2826500202F580600F2826500
            202F580600F2826500202F580600F2826500202F580600F28265608677BF393B
            CCA7DF7FE77F0D300796815F79F2E30F97BF7EFAA7C79FBD74FFC33FDC79FB77
            6FFFCF6C5EFCE47DBD58AB483DDFFEFC937F2380115806FE23B3BCFCC5FD173E
            782B304842E426BD152D1D188365FA45AD8F3F7EF6F1EFFF712530C52691B3D0
            0D38B04C77A85FF3E77FFF7393964B4CD4A5FADBD37FF9BF0D5D82653A427EF9
            D3E3CF32355EA623A9E19A6EC132BDA0F6CB2E7E1947AEB9FCF553FF81A01BB0
            4CFBBCFBCD59E409A332511FEAC98F3FF80F071D80655A465DA497BFB81FECE4
            3544AD2AB5ADFCA784D6C132CDF2E9F7DF55D584398C1A354CB1E9012CD3267F
            7BFAAFDD476162A20FC9D9EEE6C1320D52672F69229C7E6A1B2CD31A7FFCECE3
            601F36913F3DFECC7F01680E2CD30EDFFEFC9351C5B8E8C3FB6F026D8165DAC1
            B4625C104D936099466840312E88A63DB04C0B34A3181744D31858C63C8D29C6
            05D1B40496B14D938A714134CD80650CD3B0625C104D1B6019AB34AF181744D3
            0058C6249D28C605D15807CBD8A32BC5B8201AD360196374A818174463172C63
            896E15E382688C8265CCD0B9625C108D45B08C0D50CC1044630E2C6300141304
            D1D802CBD40E8A391A4463082C533528662288C60A58A65E50CC6C108D09B04C
            A5A098C8209AFAC1323582621605D1540E96A90E14931044533358A62E504C72
            104DB560998A40312B8368EA04CBD4028AD92488A642B04C15A0980D83686A03
            CBEC0F8AD93C88A62AB0CCCEA0984C4134F58065F604C5640DA2A9042CB31B28
            A640104D0D60997D4031C582687607CBEC008A291C44B32F58A634286697209A
            1DC1324541313B06D1EC059629078AD93D886617B04C21504C254134E5C13225
            F8F3BFFF19D475B2632E7FFDD4170C1401CB94E0DD6FCE828A4E76CCB73FFFE4
            0B068A80654AA06A1D5474B2637CA94029B04C21828A4E768C2F122805962944
            50D1C98EF14502A5C03285082A3AD931BE48A01458A6104145273BC617099402
            CB1422A8E864C7F822815260994204159DEC185F24500A2C5388A0A2931DE38B
            044A81650A115474B2637C914029B04C21828A4E768C2F12280596294450D1C9
            8EF14502A5C032E97CFBF34F7FB8F3B6FF618EA0A2931DE38B649277BF39E3EA
            EDADC0328938C544565931AEE564DFF82299C45DE08A683601CBA4302826B2CA
            0AF76252437C914C325C468F68D683651633564C649515C3EBC9EEF14532C9F8
            661D886625586619816214FF8B39C6AB907DE38B6492E0964088660D58660187
            8A51FCEFE608D6223BC617C92481651444930C9689E5A86214FFEB3982B5C85E
            79E183B77C914C72681905D1A48165A238A518C5BF628E602DB2575EFCE47D5F
            24931CB58C826812C032F34C2846F9F4FBEFFCEB2609D6227B65A5651444B314
            2C33C3B462145547FFD24954B98315C92E8974C4F4632710CD22B0CC14B38A51
            222DF3D2FD0F8315C92EF9D3E3CF7C914CA297052B064134F1609993C42846D9
            AAD69232897C18932412AC781844130996394EA4629497BFB8EFD79964A29F4F
            4A4625EB8B6492C81E2EA28901CB1C215E314AE468A2DE335891944FE4696C11
            AC381144330B960959A41817BFE61C0C00EF9EC886E7A7DF7F17AC381D44330D
            96F90D098A51224F66F3B4ECDD1359527F7BFAAF60C5D9209A09B0CCAFA42946
            913EFC5B4C42A769DFC47797A48C60DD98209A5360194FB2629497EE7FE8DF65
            8EB4EA4B3649E4D940211F05EB4606D11C05CBFC97358A71D13BF8F79A84334D
            7BE5F7FFB81259464B076582209A43B0CC068A51D493F76F370763C0BB24BE21
            F3F217F783759706D104F46E994D14A3C4779A68CE944F7C4346247797C64134
            63BAB6CC568A7179F2E30FFE7DE76074A6702287E7C586C7004433D0AF65B655
            8C12DF26D79FD6D135589D648A4AD96FF708B63D00201A47A796D95C314AFC89
            5271F9EBA7C1EA244764F3C8393242ADD160F5F54134A247CBE4508C4BFC18B0
            583FCA4866B3A84432F564114D7796C9A7186551734670BE296B22AF2770E468
            C80CE95C347D5926AB625CE2071A4581CFD36D96EED8991A32437A164D479629
            B34B2F3A692A104D8E2CDDA557CEC48B4CB7A2E9C5322577E6A59509D16C9B84
            9DB9DABAD1065D58A6FC6E1C799BCE0144B3551276E3C2D7CA77289AF62DB3CB
            0EFCC2076FE9EFFA4F1007A2599F841D587DA5F273977A134DE396D971D78DBF
            E66000D1AC49C2AEBBE306EF4A342D5B66F79D76D1F92607A2494BDA4EABB582
            F729997E44D3AC652AD95D970ED00844B33469BB6BC20DF1364F27A269D332F5
            ECA88B66B80F209AF8D8558C4B0FA269D032B5EDA288265FD276D15D467C27D2
            BC685AB34C9D3B27A2C9913614E3D2B6689AB24CCDBB25A2D9362D29C6A561D1
            B46399FA774844B355DA538C4BABA269C43256764544B33EAD2AC6A549D1B460
            195B3B21A25993B615E3D29E68CC5BC6E2EE8768D2D283625C1A138D6DCBD8DD
            F110CDD2F4A31897964463D832D6773944139FDE14E3D28C68AC5AA68D9D0DD1
            C4A44FC5B8B4211A93966969374334D3E959312E0D88C69E65DADBC110CDA9A0
            1817EBA231669956772D44731814338E69D158B24CDB3B15A21907C51CC6AE68
            CC58A6870E02A2714131A7625434362CD383625C100D8A998E45D118B04C3F8A
            71E95934282626E64453BB657A538C4B9FA24131F1B1259AAA2DD3A7625C7A13
            0D8A591A43A2A9D7323D2BC6A51FD1A098B458114DA59641312E3D8806C5AC89
            09D1546A99173F793FD89ADDA66DD1A098F5A95F34355A465B2DD88E9DA755D1
            A098AD52B968AAB30C8A399AF6448362B64DC2834C8B5197655EFEE27EB0EDC8
            909644836272E46F4FFFE5B754655464997A1EF7576DDA100D8AC99784EA5180
            5A2C431D8A8C75D1A098AC79E183B754D67EAB55431596A979F8A0C2D8150D8A
            299097EE7FE8375C35546119866396C6A268504CB1D43612BCBF65DEFDE62CD8
            462426B64483624A461BADAA7ED3FE96A1AF941C2BA24131E55355BF6967CBA8
            69176C1DB228F58B06C5EC15F512FCD6DC9B3D2DA3BA4E4D5A9F9A45836276CC
            8B9FBCEF37E8DEEC69993F3DFE2CD82E242D758A06C5EC9ECB5F3FF59B755776
            B30C0D996D539B68504C0DA9A439B39B651891D93CF58806C5D4931A466776B3
            CC0B1FBC156C0EB23E358806C554951A4E36ED6319E6C8E4CBBEA249ABD32826
            6B9EFCF883DFD03BB18F6574B80B3604D930C9A259B9ABCB537A13FF76D1A098
            DCD97D2AF03E96A156E54E9A68D6B431F517138E9928A640647FBFB9776207CB
            5CFEFA69B015488EA48926797A41C20113C514CBBE9DA61D2C4377A9581244A3
            2E4FC2C07CC2D112C594CCBE37B8DAC1329C5D2A9904D124DC4E6CE9E9521453
            38FB9E692A6D19B5DC82EF4F722741348B8E047AB15F2D0E14533EDAE07EEBEF
            4169CB3028B34B968A66D1E8CCA2111914B357761C9A296D19AE5DDA2B8B44B3
            A8C9195F7D51CC8ED9F19AA6D296E1716E3B467B78FC7C96C84E53FCB82F8AD9
            373AC0FB92284E69CB6C32C1942427FEF2B9C85381F1D71330EABF6F761C002E
            6D99E09B93F2893C1F1479396BE4A00C8FC1D93D3B5E9F8D65BA4B64EB23721E
            70A4B3E829EF1E75577D6114A7A865D64C60275B25F2C4F3B69609D622BBC417
            4671B04C8FF1E531C9B73FFF14AC753491279882B5C82EF185511C2CD3637C79
            CC11AC753458C6507C611407CB7497C8FE393DA6F6E20BA33858A6BB449ED1DC
            D632CC60A821BE308A8365BA4BE41CD06DCF6447BE1BC91A5F18C5C1327D257E
            D244E4C3CBF532BFC22469379420DBC6174671B04C47F9FD92DBD945F671E2AF
            30A0F4778F2F89E214B58C08BE3629162966F7AB259901BC6396DEA06343B04C
            1759A418B16818257268C68168F64A47571870AEA17C962A462C1A4389EF3439
            10CD2EE9E86A497DD5E0CB93AC49504C813B72229AF2E9E8CE0FDCC5AA641214
            23124E0625B4C6114DE17474172BEEC8592C698A493E0C245462445332F183F4
            9B53DA3291D7E0919549538C5609DE273EFA8BF137E21B403465B2E3092651DA
            328201E0DC4953CCFA8973696731104D81C4DFD230073B5826725229494BB262
            36B17F5A6D4634B9A32DECB7F51EEC6019E680E6CBBE8A7141341526A133BB21
            3B5846686708B602599F1A14E38268AACABE0F9614FB5846B530D8106465EA51
            8C0BA2A927FB7697C43E96D1FE106C08B226B529C605D154927DBB4B621FCB88
            ACF5BBABD4A9181744B37BD28A605B76B30C356993D4AC181744B36F12AAC7E6
            EC6619B1727606A95F312E8866AFEC781DF6983D2D43355A132B8A714134BB64
            E955AC99D8D33282E64C5A6C29C605D1144E250D19B1B365A84309B1A8181744
            5332358CC83876B68C907183AD43266257312E88A64C22EFFA5E86FD2DA37D26
            D840E454AC2BC605D1E4CE0B1FBCA542F71BAE02F6B78CE0D656316943312E88
            266B76BC61D551AAB08CA0DF349D9614E3826832A5AABE92A316CB3CF9F107ED
            48C1F6222EED29C605D16C1E9578557D25472D9611DC11E2685A558C0BA2D930
            AA2A3BDE7673828A2C23A83D41DA568C0BA2D92A0955A50C7559467027BD213D
            28C605D1AC8FB686DF2EF5519D6584EA5CB0053B4C3F8A7141346B52B362448D
            96119D8BA637C5B8209AB454AE1851A96544B7A2E953312E886669EA578CA8D7
            32A243D1F4AC181744131F138A11555B4674251A14E3826862624531A276CB88
            4E448362C64134D331A41861C032A279D1A098C3209A53B1A51861C332A261D1
            A0985341348731A71861C632A249D1A098E9209A712C2A4658B28C684C342826
            2688C6C5A8628431CB8866448362E28368EC2A46D8B38C6840342866697A168D
            69C508939611A6458362D2D2A768AC2B4658B58C302A1A14B326BD89A601C508
            C39611E6448362D6A71FD1B4A11861DB32C2906850CC56E94134CD284698B78C
            30211A14B36DDA164D4B8A112D5846542E1A149323AD8AA631C588462C23AA15
            0D8AC997F644D39E62443B9611158A06C5E44E4BA2695231A229CB88DA449350
            6F50CCD2A489A6B6279AB6AA18D19A65443DA2513DF69F291A14939634D1D453
            551A568C68D032A286DAF3D2FD0FFDA78906C5AC4982682AD9E06D2B46B46919
            B1AF687EFF8F2BAAC1FEA3C48162D62741349F7EFF5DF02685D3BC6244B39611
            3B8AE6DD6FCEFC878803C56C9504D1FCF9DFFF0CDEA4587A508C68D9326217D1
            2CADE82866DB24886697EDDF896244E396118545B3B4AF84627264A968CAF79B
            FA518C68DF32A2A468D4FCF67F350E1493294B4553B29274A518D1856544993A
            F4C2076FF9BF1747C99ADD6116CD2478F2E30F6A8706EF9023BD2946F4621951
            60975E54816A9B15D6642E7FFDD46FEE080A9448878A111D59466415CDA286CC
            BBDF9C05AB931C51F3448D14BFD1E7D02B83D5B74D9F8A117D5946E4134DFC88
            CCB73FFF54A6714E943FDC79DB6FF708F2558F6E1523BAB38CC85193169D5A2A
            D07723E3C41F00329D6CEA5931A247CB88CDF773BDA17FEB39E82B95CFA263C0
            E667FD3A578CE8D432625BD1C48F32BEF8C9FBC1BAA4405EFEE2BE2F8039B69D
            0A8C6244BF96115B8946874AFF8E73D090D93191C3C01B8E01A31847D796119B
            8826BEBBF4D2FD0F837549B1C44F9FD9A4D38462067AB78C582F9AC8FA94FB44
            29994E7C9353DDAB60DDA5413163B0CC7F59299AC8A6F88ED7FE1297C8E133BD
            2C587151504C0096F1248B267E321E972CED9EC8BEEDB73FFF14AC181F147308
            96F99534D144DE138FEE520D89EF34A51D1250CC51B0CC6F48104DE498A2EA5F
            B022D925918F944818A74731A7C032214B4513D9D54FEE91916D13390F78E995
            932866022C7384454688BCF92693F12A890AD717C9248BDA9E28661A2C739C78
            D1F815E608D6227B45BAF7453249FCFC4914330B963949A468FCABE708D6227B
            25F29C60A465504C0C58668A18D1F8974EC2850555C597CA243127B3514C2458
            668669D1449E19C53255C597CA1CC15A41504C3C58669E09D16CDEC92705E24B
            658E60AD7150CC22B04C14A74483652CC697CA1CC15A4350CC52B04C2C474583
            652CC697CA1CC15A2E2826012CB38043D160198BF1A53247B0968262D2C032CB
            084483652CC697CA1CC15A2826192CB398B168B08CC5F8529963BC0A8A590396
            4961100D96B1185F2A730CAF47312BC1328938D160198BF1A532877B318A590F
            964947A2C13216E34B650EBD12C56C02965945642DC43255C597CA1C28662BB0
            4C09B04C55F1A502A5C03225C03255C5970A9402CB9400CB54155F2A500A2C53
            022C53557CA94029B04C09B04C55F1A502A5C03225C03255C5970A9402CB9400
            CB54155F2A500A2C53022C53557CA94029B04C09B04C55F1A502A5C03225C032
            55C5970A9402CB9400CB54956F7FFEC9170C1401CB9460E9E35049D6443E7418
            B602CB94E0E52FEE07159DEC182C53182C5388E0569E64AF70A57579B04C3910
            CDEE4131BB80658A8268760C8AD90B2C531A44B34B50CC8E60991D4034858362
            F605CBEC03A2291614B33B586637104D81A0981AC0327B8268B206C5540296D9
            1944932928A61EB0CCFE209ACD8362AA02CB5401A2D93028A636B04C2D209A4D
            82622A04CB5404A2591914532758A62E104D72504CB56099EA40340941313583
            656A04D12C0A8AA91C2C532988263228A67EB04CBD209AD9A018136099AA4134
            13413156C032B583688E06C51802CB1800D1044131B6C03236403443508C39B0
            8C19108D82622C82652CD1B968508C51B08C31BA150D8AB10B96B14787A24131
            A6C13226E94A3428C63A58C62A9D8806C5340096314CF3A241316D80656CD3B0
            68504C336019F334291A14D31258A6051A130D8A690C2CD308CD8806C5B40796
            6987064483629A04CB348569D1A09856C132ADF1F217F783BDD744504CC36099
            06D11E1BECC335E7F7FFB8F2EE3767FEA3438B609936F9F4FBEFB4F706FB7385
            F9C39DB79FFCF883FFD0D02858A659BEFDF9A7173F793FD8ABAB8A3A77FA90FE
            E342BB6099C6F9F3BFFF5961A3461FE9F2D74FFD4784D6C132EDA32EC94BF73F
            0CF6F31D4313A637B04C2FBCFBCDD90B1FBC15ECF085A31EDCA7DF7FE73F1074
            0396E98BBF3DFDD72EAE915F3891D42D58A647B4C317EB43FDF1B38F69BF740E
            96E997273FFEF0E77FFFF30F77DE0EBCB049F4B66A3731FE0202CB80D78D5A37
            2BCF466975B55C900B046019F80DEADD48137F7AFCD98B9FBC3F3DDD464ED10B
            E426BDF8F2D74F995C07A7C0320090172C030079C1320090172C030079C13200
            90172C030079C1320090172C030079C1320090172C030079C1320090172C0300
            79C1320090172C030079C1320090172C030079C1320090172C030079C1320090
            172C030079C1320090172C030079C1320090172C030079C1320090172C030079
            C1320090172C030079C1320090172C030079C1320090172C030079C132009017
            2C030079C1320090172C030079C1320090172C030079C1320090172C030079C1
            320090172C030079C1320090172C030079C1320090172C030079C1320090172C
            030079C1320090172C030079C1320090172C030079C1320090172C030039F9CF
            7FFE3F873574C29F896A560000000049454E44AE426082}
          HightQuality = True
          Transparent = True
          TransparentColor = clWhite
        end
      end
    end
  end
  object cdsDadosGuia: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 181
    Top = 96
    object cdsDadosGuiaIdentificador: TStringField
      FieldName = 'Identificador'
      Size = 1
    end
    object cdsDadosGuiaSequencialGuia: TStringField
      FieldName = 'SequencialGuia'
      Size = 4
    end
    object cdsDadosGuiaSituacaoGuia: TStringField
      FieldName = 'SituacaoGuia'
      Size = 1
    end
    object cdsDadosGuiaUFfavorecido: TStringField
      FieldName = 'UFfavorecido'
      Size = 2
    end
    object cdsDadosGuiaCodigoReceita: TStringField
      FieldName = 'CodigoReceita'
      Size = 6
    end
    object cdsDadosGuiaTipoDocEmitente: TStringField
      FieldName = 'TipoDocEmitente'
      Size = 1
    end
    object cdsDadosGuiaDocumentoEmitente: TStringField
      FieldName = 'DocumentoEmitente'
      Size = 18
    end
    object cdsDadosGuiaRazaoSocialEmitente: TStringField
      FieldName = 'RazaoSocialEmitente'
      Size = 60
    end
    object cdsDadosGuiaEnderecoEmitente: TStringField
      FieldName = 'EnderecoEmitente'
      Size = 60
    end
    object cdsDadosGuiaMinicipioEmitente: TStringField
      FieldName = 'MunicipioEmitente'
      Size = 50
    end
    object cdsDadosGuiaUFemitente: TStringField
      FieldName = 'UFemitente'
      Size = 2
    end
    object cdsDadosGuiaCepEmitente: TStringField
      FieldName = 'CepEmitente'
      Size = 10
    end
    object cdsDadosGuiaTelefoneEmitente: TStringField
      FieldName = 'TelefoneEmitente'
      Size = 16
    end
    object cdsDadosGuiaTipoDocDestinatario: TStringField
      FieldName = 'TipoDocDestinatario'
      Size = 1
    end
    object cdsDadosGuiaDocumentoDestinatario: TStringField
      FieldName = 'DocumentoDestinatario'
      Size = 120
    end
    object cdsDadosGuiaMunicipioDestinatario: TStringField
      FieldName = 'MunicipioDestinatario'
      Size = 50
    end
    object cdsDadosGuiaProduto: TStringField
      FieldName = 'Produto'
      Size = 255
    end
    object cdsDadosGuiaNumeroDocumentoOrigem: TStringField
      FieldName = 'NumeroDocumentoOrigem'
      Size = 18
    end
    object cdsDadosGuiaConvenio: TStringField
      DisplayWidth = 120
      FieldName = 'Convenio'
      Size = 120
    end
    object cdsDadosGuiaInformacoesComplementares: TStringField
      FieldName = 'InformacoesComplementares'
      Size = 300
    end
    object cdsDadosGuiaDataVencimento: TStringField
      FieldName = 'DataVencimento'
      Size = 10
    end
    object cdsDadosGuiaDataLimitePagamento: TStringField
      FieldName = 'DataLimitePagamento'
      Size = 10
    end
    object cdsDadosGuiaPeriodoReferencia: TStringField
      FieldName = 'PeriodoReferencia'
      Size = 8
    end
    object cdsDadosGuiaMesAnoReferencia: TStringField
      FieldName = 'MesAnoReferencia'
      Size = 6
    end
    object cdsDadosGuiaParcela: TStringField
      FieldName = 'Parcela'
      Size = 3
    end
    object cdsDadosGuiaValorPrincipal: TCurrencyField
      FieldName = 'ValorPrincipal'
    end
    object cdsDadosGuiaAtualizacaoMonetaria: TCurrencyField
      FieldName = 'AtualizacaoMonetaria'
    end
    object cdsDadosGuiaJuros: TCurrencyField
      FieldName = 'Juros'
    end
    object cdsDadosGuiaMulta: TCurrencyField
      FieldName = 'Multa'
    end
    object cdsDadosGuiaRepresentacaoMonetaria: TStringField
      FieldName = 'RepresentacaoNumerica'
      Size = 48
    end
    object cdsDadosGuiaCodigoDeBarras: TStringField
      FieldName = 'CodigoDeBarras'
      Size = 44
    end
    object cdsDadosGuiaQtdVias: TStringField
      FieldName = 'QtdVias'
      Size = 1
    end
    object cdsDadosGuiaNumeroControle: TStringField
      FieldName = 'NumeroControle'
      Size = 16
    end
    object cdsDadosGuiaIdentificadorGuia: TStringField
      FieldName = 'IdentificadorGuia'
      Size = 10
    end
    object cdsDadosGuiaGuiaGeradaContingencia: TStringField
      FieldName = 'GuiaGeradaContingencia'
      Size = 10
    end
    object cdsDadosGuiaReservado: TStringField
      FieldName = 'Reservado'
      Size = 126
    end
    object cdsDadosGuiaValor: TCurrencyField
      FieldName = 'Valor'
    end
    object cdsDadosGuiaAmbiente: TStringField
      FieldName = 'Ambiente'
      Size = 1
    end
    object cdsDadosGuiaCodigoBarrasBoleto: TStringField
      FieldName = 'CodigoBarrasBoleto'
      Size = 48
    end
    object cdsDadosGuiaCodigoEmpresa: TStringField
      FieldName = 'CodigoEmpresa'
      Size = 3
    end
    object cdsDadosGuiaQrCode: TStringField
      FieldName = 'QrCode'
      Size = 500
    end
    object cdsDadosGuiaTitulo: TStringField
      DisplayWidth = 200
      FieldName = 'Titulo'
      Size = 200
    end
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 79
    Top = 96
  end
  object frxDBDatasetGuia: TfrxDBDataset
    UserName = 'Guia'
    CloseDataSource = False
    DataSet = cdsDadosGuia
    BCDToCurrency = False
    Left = 181
    Top = 35
  end
  object frxPDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 100
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 80
    Top = 152
  end
end
