object frmModuloFatImp: TfrmModuloFatImp
  Left = 0
  Top = 0
  ClientHeight = 252
  ClientWidth = 376
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
  object frxDocSep80: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40324.349252384300000000
    ReportOptions.LastChange = 41597.552822256940000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      
        'procedure MasterDataModelo2EmbSepOnBeforePrint(Sender: TfrxCompo' +
        'nent);'
      'begin  '
      
        '  If (<frxItens."NUMLOT"> <> '#39#39') Or (<frxItens."QTDEMB"> > 0) Th' +
        'en'
      '  Begin              '
      '    MasterDataModelo2EmbSep.Height := 37.8;'
      '  End        '
      '  Else'
      '    MasterDataModelo2EmbSep.Height := 37.8 / 2;  '
      '      '
      '  mmoQtdEmb2.Visible := <frxItens."QTDEMB"> > 0;'
      'end;'
      ''
      'procedure mmoQtdEmbOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  mmoQtdEmb.Visible := (<frxItens."QTDEMB"> > 0) And mmoQtdEmbTi' +
        't.Visible;              '
      'end;'
      ''
      'procedure mmoQtdEmbMod2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  mmoQtdEmbMod2.Visible := <frxItens."QTDEMB"> > 0;             ' +
        ' '
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin    '
      '  If Not rldValUni.Visible Then'
      '  Begin'
      
        '    If (<frxItens."NUMLOT"> <> '#39#39') Or (<frxItens."QTDEMB"> > 0) ' +
        'Then'
      '    Begin              '
      '      MasterData1.Height := 37.8;'
      '      mmoNumLot.Visible  := True;'
      
        '      mmoQtdEmb.Visible  := (<frxItens."QTDEMB"> > 0) And mmoQtd' +
        'EmbTit.Visible;;          '
      
        '      mmoNumLot.Top      := mmoCodFab.Height;                   ' +
        '           '
      
        '      mmoQtdEmb.Top      := mmoCodFab.Height;                   ' +
        '           '
      '    End '
      '    Else'
      '    Begin                '
      '      MasterData1.Height := 37.8 / 2;'
      '      mmoNumLot.Visible  := False;'
      '      mmoNumLot.Top      := 0;                              '
      '      mmoQtdEmb.Visible  := False;            '
      '      mmoQtdEmb.Top      := 0;                              '
      '    End;                '
      '  End;                           '
      'end;'
      ''
      'procedure ChildTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllUrgente.Visible := (<frxcadSep."ENTURG"> = '#39'S'#39');           ' +
        '                       '
      'end;'
      ''
      'begin'
      '                                                   '
      'end.')
    OnUserFunction = frxDocSep80UserFunction
    Left = 40
    Top = 16
    Datasets = <
      item
        DataSet = frxCadEmp
        DataSetName = 'frxCadEmp'
      end
      item
        DataSet = frxCadSep
        DataSetName = 'frxCadSep'
      end
      item
        DataSet = frxFatGor
        DataSetName = 'frxFatGor'
      end
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end
      item
        DataSet = frxMovGer
        DataSetName = 'frxMovGer'
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
      LargeDesignHeight = True
      object pghCabecEmpresa: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 86.929133860000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxDocSep80.ChildTitulo
        PrintChildIfInvisible = True
        object Line3: TfrxLineView
          Align = baWidth
          Top = 83.149660000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo40: TfrxMemoView
          Left = 3.779530000000000000
          Width = 600.945270000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo40OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxCadEmp."EMP_NOMFAN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoNumPag1: TfrxMemoView
          Left = 646.299630000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page] / [TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 3.779530000000000000
          Top = 20.417336670000000000
          Width = 600.945270000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[fFormataFone(<frxCadEmp."EMP_FONE01">)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 3.779530000000000000
          Top = 40.834673330000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cidade: [frxCadEmp."EMP_NOMCID"] - [frxCadEmp."EMP_ESTADO"]   Ba' +
              'irro: [frxCadEmp."EMP_BAIRRO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Left = 3.779530000000000000
          Top = 61.252010000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Endere'#231'o: [frxCadEmp."EMP_ENDERE"] - [frxCadEmp."EMP_ENDNUM"] [f' +
              'rxCadEmp."EMP_ENDCMP"]    C.E.P:: [frxCadEmp."EMP_C_E_P_"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 37.795275590000000000
        ParentFont = False
        Top = 502.677490000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object mmoLocFis: TfrxMemoView
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxItens."LOCFIS"> + '#39'-'#39' + <frxItens."DESFIS">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 185.976500000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoDesIte: TfrxMemoView
          Left = 384.937230000000000000
          Width = 196.535560000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
        end
        object mmoDesMar: TfrxMemoView
          Left = 585.827150000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 354.653990000000000000
          Width = 26.456710000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoQtdIte: TfrxMemoView
          Left = 238.110390000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoCodFab: TfrxMemoView
          Left = 79.370130000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object rldValUni: TfrxMemoView
          Left = 522.708624800000000000
          Top = 18.897650000000000000
          Width = 94.488142600000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxItens."VALUNI"]')
          ParentFont = False
          WordWrap = False
        end
        object rldValTot: TfrxMemoView
          Left = 619.842920000000000000
          Top = 18.897650000000000000
          Width = 94.488142600000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxItens."VALITE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoNumLot: TfrxMemoView
          Left = 79.370130000000000000
          Top = 18.897650000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(<frxItens."NUMLOT"> = '#39#39', '#39#39', '#39'LOTE: '#39' + <frxItens."NUMLOT"' +
              '>)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoQtdEmb: TfrxMemoView
          Left = 238.110390000000000000
          Top = 18.897649999999900000
          Width = 94.488142600000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoQtdEmbOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxItens."QTDEMB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 317.480520000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(((<frxCadSep."ESPDOC"> = '#39'PD'#39') OR (<frxCadSep."ESPDOC"> = '#39 +
              'OR'#39') OR (<frxCadSep."ESPDOC"> = '#39'PR'#39')), IIF(<frxItens."ENTRET"> ' +
              '= '#39'E'#39', IIF(<frxItens."ENTFUT"> = '#39'S'#39', '#39'F'#39', '#39'I'#39'), '#39'R'#39'), IIF(<frxI' +
              'tens."ENTFUT"> = '#39'S'#39', '#39'F'#39', IIF(<frxCadSep."ENTFAT"> = '#39'S'#39', '#39'I'#39', ' +
              #39'R'#39')))]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 41.574803150000000000
        ParentFont = False
        Top = 438.425480000000000000
        Width = 718.110700000000000000
        AllowSplit = True
        ReprintOnNewPage = True
        Stretched = True
        object Shape1: TfrxShapeView
          Width = 718.110700000000000000
          Height = 37.795275590000000000
          Fill.BackColor = clSilver
        end
        object mmoTitLocFis: TfrxMemoView
          Left = 0.779530000000000000
          Top = 3.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.F'#205'SICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 185.976500000000000000
          Top = 3.000000000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoTitDesIte: TfrxMemoView
          Left = 384.937230000000000000
          Top = 3.000000000000000000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O/REFER'#202'NCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoTitDesMar: TfrxMemoView
          Left = 585.827150000000000000
          Top = 3.000000000000000000
          Width = 128.504020000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 354.653990000000000000
          Top = 3.000000000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNI.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 238.110390000000000000
          Top = 3.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoTitCodFab: TfrxMemoView
          Left = 79.370130000000000000
          Top = 3.000000000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'D.F'#193'BRICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitValUni: TfrxMemoView
          Left = 522.795610000000000000
          Top = 18.897650000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
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
          VAlign = vaCenter
        end
        object rllTitValTot: TfrxMemoView
          Left = 619.842920000000000000
          Top = 18.897650000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
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
          VAlign = vaCenter
        end
        object mmoQtdEmbTit: TfrxMemoView
          Left = 207.874150000000000000
          Top = 18.897650000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD EMBALAGENS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 317.480520000000000000
          Top = 3.000000000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ENT.')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooterPadrao: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 321.259908430000000000
        ParentFont = False
        Top = 910.866730000000000000
        Width = 718.110700000000000000
        object Line1: TfrxLineView
          Align = baWidth
          Top = 49.779530000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 113.811070000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo27: TfrxMemoView
          Left = 3.779530000000000000
          Top = 52.559060000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Transportadora:')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblEntrega: TfrxMemoView
          Left = 3.779530000000000000
          Top = 72.590551180000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Entrega:')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep2: TfrxMemoView
          Left = 442.205010000000000000
          Top = 52.559060000000000000
          Width = 272.126160000000000000
          Height = 18.897650000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."SPESOS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep3: TfrxMemoView
          Left = 90.708720000000000000
          Top = 52.559060000000000000
          Width = 347.716760000000000000
          Height = 18.897650000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."TRANSP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbENDENT: TfrxMemoView
          Left = 90.708720000000000000
          Top = 72.590551180000000000
          Width = 623.622450000000000000
          Height = 18.897650000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."ENDENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 3.779530000000000000
          Top = 92.622047240000000000
          Width = 710.551640000000000000
          Height = 18.897650000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."ROMANE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep4: TfrxMemoView
          Left = 634.961040000000000000
          Top = 117.811070000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."DTAENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 634.961040000000000000
          Top = 137.842519690000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."HORENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Left = 603.724800000000000000
          Top = 117.811070000000000000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 603.945270000000000000
          Top = 137.842519690000000000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Hora:')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoTitVended: TfrxMemoView
          Left = 3.779530000000000000
          Top = 117.811070000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoVended: TfrxMemoView
          Left = 90.708720000000000000
          Top = 117.811070000000000000
          Width = 200.315090000000000000
          Height = 18.897650000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."VENDED"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoTitDigita: TfrxMemoView
          Left = 294.803340000000000000
          Top = 117.811070000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Digitador:')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDigita: TfrxMemoView
          Left = 351.496290000000000000
          Top = 117.811070000000000000
          Width = 249.448980000000000000
          Height = 18.897650000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."DIGITA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoTitProfis: TfrxMemoView
          Left = 3.779530000000000000
          Top = 137.842519690000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Profissional:')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoProfis: TfrxMemoView
          Left = 90.708720000000000000
          Top = 137.842519690000000000
          Width = 510.236550000000000000
          Height = 18.897650000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."PROFIS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Left = 3.779530000000000000
          Top = 177.905511810000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Mensagem:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 90.708720000000000000
          Top = 177.905511810000000000
          Width = 623.622450000000000000
          Height = 75.590600000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."MENSAG"]')
          WordWrap = False
        end
        object rllEmpFor: TfrxMemoView
          Left = 3.779530000000000000
          Top = 157.874015750000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emp. Fornec.:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rlbEmpFor: TfrxMemoView
          Left = 90.708720000000000000
          Top = 157.874015750000000000
          Width = 510.236550000000000000
          Height = 18.897650000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object lblQtdTot: TfrxMemoView
          Left = 4.559060000000000000
          Top = 7.559060000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE TOTAL:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbQtdTot: TfrxMemoView
          Left = 87.401777400000000000
          Top = 7.559060000000000000
          Width = 79.370022600000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
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
            '[SUM(<frxItens."QTDITE">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object lblValTot: TfrxMemoView
          Left = 550.866420000000000000
          Top = 27.015770000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOT GERAL:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbValTot: TfrxMemoView
          Left = 628.472897400000000000
          Top = 27.015770000000000000
          Width = 86.929128980000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
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
            
              '[SUM(<frxItens."VALITE">-<frxItens."DESESP">+<frxItens."VALIPI">' +
              '+<frxItens."VALRET">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object lineTotal: TfrxLineView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object lblValTotGer: TfrxMemoView
          Left = 4.559060000000000000
          Top = 26.236240000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOT BRUTO:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbValTotGer: TfrxMemoView
          Left = 80.283657400000000000
          Top = 26.236240000000000000
          Width = 86.929141180000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
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
            '[SUM(<frxItens."VALITE">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object lblDesEsp: TfrxMemoView
          Left = 172.315090000000000000
          Top = 26.236240000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESC.ESP:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbDesEsp: TfrxMemoView
          Left = 235.480627400000000000
          Top = 26.236240000000000000
          Width = 68.031478980000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
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
            '[SUM(<frxItens."DESESP">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object lblSub: TfrxMemoView
          Left = 311.700990000000000000
          Top = 26.456710000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SUB TRIB.:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbSub: TfrxMemoView
          Left = 378.866527400000000000
          Top = 26.456710000000000000
          Width = 52.913358980000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
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
            '[SUM(<frxItens."VALRET">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object lblIpi: TfrxMemoView
          Left = 439.102660000000000000
          Top = 26.456710000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOT IPI:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbIpi: TfrxMemoView
          Left = 491.268197400000000000
          Top = 26.456710000000000000
          Width = 52.913358980000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
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
            '[SUM(<frxItens."VALIPI">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoMenExp: TfrxMemoView
          Left = 3.779530000000000000
          Top = 259.567100000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Men.Expedi'#231#227'o:')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoMenSa2: TfrxMemoView
          Left = 90.708720000000000000
          Top = 259.567100000000000000
          Width = 623.622450000000000000
          Height = 56.692950000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."MENSA2"]')
          WordWrap = False
        end
      end
      object ChildDadosCliente: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 115.275590550000000000
        ParentFont = False
        Top = 173.858380000000000000
        Width = 718.110700000000000000
        Child = frxDocSep80.ChildLocSep
        PrintChildIfInvisible = True
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.677179999999993000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 16.888463648333300000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fantasia:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 33.099747296666700000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 49.311030945000000000
          Width = 86.929190000000000000
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
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Top = 81.733598241666700000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ/CPF:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 65.522314593333300000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ref. Entrega:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 423.307360000000000000
          Top = 0.677179999999993000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 287.244280000000000000
          Top = 49.311030940000000000
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
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 423.307360000000000000
          Top = 49.311030940000000000
          Width = 56.692950000000000000
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
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 423.307360000000000000
          Top = 81.733598240000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE/RG:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 3.779530000000000000
          Top = 97.944881890000000000
          Width = 86.929190000000000000
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
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep: TfrxMemoView
          Left = 577.268090000000000000
          Top = 0.677179999999993000
          Width = 139.842610000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCadSep."REIMPR"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep1: TfrxMemoView
          Left = 94.488250000000000000
          Top = 0.677179999999993000
          Width = 325.039580000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 94.488250000000000000
          Top = 16.888463650000000000
          Width = 623.622450000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."NOMFAN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 94.488250000000000000
          Top = 33.099747300000000000
          Width = 623.622450000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."ENDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 94.708720000000000000
          Top = 49.311030940000000000
          Width = 188.976500000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."BAICLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 332.598640000000000000
          Top = 49.311030940000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."CEPCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 483.779840000000000000
          Top = 49.311030940000000000
          Width = 234.330860000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."CIDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 483.779840000000000000
          Top = 0.677179999999993000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."CODCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 483.779840000000000000
          Top = 81.733598240000000000
          Width = 234.330860000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."IES_RG"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 94.488250000000000000
          Top = 81.733598240000000000
          Width = 321.260050000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."CGCCPF"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 94.488250000000000000
          Top = 65.522314590000000000
          Width = 321.260050000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."REFERE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 94.488250000000000000
          Top = 97.944881890000000000
          Width = 321.260050000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."TELCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object qrlConPag: TfrxMemoView
          Left = 423.307360000000000000
          Top = 98.267780000000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cond Pgto:')
          ParentFont = False
          VAlign = vaCenter
        end
        object qrdConPag: TfrxMemoView
          Left = 483.779840000000000000
          Top = 98.267780000000000000
          Width = 234.330860000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."CONPAG"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildTitulo: TfrxChild
        FillType = ftBrush
        Height = 22.677165350000000000
        Top = 128.504020000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'ChildTituloOnBeforePrint'
        Child = frxDocSep80.ChildDadosCliente
        PrintChildIfInvisible = True
        object dbTITULO: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.889757670000000000
          Width = 566.929500000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'SEPARA'#199#195'O - [IIF(<frxCadSep."SEPFUT"> = '#39'S'#39', '#39'ENT.FUT. - '#39', '#39#39')]' +
              '[frxCadSep."NUMDOC"] - [frxCadSep."ESPDOC"][frxCadSep."ENT_CD"]')
          ParentFont = False
        end
        object mmoNumPag2: TfrxMemoView
          Left = 645.520100000000000000
          Top = 1.889765000000010000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page] / [TotalPages#]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllUrgente: TfrxMemoView
          Left = 570.709030000000000000
          Top = 1.889757670000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'URGENTE')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ChildLocSep: TfrxChild
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 313.700990000000000000
        Width = 718.110700000000000000
        Child = frxDocSep80.ChildSetor
        PrintChildIfInvisible = True
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.944881890000000000
          Width = 706.772110000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Separador: __________________________________________________ Ho' +
              'ra: ______')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterDataModelo2: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 612.283860000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'MasterDataModelo2OnBeforePrint'
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object Memo48: TfrxMemoView
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxItens."LOCFIS"> + '#39'-'#39' + <frxItens."DESFIS">]')
          ParentFont = False
          WordWrap = False
        end
        object rdbCodFab1: TfrxMemoView
          Left = 79.370130000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Left = 238.110390000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo51: TfrxMemoView
          Left = 291.023810000000000000
          Width = 94.488142600000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo52: TfrxMemoView
          Left = 389.291590000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 585.827150000000000000
          Width = 90.708612600000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Left = 680.315400000000000000
          Width = 34.015662600000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object HeaderModelo2: TfrxHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 563.149970000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape2: TfrxShapeView
          Width = 718.110700000000000000
          Height = 22.677155590000000000
          Fill.BackColor = clSilver
        end
        object Memo24: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000020000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.F'#205'SICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblCodFab1: TfrxMemoView
          Left = 83.149660000000000000
          Top = 3.779530000000000000
          Width = 151.181200000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'D.F'#193'BRICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 238.110390000000000000
          Top = 3.779530000000020000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 291.023810000000000000
          Top = 3.779530000000020000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 389.291590000000000000
          Top = 3.779530000000020000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O/REFER'#202'NCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 585.827150000000000000
          Top = 3.779530000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 680.315400000000000000
          Top = 3.779530000000020000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterDataModelo2EmbSep: TfrxMasterData
        FillType = ftBrush
        Height = 41.574805590000000000
        Top = 714.331170000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'MasterDataModelo2EmbSepOnBeforePrint'
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object mmoQtdEmb2: TfrxMemoView
          Left = 166.299212600000000000
          Top = 18.897637800000000000
          Width = 86.929133860000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoQtdEmbOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxItens."QTDEMB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxItens."LOCFIS"> + '#39'-'#39' + <frxItens."DESFIS">]')
          ParentFont = False
          WordWrap = False
        end
        object rdbCodFab2: TfrxMemoView
          Left = 79.370130000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo57: TfrxMemoView
          Left = 238.110390000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo58: TfrxMemoView
          Left = 291.023810000000000000
          Width = 86.929133858267720000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo59: TfrxMemoView
          Left = 259.275590550000000000
          Top = 18.897637800000000000
          Width = 434.645657090000000000
          Height = 18.897637800000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 585.827150000000000000
          Width = 90.708612600000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo61: TfrxMemoView
          Left = 680.315400000000000000
          Width = 34.015662600000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoQtdEmbMod2: TfrxMemoView
          Left = 381.291590000000000000
          Width = 56.692842600000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoQtdEmbMod2OnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxItens."QTDEMB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo73: TfrxMemoView
          Top = 18.897650000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(<frxItens."NUMLOT"> = '#39#39', '#39#39', '#39'LOTE: '#39' + <frxItens."NUMLOT"' +
              '>)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object HeaderModelo2EmbSep: TfrxHeader
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 653.858690000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape3: TfrxShapeView
          Width = 718.110700000000000000
          Height = 37.795275590000000000
          Fill.BackColor = clSilver
        end
        object mmoQtdEmbTit2: TfrxMemoView
          Left = 166.299132050000000000
          Top = 20.897650000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD EMBALAG.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo63: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000020000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.F'#205'SICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblCodFab2: TfrxMemoView
          Left = 83.149660000000000000
          Top = 3.779530000000000000
          Width = 151.181200000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'D.F'#193'BRICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo65: TfrxMemoView
          Left = 238.110390000000000000
          Top = 3.779530000000020000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo66: TfrxMemoView
          Left = 291.023810000000000000
          Top = 3.779530000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo67: TfrxMemoView
          Left = 259.346630000000000000
          Top = 20.897650000000000000
          Width = 453.543600000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo68: TfrxMemoView
          Left = 585.827150000000000000
          Top = 3.779530000000020000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo69: TfrxMemoView
          Left = 680.315400000000000000
          Top = 3.779530000000020000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo70: TfrxMemoView
          Left = 381.291590000000000000
          Top = 3.779530000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'EMBALA.')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object HeaderModelo3: TfrxHeader
        FillType = ftBrush
        Height = 26.456692910000000000
        Top = 778.583180000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape4: TfrxShapeView
          Width = 718.110700000000000000
          Height = 22.677155590000000000
          Fill.BackColor = clSilver
        end
        object Memo62: TfrxMemoView
          Left = 1.889763779527560000
          Top = 3.779530000000020000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.F'#205'SICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblCodFab3: TfrxMemoView
          Left = 80.149660000000000000
          Top = 3.779530000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'D.F'#193'BRICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo72: TfrxMemoView
          Left = 192.433210000000000000
          Top = 3.779530000000020000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo74: TfrxMemoView
          Left = 244.567100000000000000
          Top = 3.779530000000020000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
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
          VAlign = vaCenter
        end
        object Memo75: TfrxMemoView
          Left = 306.378170000000000000
          Top = 3.779530000000020000
          Width = 170.078850000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O/REFER'#202'NCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo76: TfrxMemoView
          Left = 629.291338580000000000
          Top = 3.779530000000020000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo77: TfrxMemoView
          Left = 281.141930000000000000
          Top = 3.779530000000020000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo78: TfrxMemoView
          Left = 477.913730000000000000
          Top = 3.779530000000020000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VOL.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo79: TfrxMemoView
          Left = 527.370440000000000000
          Top = 3.779530000000020000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MUL.VEN.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo80: TfrxMemoView
          Left = 580.504330000000000000
          Top = 3.779530000000020000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterDataModelo3: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 827.717070000000000000
        Width = 718.110700000000000000
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        object Memo81: TfrxMemoView
          Left = 1.889763780000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxItens."LOCFIS"> + '#39'-'#39' + <frxItens."DESFIS">]')
          ParentFont = False
          WordWrap = False
        end
        object rdbCodFab3: TfrxMemoView
          Left = 80.015748030000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo83: TfrxMemoView
          Left = 192.559055120000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo84: TfrxMemoView
          Left = 244.472440940000000000
          Width = 34.015748030000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo85: TfrxMemoView
          Left = 306.346456690000000000
          Width = 170.078735280000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo86: TfrxMemoView
          Left = 629.291338580000000000
          Width = 86.929133860000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Copy(<frxItens."DESMAR">, 1, 13)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo87: TfrxMemoView
          Left = 281.267716540000000000
          Width = 22.677165350000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo88: TfrxMemoView
          Left = 477.889763780000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            
              '[IIF((<frxItens."QTDITE"> > 0) And (<frxItens."MLTVEN"> > 0), <f' +
              'rxItens."QTDITE"> / <frxItens."MLTVEN"> , IIF((<frxItens."QTDITE' +
              '"> > 0), <frxItens."QTDITE"> / 1, 0))]')
          ParentFont = False
          WordWrap = False
        end
        object Memo89: TfrxMemoView
          Left = 529.291338580000000000
          Width = 49.133870470000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[IIF((<frxItens."MLTVEN"> = 0), 1, <frxItens."MLTVEN">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo90: TfrxMemoView
          Left = 580.692913390000000000
          Width = 49.133858270000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            
              '[IIF((<frxItens."SALDOS"> > 0) And (<frxItens."MLTVEN"> > 0), <f' +
              'rxItens."SALDOS"> / <frxItens."MLTVEN"> , IIF((<frxItens."SALDOS' +
              '"> > 0), <frxItens."SALDOS"> / 1, 0))]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildSetor: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 355.275820000000000000
        Width = 718.110700000000000000
        object mmoSetor: TfrxMemoView
          Left = 3.779527560000000000
          Top = 2.779530000000000000
          Width = 706.772110000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'SETOR')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxItens: TfrxDBDataset
    UserName = 'frxItens'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 216
    Top = 16
  end
  object frxFatGor: TfrxDBDataset
    UserName = 'frxFatGor'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 280
    Top = 16
  end
  object frxMovGer: TfrxDBDataset
    UserName = 'frxMovGer'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 344
    Top = 16
  end
  object frxCadEmp: TfrxDBDataset
    UserName = 'frxCadEmp'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 216
    Top = 72
  end
  object frxCadSep: TfrxDBDataset
    UserName = 'frxCadSep'
    CloseDataSource = False
    DataSource = dtsCadSep
    BCDToCurrency = False
    Left = 280
    Top = 72
  end
  object dtsCadSep: TDataSource
    Left = 216
    Top = 120
  end
  object frxDocSep40: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.Author = 'CITEL SOFTWARE'
    ReportOptions.CreateDate = 39534.387590949100000000
    ReportOptions.Description.Strings = (
      'PAGE1 IMPRIME :'
      ''
      'GARANTIA'
      'TROCA'
      'DEVOLU'#199#195'O'
      'AJUSTE'
      'FATURAMENTO FUTURO'
      'MOVIMENTA'#199#195'O DE ITEM'
      'TRANSFER'#202'NCIA DE ESTOQUE'
      'PIGMENTO'
      'BRINDE')
    ReportOptions.LastChange = 41465.652991701400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  blnCodFabVis: Boolean;'
      '  blnValSepVis: Boolean;'
      ''
      'procedure pExibirLinhaSeparacoEntreItens(strTitulo: String);'
      'begin'
      '  ChildItem.Visible   := False;'
      '  ChildQtdIte.Visible := False;        '
      '  ChildValSep.Visible := False;'
      '  ChildCodFab.Visible := False;  '
      '  ChildNumLot.Visible := False;'
      '  ChildItemDivisao.Visible := True;'
      
        '  rllItemDivisao.Text := strTitulo;                             ' +
        '         '
      'end;          '
      '    '
      'procedure MDadosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  ChildItem.Visible   := True;'
      '  ChildQtdIte.Visible := True;'
      '  ChildValSep.Visible := blnValSepVis;      '
      '  ChildCodFab.Visible := blnCodFabVis;'
      '  ChildItemDivisao.Visible := False;        '
      '    '
      '  If <frxItens."NUMLOT"> = '#39#39' Then'
      '    ChildNumLot.Visible := False'
      '  Else'
      '    ChildNumLot.Visible := True;'
      ''
      
        '  If (Pos(INF_DEVOLVER_ALMOXARIFADO, <frxItens."DESITE">) > 0) T' +
        'hen'
      '    pExibirLinhaSeparacoEntreItens(INF_DEVOLVER_ALMOXARIFADO);'
      '      '
      
        '  If (Pos(INF_RETIRAR_ALMOXARIFADO,  <frxItens."DESITE">) > 0) T' +
        'hen'
      '    pExibirLinhaSeparacoEntreItens(INF_RETIRAR_ALMOXARIFADO);'
      ''
      
        '  If (Pos(INF_SEM_ITENS_SEPARACAO,  <frxItens."DESITE">) > 0) Th' +
        'en'
      '    pExibirLinhaSeparacoEntreItens(INF_SEM_ITENS_SEPARACAO);'
      'end;'
      ''
      'procedure rllLocFisTitOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllLocFisTit.Visible := (<frxItens."LOCFIS"> <> '#39#39') OR (<frxIt' +
        'ens."LOCSUP"> <> '#39#39');        '
      'end;'
      ''
      'procedure DMPMemo4OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxItens."ALTERADO"> = '#39'S'#39' Then'
      
        '    DMPMemo4.Text := '#39'*'#39' + DMPMemo4.Text;                       ' +
        '                                   '
      'end;'
      ''
      'begin'
      '  blnCodFabVis := ChildCodFab.Visible;               '
      '  blnValSepVis := ChildValSep.Visible;                   '
      'end.')
    OnUserFunction = frxDocSep40UserFunction
    Left = 40
    Top = 80
    Datasets = <
      item
        DataSet = frxCadEmp
        DataSetName = 'frxCadEmp'
      end
      item
        DataSet = frxCadSep
        DataSetName = 'frxCadSep'
      end
      item
        DataSet = frxFatGor
        DataSetName = 'frxFatGor'
      end
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end
      item
        DataSet = frxMovGer
        DataSetName = 'frxMovGer'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 449.791376176402900000
      PaperSize = 256
      EndlessHeight = True
      FontStyle = []
      object RTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40.ChildFantasia
        PrintChildIfInvisible = True
        object dbEmpresa: TfrxDMPMemoView
          Align = baWidth
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          GroupIndex = 2
          DataField = 'EMP_NOMFAN'
          DataSet = frxCadEmp
          DataSetName = 'frxCadEmp'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCadEmp."EMP_NOMFAN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object UniClientDataSete: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 119.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."NOMCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCliente: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Cliente..:')
          TruncOutboundText = False
        end
        object Command1: TfrxDMPCommand
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          GroupIndex = 1
          Command = '#27#64#15#27#80'
        end
        object dbTITULO: TfrxDMPMemoView
          Align = baCenter
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'SEPARACAO - [IIF(<frxCadSep."SEPFUT"> = '#39'S'#39', '#39'ENT.FUT. - '#39', '#39#39')]' +
              '[frxCadSep."NUMDOC"] - [frxCadSep."ESPDOC"]')
          TruncOutboundText = False
        end
        object dbREIMPRESSAO: TfrxDMPMemoView
          Align = baCenter
          Left = 86.400000000000000000
          Top = 85.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCadSep."REIMPR"]')
          TruncOutboundText = False
        end
        object rlbCodCli: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 119.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."CODCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSepCli: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 119.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '-')
          TruncOutboundText = False
        end
        object rllNumGui: TfrxDMPMemoView
          Align = baCenter
          Top = 68.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'No GUICHE - [frxFatGor."FGO_NUMGUI"]')
          TruncOutboundText = False
        end
        object rllAlterado: TfrxDMPMemoView
          Align = baCenter
          Left = 86.400000000000000000
          Top = 102.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '')
          TruncOutboundText = False
        end
      end
      object HCabecalho: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 561.000000000000000000
        Width = 384.000000000000000000
        PrintChildIfInvisible = True
        object Linha2: TfrxDMPLineView
          Left = -14.400000000000000000
          Top = 8.500000000000000000
          Width = 393.600000000000000000
          Color = clBlack
        end
        object lblDescricao: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
          TruncOutboundText = False
        end
        object lblUn: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
          TruncOutboundText = False
        end
        object lblQtde: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.')
          TruncOutboundText = False
        end
        object lblCodigo: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.')
          TruncOutboundText = False
        end
        object Linha3: TfrxDMPLineView
          Left = -14.400000000000000000
          Top = 42.500000000000000000
          Width = 393.600000000000000000
          Color = clBlack
        end
        object rllTitValUni: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT')
          TruncOutboundText = False
        end
        object rllTitValTot: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          TruncOutboundText = False
        end
        object Linha4: TfrxDMPLineView
          Left = -14.400000000000000000
          Top = 59.500000000000000000
          Width = 393.600000000000000000
          Color = clBlack
        end
        object DMPMemo3: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'E/S')
          TruncOutboundText = False
        end
      end
      object MDados: TfrxMasterData
        FillType = ftBrush
        Top = 646.000000000000000000
        Width = 384.000000000000000000
        OnBeforePrint = 'MDadosOnBeforePrint'
        Child = frxDocSep40.ChildItemDivisao
        DataSet = frxItens
        DataSetName = 'frxItens'
        PrintChildIfInvisible = True
        PrintIfDetailEmpty = True
        RowCount = 0
        Stretched = True
      end
      object CMensag: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 1190.000000000000000000
        Width = 384.000000000000000000
        AllowSplit = True
        Child = frxDocSep40.CMensa2
        PrintChildIfInvisible = True
        Stretched = True
        object lblMensagem: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Mensagem:')
          TruncOutboundText = False
        end
        object dbMEN001: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMovGer
          DataSetName = 'frxMovGer'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."MENSAG"]')
          TruncOutboundText = False
        end
      end
      object CFSalto: TfrxColumnFooter
        FillType = ftBrush
        Height = 306.000000000000000000
        Top = 1326.000000000000000000
        Width = 384.000000000000000000
        object frxSaltoPaginaSALTO: TfrxDMPMemoView
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."SALTO"]')
          TruncOutboundText = False
        end
      end
      object ChildRomaneio: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 1275.000000000000000000
        Width = 384.000000000000000000
        PrintChildIfInvisible = True
        object DMPMemo30: TfrxDMPMemoView
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."ROMA40"]')
          TruncOutboundText = False
        end
      end
      object ChildCodFab: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 816.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40.ChildNumLot
        PrintChildIfInvisible = True
        object mmoCodFab: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxItens."CODFAB"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTitCodFab: TfrxDMPMemoView
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.FAB.:')
          TruncOutboundText = False
        end
      end
      object ChildDigitador: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 408.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40.ChildProfis
        PrintChildIfInvisible = True
        object DMPMemo5: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Digitador:')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."DIGITA"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildVendedor: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 374.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40.ChildDigitador
        PrintChildIfInvisible = True
        object DMPMemo2: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Vendedor.:')
          TruncOutboundText = False
        end
        object dbVENDEDOR: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."VENDED"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildProfis: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 442.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40.ChildEmpFor
        PrintChildIfInvisible = True
        object DMPMemo8: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Profissi.:')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."PROFIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildDadosCliente: TfrxChild
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 238.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40.ChildVendedor
        PrintChildIfInvisible = True
        object DMPMemo13: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Bairro...:')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C.E.P....:')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Municipio:')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Ref Entr.:')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CNPJ/CPF.:')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'IE/RG....:')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Telefone.:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."BAICLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 17.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."CEPCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 34.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."CIDCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 51.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."REFERE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 68.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."CGCCPF"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 85.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."IES_RG"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 102.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."TELCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildQtdIte: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 748.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40.ChildValSep
        PrintChildIfInvisible = True
        Stretched = True
        object dbUNITEM1: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object dbQTDEITEM1: TfrxDMPMemoView
          Left = 288.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLocFis: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fRetLocFisica(<frxItens."LOCFIS">,<frxItens."LOCSUP">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLocFisTit: TfrxDMPMemoView
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllLocFisTitOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC.:')
          TruncOutboundText = False
        end
      end
      object Footer: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 884.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40.CTotais
        PrintChildIfInvisible = True
        object DMPLine6: TfrxDMPLineView
          Left = -4.800000000000000000
          Top = 8.500000000000000000
          Width = 393.600000000000000000
          Color = clBlack
        end
        object rdbQtdTot: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."QTDITE">,MDados)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE. TOTAL:')
          TruncOutboundText = False
        end
      end
      object ChildNumLot: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 850.000000000000000000
        Width = 384.000000000000000000
        PrintChildIfInvisible = True
        object DMPMemo34: TfrxDMPMemoView
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NRO.LOTE:')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxItens."NUMLOT"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildValSep: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 782.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40.ChildCodFab
        PrintChildIfInvisible = True
        object rldValUni: TfrxDMPMemoView
          Left = 144.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."VALUNI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rldValTot: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."VALITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildEmpFor: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 476.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40.ChildLocSep
        PrintChildIfInvisible = True
        object rllEmpFor: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Emp.Forn.:')
          TruncOutboundText = False
        end
        object rlbEmpFor: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildLocSep: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 510.000000000000000000
        Width = 384.000000000000000000
        PrintChildIfInvisible = True
        object DMPMemo1: TfrxDMPMemoView
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Separador:_________________ Hora: ______')
          TruncOutboundText = False
        end
      end
      object CMensa2: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1224.000000000000000000
        Width = 384.000000000000000000
        AllowSplit = True
        Child = frxDocSep40.ChildRomaneio
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo20: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Mensagem'
            'Expedicao:')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 288.000000000000000000
          Height = 34.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMovGer
          DataSetName = 'frxMovGer'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."MENSA2"]')
          TruncOutboundText = False
        end
      end
      object ChildItemDivisao: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 663.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40.ChildItem
        PrintChildIfInvisible = True
        Stretched = True
        object rllItemDivisao: TfrxDMPMemoView
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'PRODUTOS A DEVOLVER PARA O ALMOXARIFADO')
          TruncOutboundText = False
        end
      end
      object ChildItem: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 714.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40.ChildQtdIte
        PrintChildIfInvisible = True
        Stretched = True
        object dbCODITEM1: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object dbDESITEM1: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo4OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxItens."ENTSAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object CTransp: TfrxChild
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 1037.000000000000000000
        Width = 384.000000000000000000
        AllowSplit = True
        Child = frxDocSep40.CDataHora
        PrintChildIfInvisible = True
        Stretched = True
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
        end
        object lblEntrega: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENTREGA: ')
          TruncOutboundText = False
        end
        object dbENDENT: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 17.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."ENDTRA"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object dbBAIRROENT: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 34.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."BAITRA"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object dbCIDADEENT: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 51.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."CIDTRA"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TRANSP.: ')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 86.400000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."TRANSP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."SPES40"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object CDataHora: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 1156.000000000000000000
        Width = 384.000000000000000000
        AllowSplit = True
        Child = frxDocSep40.CMensag
        PrintChildIfInvisible = True
        Stretched = True
        object lblData: TfrxDMPMemoView
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Data:')
          TruncOutboundText = False
        end
        object lblHora: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Hora:')
          TruncOutboundText = False
        end
        object dbDTAENT: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxMovGer
          DataSetName = 'frxMovGer'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."DTAENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object dbHORENT: TfrxDMPMemoView
          Left = 249.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxMovGer
          DataSetName = 'frxMovGer'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."HORENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object CTotais: TfrxChild
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 935.000000000000000000
        Width = 384.000000000000000000
        AllowSplit = True
        Child = frxDocSep40.CTransp
        PrintChildIfInvisible = True
        Stretched = True
        object rdbValTot: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."VALITE">,MDados)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object lblValTot: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL BRUTO:')
          TruncOutboundText = False
        end
        object rdbDesEsp: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."DESESP">,MDados)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object lblDesEsp: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DESC.ESPECIAL:')
          TruncOutboundText = False
        end
        object rdbValTotGer: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxItens."VALITE"> - <frxItens."DESESP"> + <frxItens."VALI' +
              'PI"> + <frxItens."VALRET">,MDados)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object lblValTotGer: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 68.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          TruncOutboundText = False
        end
        object rdbSub: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."VALRET">,MDados)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object lblSub: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 34.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SUB.TRIB.:')
          TruncOutboundText = False
        end
        object rdbIpi: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."VALIPI">,MDados)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object lblIpi: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 51.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL IPI:')
          TruncOutboundText = False
        end
      end
      object ChildFantasia: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 170.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40.ChildEndereco
        PrintChildIfInvisible = True
        object DMPMemo11: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Fantasia.:')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."NOMFAN"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildEndereco: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 204.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40.ChildDadosCliente
        PrintChildIfInvisible = True
        Stretched = True
        object dmpCEndCli: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Endereco.:')
          TruncOutboundText = False
        end
        object dmpDEndCli: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."ENDCLI"]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxMatricial: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    PageBreaks = False
    SaveToFile = False
    UseIniSettings = False
    Left = 344
    Top = 72
  end
  object frxDocSep40Item: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.Author = 'CITEL SOFTWARE'
    ReportOptions.CreateDate = 39534.387590949100000000
    ReportOptions.Description.Strings = (
      'PAGE1 IMPRIME :'
      ''
      'GARANTIA'
      'TROCA'
      'DEVOLU'#199#195'O'
      'AJUSTE'
      'FATURAMENTO FUTURO'
      'MOVIMENTA'#199#195'O DE ITEM'
      'TRANSFER'#202'NCIA DE ESTOQUE'
      'PIGMENTO'
      'BRINDE')
    ReportOptions.LastChange = 40730.651232638900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 40
    Top = 144
    Datasets = <
      item
        DataSet = frxDBSepItem
        DataSetName = 'frxDBSepItem'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 143.933240376448900000
      PaperSize = 256
      EndlessHeight = True
      FontStyle = []
      object RTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        PrintChildIfInvisible = True
        object dbEmpresa: TfrxDMPMemoView
          Align = baWidth
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          GroupIndex = 2
          DataSet = frxCadEmp
          DataSetName = 'frxCadEmp'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMFAN]')
          WordWrap = False
          TruncOutboundText = False
        end
        object UniClientDataSete: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 85.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOMCLI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCliente: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Cliente..:')
          TruncOutboundText = False
        end
        object Command1: TfrxDMPCommand
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          GroupIndex = 1
          Command = '#27#64#15#27#80'
        end
        object dbTITULO: TfrxDMPMemoView
          Align = baCenter
          Left = 19.200000000000000000
          Top = 51.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'SEPARACAO - CLIENTE NO BALCAO')
          TruncOutboundText = False
        end
        object rlbCodCli: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 85.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CODCLI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSepCli: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 85.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '-')
          TruncOutboundText = False
        end
      end
      object HCabecalho: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 221.000000000000000000
        Width = 384.000000000000000000
        PrintChildIfInvisible = True
        object Linha2: TfrxDMPLineView
          Left = -14.400000000000000000
          Top = 8.500000000000000000
          Width = 393.600000000000000000
          Color = clBlack
        end
        object lblDescricao: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
          TruncOutboundText = False
        end
        object lblUn: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
          TruncOutboundText = False
        end
        object lblCodigo: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.')
          TruncOutboundText = False
        end
        object Linha3: TfrxDMPLineView
          Left = -14.400000000000000000
          Top = 42.500000000000000000
          Width = 393.600000000000000000
          Color = clBlack
        end
        object rllTitValUni: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT')
          TruncOutboundText = False
        end
        object Linha4: TfrxDMPLineView
          Left = -14.400000000000000000
          Top = 59.500000000000000000
          Width = 393.600000000000000000
          Color = clBlack
        end
      end
      object MDados: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 384.000000000000000000
        OnBeforePrint = 'MDadosOnBeforePrint'
        Child = frxDocSep40Item.ChildQtdIte
        DataSet = frxDBSepItem
        DataSetName = 'frxDBSepItem'
        PrintChildIfInvisible = True
        RowCount = 0
        Stretched = True
        object dbCODITEM1: TfrxDMPMemoView
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBSepItem."CODITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object dbDESITEM1: TfrxDMPMemoView
          Left = 86.400000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBSepItem."DESITE"]')
          TruncOutboundText = False
        end
      end
      object CFSalto: TfrxColumnFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 527.000000000000000000
        Width = 384.000000000000000000
        object frxSaltoPaginaSALTO: TfrxDMPMemoView
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SALTO]')
          TruncOutboundText = False
        end
      end
      object ChildCodFab: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 374.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40Item.ChildRefIte
        PrintChildIfInvisible = True
        object mmoCodFab: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBSepItem."CODFAB"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTitCodFab: TfrxDMPMemoView
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'COD.FAB.:')
          TruncOutboundText = False
        end
      end
      object ChildDigitador: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 187.000000000000000000
        Width = 384.000000000000000000
        PrintChildIfInvisible = True
        object DMPMemo5: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Digitador:')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[DIGITA]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildVendedor: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 153.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40Item.ChildDigitador
        PrintChildIfInvisible = True
        object DMPMemo2: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Vendedor.:')
          TruncOutboundText = False
        end
        object dbVENDEDOR: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDED]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildQtdIte: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 340.000000000000000000
        Width = 384.000000000000000000
        Child = frxDocSep40Item.ChildCodFab
        PrintChildIfInvisible = True
        Stretched = True
        object dbUNITEM1: TfrxDMPMemoView
          Left = 211.200000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDBSepItem."UNIDAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLocFis: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBSepItem."LOCFIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC.:')
          TruncOutboundText = False
        end
        object rldValUni: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBSepItem."VALUNI"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Footer: TfrxFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 442.000000000000000000
        Width = 384.000000000000000000
        object lblData: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Data:')
          TruncOutboundText = False
        end
        object lblHora: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Hora:')
          TruncOutboundText = False
        end
        object dbDTAENT: TfrxDMPMemoView
          Left = 57.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxMovGer
          DataSetName = 'frxMovGer'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[DTAENT]')
          WordWrap = False
          TruncOutboundText = False
        end
        object dbHORENT: TfrxDMPMemoView
          Left = 249.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxMovGer
          DataSetName = 'frxMovGer'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[HORENT]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Left = -4.800000000000000000
          Top = 8.500000000000000000
          Width = 393.600000000000000000
          Color = clBlack
        end
      end
      object ChildRefIte: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 408.000000000000000000
        Width = 384.000000000000000000
        PrintChildIfInvisible = True
        object DMPMemo1: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDBSepItem."REFERE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'REF.ITEM:')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxDBSepItem: TfrxDBDataset
    UserName = 'frxDBSepItem'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 40
    Top = 200
  end
  object frxDocSep80_Mod4: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40324.349252384300000000
    ReportOptions.LastChange = 41199.685459155100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure Footer1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  rllContinua.Visible := False;'
      '  mmoUlt1.Visible := True;'
      '  mmoUlt2.Visible := True;'
      
        '  mmoUlt3.Visible := True;                                      ' +
        '                     '
      
        '  mmoUlt4.Visible := True;                                      ' +
        '                     '
      
        '  mmoUlt5.Visible := True;                                      ' +
        '                     '
      '  mmoUlt6.Visible := True;'
      '  mmoFrete.Visible := True;        '
      'end;'
      ''
      'begin'
      '  rllContinua.Visible := True;'
      '  mmoUlt1.Visible := False;'
      '  mmoUlt2.Visible := False;'
      
        '  mmoUlt3.Visible := False;                                     ' +
        '                      '
      
        '  mmoUlt4.Visible := False;                                     ' +
        '                      '
      
        '  mmoUlt5.Visible := False;                                     ' +
        '                      '
      '  mmoUlt6.Visible := False;'
      '  mmoFrete.Visible := False;                   '
      'end.')
    OnUserFunction = frxDocSep80_Mod4UserFunction
    Left = 136
    Top = 16
    Datasets = <
      item
        DataSet = frxCadEmp
        DataSetName = 'frxCadEmp'
      end
      item
        DataSet = frxCadSep
        DataSetName = 'frxCadSep'
      end
      item
        DataSet = frxFatGor
        DataSetName = 'frxFatGor'
      end
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end
      item
        DataSet = frxMovGer
        DataSetName = 'frxMovGer'
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
      object pghCabecEmpresa: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 34.393695910000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        object Memo98: TfrxMemoView
          Left = 616.063390000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Fl: [FormatFloat('#39'00000'#39', <Page>)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo99: TfrxMemoView
          Left = 240.110390000000000000
          Top = 1.779530000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Style = fsDot
          Memo.UTF8W = (
            'S E P A R A '#199' '#195' O')
          ParentFont = False
        end
        object Memo141: TfrxMemoView
          Left = 1.000000000000000000
          Top = 14.677180000000000000
          Width = 510.236550000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              'Empresa: [frxCadEmp."EMP_NOMFAN"] CNPJ: [fRetVal('#39'CNPJ'#39')] IE: [f' +
              'rxCadEmp."EMP_I_E_S_"]')
          ParentFont = False
        end
        object Memo113: TfrxMemoView
          Left = 521.575140000000000000
          Top = 17.677165350000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[fRetVal('#39'DATA'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object Line2: TfrxLineView
          Left = 2.000000000000000000
          Top = 7.559060000000000000
          Width = 234.330860000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Left = 333.598640000000000000
          Top = 8.338590000000000000
          Width = 279.685220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object PageFooterPadrao: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 322.039580000000000000
        ParentFont = False
        Top = 257.008040000000000000
        Width = 718.110700000000000000
        object Memo2: TfrxMemoView
          Left = 24.559060000000000000
          Top = 197.078850000000000000
          Width = 650.079160000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              '          Separador                  Conferente                 ' +
              '              Volumes                       Tot.Itens           ' +
              '     Pedido        ')
          ParentFont = False
        end
        object mmoUlt1: TfrxMemoView
          Left = 7.559060000000000000
          Width = 702.992580000000000000
          Height = 77.480356460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            'Obs.Ped.Interno: [frxCadSep."MENSAG"] [frxCadSep."MENSA2"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo1: TfrxMemoView
          Left = 24.559060000000000000
          Top = 258.992270000000000000
          Width = 706.772110000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              '                  Plano de Pagamento                            ' +
              '          Vendedor                                      Cliente ' +
              '                   ')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 31.015770000000000000
          Top = 287.008040000000000000
          Width = 234.330860000000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            '    Prazo: [frxCadSep."CNDMD4"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 4.559060000000000000
          Top = 129.708720000000000000
          Width = 75.590600000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 4.559060000000000000
          Top = 142.131287300000000000
          Width = 75.590600000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 4.559060000000000000
          Top = 167.765138240000000000
          Width = 75.590600000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'C.N.P.J/C.P.F:')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 4.559060000000000000
          Top = 155.342570940000000000
          Width = 75.590600000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Cidade:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 83.267780000000000000
          Top = 129.708720000000000000
          Width = 631.181510000000000000
          Height = 13.228346460000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxCadSep."CODCLI"] [frxCadSep."NOMCLI"]  Data Entrada:  [frxCa' +
              'dSep."DTAENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 83.267780000000000000
          Top = 142.131287300000000000
          Width = 631.181510000000000000
          Height = 13.228346460000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxCadSep."ENDCLI"],      B [frxCadSep."BAICLI"]      Fone Coml' +
              ': [fRetVal('#39'FONE'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 83.267780000000000000
          Top = 155.342570940000000000
          Width = 631.181510000000000000
          Height = 13.228346460000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."CIDCLI"] CEP: [frxCadSep."CEPCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 83.267780000000000000
          Top = 167.765138240000000000
          Width = 631.181510000000000000
          Height = 13.228346460000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."CGCCPF"]   Inscr.Estad: [frxCadSep."IES_RG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 4.559060000000000000
          Top = 181.094620000000000000
          Width = 75.590600000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Transportador:')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 83.267780000000000000
          Top = 181.094620000000000000
          Width = 631.181510000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."TRANSP"]    Tp.Frete: [frxCadSep."FRETE_"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 275.905690000000000000
          Top = 299.905690000000000000
          Width = 177.637910000000000000
          Height = 11.338577800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'Repr: [frxCadSep."VENDED"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 562.268090000000000000
          Top = 224.653680000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCadSep."NUMDOC"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 485.897960000000000000
          Top = 224.653680000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[fRetVal('#39'QTDDIS'#39')]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 464.882190000000000000
          Top = 299.905690000000000000
          Width = 188.976500000000000000
          Height = 11.338577800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxCadSep."NOMCLI"]')
          ParentFont = False
        end
        object mmoUlt3: TfrxMemoView
          Left = 7.559060000000000000
          Top = 89.440949760000000000
          Width = 453.543492600000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              'Total Mercadorias: [FormatFloat('#39'#,##0.00'#39', SUM(<frxItens."VALIT' +
              'E">,MasterDataModelo4,2))]          IPI: [FormatFloat('#39'#,##0.00'#39 +
              ', SUM(<frxItens."VALIPI">,MasterDataModelo4,2))]')
          ParentFont = False
          WordWrap = False
        end
        object mmoUlt6: TfrxMemoView
          Left = 469.661720000000000000
          Top = 114.338587560000000000
          Width = 215.433210000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              '*** Total da Nota: [FormatFloat('#39'#,##0.00'#39', SUM(<frxItens."VALIT' +
              'E">,MasterDataModelo4,2) + SUM(<frxItens."VALIPI">,MasterDataMod' +
              'elo4,2) + <frxCadSep."TOTFRE"> - SUM(<frxItens."DESESI">,MasterD' +
              'ataModelo4,2))]')
          ParentFont = False
        end
        object mmoUlt4: TfrxMemoView
          Left = 7.559060000000000000
          Top = 102.472480000000000000
          Width = 453.543600000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              'Quantid. Total: [fRetVal('#39'QTDITE'#39')]          [frxCadSep."SPESOS"' +
              ']')
          ParentFont = False
        end
        object mmoUlt2: TfrxMemoView
          Left = 7.559060000000000000
          Top = 77.456710000000000000
          Width = 676.535870000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              'Desconto Especial: [FormatFloat('#39'#,##0.00'#39', <frxCadSep."DESESP">' +
              ' / <frxCadSep."TOTPRO"> * 100)]%          Vlr.do Desconto Especi' +
              'al: [FormatFloat('#39'#,##0.00'#39', SUM(<frxItens."DESESI">, MasterData' +
              'Modelo4,2))]          Encargo Financeiro: [FormatFloat('#39'#,##0.00' +
              #39', <frxCadSep."FINANC">)]%')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object mmoUlt5: TfrxMemoView
          Left = 469.661720000000000000
          Top = 102.354360000000000000
          Width = 215.433210000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              'Total Mercadorias: [FormatFloat('#39'#,##0.00'#39', SUM(<frxItens."VALIT' +
              'E">,MasterDataModelo4,2))]')
          ParentFont = False
        end
        object rllContinua: TfrxMemoView
          Left = 5.559060000000000000
          Top = 12.661410000000000000
          Width = 75.590600000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            'Continua...')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoFrete: TfrxMemoView
          Left = 469.661720000000000000
          Top = 89.133890000000000000
          Width = 215.433210000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              '            Frete: [FormatFloat( '#39'#,##0.00'#39', <frxCadSep."TOTFRE"' +
              '>)]')
          ParentFont = False
        end
        object Shape1: TfrxShapeView
          Left = 26.456710000000000000
          Top = 207.874150000000000000
          Width = 120.944960000000000000
          Height = 49.133890000000000000
        end
        object Shape2: TfrxShapeView
          Left = 147.401670000000000000
          Top = 207.874150000000000000
          Width = 120.944960000000000000
          Height = 49.133890000000000000
        end
        object Shape3: TfrxShapeView
          Left = 268.346630000000000000
          Top = 207.874150000000000000
          Width = 211.653680000000000000
          Height = 49.133890000000000000
        end
        object Shape4: TfrxShapeView
          Left = 480.000310000000000000
          Top = 207.874150000000000000
          Width = 75.590600000000000000
          Height = 49.133890000000000000
        end
        object Shape5: TfrxShapeView
          Left = 555.590910000000000000
          Top = 207.874150000000000000
          Width = 105.826840000000000000
          Height = 49.133890000000000000
        end
        object Shape6: TfrxShapeView
          Left = 26.456710000000000000
          Top = 270.346630000000000000
          Width = 241.889920000000000000
          Height = 49.133890000000000000
        end
        object Shape7: TfrxShapeView
          Left = 268.346630000000000000
          Top = 270.346630000000000000
          Width = 188.976500000000000000
          Height = 49.133890000000000000
        end
        object Shape8: TfrxShapeView
          Left = 457.323130000000000000
          Top = 270.346630000000000000
          Width = 204.094620000000000000
          Height = 49.133890000000000000
        end
      end
      object HeaderModelo4: TfrxHeader
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 113.385900000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        ReprintOnNewPage = True
        object Memo19: TfrxMemoView
          Left = 504.236237560000000000
          Top = 2.000000000000000000
          Width = 74.078740160000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Embalagem')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 74.173155120000000000
          Top = 2.000000000000000000
          Width = 45.354330710000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Codigo')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 1.755903070000000000
          Top = 2.000000000000000000
          Width = 41.574803150000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Quant')
          ParentFont = False
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 118.488076690000000000
          Top = 2.000000000000000000
          Width = 291.023622050000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Descricao Longa do Produto')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 578.385858500000000000
          Top = 2.000000000000000000
          Width = 68.031496060000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Preco Unit')
          ParentFont = False
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 43.495916540000000000
          Top = 2.000000000000000000
          Width = 30.236220470000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Un')
          ParentFont = False
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 647.079160000000000000
          Top = 2.000000000000000000
          Width = 68.031488740000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Preco Tot.')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 409.748300000000000000
          Top = 2.000000000000000000
          Width = 94.488188980000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Endereco de estoque')
          ParentFont = False
          WordWrap = False
        end
      end
      object MasterDataModelo4: TfrxMasterData
        FillType = ftBrush
        Height = 19.275590550000000000
        Top = 154.960730000000000000
        Width = 718.110700000000000000
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object Memo97: TfrxMemoView
          Left = 504.236237560000000000
          Top = 3.000000000000000000
          Width = 74.078740160000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxItens."REFERE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo117: TfrxMemoView
          Left = 74.173155120000000000
          Top = 3.000000000000000000
          Width = 45.354330710000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo118: TfrxMemoView
          Left = 1.755903070000000000
          Top = 3.000000000000000000
          Width = 41.574805590000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo119: TfrxMemoView
          Left = 118.488076690000000000
          Top = 3.000000000000000000
          Width = 291.023695280000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
        end
        object Memo120: TfrxMemoView
          Left = 578.385858500000000000
          Top = 3.000000000000000000
          Width = 68.031488740000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxItens."VALUNI">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo121: TfrxMemoView
          Left = 43.495916540000000000
          Top = 3.000000000000000000
          Width = 30.236225350000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo122: TfrxMemoView
          Left = 647.079160000000000000
          Top = 3.000000000000000000
          Width = 68.031488740000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxItens."VALITE">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 409.748300000000000000
          Top = 3.000000000000000000
          Width = 94.488250000000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[<frxItens."LOCFIS"> + '#39'-'#39' + <frxItens."DESFIS">]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Top = 196.535560000000000000
        Width = 718.110700000000000000
        OnAfterPrint = 'Footer1OnAfterPrint'
      end
    end
  end
  object frxDocSepMeiaFolha80: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40324.349252384300000000
    ReportOptions.LastChange = 41597.552822256900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure ChildTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllUrgente.Visible := (<frxcadSep."ENTURG"> = '#39'S'#39');           ' +
        '                       '
      'end;'
      ''
      'procedure FooterMeiaFolhaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rdbDesEsp.Visible:=SUM(<frxItens."DESESP">,MasterDataMeiaFolha' +
        ')>0;    '
      
        '  rdbSub.Visible   :=SUM(<frxItens."VALRET">,MasterDataMeiaFolha' +
        ')>0;    '
      
        '  rdbIpi.Visible   :=SUM(<frxItens."VALIPI">,MasterDataMeiaFolha' +
        ')>0;'
      'end;'
      ''
      'begin'
      '                                                   '
      'end.')
    OnUserFunction = frxDocSep80UserFunction
    Left = 136
    Top = 80
    Datasets = <
      item
        DataSet = frxCadEmp
        DataSetName = 'frxCadEmp'
      end
      item
        DataSet = frxCadSep
        DataSetName = 'frxCadSep'
      end
      item
        DataSet = frxFatGor
        DataSetName = 'frxFatGor'
      end
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end
      item
        DataSet = frxMovGer
        DataSetName = 'frxMovGer'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 148.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      object PageFooterPadrao: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 205.984247090000000000
        ParentFont = False
        Top = 566.929500000000000000
        Width = 718.110700000000000000
        object Line2: TfrxLineView
          Align = baWidth
          Top = 53.811070000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo27: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.559060000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Transportadora:')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblEntrega: TfrxMemoView
          Left = 3.779530000000000000
          Top = 19.590551180000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Entrega:')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep2: TfrxMemoView
          Left = 442.205010000000000000
          Top = 2.559060000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."SPESOS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep3: TfrxMemoView
          Left = 90.708720000000000000
          Top = 2.559060000000000000
          Width = 347.716760000000000000
          Height = 15.118120000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."TRANSP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbENDENT: TfrxMemoView
          Left = 90.708720000000000000
          Top = 19.590551180000000000
          Width = 623.622450000000000000
          Height = 15.118120000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."ENDENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 3.779530000000000000
          Top = 36.622047240000000000
          Width = 710.551640000000000000
          Height = 15.118120000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."ROMANE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep4: TfrxMemoView
          Left = 634.961040000000000000
          Top = 56.811070000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."DTAENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 634.961040000000000000
          Top = 72.842519690000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."HORENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Left = 603.724800000000000000
          Top = 56.811070000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 603.945270000000000000
          Top = 72.842519690000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Hora:')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoTitVended: TfrxMemoView
          Left = 3.779530000000000000
          Top = 56.811070000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoVended: TfrxMemoView
          Left = 90.708720000000000000
          Top = 56.811070000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."VENDED"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoTitDigita: TfrxMemoView
          Left = 294.803340000000000000
          Top = 56.811070000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Digitador:')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDigita: TfrxMemoView
          Left = 351.496290000000000000
          Top = 56.811070000000000000
          Width = 249.448980000000000000
          Height = 15.118120000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."DIGITA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoTitProfis: TfrxMemoView
          Left = 3.779530000000000000
          Top = 72.842519690000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Profissional:')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoProfis: TfrxMemoView
          Left = 90.708720000000000000
          Top = 72.842519690000000000
          Width = 510.236550000000000000
          Height = 15.118120000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."PROFIS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Left = 3.779530000000000000
          Top = 105.905511810000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Mensagem:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 90.708720000000000000
          Top = 105.905511810000000000
          Width = 623.622450000000000000
          Height = 45.354360000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."MENSAG"]')
          WordWrap = False
        end
        object rllEmpFor: TfrxMemoView
          Left = 3.779530000000000000
          Top = 89.874015750000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emp. Fornec.:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rlbEmpFor: TfrxMemoView
          Left = 90.708720000000000000
          Top = 89.874015750000000000
          Width = 510.236550000000000000
          Height = 15.118120000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object lineTotal: TfrxLineView
          Align = baWidth
          Top = 0.779530000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object mmoMenExp: TfrxMemoView
          Left = 3.779530000000000000
          Top = 153.567100000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Men.Expedi'#231#227'o:')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoMenSa2: TfrxMemoView
          Left = 90.708720000000000000
          Top = 153.567100000000000000
          Width = 623.622450000000000000
          Height = 49.133890000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCadSep."MENSA2"]')
          WordWrap = False
        end
      end
      object ChildDadosCliente: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 115.275590550000000000
        ParentFont = False
        Top = 151.181200000000000000
        Width = 718.110700000000000000
        Child = frxDocSepMeiaFolha80.ChildLocSep
        PrintChildIfInvisible = True
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.677179999999993000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 16.888463648333300000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fantasia:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 33.099747296666700000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 49.311030945000000000
          Width = 86.929190000000000000
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
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Top = 81.733598241666700000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ/CPF:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 65.522314593333300000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ref. Entrega:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 423.307360000000000000
          Top = 0.677179999999993000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 287.244280000000000000
          Top = 49.311030940000000000
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
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 423.307360000000000000
          Top = 49.311030940000000000
          Width = 56.692950000000000000
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
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 423.307360000000000000
          Top = 81.733598240000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE/RG:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 3.779530000000000000
          Top = 97.944881890000000000
          Width = 86.929190000000000000
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
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep: TfrxMemoView
          Left = 577.268090000000000000
          Top = 0.677179999999993000
          Width = 139.842610000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCadSep."REIMPR"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep1: TfrxMemoView
          Left = 94.488250000000000000
          Top = 0.677180000000000000
          Width = 325.039580000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 94.488250000000000000
          Top = 16.888463650000000000
          Width = 623.622450000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."NOMFAN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 94.488250000000000000
          Top = 33.099747300000000000
          Width = 623.622450000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."ENDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 94.708720000000000000
          Top = 49.311030940000000000
          Width = 188.976500000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."BAICLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 332.598640000000000000
          Top = 49.311030940000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."CEPCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 483.779840000000000000
          Top = 49.311030940000000000
          Width = 234.330860000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."CIDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 483.779840000000000000
          Top = 0.677179999999993000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."CODCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 483.779840000000000000
          Top = 81.733598240000000000
          Width = 234.330860000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."IES_RG"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 94.488250000000000000
          Top = 81.733598240000000000
          Width = 321.260050000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."CGCCPF"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 94.488250000000000000
          Top = 65.522314590000000000
          Width = 321.260050000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."REFERE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 94.488250000000000000
          Top = 97.944881890000000000
          Width = 321.260050000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."TELCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object qrlConPag: TfrxMemoView
          Left = 423.307360000000000000
          Top = 98.267780000000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cond Pgto:')
          ParentFont = False
          VAlign = vaCenter
        end
        object qrdConPag: TfrxMemoView
          Left = 483.779840000000000000
          Top = 98.267780000000000000
          Width = 234.330860000000000000
          Height = 15.118110240000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."CONPAG"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildTitulo: TfrxChild
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 109.606370000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'ChildTituloOnBeforePrint'
        Child = frxDocSepMeiaFolha80.ChildDadosCliente
        PrintChildIfInvisible = True
        object dbTITULO: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.889757670000000000
          Width = 566.929500000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'SEPARA'#199#195'O - [IIF(<frxCadSep."SEPFUT"> = '#39'S'#39', '#39'ENT.FUT. - '#39', '#39#39')]' +
              '[frxCadSep."NUMDOC"] - [frxCadSep."ESPDOC"][frxCadSep."ENT_CD"]')
          ParentFont = False
        end
        object mmoNumPag2: TfrxMemoView
          Left = 645.520100000000000000
          Top = 0.889765000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page] / [TotalPages#]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllUrgente: TfrxMemoView
          Left = 570.709030000000000000
          Top = 0.889757670000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'URGENTE')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ChildLocSep: TfrxChild
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 291.023810000000000000
        Width = 718.110700000000000000
        Child = frxDocSepMeiaFolha80.ChildSetor
        PrintChildIfInvisible = True
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.944881890000000000
          Width = 706.772110000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Separador: __________________________________________________ Ho' +
              'ra: ______')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterDataMeiaFolha: TfrxMasterData
        FillType = ftBrush
        Height = 14.362204720000000000
        Top = 445.984540000000000000
        Width = 718.110700000000000000
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object mmoLocFis: TfrxMemoView
          Width = 75.590600000000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxItens."LOCFIS"> + '#39'-'#39' + <frxItens."DESFIS">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Left = 81.929190000000000000
          Width = 49.133890000000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoQtdIte: TfrxMemoView
          Left = 132.842610000000000000
          Width = 56.692842600000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo52: TfrxMemoView
          Left = 227.110390000000000000
          Width = 313.700990000000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 191.110390000000000000
          Width = 34.015662600000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object rldValUni: TfrxMemoView
          Left = 542.795610000000000000
          Width = 83.149552600000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxItens."VALUNI"]')
          ParentFont = False
          WordWrap = False
        end
        object rldValTot: TfrxMemoView
          Left = 627.370845200000000000
          Width = 86.929082600000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxItens."VALITE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object HeaderMeiaFolha: TfrxHeader
        FillType = ftBrush
        Height = 14.362204720000000000
        Top = 408.189240000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape2: TfrxShapeView
          Width = 718.110700000000000000
          Height = 14.362204724409500000
          Fill.BackColor = clSilver
        end
        object mmoTitLocFis: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779530000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.F'#205'SICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 81.929190000000000000
          Top = 1.779530000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 132.842610000000000000
          Top = 1.779530000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANT')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 227.110390000000000000
          Top = 1.779530000000000000
          Width = 313.700990000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O/REFER'#202'NCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 191.110390000000000000
          Top = 1.779530000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitValUni: TfrxMemoView
          Left = 542.441655200000000000
          Top = 1.889763780000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'UNIT'#193'RIO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitValTot: TfrxMemoView
          Left = 627.339305200000000000
          Top = 1.889763780000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildSetor: TfrxChild
        FillType = ftBrush
        Height = 15.874015750000000000
        Top = 332.598640000000000000
        Width = 718.110700000000000000
        object mmoSetor: TfrxMemoView
          Left = 3.779530000000000000
          Width = 706.772110000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'SETOR')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object pghCabecEmpresa: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 68.031483860000000000
        ParentFont = False
        Top = 18.897650000000000000
        Visible = False
        Width = 718.110700000000000000
        Child = frxDocSepMeiaFolha80.ChildTitulo
        PrintChildIfInvisible = True
        object Line3: TfrxLineView
          Align = baWidth
          Top = 66.149660000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo40: TfrxMemoView
          Left = 3.779530000000000000
          Width = 600.945270000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxCadEmp."EMP_NOMFAN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoNumPag1: TfrxMemoView
          Left = 646.299630000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page] / [TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 3.779530000000000000
          Top = 16.417336670000000000
          Width = 600.945270000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[fFormataFone(<frxCadEmp."EMP_FONE01">)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 3.779530000000000000
          Top = 32.834673330000000000
          Width = 706.772110000000000000
          Height = 15.118120000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cidade: [frxCadEmp."EMP_NOMCID"] - [frxCadEmp."EMP_ESTADO"]   Ba' +
              'irro: [frxCadEmp."EMP_BAIRRO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Left = 3.779530000000000000
          Top = 49.889763780000000000
          Width = 706.772110000000000000
          Height = 15.118120000000000000
          DataSet = frxCadSep
          DataSetName = 'frxCadSep'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Endere'#231'o: [frxCadEmp."EMP_ENDERE"] - [frxCadEmp."EMP_ENDNUM"] [f' +
              'rxCadEmp."EMP_ENDCMP"]    C.E.P:: [frxCadEmp."EMP_C_E_P_"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object FooterMeiaFolha: TfrxFooter
        FillType = ftBrush
        Height = 23.141734720000000000
        Top = 483.779840000000000000
        Visible = False
        Width = 718.110700000000000000
        OnBeforePrint = 'FooterMeiaFolhaOnBeforePrint'
        object Shape1: TfrxShapeView
          Top = 5.000000000000000000
          Width = 718.110700000000000000
          Height = 14.362204720000000000
          Fill.BackColor = clSilver
        end
        object Memo30: TfrxMemoView
          Left = 540.441547800000000000
          Top = 6.889763780000000000
          Width = 173.858380000000000000
          Height = 11.338590000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              'VALOR  GERAL: [SUM(<frxItens."VALITE">-<frxItens."DESESP">+<frxI' +
              'tens."VALIPI">+<frxItens."VALRET">, MasterDataMeiaFolha) #n%2,2n' +
              ']')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbValTotGer: TfrxMemoView
          Left = 22.267887400000000000
          Top = 6.889763780000000000
          Width = 124.724428980000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
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
            
              'TOTAL PROD.: [SUM(<frxItens."VALITE">, MasterDataMeiaFolha) #n%2' +
              ',2n]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbIpi: TfrxMemoView
          Left = 411.307360000000000000
          Top = 6.889763780000000000
          Width = 124.724428980000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
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
            
              'Total IPI: [SUM(<frxItens."VALIPI">, MasterDataMeiaFolha) #n%2,2' +
              'n]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbDesEsp: TfrxMemoView
          Left = 152.417440000000000000
          Top = 6.889763780000000000
          Width = 124.724428980000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
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
            
              'DESC. ESPE.: [SUM(<frxItens."DESESP">, MasterDataMeiaFolha) #n%2' +
              ',2n]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbSub: TfrxMemoView
          Left = 282.480520000000000000
          Top = 6.889763780000000000
          Width = 124.724428980000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
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
            
              'SUB. TRIB.: [SUM(<frxItens."VALRET">, MasterDataMeiaFolha) #n%2,' +
              '2n]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxDocSep40Item_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43934.747672175920000000
    ReportOptions.LastChange = 43934.747672175920000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 144
    Top = 152
    Datasets = <
      item
        DataSet = frxDBSepItem
        DataSetName = 'frxDBSepItem'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 74.000000000000000000
      PaperHeight = 170.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 64.252010000000000000
        Top = 18.897650000000000000
        Width = 204.094620000000000000
        Child = frxDocSep40Item_J.ChildVendedor
        object Memo1: TfrxMemoView
          Align = baLeft
          Top = 49.244094489999990000
          Width = 200.315090000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente: [CODCLI] - [NOMCLI]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo2: TfrxMemoView
          Align = baCenter
          Left = 5.669294999999996000
          Top = 27.133890000000000000
          Width = 192.756030000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'SEPARACAO - CLIENTE NO BALCAO')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baCenter
          Left = 5.669294999999996000
          Top = 1.118120000000001000
          Width = 192.756030000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMFAN]')
          ParentFont = False
        end
      end
      object ChildVendedor: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 105.826840000000000000
        Width = 204.094620000000000000
        Child = frxDocSep40Item_J.ChildDigitador
        object Memo3: TfrxMemoView
          Align = baLeft
          Top = 0.779529999999994100
          Width = 200.315090000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vendedor: [VENDED]')
          ParentFont = False
        end
      end
      object ChildDigitador: TfrxChild
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 147.401670000000000000
        Width = 204.094620000000000000
        object Memo5: TfrxMemoView
          Align = baLeft
          Top = 1.000000000000000000
          Width = 200.314960630000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Digitador: [DIGITA]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = -0.220470000000000000
          Top = 37.795300000000000000
          Width = 204.094620000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo23: TfrxMemoView
          Align = baLeft
          Top = 18.897650000000000000
          Width = 200.314960630000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Operador: [OPELOG]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 26.456710000000030000
        Top = 253.228510000000000000
        Width = 204.094620000000000000
        object Memo6: TfrxMemoView
          Align = baLeft
          Top = 1.338590000000011000
          Width = 34.015770000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'COD.')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 47.354360000000000000
          Top = 1.511811020000039000
          Width = 67.370130000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 118.811070000000000000
          Top = 1.511811020000039000
          Width = 34.015770000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baRight
          Left = 154.960730000000000000
          Top = 1.511811020000039000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 0.779529999999999900
          Top = 21.236240000000100000
          Width = 204.094620000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 302.362400000000000000
        Width = 204.094620000000000000
        Child = frxDocSep40Item_J.ChildQtdIte
        DataSet = frxDBSepItem
        DataSetName = 'frxDBSepItem'
        RowCount = 0
        object Memo10: TfrxMemoView
          Align = baLeft
          Top = 2.338590000000011000
          Width = 42.677180000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSepItem."CODITE"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 47.354360000000000000
          Top = 2.267716539999981000
          Width = 157.858380000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSepItem."DESITE"]')
          ParentFont = False
        end
      end
      object ChildQtdIte: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 343.937230000000000000
        Width = 204.094620000000000000
        Child = frxDocSep40Item_J.Child1
        object Memo12: TfrxMemoView
          Align = baRight
          Left = 154.960761730000000000
          Width = 49.133858270000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBSepItem."VALUNI"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 118.677165350000000000
          Width = 34.015748030000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSepItem."UNIDAD"]')
          ParentFont = False
        end
      end
      object ChildCodFab: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 427.086890000000000000
        Width = 204.094620000000000000
        Child = frxDocSep40Item_J.ChildRefIte
        Stretched = True
        object Memo16: TfrxMemoView
          Align = baLeft
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'COD.FAB.:')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 60.590600000000000000
          Width = 139.842610000000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSepItem."CODFAB"]')
          ParentFont = False
        end
      end
      object ChildRefIte: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 468.661720000000000000
        Width = 204.094620000000000000
        Stretched = True
        object Memo18: TfrxMemoView
          Align = baLeft
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REF.ITEM:')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 60.590600000000000000
          Width = 139.842610000000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSepItem."REFERE"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 26.456709999999990000
        Top = 510.236550000000000000
        Width = 204.094620000000000000
        object Memo20: TfrxMemoView
          Align = baLeft
          Top = 8.000000000000056000
          Width = 113.385900000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data: [DTAENT]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Align = baRight
          Left = 120.944960000000000000
          Top = 8.000000000000056000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Hora: [HORENT]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = -0.220470000000000200
          Top = 3.779530000000079000
          Width = 204.094620000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ColumnFooter1: TfrxColumnFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 597.165740000000000000
        Width = 204.094620000000000000
        object Memo22: TfrxMemoView
          Align = baLeft
          Width = 200.315090000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SALTO]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 385.512060000000000000
        Width = 204.094620000000000000
        Child = frxDocSep40Item_J.ChildCodFab
        Stretched = True
        object Memo14: TfrxMemoView
          Align = baLeft
          Top = 0.425169999999980000
          Width = 34.015770000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOC.:')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 35.913420000000000000
          Top = 0.425169999999980000
          Width = 170.078850000000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSepItem."LOCFIS"]')
          ParentFont = False
        end
      end
    end
  end
end
