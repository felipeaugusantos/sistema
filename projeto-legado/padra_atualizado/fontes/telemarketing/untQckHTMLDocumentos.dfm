object frmQckHTMLDocumentos: TfrmQckHTMLDocumentos
  Left = 245
  Top = 197
  Caption = 'frmQckHTMLDocumentos'
  ClientHeight = 127
  ClientWidth = 190
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
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
    ReportOptions.LastChange = 42068.618102233800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltTotIte: Double;'
      '  fltTotSer: Double;'
      '  fltValIte: Double;'
      '  fltTotFre: Double;'
      '  fltDesAce: Double;'
      '  fltDesEsp: Double;'
      '  fltValIpi: Double;'
      '  fltValSub: Double;      '
      '  fltValUni: Double;'
      '  fltTotGer: Double;'
      '    '
      'procedure rllTotalProdutosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalProdutos.Text := FormatFloat('#39'#,##0.00'#39', fltTotIte);  ' +
        '                 '
      'end;'
      ''
      'procedure DetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxRelatorio."ITESER"> <> '#39'S'#39') Then'
      '  Begin              '
      '    If fEhDV Then'
      '    Begin'
      '      fltValUni := Abs(<frxRelatorio."VALUNI">);'
      '      fltValIte := Abs(<frxRelatorio."VALITE">);  '
      '    End'
      '    Else'
      
        '    If ((<frxRelatorio."ESPDOC"> = '#39'AJ'#39') Or (<frxRelatorio."ESPD' +
        'OC"> = '#39'ML'#39')) Then'
      '    Begin                '
      
        '      fltValUni := IIF(<frxRelatorio."ENTSAI"> <> '#39'ENT'#39', -1 * <f' +
        'rxRelatorio."VALUNI">, <frxRelatorio."VALUNI">);'
      
        '      fltValIte := IIF(<frxRelatorio."ENTSAI"> <> '#39'ENT'#39', -1 * <f' +
        'rxRelatorio."VALITE">, <frxRelatorio."VALITE">);'
      '    End Else                                 '
      '    Begin'
      
        '      fltValUni := IIF(<frxRelatorio."ENTSAI"> = '#39'ENT'#39', -1 * <fr' +
        'xRelatorio."VALUNI">, <frxRelatorio."VALUNI">);'
      
        '      fltValIte := IIF(<frxRelatorio."ENTSAI"> = '#39'ENT'#39', -1 * <fr' +
        'xRelatorio."VALITE">, <frxRelatorio."VALITE">);'
      '    End;                      '
      '  End;'
      '    '
      '  If fDescontoCliente Then'
      '  Begin              '
      '    fltValIte := fltValIte / ( 1 - fGetDesCli / 100 );'
      '    fltValUni := fltValUni / ( 1 - fGetDesCli / 100 );'
      '  End;'
      '    '
      '  fltTotIte := fltTotIte + fltValIte;'
      '  fltTotFre := fltTotFre + <frxRelatorio."VALFRE">;'
      '  fltDesAce := fltDesAce + <frxRelatorio."DESACE">;'
      '  fltDesEsp := fltDesEsp + <frxRelatorio."DESESP">;'
      '  fltValIpi := fltValIpi + <frxRelatorio."VALIPI">;'
      '  fltValSub := fltValSub + <frxRelatorio."VALSUB">;      '
      '    '
      
        '  fltTotGer := fltTotIte - fltDesEsp + fltTotFre + fltValIpi + f' +
        'ltValSub + <frxRelatorio."VALSER">;'
      '    '
      '  rllMetragem.Text := fDadosMetragem(<frxRelatorio."APAREL">,'
      '                                     <frxRelatorio."BENEFI">, '
      '                                     <frxRelatorio."QTDPEC">, '
      '                                     <frxRelatorio."COMPEC">, '
      '                                     <frxRelatorio."LARPEC">, '
      '                                     <frxRelatorio."ESPPEC">);'
      '                                       '
      
        '  CMetragem.visible := rllMetragem.Text <> '#39#39';                  ' +
        '                                '
      'end;'
      ''
      'procedure rllTotalServicosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllTotalServicos.Text := FormatFloat('#39'#,##0.00'#39', fltTotSer);  '
      'end;'
      ''
      'procedure ServicosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If ((<frxRelatorio."ESPDOC"> = '#39'AJ'#39') Or (<frxRelatorio."ESPDOC' +
        '"> = '#39'ML'#39')) Then'
      
        '    fltTotSer := fltTotSer + IIF(<frxRelatorio."ENTSAI"> <> '#39'ENT' +
        #39', -1 * <frxServicos."VALSER">, <frxServicos."VALSER">)  '
      '  Else            '
      
        '    fltTotSer := fltTotSer + IIF(<frxRelatorio."ENTSAI"> = '#39'ENT'#39 +
        ', -1 * <frxServicos."VALSER">, <frxServicos."VALSER">);  '
      'end;'
      ''
      'procedure CMecanicoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  CMecanico.Visible := <frxRelatorio."MECANI"> <> '#39#39';           ' +
        '                                                               '
      'end;'
      ''
      'procedure rllPrecototOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPrecotot.Text := FormatFloat('#39'#,##0.00'#39', fltValIte);       ' +
        '         '
      'end;'
      ''
      'procedure rllPrecoUnitOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPrecoUnit.Text := FormatFloat(fRetornaMascara, fltValUni); ' +
        ' '
      'end;'
      ''
      'procedure rllTotalGeralOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalGeral.Text := FormatFloat('#39'#,##0.00'#39', fltTotGer);     ' +
        '                                      '
      'end;'
      ''
      'procedure rldValFreOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllValFre.Visible := fltTotFre <> 0;                          ' +
        '      '
      '  rldValFre.Visible := fltTotFre <> 0;             '
      '  rldValFre.Text := FormatFloat('#39'#,##0.00'#39', fltTotFre);  '
      'end;'
      ''
      'procedure rldDesAceOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllDesAce.Visible := fltDesAce <> 0;                          ' +
        '      '
      '  rldDesAce.Visible := fltDesAce <> 0;             '
      '  rldDesAce.Text := FormatFloat('#39'#,##0.00'#39', fltDesAce);  '
      'end;'
      ''
      'procedure rldDesEspOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllDesEsp.Visible := fltDesEsp <> 0;                          ' +
        '      '
      '  rldDesEsp.Visible := fltDesEsp <> 0;             '
      '  rldDesEsp.Text := FormatFloat('#39'#,##0.00'#39', fltDesEsp);  '
      'end;'
      ''
      'procedure rldValIpiOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllValIpi.Visible := fltValIpi <> 0;                          ' +
        '      '
      '  rldValIpi.Visible := fltValIpi <> 0;             '
      '  rldValIpi.Text    := FormatFloat('#39'#,##0.00'#39', fltValIpi);  '
      'end;'
      ''
      'procedure rldValSubOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllValSub.Visible := fltValSub <> 0;                          ' +
        '      '
      '  rldValSub.Visible := fltValSub <> 0;             '
      '  rldValSub.Text    := FormatFloat('#39'#,##0.00'#39', fltValSub);  '
      'end;'
      ''
      'procedure DuplicatasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If ((<frxRelatorio."ESPDOC"> = '#39'AJ'#39') Or (<frxRelatorio."ESPDOC' +
        '"> = '#39'ML'#39')) Then'
      
        '    Duplicatas.Visible := False;                                ' +
        '                       '
      'end;'
      ''
      'begin'
      '  fltTotSer := 0;  '
      '  fltValIte := 0;'
      '  fltValUni := 0;'
      '  fltValIpi := 0;'
      '  fltValSub := 0;      '
      '  fltDesEsp := 0;'
      '  fltDesAce := 0;      '
      '  fltTotGer := 0;                                      '
      'end.')
    OnPreview = frxPaginaPreview
    OnPrintReport = frxPaginaPrintReport
    OnUserFunction = frxPaginaUserFunction
    Left = 154
    Top = 46
    Datasets = <
      item
        DataSet = frxDuplicatas
        DataSetName = 'frxDuplicatas'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxRomaneio
        DataSetName = 'frxRomaneio'
      end
      item
        DataSet = frxServicos
        DataSetName = 'frxServicos'
      end
      item
        DataSet = frxVendasPerdidas
        DataSetName = 'frxVendasPerdidas'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Relatorio: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 400.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      OnBeforePrint = 'RelatorioOnBeforePrint'
      object Rodape: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1307.717380000000000000
        Width = 755.906000000000000000
        object mmCitelSoftware: TfrxMemoView
          Left = 5.669548860000000000
          Top = 3.724490000000060000
          Width = 744.566902280000000000
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
          Top = 3.606369999999970000
          Width = 748.346432280000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Detalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.566936460000000000
        Top = 434.645950000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'DetalhesOnBeforePrint'
        Child = frxPagina.CMetragem
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object frxRelatorioCODITEM: TfrxMemoView
          Left = 4.338590000000000000
          Top = 2.669294999999977000
          Width = 52.913390710000000000
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
            '[frxRelatorio."CODITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbDesIte: TfrxMemoView
          Left = 63.047310000000000000
          Top = 2.669294999999977000
          Width = 236.220438270000000000
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
            '[frxRelatorio."DESITE"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 514.283550000000000000
          Top = 2.669294999999977000
          Width = 32.125986690000000000
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
            '[frxRelatorio."UNIDAD"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 548.834880000000000000
          Top = 2.669294999999977000
          Width = 56.692923150000000000
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
          WordWrap = False
          VAlign = vaCenter
        end
        object rllPrecoUnit: TfrxMemoView
          Left = 611.441264650000000000
          Top = 2.669294999999977000
          Width = 64.251995350000000000
          Height = 13.228346460000000000
          OnBeforePrint = 'rllPrecoUnitOnBeforePrint'
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
            '[frxRelatorio."VALUNI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllPrecotot: TfrxMemoView
          Left = 683.732283460000000000
          Top = 2.669294999999977000
          Width = 69.921259840000000000
          Height = 13.228346460000000000
          OnBeforePrint = 'rllPrecototOnBeforePrint'
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
            '[frxRelatorio."VALITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rldEntSai: TfrxMemoView
          Left = 488.133846060000000000
          Top = 2.669294999999977000
          Width = 22.677167800000000000
          Height = 13.228346460000000000
          DataField = 'ENTSAI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."ENTSAI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Left = 458.764070000000000000
          Top = 2.669294999999977000
          Width = 18.897637800000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[fRetClaIpi(<frxRelatorio."CLAIPI">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbDesMar: TfrxMemoView
          Left = 374.055350000000000000
          Top = 2.669294999999977000
          Width = 79.370103150000000000
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
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbLocFis: TfrxMemoView
          Left = 306.141930000000000000
          Top = 2.779530000000022000
          Width = 64.251983150000000000
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
          VAlign = vaCenter
        end
      end
      object Itens_Servicos: TfrxReportSummary
        FillType = ftBrush
        Height = 18.897454720000000000
        Top = 559.370440000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        Child = frxPagina.chdTotais
        PrintChildIfInvisible = True
        object Subreport_Servicos: TfrxSubreport
          Left = 0.377952760000000000
          Top = 0.377952759999971000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Page = frxPagina.Page1
        end
      end
      object TopoDocumentos: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 389.291590000000000000
        Width = 755.906000000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 0.000244100000000000
          Top = 2.000000000000000000
          Width = 755.905511810000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object mmDuplicata: TfrxMemoView
          Left = 4.559059999999999000
          Top = 5.118105350000008000
          Width = 52.913390710000000000
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
          WordWrap = False
          VAlign = vaCenter
        end
        object mmEspecie: TfrxMemoView
          Left = 63.488250000000010000
          Top = 5.118105350000008000
          Width = 136.063080000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o / Refer'#234'ncia')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmEmpresa: TfrxMemoView
          Left = 513.504020000000000000
          Top = 5.118105350000008000
          Width = 30.236225350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Unid.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmDtaVencimento: TfrxMemoView
          Left = 548.834880000000000000
          Top = 5.118105350000008000
          Width = 56.692923150000000000
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
          WordWrap = False
          VAlign = vaCenter
        end
        object mmVlrOriginal: TfrxMemoView
          Left = 610.661720000000000000
          Top = 5.118105350000008000
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
            'Valor Unit.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmVlrDuplicata: TfrxMemoView
          Left = 681.732283460000000000
          Top = 5.118105350000008000
          Width = 69.921259840000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Total')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          Left = 44.590600000000000000
          Top = 2.377958859999978000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line4: TfrxLineView
          Left = 510.385900000000000000
          Top = 2.377958859999978000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          Left = 547.378170000000000000
          Top = 2.377958859999978000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 607.401572360000000000
          Top = 2.377958859999978000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 678.575140000000000000
          Top = 2.377958859999978000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object rllEntSai: TfrxMemoView
          Left = 489.000310000000000000
          Top = 5.118105350000008000
          Width = 18.897635350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'E/S')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object linEntSai: TfrxLineView
          Left = 486.220780000000000000
          Top = 2.377958859999978000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo53: TfrxMemoView
          Left = 456.764070000000000000
          Top = 5.118105350000008000
          Width = 26.456695350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Leg')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line15: TfrxLineView
          Left = 454.984540000000000000
          Top = 2.377958859999978000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object rllDesMar: TfrxMemoView
          Left = 375.685039370078700000
          Top = 5.118105350000008000
          Width = 52.913405350000000000
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
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLinhaMarca: TfrxLineView
          Left = 373.055350000000000000
          Top = 2.377958859999978000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object rllLocFis: TfrxMemoView
          Left = 306.141930000000000000
          Top = 5.519676489999995000
          Width = 64.251995350000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Loc. F'#237'sica')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLinhaLocFis: TfrxLineView
          Left = 303.362400000000000000
          Top = 2.779530000000022000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object Romaneio: TfrxChild
        FillType = ftBrush
        Height = 22.677121420000000000
        Top = 1217.008660000000000000
        Width = 755.906000000000000000
        Child = frxPagina.VendasPerdidas
        PrintChildIfInvisible = True
        object Subreport_Romaneio: TfrxSubreport
          Top = 1.779530000000022000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Page = frxPagina.PageRomaneio
        end
      end
      object Duplicatas: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1171.654300000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'DuplicatasOnBeforePrint'
        Child = frxPagina.Romaneio
        PrintChildIfInvisible = True
        object Subreport_duplic: TfrxSubreport
          Top = 1.000000000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Page = frxPagina.PageDuplicatas
        end
      end
      object rlbDocDev: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1126.299940000000000000
        Width = 755.906000000000000000
        Child = frxPagina.Duplicatas
        PrintChildIfInvisible = True
        Stretched = True
        object Memo60: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.889764999999898000
          Width = 748.346940000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Docs. Devolvidos: [DOCDEV]')
          ParentFont = False
        end
      end
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 124.724409448819000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        Child = frxPagina.Child1
        PrintChildIfInvisible = True
        object dbEmrpesa: TfrxMemoView
          Left = 260.519790000000000000
          Top = 4.897637799999998000
          Width = 476.220462680000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object dbEnderecoEmpresa: TfrxMemoView
          Left = 260.519790000000000000
          Top = 20.015770000000000000
          Width = 476.220462680000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ENDERE"]')
          ParentFont = False
          WordWrap = False
        end
        object dbBairroEmpresa: TfrxMemoView
          Left = 260.669450000000000000
          Top = 35.133858270000000000
          Width = 476.220462680000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CIDEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Line22: TfrxLineView
          Left = 3.779783860000000000
          Top = 118.299212600000000000
          Width = 748.346432280000000000
          Color = clBlack
          Diagonal = True
        end
        object dbFoneEmpresa: TfrxMemoView
          Left = 294.535560000000000000
          Top = 81.748072990000000000
          Width = 117.165359210000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataFone(<frxRelatorio."FONEMP">)]')
          ParentFont = False
          WordWrap = False
        end
        object dbCEPEmpresa: TfrxMemoView
          Left = 260.889920000000000000
          Top = 66.629962750000000000
          Width = 476.220462680000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMAIL"]')
          ParentFont = False
          WordWrap = False
        end
        object dbFaxEmpresa: TfrxMemoView
          Left = 442.314958190000000000
          Top = 81.748072990000000000
          Width = 136.063009210000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataFone(<frxRelatorio."FAXEMP">)]')
          ParentFont = False
          WordWrap = False
        end
        object mmFoneEmpresa: TfrxMemoView
          Left = 261.330860000000000000
          Top = 81.748072990000190000
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
          WordWrap = False
        end
        object mmFaxEmpresa: TfrxMemoView
          Left = 413.968501500000000000
          Top = 81.748072990000190000
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
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 260.787570000000000000
          Top = 51.252010000000200000
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
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 300.819110000000000000
          Top = 51.252010000000200000
          Width = 109.606370000000000000
          Height = 15.118110240000000000
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxRelatorio."CGCEMP">) > 0 ,'
            
              ' FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxRelatorio."CGCEMP"' +
              '>),'#39#39')]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 413.968501500000000000
          Top = 51.630004250000200000
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
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 442.314958190000000000
          Top = 51.630004250000200000
          Width = 185.196970000000000000
          Height = 15.118110240000000000
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."IESEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllImagem: TfrxPictureView
          ShiftMode = smWhenOverlapped
          Left = 11.338582680000000000
          Top = 4.338590000000000000
          Width = 241.889763780000000000
          Height = 105.826771650000000000
          Center = True
          KeepAspectRatio = False
          HightQuality = True
          Transparent = False
          TransparentColor = clWhite
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 162.519697240000000000
        Top = 166.299320000000000000
        Width = 755.906000000000000000
        object rllNumDoc: TfrxMemoView
          Left = 7.559055120000000000
          Top = 1.968435590000013000
          Width = 438.425480000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Documento')
          ParentFont = False
          WordWrap = False
        end
        object mmNomeCliente: TfrxMemoView
          Left = 7.559055120000000000
          Top = 24.007805670000290000
          Width = 64.251968500000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cliente:  ')
          ParentFont = False
          WordWrap = False
        end
        object dbNomeCliente: TfrxMemoView
          Left = 75.590551180000000000
          Top = 24.007805670000010000
          Width = 370.393700790000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object mmEnderecoCliente: TfrxMemoView
          Left = 7.559055120000000000
          Top = 58.023553700000410000
          Width = 64.251968500000000000
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
          WordWrap = False
        end
        object dbEnderecoCliente: TfrxMemoView
          Left = 75.590551180000000000
          Top = 58.023553700000410000
          Width = 370.393700790000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ENDERC"]')
          ParentFont = False
          WordWrap = False
        end
        object mmFoneCliente: TfrxMemoView
          Left = 449.543307090000000000
          Top = 109.047175750000000000
          Width = 52.913393150000000000
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
          WordWrap = False
        end
        object dbBairroCliente: TfrxMemoView
          Left = 502.133858270000000000
          Top = 58.023553700000010000
          Width = 245.669303540000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."BAIRRO"]')
          ParentFont = False
          WordWrap = False
        end
        object dbTelefoneCliente: TfrxMemoView
          Left = 502.133858270000000000
          Top = 109.047175750000000000
          Width = 244.409710000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxRelatorio."FONCLI">) > 0 ,'
            ' fFormataFone(<frxRelatorio."FONCLI">),'#39#39')]')
          ParentFont = False
          WordWrap = False
        end
        object mmCNPJCliente: TfrxMemoView
          Left = 7.559055120000000000
          Top = 92.039301730000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ/CPF:  ')
          ParentFont = False
          WordWrap = False
        end
        object dbCNPJCliente: TfrxMemoView
          Left = 75.590551180000000000
          Top = 92.039301730000000000
          Width = 370.393700790000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataCpfCgc(<frxRelatorio."CGCCLI">)]')
          ParentFont = False
          WordWrap = False
        end
        object mmIECliente: TfrxMemoView
          Left = 449.543307090000000000
          Top = 92.039301730000000000
          Width = 52.913393150000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'IE/RG:  ')
          ParentFont = False
          WordWrap = False
        end
        object dbIECliente: TfrxMemoView
          Left = 502.133858270000000000
          Top = 92.039301730000000000
          Width = 245.669303540000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."IESCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 7.559055120000000000
          Top = 109.149525750000000000
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
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 449.543307090000000000
          Top = 58.023553700000010000
          Width = 52.913393150000000000
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
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 7.559055120000000000
          Top = 75.031427720000500000
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
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 449.543307090000000000
          Top = 75.031427720000010000
          Width = 52.913393150000000000
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
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 75.590551180000000000
          Top = 75.031427720000500000
          Width = 370.393700790000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CIDCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 502.133858270000000000
          Top = 75.031427720000010000
          Width = 245.669303540000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxRelatorio."CEPCLI">) > 0 ,'
            ' FormatMaskText('#39'00000-000;0'#39',<frxRelatorio."CEPCLI">),'#39#39')]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 75.590551180000000000
          Top = 109.149525750000000000
          Width = 370.393700790000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataCondPag(<frxRelatorio."CONPAG">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 449.543307090000000000
          Top = 24.007805670000010000
          Width = 52.913393150000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo:')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 7.559055120000000000
          Top = 41.015679690000290000
          Width = 64.251968500000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fantasia:  ')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 76.590551180000000000
          Top = 41.015679690000010000
          Width = 672.756112990000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FANTAS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 502.133858270000000000
          Top = 24.007805670000010000
          Width = 245.669303540000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object rllMotCancel: TfrxMemoView
          Left = 449.764070000000000000
          Top = 2.000000000000000000
          Width = 298.582870000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 7.559060000000000000
          Top = 144.519790000000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Transp.:')
          ParentFont = False
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Left = 75.590556060000000000
          Top = 144.519790000000000000
          Width = 370.393700790000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMTRA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 449.543307090000000000
          Top = 126.724490000000000000
          Width = 52.913393150000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tipo Fat.:')
          ParentFont = False
          WordWrap = False
        end
        object Memo48: TfrxMemoView
          Left = 502.133858270000000000
          Top = 126.724485120000000000
          Width = 244.409710000000000000
          Height = 15.118120000000000000
          DataField = 'TIPPED'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."TIPPED"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbUrgente: TfrxMemoView
          Left = 351.496290000000000000
          Top = 1.968435590000013000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'URGENTE')
          ParentFont = False
          VAlign = vaBottom
        end
        object rllForPag: TfrxMemoView
          Left = 7.559060000000000000
          Top = 126.826840000000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Forma Pgto.:')
          ParentFont = False
          WordWrap = False
        end
        object rllDesForPag: TfrxMemoView
          Left = 75.590556060000000000
          Top = 126.826840000000000000
          Width = 370.393700790000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CODFPG"> <> '#39#39', <frxRelatorio."CODFPG"> + '#39' ' +
              '- '#39' + fRetDesForPag(<frxRelatorio."CODFPG">), '#39#39')]')
          ParentFont = False
          WordWrap = False
        end
      end
      object CMetragem: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 476.220780000000000000
        Width = 755.906000000000000000
        object rllMetragem: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 752.126470000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
      end
      object chdTotais: TfrxChild
        FillType = ftBrush
        Height = 54.803149606299210000
        Top = 600.945270000000000000
        Width = 755.906000000000000000
        Child = frxPagina.Child4
        PrintChildIfInvisible = True
        Stretched = True
        object Line1: TfrxLineView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 748.346432280000000000
          Color = clBlack
          Diagonal = True
        end
        object rllDesAce: TfrxMemoView
          Left = 195.165190790000000000
          Top = 37.897650000000000000
          Width = 113.385851180000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Despesas acess'#243'rias:')
          ParentFont = False
          WordWrap = False
        end
        object rllDesEsp: TfrxMemoView
          Left = 392.850410790000000000
          Top = 37.897650000000000000
          Width = 102.047241650000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Desconto Especial:')
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 584.220203940000000000
          Top = 37.897650000000000000
          Width = 77.480314960000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
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
        object rldDesAce: TfrxMemoView
          Left = 311.818934250000000000
          Top = 37.897650000000000000
          Width = 75.590492600000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'rldDesAceOnBeforePrint'
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
            '')
          ParentFont = False
          WordWrap = False
        end
        object rldDesEsp: TfrxMemoView
          Left = 499.795434250000000000
          Top = 37.897650000000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'rldDesEspOnBeforePrint'
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
            '')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalGeral: TfrxMemoView
          Left = 664.834391810000000000
          Top = 37.897650000000000000
          Width = 88.818897640000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'rllTotalGeralOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object rllBasICM: TfrxMemoView
          Left = 6.873910790000000000
          Top = 5.779530000000023000
          Width = 90.708671180000000000
          Height = 15.118120000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Base ICMS:')
          ParentFont = False
          WordWrap = False
        end
        object rldBasIcm: TfrxMemoView
          Left = 100.818934250000000000
          Top = 5.779530000000023000
          Width = 75.590492600000000000
          Height = 15.118120000000000000
          Visible = False
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
            '[frxRelatorio."BASICM"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValIcm: TfrxMemoView
          Left = 195.165190790000000000
          Top = 21.677180000000020000
          Width = 113.385851180000000000
          Height = 15.118120000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor ICMS:')
          ParentFont = False
          WordWrap = False
        end
        object rldValIcm: TfrxMemoView
          Left = 311.818934250000000000
          Top = 21.677180000000020000
          Width = 75.590492600000000000
          Height = 15.118120000000000000
          Visible = False
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
            '[frxRelatorio."VALICM"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValSub: TfrxMemoView
          Left = 195.165190790000000000
          Top = 5.779530000000023000
          Width = 113.385851180000000000
          Height = 15.118120000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor ICM Sub:')
          ParentFont = False
          WordWrap = False
        end
        object rldValSub: TfrxMemoView
          Left = 311.818934250000000000
          Top = 5.779530000000023000
          Width = 75.590492600000000000
          Height = 15.118120000000000000
          Visible = False
          OnBeforePrint = 'rldValSubOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object rllValFre: TfrxMemoView
          Left = 392.850410790000000000
          Top = 21.677180000000020000
          Width = 102.047241650000000000
          Height = 15.118120000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Frete:')
          ParentFont = False
          WordWrap = False
        end
        object rldValFre: TfrxMemoView
          Left = 499.795434250000000000
          Top = 21.677180000000020000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          Visible = False
          OnBeforePrint = 'rldValFreOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Left = 584.220203940000000000
          Top = 5.779530000000023000
          Width = 77.480314960000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Total Produtos:')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalProdutos: TfrxMemoView
          Left = 664.834391810000000000
          Top = 5.779530000000023000
          Width = 88.818897640000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'rllTotalProdutosOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object rllValIpi: TfrxMemoView
          Left = 584.220203940000000000
          Top = 21.677180000000020000
          Width = 77.480314960000000000
          Height = 15.118120000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor IPI:')
          ParentFont = False
          WordWrap = False
        end
        object rldValIpi: TfrxMemoView
          Left = 664.834391810000000000
          Top = 21.677180000000020000
          Width = 88.818897640000000000
          Height = 15.118120000000000000
          Visible = False
          OnBeforePrint = 'rldValIpiOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo51: TfrxMemoView
          Left = 6.873910790000000000
          Top = 21.000000000000000000
          Width = 90.708671180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Peso:')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 100.818934250000000000
          Top = 21.000000000000000000
          Width = 75.590492600000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PESBRU"]')
          ParentFont = False
        end
        object lblTotalM3: TfrxMemoView
          Left = 6.873910790000000000
          Top = 37.897650000000000000
          Width = 90.708671180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object dbeTotalM3: TfrxMemoView
          Left = 100.818934250000000000
          Top = 37.897650000000000000
          Width = 75.590492600000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 392.850410790000000000
          Top = 5.779530000000023000
          Width = 102.047241650000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Total Servi'#231'os:')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalServicos: TfrxMemoView
          Left = 499.795434250000000000
          Top = 5.779530000000023000
          Width = 75.590551180000010000
          Height = 15.118120000000000000
          OnBeforePrint = 'rllTotalServicosOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
      end
      object VendasPerdidas: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1262.363020000000000000
        Width = 755.906000000000000000
        object Subreport_VdPerdidas: TfrxSubreport
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Page = frxPagina.Subreport_VendasPerdidas
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 789.921770000000000000
        Width = 755.906000000000000000
        Child = frxPagina.Child3
        Stretched = True
        object Memo56: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 64.251968500000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Classif.IPI:  ')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Left = 71.811026060000000000
          Top = 3.779530000000022000
          Width = 676.535642990000000000
          Height = 30.236220470000000000
          StretchMode = smMaxHeight
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLAIPI]')
          ParentFont = False
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Height = 249.448980000000000000
        Top = 854.173780000000000000
        Width = 755.906000000000000000
        Child = frxPagina.rlbDocDev
        object Memo25: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.937044489999948000
          Width = 64.251968500000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Mensagem:  ')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllMen001: TfrxMemoView
          Left = 71.811026060000000000
          Top = 3.779530000000022000
          Width = 672.756112990000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MEN001"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllMen002: TfrxMemoView
          Left = 71.811026060000000000
          Top = 18.677180000000020000
          Width = 672.756112990000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MEN002"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 3.779530000000000000
          Top = 79.795300000000000000
          Width = 64.251968500000000000
          Height = 30.236230240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Mensagem'
            'Expedi'#231#227'o:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo59: TfrxMemoView
          Left = 71.811026060000000000
          Top = 78.795300000000000000
          Width = 672.756112990000000000
          Height = 60.472470240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MENEXP"]'
            '[frxRelatorio."MENEX2"]'
            '[frxRelatorio."MENEX3"]'
            '[frxRelatorio."MENEX4"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Top = 184.031540000000100000
          Width = 71.811028500000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'End. Entrega:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo61: TfrxMemoView
          Left = 78.149660000000000000
          Top = 184.031540000000100000
          Width = 667.086621500000000000
          Height = 30.236220470000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDENT]')
          ParentFont = False
        end
        object mmoMsgOrc: TfrxMemoView
          Left = 71.811070000000000000
          Top = 138.929190000000000000
          Width = 672.756340000000000000
          Height = 45.354330710000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTitRep: TfrxMemoView
          Left = 3.779530000000000000
          Top = 215.519789999999900000
          Width = 83.149618500000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Representante:  ')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbNomRep: TfrxMemoView
          Left = 88.149660000000000000
          Top = 215.519789999999900000
          Width = 351.496062990000000000
          Height = 15.118110240000000000
          DataField = 'REPRES'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."REPRES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllMen003: TfrxMemoView
          Left = 71.811323860000000000
          Top = 33.692949999999990000
          Width = 672.756112990000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MEN003"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllMen004: TfrxMemoView
          Left = 71.811323860000000000
          Top = 48.590599999999990000
          Width = 672.756112990000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MEN004"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllMen005: TfrxMemoView
          Left = 71.811323860000000000
          Top = 63.488250000000000000
          Width = 672.756112990000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MEN005"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoMsgPed: TfrxMemoView
          Left = 3.779783860000000000
          Top = 231.771800000000100000
          Width = 738.897691500000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MSGPED]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object CMecanico: TfrxChild
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 752.126470000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'CMecanicoOnBeforePrint'
        Child = frxPagina.Child2
        PrintChildIfInvisible = True
        Stretched = True
        object Memo62: TfrxMemoView
          Left = 3.779527559055120000
          Width = 71.811028500000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Mec'#226'nico(s):  ')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo63: TfrxMemoView
          Left = 78.590560940000000000
          Width = 676.535642990000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MECANI"]')
          ParentFont = False
        end
      end
      object Child4: TfrxChild
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 680.315400000000000000
        Width = 755.906000000000000000
        Child = frxPagina.CMecanico
        PrintChildIfInvisible = True
        object Line2: TfrxLineView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 748.346432280000000000
          Color = clBlack
          Diagonal = True
        end
        object rllTitVen: TfrxMemoView
          Left = 6.803149606299213000
          Top = 2.582699130000037000
          Width = 64.251968500000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendedor:  ')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 75.590302200000000000
          Top = 2.582699130000037000
          Width = 351.496062990000000000
          Height = 15.118110240000000000
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."VENDED"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllDigita: TfrxMemoView
          Left = 6.803149606299213000
          Top = 17.532853960000010000
          Width = 64.251968500000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Digitador:  ')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbDigita: TfrxMemoView
          Left = 75.590302200000000000
          Top = 17.532853960000010000
          Width = 351.496062990000000000
          Height = 15.118110240000000000
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DIGITA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 584.220203940000000000
          Top = 2.582699130000037000
          Width = 77.480314960000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Data:')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 664.834391810000000000
          Top = 2.582694250000031000
          Width = 88.818897640000000000
          Height = 15.118120000000000000
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 584.220203940000000000
          Top = 17.532853960000010000
          Width = 77.480314960000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Hora:')
          ParentFont = False
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 664.834391810000000000
          Top = 17.532849080000010000
          Width = 88.818897640000000000
          Height = 15.118120000000000000
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."HORENT"]')
          ParentFont = False
          WordWrap = False
        end
        object rllDigOri: TfrxMemoView
          Left = 6.803149606299213000
          Top = 32.483008789999990000
          Width = 120.944918500000000000
          Height = 15.118110240000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Digitador Doc. Origem:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbDigOri: TfrxMemoView
          Left = 132.590302200000000000
          Top = 32.483008789999990000
          Width = 351.496062990000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DIGORI]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
    object PageDuplicatas: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object TopoDuplic: TfrxHeader
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo41: TfrxMemoView
          Left = 6.338590000000000000
          Top = 2.023622050000000000
          Width = 45.354360000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parcela')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 73.283550000000000000
          Top = 2.023622050000000000
          Width = 68.031540000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
          WordWrap = False
        end
        object Memo43: TfrxMemoView
          Left = 155.126160000000000000
          Top = 2.023622050000000000
          Width = 75.590600000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
          WordWrap = False
        end
      end
      object DetalheDuplic: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 60.472480000000000000
        Width = 755.906000000000000000
        DataSet = frxDuplicatas
        DataSetName = 'frxDuplicatas'
        RowCount = 0
        object Memo44: TfrxMemoView
          Left = 6.338590000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDuplicatas."SEQUENCIA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo46: TfrxMemoView
          Left = 73.283550000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataField = 'VENCIMENTO'
          DataSet = frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDuplicatas."VENCIMENTO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 155.126160000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataSet = frxDuplicatas
          DataSetName = 'frxDuplicatas'
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
            '[frxDuplicatas."VALOR"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object PageRomaneio: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object TopoRomaneio: TfrxHeader
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Shape2: TfrxShapeView
          Top = 12.559060000000000000
          Width = 755.905492280000000000
          Height = 37.795275590000000000
          Fill.BackColor = clSilver
        end
        object Memo21: TfrxMemoView
          Left = 6.803149610000000000
          Top = 14.669291340000000000
          Width = 60.472440940000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Romaneio')
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Left = 70.645735200000000000
          Top = 12.559060000000000000
          Height = 18.897637795275600000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo22: TfrxMemoView
          Left = 73.700787400000000000
          Top = 14.669291340000000000
          Width = 117.165364090000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 197.535442830000000000
          Top = 14.669291340000000000
          Width = 366.614136610000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Motorista')
          ParentFont = False
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 572.929133860000000000
          Top = 14.669291340000000000
          Width = 117.165364090000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Baixa')
          ParentFont = False
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 698.291338580000000000
          Top = 14.669291340000000000
          Width = 52.913390710000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Entregue')
          ParentFont = False
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 6.803149610000000000
          Top = 34.456710000000000000
          Width = 90.708690710000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Observa'#231#227'o')
          ParentFont = False
          WordWrap = False
        end
        object Line6: TfrxLineView
          Left = 194.181200000000000000
          Top = 12.559060000000000000
          Height = 18.897637795275600000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line10: TfrxLineView
          Left = 567.961040000000000000
          Top = 12.559060000000000000
          Height = 18.897637795275600000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line11: TfrxLineView
          Left = 693.669760000000000000
          Top = 12.559060000000000000
          Height = 18.897637795275600000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line12: TfrxLineView
          Top = 31.370078740157500000
          Width = 755.905511810000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Detalhes_Romaneio: TfrxMasterData
        FillType = ftBrush
        Height = 38.551181100000000000
        Top = 94.488250000000000000
        Width = 755.906000000000000000
        DataSet = frxRomaneio
        DataSetName = 'frxRomaneio'
        RowCount = 0
        object Memo35: TfrxMemoView
          Left = 6.803149610000000000
          Top = 1.889763779999996000
          Width = 64.251970940000000000
          Height = 15.118120000000000000
          DataField = 'HIS_NUMROM'
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRomaneio."HIS_NUMROM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 73.700787400000000000
          Top = 1.889763779999996000
          Width = 120.944894090000000000
          Height = 15.118120000000000000
          DataField = 'HIS_DTAROM'
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRomaneio."HIS_DTAROM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 197.535442830000000000
          Top = 1.889763779999996000
          Width = 355.275546610000000000
          Height = 15.118120000000000000
          DataField = 'HIS_NOMMOT'
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRomaneio."HIS_NOMMOT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 572.929133860000000000
          Top = 1.889763779999996000
          Width = 120.944894090000000000
          Height = 15.118120000000000000
          DataField = 'HIS_DTABAI'
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRomaneio."HIS_DTABAI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 698.291338580000000000
          Top = 1.889763779999996000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
          DataField = 'HIS_ENTREG'
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRomaneio."HIS_ENTREG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 6.803149610000000000
          Top = 17.677180000000010000
          Width = 744.567370940000000000
          Height = 15.118120000000000000
          DataField = 'HIS_OBSERV'
          DataSet = frxRomaneio
          DataSetName = 'frxRomaneio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRomaneio."HIS_OBSERV"]')
          ParentFont = False
          WordWrap = False
        end
        object Line13: TfrxLineView
          Top = 34.795300000000000000
          Width = 755.905511811024000000
          Color = clBlack
          Diagonal = True
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        ReprintOnNewPage = True
        object Shape3: TfrxShapeView
          Left = 0.000244100000000000
          Top = 2.000000000000000000
          Width = 755.905511810000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object Memo10: TfrxMemoView
          Left = 6.559060000000000000
          Top = 4.118105350000001000
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
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 59.370130000000000000
          Top = 4.118105350000001000
          Width = 151.181200000000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o dos Servi'#231'os')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo65: TfrxMemoView
          Left = 681.826771653543000000
          Top = 4.118105350000001000
          Width = 69.921259840000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Total')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line16: TfrxLineView
          Left = 54.590600000000000000
          Top = 2.377958860000039000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line20: TfrxLineView
          Left = 678.425196850394000000
          Top = 2.377958860000000000
          Height = 18.141732280000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object Servicos: TfrxMasterData
        FillType = ftBrush
        Height = 14.787406460000000000
        Top = 64.252010000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'ServicosOnBeforePrint'
        DataSet = frxServicos
        DataSetName = 'frxServicos'
        RowCount = 0
        Stretched = True
        object Memo69: TfrxMemoView
          Left = 6.338590000000000000
          Top = 0.377952759999999400
          Width = 45.354330710000000000
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
            '[frxServicos."CODSER"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo70: TfrxMemoView
          Left = 59.929190000000000000
          Top = 0.377952759999999400
          Width = 614.173438270000000000
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
            '[frxServicos."DESSER"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo74: TfrxMemoView
          Left = 681.826771650000000000
          Top = 0.377952759999999400
          Width = 69.921259840000000000
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
            '[frxServicos."VALSER"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
    object Subreport_VendasPerdidas: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 14.740157480000000000
        Top = 79.370130000000000000
        Width = 755.906000000000000000
        DataSet = frxVendasPerdidas
        DataSetName = 'frxVendasPerdidas'
        RowCount = 0
        object Memo68: TfrxMemoView
          Left = 7.559060000000000000
          Width = 56.692920710000000000
          Height = 13.228346460000000000
          DataField = 'CODITE'
          DataSet = frxVendasPerdidas
          DataSetName = 'frxVendasPerdidas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxVendasPerdidas."CODITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo71: TfrxMemoView
          Left = 71.811069999999990000
          Width = 423.307330709999900000
          Height = 13.228346460000000000
          DataField = 'DESITE'
          DataSet = frxVendasPerdidas
          DataSetName = 'frxVendasPerdidas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxVendasPerdidas."DESITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo72: TfrxMemoView
          Left = 502.677490000000000000
          Width = 68.031510710000000000
          Height = 13.228346460000000000
          DataField = 'QTDITE'
          DataSet = frxVendasPerdidas
          DataSetName = 'frxVendasPerdidas'
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
            '[frxVendasPerdidas."QTDITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo73: TfrxMemoView
          Left = 578.268090000000000000
          Width = 79.370100710000000000
          Height = 13.228346460000000000
          DataField = 'UNITAR'
          DataSet = frxVendasPerdidas
          DataSetName = 'frxVendasPerdidas'
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
            '[frxVendasPerdidas."UNITAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo75: TfrxMemoView
          Left = 665.197280000000000000
          Width = 83.149630710000000000
          Height = 13.228346460000000000
          DataField = 'TOTITE'
          DataSet = frxVendasPerdidas
          DataSetName = 'frxVendasPerdidas'
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
            '[frxVendasPerdidas."TOTITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 117.165430000000000000
        Width = 755.906000000000000000
        object Memo76: TfrxMemoView
          Left = 589.606680000000000000
          Top = 3.779529999999994000
          Width = 68.031510710000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo78: TfrxMemoView
          Left = 665.197280000000000000
          Top = 3.779529999999994000
          Width = 83.149630710000000000
          Height = 13.228346460000000000
          DataSet = frxVendasPerdidas
          DataSetName = 'frxVendasPerdidas'
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
            '[SUM(<frxVendasPerdidas."TOTITE">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 37.795285350000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Shape6: TfrxShapeView
          Align = baClient
          Width = 755.906000000000000000
          Height = 37.795285350000000000
          Fill.BackColor = clSilver
        end
        object Memo79: TfrxMemoView
          Left = 7.559060000000000000
          Top = 22.677180000000000000
          Width = 56.692920710000000000
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
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo80: TfrxMemoView
          Left = 71.811069999999990000
          Top = 22.677180000000000000
          Width = 154.960700710000000000
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
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo81: TfrxMemoView
          Left = 502.677490000000000000
          Top = 22.677180000000000000
          Width = 68.031510710000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo82: TfrxMemoView
          Left = 578.268090000000000000
          Top = 22.677180000000000000
          Width = 79.370100710000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. UNIT')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo83: TfrxMemoView
          Left = 665.197280000000000000
          Top = 22.677180000000000000
          Width = 83.149630710000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. TOTAL')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo77: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000001000
          Width = 740.787850710000000000
          Height = 13.606299210000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELA'#199#195'O DE ITENS CORTADOS')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
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
    Left = 154
    Top = 17
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    DataSet = qryRelatorio
    BCDToCurrency = False
    Left = 66
    Top = 46
  end
  object frxRomaneio: TfrxDBDataset
    UserName = 'frxRomaneio'
    CloseDataSource = False
    DataSet = qryRomaneio
    BCDToCurrency = False
    Left = 95
    Top = 46
  end
  object qryRelatorio: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Left = 65
    Top = 16
  end
  object qryRomaneio: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT '
      '  HIS_NUMROM, '
      '  CONCAT(HIS_DTAROM, " - ", HIS_HORROM) HIS_DTAROM, '
      '  CONCAT(HIS_CODMOT, " - ", MOT_NOMMOT) HIS_NOMMOT, '
      '  CONCAT(HIS_DTABAI, " - ", HIS_HORBAI) HIS_DTABAI, '
      '  IF(HIS_ENTREG, "SIM", "N'#195'O") HIS_ENTREG, '
      '  HIS_OBSERV '
      'FROM '
      '  HISPED '
      '  JOIN CADMOT ON MOT_CODMOT = HIS_CODMOT ')
    ReadOnly = True
    Left = 94
    Top = 16
    object qryRomaneioHIS_NUMROM: TStringField
      FieldName = 'HIS_NUMROM'
      Required = True
      Size = 6
    end
    object qryRomaneioHIS_DTAROM: TStringField
      FieldName = 'HIS_DTAROM'
      Required = True
      Size = 21
    end
    object qryRomaneioHIS_NOMMOT: TStringField
      FieldName = 'HIS_NOMMOT'
      Required = True
      Size = 48
    end
    object qryRomaneioHIS_DTABAI: TStringField
      FieldName = 'HIS_DTABAI'
      Size = 21
    end
    object qryRomaneioHIS_ENTREG: TStringField
      FieldName = 'HIS_ENTREG'
      Required = True
      Size = 3
    end
    object qryRomaneioHIS_OBSERV: TMemoField
      FieldName = 'HIS_OBSERV'
      BlobType = ftMemo
    end
  end
  object cdsDuplicatas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 36
    Top = 16
    object cdsDuplicatasVALOR: TFloatField
      FieldName = 'VALOR'
    end
    object cdsDuplicatasVENCIMENTO: TStringField
      FieldName = 'VENCIMENTO'
      Size = 10
    end
    object cdsDuplicatasSEQUENCIA: TStringField
      FieldName = 'SEQUENCIA'
      Size = 7
    end
  end
  object frxDuplicatas: TfrxDBDataset
    UserName = 'frxDuplicatas'
    CloseDataSource = False
    DataSet = cdsDuplicatas
    BCDToCurrency = False
    Left = 36
    Top = 45
  end
  object qryModalidades: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Left = 124
    Top = 17
    object qryModalidadesMOD_NUMDOC: TStringField
      FieldName = 'MOD_NUMDOC'
      Size = 12
    end
    object qryModalidadesMOD_ESPDOC: TStringField
      FieldName = 'MOD_ESPDOC'
      Size = 2
    end
    object qryModalidadesMOD_CODEMP: TStringField
      FieldName = 'MOD_CODEMP'
      Size = 3
    end
    object qryModalidadesMOD_CODCLI: TStringField
      FieldName = 'MOD_CODCLI'
      Size = 8
    end
    object qryModalidadesMOD_SERIE_: TStringField
      FieldName = 'MOD_SERIE_'
      Size = 3
    end
    object qryModalidadesMOD_CODMOD: TStringField
      FieldName = 'MOD_CODMOD'
      Size = 3
    end
    object qryModalidadesMOD_DESMOD: TStringField
      FieldName = 'MOD_DESMOD'
      Size = 50
    end
    object qryModalidadesMOD_VALMOD: TFloatField
      FieldName = 'MOD_VALMOD'
    end
    object qryModalidadesMOD_DOCUME: TStringField
      FieldName = 'MOD_DOCUME'
      Size = 100
    end
    object qryModalidadesMOD_DTAVEN: TDateField
      FieldName = 'MOD_DTAVEN'
    end
    object qryModalidadesAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
  end
  object frxModalidades: TfrxDBDataset
    UserName = 'frxModalidades'
    CloseDataSource = False
    FieldAliases.Strings = (
      'MOD_NUMDOC=MOD_NUMDOC'
      'MOD_ESPDOC=MOD_ESPDOC'
      'MOD_CODEMP=MOD_CODEMP'
      'MOD_CODCLI=MOD_CODCLI'
      'MOD_SERIE_=MOD_SERIE_'
      'MOD_CODMOD=MOD_CODMOD'
      'MOD_DESMOD=MOD_DESMOD'
      'MOD_VALMOD=MOD_VALMOD'
      'MOD_DOCUME=MOD_DOCUME'
      'MOD_DTAVEN=MOD_DTAVEN'
      'AUTOINCREM=AUTOINCREM')
    DataSet = qryModalidades
    BCDToCurrency = False
    Left = 124
    Top = 46
  end
  object cdsServicos: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 5
    Top = 15
  end
  object frxServicos: TfrxDBDataset
    UserName = 'frxServicos'
    CloseDataSource = False
    DataSet = cdsServicos
    BCDToCurrency = False
    Left = 4
    Top = 45
  end
  object frxVendasPerdidas: TfrxDBDataset
    UserName = 'frxVendasPerdidas'
    CloseDataSource = False
    DataSet = qryVendasPerdidas
    BCDToCurrency = False
    Left = 4
    Top = 80
  end
  object qryVendasPerdidas: TUniQuery
    Connection = frmModulo.Database
    Left = 38
    Top = 80
  end
end
