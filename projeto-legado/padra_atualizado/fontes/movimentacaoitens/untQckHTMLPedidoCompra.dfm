object frmQckHTMLPedidoCompra: TfrmQckHTMLPedidoCompra
  Left = 487
  Top = 363
  Caption = 'frmQckHTMLPedidoCompra'
  ClientHeight = 110
  ClientWidth = 155
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
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39504.578949363400000000
    ReportOptions.LastChange = 39820.747356585650000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllTotalGeralOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '                                                                ' +
        '                '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPaginaUserFunction
    Left = 24
    Top = 80
    Datasets = <
      item
        DataSet = frxPedido
        DataSetName = 'frxPedido'
      end
      item
        DataSet = frxEmpresa
        DataSetName = 'frxEmpresa'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxTransp
        DataSetName = 'frxTransp'
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
      PaperSize = 9
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      OnBeforePrint = 'RelatorioOnBeforePrint'
      object Titulo: TfrxPageHeader
        FillType = ftBrush
        Height = 317.480520000000000000
        Top = 18.897650000000000000
        Width = 793.701300000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
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
          Left = 14.779530000000000000
          Top = 184.795275590000000000
          Width = 548.031850000000000000
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
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nome:  ')
          ParentFont = False
        end
        object dbNomeCliente: TfrxMemoView
          Left = 85.811070000000000000
          Top = 201.433210000000000000
          Width = 480.000310000000000000
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
            '[frxPedido."FOR_ENDERE"]')
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
          Left = 517.574803150000000000
          Top = 218.078740160000000000
          Width = 540.472790000000000000
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
          Left = 85.811070000000000000
          Top = 266.921460000000000000
          Width = 104.567100000000000000
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
            '[IIF(Length(<frxPedido."FOR_FONE01">) > 0 ,'
            ' FormatMaskText('#39'(00)0000-0000;0'#39',<frxPedido."FOR_FONE01">),'#39#39')]')
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
              '">),'#39#39')]'
            '')
          ParentFont = False
        end
        object mmIECliente: TfrxMemoView
          Left = 453.543307090000000000
          Top = 250.582677170000000000
          Width = 60.472440944881890000
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
          Left = 517.574803150000000000
          Top = 250.582677170000000000
          Width = 222.992270000000000000
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
          Top = 299.291590000000000000
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
          Top = 299.291590000000000000
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
          Top = 49.133858267716510000
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
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxPedido."FOR_FONE02">) > 0 ,'
            ' FormatMaskText('#39'(00)0000-0000;0'#39',<frxPedido."FOR_FONE02">),'#39#39')]')
          ParentFont = False
        end
        object Line22: TfrxLineView
          Left = 3.338590000000000000
          Top = 126.078850000000000000
          Width = 786.141732280000000000
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
        object Memo15: TfrxMemoView
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
            '[SUBTIT]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 15.118120000000000000
          Top = 283.086614170000000000
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
          Width = 60.472440944881890000
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
          Width = 60.472440944881890000
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
          Left = 15.118120000000000000
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
          Top = 234.330708661417000000
          Width = 60.472440940000000000
          Height = 15.118110236220500000
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
          Width = 60.472440944881890000
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
          Left = 517.574803150000000000
          Top = 234.330708660000000000
          Width = 166.299320000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxPedido."FOR_C_E_P_">) > 0 ,'
            ' FormatMaskText('#39'00000-000;0'#39',<frxPedido."FOR_C_E_P_">),'#39#39')]'
            '')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 85.811070000000000000
          Top = 283.086614170000000000
          Width = 347.716760000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
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
          Left = 517.574803150000000000
          Top = 266.834655430000000000
          Width = 264.567100000000000000
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
          Left = 517.574803150000000000
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
            '[frxPedido."PCG_DTAPED"]')
          ParentFont = False
        end
        object dbFoneEmpresa: TfrxMemoView
          Left = 296.535560000000000000
          Top = 95.748072990000000000
          Width = 117.165359210000000000
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
            '[frxEmpresa."EMP_FONE01"]')
          ParentFont = False
        end
        object dbCEPEmpresa: TfrxMemoView
          Left = 262.889920000000000000
          Top = 80.629962750000000000
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
          Top = 95.748072990000000000
          Width = 136.063009210000000000
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
            '[frxEmpresa."EMP_F_A_X_"]')
          ParentFont = False
        end
        object mmFoneEmpresa: TfrxMemoView
          Left = 263.330860000000000000
          Top = 95.748072990000000000
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
          Top = 95.748072990000000000
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
          Top = 65.252010000000000000
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
          Top = 65.252010000000000000
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
          Top = 65.630004250000000000
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
          Top = 65.630004250000000000
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
      end
      object Rodape: TfrxPageFooter
        FillType = ftBrush
        Height = 71.811070000000000000
        Top = 865.512370000000000000
        Width = 793.701300000000000000
        object mmCitelSoftware: TfrxMemoView
          Left = 3.338590000000000000
          Top = 54.724489999999950000
          Width = 786.141732280000000000
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
          Left = 3.338590000000000000
          Top = 51.606369999999970000
          Width = 786.141732280000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo42: TfrxMemoView
          Left = 4.559059999999999000
          Top = 6.574830000000020000
          Width = 222.992270000000000000
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
        object rllObservacao: TfrxMemoView
          Left = 4.559059999999999000
          Top = 27.031539999999950000
          Width = 782.362710000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Line15: TfrxLineView
          Left = 3.338590000000000000
          Top = 3.354360000000042000
          Width = 786.141732280000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Detalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 461.102660000000000000
        Width = 793.701300000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object frxRelatorioCODITEM: TfrxMemoView
          Left = 6.338590000000000000
          Top = 1.559059999999988000
          Width = 45.354330710000000000
          Height = 13.228346456692900000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PCD_CODITE"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 56.149660000000000000
          Top = 1.559059999999988000
          Width = 277.795273150000000000
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
            '[frxRelatorio."PCD_DESITE"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 339.181200000000000000
          Top = 1.559059999999988000
          Width = 28.346456692913400000
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
        object Memo9: TfrxMemoView
          Left = 371.771800000000000000
          Top = 1.559059999999988000
          Width = 69.165354330000000000
          Height = 13.228346456692900000
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
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 445.582870000000000000
          Top = 1.559059999999988000
          Width = 52.913385830000000000
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
            '[frxRelatorio."ITE_CODFAB"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 505.732530000000000000
          Top = 1.559059999999988000
          Width = 45.354333150000000000
          Height = 13.228346456692900000
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
            '[frxRelatorio."PCD_QTDITE"]')
          ParentFont = False
        end
        object rllPrecoUnit: TfrxMemoView
          Left = 557.441264650000000000
          Top = 1.559059999999988000
          Width = 64.251995350000000000
          Height = 13.228346456692900000
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
            '[frxRelatorio."PCD_UNITAR"]')
          ParentFont = False
        end
        object rllPrecotot: TfrxMemoView
          Left = 628.472831500000000000
          Top = 1.559059999999988000
          Width = 68.031498500000000000
          Height = 13.228346456692900000
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
            '[frxRelatorio."PCD_TOTITE"]')
          ParentFont = False
        end
        object rllIpi: TfrxMemoView
          Left = 703.181510000000000000
          Top = 1.559059999999988000
          Width = 32.125984250000000000
          Height = 13.228346456692900000
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
          Left = 740.992580000000000000
          Top = 1.559059999999988000
          Width = 47.244094490000000000
          Height = 13.228346456692900000
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
            '[frxRelatorio."PCD_TOTIPI"]')
          ParentFont = False
        end
      end
      object Totais: TfrxReportSummary
        FillType = ftBrush
        Height = 71.811070000000000000
        Top = 540.472790000000000000
        Width = 793.701300000000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        Child = frxPagina.Transportadora
        object Line1: TfrxLineView
          Left = 3.338590000000000000
          Top = 5.338589999999954000
          Width = 786.141732280000000000
          Color = clBlack
          Diagonal = True
        end
        object Line2: TfrxLineView
          Left = 3.338590000000000000
          Top = 68.472480000000010000
          Width = 786.141732280000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo25: TfrxMemoView
          Left = 531.441264650000000000
          Top = 9.338589999999954000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
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
          Left = 531.441264650000000000
          Top = 28.236239999999950000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
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
        object Memo27: TfrxMemoView
          Left = 531.441264650000000000
          Top = 46.866141732283490000
          Width = 94.488250000000000000
          Height = 18.897637795275600000
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
        object rllTotalItens: TfrxMemoView
          Left = 631.386288110000000000
          Top = 9.338589999999954000
          Width = 154.960622600000000000
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
            '[frxPedido."PCG_TOTITE"]')
          ParentFont = False
        end
        object rllTotalIPI: TfrxMemoView
          Left = 631.386288110000000000
          Top = 28.236239999999950000
          Width = 154.960622600000000000
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
            '[frxPedido."PCG_TOTIPI"]')
          ParentFont = False
        end
        object rllTotalGeral: TfrxMemoView
          Left = 631.386288110000000000
          Top = 46.913419999999970000
          Width = 154.960622600000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'rllTotalGeralOnBeforePrint'
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
            '[frxPedido."PCG_TOTGER"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 6.338590000000000000
          Top = 46.866141729999980000
          Width = 52.913420000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Litragem:')
          ParentFont = False
        end
        object rllLitragem: TfrxMemoView
          Left = 64.811070000000000000
          Top = 46.866141729999980000
          Width = 253.228510000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."LITROS">,Detalhes)]')
          ParentFont = False
        end
      end
      object TopoMateriais: TfrxHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 396.850650000000000000
        Width = 793.701300000000000000
        ReprintOnNewPage = True
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
        object mmEspecie: TfrxMemoView
          Left = 56.149660000000000000
          Top = 22.677165350000000000
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
        object mmEmpresa: TfrxMemoView
          Left = 339.181200000000000000
          Top = 22.677165350000000000
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
        object mmVendedor: TfrxMemoView
          Left = 371.771800000000000000
          Top = 22.677165350000000000
          Width = 69.165354330708700000
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
        object mmDtaCadastro: TfrxMemoView
          Left = 445.582870000000000000
          Top = 22.677165354330730000
          Width = 52.913385830000000000
          Height = 13.606299212598400000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cod. Fab.')
          ParentFont = False
        end
        object mmDtaVencimento: TfrxMemoView
          Left = 505.732530000000000000
          Top = 22.677165350000000000
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
        object mmVlrOriginal: TfrxMemoView
          Left = 557.441250000000000000
          Top = 22.677165350000000000
          Width = 64.252010000000000000
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
        object mmVlrDuplicata: TfrxMemoView
          Left = 628.472790000000000000
          Top = 22.677165350000000000
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
        object mmVlrJuros: TfrxMemoView
          Left = 703.181510000000000000
          Top = 22.677165350000000000
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
        object mmVlrCorrigido: TfrxMemoView
          Left = 740.992580000000000000
          Top = 22.677165350000000000
          Width = 47.244094488189000000
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
        object Line3: TfrxLineView
          Left = 53.370130000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line4: TfrxLineView
          Left = 336.063080000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 368.874150000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 443.464750000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          Left = 503.275820000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 554.181102360000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 625.354670000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line10: TfrxLineView
          Left = 700.063390000000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line11: TfrxLineView
          Left = 738.299212600000000000
          Top = 20.559059999999990000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object sDuplicata: TfrxShapeView
          Left = 3.401574803149606000
          Top = 21.000000000000000000
          Width = 786.141732280000000000
          Height = 17.763779530000000000
        end
        object Shape1: TfrxShapeView
          Left = 3.401574803149606000
          Top = 2.000000000000000000
          Width = 786.141732280000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object Memo22: TfrxMemoView
          Left = 7.000000000000000000
          Top = 3.000000000000000000
          Width = 778.582679610000000000
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
      end
      object Transportadora: TfrxChild
        FillType = ftBrush
        Height = 90.708661420000000000
        Top = 634.961040000000000000
        Width = 793.701300000000000000
        Child = frxPagina.Comprador
        object Memo31: TfrxMemoView
          Left = 4.535433070866141000
          Top = 2.220469999999978000
          Width = 778.582679610000000000
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
          Left = 4.559059999999999000
          Top = 19.456710000000040000
          Width = 521.575140000000100000
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
          Left = 72.559060000000000000
          Top = 35.574830000000020000
          Width = 408.189240000000000000
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
          Left = 537.000310000000000000
          Top = 35.574830000000020000
          Width = 241.889920000000000000
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
          Left = 72.559060000000000000
          Top = 50.929189999999950000
          Width = 411.968770000000000000
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
          Left = 537.000310000000000000
          Top = 50.929189999999950000
          Width = 158.740260000000000000
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
          Left = 489.866420000000000000
          Top = 50.929189999999950000
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
          Left = 72.559060000000000000
          Top = 66.811069999999970000
          Width = 207.874150000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTransp."TRA_FONE01"]'
            '')
          ParentFont = False
        end
        object Line12: TfrxLineView
          Left = 3.338590000000000000
          Top = 88.267780000000010000
          Width = 786.141732280000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo39: TfrxMemoView
          Left = 4.559060000000000000
          Top = 35.574830000000020000
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
        object Memo40: TfrxMemoView
          Left = 4.559060000000000000
          Top = 50.929189999999950000
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
        object Memo41: TfrxMemoView
          Left = 489.866420000000000000
          Top = 33.795300000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
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
          Top = 66.811060239999960000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
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
      end
      object Comprador: TfrxChild
        FillType = ftBrush
        Height = 94.488250000000000000
        Top = 748.346940000000000000
        Width = 793.701300000000000000
        object rllData: TfrxMemoView
          Left = 360.613902280000000000
          Top = 77.779530000000030000
          Width = 427.086890000000000000
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
        object Memo29: TfrxMemoView
          Left = 70.779530000000000000
          Top = 77.779530000000030000
          Width = 283.464750000000000000
          Height = 15.118120000000000000
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
        object Memo28: TfrxMemoView
          Left = 4.559059999999999000
          Top = 77.779530000000030000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Comprador:')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 4.535433070000000000
          Width = 37.794799610000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Obs.:')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 4.535433070000000000
          Top = 15.236239999999950000
          Width = 784.251968503937000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_OBSPD1"]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 4.535433070000000000
          Top = 30.236239999999960000
          Width = 784.251968503937000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_OBSPD2"]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 4.535433070000000000
          Top = 45.354360000000040000
          Width = 784.251968500000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPedido."PCG_OBSPD3"]')
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
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 64
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
      'PCD_UNITAR=PCD_UNITAR'
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
      'ITE_IMPLIS=ITE_IMPLIS'
      'ITE_ITEATI=ITE_ITEATI'
      'AUTOINCREM_1=AUTOINCREM_1'
      'ITE_QTDETI=ITE_QTDETI'
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
      'ITE_VFIBAL=ITE_VFIBAL'
      'ITE_PFIBAL=ITE_PFIBAL'
      'ITE_VCALCI=ITE_VCALCI'
      'ITE_PCALCI=ITE_PCALCI'
      'ITE_VFERRO=ITE_VFERRO'
      'ITE_PFERRO=ITE_PFERRO'
      'ITE_VSODIO=ITE_VSODIO'
      'ITE_PSODIO=ITE_PSODIO'
      'ITE_ITEPIG=ITE_ITEPIG'
      'ITE_SETFLZ=ITE_SETFLZ'
      'ITE_MLTCOM=ITE_MLTCOM'
      'ITE_MLTVEN=ITE_MLTVEN'
      'MAR_DESMAR=MAR_DESMAR'
      'LITROS=LITROS'
      'UNI_SIGUNI=UNI_SIGUNI')
    DataSet = qryRelatorio
    BCDToCurrency = False
    Left = 40
    Top = 8
  end
  object frxPedido: TfrxDBDataset
    UserName = 'frxPedido'
    CloseDataSource = False
    DataSet = qryPedido
    BCDToCurrency = False
    Left = 40
    Top = 40
  end
  object qryRelatorio: TUniQuery
    Connection = frmModulo.Database
    Left = 8
    Top = 8
    object qryRelatorioPCD_NUMPED: TStringField
      FieldName = 'PCD_NUMPED'
      Required = True
      Size = 6
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
      Size = 57
    end
    object qryRelatorioPCD_QTDITE: TFloatField
      FieldName = 'PCD_QTDITE'
    end
    object qryRelatorioPCD_UNITAR: TFloatField
      FieldName = 'PCD_UNITAR'
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
      Size = 6
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
      Size = 3
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
    object qryRelatorioITE_IMPLIS: TStringField
      FieldName = 'ITE_IMPLIS'
      Size = 1
    end
    object qryRelatorioITE_ITEATI: TStringField
      FieldName = 'ITE_ITEATI'
      Size = 1
    end
    object qryRelatorioAUTOINCREM_1: TStringField
      FieldName = 'AUTOINCREM_1'
    end
    object qryRelatorioITE_QTDETI: TIntegerField
      FieldName = 'ITE_QTDETI'
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
    object qryRelatorioITE_VFIBAL: TIntegerField
      FieldName = 'ITE_VFIBAL'
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
    object qryRelatorioITE_MLTCOM: TIntegerField
      FieldName = 'ITE_MLTCOM'
    end
    object qryRelatorioITE_MLTVEN: TIntegerField
      FieldName = 'ITE_MLTVEN'
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
  end
  object qryPedido: TUniQuery
    Connection = frmModulo.Database
    Left = 8
    Top = 40
    object qryPedidoPCG_NUMPED: TStringField
      FieldName = 'PCG_NUMPED'
      Required = True
      Size = 6
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
    object qryPedidoPCG_OBS001: TStringField
      FieldName = 'PCG_OBS001'
      Size = 50
    end
    object qryPedidoPCG_OBS002: TStringField
      FieldName = 'PCG_OBS002'
      Size = 50
    end
    object qryPedidoPCG_OBS003: TStringField
      FieldName = 'PCG_OBS003'
      Size = 50
    end
    object qryPedidoPCG_OBS004: TStringField
      FieldName = 'PCG_OBS004'
      Size = 50
    end
    object qryPedidoPCG_OBS005: TStringField
      FieldName = 'PCG_OBS005'
      Size = 50
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
      Size = 50
    end
    object qryPedidoPCG_OBSPD2: TStringField
      FieldName = 'PCG_OBSPD2'
      Size = 50
    end
    object qryPedidoPCG_OBSPD3: TStringField
      FieldName = 'PCG_OBSPD3'
      Size = 50
    end
    object qryPedidoPCG_TIPFRE: TStringField
      FieldName = 'PCG_TIPFRE'
      Size = 1
    end
    object qryPedidoPCG_PEDVEN: TStringField
      FieldName = 'PCG_PEDVEN'
      Size = 6
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
      Size = 6
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
      FieldName = 'FOR_NUMRG_'
      Size = 10
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
  end
  object frxTransp: TfrxDBDataset
    UserName = 'frxTransp'
    CloseDataSource = False
    DataSet = qryTransp
    BCDToCurrency = False
    Left = 112
    Top = 40
  end
  object frxEmpresa: TfrxDBDataset
    UserName = 'frxEmpresa'
    CloseDataSource = False
    DataSet = qryEmpresa
    BCDToCurrency = False
    Left = 112
    Top = 8
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
    Left = 80
    Top = 8
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
  end
  object qryTransp: TUniQuery
    Connection = frmModulo.Database
    Left = 80
    Top = 40
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
    Left = 104
    Top = 80
  end
end
