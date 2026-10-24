object frmQckOcorrenciasCRM: TfrmQckOcorrenciasCRM
  Left = 0
  Top = 0
  ClientHeight = 213
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxOcorrencias: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41003.620361145800000000
    ReportOptions.LastChange = 44223.439952338000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure MasterData1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '                                            '
      'end;'
      ''
      'procedure Child1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '                                       '
      'end;'
      ''
      'procedure Page1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '          '
      'end;'
      ''
      'procedure ReportTitle1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '              '
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure ReportTitle1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  if Memo30.Value = '#39#39' then'
      '  begin'
      '    Child1.Visible := False;'
      '    ReportSummary1.Visible := False;'
      '    Memo30.Visible := False;'
      ''
      '    ShpEnderecos.Visible := False;'
      '    mmoEnderecos.Visible := False;'
      
        '    SubEnderecosDev.Visible := False;                           ' +
        '                                                          '
      
        '    PageHeader1.Height := 75.590600000000000000;                ' +
        '                                                          '
      '  end;    '
      'end;'
      ''
      'procedure PageHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <DBOcorrencias."OCO_TIP_FC"> = '#39'F'#39' Then'
      
        '    Memo4.Text := '#39'Fornecedor:'#39';                                ' +
        '                     '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 48
    Top = 88
    Datasets = <
      item
        DataSet = DBEnderecosDev
        DataSetName = 'DBEnderecosDev'
      end
      item
        DataSet = DBOcorrencias
        DataSetName = 'DBOcorrencias'
      end
      item
        DataSet = DBProdutosDev
        DataSetName = 'DBProdutosDev'
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
      LeftMargin = 4.000000000000000000
      RightMargin = 4.000000000000000000
      TopMargin = 4.000000000000000000
      BottomMargin = 4.000000000000000000
      OnBeforePrint = 'Page1OnBeforePrint'
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 147.401670000000000000
        Top = 18.897650000000000000
        Width = 763.465060000000000000
        OnAfterPrint = 'ReportTitle1OnAfterPrint'
        OnBeforePrint = 'ReportTitle1OnBeforePrint'
        object Shape1: TfrxShapeView
          Left = 1.889763780000000000
          Width = 759.685530000000000000
          Height = 147.401670000000000000
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 278.988405000000000000
          Top = 39.000000000000000000
          Width = 205.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'OCORR'#202'NCIA CRM')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 178.118120000000000000
          Top = 80.779530000000000000
          Width = 197.991960000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[DBOcorrencias."OCO_PROTOC"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 7.559055120000000000
          Top = 81.236240000000000000
          Width = 167.692950000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Protocolo       :')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baCenter
          Left = 122.137910000000000000
          Top = 6.779530000000000000
          Width = 519.189240000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[DBOcorrencias."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 7.559055120000000000
          Top = 103.488250000000000000
          Width = 167.692950000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Grupo Ocorr'#234'ncia:')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 177.637910000000000000
          Top = 103.488250000000000000
          Width = 390.747990000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[DBOcorrencias."GOC_DESGOC"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 7.559055120000000000
          Top = 124.606370000000000000
          Width = 167.692950000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tipo Ocorr'#234'ncia :')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 177.637910000000000000
          Top = 124.606370000000000000
          Width = 390.747990000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[DBOcorrencias."TOC_DESTOC"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 657.520100000000000000
          Top = 38.416202860000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBProdutosDev."DEVOLUCAO"]')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 167.433070870000000000
        Top = 188.976500000000000000
        Width = 763.465060000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        object Shape2: TfrxShapeView
          Left = 1.889763780000000000
          Width = 759.685530000000000000
          Height = 75.590600000000000000
        end
        object Memo4: TfrxMemoView
          Left = 7.559055120000000000
          Top = 6.338590000000000000
          Width = 84.543290000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              '[IIF(<DBOcorrencias."OCO_TIP_FC"> = '#39'C'#39','#39'Cliente'#39', IIF(<DBOcorre' +
              'ncias."OCO_TIP_FC"> = '#39'P'#39','#39'Prospecto'#39', '#39'Fornecedor'#39'))] :')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 469.205010000000000000
          Top = 6.118120000000000000
          Width = 76.984230000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cgc/Cpf :')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 7.559055120000000000
          Top = 28.252010000000000000
          Width = 84.543290000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Atividade:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 469.000310000000000000
          Top = 32.125986690000000000
          Width = 50.527520000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tipo :')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 7.559055120000000000
          Top = 50.708720000000000000
          Width = 84.543290000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'E-mail   :')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 97.133858270000000000
          Top = 6.559059999999990000
          Width = 364.291280000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[DBOcorrencias."DESCLI"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 548.134200000000000000
          Top = 6.779530000000000000
          Width = 152.637600000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[DBOcorrencias."CLI_C_G_C_"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 97.133858270000000000
          Top = 27.913420000000000000
          Width = 284.921150000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[DBOcorrencias."DESATI"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 521.913730000000000000
          Top = 32.015770000000000000
          Width = 269.803030000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[DBOcorrencias."DESTIP"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 97.133858270000000000
          Top = 50.708720000000000000
          Width = 693.110390000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[DBOcorrencias."CLI_EMAIL_"]')
          ParentFont = False
        end
        object ShpEnderecos: TfrxShapeView
          Left = 1.779530000000000000
          Top = 75.590600000000000000
          Width = 759.685530000000000000
          Height = 92.220472440944900000
        end
        object mmoEnderecos: TfrxMemoView
          Left = 7.559060000000000000
          Top = 81.370130000000000000
          Width = 175.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'os de entrega:')
          ParentFont = False
        end
        object SubEnderecosDev: TfrxSubreport
          Left = 7.559060000000000000
          Top = 97.826840000000000000
          Width = 748.346940000000000000
          Height = 18.897650000000000000
          Page = frxOcorrencias.Page2
          PrintOnParent = True
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.LeftLine.Width = 3.000000000000000000
        Frame.BottomLine.Width = 3.000000000000000000
        Height = 75.590600000000000000
        Top = 415.748300000000000000
        Width = 763.465060000000000000
        OnAfterPrint = 'MasterData1OnAfterPrint'
        OnBeforePrint = 'MasterData1OnBeforePrint'
        Child = frxOcorrencias.Child1
        DataSet = DBOcorrencias
        DataSetName = 'DBOcorrencias'
        RowCount = 0
        Stretched = True
        object Memo19: TfrxMemoView
          Left = 7.559055120000000000
          Top = 51.913420000000000000
          Width = 726.721398570000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[DBOcorrencias."HIS_DESCRI"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 7.559055120000000000
          Top = 26.456710000000000000
          Width = 216.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'HIST'#211'RICO:')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 7.559055120000000000
          Top = 3.023622050000000000
          Width = 133.677180000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Operador Origem:')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 349.834880000000000000
          Top = 3.023622050000000000
          Width = 148.795300000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Operador Destino:')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 349.542672860000000000
          Top = 26.456692910000000000
          Width = 42.968460000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data:')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 493.164812860000000000
          Top = 26.456692910000000000
          Width = 46.747990000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Hora:')
          ParentFont = False
        end
        object DBOcorrenciasDBOcorrencias: TfrxMemoView
          Left = 394.897032860000000000
          Top = 26.456692910000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = DBOcorrencias
          DataSetName = 'DBOcorrencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[DBOcorrencias."HIS_DTAINC"]')
          ParentFont = False
        end
        object DBOcorrenciasDBOcorrencias1: TfrxMemoView
          Left = 542.298702860000000000
          Top = 26.456692910000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = DBOcorrencias
          DataSetName = 'DBOcorrencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[DBOcorrencias."HIS_HORINC"]')
          ParentFont = False
        end
        object DBOcorrenciasDBOcorrencias3: TfrxMemoView
          Left = 501.016080000000000000
          Top = 3.023622050000000000
          Width = 234.330860000000000000
          Height = 18.897650000000000000
          DataSet = DBOcorrencias
          DataSetName = 'DBOcorrencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[DBOcorrencias."OPE_NOMOPE"]')
          ParentFont = False
        end
        object DBOcorrenciasDBOcorrencias2: TfrxMemoView
          Left = 144.299320000000000000
          Top = 2.779530000000000000
          Width = 200.315090000000000000
          Height = 18.897650000000000000
          DataSet = DBOcorrencias
          DataSetName = 'DBOcorrencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[DBOcorrencias."NOMHIS"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 1.889763780000000000
          Height = 75.590600000000000000
          StretchMode = smMaxHeight
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line2: TfrxLineView
          Left = 761.574803149606000000
          Height = 75.590600000000000000
          StretchMode = smMaxHeight
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line3: TfrxLineView
          Left = 1.889763780000000000
          Top = 75.590600000000000000
          Width = 759.685039370079000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 676.535870000000000000
        Width = 763.465060000000000000
        object Date: TfrxMemoView
          Left = 567.590910000000000000
          Top = 3.000000000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 5.118120000000000000
          Top = 3.220469999999980000
          Width = 179.031540000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'frmCadMovOcorrencias')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 657.283860000000000000
          Top = 2.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[Time]')
        end
        object Shape13: TfrxShapeView
          Top = 0.377574409449000000
          Width = 760.818897637795000000
          Fill.BackColor = clSilver
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        Height = 55.826840000000000000
        ParentFont = False
        Top = 514.016080000000000000
        Width = 763.465060000000000000
        OnBeforePrint = 'Child1OnBeforePrint'
        object Memo31: TfrxMemoView
          Left = 199.972635000000000000
          Top = 7.204724410000000000
          Width = 239.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'PRODUTOS DA DEVOLU'#199#195'O : ')
          ParentFont = False
        end
        object Shape9: TfrxShapeView
          Left = 1.889763780000000000
          Width = 759.685039370079000000
          Fill.BackColor = clSilver
        end
        object Shape10: TfrxShapeView
          Left = 1.889763780000000000
          Width = 0.377952760000000000
          Height = 51.779520240000000000
          Fill.BackColor = clSilver
        end
        object Shape11: TfrxShapeView
          Left = 1.889763780000000000
          Top = 52.165430000000000000
          Width = 760.062979920000000000
          Fill.BackColor = clSilver
        end
        object Memo32: TfrxMemoView
          Left = 3.779530000000000000
          Top = 33.590600000000000000
          Width = 39.188930000000000000
          Height = 15.118120000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'd.')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 171.133890000000000000
          Top = 33.574803150000000000
          Width = 247.181082830000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Nome')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 420.205010000000000000
          Top = 33.574803150000000000
          Width = 24.070810000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 447.370440000000000000
          Top = 33.574803150000000000
          Width = 46.747990000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quant.')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 442.803625590000000000
          Top = 7.559060000000000000
          Width = 148.858070000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[DBProdutosDev."GER_CODADE"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 497.354670000000000000
          Top = 33.574803150000000000
          Width = 42.968460000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Unit.')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 544.268090000000000000
          Top = 33.574803150000000000
          Width = 50.527520000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 598.165740000000000000
          Top = 33.574803150000000000
          Width = 50.527520000000000000
          Height = 15.118120000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Garant.')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 48.472480000000000000
          Top = 33.574830000000000000
          Width = 119.055113230000000000
          Height = 15.118120000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#243'd. F'#225'brica')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 659.512370000000000000
          Top = 33.574830000000000000
          Width = 99.661410000000000000
          Height = 15.118120000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Documento')
          ParentFont = False
        end
        object Shape3: TfrxShapeView
          Left = 761.574803150000000000
          Height = 51.779527560000000000
          Fill.BackColor = clSilver
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 631.181510000000000000
        Width = 763.465060000000000000
        AllowSplit = True
        Stretched = True
        object SubProdutosDev: TfrxSubreport
          Left = 0.338590000000000000
          Top = 1.999668030000000000
          Width = 763.464566930000000000
          Height = 18.897650000000000000
          Page = frxOcorrencias.ProdutosDev
          PrintOnParent = True
        end
      end
    end
    object ProdutosDev: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 4.000000000000000000
      RightMargin = 4.000000000000000000
      TopMargin = 4.000000000000000000
      BottomMargin = 4.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 13.228346456692900000
        Top = 18.897650000000000000
        Width = 763.465060000000000000
        DataSet = DBProdutosDev
        DataSetName = 'DBProdutosDev'
        RowCount = 0
        Stretched = True
        object Memo26: TfrxMemoView
          Left = 3.000000000000000000
          Top = 0.377952755905512000
          Width = 35.527549290000000000
          Height = 11.338582680000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[DBProdutosDev."ITE_CODITE"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 168.795300000000000000
          Top = 0.377952755905512000
          Width = 254.740133070000000000
          Height = 11.338582680000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[DBProdutosDev."ITE_DESITE"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 425.425480000000000000
          Top = 0.377952755905512000
          Width = 16.629909060000000000
          Height = 11.338582680000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[DBProdutosDev."UNI_SIGUNI"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 445.031850000000000000
          Top = 0.377952760000000000
          Width = 43.086606850000000000
          Height = 11.338582680000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[DBProdutosDev."DET_QTDDEV"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 493.102660000000000000
          Top = 0.377952755905512000
          Width = 43.086601970000000000
          Height = 11.338582680000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[DBProdutosDev."DET_UNIDEV"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 542.354670000000000000
          Top = 0.377952755905512000
          Width = 50.645659530000000000
          Height = 11.338582680000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[DBProdutosDev."DET_TOTDEV"]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 601.606680000000000000
          Top = 0.377952755905512000
          Width = 24.188947090000000000
          Height = 11.338582680000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[DBProdutosDev."DET_GARANT"]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 41.472480000000000000
          Top = 0.377952755905512000
          Width = 122.834594410000000000
          Height = 11.338582680000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[DBProdutosDev."ITE_CODFAB"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 623.226060120000000000
          Top = 0.377952760000000000
          Width = 137.574847090000000000
          Height = 11.338582680000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[DBProdutosDev."NUMDOC"]')
          ParentFont = False
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 4.000000000000000000
      RightMargin = 4.000000000000000000
      TopMargin = 4.000000000000000000
      BottomMargin = 4.000000000000000000
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Height = 16.251968500000000000
        Top = 18.897650000000000000
        Width = 763.465060000000000000
        DataSet = DBEnderecosDev
        DataSetName = 'DBEnderecosDev'
        RowCount = 0
        object Memo48: TfrxMemoView
          Width = 762.330708660000000000
          Height = 14.740157480000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            
              '- [DBEnderecosDev."ETC_ENDENT"], [DBEnderecosDev."ETC_BAIENT"] -' +
              ' [DBEnderecosDev."ETC_CEPENT"] - [DBEnderecosDev."CID_NOMCID"]-[' +
              'DBEnderecosDev."CID_ESTADO"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
      end
    end
  end
  object DBOcorrencias: TfrxDBDataset
    UserName = 'DBOcorrencias'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 112
    Top = 88
  end
  object DBProdutosDev: TfrxDBDataset
    UserName = 'DBProdutosDev'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 144
    Top = 88
  end
  object DBEnderecosDev: TfrxDBDataset
    UserName = 'DBEnderecosDev'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 168
    Top = 88
  end
end
