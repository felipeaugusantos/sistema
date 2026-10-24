object frmQckHTMLPedidoCompra: TfrmQckHTMLPedidoCompra
  Left = 400
  Top = 278
  Caption = 'frmQckHTMLPedidoCompra'
  ClientHeight = 378
  ClientWidth = 546
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object frxPagina: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39504.578949363400000000
    ReportOptions.LastChange = 45685.014362256940000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllObservacoesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  //                                      '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPaginaUserFunction
    Left = 24
    Top = 136
    Datasets = <
      item
        DataSet = frxEmpresa
        DataSetName = 'frxEmpresa'
      end
      item
        DataSet = frxPedido
        DataSetName = 'frxPedido'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxTransp
        DataSetName = 'frxTransp'
      end
      item
        DataSet = frxTranspRedesp
        DataSetName = 'frxTranspRedes'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Relatorio: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 2.500000000000000000
      BottomMargin = 2.500000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      OnBeforePrint = 'RelatorioOnBeforePrint'
      object Titulo: TfrxPageHeader
        FillType = ftBrush
        Height = 365.102574560000000000
        Top = 18.897650000000000000
        Width = 774.803650000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        Stretched = True
        object rllImagem: TfrxPictureView
          ShiftMode = smWhenOverlapped
          Left = 12.559060000000000000
          Top = 18.338590000000000000
          Width = 235.472480000000000000
          Height = 94.118120000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object dbEmrpesa: TfrxMemoView
          Left = 262.519790000000000000
          Top = 18.897637800000000000
          Width = 457.323130000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxEmpresa."EMP_NOMEMP"]')
          ParentFont = False
        end
        object dbEnderecoEmpresa: TfrxMemoView
          Left = 262.519790000000000000
          Top = 34.015770000000010000
          Width = 457.323130000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_ENDERE"]')
          ParentFont = False
        end
        object rllPedOrc: TfrxMemoView
          Left = 14.779530000000000000
          Top = 184.795275590000000000
          Width = 438.425480000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pedido de Compra N'#186':')
          ParentFont = False
        end
        object mmNomeCliente: TfrxMemoView
          Left = 14.779530000000000000
          Top = 202.212740000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nome:  ')
          ParentFont = False
        end
        object dbNomeCliente: TfrxMemoView
          Left = 85.811070000000000000
          Top = 202.433210000000000000
          Width = 684.094930000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxPedido."FOR_NOMFOR"]')
          ParentFont = False
        end
        object mmEnderecoCliente: TfrxMemoView
          Left = 14.779530000000000000
          Top = 218.078740160000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object dbEnderecoCliente: TfrxMemoView
          Left = 85.811070000000000000
          Top = 218.078740160000000000
          Width = 366.614410000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."ENDERE"]')
          ParentFont = False
        end
        object mmFoneCliente: TfrxMemoView
          Left = 14.779530000000000000
          Top = 266.921460000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fone:  ')
          ParentFont = False
        end
        object dbBairroCliente: TfrxMemoView
          Left = 526.133863150000000000
          Top = 218.078740160000000000
          Width = 366.614410000000000000
          Height = 15.118110240000000000
          DataField = 'FOR_BAIRRO'
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_BAIRRO"]')
          ParentFont = False
        end
        object dbTelefoneCliente: TfrxMemoView
          Left = 85.811070000000000000
          Top = 266.921460000000000000
          Width = 104.567100000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Length(<frxPedido."FOR_FONE01">) > 0 , fFormataFone(<frxPed' +
              'ido."FOR_FONE01">),'#39#39')]')
          ParentFont = False
        end
        object mmCNPJCliente: TfrxMemoView
          Left = 14.779530000000000000
          Top = 250.582870000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ:  ')
          ParentFont = False
        end
        object dbCNPJCliente: TfrxMemoView
          Left = 85.811070000000000000
          Top = 250.582677170000000000
          Width = 234.330860000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxPedido."FOR_C_G_C_">) > 0 ,'
            
              ' FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxPedido."FOR_C_G_C_' +
              '">),'#39#39')]')
          ParentFont = False
        end
        object mmIECliente: TfrxMemoView
          Left = 453.543307090000000000
          Top = 250.582677170000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'IE:  ')
          ParentFont = False
        end
        object dbIECliente: TfrxMemoView
          Left = 526.133863150000000000
          Top = 250.582677170000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_I_E_S_"]')
          ParentFont = False
        end
        object mmContatoCliente: TfrxMemoView
          Left = 14.779530000000000000
          Top = 314.409710000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Contato:  ')
          ParentFont = False
        end
        object dbContatoCliente: TfrxMemoView
          Left = 85.811070000000000000
          Top = 314.409710000000000000
          Width = 317.480520000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_CONTAT"]')
          ParentFont = False
        end
        object dbBairroEmpresa: TfrxMemoView
          Left = 262.669450000000000000
          Top = 49.133858270000010000
          Width = 457.323130000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_NOMCID"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 203.000000000000000000
          Top = 266.834645670000000000
          Width = 108.567100000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Length(<frxPedido."FOR_FONE02">) > 0 , fFormataFone(<frxPed' +
              'ido."FOR_FONE02">),'#39#39')]')
          ParentFont = False
        end
        object Line22: TfrxLineView
          Left = 1.889763780000000000
          Top = 130.078850000000000000
          Width = 771.023622050000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo14: TfrxMemoView
          Left = 11.338582680000000000
          Top = 134.063080000000000000
          Width = 774.803149610000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Departamento de Compras')
          ParentFont = False
        end
        object rllTituloPedOrc: TfrxMemoView
          Left = 11.338582680000000000
          Top = 157.519790000000000000
          Width = 774.803149610000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Or'#231'amento')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 14.779530000000000000
          Top = 298.204734170000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cond. Pgto.:')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 453.543307090000000000
          Top = 266.834645670000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Aten'#231#227'o:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 453.543307090000000000
          Top = 218.078740160000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 14.779530000000000000
          Top = 234.330708660000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 453.543307090000000000
          Top = 234.330708660000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C.E.P.:')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 453.543307090000000000
          Top = 283.086614170000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Entrega:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 85.811070000000000000
          Top = 234.330708660000000000
          Width = 355.275820000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_NOMCID"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 526.133863150000000000
          Top = 234.330708660000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxPedido."FOR_C_E_P_">) > 0 ,'
            ' FormatMaskText('#39'00000-000;0'#39',<frxPedido."FOR_C_E_P_">),'#39#39')]')
          ParentFont = False
        end
        object mmoConPag: TfrxMemoView
          Left = 82.031540000000000000
          Top = 298.204734170000000000
          Width = 532.913730000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataCondPag(<frxPedido."PCG_CONPAG">)]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 526.133863150000000000
          Top = 266.834655430000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_ATENCA"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 526.133863150000000000
          Top = 283.086614170000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_DTAENT"]')
          ParentFont = False
        end
        object dbFoneEmpresa: TfrxMemoView
          Left = 296.535560000000000000
          Top = 111.748072990000000000
          Width = 117.165359210000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataFone(<frxEmpresa."EMP_FONE01">)]')
          ParentFont = False
        end
        object dbCEPEmpresa: TfrxMemoView
          Left = 262.889920000000000000
          Top = 96.629962750000000000
          Width = 457.323130000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_EMAILC"]')
          ParentFont = False
        end
        object dbFaxEmpresa: TfrxMemoView
          Left = 444.314958190000000000
          Top = 111.748072990000000000
          Width = 136.063009210000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataFone(<frxEmpresa."EMP_F_A_X_">)]')
          ParentFont = False
        end
        object mmFoneEmpresa: TfrxMemoView
          Left = 263.330860000000000000
          Top = 111.748072990000000000
          Width = 30.614173230000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone:')
          ParentFont = False
        end
        object mmFaxEmpresa: TfrxMemoView
          Left = 415.968501500000000000
          Top = 111.748072990000000000
          Width = 26.456710000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fax: ')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 262.787570000000000000
          Top = 81.252010000000000000
          Width = 37.795300000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ:  ')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 302.819110000000000000
          Top = 81.252010000000000000
          Width = 109.606370000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxEmpresa."EMP_C_G_C_">) > 0 ,'
            
              ' FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxEmpresa."EMP_C_G_C' +
              '_">),'#39#39')]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 415.968501500000000000
          Top = 81.630004250000000000
          Width = 18.897650000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE:  ')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 444.314958190000000000
          Top = 81.630004250000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_I_E_S_"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 453.543307090000000000
          Top = 328.819110000000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tipo Frete:')
          ParentFont = False
        end
        object rllTipFre: TfrxMemoView
          Left = 527.354333150000000000
          Top = 328.819110000000000000
          Width = 2834.645669290000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fDescricaoFrete(<frxPedido."PCG_TIPFRE">)]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 14.779530000000000000
          Top = 283.464750000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fax:  ')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 85.811070000000000000
          Top = 283.464750000000000000
          Width = 104.567100000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Length(<frxPedido."FOR_F_A_X_">) > 0, fFormataFone(<frxPedi' +
              'do."FOR_F_A_X_">),'#39#39')]')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 453.543307090000000000
          Top = 313.700990000000000000
          Width = 71.433070870000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Faturamento:')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 526.133863150000000000
          Top = 313.700990000000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF((<frxPedido."PCG_DTAFAT"> = <frxPedido."PCG_DTAENT">) AND (' +
              'STRFATPED = '#39'1'#39'), '#39'IMEDIATO'#39', <frxPedido."PCG_DTAFAT">)]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 262.787570000000000000
          Top = 65.252010000000000000
          Width = 457.323130000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_BAIRRO"] - CEP.: [frxEmpresa."EMP_C_E_P_"]')
          ParentFont = False
        end
        object rllPgtVis: TfrxMemoView
          Left = 617.063390000000000000
          Top = 297.425204170000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PAGTO. A VISTA')
          ParentFont = False
        end
        object mmEspecie: TfrxMemoView
          Left = -113.929190000000000000
          Top = 347.716745350000000000
          Width = 79.370130000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Left = 7.559060000000000000
          Top = 343.937230000000000000
          Width = 71.811030940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ped. Venda.:')
          ParentFont = False
        end
        object Memo80: TfrxMemoView
          Left = 83.929146060000000000
          Top = 344.157700000000000000
          Width = 680.315400000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_PEDVEN"]')
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          Left = 526.134156060000000000
          Top = 184.795275590000000000
          Width = 366.614410000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_CODCMP"] - [frxPedido."COMPRA"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo82: TfrxMemoView
          Left = 453.543307090000000000
          Top = 184.795275590000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Comprador:')
          ParentFont = False
        end
      end
      object Rodape: TfrxPageFooter
        FillType = ftBrush
        Height = 170.417440000000000000
        Top = 1160.315710000000000000
        Width = 774.803650000000000000
        object Memo42: TfrxMemoView
          Left = 4.559060000000000000
          Top = 1.913420000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES:')
          ParentFont = False
        end
        object rllObservacoes: TfrxMemoView
          Left = 5.559060000000000000
          Top = 21.574830000000000000
          Width = 763.465060000000000000
          Height = 101.291345910000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10')
          ParentFont = False
          WordWrap = False
        end
        object rllObservacao: TfrxMemoView
          Left = 124.724490000000000000
          Top = 2.897650000000113000
          Width = 634.961040000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = False
        end
        object Line166: TfrxLineView
          Left = 7.118120000000000000
          Top = 21.370130000000000000
          Width = 759.685032050000000000
          Color = clBlack
          Diagonal = True
        end
        object mmCitelSoftware: TfrxMemoView
          Align = baRight
          Left = 442.204502280000000000
          Top = 152.992270000000000000
          Width = 332.599147720000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          ParentFont = False
        end
        object Line14: TfrxLineView
          Align = baWidth
          Top = 151.212740000000000000
          Width = 774.803650000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo47: TfrxMemoView
          Align = baLeft
          Top = 152.992270000000000000
          Width = 374.172962280000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emitido em [Date] '#224's [Time]')
          ParentFont = False
        end
        object mmoMsgPcm: TfrxMemoView
          Left = 2.118120000000000000
          Top = 119.063080000000000000
          Width = 759.685530000000000000
          Height = 14.362204724409450000
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[MSGPCM]')
          ParentFont = False
          WordWrap = False
        end
        object Memo52: TfrxMemoView
          Left = 0.779530000000000000
          Top = 133.944960000000000000
          Width = 721.890230000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MSGPC2]')
          ParentFont = False
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Left = 723.669760000000000000
          Top = 133.944960000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'P'#225'g:[Page#]/[TotalPages#]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object Detalhes: TfrxMasterData
        FillType = ftBrush
        Frame.ShadowWidth = 1.000000000000000000
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Height = 32.125994020000000000
        Top = 529.134200000000000000
        Width = 774.803650000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        Child = frxPagina.ChildAplicacao
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object frxRelatorioCODITEM: TfrxMemoView
          Left = 6.338590000000000000
          Top = 1.559059999999931000
          Width = 52.913390710000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PCD_CODITE"]')
          ParentFont = False
        end
        object mmoDescri: TfrxMemoView
          ShiftMode = smDontShift
          Left = 63.708720000000000000
          Top = 1.559059999999931000
          Width = 222.220470000000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataField = 'PCD_DESITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PCD_DESITE"]')
          ParentFont = False
        end
        object mmoUnidade: TfrxMemoView
          Left = 263.818897640000000000
          Top = 18.456710000000040000
          Width = 28.346456690000000000
          Height = 13.228346460000000000
          DataField = 'UNI_SIGUNI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          ParentFont = False
        end
        object mmoDesMar: TfrxMemoView
          Left = 78.661417320000000000
          Top = 18.456710000000040000
          Width = 69.165354330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoCodFabrica: TfrxMemoView
          Left = 152.496062990000000000
          Top = 18.456710000000040000
          Width = 109.606335830000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdIte: TfrxMemoView
          Left = 294.566929130000000000
          Top = 18.456710000000040000
          Width = 45.354333150000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
        end
        object rllPrecoUnit: TfrxMemoView
          Left = 343.212598430000000000
          Top = 18.456710000000040000
          Width = 60.472440940000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          ParentFont = False
        end
        object rllPrecotot: TfrxMemoView
          Left = 520.165354330000000000
          Top = 18.456710000000040000
          Width = 68.031498500000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          ParentFont = False
        end
        object rllIpi: TfrxMemoView
          Left = 592.000000000000000000
          Top = 18.456710000000040000
          Width = 32.125984250000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PCD_PERIPI"]')
          ParentFont = False
        end
        object rllVlIpi: TfrxMemoView
          Left = 628.795275590000000000
          Top = 18.456710000000040000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTIPI"]')
          ParentFont = False
        end
        object rllDesUni: TfrxMemoView
          Left = 407.488188980000000000
          Top = 18.456710000000040000
          Width = 45.354320940000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(1 - (1 - <frxRelatorio."PCD_DESUNI"> / 100) * (1 - <frxRelator' +
              'io."PCD_DESUN2"> / 100) * (1 - <frxRelatorio."PCD_DESUN3"> / 100' +
              ') * (1 - <frxRelatorio."PCD_DESUN4"> / 100) '
            
              '* (1 - <frxRelatorio."PCD_DESUN5"> / 100) * (1 - <frxRelatorio."' +
              'PCD_DESUN6"> / 100)) * 100]')
          ParentFont = False
        end
        object rllUnilIQ: TfrxMemoView
          Left = 456.889763780000000000
          Top = 18.456710000000040000
          Width = 60.472440940000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNILIQ"]')
          ParentFont = False
        end
        object mmoLocFisDes: TfrxMemoView
          Left = 540.354670000000000000
          Top = 1.559059999999931000
          Width = 114.519714330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoLocSupDes: TfrxMemoView
          Left = 666.165740000000000000
          Top = 1.559060000000045000
          Width = 99.401594330000000000
          Height = 13.228346460000000000
          DataField = 'LOCSUP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCSUP"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoCodBarras: TfrxMemoView
          Left = 403.630180000000000000
          Top = 1.779530000000022000
          Width = 129.637834330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODBAR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoDtaEnt: TfrxMemoView
          Left = 6.425196850000000000
          Top = 18.519685040000010000
          Width = 69.165354330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."PCD_DTAENT"]')
          ParentFont = False
        end
        object rllValSub: TfrxMemoView
          Left = 717.976377950000000000
          Top = 18.519685040000010000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."TOTSUB"> > 0, <frxRelatorio."TOTSUB">, <frxR' +
              'elatorio."TOTDAR">)]')
          ParentFont = False
        end
        object rllAlqSub: TfrxMemoView
          Left = 676.756340000000000000
          Top = 18.897650000000110000
          Width = 39.685034490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PCD_PERSUB"]')
          ParentFont = False
        end
        object mmoReferenciaDados: TfrxMemoView
          Left = 295.102350000000000000
          Top = 0.763450000000034400
          Width = 95.622064330000000000
          Height = 13.228346460000000000
          DataField = 'ITE_REFERE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoAstDare: TfrxMemoView
          Left = 766.346940000000000000
          Top = 18.897650000000000000
          Width = 5.669288900000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."TOTDAR"> > 0, '#39'*'#39','#39#39')]')
          ParentFont = False
        end
      end
      object TopoMateriais: TfrxHeader
        FillType = ftBrush
        Height = 60.472480000000000000
        Top = 445.984540000000000000
        Width = 774.803650000000000000
        ReprintOnNewPage = True
        object sDados: TfrxShapeView
          Left = 3.401574800000000000
          Top = 38.795300000000000000
          Width = 763.464552280000000000
          Height = 18.897637800000000000
        end
        object sDuplicata: TfrxShapeView
          Left = 3.401574800000000000
          Top = 21.000000000000000000
          Width = 763.464552280000000000
          Height = 17.763779530000000000
        end
        object mmDuplicata: TfrxMemoView
          Left = 6.338590000000000000
          Top = 22.677165350000000000
          Width = 41.574800710000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 53.370130000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object sTitulo: TfrxShapeView
          Left = 3.401574800000000000
          Top = 2.000000000000000000
          Width = 763.464552280000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object Memo22: TfrxMemoView
          Left = 7.000000000000000000
          Top = 3.000000000000000000
          Width = 752.125969610000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'MATERIAIS SOLICITADOS')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 56.692950000000000000
          Top = 22.677180000000020000
          Width = 71.811040710000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object mmoUnid: TfrxMemoView
          Left = 265.819110000000000000
          Top = 41.913405350000010000
          Width = 22.677165350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Un.')
          ParentFont = False
        end
        object mmoMarca: TfrxMemoView
          Left = 77.960730000000000000
          Top = 41.913405350000010000
          Width = 69.165354330000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
        end
        object mmoCodFab: TfrxMemoView
          Left = 152.551330000000000000
          Top = 41.913405350000010000
          Width = 109.606335830000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Codigo de F'#225'brica')
          ParentFont = False
        end
        object rllTitQtdIte: TfrxMemoView
          Left = 292.527830000000000000
          Top = 41.913405350000010000
          Width = 45.354333150000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quant.')
          ParentFont = False
        end
        object mmoPreUni: TfrxMemoView
          Left = 342.236550000000000000
          Top = 41.913405350000010000
          Width = 60.472480000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Unit.')
          ParentFont = False
        end
        object mmoPreTot: TfrxMemoView
          Left = 520.268090000000000000
          Top = 41.913405350000010000
          Width = 68.031540000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Total')
          ParentFont = False
        end
        object mmoPerIpi: TfrxMemoView
          Left = 591.976810000000000000
          Top = 41.913405350000010000
          Width = 32.125984250000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% IPI')
          ParentFont = False
        end
        object mmoPreIpi: TfrxMemoView
          Left = 627.787880000000000000
          Top = 41.913405350000010000
          Width = 47.244094490000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. IPI')
          ParentFont = False
        end
        object linUnid: TfrxLineView
          Left = 264.700990000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linMarca: TfrxLineView
          Left = 76.063080000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linCodFab: TfrxLineView
          Left = 149.653680000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linQtdIte: TfrxLineView
          Left = 291.071120000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object LinPreUni: TfrxLineView
          Left = 339.976402360000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPreTot: TfrxLineView
          Left = 519.149970000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPerIpi: TfrxLineView
          Left = 589.858690000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPreIpi: TfrxLineView
          Left = 626.094512600000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPerDesc: TfrxLineView
          Left = 404.622450000000000000
          Top = 38.913419999999970000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoPerDesc: TfrxMemoView
          Left = 406.520100000000000000
          Top = 41.913419999999970000
          Width = 45.354345350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%DESC')
          ParentFont = False
        end
        object mmoVlrLiq: TfrxMemoView
          Left = 455.866827640000000000
          Top = 42.031525349999980000
          Width = 60.472480000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Unit.L'#237'q.')
          ParentFont = False
        end
        object linVlrLiq: TfrxLineView
          Left = 454.606680000000000000
          Top = 38.913419999999970000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoLocFis: TfrxMemoView
          Left = 540.354670000000000000
          Top = 22.677180000000020000
          Width = 114.519714330000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Loc. Fis.')
          ParentFont = False
        end
        object linLocFis: TfrxLineView
          Left = 535.606680000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoLocSup: TfrxMemoView
          Left = 666.165740000000000000
          Top = 22.677180000000020000
          Width = 99.401594330000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Loc. Super Est.')
          ParentFont = False
        end
        object linLocSup: TfrxLineView
          Left = 661.417750000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoCodBar: TfrxMemoView
          Left = 401.189240000000000000
          Top = 22.456709999999990000
          Width = 125.858304330000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo De Barras')
          ParentFont = False
        end
        object linCodBar: TfrxLineView
          Left = 396.850650000000000000
          Top = 20.677180000000020000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoTitDtaEnt: TfrxMemoView
          Left = 4.559060000000000000
          Top = 41.952755910000010000
          Width = 69.165354330000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data Entrega')
          ParentFont = False
        end
        object mmoValSub: TfrxMemoView
          Left = 718.024537400000000000
          Top = 41.913405350000010000
          Width = 47.244094490000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. Sub.')
          ParentFont = False
        end
        object linValSub: TfrxLineView
          Left = 716.331170000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoPerSub: TfrxMemoView
          Left = 678.756340000000000000
          Top = 41.574830000000020000
          Width = 35.905514250000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% Sub')
          ParentFont = False
        end
        object linPerSub: TfrxLineView
          Left = 676.756340000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linReferencia: TfrxLineView
          Left = 291.000000000000000000
          Top = 20.913110000000020000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoReferencia: TfrxMemoView
          Left = 295.102350000000000000
          Top = 22.913110000000020000
          Width = 95.622064330000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Referencia')
          ParentFont = False
        end
      end
      object Transportadora: TfrxChild
        FillType = ftBrush
        Height = 102.047251420000000000
        Top = 952.441560000000000000
        Width = 774.803650000000000000
        Child = frxPagina.Comprador
        PrintChildIfInvisible = True
        object Memo31: TfrxMemoView
          Left = 4.535433070000000000
          Top = 2.220469999999978000
          Width = 370.393439610000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TRANSPORTADORA:')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 4.559060000000000000
          Top = 17.456709999999930000
          Width = 370.393940000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_NOMTRA"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 59.559060000000000000
          Top = 32.574830000000130000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_ENDERE"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 59.220470000000000000
          Top = 47.913419999999970000
          Width = 173.858380000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_BAIRRO"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 59.559060000000000000
          Top = 63.047310000000040000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_NOMCID"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 284.771800000000000000
          Top = 48.149660000000150000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxTransp."TRA_C_E_P_">) > 0 ,'
            ' FormatMaskText('#39'00000-000;0'#39',<frxTransp."TRA_C_E_P_">),'#39#39')]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 237.637910000000000000
          Top = 47.149660000000150000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.E.P.:')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 59.559060000000000000
          Top = 78.811069999999740000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_FONE01"]')
          ParentFont = False
        end
        object Line12: TfrxLineView
          Left = 1.889763780000000000
          Top = 96.267779999999680000
          Width = 771.023622050000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo39: TfrxMemoView
          Left = 4.559060000000000000
          Top = 32.574830000000130000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 4.559060000000000000
          Top = 63.047310000000040000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 4.535433070000000000
          Top = 47.913419999999970000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 4.559060000000000000
          Top = 78.811069999999740000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone/Fax:')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 205.000000000000000000
          Top = 78.811069999999740000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_F_A_X_"]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 400.409710000000000000
          Top = 2.267716540000038000
          Width = 366.613909610000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TRANSPORTADOR REDESPACHO:')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 400.653806930000000000
          Top = 17.118120000000090000
          Width = 370.393940000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_NOMTRA"]')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Left = 455.653806930000000000
          Top = 32.236239999999840000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_ENDERE"]')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 455.315216930000000000
          Top = 47.574830000000130000
          Width = 173.858380000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_BAIRRO"]')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 455.653806930000000000
          Top = 62.708720000000200000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_NOMCID"]')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 680.866546930000000000
          Top = 47.811069999999860000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxTranspRedes."TRA_C_E_P_">) > 0 ,'
            
              ' FormatMaskText('#39'00000-000;0'#39',<frxTranspRedes."TRA_C_E_P_">),'#39#39')' +
              ']')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 633.732656930000000000
          Top = 46.811069999999860000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.E.P.:')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 455.653806930000000000
          Top = 78.472479999999910000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_FONE01"]')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 400.653806930000000000
          Top = 32.236239999999840000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 400.653806930000000000
          Top = 62.708720000000200000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 400.630180000000000000
          Top = 47.574830000000130000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Left = 400.653806930000000000
          Top = 78.472479999999910000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone/Fax:')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Left = 601.094746930000000000
          Top = 78.472479999999910000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_F_A_X_"]')
          ParentFont = False
        end
      end
      object LocalEntrega: TfrxChild
        FillType = ftBrush
        Height = 64.251961180000000000
        Top = 865.512370000000000000
        Width = 774.803650000000000000
        Child = frxPagina.Transportadora
        PrintChildIfInvisible = True
        object Memo51: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779530000000022000
          Width = 755.905499610000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOCAL DE ENTREGA:')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 3.803156930000000000
          Top = 17.015769999999970000
          Width = 521.575140000000000000
          Height = 15.118110240000000000
          DataField = 'PCG_NOMENT'
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_NOMENT"]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 71.803156930000000000
          Top = 32.133889999999840000
          Width = 408.189240000000000000
          Height = 15.118110240000000000
          DataField = 'PCG_ENDENT'
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_ENDENT"]')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 71.803156930000000000
          Top = 47.488249999999880000
          Width = 408.189240000000000000
          Height = 15.118110240000000000
          DataField = 'PCG_CIDENT'
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_CIDENT"]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 3.803156930000000000
          Top = 32.133889999999840000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          Left = 3.803156930000000000
          Top = 47.488249999999880000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
      end
      object ChildData: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 1122.520410000000000000
        Width = 774.803650000000000000
        object rllData: TfrxMemoView
          Left = 9.117612280000000000
          Width = 740.787880000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
        end
      end
      object ChildAplicacao: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 585.827150000000000000
        Width = 774.803650000000000000
        Stretched = True
        object Memo8: TfrxMemoView
          ShiftMode = smDontShift
          Left = 132.283550000000000000
          Width = 632.315263310000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataField = 'ITE_APLFAB'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_APLFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 3.779530000000000000
          Width = 124.724490000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aplica'#231#227'o / C'#243'd. F'#225'brica:')
          ParentFont = False
        end
      end
      object Totais: TfrxReportSummary
        FillType = ftBrush
        Height = 83.149650240000000000
        Top = 661.417750000000000000
        Width = 774.803650000000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        Child = frxPagina.chiIcmDes
        PrintChildIfInvisible = True
        object Line1: TfrxLineView
          Width = 771.023622050000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo25: TfrxMemoView
          Left = 495.496062992126000000
          Top = 4.338589999999954000
          Width = 109.606299210000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Soma dos Itens:')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 234.369902990000000000
          Top = 4.228336689999992000
          Width = 109.606299210000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Soma do I.P.I.:')
          ParentFont = False
        end
        object rllTotalItens: TfrxMemoView
          Left = 608.709108110000000000
          Top = 4.338589999999954000
          Width = 154.960622600000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,Detalhes,2)]')
          ParentFont = False
        end
        object rllTotalIPI: TfrxMemoView
          Left = 347.582948110000000000
          Top = 4.118119999999976000
          Width = 113.385792600000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTIPI">,Detalhes,2)]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 1.559055120000000000
          Top = 41.307054880000010000
          Width = 113.385848740000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Litros:')
          ParentFont = False
        end
        object rllLitragem: TfrxMemoView
          Left = 120.991864800000000000
          Top = 41.307054880000010000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTLIT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo48: TfrxMemoView
          Left = 495.496062992126000000
          Top = 20.700816690000010000
          Width = 109.606299210000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor do Frete:')
          ParentFont = False
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 608.709108110000000000
          Top = 20.700816690000010000
          Width = 154.960629920000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'Memo49OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_VALFRE">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Left = 234.369902990000000000
          Top = 20.236239999999950000
          Width = 109.606299210000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor da Subst:')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalsUB: TfrxMemoView
          Left = 347.582948110000000000
          Top = 20.236239999999950000
          Width = 113.385799920000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'Memo49OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTSUB">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 1.559060000000000000
          Top = 24.543275350000040000
          Width = 113.385848740000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Peso Total:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 120.991864800000000000
          Top = 24.543275350000040000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PESOIT">,Detalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 495.496062992126000000
          Top = 37.708719999999970000
          Width = 109.606299210000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Desp. Acess'#243'rias:')
          ParentFont = False
          WordWrap = False
        end
        object Memo60: TfrxMemoView
          Left = 608.709108110000000000
          Top = 37.708719999999970000
          Width = 154.960629920000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'Memo49OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_DESACE">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 1.559060000000000000
          Top = 7.236239999999953000
          Width = 113.385848740000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tot. Itens Impressos:')
          ParentFont = False
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 120.991864800000000000
          Top = 7.236239999999953000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(Detalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 1.559060000000000000
          Top = 58.252010000000040000
          Width = 113.385848740000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Kilos:')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 120.991869680000000000
          Top = 58.252010000000040000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTKIL"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 234.110390000000000000
          Top = 36.354360000000040000
          Width = 109.606318740000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Subst FCP:')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalSubFCP: TfrxMemoView
          Left = 348.055413460000000000
          Top = 36.354360000000040000
          Width = 113.385799920000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SUBFCP">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoTitDar: TfrxMemoView
          Left = 234.330860000000000000
          Top = 52.692949999999990000
          Width = 109.606318740000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor DARE:')
          ParentFont = False
          WordWrap = False
        end
        object mmoValDar: TfrxMemoView
          Left = 348.275883460000000000
          Top = 52.692949999999990000
          Width = 113.385799920000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTDAR">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoMsgDare: TfrxMemoView
          Left = 347.716760000000000000
          Top = 68.031539999999950000
          Width = 173.858279920000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."TOTDAR">,Detalhes,2) > 0, '#39'(*) Valores d' +
              'a DARE por produto'#39', '#39#39')]')
          ParentFont = False
          WordWrap = False
        end
      end
      object chiTotalPedido: TfrxChild
        FillType = ftBrush
        Height = 20.440940000000000000
        Top = 823.937540000000000000
        Width = 774.803650000000000000
        Child = frxPagina.LocalEntrega
        PrintChildIfInvisible = True
        object Line2: TfrxLineView
          Left = -1.889766220000000000
          Top = 16.661410000000040000
          Width = 771.023622050000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo27: TfrxMemoView
          Left = 495.496062992126000000
          Width = 109.606299212598000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total do Pedido:')
          ParentFont = False
        end
        object rllTotalGeral: TfrxMemoView
          Left = 608.709108110000000000
          Width = 154.960622600000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE"> +<frxRelatorio."TOTIPI"> + <frxRela' +
              'torio."TOTSUB"> + <frxRelatorio."SUBFCP"> - <frxRelatorio."ICMDE' +
              'S"> ,Detalhes,2) + <frxPedido."PCG_VALFRE">]')
          ParentFont = False
        end
      end
      object chiIcmDes: TfrxChild
        FillType = ftBrush
        Height = 32.125984250000000000
        Top = 767.244590000000000000
        Width = 774.803650000000000000
        Child = frxPagina.chiTotalPedido
        PrintChildIfInvisible = True
        object mmoTitIcmDes: TfrxMemoView
          Left = 495.496062990000000000
          Top = 16.000000000000000000
          Width = 109.606318740000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ICMS Desonerado:')
          ParentFont = False
          WordWrap = False
        end
        object mmoIcmDes: TfrxMemoView
          Left = 609.402043460000000000
          Top = 16.000000000000000000
          Width = 154.960629920000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'Memo49OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ICMDES">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoTitDesPis: TfrxMemoView
          Left = 495.677490000000000000
          Width = 109.606308980000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Desc. PIS/COFINS:')
          ParentFont = False
          WordWrap = False
        end
        object mmoDesPis: TfrxMemoView
          Left = 608.953090310000000000
          Width = 154.960629920000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'Memo49OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESPIS">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Comprador: TfrxChild
        FillType = ftBrush
        Height = 23.566943780000000000
        Top = 1077.166050000000000000
        Width = 774.803650000000000000
        Child = frxPagina.ChildData
        PrintChildIfInvisible = True
        Stretched = True
        object mmoCompra: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779530000000022000
          Width = 755.906000000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxPedido."PCG_COMPRA"]')
          ParentFont = False
        end
      end
    end
  end
  object frxExportaPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbeddedFonts = True
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = True
    PrintScaling = True
    PdfA = False
    Left = 312
    Top = 80
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PCD_NUMPED=PCD_NUMPED'
      'PCD_CODEMP=PCD_CODEMP'
      'PCD_ESPDOC=PCD_ESPDOC'
      'AUTOINCREM=AUTOINCREM'
      'PCD_CODITE=PCD_CODITE'
      'PCD_DTAENT=PCD_DTAENT'
      'PCD_DTAPED=PCD_DTAPED'
      'PCD_CONPAG=PCD_CONPAG'
      'PCD_DESITE=PCD_DESITE'
      'PCD_QTDITE=PCD_QTDITE'
      'PCD_TOTITE=PCD_TOTITE'
      'PCD_PERIPI=PCD_PERIPI'
      'PCD_TOTIPI=PCD_TOTIPI'
      'PCD_QTDBAI=PCD_QTDBAI'
      'PCD_TOTBAI=PCD_TOTBAI'
      'PCD_IPIBAI=PCD_IPIBAI'
      'PCD_BAIXAD=PCD_BAIXAD'
      'PCD_CODFOR=PCD_CODFOR'
      'PCD_HORPED=PCD_HORPED'
      'PCD_PERSUB=PCD_PERSUB'
      'PCD_TOTSUB=PCD_TOTSUB'
      'PCD_SUBBAI=PCD_SUBBAI'
      'PCD_DOCORI=PCD_DOCORI'
      'PCD_NUMCTN=PCD_NUMCTN'
      'PCD_PEDIMP=PCD_PEDIMP'
      'PCD_JAEMIT=PCD_JAEMIT'
      'PCD_DTAEMI=PCD_DTAEMI'
      'PCD_VALEMI=PCD_VALEMI'
      'PCD_DOCEMI=PCD_DOCEMI'
      'PCD_ESPEMI=PCD_ESPEMI'
      'PCD_PEDTXT=PCD_PEDTXT'
      'ITE_CODITE=ITE_CODITE'
      'ITE_CODEMP=ITE_CODEMP'
      'ITE_CODABF=ITE_CODABF'
      'ITE_CODUNI=ITE_CODUNI'
      'ITE_CODMAR=ITE_CODMAR'
      'ITE_CODFOR=ITE_CODFOR'
      'ITE_DESITE=ITE_DESITE'
      'ITE_REFERE=ITE_REFERE'
      'ITE_CODFAB=ITE_CODFAB'
      'ITE_DTACAD=ITE_DTACAD'
      'ITE_CODBAR=ITE_CODBAR'
      'ITE_CLAIPI=ITE_CLAIPI'
      'ITE_INCPIS=ITE_INCPIS'
      'ITE_COMLUB=ITE_COMLUB'
      'ITE_PESOIT=ITE_PESOIT'
      'ITE_ITEATI=ITE_ITEATI'
      'AUTOINCREM_1=AUTOINCREM_1'
      'ITE_CODSIM=ITE_CODSIM'
      'ITE_ITEBAS=ITE_ITEBAS'
      'ITE_CNV_ML=ITE_CNV_ML'
      'ITE_EMBALA=ITE_EMBALA'
      'ITE_MSGLV1=ITE_MSGLV1'
      'ITE_MSGLV2=ITE_MSGLV2'
      'ITE_MARBAS=ITE_MARBAS'
      'ITE_CODVEL=ITE_CODVEL'
      'ITE_APLICA=ITE_APLICA'
      'ITE_TMPGAR=ITE_TMPGAR'
      'ITE_FATCNV=ITE_FATCNV'
      'ITE_CODFIN=ITE_CODFIN'
      'ITE_CODAGR=ITE_CODAGR'
      'ITE_DESFLZ=ITE_DESFLZ'
      'ITE_RECFLZ=ITE_RECFLZ'
      'ITE_CODFLZ=ITE_CODFLZ'
      'ITE_TECFLZ=ITE_TECFLZ'
      'ITE_VALFLZ=ITE_VALFLZ'
      'ITE_TIPFLZ=ITE_TIPFLZ'
      'ITE_PORFLZ=ITE_PORFLZ'
      'ITE_VALCAL=ITE_VALCAL'
      'ITE_PERCAL=ITE_PERCAL'
      'ITE_VCARBO=ITE_VCARBO'
      'ITE_PCARBO=ITE_PCARBO'
      'ITE_VPROTE=ITE_VPROTE'
      'ITE_PPROTE=ITE_PPROTE'
      'ITE_VGORTO=ITE_VGORTO'
      'ITE_PGORTO=ITE_PGORTO'
      'ITE_VGORSA=ITE_VGORSA'
      'ITE_PGORSA=ITE_PGORSA'
      'ITE_VCOLES=ITE_VCOLES'
      'ITE_PCOLES=ITE_PCOLES'
      'ITE_PFIBAL=ITE_PFIBAL'
      'ITE_VCALCI=ITE_VCALCI'
      'ITE_PCALCI=ITE_PCALCI'
      'ITE_VFERRO=ITE_VFERRO'
      'ITE_PFERRO=ITE_PFERRO'
      'ITE_VSODIO=ITE_VSODIO'
      'ITE_PSODIO=ITE_PSODIO'
      'ITE_ITEPIG=ITE_ITEPIG'
      'ITE_SETFLZ=ITE_SETFLZ'
      'MAR_DESMAR=MAR_DESMAR'
      'LITROS=LITROS'
      'UNI_SIGUNI=UNI_SIGUNI'
      'PESOIT=PESOIT'
      'PCD_ENTREG=PCD_ENTREG'
      'PCD_CODACA=PCD_CODACA'
      'PCD_EMPACA=PCD_EMPACA'
      'PCD_PROACA=PCD_PROACA'
      'ITE_DESFAB=ITE_DESFAB'
      'ITE_OBRCPF=ITE_OBRCPF'
      'ITE_CPRCEN=ITE_CPRCEN'
      'ITE_INFLAM=ITE_INFLAM'
      'ITE_DTAALT=ITE_DTAALT'
      'ITE_NVLGIR=ITE_NVLGIR'
      'ITE_CADPAI=ITE_CADPAI'
      'ITE_MLTCOM=ITE_MLTCOM'
      'ITE_MLTVEN=ITE_MLTVEN'
      'ITE_VFIBAL=ITE_VFIBAL'
      'QTDITE=QTDITE'
      'TOTITE=TOTITE'
      'TOTIPI=TOTIPI'
      'TOTSUB=TOTSUB'
      'PCD_DESUNI=PCD_DESUNI'
      'UNITAR=UNITAR'
      'PCD_DESUN2=PCD_DESUN2'
      'SIGEMB=SIGEMB'
      'LOCFIS=LOCFIS'
      'TOTKIL=TOTKIL'
      'TOTLIT=TOTLIT'
      'LOCSUP=LOCSUP'
      'ITE_APLFAB=ITE_APLFAB'
      'PCD_DESUN3=PCD_DESUN3'
      'PCD_DESUN4=PCD_DESUN4'
      'PCD_DESUN5=PCD_DESUN5'
      'PCD_DESUN6=PCD_DESUN6'
      'ICMDES=ICMDES'
      'DESPIS=DESPIS'
      'SUBFCP=SUBFCP'
      'PCD_SUBFCP=PCD_SUBFCP'
      'TOTDAR=TOTDAR'
      'PCD_TOTDAR=PCD_TOTDAR'
      'PCD_ALQCBS=PCD_ALQCBS'
      'PCD_ALQIBS=PCD_ALQIBS'
      'PCD_ALQ_IS=PCD_ALQ_IS'
      'PCD_VALCBS=PCD_VALCBS'
      'PCD_VALIBS=PCD_VALIBS'
      'PCD_VAL_IS=PCD_VAL_IS'
      'VALCBS=VALCBS'
      'VALIBS=VALIBS'
      'VAL_IS=VAL_IS'
      'BASCBS=BASCBS'
      'BASIBS=BASIBS'
      'BAS_IS=BAS_IS'
      'UNILIQ=UNILIQ')
    DataSet = qryRelatorio
    BCDToCurrency = False
    Left = 96
    Top = 16
  end
  object frxPedido: TfrxDBDataset
    UserName = 'frxPedido'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PCG_NUMPED=PCG_NUMPED'
      'PCG_CODEMP=PCG_CODEMP'
      'PCG_ESPDOC=PCG_ESPDOC'
      'PCG_CODFOR=PCG_CODFOR'
      'PCG_CODTRA=PCG_CODTRA'
      'PCG_CONPAG=PCG_CONPAG'
      'PCG_DTAENT=PCG_DTAENT'
      'PCG_HORENT=PCG_HORENT'
      'PCG_DTAPED=PCG_DTAPED'
      'PCG_COMPRA=PCG_COMPRA'
      'PCG_TOTIPI=PCG_TOTIPI'
      'PCG_TOTITE=PCG_TOTITE'
      'PCG_TOTGER=PCG_TOTGER'
      'PCG_OBS001=PCG_OBS001'
      'PCG_OBS002=PCG_OBS002'
      'PCG_OBS003=PCG_OBS003'
      'PCG_OBS004=PCG_OBS004'
      'PCG_OBS005=PCG_OBS005'
      'PCG_ATENCA=PCG_ATENCA'
      'AUTOINCREM=AUTOINCREM'
      'PCG_BAIXAD=PCG_BAIXAD'
      'PCG_TOTSUB=PCG_TOTSUB'
      'PCG_OBSPD1=PCG_OBSPD1'
      'PCG_OBSPD2=PCG_OBSPD2'
      'PCG_OBSPD3=PCG_OBSPD3'
      'PCG_TIPFRE=PCG_TIPFRE'
      'PCG_PEDVEN=PCG_PEDVEN'
      'PCG_DOCORI=PCG_DOCORI'
      'PCG_NUMCTN=PCG_NUMCTN'
      'PCG_PEDIMP=PCG_PEDIMP'
      'PCG_JAEMIT=PCG_JAEMIT'
      'PCG_DTAEMI=PCG_DTAEMI'
      'PCG_VALEMI=PCG_VALEMI'
      'PCG_DOCEMI=PCG_DOCEMI'
      'PCG_ESPEMI=PCG_ESPEMI'
      'FOR_CODFOR=FOR_CODFOR'
      'FOR_CODATI=FOR_CODATI'
      'FOR_CODCID=FOR_CODCID'
      'FOR_NOMFOR=FOR_NOMFOR'
      'FOR_DTACAD=FOR_DTACAD'
      'FOR_NOMFAN=FOR_NOMFAN'
      'FOR_ENDERE=FOR_ENDERE'
      'FOR_BAIRRO=FOR_BAIRRO'
      'FOR_C_E_P_=FOR_C_E_P_'
      'FOR_CGCCPF=FOR_CGCCPF'
      'FOR_C_G_C_=FOR_C_G_C_'
      'FOR_I_E_S_=FOR_I_E_S_'
      'FOR_CONTAT=FOR_CONTAT'
      'FOR_CAIPOS=FOR_CAIPOS'
      'FOR_FONE01=FOR_FONE01'
      'FOR_FONE02=FOR_FONE02'
      'FOR_F_A_X_=FOR_F_A_X_'
      'FOR_EMAIL_=FOR_EMAIL_'
      'FOR_HOMEPA=FOR_HOMEPA'
      'FOR_CNDPAG=FOR_CNDPAG'
      'FOR_CODEMP=FOR_CODEMP'
      'AUTOINCREM_1=AUTOINCREM_1'
      'FOR_QTDETI=FOR_QTDETI'
      'FOR_PERCOM=FOR_PERCOM'
      'FOR_NUMRG_=FOR_NUMRG_'
      'FOR_MATREV=FOR_MATREV'
      'FOR_OBSERV=FOR_OBSERV'
      'FOR_NOMCID=FOR_NOMCID'
      'PCG_VALFRE=PCG_VALFRE'
      'PCG_DESACE=PCG_DESACE'
      'PCG_DTAFAT=PCG_DTAFAT'
      'PCG_NOMENT=PCG_NOMENT'
      'PCG_ENDENT=PCG_ENDENT'
      'PCG_CIDENT=PCG_CIDENT'
      'COMPRA=COMPRA'
      'OPE_E_MAIL=OPE_E_MAIL'
      'OPE_NEXTEL=OPE_NEXTEL'
      'OPE_RAMAL1=OPE_RAMAL1'
      'OPE_FONE01=OPE_FONE01'
      'PCG_BASCOF=PCG_BASCOF'
      'PCG_VALCOF=PCG_VALCOF'
      'PCG_BASPIS=PCG_BASPIS'
      'PCG_VALPIS=PCG_VALPIS'
      'PCG_BASICM=PCG_BASICM'
      'PCG_VALICM=PCG_VALICM'
      'PCG_BASIPI=PCG_BASIPI'
      'PCG_BASSUB=PCG_BASSUB'
      'PCG_PAGVIS=PCG_PAGVIS'
      'ENDERE=ENDERE'
      'PCG_ORCORI=PCG_ORCORI'
      'PCG_SUBFCP=PCG_SUBFCP'
      'PCG_CODTRR=PCG_CODTRR'
      'PCG_PEDBON=PCG_PEDBON'
      'PCG_TOTDAR=PCG_TOTDAR'
      'PCG_CODCMP=PCG_CODCMP')
    DataSet = qryPedido
    BCDToCurrency = False
    Left = 240
    Top = 16
  end
  object qryRelatorio: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Left = 24
    Top = 16
    object qryRelatorioPCD_NUMPED: TStringField
      FieldName = 'PCD_NUMPED'
      Required = True
      Size = 12
    end
    object qryRelatorioPCD_CODEMP: TStringField
      FieldName = 'PCD_CODEMP'
      Required = True
      Size = 3
    end
    object qryRelatorioPCD_ESPDOC: TStringField
      FieldName = 'PCD_ESPDOC'
      Required = True
      Size = 2
    end
    object qryRelatorioAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Required = True
    end
    object qryRelatorioPCD_CODITE: TStringField
      FieldName = 'PCD_CODITE'
      Required = True
      Size = 5
    end
    object qryRelatorioPCD_DTAENT: TDateField
      FieldName = 'PCD_DTAENT'
      Required = True
    end
    object qryRelatorioPCD_DTAPED: TDateField
      FieldName = 'PCD_DTAPED'
      Required = True
    end
    object qryRelatorioPCD_CONPAG: TStringField
      FieldName = 'PCD_CONPAG'
      Size = 38
    end
    object qryRelatorioPCD_DESITE: TStringField
      FieldName = 'PCD_DESITE'
      Size = 70
    end
    object qryRelatorioPCD_QTDITE: TFloatField
      FieldName = 'PCD_QTDITE'
    end
    object qryRelatorioPCD_TOTITE: TFloatField
      FieldName = 'PCD_TOTITE'
    end
    object qryRelatorioPCD_PERIPI: TFloatField
      FieldName = 'PCD_PERIPI'
    end
    object qryRelatorioPCD_TOTIPI: TFloatField
      FieldName = 'PCD_TOTIPI'
    end
    object qryRelatorioPCD_ALQCBS: TFloatField
      FieldName = 'PCD_ALQCBS'
    end
    object qryRelatorioPCD_ALQIBS: TFloatField
      FieldName = 'PCD_ALQIBS'
    end
    object qryRelatorioPCD_ALQ_IS: TFloatField
      FieldName = 'PCD_ALQ_IS'
    end
    object qryRelatorioPCD_VALCBS: TFloatField
      FieldName = 'PCD_VALCBS'
    end
    object qryRelatorioPCD_VALIBS: TFloatField
      FieldName = 'PCD_VALIBS'
    end
    object qryRelatorioPCD_VAL_IS: TFloatField
      FieldName = 'PCD_VAL_IS'
    end
    object qryRelatorioVALCBS: TFloatField
      FieldName = 'VALCBS'
    end
    object qryRelatorioVALIBS: TFloatField
      FieldName = 'VALIBS'
    end
    object qryRelatorioVAL_IS: TFloatField
      FieldName = 'VAL_IS'
    end
    object qryRelatorioBASCBS: TFloatField
      FieldName = 'BASCBS'
    end
    object qryRelatorioBASIBS: TFloatField
      FieldName = 'BASIBS'
    end
    object qryRelatorioBAS_IS: TFloatField
      FieldName = 'BAS_IS'
    end
    object qryRelatorioPCD_QTDBAI: TFloatField
      FieldName = 'PCD_QTDBAI'
    end
    object qryRelatorioPCD_TOTBAI: TFloatField
      FieldName = 'PCD_TOTBAI'
    end
    object qryRelatorioPCD_IPIBAI: TFloatField
      FieldName = 'PCD_IPIBAI'
    end
    object qryRelatorioPCD_BAIXAD: TSmallintField
      FieldName = 'PCD_BAIXAD'
    end
    object qryRelatorioPCD_CODFOR: TStringField
      FieldName = 'PCD_CODFOR'
      Size = 8
    end
    object qryRelatorioPCD_HORPED: TTimeField
      FieldName = 'PCD_HORPED'
    end
    object qryRelatorioPCD_PERSUB: TFloatField
      FieldName = 'PCD_PERSUB'
    end
    object qryRelatorioPCD_TOTSUB: TFloatField
      FieldName = 'PCD_TOTSUB'
    end
    object qryRelatorioPCD_SUBBAI: TFloatField
      FieldName = 'PCD_SUBBAI'
    end
    object qryRelatorioPCD_DOCORI: TStringField
      FieldName = 'PCD_DOCORI'
    end
    object qryRelatorioPCD_NUMCTN: TIntegerField
      FieldName = 'PCD_NUMCTN'
      Required = True
    end
    object qryRelatorioPCD_PEDIMP: TStringField
      FieldName = 'PCD_PEDIMP'
      Size = 1
    end
    object qryRelatorioPCD_JAEMIT: TSmallintField
      FieldName = 'PCD_JAEMIT'
    end
    object qryRelatorioPCD_DTAEMI: TDateField
      FieldName = 'PCD_DTAEMI'
    end
    object qryRelatorioPCD_VALEMI: TFloatField
      FieldName = 'PCD_VALEMI'
    end
    object qryRelatorioPCD_DOCEMI: TStringField
      FieldName = 'PCD_DOCEMI'
      Size = 12
    end
    object qryRelatorioPCD_ESPEMI: TStringField
      FieldName = 'PCD_ESPEMI'
      Size = 2
    end
    object qryRelatorioPCD_PEDTXT: TStringField
      FieldName = 'PCD_PEDTXT'
      Size = 3
    end
    object qryRelatorioITE_CODITE: TStringField
      FieldName = 'ITE_CODITE'
      Required = True
      Size = 5
    end
    object qryRelatorioITE_CODEMP: TStringField
      FieldName = 'ITE_CODEMP'
      Required = True
      Size = 3
    end
    object qryRelatorioITE_CODABF: TStringField
      FieldName = 'ITE_CODABF'
      Required = True
      Size = 7
    end
    object qryRelatorioITE_CODUNI: TStringField
      FieldName = 'ITE_CODUNI'
      Required = True
      Size = 2
    end
    object qryRelatorioITE_CODMAR: TStringField
      FieldName = 'ITE_CODMAR'
      Size = 6
    end
    object qryRelatorioITE_CODFOR: TStringField
      FieldName = 'ITE_CODFOR'
      Size = 8
    end
    object qryRelatorioITE_DESITE: TStringField
      FieldName = 'ITE_DESITE'
      Required = True
      Size = 70
    end
    object qryRelatorioITE_REFERE: TStringField
      FieldName = 'ITE_REFERE'
      Size = 16
    end
    object qryRelatorioITE_CODFAB: TStringField
      FieldName = 'ITE_CODFAB'
      Size = 50
    end
    object qryRelatorioITE_DTACAD: TDateField
      FieldName = 'ITE_DTACAD'
    end
    object qryRelatorioITE_CODBAR: TStringField
      FieldName = 'ITE_CODBAR'
      Size = 15
    end
    object qryRelatorioITE_CLAIPI: TStringField
      FieldName = 'ITE_CLAIPI'
      Size = 10
    end
    object qryRelatorioITE_INCPIS: TStringField
      FieldName = 'ITE_INCPIS'
      Size = 1
    end
    object qryRelatorioITE_COMLUB: TStringField
      FieldName = 'ITE_COMLUB'
      Size = 1
    end
    object qryRelatorioITE_PESOIT: TFloatField
      FieldName = 'ITE_PESOIT'
    end
    object qryRelatorioITE_ITEATI: TStringField
      FieldName = 'ITE_ITEATI'
      Size = 1
    end
    object qryRelatorioAUTOINCREM_1: TStringField
      FieldName = 'AUTOINCREM_1'
    end
    object qryRelatorioITE_CODSIM: TStringField
      FieldName = 'ITE_CODSIM'
      Size = 6
    end
    object qryRelatorioITE_ITEBAS: TStringField
      FieldName = 'ITE_ITEBAS'
      Size = 1
    end
    object qryRelatorioITE_CNV_ML: TFloatField
      FieldName = 'ITE_CNV_ML'
    end
    object qryRelatorioITE_EMBALA: TFloatField
      FieldName = 'ITE_EMBALA'
    end
    object qryRelatorioITE_MSGLV1: TStringField
      FieldName = 'ITE_MSGLV1'
      Size = 50
    end
    object qryRelatorioITE_MSGLV2: TStringField
      FieldName = 'ITE_MSGLV2'
      Size = 50
    end
    object qryRelatorioITE_MARBAS: TStringField
      FieldName = 'ITE_MARBAS'
      Size = 30
    end
    object qryRelatorioITE_CODVEL: TStringField
      FieldName = 'ITE_CODVEL'
    end
    object qryRelatorioITE_APLICA: TMemoField
      FieldName = 'ITE_APLICA'
      BlobType = ftMemo
    end
    object qryRelatorioITE_TMPGAR: TSmallintField
      FieldName = 'ITE_TMPGAR'
    end
    object qryRelatorioITE_FATCNV: TFloatField
      FieldName = 'ITE_FATCNV'
      Required = True
    end
    object qryRelatorioITE_CODFIN: TStringField
      FieldName = 'ITE_CODFIN'
      Size = 10
    end
    object qryRelatorioITE_CODAGR: TStringField
      FieldName = 'ITE_CODAGR'
      Size = 6
    end
    object qryRelatorioITE_DESFLZ: TStringField
      FieldName = 'ITE_DESFLZ'
      Size = 22
    end
    object qryRelatorioITE_RECFLZ: TIntegerField
      FieldName = 'ITE_RECFLZ'
    end
    object qryRelatorioITE_CODFLZ: TStringField
      FieldName = 'ITE_CODFLZ'
      Size = 4
    end
    object qryRelatorioITE_TECFLZ: TIntegerField
      FieldName = 'ITE_TECFLZ'
    end
    object qryRelatorioITE_VALFLZ: TIntegerField
      FieldName = 'ITE_VALFLZ'
    end
    object qryRelatorioITE_TIPFLZ: TStringField
      FieldName = 'ITE_TIPFLZ'
      Size = 1
    end
    object qryRelatorioITE_PORFLZ: TStringField
      FieldName = 'ITE_PORFLZ'
      Size = 35
    end
    object qryRelatorioITE_VALCAL: TIntegerField
      FieldName = 'ITE_VALCAL'
    end
    object qryRelatorioITE_PERCAL: TIntegerField
      FieldName = 'ITE_PERCAL'
    end
    object qryRelatorioITE_VCARBO: TIntegerField
      FieldName = 'ITE_VCARBO'
    end
    object qryRelatorioITE_PCARBO: TIntegerField
      FieldName = 'ITE_PCARBO'
    end
    object qryRelatorioITE_VPROTE: TIntegerField
      FieldName = 'ITE_VPROTE'
    end
    object qryRelatorioITE_PPROTE: TIntegerField
      FieldName = 'ITE_PPROTE'
    end
    object qryRelatorioITE_VGORTO: TFloatField
      FieldName = 'ITE_VGORTO'
    end
    object qryRelatorioITE_PGORTO: TIntegerField
      FieldName = 'ITE_PGORTO'
    end
    object qryRelatorioITE_VGORSA: TFloatField
      FieldName = 'ITE_VGORSA'
    end
    object qryRelatorioITE_PGORSA: TIntegerField
      FieldName = 'ITE_PGORSA'
    end
    object qryRelatorioITE_VCOLES: TIntegerField
      FieldName = 'ITE_VCOLES'
    end
    object qryRelatorioITE_PCOLES: TIntegerField
      FieldName = 'ITE_PCOLES'
    end
    object qryRelatorioITE_PFIBAL: TIntegerField
      FieldName = 'ITE_PFIBAL'
    end
    object qryRelatorioITE_VCALCI: TFloatField
      FieldName = 'ITE_VCALCI'
    end
    object qryRelatorioITE_PCALCI: TIntegerField
      FieldName = 'ITE_PCALCI'
    end
    object qryRelatorioITE_VFERRO: TFloatField
      FieldName = 'ITE_VFERRO'
    end
    object qryRelatorioITE_PFERRO: TIntegerField
      FieldName = 'ITE_PFERRO'
    end
    object qryRelatorioITE_VSODIO: TIntegerField
      FieldName = 'ITE_VSODIO'
    end
    object qryRelatorioITE_PSODIO: TIntegerField
      FieldName = 'ITE_PSODIO'
    end
    object qryRelatorioITE_ITEPIG: TStringField
      FieldName = 'ITE_ITEPIG'
      Size = 1
    end
    object qryRelatorioITE_SETFLZ: TStringField
      FieldName = 'ITE_SETFLZ'
      Size = 3
    end
    object qryRelatorioMAR_DESMAR: TStringField
      FieldName = 'MAR_DESMAR'
      Required = True
      Size = 30
    end
    object qryRelatorioLITROS: TFloatField
      FieldName = 'LITROS'
    end
    object qryRelatorioUNI_SIGUNI: TStringField
      FieldName = 'UNI_SIGUNI'
      Size = 4
    end
    object qryRelatorioPESOIT: TFloatField
      FieldName = 'PESOIT'
    end
    object qryRelatorioPCD_ENTREG: TStringField
      FieldName = 'PCD_ENTREG'
      Size = 1
    end
    object qryRelatorioPCD_CODACA: TStringField
      FieldName = 'PCD_CODACA'
      Size = 6
    end
    object qryRelatorioPCD_EMPACA: TStringField
      FieldName = 'PCD_EMPACA'
      Size = 3
    end
    object qryRelatorioPCD_PROACA: TStringField
      FieldName = 'PCD_PROACA'
      Size = 1
    end
    object qryRelatorioITE_DESFAB: TStringField
      FieldName = 'ITE_DESFAB'
      Size = 70
    end
    object qryRelatorioITE_OBRCPF: TStringField
      FieldName = 'ITE_OBRCPF'
      Size = 1
    end
    object qryRelatorioITE_CPRCEN: TStringField
      FieldName = 'ITE_CPRCEN'
      Size = 1
    end
    object qryRelatorioITE_INFLAM: TStringField
      FieldName = 'ITE_INFLAM'
      Size = 1
    end
    object qryRelatorioITE_DTAALT: TDateField
      FieldName = 'ITE_DTAALT'
    end
    object qryRelatorioITE_NVLGIR: TStringField
      FieldName = 'ITE_NVLGIR'
      Size = 1
    end
    object qryRelatorioITE_CADPAI: TStringField
      FieldName = 'ITE_CADPAI'
      Size = 1
    end
    object qryRelatorioITE_MLTCOM: TFloatField
      FieldName = 'ITE_MLTCOM'
    end
    object qryRelatorioITE_MLTVEN: TFloatField
      FieldName = 'ITE_MLTVEN'
    end
    object qryRelatorioITE_VFIBAL: TFloatField
      FieldName = 'ITE_VFIBAL'
    end
    object qryRelatorioQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object qryRelatorioTOTITE: TFloatField
      FieldName = 'TOTITE'
    end
    object qryRelatorioTOTIPI: TFloatField
      FieldName = 'TOTIPI'
    end
    object qryRelatorioTOTSUB: TFloatField
      FieldName = 'TOTSUB'
    end
    object qryRelatorioPCD_DESUNI: TFloatField
      FieldName = 'PCD_DESUNI'
    end
    object qryRelatorioUNITAR: TFloatField
      FieldName = 'UNITAR'
    end
    object qryRelatorioPCD_DESUN2: TFloatField
      FieldName = 'PCD_DESUN2'
    end
    object qryRelatorioSIGEMB: TStringField
      FieldName = 'SIGEMB'
    end
    object qryRelatorioLOCFIS: TStringField
      FieldName = 'LOCFIS'
      Size = 10
    end
    object qryRelatorioTOTKIL: TFloatField
      FieldName = 'TOTKIL'
    end
    object qryRelatorioTOTLIT: TFloatField
      FieldName = 'TOTLIT'
    end
    object qryRelatorioLOCSUP: TStringField
      FieldName = 'LOCSUP'
      Size = 10
    end
    object qryRelatorioITE_APLFAB: TStringField
      FieldName = 'ITE_APLFAB'
      Size = 3000
    end
    object qryRelatorioPCD_DESUN3: TFloatField
      FieldName = 'PCD_DESUN3'
    end
    object qryRelatorioPCD_DESUN4: TFloatField
      FieldName = 'PCD_DESUN4'
    end
    object qryRelatorioPCD_DESUN5: TFloatField
      FieldName = 'PCD_DESUN5'
    end
    object qryRelatorioPCD_DESUN6: TFloatField
      FieldName = 'PCD_DESUN6'
    end
    object qryRelatorioICMDES: TFloatField
      FieldName = 'ICMDES'
    end
    object qryRelatorioDESPIS: TFloatField
      FieldName = 'DESPIS'
    end
    object qryRelatorioSUBFCP: TFloatField
      FieldName = 'SUBFCP'
    end
    object qryRelatorioPCD_SUBFCP: TFloatField
      FieldName = 'PCD_SUBFCP'
    end
    object qryRelatorioTOTDAR: TFloatField
      FieldName = 'TOTDAR'
    end
    object qryRelatorioPCD_TOTDAR: TFloatField
      FieldName = 'PCD_TOTDAR'
    end
    object qryRelatorioUNILIQ: TFloatField
      FieldName = 'UNILIQ'
    end
  end
  object qryPedido: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Left = 176
    Top = 16
    object qryPedidoPCG_TIPFAB: TStringField
      FieldName = 'PCG_TIPFAB'
      Size = 1
    end
    object qryPedidoPCG_NUMPED: TStringField
      FieldName = 'PCG_NUMPED'
      Required = True
      Size = 12
    end
    object qryPedidoPCG_CODEMP: TStringField
      FieldName = 'PCG_CODEMP'
      Required = True
      Size = 3
    end
    object qryPedidoPCG_ESPDOC: TStringField
      FieldName = 'PCG_ESPDOC'
      Required = True
      Size = 2
    end
    object qryPedidoPCG_CODFOR: TStringField
      FieldName = 'PCG_CODFOR'
      Required = True
      Size = 8
    end
    object qryPedidoPCG_CODTRA: TStringField
      FieldName = 'PCG_CODTRA'
      Size = 5
    end
    object qryPedidoPCG_CONPAG: TStringField
      FieldName = 'PCG_CONPAG'
      Size = 38
    end
    object qryPedidoPCG_DTAENT: TDateField
      FieldName = 'PCG_DTAENT'
    end
    object qryPedidoPCG_HORENT: TTimeField
      FieldName = 'PCG_HORENT'
    end
    object qryPedidoPCG_DTAPED: TDateField
      FieldName = 'PCG_DTAPED'
    end
    object qryPedidoPCG_COMPRA: TStringField
      FieldName = 'PCG_COMPRA'
      Size = 40
    end
    object qryPedidoPCG_TOTIPI: TFloatField
      FieldName = 'PCG_TOTIPI'
    end
    object qryPedidoPCG_TOTITE: TFloatField
      FieldName = 'PCG_TOTITE'
    end
    object qryPedidoPCG_TOTGER: TFloatField
      FieldName = 'PCG_TOTGER'
    end
    object qryPedidoPCG_VALCBS: TFloatField
      FieldName = 'PCG_VALCBS'
    end
    object qryPedidoPCG_VALIBS: TFloatField
      FieldName = 'PCG_VALIBS'
    end
    object qryPedidoPCG_VAL_IS: TFloatField
      FieldName = 'PCG_VAL_IS'
    end
    object qryPedidoPCG_OBS001: TStringField
      FieldName = 'PCG_OBS001'
      Size = 250
    end
    object qryPedidoPCG_OBS002: TStringField
      FieldName = 'PCG_OBS002'
      Size = 250
    end
    object qryPedidoPCG_OBS003: TStringField
      FieldName = 'PCG_OBS003'
      Size = 250
    end
    object qryPedidoPCG_OBS004: TStringField
      FieldName = 'PCG_OBS004'
      Size = 250
    end
    object qryPedidoPCG_OBS005: TStringField
      FieldName = 'PCG_OBS005'
      Size = 250
    end
    object qryPedidoPCG_ATENCA: TStringField
      FieldName = 'PCG_ATENCA'
      Size = 40
    end
    object qryPedidoAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryPedidoPCG_BAIXAD: TSmallintField
      FieldName = 'PCG_BAIXAD'
    end
    object qryPedidoPCG_TOTSUB: TFloatField
      FieldName = 'PCG_TOTSUB'
    end
    object qryPedidoPCG_OBSPD1: TStringField
      FieldName = 'PCG_OBSPD1'
      Size = 250
    end
    object qryPedidoPCG_OBSPD2: TStringField
      FieldName = 'PCG_OBSPD2'
      Size = 250
    end
    object qryPedidoPCG_OBSPD3: TStringField
      FieldName = 'PCG_OBSPD3'
      Size = 250
    end
    object qryPedidoPCG_TIPFRE: TStringField
      FieldName = 'PCG_TIPFRE'
      Size = 1
    end
    object qryPedidoPCG_PEDVEN: TStringField
      FieldName = 'PCG_PEDVEN'
      Size = 12
    end
    object qryPedidoPCG_DOCORI: TStringField
      FieldName = 'PCG_DOCORI'
    end
    object qryPedidoPCG_NUMCTN: TIntegerField
      FieldName = 'PCG_NUMCTN'
      Required = True
    end
    object qryPedidoPCG_PEDIMP: TStringField
      FieldName = 'PCG_PEDIMP'
      Size = 1
    end
    object qryPedidoPCG_JAEMIT: TSmallintField
      FieldName = 'PCG_JAEMIT'
    end
    object qryPedidoPCG_DTAEMI: TDateField
      FieldName = 'PCG_DTAEMI'
    end
    object qryPedidoPCG_VALEMI: TFloatField
      FieldName = 'PCG_VALEMI'
    end
    object qryPedidoPCG_DOCEMI: TStringField
      FieldName = 'PCG_DOCEMI'
      Size = 12
    end
    object qryPedidoPCG_ESPEMI: TStringField
      FieldName = 'PCG_ESPEMI'
      Size = 2
    end
    object qryPedidoFOR_CODFOR: TStringField
      FieldName = 'FOR_CODFOR'
      Required = True
      Size = 8
    end
    object qryPedidoFOR_CODATI: TStringField
      FieldName = 'FOR_CODATI'
      Required = True
      Size = 3
    end
    object qryPedidoFOR_CODCID: TStringField
      FieldName = 'FOR_CODCID'
      Size = 5
    end
    object qryPedidoFOR_NOMFOR: TStringField
      FieldName = 'FOR_NOMFOR'
      Size = 60
    end
    object qryPedidoFOR_DTACAD: TDateField
      FieldName = 'FOR_DTACAD'
    end
    object qryPedidoFOR_NOMFAN: TStringField
      FieldName = 'FOR_NOMFAN'
      Size = 60
    end
    object qryPedidoFOR_ENDERE: TStringField
      FieldName = 'FOR_ENDERE'
      Size = 60
    end
    object qryPedidoFOR_BAIRRO: TStringField
      FieldName = 'FOR_BAIRRO'
      Size = 30
    end
    object qryPedidoFOR_C_E_P_: TStringField
      FieldName = 'FOR_C_E_P_'
      Size = 9
    end
    object qryPedidoFOR_CGCCPF: TStringField
      FieldName = 'FOR_CGCCPF'
      Size = 1
    end
    object qryPedidoFOR_C_G_C_: TStringField
      FieldName = 'FOR_C_G_C_'
      Size = 18
    end
    object qryPedidoFOR_I_E_S_: TStringField
      FieldName = 'FOR_I_E_S_'
      Size = 18
    end
    object qryPedidoFOR_CONTAT: TStringField
      FieldName = 'FOR_CONTAT'
      Size = 25
    end
    object qryPedidoFOR_CAIPOS: TStringField
      FieldName = 'FOR_CAIPOS'
      Size = 5
    end
    object qryPedidoFOR_FONE01: TStringField
      FieldName = 'FOR_FONE01'
      Size = 15
    end
    object qryPedidoFOR_FONE02: TStringField
      FieldName = 'FOR_FONE02'
      Size = 15
    end
    object qryPedidoFOR_F_A_X_: TStringField
      FieldName = 'FOR_F_A_X_'
      Size = 15
    end
    object qryPedidoFOR_EMAIL_: TStringField
      FieldName = 'FOR_EMAIL_'
      Size = 50
    end
    object qryPedidoFOR_HOMEPA: TStringField
      FieldName = 'FOR_HOMEPA'
      Size = 50
    end
    object qryPedidoFOR_CNDPAG: TStringField
      FieldName = 'FOR_CNDPAG'
      Size = 38
    end
    object qryPedidoFOR_CODEMP: TStringField
      FieldName = 'FOR_CODEMP'
      Required = True
      Size = 3
    end
    object qryPedidoAUTOINCREM_1: TStringField
      FieldName = 'AUTOINCREM_1'
    end
    object qryPedidoFOR_QTDETI: TIntegerField
      FieldName = 'FOR_QTDETI'
    end
    object qryPedidoFOR_PERCOM: TFloatField
      FieldName = 'FOR_PERCOM'
    end
    object qryPedidoFOR_NUMRG_: TStringField
      DisplayWidth = 15
      FieldName = 'FOR_NUMRG_'
      Size = 15
    end
    object qryPedidoFOR_MATREV: TStringField
      FieldName = 'FOR_MATREV'
      Size = 1
    end
    object qryPedidoFOR_OBSERV: TMemoField
      FieldName = 'FOR_OBSERV'
      BlobType = ftMemo
    end
    object qryPedidoFOR_NOMCID: TStringField
      FieldName = 'FOR_NOMCID'
      Required = True
      Size = 40
    end
    object qryPedidoPCG_VALFRE: TFloatField
      FieldName = 'PCG_VALFRE'
    end
    object qryPedidoPCG_DESACE: TFloatField
      FieldName = 'PCG_DESACE'
    end
    object qryPedidoPCG_DTAFAT: TDateField
      FieldName = 'PCG_DTAFAT'
    end
    object qryPedidoPCG_NOMENT: TStringField
      FieldName = 'PCG_NOMENT'
      Size = 50
    end
    object qryPedidoPCG_ENDENT: TStringField
      FieldName = 'PCG_ENDENT'
      Size = 50
    end
    object qryPedidoPCG_CIDENT: TStringField
      FieldName = 'PCG_CIDENT'
      Size = 50
    end
    object qryPedidoCOMPRA: TStringField
      FieldName = 'COMPRA'
      Size = 70
    end
    object qryPedidoOPE_E_MAIL: TStringField
      FieldName = 'OPE_E_MAIL'
      Size = 100
    end
    object qryPedidoOPE_NEXTEL: TStringField
      FieldName = 'OPE_NEXTEL'
      Size = 100
    end
    object qryPedidoOPE_RAMAL1: TStringField
      FieldName = 'OPE_RAMAL1'
    end
    object qryPedidoOPE_FONE01: TStringField
      FieldName = 'OPE_FONE01'
    end
    object qryPedidoPCG_BASCOF: TFloatField
      FieldName = 'PCG_BASCOF'
    end
    object qryPedidoPCG_VALCOF: TFloatField
      FieldName = 'PCG_VALCOF'
    end
    object qryPedidoPCG_BASPIS: TFloatField
      FieldName = 'PCG_BASPIS'
    end
    object qryPedidoPCG_VALPIS: TFloatField
      FieldName = 'PCG_VALPIS'
    end
    object qryPedidoPCG_BASICM: TFloatField
      FieldName = 'PCG_BASICM'
    end
    object qryPedidoPCG_VALICM: TFloatField
      FieldName = 'PCG_VALICM'
    end
    object qryPedidoPCG_BASIPI: TFloatField
      FieldName = 'PCG_BASIPI'
      LookupDataSet = qryEmpresa
    end
    object qryPedidoPCG_BASSUB: TFloatField
      FieldName = 'PCG_BASSUB'
    end
    object cdsPedidoPCG_PAGVIS: TStringField
      FieldName = 'PCG_PAGVIS'
      Size = 1
    end
    object qryPedidoENDERE: TStringField
      FieldName = 'ENDERE'
      Size = 100
    end
    object qryPedidoPCG_ORCORI: TStringField
      FieldName = 'PCG_ORCORI'
      Size = 11
    end
    object qryPedidoPCG_SUBFCP: TFloatField
      FieldName = 'PCG_SUBFCP'
    end
    object qryPedidoPCG_CODTRR: TStringField
      DisplayWidth = 5
      FieldName = 'PCG_CODTRR'
      Size = 5
    end
    object qryPedidoPCG_PEDBON: TStringField
      FieldName = 'PCG_PEDBON'
      Size = 1
    end
    object qryPedidoPCG_TOTDAR: TFloatField
      FieldName = 'PCG_TOTDAR'
    end
    object qryPedidoPCG_CODCMP: TStringField
      FieldName = 'PCG_CODCMP'
      Size = 60
    end
    object qryPedidoPCG_OBS006: TStringField
      FieldName = 'PCG_OBS006'
      Size = 250
    end
    object qryPedidoPCG_OBSPD4: TStringField
      FieldName = 'PCG_OBSPD4'
      Size = 250
    end
    object qryPedidoPCG_OBSPD5: TStringField
      FieldName = 'PCG_OBSPD5'
      Size = 250
    end
    object qryPedidoPCG_OBSPD6: TStringField
      FieldName = 'PCG_OBSPD6'
      Size = 250
    end
  end
  object frxTransp: TfrxDBDataset
    UserName = 'frxTransp'
    CloseDataSource = False
    DataSet = qryTransp
    BCDToCurrency = False
    Left = 96
    Top = 72
  end
  object frxEmpresa: TfrxDBDataset
    UserName = 'frxEmpresa'
    CloseDataSource = False
    DataSet = qryEmpresa
    BCDToCurrency = False
    Left = 480
    Top = 16
  end
  object qryEmpresa: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT'
      '  CADEMP.EMP_CODEMP,'
      '  CADEMP.EMP_NOMEMP,'
      
        '  CONCAT(CADEMP.EMP_ENDERE, '#39', '#39', CADEMP.EMP_ENDNUM) AS EMP_ENDE' +
        'RE,'
      
        '  CONCAT(CADCID.CID_NOMCID, '#39' - '#39', CADCID.CID_ESTADO) AS EMP_NOM' +
        'CID,'
      '  CADEMP.EMP_EMAILC,'
      '  CADEMP.EMP_FONE01, '
      '  CADEMP.EMP_F_A_X_,'
      '  CADEMP.EMP_C_G_C_,'
      '  CADEMP.EMP_I_E_S_'
      'FROM '
      '  CADEMP '
      '  LEFT JOIN CADCID ON (CADEMP.EMP_CODCID = CADCID.CID_CODCID) ')
    ReadOnly = True
    Left = 416
    Top = 16
    object qryEmpresaEMP_CODEMP: TStringField
      FieldName = 'EMP_CODEMP'
      Required = True
      Size = 3
    end
    object qryEmpresaEMP_NOMEMP: TStringField
      FieldName = 'EMP_NOMEMP'
      Required = True
      Size = 40
    end
    object qryEmpresaEMP_ENDERE: TStringField
      FieldName = 'EMP_ENDERE'
      Size = 47
    end
    object qryEmpresaEMP_NOMCID: TStringField
      FieldName = 'EMP_NOMCID'
      Size = 45
    end
    object qryEmpresaEMP_FONE01: TStringField
      FieldName = 'EMP_FONE01'
      Size = 15
    end
    object qryEmpresaEMP_F_A_X_: TStringField
      FieldName = 'EMP_F_A_X_'
      Size = 15
    end
    object qryEmpresaEMP_C_G_C_: TStringField
      FieldName = 'EMP_C_G_C_'
      Size = 18
    end
    object qryEmpresaEMP_I_E_S_: TStringField
      FieldName = 'EMP_I_E_S_'
      Size = 18
    end
    object qryEmpresaEMP_EMAILC: TStringField
      FieldName = 'EMP_EMAILC'
      Size = 50
    end
    object qryEmpresaEMP_BAIRRO: TStringField
      FieldName = 'EMP_BAIRRO'
      Size = 100
    end
    object qryEmpresaEMP_C_E_P_: TStringField
      FieldName = 'EMP_C_E_P_'
    end
  end
  object qryTransp: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Left = 24
    Top = 72
    object qryTranspTRA_CODTRA: TStringField
      FieldName = 'TRA_CODTRA'
      Required = True
      Size = 5
    end
    object qryTranspTRA_CODCID: TStringField
      FieldName = 'TRA_CODCID'
      Size = 5
    end
    object qryTranspTRA_NOMTRA: TStringField
      FieldName = 'TRA_NOMTRA'
      Size = 40
    end
    object qryTranspTRA_DTACAD: TDateField
      FieldName = 'TRA_DTACAD'
    end
    object qryTranspTRA_ENDERE: TStringField
      FieldName = 'TRA_ENDERE'
      Size = 40
    end
    object qryTranspTRA_BAIRRO: TStringField
      FieldName = 'TRA_BAIRRO'
      Size = 30
    end
    object qryTranspTRA_C_E_P_: TStringField
      FieldName = 'TRA_C_E_P_'
      Size = 9
    end
    object qryTranspTRA_C_G_C_: TStringField
      FieldName = 'TRA_C_G_C_'
      Size = 18
    end
    object qryTranspTRA_I_E_S_: TStringField
      FieldName = 'TRA_I_E_S_'
      Size = 18
    end
    object qryTranspTRA_FONE01: TStringField
      FieldName = 'TRA_FONE01'
      Size = 15
    end
    object qryTranspTRA_FONE02: TStringField
      FieldName = 'TRA_FONE02'
      Size = 15
    end
    object qryTranspTRA_F_A_X_: TStringField
      FieldName = 'TRA_F_A_X_'
      Size = 15
    end
    object qryTranspTRA_NUMPLA: TStringField
      FieldName = 'TRA_NUMPLA'
      Size = 8
    end
    object qryTranspTRA_CONTAT: TStringField
      FieldName = 'TRA_CONTAT'
      Size = 25
    end
    object qryTranspTRA_EMAIL_: TStringField
      FieldName = 'TRA_EMAIL_'
      Size = 60
    end
    object qryTranspTRA_HOMEPA: TStringField
      FieldName = 'TRA_HOMEPA'
      Size = 60
    end
    object qryTranspTRA_CODEMP: TStringField
      FieldName = 'TRA_CODEMP'
      Size = 3
    end
    object qryTranspAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryTranspTRA_NOMFAN: TStringField
      FieldName = 'TRA_NOMFAN'
      Size = 40
    end
    object qryTranspTRA_CGCCPF: TIntegerField
      FieldName = 'TRA_CGCCPF'
    end
    object qryTranspTRA_NOMCID: TStringField
      FieldName = 'TRA_NOMCID'
      Required = True
      Size = 40
    end
  end
  object frxExportaXLS: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 232
    Top = 80
  end
  object frxPaginaPaisagem: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39504.578949363400000000
    ReportOptions.LastChange = 44480.443031087960000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllTipFreOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxPedido."PCG_TIPFRE"> = '#39'1'#39' Then'
      '    rllTipFre.Text := '#39'CIF '#39
      '  Else              '
      '    rllTipFre.Text := '#39'FOB '#39
      'end;'
      ''
      'procedure rllObservacoesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  //              '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPaginaUserFunction
    Left = 104
    Top = 136
    Datasets = <
      item
        DataSet = frxEmpresa
        DataSetName = 'frxEmpresa'
      end
      item
        DataSet = frxPedido
        DataSetName = 'frxPedido'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxTransp
        DataSetName = 'frxTransp'
      end
      item
        DataSet = frxTranspRedesp
        DataSetName = 'frxTranspRedes'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Relatorio: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 2.500000000000000000
      BottomMargin = 2.500000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      OnBeforePrint = 'RelatorioOnBeforePrint'
      object Titulo: TfrxPageHeader
        FillType = ftBrush
        Height = 321.260050000000000000
        Top = 18.897650000000000000
        Width = 1103.622760000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        Stretched = True
        object rllImagem: TfrxPictureView
          ShiftMode = smWhenOverlapped
          Left = 12.559060000000000000
          Top = 18.338590000000000000
          Width = 235.472480000000000000
          Height = 94.118120000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object dbEmrpesa: TfrxMemoView
          Left = 262.519790000000000000
          Top = 18.897637795275600000
          Width = 457.323130000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxEmpresa."EMP_NOMEMP"]')
          ParentFont = False
        end
        object dbEnderecoEmpresa: TfrxMemoView
          Left = 262.519790000000000000
          Top = 34.015770000000010000
          Width = 464.882190000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_ENDERE"]')
          ParentFont = False
        end
        object rllPedOrc: TfrxMemoView
          Left = 7.220470000000000000
          Top = 184.795275590000000000
          Width = 415.748300000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pedido de Compra N'#186':')
          ParentFont = False
        end
        object mmNomeCliente: TfrxMemoView
          Left = 7.220470000000000000
          Top = 202.212740000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nome:  ')
          ParentFont = False
        end
        object dbNomeCliente: TfrxMemoView
          Left = 78.252010000000000000
          Top = 201.433210000000000000
          Width = 891.969080000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxPedido."FOR_NOMFOR"]')
          ParentFont = False
        end
        object mmEnderecoCliente: TfrxMemoView
          Left = 7.220470000000000000
          Top = 218.078740160000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object dbEnderecoCliente: TfrxMemoView
          Left = 78.252010000000000000
          Top = 218.078740160000000000
          Width = 343.937230000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."ENDERE"]')
          ParentFont = False
        end
        object mmFoneCliente: TfrxMemoView
          Left = 7.220470000000000000
          Top = 266.921460000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fone:  ')
          ParentFont = False
        end
        object dbBairroCliente: TfrxMemoView
          Left = 501.015743150000000000
          Top = 218.078740160000000000
          Width = 461.102660000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_BAIRRO"]')
          ParentFont = False
        end
        object dbTelefoneCliente: TfrxMemoView
          Left = 78.252010000000000000
          Top = 266.921460000000000000
          Width = 104.567100000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Length(<frxPedido."FOR_FONE01">) > 0, fFormataFone(<frxPedi' +
              'do."FOR_FONE01">),'#39#39')]')
          ParentFont = False
        end
        object mmCNPJCliente: TfrxMemoView
          Left = 7.220470000000000000
          Top = 250.582870000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ:  ')
          ParentFont = False
        end
        object dbCNPJCliente: TfrxMemoView
          Left = 78.252010000000000000
          Top = 250.582677170000000000
          Width = 234.330860000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxPedido."FOR_C_G_C_">) > 0 ,'
            
              ' FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxPedido."FOR_C_G_C_' +
              '">),'#39#39')]')
          ParentFont = False
        end
        object mmIECliente: TfrxMemoView
          Left = 429.425187090000000000
          Top = 234.464557170000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'IE:  ')
          ParentFont = False
        end
        object dbIECliente: TfrxMemoView
          Left = 502.015743150000000000
          Top = 234.464557170000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_I_E_S_"]')
          ParentFont = False
        end
        object mmContatoCliente: TfrxMemoView
          Left = 689.874460000000000000
          Top = 271.086614170000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Contato:  ')
          ParentFont = False
        end
        object dbContatoCliente: TfrxMemoView
          Left = 746.906000000000000000
          Top = 271.086609290000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_CONTAT"]')
          ParentFont = False
        end
        object dbBairroEmpresa: TfrxMemoView
          Left = 731.331170000000000000
          Top = 34.015738270000000000
          Width = 362.834880000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_NOMCID"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 195.440940000000000000
          Top = 266.834645670000000000
          Width = 108.567100000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Length(<frxPedido."FOR_FONE02">) > 0 ,fFormataFone(<frxPedi' +
              'do."FOR_FONE02">),'#39#39')]')
          ParentFont = False
        end
        object Line22: TfrxLineView
          Left = 1.889763779527559000
          Top = 130.078850000000000000
          Width = 1096.062992125984000000
          Color = clBlack
          Diagonal = True
        end
        object Memo14: TfrxMemoView
          Align = baWidth
          Top = 134.063080000000000000
          Width = 1103.622760000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Departamento de Compras')
          ParentFont = False
        end
        object rllTituloPedOrc: TfrxMemoView
          Align = baWidth
          Top = 157.519790000000000000
          Width = 1103.622760000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Or'#231'amento')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 428.748300000000000000
          Top = 287.204734170000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cond. Pgto.:')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 803.598657090000000000
          Top = 251.716525670000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Aten'#231#227'o:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 428.425187090000000000
          Top = 218.078740160000000000
          Width = 56.692910940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 7.220470000000000000
          Top = 233.330708660000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 7.897357090000000000
          Top = 285.110270390000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C.E.P.:')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 622.842627090000000000
          Top = 251.850374170000000000
          Width = 49.133850940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Entrega:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 78.252010000000000000
          Top = 233.196850390000000000
          Width = 249.448980000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_NOMCID"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 80.487913150000000000
          Top = 285.110270390000000000
          Width = 132.283550000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxPedido."FOR_C_E_P_">) > 0 ,'
            ' FormatMaskText('#39'00000-000;0'#39',<frxPedido."FOR_C_E_P_">),'#39#39')]')
          ParentFont = False
        end
        object mmoConPag: TfrxMemoView
          Left = 497.779840000000000000
          Top = 287.204734170000000000
          Width = 517.795610000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataCondPag(<frxPedido."PCG_CONPAG">)]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 868.189213150000000000
          Top = 251.716535430000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_ATENCA"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 675.433183150000000000
          Top = 251.850374170000000000
          Width = 124.724490000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_DTAENT"]')
          ParentFont = False
        end
        object dbFoneEmpresa: TfrxMemoView
          Left = 296.535560000000000000
          Top = 98.748072990000000000
          Width = 117.165359210000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataFone(<frxEmpresa."EMP_FONE01">)]')
          ParentFont = False
        end
        object dbCEPEmpresa: TfrxMemoView
          Left = 584.149970000000000000
          Top = 98.748082750000000000
          Width = 457.323130000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_EMAILC"]')
          ParentFont = False
        end
        object dbFaxEmpresa: TfrxMemoView
          Left = 444.314958190000000000
          Top = 98.748072990000000000
          Width = 136.063009210000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataFone(<frxEmpresa."EMP_F_A_X_">)]')
          ParentFont = False
        end
        object mmFoneEmpresa: TfrxMemoView
          Left = 263.330860000000000000
          Top = 98.748072990000000000
          Width = 30.614173230000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone:')
          ParentFont = False
        end
        object mmFaxEmpresa: TfrxMemoView
          Left = 415.968501500000000000
          Top = 98.748072990000000000
          Width = 26.456710000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fax: ')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 262.787570000000000000
          Top = 81.252010000000000000
          Width = 37.795300000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ:  ')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 302.819110000000000000
          Top = 81.252010000000000000
          Width = 109.606370000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxEmpresa."EMP_C_G_C_">) > 0 ,'
            
              ' FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxEmpresa."EMP_C_G_C' +
              '_">),'#39#39')]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 415.968501500000000000
          Top = 81.630004250000000000
          Width = 18.897650000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE:  ')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 444.314958190000000000
          Top = 81.630004250000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_I_E_S_"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 944.559680000000000000
          Top = 271.464750000000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tipo Frete:')
          ParentFont = False
        end
        object rllTipFre: TfrxMemoView
          Left = 1009.150236060000000000
          Top = 271.464750000000000000
          Width = 71.811070000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllTipFreOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 429.425187090000000000
          Top = 252.228510000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fax:  ')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 502.015743150000000000
          Top = 252.228510000000000000
          Width = 104.567100000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Length(<frxPedido."FOR_F_A_X_">) > 0, fFormataFone(<frxPedi' +
              'do."FOR_F_A_X_">),'#39#39')]')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 429.425187090000000000
          Top = 271.086614170000000000
          Width = 71.433070870000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Faturamento:')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 502.015743150000000000
          Top = 271.086614170000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF((<frxPedido."PCG_DTAFAT"> = <frxPedido."PCG_DTAENT">) AND (' +
              'STRFATPED = '#39'1'#39'), '#39'IMEDIATO'#39', <frxPedido."PCG_DTAFAT">)]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 262.787570000000000000
          Top = 51.252010000000000000
          Width = 521.575140000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_BAIRRO"] - CEP.: [frxEmpresa."EMP_C_E_P_"]')
          ParentFont = False
        end
        object rllPgtVis: TfrxMemoView
          Left = 1015.354980000000000000
          Top = 286.645674170000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PAGTO. A VISTA')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 7.559060000000000000
          Top = 302.362400000000000000
          Width = 71.811030940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ped. Venda.:')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 80.149616060000000000
          Top = 302.362400000000000000
          Width = 1012.914040000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_PEDVEN"]')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 501.015743150000000000
          Top = 184.795275590000000000
          Width = 366.614410000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_CODCMP"] - [frxPedido."COMPRA"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo54: TfrxMemoView
          Left = 428.425187090000000000
          Top = 184.795275590000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Comprador:')
          ParentFont = False
        end
      end
      object Rodape: TfrxPageFooter
        FillType = ftBrush
        Height = 160.637910000000000000
        Top = 1058.268400000000000000
        Width = 1103.622760000000000000
        object mmCitelSoftware: TfrxMemoView
          Align = baRight
          Left = 808.819420000000000000
          Top = 141.740259999999900000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          ParentFont = False
        end
        object Line15: TfrxLineView
          Left = 1.889763780000000000
          Top = 91.181200000000000000
          Width = 1096.062992130000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoMsgPcm: TfrxMemoView
          Align = baWidth
          Top = 93.433210000000030000
          Width = 1103.622760000000000000
          Height = 18.897650000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[MSGPCM]')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 8.338590000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES:')
          ParentFont = False
        end
        object rllObservacoes: TfrxMemoView
          Left = 6.425118740000000000
          Top = 18.661410000000000000
          Width = 1084.725110000000000000
          Height = 68.787401570000000000
          OnBeforePrint = 'rllObservacoesOnBeforePrint'
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7')
          ParentFont = False
          WordWrap = False
        end
        object rllObservacao: TfrxMemoView
          Left = 128.504020000000000000
          Top = 0.984230000000025000
          Width = 963.780150000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = False
        end
        object Line28: TfrxLineView
          Align = baWidth
          Top = 134.960729999999900000
          Width = 1103.622760000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo29: TfrxMemoView
          Align = baLeft
          Top = 139.842609999999800000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emitido em [DATE] '#224's [TIME]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Top = 113.385900000000100000
          Width = 1054.488870000000000000
          Height = 18.897650000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[MSGPC2]')
          ParentFont = False
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Left = 1050.709340000000000000
          Top = 115.385900000000100000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'P'#225'g:[Page#]/[TotalPages#]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object Detalhes: TfrxMasterData
        FillType = ftBrush
        Height = 32.125994020000000000
        Top = 483.779840000000000000
        Width = 1103.622760000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        Child = frxPaginaPaisagem.ChildAplicacao
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object frxRelatorioCODITEM: TfrxMemoView
          Left = 6.338590000000000000
          Width = 52.913390710000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PCD_CODITE"]')
          ParentFont = False
        end
        object mmoDescri: TfrxMemoView
          ShiftMode = smDontShift
          Left = 63.708720000000000000
          Width = 457.535733310000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataField = 'PCD_DESITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PCD_DESITE"]')
          ParentFont = False
        end
        object mmoUnidade: TfrxMemoView
          Left = 436.519685040000000000
          Top = 16.897650000000000000
          Width = 22.677165350000000000
          Height = 13.228346460000000000
          DataField = 'UNI_SIGUNI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          ParentFont = False
        end
        object mmoDesMar: TfrxMemoView
          Left = 81.661417320000000000
          Top = 16.897650000000000000
          Width = 69.165354330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoCodFabrica: TfrxMemoView
          Left = 154.385826770000000000
          Top = 16.897650000000000000
          Width = 113.385865830000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdIte: TfrxMemoView
          Left = 610.275590550000000000
          Top = 16.897650000000000000
          Width = 45.354333150000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
        end
        object rllPrecoUnit: TfrxMemoView
          Left = 660.921259840000000000
          Top = 16.897650000000000000
          Width = 60.472480000000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          ParentFont = False
        end
        object rllPrecotot: TfrxMemoView
          Left = 839.874015750000000000
          Top = 16.897650000000000000
          Width = 68.031540000000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          ParentFont = False
        end
        object rllIpi: TfrxMemoView
          Left = 912.708661420000000000
          Top = 16.897650000000000000
          Width = 32.125984250000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PCD_PERIPI"]')
          ParentFont = False
        end
        object rllVlIpi: TfrxMemoView
          Left = 950.503937010000000000
          Top = 16.897650000000000000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTIPI"]')
          ParentFont = False
        end
        object rllDesUni: TfrxMemoView
          Left = 724.196850390000000000
          Top = 16.897650000000000000
          Width = 45.354345350000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(1 - (1 - <frxRelatorio."PCD_DESUNI"> / 100) * (1 - <frxRelator' +
              'io."PCD_DESUN2"> / 100) * (1 - <frxRelatorio."PCD_DESUN3"> / 100' +
              ') * (1 - <frxRelatorio."PCD_DESUN4"> / 100) '
            
              '* (1 - <frxRelatorio."PCD_DESUN5"> / 100) * (1 - <frxRelatorio."' +
              'PCD_DESUN6"> / 100)) * 100]')
          ParentFont = False
        end
        object rllUnilIQ: TfrxMemoView
          Left = 777.598425200000000000
          Top = 16.897650000000000000
          Width = 60.472480000000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNILIQ"]')
          ParentFont = False
        end
        object mmoCodBarras: TfrxMemoView
          Left = 271.842519690000000000
          Top = 16.897650000000000000
          Width = 158.740225830000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODBAR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoUnidEmbDes: TfrxMemoView
          Left = 464.157480310000000000
          Top = 16.897650000000000000
          Width = 56.692935350000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SIGEMB"]')
          ParentFont = False
        end
        object mmoQtdEmbDes: TfrxMemoView
          Left = 526.299212600000000000
          Top = 16.897650000000000000
          Width = 79.370115350000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_EMBALA"]')
          ParentFont = False
        end
        object mmoLocFisDes: TfrxMemoView
          Left = 806.055660000000000000
          Width = 159.874074330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoLocSupDes: TfrxMemoView
          Left = 979.111010000000000000
          Width = 106.960654330000000000
          Height = 13.228346460000000000
          DataField = 'LOCSUP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCSUP"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoDtaEnt: TfrxMemoView
          Left = 6.425196850000000000
          Top = 17.007874019999970000
          Width = 69.165354330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."PCD_DTAENT"]')
          ParentFont = False
        end
        object rllValSub: TfrxMemoView
          Left = 1045.795275590000000000
          Top = 17.118119999999980000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTSUB"]')
          ParentFont = False
        end
        object rllAlqSub: TfrxMemoView
          Left = 998.795920000000000000
          Top = 16.897650000000000000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PCD_PERSUB"]')
          ParentFont = False
        end
        object mmoReferenciaDados: TfrxMemoView
          Left = 638.000000000000000000
          Top = 1.338279999999997000
          Width = 159.874074330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoValDarIte: TfrxMemoView
          Left = 566.173228350000000000
          Top = 1.511811019999982000
          Width = 62.362204720000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTDAR"]')
          ParentFont = False
        end
      end
      object Totais: TfrxReportSummary
        FillType = ftBrush
        Height = 139.724490000000000000
        Top = 616.063390000000000000
        Width = 1103.622760000000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        Child = frxPaginaPaisagem.LocalEntrega
        object Shape2: TfrxShapeView
          Left = 7.118120000000000000
          Top = 4.118110239999965000
          Width = 1092.284170000000000000
          Height = 105.826840000000000000
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 0.338589999999953800
          Width = 1103.622760000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 139.724490000000000000
          Width = 1103.622760000000000000
          Color = clBlack
          Diagonal = True
        end
        object rllTotalItens: TfrxMemoView
          Left = 959.764458110000000000
          Top = 26.834645669999990000
          Width = 132.283442600000000000
          Height = 18.897637795275590000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,Detalhes,2)]')
          ParentFont = False
        end
        object rllTotalIPI: TfrxMemoView
          Left = 792.465138110000000000
          Top = 82.393700787401600000
          Width = 75.590492600000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTIPI">,Detalhes,2)]')
          ParentFont = False
        end
        object rllTotalGeral: TfrxMemoView
          Left = 959.764458110000000000
          Top = 82.393700787401600000
          Width = 132.283442600000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'rllTotalGeralOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE"> +<frxRelatorio."TOTIPI"> + <frxRela' +
              'torio."TOTSUB"> ,Detalhes,2) + <frxPedido."PCG_VALFRE">]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 188.535555120000000000
          Top = 118.338594880000000000
          Width = 79.370078740000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Litros:')
          ParentFont = False
        end
        object rllLitragem: TfrxMemoView
          Left = 270.173064800000000000
          Top = 118.338594880000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTLIT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 375.889605120000000000
          Top = 82.377996690000030000
          Width = 120.944859920000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo49OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_VALFRE">]')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalsUB: TfrxMemoView
          Left = 701.393647090000000000
          Top = 26.834645669999990000
          Width = 79.370081180000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTSUB">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 5.118120000000000000
          Top = 118.472465350000000000
          Width = 79.370078740000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Peso Total:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 86.755624800000000000
          Top = 118.472465350000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PESOIT">,Detalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo60: TfrxMemoView
          Left = 506.173155120000000000
          Top = 82.393700790000030000
          Width = 102.047209920000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo49OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_DESACE">]')
          ParentFont = False
          WordWrap = False
        end
        object Line19: TfrxLineView
          Left = 7.118120000000000000
          Top = 57.031539999999950000
          Width = 1092.284170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line20: TfrxLineView
          Left = 133.622140000000000000
          Top = 4.118119999999976000
          Height = 105.826840000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line21: TfrxLineView
          Left = 249.905690000000000000
          Top = 4.118119999999976000
          Height = 105.826840000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line23: TfrxLineView
          Left = 369.968770000000000000
          Top = 4.118119999999976000
          Height = 105.826840000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line24: TfrxLineView
          Left = 502.724800000000000000
          Top = 4.118119999999976000
          Height = 105.826840000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line25: TfrxLineView
          Left = 785.803650000000000000
          Top = 4.118119999999976000
          Height = 105.826840000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line26: TfrxLineView
          Left = 954.323440000000000000
          Top = 4.118119999999976000
          Height = 105.826840000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo33: TfrxMemoView
          Left = 8.897650000000000000
          Top = 8.677180000000022000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'BASE C'#193'LC.PIS')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 137.401670000000000000
          Top = 7.897649999999999000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'AL'#205'QUOTA DO PIS')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 8.897650000000000000
          Top = 60.811069999999970000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'BASE C'#193'LC. COFINS')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 137.401670000000000000
          Top = 60.811069999999970000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'AL'#205'QUOTA COFINS')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 254.803340000000000000
          Top = 7.897649999999999000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DO PIS')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 254.803340000000000000
          Top = 60.811069999999970000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DO COFINS')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 375.527830000000000000
          Top = 7.897649999999999000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'BASE C'#193'LCULO ICMS')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 375.527830000000000000
          Top = 60.811069999999970000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DO FRETE')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 959.559680000000000000
          Top = 7.897649999999999000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOS PRODUTOS')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          Left = 959.559680000000000000
          Top = 60.850393700787430000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO PEDIDO')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 701.213050000000000000
          Top = 7.897649999999999000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ICMS SUBST.')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 792.362710000000000000
          Top = 60.850393700787430000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DO IPI')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 701.527559060000000000
          Top = 60.811069999999970000
          Width = 79.370081180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'BASE C. IPI')
          ParentFont = False
        end
        object Line27: TfrxLineView
          Left = 613.740570000000000000
          Top = 4.118119999999976000
          Height = 105.826840000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo75: TfrxMemoView
          Left = 505.795610000000000000
          Top = 7.897649999999999000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DO ICMS')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 505.795610000000000000
          Top = 60.811069999999970000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESP.ACESS'#211'R.')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 701.527559060000000000
          Top = 82.393700790000030000
          Width = 79.370081180000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_BASIPI">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 505.795610000000000000
          Top = 26.795300000000000000
          Width = 102.047209920000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_VALICM">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 375.512060000000000000
          Top = 26.795300000000000000
          Width = 120.944859920000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_BASICM">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo48: TfrxMemoView
          Left = 254.567100000000000000
          Top = 26.795300000000000000
          Width = 109.606269920000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_VALPIS">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Left = 254.567100000000000000
          Top = 82.354330710000000000
          Width = 109.606269920000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_VALCOF">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo77: TfrxMemoView
          Left = 8.897650000000000000
          Top = 26.795275589999960000
          Width = 120.944859920000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_BASPIS">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo78: TfrxMemoView
          Left = 8.897650000000000000
          Top = 82.354330710000000000
          Width = 120.944859920000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_BASCOF">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo79: TfrxMemoView
          Left = 137.401574800000000000
          Top = 26.795300000000000000
          Width = 105.826739920000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxPedido."PCG_BASPIS"> <> 0, (<frxPedido."PCG_VALPIS"> / ' +
              ' <frxPedido."PCG_BASPIS">) * 100, 0) ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo80: TfrxMemoView
          Left = 137.401670000000000000
          Top = 82.354330710000000000
          Width = 105.826739920000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxPedido."PCG_BASCOF"> <> 0, (<frxPedido."PCG_VALCOF"> / ' +
              ' <frxPedido."PCG_BASCOF">) * 100, 0) ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 373.953000000000000000
          Top = 118.165430000000000000
          Width = 79.370078740000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Kilos:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 455.590509680000000000
          Top = 118.165430000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTKIL"]')
          ParentFont = False
          WordWrap = False
        end
        object linIcmDes: TfrxLineView
          Left = 871.291900000000000000
          Top = 4.157446140000047000
          Height = 105.448853070000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoIcmDes: TfrxMemoView
          Left = 875.173858110000000000
          Top = 82.393700787401600000
          Width = 75.590492600000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ICMDES">,Detalhes,2)]')
          ParentFont = False
        end
        object mmoTitIcmDes: TfrxMemoView
          Left = 875.071430000000000000
          Top = 60.850393700787430000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ICMS DESON.')
          ParentFont = False
        end
        object mmoTitDesPis: TfrxMemoView
          Left = 875.071430000000000000
          Top = 7.937007870000003000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DES. PIS/COF')
          ParentFont = False
        end
        object mmoDesPis: TfrxMemoView
          Left = 875.071430000000000000
          Top = 26.834645669999990000
          Width = 75.590492600000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESPIS">,Detalhes,2)]')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Left = 694.992580000000000000
          Top = 3.779530000000022000
          Height = 105.826771650000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object rllTotalSubFCP: TfrxMemoView
          Left = 788.322785830000000000
          Top = 30.456710000000040000
          Width = 80.503937010000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SUBFCP">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 788.142240000000000000
          Top = 7.559060000000045000
          Width = 80.503937010000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ICMS SUB FCP')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 619.237018660000000000
          Top = 7.937007874015762000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'B. ICMS SUB')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 619.063390000000000000
          Top = 26.834645669291380000
          Width = 71.810974800000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_BASSUB">]')
          ParentFont = False
          WordWrap = False
        end
        object mmoTitDar: TfrxMemoView
          Left = 619.237018660000000000
          Top = 60.850393700000040000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DARE')
          ParentFont = False
        end
        object mmoValDar: TfrxMemoView
          Left = 619.063390000000000000
          Top = 82.393700790000000000
          Width = 71.810974800000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_TOTDAR">]')
          ParentFont = False
          WordWrap = False
        end
      end
      object TopoMateriais: TfrxHeader
        FillType = ftBrush
        Height = 60.472480000000000000
        Top = 400.630180000000000000
        Width = 1103.622760000000000000
        ReprintOnNewPage = True
        object sDados: TfrxShapeView
          Left = 2.000000000000000000
          Top = 38.574830000000020000
          Width = 1094.173211260000000000
          Height = 18.897637800000000000
        end
        object sTitulo: TfrxShapeView
          Left = 2.000000000000000000
          Width = 1094.173211260000000000
          Height = 20.787389370000000000
          Fill.BackColor = clSilver
        end
        object sDuplicata: TfrxShapeView
          Left = 2.000000000000000000
          Top = 21.000000000000000000
          Width = 1094.173211260000000000
          Height = 17.763779530000000000
        end
        object mmDuplicata: TfrxMemoView
          Left = 6.338590000000000000
          Top = 22.677165350000000000
          Width = 41.574800710000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 53.000000000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo22: TfrxMemoView
          Left = 7.000000000000000000
          Top = 2.000000000000000000
          Width = 1084.724609610000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'MATERIAIS SOLICITADOS')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 56.692950000000000000
          Top = 22.677180000000020000
          Width = 71.811040710000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object mmoUnid: TfrxMemoView
          Left = 436.496290000000000000
          Top = 41.913405350000010000
          Width = 22.677165350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Un.')
          ParentFont = False
        end
        object mmoMarca: TfrxMemoView
          Left = 81.637910000000000000
          Top = 41.913405350000010000
          Width = 69.165354330000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
        end
        object mmoCodFab: TfrxMemoView
          Left = 154.228510000000000000
          Top = 41.913405350000010000
          Width = 113.385865830000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Codigo de F'#225'brica')
          ParentFont = False
        end
        object rllTitQtdIte: TfrxMemoView
          Left = 610.205010000000000000
          Top = 41.913405350000010000
          Width = 45.354333150000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quant.')
          ParentFont = False
        end
        object mmoPreUni: TfrxMemoView
          Left = 659.913730000000000000
          Top = 41.913405350000010000
          Width = 60.472480000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Unit.')
          ParentFont = False
        end
        object mmoPreTot: TfrxMemoView
          Left = 838.945270000000000000
          Top = 41.913405350000010000
          Width = 68.031540000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Total')
          ParentFont = False
        end
        object mmoPerIpi: TfrxMemoView
          Left = 912.653990000000000000
          Top = 41.913405350000010000
          Width = 32.125984250000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% IPI')
          ParentFont = False
        end
        object mmoPreIpi: TfrxMemoView
          Left = 950.465060000000000000
          Top = 41.913405350000010000
          Width = 47.244094490000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. IPI')
          ParentFont = False
        end
        object linCodBar: TfrxLineView
          Left = 269.378170000000000000
          Top = 39.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linMarca: TfrxLineView
          Left = 79.740260000000000000
          Top = 39.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linCodFab: TfrxLineView
          Left = 152.330860000000000000
          Top = 39.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linUnidEmb: TfrxLineView
          Left = 461.748300000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPreUni: TfrxLineView
          Left = 657.653582360000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPreTot: TfrxLineView
          Left = 836.827150000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPerIpi: TfrxLineView
          Left = 909.535870000000000000
          Top = 39.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPreIpi: TfrxLineView
          Left = 947.771692600000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPerDesc: TfrxLineView
          Left = 722.299630000000000000
          Top = 38.685039370000030000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoPerDesc: TfrxMemoView
          Left = 724.197280000000000000
          Top = 41.913419999999970000
          Width = 45.354345350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%DESC')
          ParentFont = False
        end
        object mmoVlrLiq: TfrxMemoView
          Left = 773.544007640000000000
          Top = 42.031525349999980000
          Width = 60.472480000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Unit.L'#237'q.')
          ParentFont = False
        end
        object linVlrLiq: TfrxLineView
          Left = 771.283860000000000000
          Top = 38.913419999999970000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoCodBar: TfrxMemoView
          Left = 271.834880000000000000
          Top = 41.952768110000020000
          Width = 158.740225830000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Codigo de Barras')
          ParentFont = False
        end
        object linUnid: TfrxLineView
          Left = 434.354670000000000000
          Top = 39.574830000000020000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoUnidEmb: TfrxMemoView
          Left = 464.149970000000000000
          Top = 41.913405350000010000
          Width = 56.692935350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Un.Emb.')
          ParentFont = False
        end
        object linQtdEmb: TfrxLineView
          Left = 523.401980000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoQtdEmb: TfrxMemoView
          Left = 526.401980000000000000
          Top = 41.692935350000030000
          Width = 79.370115350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Quant.Emb.')
          ParentFont = False
        end
        object linQtdIte: TfrxLineView
          Left = 607.653990000000000000
          Top = 39.574830000000020000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmEspecie: TfrxMemoView
          Left = -113.929190000000000000
          Top = 22.614395350000000000
          Width = 79.370130000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object mmoLocFis: TfrxMemoView
          Left = 810.055660000000000000
          Top = 23.015755350000010000
          Width = 159.874074330000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Loc. Fis.')
          ParentFont = False
        end
        object linLocFis: TfrxLineView
          Left = 807.299630000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoLocSup: TfrxMemoView
          Left = 979.111010000000000000
          Top = 23.015755350000010000
          Width = 106.960654330000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Loc. Super Est.')
          ParentFont = False
        end
        object linLocSup: TfrxLineView
          Left = 976.354980000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoTitDtaEnt: TfrxMemoView
          Left = 6.425196850000000000
          Top = 41.952755910000010000
          Width = 69.165354330000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data Entrega')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 1045.843647400000000000
          Top = 41.692935350000030000
          Width = 47.244094490000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. Sub.')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Left = 1043.150280000000000000
          Top = 39.574830000000020000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoPerSub: TfrxMemoView
          Left = 1003.693570000000000000
          Top = 41.692935350000030000
          Width = 35.905514250000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% Sub')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Left = 1000.575450000000000000
          Top = 39.574830000000020000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoReferencia: TfrxMemoView
          Left = 638.000000000000000000
          Top = 23.487939999999980000
          Width = 159.874074330000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Referencia')
          ParentFont = False
        end
        object linReferencia: TfrxLineView
          Left = 632.000000000000000000
          Top = 20.487939999999980000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoTitDarIte: TfrxMemoView
          Left = 566.149970000000000000
          Top = 22.897650000000000000
          Width = 62.362214490000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. DARE'
            ''
            '')
          ParentFont = False
        end
      end
      object Transportadora: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 857.953310000000000000
        Width = 1103.622760000000000000
        Child = frxPaginaPaisagem.Comprador
        PrintChildIfInvisible = True
        object Line12: TfrxLineView
          Align = baWidth
          Top = 98.622140000000000000
          Width = 1103.622760000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo67: TfrxMemoView
          Left = 6.425199290000000000
          Width = 370.393439610000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TRANSPORTADORA:')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Left = 6.448826220000000000
          Top = 15.236240000000000000
          Width = 370.393940000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_NOMTRA"]')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 61.448826220000000000
          Top = 30.354360000000000000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_ENDERE"]')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 61.110236220000000000
          Top = 45.692950000000000000
          Width = 173.858380000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_BAIRRO"]')
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          Left = 61.448826220000000000
          Top = 60.826840000000000000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_NOMCID"]')
          ParentFont = False
        end
        object Memo84: TfrxMemoView
          Left = 286.661566220000000000
          Top = 45.929190000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxTransp."TRA_C_E_P_">) > 0 ,'
            ' FormatMaskText('#39'00000-000;0'#39',<frxTransp."TRA_C_E_P_">),'#39#39')]')
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Left = 239.527676220000000000
          Top = 44.929190000000000000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.E.P.:')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 61.448826220000000000
          Top = 76.590600000000000000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_FONE01"]')
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          Left = 6.448826220000000000
          Top = 30.354360000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          Left = 6.448826220000000000
          Top = 60.826840000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 6.425199290000000000
          Top = 45.692950000000000000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 6.448826220000000000
          Top = 76.590600000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone/Fax:')
          ParentFont = False
        end
        object Memo91: TfrxMemoView
          Left = 206.889766220000000000
          Top = 76.590600000000000000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_F_A_X_"]')
          ParentFont = False
        end
        object Memo92: TfrxMemoView
          Left = 553.480676220000000000
          Top = 0.047246540000000000
          Width = 366.613909610000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TRANSPORTADOR REDESPACHO:')
          ParentFont = False
        end
        object Memo93: TfrxMemoView
          Left = 553.724773150000000000
          Top = 14.897650000000000000
          Width = 370.393940000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_NOMTRA"]')
          ParentFont = False
        end
        object Memo94: TfrxMemoView
          Left = 608.724773150000000000
          Top = 30.015770000000000000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_ENDERE"]')
          ParentFont = False
        end
        object Memo95: TfrxMemoView
          Left = 608.386183150000000000
          Top = 45.354360000000000000
          Width = 173.858380000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_BAIRRO"]')
          ParentFont = False
        end
        object Memo96: TfrxMemoView
          Left = 608.724773150000000000
          Top = 60.488250000000000000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_NOMCID"]')
          ParentFont = False
        end
        object Memo97: TfrxMemoView
          Left = 833.937513150000000000
          Top = 45.590600000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxTranspRedes."TRA_C_E_P_">) > 0 ,'
            
              ' FormatMaskText('#39'00000-000;0'#39',<frxTranspRedes."TRA_C_E_P_">),'#39#39')' +
              ']')
          ParentFont = False
        end
        object Memo98: TfrxMemoView
          Left = 786.803623150000000000
          Top = 44.590600000000000000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.E.P.:')
          ParentFont = False
        end
        object Memo99: TfrxMemoView
          Left = 608.724773150000000000
          Top = 76.252010000000000000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_FONE01"]')
          ParentFont = False
        end
        object Memo100: TfrxMemoView
          Left = 553.724773150000000000
          Top = 30.015770000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          Left = 553.724773150000000000
          Top = 60.488250000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          Left = 553.701146220000000000
          Top = 45.354360000000000000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo103: TfrxMemoView
          Left = 553.724773150000000000
          Top = 76.252010000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone/Fax:')
          ParentFont = False
        end
        object Memo104: TfrxMemoView
          Left = 754.165713150000000000
          Top = 76.252010000000000000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_F_A_X_"]')
          ParentFont = False
        end
      end
      object LocalEntrega: TfrxChild
        FillType = ftBrush
        Height = 54.692950000000010000
        Top = 778.583180000000000000
        Width = 1103.622760000000000000
        Child = frxPaginaPaisagem.Transportadora
        PrintChildIfInvisible = True
        object Memo62: TfrxMemoView
          Left = 3.803156930000000000
          Top = 21.015769999999970000
          Width = 1088.504640000000000000
          Height = 15.118110240000000000
          DataField = 'PCG_NOMENT'
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_NOMENT"]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 778.582679610000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOCAL DE ENTREGA:')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 3.803156930000000000
          Top = 37.133889999999950000
          Width = 1088.504640000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Endere'#231'o: [frxPedido."PCG_ENDENT"] Munic'#237'pio: [frxPedido."PCG_CI' +
              'DENT"]')
          ParentFont = False
        end
        object Line18: TfrxLineView
          Align = baWidth
          Top = 54.692949999999990000
          Width = 1103.622760000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Comprador: TfrxChild
        FillType = ftBrush
        Height = 16.007883780000000000
        Top = 982.677800000000000000
        Width = 1103.622760000000000000
        Child = frxPaginaPaisagem.ChildData
        PrintChildIfInvisible = True
        Stretched = True
        object mmoCompra: TfrxMemoView
          Left = 4.535433070000000000
          Top = 0.889763779999952900
          Width = 782.362710000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxPedido."PCG_COMPRA"]')
          ParentFont = False
        end
      end
      object ChildData: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 1020.473100000000000000
        Width = 1103.622760000000000000
        PrintChildIfInvisible = True
        object rllData: TfrxMemoView
          Align = baCenter
          Left = -9.448825000000000000
          Width = 1122.520410000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
      end
      object ChildAplicacao: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 540.472790000000000000
        Width = 1103.622760000000000000
        Stretched = True
        object Memo81: TfrxMemoView
          ShiftMode = smDontShift
          Left = 132.283550000000000000
          Width = 1112.315573310000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataField = 'ITE_APLFAB'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_APLFAB"]')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Left = 3.779530000000000000
          Width = 124.724490000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aplica'#231#227'o / C'#243'd. F'#225'brica:')
          ParentFont = False
        end
      end
    end
  end
  object frxTranspRedesp: TfrxDBDataset
    UserName = 'frxTranspRedes'
    CloseDataSource = False
    FieldAliases.Strings = (
      'TRA_CODTRA=TRA_CODTRA'
      'TRA_CODCID=TRA_CODCID'
      'TRA_NOMTRA=TRA_NOMTRA'
      'TRA_DTACAD=TRA_DTACAD'
      'TRA_ENDERE=TRA_ENDERE'
      'TRA_BAIRRO=TRA_BAIRRO'
      'TRA_C_E_P_=TRA_C_E_P_'
      'TRA_C_G_C_=TRA_C_G_C_'
      'TRA_I_E_S_=TRA_I_E_S_'
      'TRA_FONE01=TRA_FONE01'
      'TRA_FONE02=TRA_FONE02'
      'TRA_F_A_X_=TRA_F_A_X_'
      'TRA_NUMPLA=TRA_NUMPLA'
      'TRA_CONTAT=TRA_CONTAT'
      'TRA_EMAIL_=TRA_EMAIL_'
      'TRA_HOMEPA=TRA_HOMEPA'
      'TRA_CODEMP=TRA_CODEMP'
      'AUTOINCREM=AUTOINCREM'
      'TRA_NOMFAN=TRA_NOMFAN'
      'TRA_CGCCPF=TRA_CGCCPF'
      'TRA_NOMCID=TRA_NOMCID')
    DataSet = qryTranspRedes
    BCDToCurrency = False
    Left = 96
    Top = 200
  end
  object qryTranspRedes: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Left = 24
    Top = 200
    object qryTranspRedesTRA_CODTRA: TStringField
      FieldName = 'TRA_CODTRA'
      Required = True
      Size = 5
    end
    object qryTranspRedesTRA_CODCID: TStringField
      FieldName = 'TRA_CODCID'
      Size = 5
    end
    object qryTranspRedesTRA_NOMTRA: TStringField
      FieldName = 'TRA_NOMTRA'
      Size = 40
    end
    object qryTranspRedesTRA_DTACAD: TDateField
      FieldName = 'TRA_DTACAD'
    end
    object qryTranspRedesTRA_ENDERE: TStringField
      FieldName = 'TRA_ENDERE'
      Size = 40
    end
    object qryTranspRedesTRA_BAIRRO: TStringField
      FieldName = 'TRA_BAIRRO'
      Size = 30
    end
    object qryTranspRedesTRA_C_E_P_: TStringField
      FieldName = 'TRA_C_E_P_'
      Size = 9
    end
    object qryTranspRedesTRA_C_G_C_: TStringField
      FieldName = 'TRA_C_G_C_'
      Size = 18
    end
    object qryTranspRedesTRA_I_E_S_: TStringField
      FieldName = 'TRA_I_E_S_'
      Size = 18
    end
    object qryTranspRedesTRA_FONE01: TStringField
      FieldName = 'TRA_FONE01'
      Size = 15
    end
    object qryTranspRedesTRA_FONE02: TStringField
      FieldName = 'TRA_FONE02'
      Size = 15
    end
    object qryTranspRedesTRA_F_A_X_: TStringField
      FieldName = 'TRA_F_A_X_'
      Size = 15
    end
    object qryTranspRedesTRA_NUMPLA: TStringField
      FieldName = 'TRA_NUMPLA'
      Size = 8
    end
    object qryTranspRedesTRA_CONTAT: TStringField
      FieldName = 'TRA_CONTAT'
      Size = 25
    end
    object qryTranspRedesTRA_EMAIL_: TStringField
      FieldName = 'TRA_EMAIL_'
      Size = 60
    end
    object qryTranspRedesTRA_HOMEPA: TStringField
      FieldName = 'TRA_HOMEPA'
      Size = 60
    end
    object qryTranspRedesTRA_CODEMP: TStringField
      FieldName = 'TRA_CODEMP'
      Size = 3
    end
    object qryTranspRedesAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryTranspRedesTRA_NOMFAN: TStringField
      FieldName = 'TRA_NOMFAN'
      Size = 40
    end
    object qryTranspRedesTRA_CGCCPF: TIntegerField
      FieldName = 'TRA_CGCCPF'
    end
    object qryTranspRedesTRA_NOMCID: TStringField
      FieldName = 'TRA_NOMCID'
      Required = True
      Size = 40
    end
  end
  object frxPaginaReforma: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39504.578949363400000000
    ReportOptions.LastChange = 45685.014362256940000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllObservacoesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  //                                      '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPaginaUserFunction
    Left = 24
    Top = 136
    Datasets = <
      item
        DataSet = frxEmpresa
        DataSetName = 'frxEmpresa'
      end
      item
        DataSet = frxPedido
        DataSetName = 'frxPedido'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxTransp
        DataSetName = 'frxTransp'
      end
      item
        DataSet = frxTranspRedesp
        DataSetName = 'frxTranspRedes'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Relatorio: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 2.500000000000000000
      BottomMargin = 2.500000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      OnBeforePrint = 'RelatorioOnBeforePrint'
      object Titulo: TfrxPageHeader
        FillType = ftBrush
        Height = 365.102574560000000000
        Top = 18.897650000000000000
        Width = 774.803650000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        Stretched = True
        object rllImagem: TfrxPictureView
          ShiftMode = smWhenOverlapped
          Left = 12.559060000000000000
          Top = 18.338590000000000000
          Width = 235.472480000000000000
          Height = 94.118120000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object dbEmrpesa: TfrxMemoView
          Left = 262.519790000000000000
          Top = 18.897637800000000000
          Width = 457.323130000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxEmpresa."EMP_NOMEMP"]')
          ParentFont = False
        end
        object dbEnderecoEmpresa: TfrxMemoView
          Left = 262.519790000000000000
          Top = 34.015770000000010000
          Width = 457.323130000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_ENDERE"]')
          ParentFont = False
        end
        object rllPedOrc: TfrxMemoView
          Left = 14.779530000000000000
          Top = 184.795275590000000000
          Width = 438.425480000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pedido de Compra N'#186':')
          ParentFont = False
        end
        object mmNomeCliente: TfrxMemoView
          Left = 14.779530000000000000
          Top = 202.212740000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nome:  ')
          ParentFont = False
        end
        object dbNomeCliente: TfrxMemoView
          Left = 85.811070000000000000
          Top = 202.433210000000000000
          Width = 684.094930000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxPedido."FOR_NOMFOR"]')
          ParentFont = False
        end
        object mmEnderecoCliente: TfrxMemoView
          Left = 14.779530000000000000
          Top = 218.078740160000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object dbEnderecoCliente: TfrxMemoView
          Left = 85.811070000000000000
          Top = 218.078740160000000000
          Width = 366.614410000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."ENDERE"]')
          ParentFont = False
        end
        object mmFoneCliente: TfrxMemoView
          Left = 14.779530000000000000
          Top = 266.921460000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fone:  ')
          ParentFont = False
        end
        object dbBairroCliente: TfrxMemoView
          Left = 526.133863150000000000
          Top = 218.078740160000000000
          Width = 366.614410000000000000
          Height = 15.118110240000000000
          DataField = 'FOR_BAIRRO'
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_BAIRRO"]')
          ParentFont = False
        end
        object dbTelefoneCliente: TfrxMemoView
          Left = 85.811070000000000000
          Top = 266.921460000000000000
          Width = 104.567100000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Length(<frxPedido."FOR_FONE01">) > 0 , fFormataFone(<frxPed' +
              'ido."FOR_FONE01">),'#39#39')]')
          ParentFont = False
        end
        object mmCNPJCliente: TfrxMemoView
          Left = 14.779530000000000000
          Top = 250.582870000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ:  ')
          ParentFont = False
        end
        object dbCNPJCliente: TfrxMemoView
          Left = 85.811070000000000000
          Top = 250.582677170000000000
          Width = 234.330860000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxPedido."FOR_C_G_C_">) > 0 ,'
            
              ' FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxPedido."FOR_C_G_C_' +
              '">),'#39#39')]')
          ParentFont = False
        end
        object mmIECliente: TfrxMemoView
          Left = 453.543307090000000000
          Top = 250.582677170000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'IE:  ')
          ParentFont = False
        end
        object dbIECliente: TfrxMemoView
          Left = 526.133863150000000000
          Top = 250.582677170000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_I_E_S_"]')
          ParentFont = False
        end
        object mmContatoCliente: TfrxMemoView
          Left = 14.779530000000000000
          Top = 314.409710000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Contato:  ')
          ParentFont = False
        end
        object dbContatoCliente: TfrxMemoView
          Left = 85.811070000000000000
          Top = 314.409710000000000000
          Width = 317.480520000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_CONTAT"]')
          ParentFont = False
        end
        object dbBairroEmpresa: TfrxMemoView
          Left = 262.669450000000000000
          Top = 49.133858270000010000
          Width = 457.323130000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_NOMCID"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 203.000000000000000000
          Top = 266.834645670000000000
          Width = 108.567100000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Length(<frxPedido."FOR_FONE02">) > 0 , fFormataFone(<frxPed' +
              'ido."FOR_FONE02">),'#39#39')]')
          ParentFont = False
        end
        object Line22: TfrxLineView
          Left = 1.889763780000000000
          Top = 130.078850000000000000
          Width = 771.023622050000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo14: TfrxMemoView
          Left = 11.338582680000000000
          Top = 134.063080000000000000
          Width = 774.803149610000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Departamento de Compras')
          ParentFont = False
        end
        object rllTituloPedOrc: TfrxMemoView
          Left = 11.338582680000000000
          Top = 157.519790000000000000
          Width = 774.803149610000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Or'#231'amento')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 14.779530000000000000
          Top = 298.204734170000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cond. Pgto.:')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 453.543307090000000000
          Top = 266.834645670000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Aten'#231#227'o:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 453.543307090000000000
          Top = 218.078740160000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 14.779530000000000000
          Top = 234.330708660000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 453.543307090000000000
          Top = 234.330708660000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C.E.P.:')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 453.543307090000000000
          Top = 283.086614170000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Entrega:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 85.811070000000000000
          Top = 234.330708660000000000
          Width = 355.275820000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_NOMCID"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 526.133863150000000000
          Top = 234.330708660000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxPedido."FOR_C_E_P_">) > 0 ,'
            ' FormatMaskText('#39'00000-000;0'#39',<frxPedido."FOR_C_E_P_">),'#39#39')]')
          ParentFont = False
        end
        object mmoConPag: TfrxMemoView
          Left = 82.031540000000000000
          Top = 298.204734170000000000
          Width = 532.913730000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataCondPag(<frxPedido."PCG_CONPAG">)]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 526.133863150000000000
          Top = 266.834655430000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_ATENCA"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 526.133863150000000000
          Top = 283.086614170000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_DTAENT"]')
          ParentFont = False
        end
        object dbFoneEmpresa: TfrxMemoView
          Left = 296.535560000000000000
          Top = 111.748072990000000000
          Width = 117.165359210000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataFone(<frxEmpresa."EMP_FONE01">)]')
          ParentFont = False
        end
        object dbCEPEmpresa: TfrxMemoView
          Left = 262.889920000000000000
          Top = 96.629962750000000000
          Width = 457.323130000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_EMAILC"]')
          ParentFont = False
        end
        object dbFaxEmpresa: TfrxMemoView
          Left = 444.314958190000000000
          Top = 111.748072990000000000
          Width = 136.063009210000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataFone(<frxEmpresa."EMP_F_A_X_">)]')
          ParentFont = False
        end
        object mmFoneEmpresa: TfrxMemoView
          Left = 263.330860000000000000
          Top = 111.748072990000000000
          Width = 30.614173230000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone:')
          ParentFont = False
        end
        object mmFaxEmpresa: TfrxMemoView
          Left = 415.968501500000000000
          Top = 111.748072990000000000
          Width = 26.456710000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fax: ')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 262.787570000000000000
          Top = 81.252010000000000000
          Width = 37.795300000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ:  ')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 302.819110000000000000
          Top = 81.252010000000000000
          Width = 109.606370000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxEmpresa."EMP_C_G_C_">) > 0 ,'
            
              ' FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxEmpresa."EMP_C_G_C' +
              '_">),'#39#39')]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 415.968501500000000000
          Top = 81.630004250000000000
          Width = 18.897650000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE:  ')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 444.314958190000000000
          Top = 81.630004250000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_I_E_S_"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 453.543307090000000000
          Top = 328.819110000000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tipo Frete:')
          ParentFont = False
        end
        object rllTipFre: TfrxMemoView
          Left = 527.354333150000000000
          Top = 328.819110000000000000
          Width = 2834.645669290000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fDescricaoFrete(<frxPedido."PCG_TIPFRE">)]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 14.779530000000000000
          Top = 283.464750000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fax:  ')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 85.811070000000000000
          Top = 283.464750000000000000
          Width = 104.567100000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Length(<frxPedido."FOR_F_A_X_">) > 0, fFormataFone(<frxPedi' +
              'do."FOR_F_A_X_">),'#39#39')]')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 453.543307090000000000
          Top = 313.700990000000000000
          Width = 71.433070870000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Faturamento:')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 526.133863150000000000
          Top = 313.700990000000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF((<frxPedido."PCG_DTAFAT"> = <frxPedido."PCG_DTAENT">) AND (' +
              'STRFATPED = '#39'1'#39'), '#39'IMEDIATO'#39', <frxPedido."PCG_DTAFAT">)]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 262.787570000000000000
          Top = 65.252010000000000000
          Width = 457.323130000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_BAIRRO"] - CEP.: [frxEmpresa."EMP_C_E_P_"]')
          ParentFont = False
        end
        object rllPgtVis: TfrxMemoView
          Left = 617.063390000000000000
          Top = 297.425204170000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PAGTO. A VISTA')
          ParentFont = False
        end
        object mmEspecie: TfrxMemoView
          Left = -113.929190000000000000
          Top = 347.716745350000000000
          Width = 79.370130000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Left = 7.559060000000000000
          Top = 343.937230000000000000
          Width = 71.811030940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ped. Venda.:')
          ParentFont = False
        end
        object Memo80: TfrxMemoView
          Left = 83.929146060000000000
          Top = 344.157700000000000000
          Width = 680.315400000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_PEDVEN"]')
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          Left = 526.134156060000000000
          Top = 184.795275590000000000
          Width = 366.614410000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_CODCMP"] - [frxPedido."COMPRA"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo82: TfrxMemoView
          Left = 453.543307090000000000
          Top = 184.795275590000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Comprador:')
          ParentFont = False
        end
      end
      object Rodape: TfrxPageFooter
        FillType = ftBrush
        Height = 170.417440000000000000
        Top = 1198.111010000000078
        Width = 774.803650000000000000
        object Memo42: TfrxMemoView
          Left = 4.559060000000000000
          Top = 1.913420000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES:')
          ParentFont = False
        end
        object rllObservacoes: TfrxMemoView
          Left = 5.559060000000000000
          Top = 21.574830000000000000
          Width = 763.465060000000000000
          Height = 101.291345910000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10')
          ParentFont = False
          WordWrap = False
        end
        object rllObservacao: TfrxMemoView
          Left = 124.724490000000000000
          Top = 2.897650000000113000
          Width = 634.961040000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = False
        end
        object Line166: TfrxLineView
          Left = 7.118120000000000000
          Top = 21.370130000000000000
          Width = 759.685032050000000000
          Color = clBlack
          Diagonal = True
        end
        object mmCitelSoftware: TfrxMemoView
          Align = baRight
          Left = 442.204502280000000000
          Top = 152.992270000000000000
          Width = 332.599147720000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          ParentFont = False
        end
        object Line14: TfrxLineView
          Align = baWidth
          Top = 151.212740000000000000
          Width = 774.803650000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo47: TfrxMemoView
          Align = baLeft
          Top = 152.992270000000000000
          Width = 374.172962280000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emitido em [Date] '#224's [Time]')
          ParentFont = False
        end
        object mmoMsgPcm: TfrxMemoView
          Left = 2.118120000000000000
          Top = 119.063080000000000000
          Width = 759.685530000000000000
          Height = 14.362204724409450000
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[MSGPCM]')
          ParentFont = False
          WordWrap = False
        end
        object Memo52: TfrxMemoView
          Left = 0.779530000000000000
          Top = 133.944960000000000000
          Width = 721.890230000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MSGPC2]')
          ParentFont = False
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Left = 723.669760000000000000
          Top = 133.944960000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'P'#225'g:[Page#]/[TotalPages#]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object Detalhes: TfrxMasterData
        FillType = ftBrush
        Frame.ShadowWidth = 1.000000000000000000
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Height = 47.244114019999998
        Top = 551.811379999999986
        Width = 774.803650000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        Child = frxPaginaReforma.ChildAplicacao
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object frxRelatorioCODITEM: TfrxMemoView
          Left = 6.338590000000000000
          Top = 1.559059999999931000
          Width = 52.913390710000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PCD_CODITE"]')
          ParentFont = False
        end
        object mmoDescri: TfrxMemoView
          ShiftMode = smDontShift
          Left = 63.708720000000000000
          Top = 1.559059999999931000
          Width = 222.220470000000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataField = 'PCD_DESITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PCD_DESITE"]')
          ParentFont = False
        end
        object mmoUnidade: TfrxMemoView
          Left = 263.818897640000000000
          Top = 18.456710000000040000
          Width = 28.346456690000000000
          Height = 13.228346460000000000
          DataField = 'UNI_SIGUNI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          ParentFont = False
        end
        object mmoDesMar: TfrxMemoView
          Left = 78.661417320000000000
          Top = 18.456710000000040000
          Width = 69.165354330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoCodFabrica: TfrxMemoView
          Left = 152.496062990000000000
          Top = 18.456710000000040000
          Width = 109.606335830000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdIte: TfrxMemoView
          Left = 294.566929130000000000
          Top = 18.456710000000040000
          Width = 45.354333150000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
        end
        object rllPrecoUnit: TfrxMemoView
          Left = 343.212598430000000000
          Top = 18.456710000000040000
          Width = 60.472440940000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          ParentFont = False
        end
        object rllPrecotot: TfrxMemoView
          Left = 520.165354330000000000
          Top = 18.456710000000040000
          Width = 68.031498500000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          ParentFont = False
        end
        object rllIpi: TfrxMemoView
          Left = 592.000000000000000000
          Top = 18.456710000000040000
          Width = 32.125984250000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PCD_PERIPI"]')
          ParentFont = False
        end
        object rllVlIpi: TfrxMemoView
          Left = 628.795275590000000000
          Top = 18.456710000000040000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTIPI"]')
          ParentFont = False
        end
        object rllDesUni: TfrxMemoView
          Left = 407.488188980000000000
          Top = 18.456710000000040000
          Width = 45.354320940000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(1 - (1 - <frxRelatorio."PCD_DESUNI"> / 100) * (1 - <frxRelator' +
              'io."PCD_DESUN2"> / 100) * (1 - <frxRelatorio."PCD_DESUN3"> / 100' +
              ') * (1 - <frxRelatorio."PCD_DESUN4"> / 100) '
            
              '* (1 - <frxRelatorio."PCD_DESUN5"> / 100) * (1 - <frxRelatorio."' +
              'PCD_DESUN6"> / 100)) * 100]')
          ParentFont = False
        end
        object rllUnilIQ: TfrxMemoView
          Left = 456.889763780000000000
          Top = 18.456710000000040000
          Width = 60.472440940000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNILIQ"]')
          ParentFont = False
        end
        object mmoLocFisDes: TfrxMemoView
          Left = 540.354670000000000000
          Top = 1.559059999999931000
          Width = 114.519714330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoLocSupDes: TfrxMemoView
          Left = 666.165740000000000000
          Top = 1.559060000000045000
          Width = 99.401594330000000000
          Height = 13.228346460000000000
          DataField = 'LOCSUP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCSUP"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoCodBarras: TfrxMemoView
          Left = 403.630180000000000000
          Top = 1.779530000000022000
          Width = 129.637834330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODBAR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoDtaEnt: TfrxMemoView
          Left = 6.425196850000000000
          Top = 18.519685040000010000
          Width = 69.165354330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."PCD_DTAENT"]')
          ParentFont = False
        end
        object rllValSub: TfrxMemoView
          Left = 717.976377950000000000
          Top = 18.519685040000010000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."TOTSUB"> > 0, <frxRelatorio."TOTSUB">, <frxR' +
              'elatorio."TOTDAR">)]')
          ParentFont = False
        end
        object rllAlqSub: TfrxMemoView
          Left = 676.756340000000000000
          Top = 18.897650000000110000
          Width = 39.685034490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PCD_PERSUB"]')
          ParentFont = False
        end
        object mmoReferenciaDados: TfrxMemoView
          Left = 295.102350000000000000
          Top = 0.763450000000034400
          Width = 95.622064330000000000
          Height = 13.228346460000000000
          DataField = 'ITE_REFERE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoAstDare: TfrxMemoView
          Left = 766.346940000000000000
          Top = 18.897650000000000000
          Width = 5.669288900000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."TOTDAR"> > 0, '#39'*'#39','#39#39')]')
          ParentFont = False
        end
        object rllValIs: TfrxMemoView
          Left = 718.110700000000000000
          Top = 34.015770000000000000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VAL_IS"]')
          ParentFont = False
        end
        object rllAlqIs: TfrxMemoView
          Left = 676.535870000000000000
          Top = 34.015770000000000000
          Width = 39.685034490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PCD_ALQ_IS"]')
          ParentFont = False
        end
        object rllValIbs: TfrxMemoView
          Left = 628.913385830000000000
          Top = 34.015770000000000000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALIBS"]')
          ParentFont = False
        end
        object rllAlqIbs: TfrxMemoView
          Left = 591.874015750000000000
          Top = 34.015770000000000000
          Width = 32.125984251968500000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PCD_ALQIBS"]')
          ParentFont = False
        end
        object rllValCbs: TfrxMemoView
          Left = 541.228346460000000000
          Top = 34.015770000000000000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALCBS"]')
          ParentFont = False
        end
        object rllAlqCbs: TfrxMemoView
          Left = 502.677165354330700000
          Top = 34.015770000000000000
          Width = 35.905511810000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PCD_ALQCBS"]')
          ParentFont = False
        end
      end
      object TopoMateriais: TfrxHeader
        FillType = ftBrush
        Height = 83.149659999999997
        Top = 445.984540000000000000
        Width = 774.803650000000000000
        ReprintOnNewPage = True
        object sDados: TfrxShapeView
          Left = 3.401574800000000000
          Top = 38.795300000000000000
          Width = 763.464552280000000000
          Height = 18.897637800000000000
        end
        object sDuplicata: TfrxShapeView
          Left = 3.401574800000000000
          Top = 21.000000000000000000
          Width = 763.464552280000000000
          Height = 17.763779530000000000
        end
        object mmDuplicata: TfrxMemoView
          Left = 6.338590000000000000
          Top = 22.677165350000000000
          Width = 41.574800710000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 53.370130000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object sTitulo: TfrxShapeView
          Left = 3.401574800000000000
          Top = 2.000000000000000000
          Width = 763.464552280000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object Memo22: TfrxMemoView
          Left = 7.000000000000000000
          Top = 3.000000000000000000
          Width = 752.125969610000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'MATERIAIS SOLICITADOS')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 56.692950000000000000
          Top = 22.677180000000020000
          Width = 71.811040710000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object mmoUnid: TfrxMemoView
          Left = 265.819110000000000000
          Top = 41.913405350000010000
          Width = 22.677165350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Un.')
          ParentFont = False
        end
        object mmoMarca: TfrxMemoView
          Left = 77.960730000000000000
          Top = 41.913405350000010000
          Width = 69.165354330000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
        end
        object mmoCodFab: TfrxMemoView
          Left = 152.551330000000000000
          Top = 41.913405350000010000
          Width = 109.606335830000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Codigo de F'#225'brica')
          ParentFont = False
        end
        object rllTitQtdIte: TfrxMemoView
          Left = 292.527830000000000000
          Top = 41.913405350000010000
          Width = 45.354333150000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quant.')
          ParentFont = False
        end
        object mmoPreUni: TfrxMemoView
          Left = 342.236550000000000000
          Top = 41.913405350000010000
          Width = 60.472480000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Unit.')
          ParentFont = False
        end
        object mmoPreTot: TfrxMemoView
          Left = 520.268090000000000000
          Top = 41.913405350000010000
          Width = 68.031540000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Total')
          ParentFont = False
        end
        object mmoPerIpi: TfrxMemoView
          Left = 591.976810000000000000
          Top = 41.913405350000010000
          Width = 32.125984250000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% IPI')
          ParentFont = False
        end
        object mmoPreIpi: TfrxMemoView
          Left = 627.787880000000000000
          Top = 41.913405350000010000
          Width = 47.244094490000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. IPI')
          ParentFont = False
        end
        object linUnid: TfrxLineView
          Left = 264.700990000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linMarca: TfrxLineView
          Left = 76.063080000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linCodFab: TfrxLineView
          Left = 149.653680000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linQtdIte: TfrxLineView
          Left = 291.071120000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object LinPreUni: TfrxLineView
          Left = 339.976402360000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPreTot: TfrxLineView
          Left = 519.149970000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPerIpi: TfrxLineView
          Left = 589.858690000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPreIpi: TfrxLineView
          Left = 626.094512600000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPerDesc: TfrxLineView
          Left = 404.622450000000000000
          Top = 38.913419999999970000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoPerDesc: TfrxMemoView
          Left = 406.520100000000000000
          Top = 41.913419999999970000
          Width = 45.354345350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%DESC')
          ParentFont = False
        end
        object mmoVlrLiq: TfrxMemoView
          Left = 455.866827640000000000
          Top = 42.031525349999980000
          Width = 60.472480000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Unit.L'#237'q.')
          ParentFont = False
        end
        object linVlrLiq: TfrxLineView
          Left = 454.606680000000000000
          Top = 38.913419999999970000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoLocFis: TfrxMemoView
          Left = 540.354670000000000000
          Top = 22.677180000000020000
          Width = 114.519714330000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Loc. Fis.')
          ParentFont = False
        end
        object linLocFis: TfrxLineView
          Left = 535.606680000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoLocSup: TfrxMemoView
          Left = 666.165740000000000000
          Top = 22.677180000000020000
          Width = 99.401594330000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Loc. Super Est.')
          ParentFont = False
        end
        object linLocSup: TfrxLineView
          Left = 661.417750000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoCodBar: TfrxMemoView
          Left = 401.189240000000000000
          Top = 22.456709999999990000
          Width = 125.858304330000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo De Barras')
          ParentFont = False
        end
        object linCodBar: TfrxLineView
          Left = 396.850650000000000000
          Top = 20.677180000000020000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoTitDtaEnt: TfrxMemoView
          Left = 4.559060000000000000
          Top = 41.952755910000010000
          Width = 69.165354330000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data Entrega')
          ParentFont = False
        end
        object mmoValSub: TfrxMemoView
          Left = 718.024537400000000000
          Top = 41.913405350000010000
          Width = 47.244094490000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. Sub.')
          ParentFont = False
        end
        object linValSub: TfrxLineView
          Left = 716.331170000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoPerSub: TfrxMemoView
          Left = 678.756340000000000000
          Top = 41.574830000000020000
          Width = 35.905514250000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% Sub')
          ParentFont = False
        end
        object linPerSub: TfrxLineView
          Left = 676.756340000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linReferencia: TfrxLineView
          Left = 291.000000000000000000
          Top = 20.913110000000020000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoReferencia: TfrxMemoView
          Left = 295.102350000000000000
          Top = 22.913110000000020000
          Width = 95.622064330000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Referencia')
          ParentFont = False
        end
        object Shape1: TfrxShapeView
          Left = 3.779530000000000000
          Top = 58.472480000000000000
          Width = 763.464552280000000000
          Height = 18.897637800000000000
        end
        object Memo85: TfrxMemoView
          Left = 590.724800000000000000
          Top = 62.590585350000000000
          Width = 35.905514250000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% IBS')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 627.535870000000000000
          Top = 62.590585350000000000
          Width = 47.244094490000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. IBS')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Left = 589.606680000000000000
          Top = 58.472480000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 625.842502600000000000
          Top = 58.472480000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo87: TfrxMemoView
          Left = 717.772527400000000000
          Top = 62.590585350000000000
          Width = 47.244094490000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. IS')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Left = 716.079160000000000000
          Top = 58.472480000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo88: TfrxMemoView
          Left = 678.504330000000000000
          Top = 62.252010000000000000
          Width = 35.905514250000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% IS')
          ParentFont = False
        end
        object Line7: TfrxLineView
          Left = 676.504330000000000000
          Top = 58.472480000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo89: TfrxMemoView
          Left = 502.677490000000000000
          Top = 62.472480000000000000
          Width = 35.905514250000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%CBS')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 541.268090000000000000
          Top = 62.472480000000000000
          Width = 47.244094490000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. CBS')
          ParentFont = False
        end
        object Line8: TfrxLineView
          Left = 539.693260000000000000
          Top = 58.692950000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 502.118430000000000000
          Top = 58.472480000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object Transportadora: TfrxChild
        FillType = ftBrush
        Height = 102.047251420000000000
        Top = 990.236859999999979
        Width = 774.803650000000000000
        Child = frxPaginaReforma.Comprador
        PrintChildIfInvisible = True
        object Memo31: TfrxMemoView
          Left = 4.535433070000000000
          Top = 2.220469999999978000
          Width = 370.393439610000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TRANSPORTADORA:')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 4.559060000000000000
          Top = 17.456709999999930000
          Width = 370.393940000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_NOMTRA"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 59.559060000000000000
          Top = 32.574830000000130000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_ENDERE"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 59.220470000000000000
          Top = 47.913419999999970000
          Width = 173.858380000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_BAIRRO"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 59.559060000000000000
          Top = 63.047310000000040000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_NOMCID"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 284.771800000000000000
          Top = 48.149660000000150000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxTransp."TRA_C_E_P_">) > 0 ,'
            ' FormatMaskText('#39'00000-000;0'#39',<frxTransp."TRA_C_E_P_">),'#39#39')]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 237.637910000000000000
          Top = 47.149660000000150000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.E.P.:')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 59.559060000000000000
          Top = 78.811069999999740000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_FONE01"]')
          ParentFont = False
        end
        object Line12: TfrxLineView
          Left = 1.889763780000000000
          Top = 96.267779999999680000
          Width = 771.023622050000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo39: TfrxMemoView
          Left = 4.559060000000000000
          Top = 32.574830000000130000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 4.559060000000000000
          Top = 63.047310000000040000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 4.535433070000000000
          Top = 47.913419999999970000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 4.559060000000000000
          Top = 78.811069999999740000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone/Fax:')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 205.000000000000000000
          Top = 78.811069999999740000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_F_A_X_"]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 400.409710000000000000
          Top = 2.267716540000038000
          Width = 366.613909610000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TRANSPORTADOR REDESPACHO:')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 400.653806930000000000
          Top = 17.118120000000090000
          Width = 370.393940000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_NOMTRA"]')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Left = 455.653806930000000000
          Top = 32.236239999999840000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_ENDERE"]')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 455.315216930000000000
          Top = 47.574830000000130000
          Width = 173.858380000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_BAIRRO"]')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 455.653806930000000000
          Top = 62.708720000000200000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_NOMCID"]')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 680.866546930000000000
          Top = 47.811069999999860000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxTranspRedes."TRA_C_E_P_">) > 0 ,'
            
              ' FormatMaskText('#39'00000-000;0'#39',<frxTranspRedes."TRA_C_E_P_">),'#39#39')' +
              ']')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 633.732656930000000000
          Top = 46.811069999999860000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.E.P.:')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 455.653806930000000000
          Top = 78.472479999999910000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_FONE01"]')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 400.653806930000000000
          Top = 32.236239999999840000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 400.653806930000000000
          Top = 62.708720000000200000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 400.630180000000000000
          Top = 47.574830000000130000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Left = 400.653806930000000000
          Top = 78.472479999999910000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone/Fax:')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Left = 601.094746930000000000
          Top = 78.472479999999910000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_F_A_X_"]')
          ParentFont = False
        end
      end
      object LocalEntrega: TfrxChild
        FillType = ftBrush
        Height = 64.251961180000000000
        Top = 903.307670000000030
        Width = 774.803650000000000000
        Child = frxPaginaReforma.Transportadora
        PrintChildIfInvisible = True
        object Memo51: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779530000000022000
          Width = 755.905499610000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOCAL DE ENTREGA:')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 3.803156930000000000
          Top = 17.015769999999970000
          Width = 521.575140000000000000
          Height = 15.118110240000000000
          DataField = 'PCG_NOMENT'
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_NOMENT"]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 71.803156930000000000
          Top = 32.133889999999840000
          Width = 408.189240000000000000
          Height = 15.118110240000000000
          DataField = 'PCG_ENDENT'
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_ENDENT"]')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 71.803156930000000000
          Top = 47.488249999999880000
          Width = 408.189240000000000000
          Height = 15.118110240000000000
          DataField = 'PCG_CIDENT'
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_CIDENT"]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 3.803156930000000000
          Top = 32.133889999999840000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          Left = 3.803156930000000000
          Top = 47.488249999999880000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
      end
      object ChildData: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 1160.315710000000081
        Width = 774.803650000000000000
        object rllData: TfrxMemoView
          Left = 9.117612280000000000
          Width = 740.787880000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
        end
      end
      object ChildAplicacao: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 623.622449999999958
        Width = 774.803650000000000000
        Stretched = True
        object Memo8: TfrxMemoView
          ShiftMode = smDontShift
          Left = 132.283550000000000000
          Width = 632.315263310000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataField = 'ITE_APLFAB'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_APLFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 3.779530000000000000
          Width = 124.724490000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aplica'#231#227'o / C'#243'd. F'#225'brica:')
          ParentFont = False
        end
      end
      object Totais: TfrxReportSummary
        FillType = ftBrush
        Height = 83.149650240000000000
        Top = 699.213049999999953
        Width = 774.803650000000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        Child = frxPaginaReforma.chiIcmDes
        PrintChildIfInvisible = True
        object Line1: TfrxLineView
          Width = 771.023622050000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo25: TfrxMemoView
          Left = 495.496062992126000000
          Top = 4.338589999999954000
          Width = 109.606299210000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Soma dos Itens:')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 234.369902990000000000
          Top = 4.228336689999992000
          Width = 109.606299210000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Soma do I.P.I.:')
          ParentFont = False
        end
        object rllTotalItens: TfrxMemoView
          Left = 608.709108110000000000
          Top = 4.338589999999954000
          Width = 154.960622600000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,Detalhes,2)]')
          ParentFont = False
        end
        object rllTotalIPI: TfrxMemoView
          Left = 347.582948110000000000
          Top = 4.118119999999976000
          Width = 113.385792600000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTIPI">,Detalhes,2)]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 1.559055120000000000
          Top = 41.307054880000010000
          Width = 113.385848740000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Litros:')
          ParentFont = False
        end
        object rllLitragem: TfrxMemoView
          Left = 120.991864800000000000
          Top = 41.307054880000010000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTLIT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo48: TfrxMemoView
          Left = 495.496062992126000000
          Top = 20.700816690000010000
          Width = 109.606299210000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor do Frete:')
          ParentFont = False
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 608.709108110000000000
          Top = 20.700816690000010000
          Width = 154.960629920000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'Memo49OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_VALFRE">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Left = 234.369902990000000000
          Top = 20.236239999999950000
          Width = 109.606299210000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor da Subst:')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalsUB: TfrxMemoView
          Left = 347.582948110000000000
          Top = 20.236239999999950000
          Width = 113.385799920000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'Memo49OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTSUB">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 1.559060000000000000
          Top = 24.543275350000040000
          Width = 113.385848740000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Peso Total:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 120.991864800000000000
          Top = 24.543275350000040000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PESOIT">,Detalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 495.496062992126000000
          Top = 37.708719999999970000
          Width = 109.606299210000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Desp. Acess'#243'rias:')
          ParentFont = False
          WordWrap = False
        end
        object Memo60: TfrxMemoView
          Left = 608.709108110000000000
          Top = 37.708719999999970000
          Width = 154.960629920000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'Memo49OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_DESACE">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 1.559060000000000000
          Top = 7.236239999999953000
          Width = 113.385848740000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tot. Itens Impressos:')
          ParentFont = False
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 120.991864800000000000
          Top = 7.236239999999953000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(Detalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 1.559060000000000000
          Top = 58.252010000000040000
          Width = 113.385848740000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Kilos:')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 120.991869680000000000
          Top = 58.252010000000040000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTKIL"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 234.110390000000000000
          Top = 36.354360000000040000
          Width = 109.606318740000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Subst FCP:')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalSubFCP: TfrxMemoView
          Left = 348.055413460000000000
          Top = 36.354360000000040000
          Width = 113.385799920000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SUBFCP">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoTitDar: TfrxMemoView
          Left = 234.330860000000000000
          Top = 52.692949999999990000
          Width = 109.606318740000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor DARE:')
          ParentFont = False
          WordWrap = False
        end
        object mmoValDar: TfrxMemoView
          Left = 348.275883460000000000
          Top = 52.692949999999990000
          Width = 113.385799920000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTDAR">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoMsgDare: TfrxMemoView
          Left = 347.716760000000000000
          Top = 68.031539999999950000
          Width = 173.858279920000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."TOTDAR">,Detalhes,2) > 0, '#39'(*) Valores d' +
              'a DARE por produto'#39', '#39#39')]')
          ParentFont = False
          WordWrap = False
        end
      end
      object chiTotalPedido: TfrxChild
        FillType = ftBrush
        Height = 20.440940000000000000
        Top = 861.732840000000010
        Width = 774.803650000000000000
        Child = frxPaginaReforma.LocalEntrega
        PrintChildIfInvisible = True
        object Line2: TfrxLineView
          Left = -1.889766220000000000
          Top = 16.661410000000040000
          Width = 771.023622050000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo27: TfrxMemoView
          Left = 495.496062992126000000
          Width = 109.606299212598000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total do Pedido:')
          ParentFont = False
        end
        object rllTotalGeral: TfrxMemoView
          Left = 608.709108110000000000
          Width = 154.960622600000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE"> +<frxRelatorio."TOTIPI"> + <frxRela' +
              'torio."TOTSUB"> + <frxRelatorio."SUBFCP"> - <frxRelatorio."ICMDE' +
              'S">  + <frxRelatorio."VALCBS"> + <frxRelatorio."VALIBS"> + <frxRelatorio."VAL_IS"> ,Detalhes,2) + <frxPedido."PCG_VALFRE">]')
          ParentFont = False
        end
      end
      object chiIcmDes: TfrxChild
        FillType = ftBrush
        Height = 32.125984250000000000
        Top = 805.039890000000014
        Width = 774.803650000000000000
        Child = frxPaginaReforma.chiTotalPedido
        PrintChildIfInvisible = True
        object mmoTitIcmDes: TfrxMemoView
          Left = 495.496062990000000000
          Top = 16.000000000000000000
          Width = 109.606318740000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ICMS Desonerado:')
          ParentFont = False
          WordWrap = False
        end
        object mmoIcmDes: TfrxMemoView
          Left = 609.402043460000000000
          Top = 16.000000000000000000
          Width = 154.960629920000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'Memo49OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ICMDES">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoTitDesPis: TfrxMemoView
          Left = 495.677490000000000000
          Width = 109.606308980000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Desc. PIS/COFINS:')
          ParentFont = False
          WordWrap = False
        end
        object mmoDesPis: TfrxMemoView
          Left = 608.953090310000000000
          Width = 154.960629920000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'Memo49OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESPIS">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Comprador: TfrxChild
        FillType = ftBrush
        Height = 23.566943780000000000
        Top = 1114.961350000000039
        Width = 774.803650000000000000
        Child = frxPaginaReforma.ChildData
        PrintChildIfInvisible = True
        Stretched = True
        object mmoCompra: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779530000000022000
          Width = 755.906000000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxPedido."PCG_COMPRA"]')
          ParentFont = False
        end
      end
    end
  end
  object frxPaginaPaisagemReforma: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39504.578949363400000000
    ReportOptions.LastChange = 44480.443031087960000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllTipFreOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxPedido."PCG_TIPFRE"> = '#39'1'#39' Then'
      '    rllTipFre.Text := '#39'CIF '#39
      '  Else              '
      '    rllTipFre.Text := '#39'FOB '#39
      'end;'
      ''
      'procedure rllObservacoesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  //              '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPaginaUserFunction
    Left = 104
    Top = 136
    Datasets = <
      item
        DataSet = frxEmpresa
        DataSetName = 'frxEmpresa'
      end
      item
        DataSet = frxPedido
        DataSetName = 'frxPedido'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxTransp
        DataSetName = 'frxTransp'
      end
      item
        DataSet = frxTranspRedesp
        DataSetName = 'frxTranspRedes'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Relatorio: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 2.500000000000000000
      BottomMargin = 2.500000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      OnBeforePrint = 'RelatorioOnBeforePrint'
      object Titulo: TfrxPageHeader
        FillType = ftBrush
        Height = 321.260050000000000000
        Top = 18.897650000000000000
        Width = 1103.622760000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        Stretched = True
        object rllImagem: TfrxPictureView
          ShiftMode = smWhenOverlapped
          Left = 12.559060000000000000
          Top = 18.338590000000000000
          Width = 235.472480000000000000
          Height = 94.118120000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object dbEmrpesa: TfrxMemoView
          Left = 262.519790000000000000
          Top = 18.897637795275600000
          Width = 457.323130000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxEmpresa."EMP_NOMEMP"]')
          ParentFont = False
        end
        object dbEnderecoEmpresa: TfrxMemoView
          Left = 262.519790000000000000
          Top = 34.015770000000010000
          Width = 464.882190000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_ENDERE"]')
          ParentFont = False
        end
        object rllPedOrc: TfrxMemoView
          Left = 7.220470000000000000
          Top = 184.795275590000000000
          Width = 415.748300000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pedido de Compra N'#186':')
          ParentFont = False
        end
        object mmNomeCliente: TfrxMemoView
          Left = 7.220470000000000000
          Top = 202.212740000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nome:  ')
          ParentFont = False
        end
        object dbNomeCliente: TfrxMemoView
          Left = 78.252010000000000000
          Top = 201.433210000000000000
          Width = 891.969080000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxPedido."FOR_NOMFOR"]')
          ParentFont = False
        end
        object mmEnderecoCliente: TfrxMemoView
          Left = 7.220470000000000000
          Top = 218.078740160000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object dbEnderecoCliente: TfrxMemoView
          Left = 78.252010000000000000
          Top = 218.078740160000000000
          Width = 343.937230000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."ENDERE"]')
          ParentFont = False
        end
        object mmFoneCliente: TfrxMemoView
          Left = 7.220470000000000000
          Top = 266.921460000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fone:  ')
          ParentFont = False
        end
        object dbBairroCliente: TfrxMemoView
          Left = 501.015743150000000000
          Top = 218.078740160000000000
          Width = 461.102660000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_BAIRRO"]')
          ParentFont = False
        end
        object dbTelefoneCliente: TfrxMemoView
          Left = 78.252010000000000000
          Top = 266.921460000000000000
          Width = 104.567100000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Length(<frxPedido."FOR_FONE01">) > 0, fFormataFone(<frxPedi' +
              'do."FOR_FONE01">),'#39#39')]')
          ParentFont = False
        end
        object mmCNPJCliente: TfrxMemoView
          Left = 7.220470000000000000
          Top = 250.582870000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ:  ')
          ParentFont = False
        end
        object dbCNPJCliente: TfrxMemoView
          Left = 78.252010000000000000
          Top = 250.582677170000000000
          Width = 234.330860000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxPedido."FOR_C_G_C_">) > 0 ,'
            
              ' FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxPedido."FOR_C_G_C_' +
              '">),'#39#39')]')
          ParentFont = False
        end
        object mmIECliente: TfrxMemoView
          Left = 429.425187090000000000
          Top = 234.464557170000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'IE:  ')
          ParentFont = False
        end
        object dbIECliente: TfrxMemoView
          Left = 502.015743150000000000
          Top = 234.464557170000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_I_E_S_"]')
          ParentFont = False
        end
        object mmContatoCliente: TfrxMemoView
          Left = 689.874460000000000000
          Top = 271.086614170000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Contato:  ')
          ParentFont = False
        end
        object dbContatoCliente: TfrxMemoView
          Left = 746.906000000000000000
          Top = 271.086609290000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_CONTAT"]')
          ParentFont = False
        end
        object dbBairroEmpresa: TfrxMemoView
          Left = 731.331170000000000000
          Top = 34.015738270000000000
          Width = 362.834880000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_NOMCID"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 195.440940000000000000
          Top = 266.834645670000000000
          Width = 108.567100000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Length(<frxPedido."FOR_FONE02">) > 0 ,fFormataFone(<frxPedi' +
              'do."FOR_FONE02">),'#39#39')]')
          ParentFont = False
        end
        object Line22: TfrxLineView
          Left = 1.889763779527559000
          Top = 130.078850000000000000
          Width = 1096.062992125984000000
          Color = clBlack
          Diagonal = True
        end
        object Memo14: TfrxMemoView
          Align = baWidth
          Top = 134.063080000000000000
          Width = 1103.622760000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Departamento de Compras')
          ParentFont = False
        end
        object rllTituloPedOrc: TfrxMemoView
          Align = baWidth
          Top = 157.519790000000000000
          Width = 1103.622760000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Or'#231'amento')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 428.748300000000000000
          Top = 287.204734170000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cond. Pgto.:')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 803.598657090000000000
          Top = 251.716525670000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Aten'#231#227'o:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 428.425187090000000000
          Top = 218.078740160000000000
          Width = 56.692910940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 7.220470000000000000
          Top = 233.330708660000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 7.897357090000000000
          Top = 285.110270390000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C.E.P.:')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 622.842627090000000000
          Top = 251.850374170000000000
          Width = 49.133850940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Entrega:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 78.252010000000000000
          Top = 233.196850390000000000
          Width = 249.448980000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."FOR_NOMCID"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 80.487913150000000000
          Top = 285.110270390000000000
          Width = 132.283550000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxPedido."FOR_C_E_P_">) > 0 ,'
            ' FormatMaskText('#39'00000-000;0'#39',<frxPedido."FOR_C_E_P_">),'#39#39')]')
          ParentFont = False
        end
        object mmoConPag: TfrxMemoView
          Left = 497.779840000000000000
          Top = 287.204734170000000000
          Width = 517.795610000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataCondPag(<frxPedido."PCG_CONPAG">)]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 868.189213150000000000
          Top = 251.716535430000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_ATENCA"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 675.433183150000000000
          Top = 251.850374170000000000
          Width = 124.724490000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_DTAENT"]')
          ParentFont = False
        end
        object dbFoneEmpresa: TfrxMemoView
          Left = 296.535560000000000000
          Top = 98.748072990000000000
          Width = 117.165359210000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataFone(<frxEmpresa."EMP_FONE01">)]')
          ParentFont = False
        end
        object dbCEPEmpresa: TfrxMemoView
          Left = 584.149970000000000000
          Top = 98.748082750000000000
          Width = 457.323130000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_EMAILC"]')
          ParentFont = False
        end
        object dbFaxEmpresa: TfrxMemoView
          Left = 444.314958190000000000
          Top = 98.748072990000000000
          Width = 136.063009210000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataFone(<frxEmpresa."EMP_F_A_X_">)]')
          ParentFont = False
        end
        object mmFoneEmpresa: TfrxMemoView
          Left = 263.330860000000000000
          Top = 98.748072990000000000
          Width = 30.614173230000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone:')
          ParentFont = False
        end
        object mmFaxEmpresa: TfrxMemoView
          Left = 415.968501500000000000
          Top = 98.748072990000000000
          Width = 26.456710000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fax: ')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 262.787570000000000000
          Top = 81.252010000000000000
          Width = 37.795300000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ:  ')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 302.819110000000000000
          Top = 81.252010000000000000
          Width = 109.606370000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxEmpresa."EMP_C_G_C_">) > 0 ,'
            
              ' FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxEmpresa."EMP_C_G_C' +
              '_">),'#39#39')]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 415.968501500000000000
          Top = 81.630004250000000000
          Width = 18.897650000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE:  ')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 444.314958190000000000
          Top = 81.630004250000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_I_E_S_"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 944.559680000000000000
          Top = 271.464750000000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tipo Frete:')
          ParentFont = False
        end
        object rllTipFre: TfrxMemoView
          Left = 1009.150236060000000000
          Top = 271.464750000000000000
          Width = 71.811070000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllTipFreOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 429.425187090000000000
          Top = 252.228510000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fax:  ')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 502.015743150000000000
          Top = 252.228510000000000000
          Width = 104.567100000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Length(<frxPedido."FOR_F_A_X_">) > 0, fFormataFone(<frxPedi' +
              'do."FOR_F_A_X_">),'#39#39')]')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 429.425187090000000000
          Top = 271.086614170000000000
          Width = 71.433070870000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Faturamento:')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 502.015743150000000000
          Top = 271.086614170000000000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF((<frxPedido."PCG_DTAFAT"> = <frxPedido."PCG_DTAENT">) AND (' +
              'STRFATPED = '#39'1'#39'), '#39'IMEDIATO'#39', <frxPedido."PCG_DTAFAT">)]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 262.787570000000000000
          Top = 51.252010000000000000
          Width = 521.575140000000000000
          Height = 15.118110240000000000
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_BAIRRO"] - CEP.: [frxEmpresa."EMP_C_E_P_"]')
          ParentFont = False
        end
        object rllPgtVis: TfrxMemoView
          Left = 1015.354980000000000000
          Top = 286.645674170000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PAGTO. A VISTA')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 7.559060000000000000
          Top = 302.362400000000000000
          Width = 71.811030940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ped. Venda.:')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 80.149616060000000000
          Top = 302.362400000000000000
          Width = 1012.914040000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_PEDVEN"]')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 501.015743150000000000
          Top = 184.795275590000000000
          Width = 366.614410000000000000
          Height = 15.118110240000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_CODCMP"] - [frxPedido."COMPRA"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo54: TfrxMemoView
          Left = 428.425187090000000000
          Top = 184.795275590000000000
          Width = 68.031500940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Comprador:')
          ParentFont = False
        end
      end
      object Rodape: TfrxPageFooter
        FillType = ftBrush
        Height = 160.637910000000000000
        Top = 1092.284099209999795
        Width = 1103.622760000000000000
        object mmCitelSoftware: TfrxMemoView
          Align = baRight
          Left = 808.819420000000000000
          Top = 141.740259999999900000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          ParentFont = False
        end
        object Line15: TfrxLineView
          Left = 1.889763780000000000
          Top = 91.181200000000000000
          Width = 1096.062992130000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoMsgPcm: TfrxMemoView
          Align = baWidth
          Top = 93.433210000000030000
          Width = 1103.622760000000000000
          Height = 18.897650000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[MSGPCM]')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 8.338590000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES:')
          ParentFont = False
        end
        object rllObservacoes: TfrxMemoView
          Left = 6.425118740000000000
          Top = 18.661410000000000000
          Width = 1084.725110000000000000
          Height = 68.787401570000000000
          OnBeforePrint = 'rllObservacoesOnBeforePrint'
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7')
          ParentFont = False
          WordWrap = False
        end
        object rllObservacao: TfrxMemoView
          Left = 128.504020000000000000
          Top = 0.984230000000025000
          Width = 963.780150000000000000
          Height = 15.118120000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = False
        end
        object Line28: TfrxLineView
          Align = baWidth
          Top = 134.960729999999900000
          Width = 1103.622760000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo29: TfrxMemoView
          Align = baLeft
          Top = 139.842609999999800000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emitido em [DATE] '#224's [TIME]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Top = 113.385900000000100000
          Width = 1054.488870000000000000
          Height = 18.897650000000000000
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[MSGPC2]')
          ParentFont = False
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Left = 1050.709340000000000000
          Top = 115.385900000000100000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'P'#225'g:[Page#]/[TotalPages#]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object Detalhes: TfrxMasterData
        FillType = ftBrush
        Height = 47.244094490000002
        Top = 502.677438739999957
        Width = 1103.622760000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        Child = frxPaginaPaisagemReforma.ChildAplicacao
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object frxRelatorioCODITEM: TfrxMemoView
          Left = 6.338590000000000000
          Width = 52.913390710000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PCD_CODITE"]')
          ParentFont = False
        end
        object mmoDescri: TfrxMemoView
          ShiftMode = smDontShift
          Left = 63.708720000000000000
          Width = 457.535733310000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataField = 'PCD_DESITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PCD_DESITE"]')
          ParentFont = False
        end
        object mmoUnidade: TfrxMemoView
          Left = 436.519685040000000000
          Top = 16.897650000000000000
          Width = 22.677165350000000000
          Height = 13.228346460000000000
          DataField = 'UNI_SIGUNI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          ParentFont = False
        end
        object mmoDesMar: TfrxMemoView
          Left = 81.661417320000000000
          Top = 16.897650000000000000
          Width = 69.165354330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoCodFabrica: TfrxMemoView
          Left = 154.385826770000000000
          Top = 16.897650000000000000
          Width = 113.385865830000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdIte: TfrxMemoView
          Left = 610.275590550000000000
          Top = 16.897650000000000000
          Width = 45.354333150000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
        end
        object rllPrecoUnit: TfrxMemoView
          Left = 660.921259840000000000
          Top = 16.897650000000000000
          Width = 60.472480000000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          ParentFont = False
        end
        object rllPrecotot: TfrxMemoView
          Left = 839.874015750000000000
          Top = 16.897650000000000000
          Width = 68.031540000000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          ParentFont = False
        end
        object rllIpi: TfrxMemoView
          Left = 912.708661420000000000
          Top = 16.897650000000000000
          Width = 32.125984250000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PCD_PERIPI"]')
          ParentFont = False
        end
        object rllVlIpi: TfrxMemoView
          Left = 950.503937010000000000
          Top = 16.897650000000000000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTIPI"]')
          ParentFont = False
        end
        object rllDesUni: TfrxMemoView
          Left = 724.196850390000000000
          Top = 16.897650000000000000
          Width = 45.354345350000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(1 - (1 - <frxRelatorio."PCD_DESUNI"> / 100) * (1 - <frxRelator' +
              'io."PCD_DESUN2"> / 100) * (1 - <frxRelatorio."PCD_DESUN3"> / 100' +
              ') * (1 - <frxRelatorio."PCD_DESUN4"> / 100) '
            
              '* (1 - <frxRelatorio."PCD_DESUN5"> / 100) * (1 - <frxRelatorio."' +
              'PCD_DESUN6"> / 100)) * 100]')
          ParentFont = False
        end
        object rllUnilIQ: TfrxMemoView
          Left = 777.598425200000000000
          Top = 16.897650000000000000
          Width = 60.472480000000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNILIQ"]')
          ParentFont = False
        end
        object mmoCodBarras: TfrxMemoView
          Left = 271.842519690000000000
          Top = 16.897650000000000000
          Width = 158.740225830000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODBAR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoUnidEmbDes: TfrxMemoView
          Left = 464.157480310000000000
          Top = 16.897650000000000000
          Width = 56.692935350000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SIGEMB"]')
          ParentFont = False
        end
        object mmoQtdEmbDes: TfrxMemoView
          Left = 526.299212600000000000
          Top = 16.897650000000000000
          Width = 79.370115350000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_EMBALA"]')
          ParentFont = False
        end
        object mmoLocFisDes: TfrxMemoView
          Left = 806.055660000000000000
          Width = 159.874074330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoLocSupDes: TfrxMemoView
          Left = 979.111010000000000000
          Width = 106.960654330000000000
          Height = 13.228346460000000000
          DataField = 'LOCSUP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCSUP"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoDtaEnt: TfrxMemoView
          Left = 6.425196850000000000
          Top = 17.007874019999970000
          Width = 69.165354330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."PCD_DTAENT"]')
          ParentFont = False
        end
        object rllValSub: TfrxMemoView
          Left = 1045.795275590000000000
          Top = 17.118119999999980000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTSUB"]')
          ParentFont = False
        end
        object rllAlqSub: TfrxMemoView
          Left = 998.795920000000000000
          Top = 16.897650000000000000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PCD_PERSUB"]')
          ParentFont = False
        end
        object mmoReferenciaDados: TfrxMemoView
          Left = 638.000000000000000000
          Top = 1.338279999999997000
          Width = 159.874074330000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoValDarIte: TfrxMemoView
          Left = 566.173228350000000000
          Top = 1.511811019999982000
          Width = 62.362204720000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTDAR"]')
          ParentFont = False
        end
        object rllAlqCbs: TfrxMemoView
          Left = 821.102362200000
          Top = 34.015770000000
          Width = 35.905511810000
          Height = 13.228346460000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PCD_ALQCBS"]')
          ParentFont = False
        end
        object rllValCbs: TfrxMemoView
          Left = 860.787401570000
          Top = 34.015770000000
          Width = 47.244094490000
          Height = 13.228346460000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALCBS"]')
          ParentFont = False
        end
        object rllAlqIbs: TfrxMemoView
          Left = 911.055118110000
          Top = 34.015770000000
          Width = 35.905511810000
          Height = 13.228346460000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PCD_ALQIBS"]')
          ParentFont = False
        end
        object rllValIbs: TfrxMemoView
          Left = 950.503937010000
          Top = 34.015770000000
          Width = 47.244094490000
          Height = 13.228346460000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALIBS"]')
          ParentFont = False
        end
        object rllAlqIs: TfrxMemoView
          Left = 1003.692913390000
          Top = 34.015770000000
          Width = 35.905511810000
          Height = 13.228346460000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PCD_ALQ_IS"]')
          ParentFont = False
        end
        object rllValIs: TfrxMemoView
          Left = 1045.795275590000
          Top = 34.015770000000
          Width = 47.244094490000
          Height = 13.228346460000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VAL_IS"]')
          ParentFont = False
        end
      end
      object Totais: TfrxReportSummary
        FillType = ftBrush
        Height = 139.724490000000000000
        Top = 650.079089210000006
        Width = 1103.622760000000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        Child = frxPaginaPaisagemReforma.LocalEntrega
        object Shape2: TfrxShapeView
          Left = 7.118120000000000000
          Top = 4.118110239999965000
          Width = 1092.284170000000000000
          Height = 105.826840000000000000
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 0.338589999999953800
          Width = 1103.622760000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 139.724490000000000000
          Width = 1103.622760000000000000
          Color = clBlack
          Diagonal = True
        end
        object rllTotalItens: TfrxMemoView
          Left = 959.764458110000000000
          Top = 26.834645669999990000
          Width = 132.283442600000000000
          Height = 18.897637795275590000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,Detalhes,2)]')
          ParentFont = False
        end
        object rllTotalIPI: TfrxMemoView
          Left = 792.465138110000000000
          Top = 82.393700787401600000
          Width = 75.590492600000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTIPI">,Detalhes,2)]')
          ParentFont = False
        end
        object rllTotalGeral: TfrxMemoView
          Left = 959.764458110000000000
          Top = 82.393700787401600000
          Width = 132.283442600000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'rllTotalGeralOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE"> +<frxRelatorio."TOTIPI"> + <frxRela' +
              'torio."TOTSUB">  + <frxRelatorio."VALCBS"> + <frxRelatorio."VALIBS"> + <frxRelatorio."VAL_IS"> ,Detalhes,2) + <frxPedido."PCG_VALFRE">]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 188.535555120000000000
          Top = 118.338594880000000000
          Width = 79.370078740000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Litros:')
          ParentFont = False
        end
        object rllLitragem: TfrxMemoView
          Left = 270.173064800000000000
          Top = 118.338594880000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTLIT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 375.889605120000000000
          Top = 82.377996690000030000
          Width = 120.944859920000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo49OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_VALFRE">]')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalsUB: TfrxMemoView
          Left = 701.393647090000000000
          Top = 26.834645669999990000
          Width = 79.370081180000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTSUB">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 5.118120000000000000
          Top = 118.472465350000000000
          Width = 79.370078740000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Peso Total:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 86.755624800000000000
          Top = 118.472465350000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PESOIT">,Detalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo60: TfrxMemoView
          Left = 506.173155120000000000
          Top = 82.393700790000030000
          Width = 102.047209920000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo49OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_DESACE">]')
          ParentFont = False
          WordWrap = False
        end
        object Line19: TfrxLineView
          Left = 369.968770000000006
          Top = 57.031539999999950000
          Width = 729.433520000000044
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line20: TfrxLineView
          Left = 133.622140000000000000
          Top = 4.118119999999976000
          Height = 105.826840000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line21: TfrxLineView
          Left = 249.905690000000000000
          Top = 4.118119999999976000
          Height = 105.826840000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line23: TfrxLineView
          Left = 369.968770000000000000
          Top = 4.118119999999976000
          Height = 105.826840000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line24: TfrxLineView
          Left = 502.724800000000000000
          Top = 4.118119999999976000
          Height = 105.826840000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line25: TfrxLineView
          Left = 785.803650000000000000
          Top = 4.118119999999976000
          Height = 105.826840000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line26: TfrxLineView
          Left = 954.323440000000000000
          Top = 4.118119999999976000
          Height = 105.826840000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo41: TfrxMemoView
          Left = 375.527830000000000000
          Top = 7.897649999999999000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'BASE C'#193'LCULO ICMS')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 375.527830000000000000
          Top = 60.811069999999970000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DO FRETE')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 959.559680000000000000
          Top = 7.897649999999999000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOS PRODUTOS')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          Left = 959.559680000000000000
          Top = 60.850393700787430000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO PEDIDO')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 701.213050000000000000
          Top = 7.897649999999999000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ICMS SUBST.')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 792.362710000000000000
          Top = 60.850393700787430000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DO IPI')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 701.527559060000000000
          Top = 60.811069999999970000
          Width = 79.370081180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'BASE C. IPI')
          ParentFont = False
        end
        object Line27: TfrxLineView
          Left = 613.740570000000000000
          Top = 4.118119999999976000
          Height = 105.826840000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo75: TfrxMemoView
          Left = 505.795610000000000000
          Top = 7.897649999999999000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DO ICMS')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 505.795610000000000000
          Top = 60.811069999999970000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESP.ACESS'#211'R.')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 701.527559060000000000
          Top = 82.393700790000030000
          Width = 79.370081180000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_BASIPI">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 505.795610000000000000
          Top = 26.795300000000000000
          Width = 102.047209920000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_VALICM">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 375.512060000000000000
          Top = 26.795300000000000000
          Width = 120.944859920000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_BASICM">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 373.953000000000000000
          Top = 118.165430000000000000
          Width = 79.370078740000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Kilos:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 455.590509680000000000
          Top = 118.165430000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTKIL"]')
          ParentFont = False
          WordWrap = False
        end
        object linIcmDes: TfrxLineView
          Left = 871.291900000000000000
          Top = 4.157446140000047000
          Height = 105.448853070000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoIcmDes: TfrxMemoView
          Left = 875.173858110000000000
          Top = 82.393700787401600000
          Width = 75.590492600000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ICMDES">,Detalhes,2)]')
          ParentFont = False
        end
        object mmoTitIcmDes: TfrxMemoView
          Left = 875.071430000000000000
          Top = 60.850393700787430000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ICMS DESON.')
          ParentFont = False
        end
        object mmoTitDesPis: TfrxMemoView
          Left = 875.071430000000000000
          Top = 7.937007870000003000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DES. PIS/COF')
          ParentFont = False
        end
        object mmoDesPis: TfrxMemoView
          Left = 875.071430000000000000
          Top = 26.834645669999990000
          Width = 75.590492600000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESPIS">,Detalhes,2)]')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Left = 694.992580000000000000
          Top = 3.779530000000022000
          Height = 105.826771650000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object rllTotalSubFCP: TfrxMemoView
          Left = 788.322785830000000000
          Top = 30.456710000000040000
          Width = 80.503937010000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SUBFCP">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 788.142240000000000000
          Top = 7.559060000000045000
          Width = 80.503937010000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ICMS SUB FCP')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 619.237018660000000000
          Top = 7.937007874015762000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'B. ICMS SUB')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 619.063390000000000000
          Top = 26.834645669291380000
          Width = 71.810974800000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_BASSUB">]')
          ParentFont = False
          WordWrap = False
        end
        object mmoTitDar: TfrxMemoView
          Left = 619.237018660000000000
          Top = 60.850393700000040000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DARE')
          ParentFont = False
        end
        object mmoValDar: TfrxMemoView
          Left = 619.063390000000000000
          Top = 82.393700790000000000
          Width = 71.810974800000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PCG_TOTDAR">]')
          ParentFont = False
          WordWrap = False
        end
        object linTotCbsIbs: TfrxLineView
          Left = 7.118120000000000
          Top = 39.393733333333
          Width = 362.850650000000030
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object linTotIbsIs: TfrxLineView
          Left = 7.118120000000000
          Top = 74.669346666667
          Width = 362.850650000000030
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object mmoTitBasCbs: TfrxMemoView
          Left = 8.897650000000
          Top = 5.618120000000
          Width = 120.944960000000
          Height = 15.118120000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'BASE C'#193'LC. CBS')
          ParentFont = False
        end
        object mmoBasCbs: TfrxMemoView
          Left = 8.897650000000
          Top = 20.118120000000
          Width = 120.944859920000
          Height = 18.897650000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASCBS">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoTitTotAlqCbs: TfrxMemoView
          Left = 137.401574800000
          Top = 5.618120000000
          Width = 105.826739920000
          Height = 15.118120000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'AL'#205'QUOTA CBS')
          ParentFont = False
        end
        object mmoTotAlqCbs: TfrxMemoView
          Left = 137.401574800000
          Top = 20.118120000000
          Width = 105.826739920000
          Height = 18.897650000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."VALCBS">,Detalhes,2) * 100 / ' +
              '(SUM(<frxRelatorio."BASCBS">,Detalhes,2) + IIF(SUM(<frxRelatorio."BASCBS">,Detalhes,2) = 0, 1, 0))]')
          ParentFont = False
          WordWrap = False
        end
        object mmoTitTotValCbs: TfrxMemoView
          Left = 254.803340000000
          Top = 5.618120000000
          Width = 109.606370000000
          Height = 15.118120000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DO CBS')
          ParentFont = False
        end
        object mmoTotValCbs: TfrxMemoView
          Left = 254.567410000000
          Top = 20.118120000000
          Width = 109.606299210000
          Height = 18.897650000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALCBS">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoTitBasIbs: TfrxMemoView
          Left = 8.897650000000
          Top = 40.893733333333
          Width = 120.944960000000
          Height = 15.118120000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'BASE C'#193'LC. IBS')
          ParentFont = False
        end
        object mmoBasIbs: TfrxMemoView
          Left = 8.897650000000
          Top = 55.393733333333
          Width = 120.944859920000
          Height = 18.897650000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIBS">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoTitTotAlqIbs: TfrxMemoView
          Left = 137.401574800000
          Top = 40.893733333333
          Width = 105.826739920000
          Height = 15.118120000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'AL'#205'QUOTA IBS')
          ParentFont = False
        end
        object mmoTotAlqIbs: TfrxMemoView
          Left = 137.401574800000
          Top = 55.393733333333
          Width = 105.826739920000
          Height = 18.897650000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."VALIBS">,Detalhes,2) * 100 / ' +
              '(SUM(<frxRelatorio."BASIBS">,Detalhes,2) + IIF(SUM(<frxRelatorio."BASIBS">,Detalhes,2) = 0, 1, 0))]')
          ParentFont = False
          WordWrap = False
        end
        object mmoTitTotValIbs: TfrxMemoView
          Left = 254.803340000000
          Top = 40.893733333333
          Width = 109.606370000000
          Height = 15.118120000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DO IBS')
          ParentFont = False
        end
        object mmoTotValIbs: TfrxMemoView
          Left = 254.567410000000
          Top = 55.393733333333
          Width = 109.606299210000
          Height = 18.897650000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIBS">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoTitBasIs: TfrxMemoView
          Left = 8.897650000000
          Top = 76.169346666667
          Width = 120.944960000000
          Height = 15.118120000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'BASE C'#193'LC. IS')
          ParentFont = False
        end
        object mmoBasIs: TfrxMemoView
          Left = 8.897650000000
          Top = 90.669346666667
          Width = 120.944859920000
          Height = 18.897650000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BAS_IS">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoTitTotAlqIs: TfrxMemoView
          Left = 137.401574800000
          Top = 76.169346666667
          Width = 105.826739920000
          Height = 15.118120000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'AL'#205'QUOTA IS')
          ParentFont = False
        end
        object mmoTotAlqIs: TfrxMemoView
          Left = 137.401574800000
          Top = 90.669346666667
          Width = 105.826739920000
          Height = 18.897650000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."VAL_IS">,Detalhes,2) * 100 / ' +
              '(SUM(<frxRelatorio."BAS_IS">,Detalhes,2) + IIF(SUM(<frxRelatorio."BAS_IS">,Detalhes,2) = 0, 1, 0))]')
          ParentFont = False
          WordWrap = False
        end
        object mmoTitTotValIs: TfrxMemoView
          Left = 254.803340000000
          Top = 76.169346666667
          Width = 109.606370000000
          Height = 15.118120000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DO IS')
          ParentFont = False
        end
        object mmoTotValIs: TfrxMemoView
          Left = 254.567410000000
          Top = 90.669346666667
          Width = 109.606299210000
          Height = 18.897650000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VAL_IS">,Detalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object TopoMateriais: TfrxHeader
        FillType = ftBrush
        Height = 79.370078739999997
        Top = 400.630180000000000000
        Width = 1103.622760000000000000
        ReprintOnNewPage = True
        object sDados: TfrxShapeView
          Left = 2.000000000000000000
          Top = 38.574830000000020000
          Width = 1094.173211260000000000
          Height = 18.897637800000000000
        end
        object sTitulo: TfrxShapeView
          Left = 2.000000000000000000
          Width = 1094.173211260000000000
          Height = 20.787389370000000000
          Fill.BackColor = clSilver
        end
        object sDuplicata: TfrxShapeView
          Left = 2.000000000000000000
          Top = 21.000000000000000000
          Width = 1094.173211260000000000
          Height = 17.763779530000000000
        end
        object mmDuplicata: TfrxMemoView
          Left = 6.338590000000000000
          Top = 22.677165350000000000
          Width = 41.574800710000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 53.000000000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo22: TfrxMemoView
          Left = 7.000000000000000000
          Top = 2.000000000000000000
          Width = 1084.724609610000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'MATERIAIS SOLICITADOS')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 56.692950000000000000
          Top = 22.677180000000020000
          Width = 71.811040710000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object mmoUnid: TfrxMemoView
          Left = 436.496290000000000000
          Top = 41.913405350000010000
          Width = 22.677165350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Un.')
          ParentFont = False
        end
        object mmoMarca: TfrxMemoView
          Left = 81.637910000000000000
          Top = 41.913405350000010000
          Width = 69.165354330000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
        end
        object mmoCodFab: TfrxMemoView
          Left = 154.228510000000000000
          Top = 41.913405350000010000
          Width = 113.385865830000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Codigo de F'#225'brica')
          ParentFont = False
        end
        object rllTitQtdIte: TfrxMemoView
          Left = 610.205010000000000000
          Top = 41.913405350000010000
          Width = 45.354333150000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quant.')
          ParentFont = False
        end
        object mmoPreUni: TfrxMemoView
          Left = 659.913730000000000000
          Top = 41.913405350000010000
          Width = 60.472480000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Unit.')
          ParentFont = False
        end
        object mmoPreTot: TfrxMemoView
          Left = 838.945270000000000000
          Top = 41.913405350000010000
          Width = 68.031540000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Total')
          ParentFont = False
        end
        object mmoPerIpi: TfrxMemoView
          Left = 912.653990000000000000
          Top = 41.913405350000010000
          Width = 32.125984250000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% IPI')
          ParentFont = False
        end
        object mmoPreIpi: TfrxMemoView
          Left = 950.465060000000000000
          Top = 41.913405350000010000
          Width = 47.244094490000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. IPI')
          ParentFont = False
        end
        object linCodBar: TfrxLineView
          Left = 269.378170000000000000
          Top = 39.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linMarca: TfrxLineView
          Left = 79.740260000000000000
          Top = 39.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linCodFab: TfrxLineView
          Left = 152.330860000000000000
          Top = 39.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linUnidEmb: TfrxLineView
          Left = 461.748300000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPreUni: TfrxLineView
          Left = 657.653582360000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPreTot: TfrxLineView
          Left = 836.827150000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPerIpi: TfrxLineView
          Left = 909.535870000000000000
          Top = 39.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPreIpi: TfrxLineView
          Left = 947.771692600000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linPerDesc: TfrxLineView
          Left = 722.299630000000000000
          Top = 38.685039370000030000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoPerDesc: TfrxMemoView
          Left = 724.197280000000000000
          Top = 41.913419999999970000
          Width = 45.354345350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%DESC')
          ParentFont = False
        end
        object mmoVlrLiq: TfrxMemoView
          Left = 773.544007640000000000
          Top = 42.031525349999980000
          Width = 60.472480000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Unit.L'#237'q.')
          ParentFont = False
        end
        object linVlrLiq: TfrxLineView
          Left = 771.283860000000000000
          Top = 38.913419999999970000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoCodBar: TfrxMemoView
          Left = 271.834880000000000000
          Top = 41.952768110000020000
          Width = 158.740225830000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Codigo de Barras')
          ParentFont = False
        end
        object linUnid: TfrxLineView
          Left = 434.354670000000000000
          Top = 39.574830000000020000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoUnidEmb: TfrxMemoView
          Left = 464.149970000000000000
          Top = 41.913405350000010000
          Width = 56.692935350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Un.Emb.')
          ParentFont = False
        end
        object linQtdEmb: TfrxLineView
          Left = 523.401980000000000000
          Top = 38.795300000000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoQtdEmb: TfrxMemoView
          Left = 526.401980000000000000
          Top = 41.692935350000030000
          Width = 79.370115350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Quant.Emb.')
          ParentFont = False
        end
        object linQtdIte: TfrxLineView
          Left = 607.653990000000000000
          Top = 39.574830000000020000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmEspecie: TfrxMemoView
          Left = -113.929190000000000000
          Top = 22.614395350000000000
          Width = 79.370130000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object mmoLocFis: TfrxMemoView
          Left = 810.055660000000000000
          Top = 23.015755350000010000
          Width = 159.874074330000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Loc. Fis.')
          ParentFont = False
        end
        object linLocFis: TfrxLineView
          Left = 807.299630000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoLocSup: TfrxMemoView
          Left = 979.111010000000000000
          Top = 23.015755350000010000
          Width = 106.960654330000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Loc. Super Est.')
          ParentFont = False
        end
        object linLocSup: TfrxLineView
          Left = 976.354980000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoTitDtaEnt: TfrxMemoView
          Left = 6.425196850000000000
          Top = 41.952755910000010000
          Width = 69.165354330000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data Entrega')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 1045.843647400000000000
          Top = 41.692935350000030000
          Width = 47.244094490000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. Sub.')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Left = 1043.150280000000000000
          Top = 39.574830000000020000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoPerSub: TfrxMemoView
          Left = 1003.693570000000000000
          Top = 41.692935350000030000
          Width = 35.905514250000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% Sub')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Left = 1000.575450000000000000
          Top = 39.574830000000020000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoReferencia: TfrxMemoView
          Left = 638.000000000000000000
          Top = 23.487939999999980000
          Width = 159.874074330000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Referencia')
          ParentFont = False
        end
        object linReferencia: TfrxLineView
          Left = 632.000000000000000000
          Top = 20.487939999999980000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoTitDarIte: TfrxMemoView
          Left = 566.149970000000000000
          Top = 22.897650000000000000
          Width = 62.362214490000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. DARE'
            ''
            '')
          ParentFont = False
        end
        object shpReforma: TfrxShapeView
          Left = 2.000000000000
          Top = 57.472467800000
          Width = 1094.173211260000
          Height = 18.897637800000
        end
        object linAlqCbs: TfrxLineView
          Left = 819.212598430000
          Top = 57.692467800000
          Height = 18.141732280000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoTitAlqCbs: TfrxMemoView
          Left = 821.102362200000
          Top = 60.812467800000
          Width = 35.905511810000
          Height = 13.606299210000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%CBS')
          ParentFont = False
        end
        object linValCbs: TfrxLineView
          Left = 858.897637800000
          Top = 57.692467800000
          Height = 18.141732280000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoTitValCbs: TfrxMemoView
          Left = 860.787401570000
          Top = 60.812467800000
          Width = 47.244094490000
          Height = 13.606299210000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. CBS')
          ParentFont = False
        end
        object linAlqIbs: TfrxLineView
          Left = 909.543307090000
          Top = 57.692467800000
          Height = 18.141732280000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoTitAlqIbs: TfrxMemoView
          Left = 911.055118110000
          Top = 60.812467800000
          Width = 35.905511810000
          Height = 13.606299210000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%IBS')
          ParentFont = False
        end
        object linValIbs: TfrxLineView
          Left = 947.771692600000
          Top = 57.692467800000
          Height = 18.141732280000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoTitValIbs: TfrxMemoView
          Left = 950.503937010000
          Top = 60.812467800000
          Width = 47.244094490000
          Height = 13.606299210000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. IBS')
          ParentFont = False
        end
        object linAlqIs: TfrxLineView
          Left = 1000.582677170000
          Top = 57.692467800000
          Height = 18.141732280000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoTitAlqIs: TfrxMemoView
          Left = 1003.692913390000
          Top = 60.812467800000
          Width = 35.905511810000
          Height = 13.606299210000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%IS')
          ParentFont = False
        end
        object linValIs: TfrxLineView
          Left = 1043.149606300000
          Top = 57.692467800000
          Height = 18.141732280000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoTitValIs: TfrxMemoView
          Left = 1045.795275590000
          Top = 60.812467800000
          Width = 47.244094490000
          Height = 13.606299210000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. IS')
          ParentFont = False
        end
      end
      object Transportadora: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 891.969009209999967
        Width = 1103.622760000000000000
        Child = frxPaginaPaisagemReforma.Comprador
        PrintChildIfInvisible = True
        object Line12: TfrxLineView
          Align = baWidth
          Top = 98.622140000000000000
          Width = 1103.622760000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo67: TfrxMemoView
          Left = 6.425199290000000000
          Width = 370.393439610000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TRANSPORTADORA:')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Left = 6.448826220000000000
          Top = 15.236240000000000000
          Width = 370.393940000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_NOMTRA"]')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 61.448826220000000000
          Top = 30.354360000000000000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_ENDERE"]')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 61.110236220000000000
          Top = 45.692950000000000000
          Width = 173.858380000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_BAIRRO"]')
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          Left = 61.448826220000000000
          Top = 60.826840000000000000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_NOMCID"]')
          ParentFont = False
        end
        object Memo84: TfrxMemoView
          Left = 286.661566220000000000
          Top = 45.929190000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxTransp."TRA_C_E_P_">) > 0 ,'
            ' FormatMaskText('#39'00000-000;0'#39',<frxTransp."TRA_C_E_P_">),'#39#39')]')
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Left = 239.527676220000000000
          Top = 44.929190000000000000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.E.P.:')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 61.448826220000000000
          Top = 76.590600000000000000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_FONE01"]')
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          Left = 6.448826220000000000
          Top = 30.354360000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          Left = 6.448826220000000000
          Top = 60.826840000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 6.425199290000000000
          Top = 45.692950000000000000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 6.448826220000000000
          Top = 76.590600000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone/Fax:')
          ParentFont = False
        end
        object Memo91: TfrxMemoView
          Left = 206.889766220000000000
          Top = 76.590600000000000000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_F_A_X_"]')
          ParentFont = False
        end
        object Memo92: TfrxMemoView
          Left = 553.480676220000000000
          Top = 0.047246540000000000
          Width = 366.613909610000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TRANSPORTADOR REDESPACHO:')
          ParentFont = False
        end
        object Memo93: TfrxMemoView
          Left = 553.724773150000000000
          Top = 14.897650000000000000
          Width = 370.393940000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_NOMTRA"]')
          ParentFont = False
        end
        object Memo94: TfrxMemoView
          Left = 608.724773150000000000
          Top = 30.015770000000000000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_ENDERE"]')
          ParentFont = False
        end
        object Memo95: TfrxMemoView
          Left = 608.386183150000000000
          Top = 45.354360000000000000
          Width = 173.858380000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_BAIRRO"]')
          ParentFont = False
        end
        object Memo96: TfrxMemoView
          Left = 608.724773150000000000
          Top = 60.488250000000000000
          Width = 315.590551180000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_NOMCID"]')
          ParentFont = False
        end
        object Memo97: TfrxMemoView
          Left = 833.937513150000000000
          Top = 45.590600000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxTranspRedes."TRA_C_E_P_">) > 0 ,'
            
              ' FormatMaskText('#39'00000-000;0'#39',<frxTranspRedes."TRA_C_E_P_">),'#39#39')' +
              ']')
          ParentFont = False
        end
        object Memo98: TfrxMemoView
          Left = 786.803623150000000000
          Top = 44.590600000000000000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.E.P.:')
          ParentFont = False
        end
        object Memo99: TfrxMemoView
          Left = 608.724773150000000000
          Top = 76.252010000000000000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_FONE01"]')
          ParentFont = False
        end
        object Memo100: TfrxMemoView
          Left = 553.724773150000000000
          Top = 30.015770000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          Left = 553.724773150000000000
          Top = 60.488250000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          Left = 553.701146220000000000
          Top = 45.354360000000000000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo103: TfrxMemoView
          Left = 553.724773150000000000
          Top = 76.252010000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone/Fax:')
          ParentFont = False
        end
        object Memo104: TfrxMemoView
          Left = 754.165713150000000000
          Top = 76.252010000000000000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTranspRedes."TRA_F_A_X_"]')
          ParentFont = False
        end
      end
      object LocalEntrega: TfrxChild
        FillType = ftBrush
        Height = 54.692950000000010000
        Top = 812.598879209999950
        Width = 1103.622760000000000000
        Child = frxPaginaPaisagemReforma.Transportadora
        PrintChildIfInvisible = True
        object Memo62: TfrxMemoView
          Left = 3.803156930000000000
          Top = 21.015769999999970000
          Width = 1088.504640000000000000
          Height = 15.118110240000000000
          DataField = 'PCG_NOMENT'
          DataSet = frxPedido
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_NOMENT"]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 778.582679610000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOCAL DE ENTREGA:')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 3.803156930000000000
          Top = 37.133889999999950000
          Width = 1088.504640000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Endere'#231'o: [frxPedido."PCG_ENDENT"] Munic'#237'pio: [frxPedido."PCG_CI' +
              'DENT"]')
          ParentFont = False
        end
        object Line18: TfrxLineView
          Align = baWidth
          Top = 54.692949999999990000
          Width = 1103.622760000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Comprador: TfrxChild
        FillType = ftBrush
        Height = 16.007883780000000000
        Top = 1016.693499210000027
        Width = 1103.622760000000000000
        Child = frxPaginaPaisagemReforma.ChildData
        PrintChildIfInvisible = True
        Stretched = True
        object mmoCompra: TfrxMemoView
          Left = 4.535433070000000000
          Top = 0.889763779999952900
          Width = 782.362710000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxPedido."PCG_COMPRA"]')
          ParentFont = False
        end
      end
      object ChildData: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 1054.488799210000025
        Width = 1103.622760000000000000
        PrintChildIfInvisible = True
        object rllData: TfrxMemoView
          Align = baCenter
          Left = -9.448825000000000000
          Width = 1122.520410000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
      end
      object ChildAplicacao: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 574.488489210000012
        Width = 1103.622760000000000000
        Stretched = True
        object Memo81: TfrxMemoView
          ShiftMode = smDontShift
          Left = 132.283550000000000000
          Width = 1112.315573310000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataField = 'ITE_APLFAB'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_APLFAB"]')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Left = 3.779530000000000000
          Width = 124.724490000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aplica'#231#227'o / C'#243'd. F'#225'brica:')
          ParentFont = False
        end
      end
    end
  end
end
