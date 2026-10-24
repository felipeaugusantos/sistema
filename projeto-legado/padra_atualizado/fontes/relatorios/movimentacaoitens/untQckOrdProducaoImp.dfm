object frmQckOrdProducaoImp: TfrmQckOrdProducaoImp
  Left = 0
  Top = 0
  ClientHeight = 324
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxImpressaoJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45282.453144780090000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  fltQtdAcu : Double;'
      ''
      'procedure mmo1HCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<REFERE>) then      '
      
        '    TfrxMemoView(Sender).Text := '#39'REFERENCIA'#39';                  ' +
        '              '
      'end;  '
      '  '
      'procedure mmo1ProdBaseOnBeforePrint(Sender: TfrxComponent);'
      'Var'
      '  strDesIte: String;'
      'begin'
      '  strDesIte := fRetNomProduto(<frxRelatorio."CODBAS">);'
      ''
      
        '  If (Pos('#39'ITEM ESPECIAL'#39', strDesIte) > 0) And (<frxRelatorio."D' +
        'ESBAS"> <> '#39#39') Then'
      '    strDesIte := <frxRelatorio."DESBAS">;'
      ''
      
        '  TfrxMemoView(Sender).Text := <frxRelatorio."CODBAS"> + '#39' - '#39' +' +
        ' strDesIte;'
      'end;'
      ''
      'procedure mmo3ProdBaseOnBeforePrint(Sender: TfrxComponent);'
      'Var'
      '  strDesIte: String;'
      'begin'
      
        '  strDesIte := fRetNomProduto(<frxRelatorio."CODBAS">) + '#39' - '#39' +' +
        ' fRetReferenciaProd(<frxRelatorio."CODBAS">);'
      ''
      
        '  If (Pos('#39'ITEM ESPECIAL'#39', strDesIte) > 0) And (<frxRelatorio."D' +
        'ESBAS"> <> '#39#39') Then'
      '    strDesIte := <frxRelatorio."DESBAS">;'
      ''
      
        '  TfrxMemoView(Sender).Text := <frxRelatorio."CODBAS"> + '#39' - '#39' +' +
        ' strDesIte;'
      'end;'
      ''
      'procedure mmo1QuantidadeOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(Sender).Text := '#39'QUANT.: '#39' + fFloatToStrF(<frxRel' +
        'atorio."QTDBAS">);'
      'end;'
      ''
      'procedure mmo1MLocFisOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <MODELO> = '#39'3'#39' then'
      '  begin'
      '       TfrxMemoView(Sender).Text := <frxRelatorio."LOCFIS">'
      '  end;'
      'end;'
      ''
      'procedure mmo1MNumlotOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <MODELO> = '#39'3'#39' then'
      '  begin'
      '        TfrxMemoView(Sender).Text := <frxRelatorio."NUMLOT">'
      '  end;'
      'end;'
      ''
      'procedure mmo1MCodigoOnBeforePrint(Sender: TfrxComponent);'
      'var'
      '   strProduto : String;'
      'begin'
      '  strProduto := <frxRelatorio."COMENT">;'
      ''
      '  if strProduto = '#39#39' then'
      '  begin'
      '    if <REFERE> then'
      '      strProduto :=  <frxRelatorio."REFERE">'
      '    else'
      
        '      strProduto :=  <frxRelatorio."CODITE"> + '#39' - '#39' + fRetNomPr' +
        'oduto(<frxRelatorio."CODITE">);'
      '  end;'
      ''
      '   TfrxMemoView(Sender).Text := strProduto;'
      ''
      'end;'
      ''
      'procedure mmo3MCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '   TfrxMemoView(Sender).Text := <frxRelatorio."CODITE"> + '#39' - '#39' ' +
        '+ fRetNomProduto(<frxRelatorio."CODITE">);'
      'end;'
      ''
      'procedure mmo1MQtdAcuOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if TfrxMemoView(Sender).Visible = True then'
      '  begin'
      '    if <frxRelatorio."ACUMOP"> = '#39'S'#39' then'
      '    begin'
      '        TfrxMemoView(Sender).Text := fFloatToStrF(fltQtdAcu);'
      '    end;'
      '  end;'
      'end;'
      ''
      'procedure mmo1MQtdIteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '   if <frxRelatorio."ACUMOP"> = '#39'S'#39' then'
      '  begin'
      '    fltQtdAcu := fltQtdAcu + <frxRelatorio."QTDITE">'
      '  end;'
      'end;'
      ''
      'Begin'
      '   fltQtdAcu := 0;'
      '   qckPagina.Visible := False;'
      '   qckMod2.Visible := False;'
      '   qckMod3.Visible := False;'
      '   qckMod4.Visible := False;'
      ''
      '  if (<MODELO> = '#39'1'#39') or (<MODELO> = '#39'3'#39') then'
      '  begin'
      '    qckPagina.Visible := True;'
      ''
      '    if <MODELO> = '#39'1'#39' then'
      '    begin'
      '      mmo1HNumlot.Visible := False;'
      '      mmo1HNumlot.Visible := False;'
      ''
      '      mmo1HCodigo.Left := mmo1HNumlot.Left;'
      '      mmo1MCodigo.Left := mmo1MNumlot.Left;'
      
        '      mmo1MCodigo.Width := mmo1MCodigo.Width + mmo1MNumlot.Width' +
        ';'
      '    end;'
      ''
      '    if <QDPRES> = '#39'N'#39' then'
      '    begin'
      '      mmo1HQtdAcu.Visible := False;'
      '      mmo1MQtdAcu.Visible := False;'
      ''
      '      mmo1HQtdIte.Left := mmo1HQtdAcu.Left;'
      '      mmo1MQtdIte.Left := mmo1MQtdAcu.Left;'
      '    end;'
      ''
      '  end;'
      ''
      '  if (<MODELO> = '#39'4'#39') then'
      '  begin'
      '    qckMod3.Visible := True;'
      ''
      '    if <QDPRES> = '#39'N'#39' then'
      '    begin'
      '      mmo3HQtdAcu.Visible := False;'
      '      mmo3MQtdAcu.Visible := False;'
      ''
      '      mmo3HQtdIte.Left := mmo3HQtdAcu.Left;'
      '      mmo3MQtdIte.Left := mmo3MQtdAcu.Left;'
      
        '      mmo3MReferencia.Width := mmo3MReferencia.Width + mmo3MQtdA' +
        'cu.Width;'
      ''
      '    end;'
      '  end;'
      ''
      '  if (<MODELO> = '#39'8'#39') then'
      '  begin'
      '    qckMod4.Visible := True;'
      ''
      '  end;'
      ''
      'end.')
    OnUserFunction = frxReportJUserFunction
    Left = 129
    Top = 41
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 140.000000000000000000
      PaperSize = 256
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 6.000000000000000000
      BottomMargin = 6.000000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 181.417440000000000000
        Width = 748.346940000000000000
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object mmo1HLocFis: TfrxMemoView
          Left = 3.779530000000000000
          Width = 109.606289450000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOC. FISICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo1HNumlot: TfrxMemoView
          Left = 120.944960000000000000
          Width = 94.488198740000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOTE')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo1HCodigo: TfrxMemoView
          Left = 219.212740000000000000
          Width = 211.653543310000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmo1HCodigoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CODIGO     DESCRICAO')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo1HQtdAcu: TfrxMemoView
          Left = 676.535870000000000000
          Width = 68.031496060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE ACUM')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo1HMetrag: TfrxMemoView
          Left = 604.724800000000000000
          Width = 68.031496060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'METROS')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo1HQtdite: TfrxMemoView
          Left = 532.913730000000000000
          Width = 68.031496060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE UNIT')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo1HNR: TfrxMemoView
          Left = 449.764070000000000000
          Width = 68.031496060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'N.R')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 222.992270000000000000
        Width = 748.346940000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmo1MLocFis: TfrxMemoView
          Left = 3.779530000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmo1MLocFisOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = False
        end
        object mmo1MNumlot: TfrxMemoView
          Left = 120.944960000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmo1MNumlotOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = False
        end
        object mmo1MCodigo: TfrxMemoView
          Left = 219.212740000000000000
          Width = 211.653680000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmo1MCodigoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."COMENT"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo1MQtdAcu: TfrxMemoView
          Left = 676.535870000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmo1MQtdAcuOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE ACUM')
          ParentFont = False
          WordWrap = False
        end
        object mmo1MMetrag: TfrxMemoView
          Left = 604.724800000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METRAG"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo1MQtdIte: TfrxMemoView
          Left = 532.913730000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmo1MQtdIteOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 102.047236770000000000
        Top = 18.897650000000000000
        Width = 748.346940000000000000
        object mmo1NumDoc: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 729.449290000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ORDEM DE PRODUCAO N'#186' [frxRelatorio."CODPRO"]')
          ParentFont = False
        end
        object mmo1Pedido: TfrxMemoView
          Left = 3.779530000000000000
          Top = 34.015770000000000000
          Width = 461.102660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
        end
        object mmo1Vendedor: TfrxMemoView
          Left = 468.661720000000000000
          Top = 34.015770000000000000
          Width = 200.315090000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENDEDOR: [frxRelatorio."CODVEN"] - [frxRelatorio."NOMVEN"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 3.779530000000000000
          Top = 60.472480000000000000
          Width = 740.787880000000000000
          Color = clBlack
          Frame.Width = 2.000000000000000000
          Diagonal = True
        end
        object mmo1ProdBase: TfrxMemoView
          Left = 3.779530000000000000
          Top = 66.252010000000000000
          Width = 461.102660000000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'mmo1ProdBaseOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baBottom
          Left = 3.779530000000000000
          Top = 102.047236770000000000
          Width = 740.787880000000000000
          Color = clBlack
          Frame.Width = 2.000000000000000000
          Diagonal = True
        end
        object mmo1Quantidade: TfrxMemoView
          Left = 468.661720000000000000
          Top = 66.252056380000000000
          Width = 200.315090000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmo1QuantidadeOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 94.488250000000000000
        Top = 298.582870000000000000
        Width = 748.346940000000000000
        object mmo1Obs: TfrxMemoView
          Left = 86.929190000000000000
          Top = 7.559060000000000000
          Width = 646.299630000000000000
          Height = 64.251973390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object mo1Obs: TfrxMemoView
          Top = 7.559060000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OBSERVACAO:')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 740.787880000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line4: TfrxLineView
          Left = 3.779530000000000000
          Top = 71.811070000000000000
          Width = 740.787880000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmo1Data: TfrxMemoView
          Left = 3.779530000000000000
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object mmo1Hora: TfrxMemoView
          Left = 631.181510000000000000
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TIME]')
          ParentFont = False
        end
      end
    end
    object qckMod2: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 140.000000000000000000
      PaperSize = 256
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 6.000000000000000000
      BottomMargin = 6.000000000000000000
      object PageHeader2: TfrxPageHeader
        FillType = ftBrush
        Height = 98.267780000000000000
        Top = 18.897650000000000000
        Width = 748.346940000000000000
        object mmo2Numdoc: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 729.449290000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ORDEM DE PRODUCAO N'#186' [frxRelatorio."CODPRO"]')
          ParentFont = False
        end
        object mmo2Pedido: TfrxMemoView
          Left = 3.779530000000000000
          Top = 34.015770000000000000
          Width = 461.102660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Left = 3.779530000000000000
          Top = 60.472480000000000000
          Width = 740.787880000000000000
          Color = clBlack
          Frame.Width = 2.000000000000000000
          Diagonal = True
        end
        object mmo2ProdBase: TfrxMemoView
          Left = 3.779530000000000000
          Top = 66.252010000000000000
          Width = 461.102660000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmo1ProdBaseOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          VAlign = vaCenter
        end
        object Line6: TfrxLineView
          Left = 3.779530000000000000
          Top = 90.708766380000000000
          Width = 740.787880000000000000
          Color = clBlack
          Frame.Width = 2.000000000000000000
          Diagonal = True
        end
        object mmo2Quantidade: TfrxMemoView
          Left = 468.661720000000000000
          Top = 66.252056380000000000
          Width = 275.905690000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmo1QuantidadeOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 177.637910000000000000
        Width = 748.346940000000000000
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object mmo2HSeparacao: TfrxMemoView
          Left = 3.779530000000000000
          Width = 113.385819450000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'SEPARACAO')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo2HCodigo: TfrxMemoView
          Left = 120.944960000000000000
          Width = 325.039443310000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmo1HCodigoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CODIGO     DESCRICAO')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo2HUnidad: TfrxMemoView
          Left = 593.386210000000000000
          Width = 34.015726060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo2HMetrag: TfrxMemoView
          Left = 521.575140000000000000
          Width = 68.031496060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'METROS')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo2HQtdIte: TfrxMemoView
          Left = 449.764070000000000000
          Width = 68.031496060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE UNIT')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo2HConferencia: TfrxMemoView
          Left = 631.181510000000000000
          Width = 113.385819450000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONFERENCIA')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 219.212740000000000000
        Width = 748.346940000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmo2MSeparacao: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559060000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '_______________________________')
          ParentFont = False
          WordWrap = False
        end
        object mmo2MCodigo: TfrxMemoView
          Left = 120.944960000000000000
          Width = 325.039580000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."COMENT"]')
          ParentFont = False
        end
        object mmo2MMetrag: TfrxMemoView
          Left = 521.575140000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METRAG"]')
          ParentFont = False
        end
        object mmo2MQtdIte: TfrxMemoView
          Left = 449.764070000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmo1MQtdIteOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
        end
        object mmo2MLocFis: TfrxMemoView
          Left = 120.944960000000000000
          Top = 15.118120000000000000
          Width = 325.039580000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOC.FISICA: [frxRelatorio."LOCFIS"]')
          ParentFont = False
        end
        object mmo2MUnidad: TfrxMemoView
          Left = 593.386210000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
        end
        object mmo2MConferencia: TfrxMemoView
          Left = 631.181510000000000000
          Top = 7.559060000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '_______________________________')
          ParentFont = False
          WordWrap = False
        end
      end
      object PageFooter2: TfrxPageFooter
        FillType = ftBrush
        Height = 94.488250000000000000
        Top = 309.921460000000000000
        Width = 748.346940000000000000
        object mmo2Obs: TfrxMemoView
          Left = 86.929190000000000000
          Top = 7.559060000000000000
          Width = 646.299630000000000000
          Height = 64.251973390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object mo2Obs: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559060000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OBSERVACAO:')
          ParentFont = False
        end
        object Line7: TfrxLineView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 740.787880000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line8: TfrxLineView
          Left = 3.779530000000000000
          Top = 71.811070000000000000
          Width = 740.787880000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmo2Data: TfrxMemoView
          Left = 3.779530000000000000
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object mmo2Hora: TfrxMemoView
          Left = 631.181510000000000000
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haBlock
          Memo.UTF8W = (
            '[TIME]')
          ParentFont = False
        end
      end
    end
    object qckMod3: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 140.000000000000000000
      PaperSize = 256
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 6.000000000000000000
      BottomMargin = 6.000000000000000000
      object PageHeader3: TfrxPageHeader
        FillType = ftBrush
        Height = 98.267780000000000000
        Top = 18.897650000000000000
        Width = 748.346940000000000000
        object mmo3Numdoc: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 729.449290000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ORDEM DE PRODUCAO N'#186' [frxRelatorio."CODPRO"]')
          ParentFont = False
        end
        object mmo3Pedido: TfrxMemoView
          Left = 3.779530000000000000
          Top = 34.015770000000000000
          Width = 461.102660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
        end
        object Line9: TfrxLineView
          Left = 3.779530000000000000
          Top = 60.472480000000000000
          Width = 740.787880000000000000
          Color = clBlack
          Frame.Width = 2.000000000000000000
          Diagonal = True
        end
        object mmo3ProdBase: TfrxMemoView
          Left = 3.779530000000000000
          Top = 66.252010000000000000
          Width = 461.102660000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmo3ProdBaseOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          VAlign = vaCenter
        end
        object Line10: TfrxLineView
          Left = 3.779530000000000000
          Top = 90.708766380000000000
          Width = 740.787880000000000000
          Color = clBlack
          Frame.Width = 2.000000000000000000
          Diagonal = True
        end
        object mmo3Quantidade: TfrxMemoView
          Left = 468.661720000000000000
          Top = 66.252056380000000000
          Width = 200.315090000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmo1QuantidadeOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header3: TfrxHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 177.637910000000000000
        Width = 748.346940000000000000
        object Shape3: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object mmo3HLocFisica: TfrxMemoView
          Left = 3.779530000000000000
          Width = 79.370049450000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOC. FISICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo3HCodigo: TfrxMemoView
          Left = 170.078850000000000000
          Width = 207.874013310000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CODIGO     DESCRICAO')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo3HUnidad: TfrxMemoView
          Left = 706.772110000000000000
          Width = 34.015726060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo3HMetrag: TfrxMemoView
          Left = 555.590910000000000000
          Width = 68.031496060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'METROS')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo3HReferencia: TfrxMemoView
          Left = 381.732530000000000000
          Width = 90.708668740000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo3HLote: TfrxMemoView
          Left = 86.929190000000000000
          Width = 79.370049450000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOTE')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo3HQtdIte: TfrxMemoView
          Left = 480.000310000000000000
          Width = 68.031496060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE UNIT')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo3HQtdAcu: TfrxMemoView
          Left = 631.181510000000000000
          Width = 68.031496060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE ACUM')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 219.212740000000000000
        Width = 748.346940000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmo3MLocFisica: TfrxMemoView
          Left = 3.779530000000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo3MLote: TfrxMemoView
          Left = 86.929190000000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMLOT"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo3MCodigo: TfrxMemoView
          Left = 170.078850000000000000
          Width = 207.874015750000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmo3MCodigoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = False
        end
        object mmo3MReferencia: TfrxMemoView
          Left = 381.732530000000000000
          Width = 90.708668740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."REFITE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo3MUnidade: TfrxMemoView
          Left = 706.772110000000000000
          Width = 34.015718740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo3MMetrag: TfrxMemoView
          Left = 555.590910000000000000
          Width = 68.031488740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METRAG"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo3MQtdIte: TfrxMemoView
          Left = 480.000310000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmo1MQtdIteOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo3MQtdAcu: TfrxMemoView
          Left = 631.181510000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmo1MQtdAcuOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE ACUM')
          ParentFont = False
          WordWrap = False
        end
      end
      object PageFooter3: TfrxPageFooter
        FillType = ftBrush
        Height = 94.488250000000000000
        Top = 294.803340000000000000
        Width = 748.346940000000000000
        object mmo3Obs: TfrxMemoView
          Left = 86.929190000000000000
          Top = 7.559060000000000000
          Width = 646.299630000000000000
          Height = 64.251973390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object mo3Obs: TfrxMemoView
          Top = 7.559060000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OBSERVACAO:')
          ParentFont = False
        end
        object Line13: TfrxLineView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 740.787880000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line14: TfrxLineView
          Left = 3.779530000000000000
          Top = 71.811070000000000000
          Width = 740.787880000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmo3Data: TfrxMemoView
          Left = 3.779530000000000000
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object mmo3Hora: TfrxMemoView
          Left = 631.181510000000000000
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haBlock
          Memo.UTF8W = (
            '[TIME]')
          ParentFont = False
        end
      end
    end
    object qckMod4: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 6.000000000000000000
      BottomMargin = 6.000000000000000000
      object PageHeader4: TfrxPageHeader
        FillType = ftBrush
        Height = 98.267780000000000000
        Top = 18.897650000000000000
        Width = 748.346940000000000000
        object mmo4Numdoc: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 729.449290000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ORDEM DE PRODUCAO N'#186' [frxRelatorio."CODPRO"]')
          ParentFont = False
        end
        object mmo4Pedido: TfrxMemoView
          Left = 3.779530000000000000
          Top = 34.015770000000000000
          Width = 461.102660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
        end
        object Line11: TfrxLineView
          Left = 3.779530000000000000
          Top = 60.472480000000000000
          Width = 740.787880000000000000
          Color = clBlack
          Frame.Width = 2.000000000000000000
          Diagonal = True
        end
        object mmo4ProdBase: TfrxMemoView
          Left = 3.779530000000000000
          Top = 66.252010000000000000
          Width = 461.102660000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmo3ProdBaseOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          VAlign = vaCenter
        end
        object Line12: TfrxLineView
          Left = 3.779530000000000000
          Top = 90.708766380000000000
          Width = 740.787880000000000000
          Color = clBlack
          Frame.Width = 2.000000000000000000
          Diagonal = True
        end
        object mmo4Quantidade: TfrxMemoView
          Left = 468.661720000000000000
          Top = 66.252056380000000000
          Width = 200.315090000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmo1QuantidadeOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header4: TfrxHeader
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 177.637910000000000000
        Width = 748.346940000000000000
        object Shape4: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 37.795300000000000000
          Fill.BackColor = clSilver
        end
        object mmo4HLocFis: TfrxMemoView
          Top = 18.897650000000000000
          Width = 94.488169450000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOC. FISICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo4HUnidad: TfrxMemoView
          Left = 517.795610000000000000
          Top = 18.897650000000000000
          Width = 34.015726060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo4HMetrag: TfrxMemoView
          Left = 374.173470000000000000
          Top = 18.897650000000000000
          Width = 68.031496060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'METROS')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo4HReferencia: TfrxMemoView
          Left = 196.535560000000000000
          Top = 18.897650000000000000
          Width = 94.488188980000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo4HNumlot: TfrxMemoView
          Left = 98.267780000000000000
          Top = 18.897650000000000000
          Width = 94.488169450000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOTE')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo4HQtdIte: TfrxMemoView
          Left = 298.582870000000000000
          Top = 18.897650000000000000
          Width = 68.031496060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE UNIT')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo4HQtdAcul: TfrxMemoView
          Left = 445.984540000000000000
          Top = 18.897650000000000000
          Width = 68.031496060000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE ACUM')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo4HCodigo: TfrxMemoView
          Left = 3.779530000000000000
          Width = 64.251929450000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmo4HDescricao: TfrxMemoView
          Left = 71.811070000000000000
          Width = 298.582789450000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData4: TfrxMasterData
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 238.110390000000000000
        Width = 748.346940000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmo4MLocFis: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000000000
          Width = 90.708668740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo4MNumlot: TfrxMemoView
          Left = 98.267780000000000000
          Top = 15.118120000000000000
          Width = 94.488198740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMLOT"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo4MCodigo: TfrxMemoView
          Left = 3.779530000000000000
          Width = 740.787745750000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmo3MCodigoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = False
        end
        object mmo4MRefere: TfrxMemoView
          Left = 196.535560000000000000
          Top = 15.118120000000000000
          Width = 94.488198740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."REFITE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo4MUnidad: TfrxMemoView
          Left = 517.795610000000000000
          Top = 15.118120000000000000
          Width = 34.015718740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo4MMetrag: TfrxMemoView
          Left = 374.173470000000000000
          Top = 15.118120000000000000
          Width = 68.031488740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METRAG"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo4MQtdIte: TfrxMemoView
          Left = 298.582870000000000000
          Top = 15.118120000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmo1MQtdIteOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo4MQtdAcu: TfrxMemoView
          Left = 445.984540000000000000
          Top = 15.118120000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmo1MQtdAcuOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE ACUM')
          ParentFont = False
          WordWrap = False
        end
      end
      object PageFooter4: TfrxPageFooter
        FillType = ftBrush
        Height = 94.488250000000000000
        Top = 328.819110000000000000
        Width = 748.346940000000000000
        object mmo4Obs: TfrxMemoView
          Left = 86.929190000000000000
          Top = 7.559060000000000000
          Width = 646.299630000000000000
          Height = 64.251973390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object mo4Obs: TfrxMemoView
          Top = 7.559060000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OBSERVACAO:')
          ParentFont = False
        end
        object Line15: TfrxLineView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 740.787880000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line16: TfrxLineView
          Left = 3.779530000000000000
          Top = 71.811070000000000000
          Width = 740.787880000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 631.181510000000000000
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haBlock
          Memo.UTF8W = (
            '[TIME]')
          ParentFont = False
        end
      end
    end
  end
  object frxImpressaoM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45282.462341898150000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  fltQtdAcu : Double;'
      ''
      'procedure mmo1HCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<REFERE>) then'
      '    TfrxDMPMemoView(Sender).Text := '#39'REFERENCIA'#39';'
      'end;'
      ''
      'procedure mmo1ProdBaseOnBeforePrint(Sender: TfrxComponent);'
      'Var'
      '  strDesIte: String;'
      'begin'
      '  strDesIte := fRetNomProduto(<frxRelatorio."CODBAS">);'
      ''
      
        '  If (Pos('#39'ITEM ESPECIAL'#39', strDesIte) > 0) And (<frxRelatorio."D' +
        'ESBAS"> <> '#39#39') Then'
      '    strDesIte := <frxRelatorio."DESBAS">;'
      ''
      
        '  TfrxDMPMemoView(Sender).Text := <frxRelatorio."CODBAS"> + '#39' - ' +
        #39' + strDesIte;'
      'end;'
      ''
      'procedure mmo3ProdBaseOnBeforePrint(Sender: TfrxComponent);'
      'Var'
      '  strDesIte: String;'
      'begin'
      
        '  strDesIte := fRetNomProduto(<frxRelatorio."CODBAS">) + '#39' - '#39' +' +
        ' fRetReferenciaProd(<frxRelatorio."CODBAS">);'
      ''
      
        '  If (Pos('#39'ITEM ESPECIAL'#39', strDesIte) > 0) And (<frxRelatorio."D' +
        'ESBAS"> <> '#39#39') Then'
      '    strDesIte := <frxRelatorio."DESBAS">;'
      ''
      
        '  TfrxDMPMemoView(Sender).Text := <frxRelatorio."CODBAS"> + '#39' - ' +
        #39' + strDesIte;'
      'end;'
      ''
      'procedure mmo1QuantidadeOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxDMPMemoView(Sender).Text := '#39'QUANT.: '#39' + fFloatToStrF(<frx' +
        'Relatorio."QTDBAS">);'
      'end;'
      ''
      'procedure mmo1MLocFisOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <MODELO> = '#39'3'#39' then'
      '  begin'
      '       TfrxMemoView(Sender).Text := <frxRelatorio."LOCFIS">'
      '  end;'
      'end;'
      ''
      'procedure mmo1MNumlotOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <MODELO> = '#39'3'#39' then'
      '  begin'
      '        TfrxMemoView(Sender).Text := <frxRelatorio."NUMLOT">'
      '  end;'
      'end;'
      ''
      'procedure mmo1MCodigoOnBeforePrint(Sender: TfrxComponent);'
      'var'
      '   strProduto : String;'
      'begin'
      '  strProduto := <frxRelatorio."COMENT">;'
      ''
      '  if strProduto = '#39#39' then'
      '  begin'
      '    if <REFERE> then'
      '      strProduto :=  <frxRelatorio."REFERE">'
      '    else'
      
        '      strProduto :=  <frxRelatorio."CODITE"> + '#39' - '#39' + fRetNomPr' +
        'oduto(<frxRelatorio."CODITE">);'
      '  end;'
      ''
      '  mmo1MCodigo.Text := strProduto;'
      ''
      'end;'
      ''
      'procedure mmo3MCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '   TfrxMemoView(Sender).Text := <frxRelatorio."CODITE"> + '#39' - '#39' ' +
        '+ fRetNomProduto(<frxRelatorio."CODITE">);'
      'end;'
      ''
      'procedure mmo1MQtdAcuOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if TfrxDMPMemoView(Sender).Visible = True then'
      '  begin'
      '    if <frxRelatorio."ACUMOP"> = '#39'S'#39' then'
      '    begin'
      '        TfrxDMPMemoView(Sender).Text := fFloatToStrF(fltQtdAcu);'
      '    end;'
      '  end;'
      'end;'
      ''
      'procedure mmo1MQtdIteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '   if <frxRelatorio."ACUMOP"> = '#39'S'#39' then'
      '  begin'
      '    fltQtdAcu := fltQtdAcu + <frxRelatorio."QTDITE">'
      '  end;'
      'end;'
      ''
      'Begin'
      '   fltQtdAcu := 0;'
      '   qckPagina.Visible := False;'
      '   qckMod2.Visible := False;'
      '   qckMod3.Visible := False;'
      '   qckMod4.Visible := False;'
      ''
      '  if (<MODELO> = '#39'1'#39') or (<MODELO> = '#39'3'#39') then'
      '  begin'
      '    qckPagina.Visible := True;'
      ''
      '    if <MODELO> = '#39'1'#39' then'
      '    begin'
      '      mmo1HNumlot.Visible := False;'
      '      mmo1HNumlot.Visible := False;'
      ''
      '      mmo1HCodigo.Left := mmo1HNumlot.Left;'
      '      mmo1MCodigo.Left := mmo1MNumlot.Left;'
      
        '      mmo1MCodigo.Width := mmo1MCodigo.Width + mmo1MNumlot.Width' +
        ';'
      '    end;'
      ''
      '    if <QDPRES> = '#39'N'#39' then'
      '    begin'
      '      mmo1HQtdAcu.Visible := False;'
      '      mmo1MQtdAcu.Visible := False;'
      ''
      '      mmo1HQtdIte.Left := mmo1HQtdAcu.Left;'
      '      mmo1MQtdIte.Left := mmo1MQtdAcu.Left;'
      '    end;'
      ''
      '  end;'
      ''
      '  if (<MODELO> = '#39'4'#39') then'
      '  begin'
      '    qckMod3.Visible := True;'
      ''
      '    if <QDPRES> = '#39'N'#39' then'
      '    begin'
      '      mmo3HQtdAcu.Visible := False;'
      '      mmo3MQtdAcu.Visible := False;'
      ''
      '      mmo3HQtdIte.Left := mmo3HQtdAcu.Left;'
      '      mmo3MQtdIte.Left := mmo3MQtdAcu.Left;'
      
        '      mmo3MReferencia.Width := mmo3MReferencia.Width + mmo3MQtdA' +
        'cu.Width;'
      ''
      '    end;'
      '  end;'
      ''
      '  if (<MODELO> = '#39'8'#39') then'
      '  begin'
      '    qckMod4.Visible := True;'
      ''
      '  end;'
      ''
      'end.')
    OnUserFunction = frxReportJUserFunction
    Left = 209
    Top = 41
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 256.539834318023700000
      PaperHeight = 148.431154138213000000
      PaperSize = 256
      RightMargin = 17.779988517090750000
      FontStyle = []
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 136.000000000000000000
        Width = 902.400000000000000000
        object mmo1HLocFis: TfrxDMPMemoView
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'LOC. FISICA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo1HNumlot: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'LOTE')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo1HCodigo: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1HCodigoOnBeforePrint'
          FontStyle = []
          Memo.UTF8W = (
            'CODIGO     DESCRICAO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo1HQtdAcu: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE ACUM')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo1HMetrag: TfrxDMPMemoView
          Left = 691.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'METROS')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo1HQtdite: TfrxDMPMemoView
          Left = 585.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE UNIT')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo1HNR: TfrxDMPMemoView
          Left = 499.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'N.R')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 170.000000000000000000
        Width = 902.400000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmo1MLocFis: TfrxDMPMemoView
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1MLocFisOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo1MNumlot: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1MNumlotOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo1MCodigo: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1MCodigoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."COMENT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo1MQtdAcu: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1MQtdAcuOnBeforePrint'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE ACUM')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo1MMetrag: TfrxDMPMemoView
          Left = 691.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METRAG"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo1MQtdIte: TfrxDMPMemoView
          Left = 585.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1MQtdIteOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 902.400000000000000000
        object mmo1NumDoc: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'ORDEM DE PRODUCAO N'#186' [frxRelatorio."CODPRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo1Pedido: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo1Vendedor: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 34.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            'VENDEDOR: [frxRelatorio."CODVEN"] - [frxRelatorio."NOMVEN"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo1ProdBase: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1ProdBaseOnBeforePrint'
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo1Quantidade: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 68.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1QuantidadeOnBeforePrint'
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo1: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 19.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#77#27#64#18#27#80#18#27#77'
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 204.000000000000000000
        Width = 902.400000000000000000
        object mmo1Obs: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 17.000000000000000000
          Width = 768.000000000000000000
          Height = 85.000000000000000000
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
        object mo1Obs: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'OBSERVACAO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo1Data: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo1Hora: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 119.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TIME]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
      end
    end
    object qckMod2: TfrxDMPPage
      Visible = False
      PaperWidth = 256.539834318023700000
      PaperHeight = 148.431154138213000000
      PaperSize = 256
      RightMargin = 17.779988517090750000
      FontStyle = []
      object PageHeader2: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 902.400000000000000000
        object mmo2Numdoc: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'ORDEM DE PRODUCAO N'#186' [frxRelatorio."CODPRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo2Pedido: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo2ProdBase: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 547.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1ProdBaseOnBeforePrint'
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo2Quantidade: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 68.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1QuantidadeOnBeforePrint'
          FontStyle = []
          HAlign = haRight
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 19.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#77#27#64#18#27#80#18#27#77'
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 153.000000000000000000
        Width = 902.400000000000000000
        object mmo2HSeparacao: TfrxDMPMemoView
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'SEPARACAO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo2HCodigo: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1HCodigoOnBeforePrint'
          FontStyle = []
          Memo.UTF8W = (
            'CODIGO     DESCRICAO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo2HUnidad: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo2HMetrag: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'METROS')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo2HQtdIte: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE UNIT')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo2HConferencia: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CONFERENCIA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 187.000000000000000000
        Width = 902.400000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmo2MSeparacao: TfrxDMPMemoView
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            '_______________________________')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object mmo2MCodigo: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."COMENT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo2MMetrag: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METRAG"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo2MQtdIte: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1MQtdIteOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo2MLocFis: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            'LOC.FISICA: [frxRelatorio."LOCFIS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo2MUnidad: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo2MConferencia: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            '_______________________________')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object PageFooter2: TfrxPageFooter
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 255.000000000000000000
        Width = 902.400000000000000000
        object mmo2Obs: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 17.000000000000000000
          Width = 768.000000000000000000
          Height = 85.000000000000000000
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
        object mo2Obs: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'OBSERVACAO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo2Data: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo2Hora: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 119.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TIME]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
      end
    end
    object qckMod3: TfrxDMPPage
      PaperWidth = 256.539834318023700000
      PaperHeight = 148.431154138213000000
      PaperSize = 256
      RightMargin = 17.779988517090750000
      FontStyle = []
      object PageHeader3: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 902.400000000000000000
        object mmo3Numdoc: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'ORDEM DE PRODUCAO N'#186' [frxRelatorio."CODPRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo3Pedido: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo3ProdBase: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo3ProdBaseOnBeforePrint'
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo3Quantidade: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 68.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1QuantidadeOnBeforePrint'
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo10: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#77#27#64#18#27#80#18#27#77'
        end
      end
      object Header3: TfrxHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 153.000000000000000000
        Width = 902.400000000000000000
        object mmo3HLocFisica: TfrxDMPMemoView
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'LOC. FISICA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo3HCodigo: TfrxDMPMemoView
          Left = 201.600000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CODIGO     DESCRICAO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo3HUnidad: TfrxDMPMemoView
          Left = 844.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo3HMetrag: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'METROS')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo3HReferencia: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo3HLote: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'LOTE')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo3HQtdIte: TfrxDMPMemoView
          Left = 547.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE UNIT')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo3HQtdAcu: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE ACUM')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 187.000000000000000000
        Width = 902.400000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmo3MLocFisica: TfrxDMPMemoView
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo3MLote: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMLOT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo3MCodigo: TfrxDMPMemoView
          Left = 201.600000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo3MCodigoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo3MReferencia: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."REFITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo3MUnidade: TfrxDMPMemoView
          Left = 844.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo3MMetrag: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METRAG"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo3MQtdIte: TfrxDMPMemoView
          Left = 547.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1MQtdIteOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo3MQtdAcu: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1MQtdAcuOnBeforePrint'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE ACUM')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object PageFooter3: TfrxPageFooter
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 238.000000000000000000
        Width = 902.400000000000000000
        object mmo3Obs: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 758.400000000000000000
          Height = 85.000000000000000000
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
        object mo3Obs: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'OBSERVACAO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo3Data: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo3Hora: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 119.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TIME]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
      end
    end
    object qckMod4: TfrxDMPPage
      Visible = False
      PaperWidth = 256.539834318023700000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      RightMargin = 17.779988517090750000
      FontStyle = []
      object PageHeader4: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 902.400000000000000000
        object mmo4Numdoc: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'ORDEM DE PRODUCAO N'#186' [frxRelatorio."CODPRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo4Pedido: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo4ProdBase: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo3ProdBaseOnBeforePrint'
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo4Quantidade: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 68.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1QuantidadeOnBeforePrint'
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo9: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
        object DMPCommand4: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#77#27#64#18#27#80#18#27#77'
        end
      end
      object Header4: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 136.000000000000000000
        Width = 902.400000000000000000
        object mmo4HLocFis: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'LOC. FISICA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo4HUnidad: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo4HMetrag: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'METROS')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo4HReferencia: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo4HNumlot: TfrxDMPMemoView
          Left = 201.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'LOTE')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo4HQtdIte: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE UNIT')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo4HQtdAcul: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE ACUM')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo4HCodigo: TfrxDMPMemoView
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmo4HDescricao: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 816.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object MasterData4: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 187.000000000000000000
        Width = 902.400000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmo4MLocFis: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo4MNumlot: TfrxDMPMemoView
          Left = 201.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMLOT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo4MCodigo: TfrxDMPMemoView
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo3MCodigoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo4MRefere: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."REFITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo4MUnidad: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo4MMetrag: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METRAG"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo4MQtdIte: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1MQtdIteOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmo4MQtdAcu: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo1MQtdAcuOnBeforePrint'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE ACUM')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object PageFooter4: TfrxPageFooter
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 255.000000000000000000
        Width = 902.400000000000000000
        object mmo4Obs: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 17.000000000000000000
          Width = 777.600000000000000000
          Height = 85.000000000000000000
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
        object mo4Obs: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'OBSERVACAO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo19: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo20: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 119.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TIME]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 56
    Top = 41
  end
end
