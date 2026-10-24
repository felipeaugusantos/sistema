object frmRelRcxReciboCob: TfrmRelRcxReciboCob
  Left = 0
  Top = 0
  Caption = 'frmRelRcxReciboCob'
  ClientHeight = 299
  ClientWidth = 470
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
  object frxReciboCobranca: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 44078.587454270800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure fooChePreOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  chiCabec.Visible := False;'
      'end;'
      ''
      'procedure Memo19OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '    memo19.Text := '#39'('#39'+fValorPorExtenso(Trim(rllTotValRec.Text))' +
        '+'#39')'#39';  '
      'end;'
      ''
      'procedure Memo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  Memo2.Text := '#39'Cidade: '#39' + fRetNomCidade(<frxDBRecCobEmpresa."' +
        'EMP_CODCID">) + '#39' - '#39' +'
      
        '                             fRetNomCidade(<frxDBRecCobEmpresa."' +
        'EMP_CODCID">, 1)'
      '  '
      'end;'
      ''
      'procedure Footer1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  Memo13.Visible := True;                                      '
      'end;'
      ''
      'begin'
      'end.')
    OnStartReport = 'frxReciboMOnStartReport'
    OnUserFunction = frxReciboCobrancaUserFunction
    Left = 72
    Top = 72
    Datasets = <
      item
        DataSet = frxDBReciboCobranca
        DataSetName = 'frxDBReciboCobranca'
      end
      item
        DataSet = frxDBRecCobEmpresa
        DataSetName = 'frxDBRecCobEmpresa'
      end>
    Variables = <
      item
        Name = ' Autcom Variables'
        Value = Null
      end
      item
        Name = 'CIDEMP'
        Value = #39'Cidade da Empresa'#39
      end
      item
        Name = 'RETINSS'
        Value = #39'RETEN'#65533#65533'O DE INSS'#39
      end
      item
        Name = 'ENDCEP'
        Value = #39'CEP: 14270-000'#39
      end
      item
        Name = 'NOMEMP'
        Value = #39'CITEL SOFTWARE'#39
      end
      item
        Name = 'NOMEND'
        Value = #39'ENDERE'#65533'O: AVENIDA DOUTOR FRANCISCO JUNQUEIRA, 457'#39
      end
      item
        Name = 'DTAFIN'
        Value = #39'30/09/2020'#39
      end
      item
        Name = 'INSINSS'
        Value = #39'N'#65533' INSCRI'#65533#65533'O NO INSS'#39
      end
      item
        Name = 'OPELIB'
        Value = #39'PROGRAMA'#65533#65533'O'#39
      end
      item
        Name = 'NOMCID'
        Value = #39'CIDADE: RIBEIR'#65533'O PRETO - SP'#39
      end
      item
        Name = 'FONE'
        Value = #39'FONE: (16) 3302-6789'#39
      end
      item
        Name = 'CONREC'
        Value = #39'RECIBO DE COBRANCA No - 000049 - 998'#39
      end
      item
        Name = 'DATA'
        Value = #39'RIBEIRAO PRETO, 29 DE SETEMBRO DE 2020'#39
      end
      item
        Name = 'DTAINI'
        Value = #39'29/09/2020'#39
      end
      item
        Name = 'BAICID'
        Value = #39'BAIRRO: VILA SEIXAS'#39
      end
      item
        Name = '%'
        Value = #39'%'#39
      end
      item
        Name = '-'
        Value = #39'-'#39
      end
      item
        Name = '..'
        Value = #39'..'#39
      end
      item
        Name = 'PERIMP'
        Value = #39'11'#39
      end
      item
        Name = 'CGCEMP'
        Value = #39'04.562.779/0001-90'#39
      end
      item
        Name = 'ENDEMP'
        Value = #39'Endere'#65533'o da Empresa'#39
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Pagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 98.220470000000000000
        Top = 16.000000000000000000
        Width = 755.906000000000000000
        Child = frxReciboCobranca.Child1
        object rllNumPag: TfrxMemoView
          Left = 517.590290000000000000
          Top = 17.000000000000000000
          Width = 123.363760000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Data da Impress'#227'o:')
          ParentFont = False
        end
        object TotalPages: TfrxMemoView
          Left = 705.590290000000000000
          Top = 17.000000000000000000
          Width = 45.656710000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Page: TfrxMemoView
          Left = 644.333580000000000000
          Top = 17.000000000000000000
          Width = 60.774830000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] - ')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Top = 47.913420000000000000
          Width = 400.251700000000000000
          Height = 13.220470000000000000
          OnBeforePrint = 'Memo2OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'cidade')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Top = 62.913420000000000000
          Width = 400.251700000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Endere'#231'o: [frxDBRecCobEmpresa."EMP_ENDERE"] ,  [frxDBRecCobEmpre' +
              'sa."EMP_ENDNUM"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Left = 400.251700000000000000
          Top = 48.574830000000000000
          Width = 279.306740000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxDBRecCobEmpresa."EMP_BAIRRO"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baLeft
          Left = 400.251700000000000000
          Top = 62.133890000000000000
          Width = 279.306740000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP: [frxDBRecCobEmpresa."EMP_C_E_P_"]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Top = 94.488250000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object frxDBRecCobEmpresaEMP_NOMEMP: TfrxMemoView
          Align = baLeft
          Top = 3.779530000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataSet = frxDBRecCobEmpresa
          DataSetName = 'frxDBRecCobEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBRecCobEmpresa."EMP_NOMEMP"]')
          ParentFont = False
        end
        object frxDBRecCobEmpresaEMP_FONE01: TfrxMemoView
          Align = baLeft
          Top = 23.236240000000000000
          Width = 230.551330000000000000
          Height = 15.118120000000000000
          DataSet = frxDBRecCobEmpresa
          DataSetName = 'frxDBRecCobEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone: [frxDBRecCobEmpresa."EMP_FONE01"]')
          ParentFont = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 372.000000000000000000
        Width = 755.906000000000000000
        DataSet = frxDBReciboCobranca
        DataSetName = 'frxDBReciboCobranca'
        RowCount = 0
        object rllValDup: TfrxMemoView
          Left = 422.936920000000000000
          Top = 0.779530000000000000
          Width = 94.110255750000000000
          Height = 13.220470000000000000
          DataField = 'VALORI'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBReciboCobranca."VALORI"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValDes: TfrxMemoView
          Left = 519.357390000000000000
          Top = 1.000000000000000000
          Width = 79.370093390000000000
          Height = 13.220470000000000000
          DataField = 'VALJUR'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBReciboCobranca."VALJUR"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValJur: TfrxMemoView
          Left = 601.762090000000000000
          Top = 1.000000000000000000
          Width = 71.811033390000000000
          Height = 13.220470000000000000
          DataField = 'DESCON'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBReciboCobranca."DESCON"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValRec: TfrxMemoView
          Left = 675.780890000000000000
          Top = 1.000000000000000000
          Width = 75.212605750000000000
          Height = 13.220470000000000000
          DataField = 'VALTOT'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBReciboCobranca."VALTOT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 222.551330000000000000
          Top = 0.779530000000000000
          Width = 105.448845750000000000
          Height = 13.220470000000000000
          DataField = 'DTAEMI'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBReciboCobranca."DTAEMI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 328.157700000000000000
          Top = 0.779530000000000000
          Width = 94.110255750000000000
          Height = 13.220470000000000000
          DataField = 'DTAVEN'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBReciboCobranca."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 3.600000000000000000
          Top = 1.000000000000000000
          Width = 143.244145750000000000
          Height = 13.220470000000000000
          DataField = 'NUMDUP'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBReciboCobranca."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 149.944960000000000000
          Top = 0.779530000000000000
          Width = 71.433068430000000000
          Height = 13.220470000000000000
          DataField = 'CODEMP'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBReciboCobranca."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object chiCabec: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 284.000000000000000000
        Width = 755.906000000000000000
        object Shape1: TfrxShapeView
          Left = 3.000000000000000000
          Top = 1.031540000000000000
          Width = 752.126470000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo12: TfrxMemoView
          Left = 3.426840000000000000
          Top = 5.440940000000000000
          Width = 146.872170000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 323.711750000000000000
          Top = 5.440940000000000000
          Width = 101.669315750000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENCIMENTO')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 424.495980000000000000
          Top = 5.440940000000000000
          Width = 94.110255750000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. ORIGINAL')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 521.916450000000000000
          Top = 5.440940000000000000
          Width = 75.590563390000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. JUROS')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 600.084910000000000000
          Top = 5.440940000000000000
          Width = 71.811033390000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DESC')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 673.607730000000000000
          Top = 5.440940000000000000
          Width = 78.992135750000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. TOTAL')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 223.937032280000000000
          Top = 5.440940000000000000
          Width = 97.889785750000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMISS'#195'O')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 153.299320000000000000
          Top = 5.440940000000000000
          Width = 67.653545750000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 117.165430000000000000
        Top = 492.000000000000000000
        Width = 755.906000000000000000
        object rllTotValRec: TfrxMemoView
          Align = baRight
          Left = 676.913864250000000000
          Top = 7.559060000000000000
          Width = 78.992135750000000000
          Height = 13.220470000000000000
          OnAfterPrint = 'rllTotValRecOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBReciboCobranca."VALTOT">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 369.464425350000000000
          Top = 7.338590000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baLeft
          Top = 4.338590000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Left = -0.118120000000000000
          Top = 49.677180000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo22: TfrxMemoView
          Left = 26.456710000000000000
          Top = 77.826818030000000000
          Width = 229.946010000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '_____________________________________')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baRight
          Left = 601.701258500000000000
          Top = 7.559060000000000000
          Width = 75.212605750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBReciboCobranca."DESCON">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Align = baRight
          Left = 526.488652750000000000
          Top = 7.779530000000000000
          Width = 75.212605750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBReciboCobranca."VALJUR">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Align = baRight
          Left = 436.157927000000000000
          Top = 7.559060000000000000
          Width = 90.330725750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBReciboCobranca."VALORI">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 588.386210000000000000
          Top = 30.015770000000000000
          Width = 165.921325750000000000
          Height = 13.220470000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:  [SUM(<frxDBReciboCobranca."VALTOT">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 377.953000000000000000
          Top = 79.370130000000000000
          Width = 359.055350000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DATA]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 26.456710000000000000
          Width = 570.709030000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo19OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 30.456710000000000000
          Top = 93.047310000000000000
          Width = 219.212740000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[OPELIB]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 128.504020000000000000
        Top = 136.000000000000000000
        Width = 755.906000000000000000
        Child = frxReciboCobranca.chiCabec
        object Memo8: TfrxMemoView
          Align = baLeft
          Width = 400.251700000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CONREC]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Top = 21.543307086614200000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Recebi de:')
          ParentFont = False
        end
        object frxDBReciboCobrancaNOMCLI: TfrxMemoView
          Left = 101.031540000000000000
          Top = 21.677180000000000000
          Width = 351.496290000000000000
          Height = 18.897650000000000000
          DataField = 'NOMCLI'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBReciboCobranca."NOMCLI"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 102.031540000000000000
          Top = 38.574830000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object frxDBReciboCobrancaENDCLI: TfrxMemoView
          Left = 166.299320000000000000
          Top = 39.354360000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          DataField = 'ENDCLI'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBReciboCobranca."ENDCLI"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 102.047310000000000000
          Top = 55.472480000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Municipio:')
          ParentFont = False
        end
        object frxDBReciboCobrancaCIDCLI: TfrxMemoView
          Left = 166.299320000000000000
          Top = 55.472480000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          DataField = 'CIDCLI'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBReciboCobranca."CIDCLI"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 102.047310000000000000
          Top = 74.149660000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ/CPF:')
          ParentFont = False
        end
        object frxDBReciboCobrancaCGCCLI: TfrxMemoView
          Left = 176.196970000000000000
          Top = 74.149660000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DataField = 'CGCCLI'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBReciboCobranca."CGCCLI"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 102.047310000000000000
          Top = 91.488250000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone 1:')
          ParentFont = False
        end
        object frxDBReciboCobrancaFONCLI: TfrxMemoView
          Left = 151.181200000000000000
          Top = 90.708720000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          DataField = 'FONCLI'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBReciboCobranca."FONCLI"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 453.882190000000000000
          Top = 22.456710000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo:')
          ParentFont = False
        end
        object frxDBReciboCobrancaCODCLI: TfrxMemoView
          Left = 500.236550000000000000
          Top = 22.677180000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataField = 'CODCLI'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBReciboCobranca."CODCLI"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 455.323130000000000000
          Top = 39.354360000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object frxDBReciboCobrancaBAICLI: TfrxMemoView
          Left = 497.897960000000000000
          Top = 39.574830000000000000
          Width = 253.228510000000000000
          Height = 18.897650000000000000
          DataField = 'BAICLI'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBReciboCobranca."BAICLI"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 455.323130000000000000
          Top = 56.252010000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cep:')
          ParentFont = False
        end
        object frxDBReciboCobrancaCEPCLI: TfrxMemoView
          Left = 489.118430000000000000
          Top = 55.692950000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DataField = 'CEPCLI'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBReciboCobranca."CEPCLI"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 455.543600000000000000
          Top = 75.370130000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE/RG:')
          ParentFont = False
        end
        object frxDBReciboCobrancaIRGCLI: TfrxMemoView
          Left = 498.897960000000000000
          Top = 75.031540000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          DataField = 'IRGCLI'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBReciboCobranca."IRGCLI"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 456.543600000000000000
          Top = 91.488250000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone 2:')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 504.677490000000000000
          Top = 90.708720000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          DataField = 'FONCLI'
          DataSet = frxDBReciboCobranca
          DataSetName = 'frxDBReciboCobranca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBReciboCobranca."FONCLI"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 113.165430000000000000
          Width = 151.181200000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'As seguinte Duplicatas:')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 408.000000000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'Footer1OnBeforePrint'
      end
    end
  end
  object frxDBRecCobEmpresa: TfrxDBDataset
    UserName = 'frxDBRecCobEmpresa'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 208
    Top = 168
  end
  object frxDBReciboCobranca: TfrxDBDataset
    UserName = 'frxDBReciboCobranca'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 344
    Top = 168
  end
end
