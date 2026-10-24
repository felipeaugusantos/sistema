object frmQckRomGer: TfrmQckRomGer
  Left = 0
  Top = 0
  ClientHeight = 431
  ClientWidth = 504
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
  object frxItensCliM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41946.595091840300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;           '
      ''
      
        'procedure frxDBItensCliGER_FONEOnAfterData(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  frxDBItensCliGER_FONE.Text := fFormataFoneInterna(frxDBItensCl' +
        'iGER_FONE.Text);                                                ' +
        '                                                                ' +
        '  '
      'end;'
      ''
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  if ( <frxDBItensCli."DET_NUMLOT"> <> '#39#39' ) then'
      '    frbLote.Visible := True'
      '  else'
      '    frbLote.Visible := False;'
      
        '  rllMetragem.Text :=  fRetMetragemItem(<frxDBItensCli."DET_AUTI' +
        'NC">,'
      
        '                                        <frxDBItensCli."GER_ESPD' +
        'OC"> );'
      '  chdMedidas.Visible := rllMetragem.Text <> '#39#39';        '
      'end;'
      ''
      'begin'
      '                                             '
      'end.')
    OnUserFunction = frxItensCliMUserFunction
    Left = 264
    Top = 16
    Datasets = <
      item
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckAnalitico: TfrxDMPPage
      PaperWidth = 335.279783465139800000
      PaperHeight = 143.933240376448900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 374.000000000000000000
        Width = 1248.000000000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        Child = frxItensCliM.frbLote
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
        RowCount = 0
        Stretched = True
        object frxDBItensCliDET_ITEM: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_ITEM'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_ITEM"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_DESCRI: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_DESCRI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_UNIDAD: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDAD'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNIDAD"]')
          TruncOutboundText = False
        end
        object frxDBItensCliMAR_DESMAR: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'MAR_DESMAR'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."MAR_DESMAR"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_QTDITE: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_QTDITE"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 748.000000000000000000
        Width = 1248.000000000000000000
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 796.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 384.000000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 19.200000000000000000
          Top = 51.000000000000000000
          Width = 1219.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 115.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object MMoBS: TfrxDMPMemoView
          Align = baCenter
          Left = 19.200000000000000000
          Top = 68.000000000000000000
          Width = 1219.200000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[OBSERVACAO]')
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 136.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Child = frxItensCliM.ChildMsgExp
        Condition = 'frxDBItensCli."DOCQUEBRA"'
        KeepChild = True
        KeepTogether = True
        PrintChildIfInvisible = True
        StartNewPage = True
        Stretched = True
        object frxDBItensCliDET_NOMCLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_NOMCLI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NOMCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_CEPCLI: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CEP: [frxDBItensCli."GER_CEPCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_FONE: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 34.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'frxDBItensCliGER_FONEOnAfterData'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."GER_FONE"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_NOMCID: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 51.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CIDADE: [frxDBItensCli."GER_NOMCID"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_ENDCLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO: [frxDBItensCli."GER_ENDCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_BAICLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BAIRRO..: [frxDBItensCli."GER_BAICLI"]')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS1...: [frxDBItensCli."GER_MEN001"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS2...: [frxDBItensCli."GER_MEN002"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TELEFONE:')
          TruncOutboundText = False
        end
        object rllPalet: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 85.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PALET: [frxDBItensCli."GER_PALET_"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object frxDBItensCliGER_NUMDOC: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              '[frxDBItensCli."GER_NUMDOC"] [frxDBItensCli."GER_ESPDOC"] [frxDB' +
              'ItensCli."GER_CODEMP"]')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 681.600000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              '[frxDBItensCli."GER_NUMFAT"] [frxDBItensCli."GER_TIPFAT"] [frxDB' +
              'ItensCli."GER_EMPFAT"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 493.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Child = frxItensCliM.childAssinatura
        object DMPMemo17: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS')
          TruncOutboundText = False
        end
        object rllTempTot: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_QTDITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine5: TfrxDMPLineView
          Left = 1128.000000000000000000
          Top = 8.500000000000000000
          Width = 115.200000000000000000
          Color = clBlack
        end
      end
      object ChildMsgExp: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 255.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Child = frxItensCliM.childTitulo
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            'MENS EXP: [frxDBItensCli."GER_MSGEXP"]')
          TruncOutboundText = False
        end
      end
      object childTitulo: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 289.000000000000000000
        Width = 1248.000000000000000000
        PrintChildIfInvisible = True
        object DMPMemo25: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR:')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 34.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DESCRICAO / REFERENCIA / LOTE')
          TruncOutboundText = False
        end
        object mmoTitQtdIte: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MARCA')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 34.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 697.000000000000000000
        Width = 1248.000000000000000000
      end
      object frbLote: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 408.000000000000000000
        Width = 1248.000000000000000000
        object DMPMemo7: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            'LOTE: [frxDBItensCli."DET_NUMLOT"]')
          TruncOutboundText = False
        end
      end
      object childAssinatura: TfrxChild
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 561.000000000000000000
        Width = 1248.000000000000000000
        object mmoMsgRod: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 1238.400000000000000000
          Height = 51.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'ASSUMO TOTAL RESPONSABILIDADE PELAS MERCADORIAS CORRESPONDENTES ' +
              'AS NFs RELACIONADAS NESTE '
            
              'ROMANEIO DE ENTREGA, COMO AINDA DECLARO CERTAS AS QUANTIDADES CA' +
              'RREGADAS EM MEU VEICULO.')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 556.799999999999900000
          Top = 51.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASS. CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASS.CONFERENTE')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'R.G. CLIENTE')
          TruncOutboundText = False
        end
      end
      object chdMedidas: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 442.000000000000000000
        Width = 1248.000000000000000000
        object rllMetragem: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1008.000000000000000000
          Height = 34.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          TruncOutboundText = False
        end
      end
    end
  end
  object frxDBItensCli: TfrxDBDataset
    UserName = 'frxDBItensCli'
    CloseDataSource = False
    DataSource = dtsGenPg1
    BCDToCurrency = False
    Left = 32
    Top = 210
  end
  object dtsGenPg1: TDataSource
    Left = 104
    Top = 210
  end
  object frxItensCliJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44964.477179768520000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;                      '
      ''
      
        'procedure frxDBItensCliGER_FONEOnAfterData(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  frxDBItensCliGER_FONE.Text := fFormataFoneInterna(frxDBItensCl' +
        'iGER_FONE.Text);                                                ' +
        '                                                                ' +
        '  '
      'end;'
      ''
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  if ( <frxDBItensCli."DET_NUMLOT"> <> '#39#39' ) then'
      '    frbLote.Visible := True            '
      '  else'
      '    frbLote.Visible := False;'
      
        '  rllMetragem.Text :=  fRetMetragemItem(<frxDBItensCli."DET_AUTI' +
        'NC">,'
      
        '                                        <frxDBItensCli."GER_ESPD' +
        'OC"> );'
      
        '  chdMedidas.Visible := rllMetragem.Text <> '#39#39';                 ' +
        '                                             '
      '        '
      'end;'
      ''
      'begin'
      '                                               '
      'end.')
    OnUserFunction = frxItensCliMUserFunction
    Left = 167
    Top = 16
    Datasets = <
      item
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckAnalitico: TfrxReportPage
      PaperWidth = 255.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 411.968770000000000000
        Width = 888.189550000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        Child = frxItensCliJ.frbLote
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 888.189550000000000000
          Height = 18.897637800000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object frxDBItensCliDET_ITEM: TfrxMemoView
          Left = 9.600000000000000000
          Top = 0.948818899999992100
          Width = 98.040940000000000000
          Height = 17.000000000000000000
          DataField = 'DET_ITEM'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_ITEM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_DESCRI: TfrxMemoView
          Left = 112.461410000000000000
          Top = 0.948818899999992100
          Width = 498.292950000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'DET_DESCRI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_DESCRI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_UNIDAD: TfrxMemoView
          Left = 747.858380000000000000
          Top = 0.948818899999992100
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDAD'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNIDAD"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliMAR_DESMAR: TfrxMemoView
          Left = 614.620470000000000000
          Top = 0.948818899999992100
          Width = 129.184230000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'MAR_DESMAR'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_QTDITE: TfrxMemoView
          Left = 779.640940000000000000
          Top = 0.948818899999992100
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_QTDITE'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_QTDITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 737.008350000000000000
        Width = 888.189550000000000000
        object rllTotalImpresso: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 87.685039370000000000
        Top = 18.897650000000000000
        Width = 888.189550000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 136.894775000000000000
          Top = 17.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 199.294775000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 768.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 816.000000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 691.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 5.631695000000036000
          Top = 51.000000000000000000
          Width = 876.926160000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object mmObs: TfrxMemoView
          Align = baCenter
          Left = 5.631695000000036000
          Top = 69.811070000000000000
          Width = 876.926160000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[OBSERVACAO]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 105.747990000000000000
        Top = 166.299320000000000000
        Width = 888.189550000000000000
        AllowSplit = True
        Child = frxItensCliJ.ChildMsgExp
        Condition = 'frxDBItensCli."DOCQUEBRA"'
        KeepChild = True
        KeepTogether = True
        PrintChildIfInvisible = True
        StartNewPage = True
        object frxDBItensCliDET_NOMCLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 420.661410000000000000
          Height = 17.000000000000000000
          DataField = 'DET_NOMCLI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NOMCLI"]')
        end
        object frxDBItensCliGER_CEPCLI: TfrxMemoView
          Left = 703.747990000000000000
          Top = 34.000000000000000000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CEP: [frxDBItensCli."GER_CEPCLI"]')
        end
        object frxDBItensCliGER_FONE: TfrxMemoView
          Left = 703.747990000000000000
          Top = 17.000000000000000000
          Width = 181.492950000000000000
          Height = 17.000000000000000000
          OnAfterData = 'frxDBItensCliGER_FONEOnAfterData'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."GER_FONE"]')
        end
        object frxDBItensCliGER_NOMCID: TfrxMemoView
          Left = 508.800000000000000000
          Top = 51.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CIDADE: [frxDBItensCli."GER_NOMCID"]')
        end
        object frxDBItensCliGER_ENDCLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 688.403030000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO: [frxDBItensCli."GER_ENDCLI"]')
        end
        object frxDBItensCliGER_BAICLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BAIRRO..: [frxDBItensCli."GER_BAICLI"]')
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 8.500000000000000000
          Width = 888.189550000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo9: TfrxMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 688.403030000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS1...: [frxDBItensCli."GER_MEN001"]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 688.403030000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS2...: [frxDBItensCli."GER_MEN002"]')
          WordWrap = False
        end
        object rllPalet: TfrxMemoView
          Left = 701.992580000000000000
          Top = 85.000000000000000000
          Width = 181.417366770000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PALET: [frxDBItensCli."GER_PALET_"]')
          WordWrap = False
        end
        object frxDBItensCliGER_NUMDOC: TfrxMemoView
          Left = 438.425480000000000000
          Top = 17.000000000000000000
          Width = 121.852010000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              '[frxDBItensCli."GER_NUMDOC"] [frxDBItensCli."GER_ESPDOC"] [frxDB' +
              'ItensCli."GER_CODEMP"]')
        end
        object Memo7: TfrxMemoView
          Left = 575.832160000000100000
          Top = 17.000000000000000000
          Width = 121.852010000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              '[frxDBItensCli."GER_NUMFAT"] [frxDBItensCli."GER_TIPFAT"] [frxDB' +
              'ItensCli."GER_EMPFAT"]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 39.629870000000000000
        Top = 551.811380000000000000
        Width = 888.189550000000000000
        Child = frxItensCliJ.childAssinatura
        object Memo17: TfrxMemoView
          Left = 508.800000000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS')
          ParentFont = False
        end
        object rllTempTot: TfrxMemoView
          Left = 779.716535430000000000
          Top = 17.000000000000000000
          Width = 105.448818897637800000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_QTDITE">,rlbDetalhes)]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 883.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildTitulo: TfrxChild
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 336.378170000000000000
        Width = 888.189550000000000000
        PrintChildIfInvisible = True
        object Shape1: TfrxShapeView
          Left = 0.779530000000000000
          Top = 29.236240000000010000
          Width = 888.189550000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 10.159060000000000000
          Top = 31.952690000000020000
          Width = 98.040940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 113.020470000000000000
          Top = 31.952690000000020000
          Width = 228.359060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRICAO / REFERENCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 787.759060000000000000
          Top = 31.952690000000020000
          Width = 98.040940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 614.620470000000000000
          Top = 31.952690000000020000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 748.417440000000000000
          Top = 31.952690000000020000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 105.600000000000000000
          Top = 0.732219999999983900
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMVEN"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 9.600000000000000000
          Top = 0.732219999999983900
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENDEDOR:')
          ParentFont = False
        end
      end
      object ChildMsgExp: TfrxChild
        FillType = ftBrush
        Height = 18.897635350000000000
        Top = 294.803340000000000000
        Width = 888.189550000000000000
        AllowSplit = True
        Child = frxItensCliJ.ChildTitulo
        PrintChildIfInvisible = True
        Stretched = True
        object Memo22: TfrxMemoView
          Left = 10.000000000000000000
          Width = 873.071430000000000000
          Height = 15.118105350000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS EXP.: [frxDBItensCli."GER_MSGEXP"]')
        end
      end
      object frbLote: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 453.543600000000000000
        Width = 888.189550000000000000
        Child = frxItensCliJ.chdMedidas
        PrintChildIfInvisible = True
        object mmoLote: TfrxMemoView
          Left = 124.724490000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOTE: [frxDBItensCli."DET_NUMLOT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object childAssinatura: TfrxChild
        FillType = ftBrush
        Height = 60.472480000000000000
        Top = 616.063390000000000000
        Width = 888.189550000000000000
        object mmoMsgRod: TfrxMemoView
          Left = 6.338590000000000000
          Top = 3.779530000000022000
          Width = 605.253680000000000000
          Height = 45.354330710000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'FAVOR CONFERIR  OS PRODUTOS ENTREGUES.'
            'NAO ACEITAREMOS RECLAMACOES POSTERIORES.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 624.933735000000000000
          Top = 32.779530000000030000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA')
        end
      end
      object chdMedidas: TfrxChild
        FillType = ftBrush
        Height = 33.236240000000000000
        Top = 495.118430000000000000
        Width = 888.189550000000000000
        object rllMetragem: TfrxMemoView
          Left = 15.118120000000000000
          Top = 3.000000000000000000
          Width = 869.291900000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
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
    Left = 424
    Top = 80
  end
  object frxItensEntM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40856.594646990750000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '      '
      ''
      
        'procedure frxDBItensCliGER_FONEOnAfterData(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  frxDBItensCliGER_FONE.Text := fFormataFoneInterna(frxDBItensCl' +
        'iGER_FONE.Text);                                                ' +
        '                                                                ' +
        '  '
      'end;'
      ''
      'begin'
      '    '
      'end.')
    OnUserFunction = frxItensCliMUserFunction
    Left = 32
    Top = 69
    Datasets = <
      item
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckAnalitico: TfrxDMPPage
      PaperWidth = 335.279783465139800000
      PaperHeight = 143.933240376448900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 374.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
        RowCount = 0
        Stretched = True
        object frxDBItensCliDET_ITEM: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_ITEM"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_DESCRI: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              '[IIF(<frxDBItensCli."DET_NUMLOT"> = '#39#39', <frxDBItensCli."DET_DESC' +
              'RI">, '
            
              '           <frxDBItensCli."DET_NUMLOT"> + '#39' / '#39' + <frxDBItensCli' +
              '."DET_DESCRI">)]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_UNIDAD: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDAD'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNIDAD"]')
          TruncOutboundText = False
        end
        object frxDBItensCliMAR_DESMAR: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'MAR_DESMAR'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."MAR_DESMAR"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_QTDITE: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_QTDITE"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_NUMDOC: TfrxDMPMemoView
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NUMDOC"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_ESPDOC: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          DataField = 'GER_ESPDOC'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_ESPDOC"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_CODEMP: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'GER_CODEMP'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_CODEMP"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 629.000000000000000000
        Width = 1248.000000000000000000
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 796.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 384.000000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 326.400000000000000000
          Top = 51.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 115.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object mmObs: TfrxDMPMemoView
          Align = baCenter
          Left = 326.400000000000000000
          Top = 68.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[OBSERVACAO]')
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 136.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Child = frxItensEntM.ChildMsgExp
        Condition = 'frxDBItensCli."DOCQUEBRA"'
        KeepChild = True
        KeepTogether = True
        PrintChildIfInvisible = True
        StartNewPage = True
        Stretched = True
        object frxDBItensCliDET_NOMCLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_NOMCLI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NOMCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_CEPCLI: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CEP: [frxDBItensCli."GER_CEPCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_FONE: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 34.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'frxDBItensCliGER_FONEOnAfterData'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItensCli."GER_FONE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDBItensCliGER_NOMCID: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 68.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CIDADE: [frxDBItensCli."GER_NOMCID"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_ENDCLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO: [frxDBItensCli."GER_ENDCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_BAICLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BAIRRO..: [frxDBItensCli."GER_BAICLI"]')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FANTASIA: [frxDBItensCli."DET_FANSOB"]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TELEFONE:')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            'MENSAGEM: [frxDBItensCli."GER_MENSAG"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 408.000000000000000000
        Width = 1248.000000000000000000
        Child = frxItensEntM.childAssinatura
        object DMPMemo17: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS')
          TruncOutboundText = False
        end
        object rllTempTot: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_QTDITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object ChildMsgExp: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 255.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Child = frxItensEntM.childTitulo
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            'MENS EXP: [frxDBItensCli."GER_MSGEXP"]')
          TruncOutboundText = False
        end
      end
      object childTitulo: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 289.000000000000000000
        Width = 1248.000000000000000000
        PrintChildIfInvisible = True
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 34.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOTE / DESCRICAO / REFERENCIA')
          TruncOutboundText = False
        end
        object mmoTitQtdIte: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MARCA')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 34.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR:')
          TruncOutboundText = False
        end
      end
      object childAssinatura: TfrxChild
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 476.000000000000000000
        Width = 1248.000000000000000000
        object mmoMsgRod: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 1238.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'ASSUMO TOTAL RESPONSABILIDADE PELAS MERCADORIAS CORRESPONDENTES ' +
              'AS NFs RELACIONADAS NESTE '
            
              'ROMANEIO DE ENTREGA, COMO AINDA DECLARO CERTAS AS QUANTIDADES CA' +
              'RREGADAS EM MEU VEICULO.')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 556.799999999999900000
          Top = 51.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASS. CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASS.CONFERENTE')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'R.G. CLIENTE')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxItensEntj: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40856.595015729170000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '      '
      ''
      
        'procedure frxDBItensCliGER_FONEOnAfterData(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  frxDBItensCliGER_FONE.Text := fFormataFoneInterna(frxDBItensCl' +
        'iGER_FONE.Text);                                                ' +
        '                                                                ' +
        '  '
      'end;'
      ''
      'begin'
      '    '
      'end.')
    OnUserFunction = frxItensCliMUserFunction
    Left = 88
    Top = 77
    Datasets = <
      item
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckAnalitico: TfrxReportPage
      PaperWidth = 255.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897637800000000000
        ParentFont = False
        Top = 419.527830000000000000
        Width = 888.189550000000000000
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 888.189550000000000000
          Height = 18.897637800000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object frxDBItensCliDET_ITEM: TfrxMemoView
          Left = 164.409448820000000000
          Top = 0.948818899999992100
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          DataField = 'DET_ITEM'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_ITEM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_DESCRI: TfrxMemoView
          Left = 351.496062992126000000
          Top = 0.948818899999992100
          Width = 258.519685039370100000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'DET_DESCRI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_DESCRI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_UNIDAD: TfrxMemoView
          Left = 764.976377950000000000
          Top = 0.948818899999992100
          Width = 25.020470000000000000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDAD'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNIDAD"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliMAR_DESMAR: TfrxMemoView
          Left = 614.400000000000000000
          Top = 0.948818899999992100
          Width = 144.302350000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'MAR_DESMAR'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_QTDITE: TfrxMemoView
          Left = 794.759060000000000000
          Top = 0.948818899999992100
          Width = 90.481880000000000000
          Height = 17.000000000000000000
          DataField = 'DET_QTDITE'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_QTDITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliGER_NUMDOC: TfrxMemoView
          Left = 1.435930000000000000
          Top = 0.948818899999992100
          Width = 148.308720000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxDBItensCli."GER_NUMDOC"] [frxDBItensCli."GER_ESPDOC"] [frxDB' +
              'ItensCli."GER_CODEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo14: TfrxMemoView
          Left = 260.787401570000000000
          Top = 0.948818899999992100
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NUMLOT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 653.858690000000000000
        Width = 888.189550000000000000
        object rllTotalImpresso: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 87.685039370000000000
        Top = 18.897650000000000000
        Width = 888.189550000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 136.894775000000000000
          Top = 17.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 199.294775000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 768.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 816.000000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 691.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 141.694775000000000000
          Top = 51.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object mmObs: TfrxMemoView
          Align = baCenter
          Left = 141.694775000000000000
          Top = 70.590600000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[OBSERVACAO]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 111.496062990000000000
        Top = 166.299320000000000000
        Width = 888.189550000000000000
        AllowSplit = True
        Child = frxItensEntj.ChildMsgExp
        Condition = 'frxDBItensCli."DOCQUEBRA"'
        KeepChild = True
        KeepTogether = True
        PrintChildIfInvisible = True
        StartNewPage = True
        Stretched = True
        object frxDBItensCliDET_NOMCLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_NOMCLI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NOMCLI"]')
        end
        object frxDBItensCliGER_CEPCLI: TfrxMemoView
          Left = 589.984230000000000000
          Top = 17.000000000000000000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CEP: [frxDBItensCli."GER_CEPCLI"]')
        end
        object frxDBItensCliGER_FONE: TfrxMemoView
          Left = 703.747990000000000000
          Top = 17.000000000000000000
          Width = 181.492950000000000000
          Height = 17.000000000000000000
          OnAfterData = 'frxDBItensCliGER_FONEOnAfterData'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."GER_FONE"]')
        end
        object frxDBItensCliGER_NOMCID: TfrxMemoView
          Left = 508.800000000000000000
          Top = 73.677179999999990000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CIDADE: [frxDBItensCli."GER_NOMCID"]')
        end
        object frxDBItensCliGER_ENDCLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 56.677179999999990000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO: [frxDBItensCli."GER_ENDCLI"]')
        end
        object frxDBItensCliGER_BAICLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 73.677179999999990000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BAIRRO..: [frxDBItensCli."GER_BAICLI"]')
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 8.500000000000000000
          Width = 888.189550000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo10: TfrxMemoView
          Left = 9.559060000000000000
          Top = 37.795300000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FANTASIA: [frxDBItensCli."DET_FANSOB"]')
        end
        object Memo15: TfrxMemoView
          Left = 11.338590000000000000
          Top = 92.708719999999950000
          Width = 873.071430000000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENSAGEM: [frxDBItensCli."GER_MENSAG"]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 39.629870000000000000
        Top = 461.102660000000000000
        Width = 888.189550000000000000
        Child = frxItensEntj.childAssinatura
        object Memo17: TfrxMemoView
          Left = 508.800000000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS')
          ParentFont = False
        end
        object rllTempTot: TfrxMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_QTDITE">,rlbDetalhes)]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 883.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildTitulo: TfrxChild
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 343.937230000000000000
        Width = 888.189550000000000000
        PrintChildIfInvisible = True
        object Shape1: TfrxShapeView
          Left = 0.220470000000000000
          Top = 30.236240000000010000
          Width = 888.189550000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 164.409448818897700000
          Top = 32.846475000000000000
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 351.496062992126000000
          Top = 32.846475000000000000
          Width = 258.519685039370100000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRICAO / REFERENCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 794.759060000000000000
          Top = 32.846475000000000000
          Width = 90.481880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 614.400000000000000000
          Top = 32.846475000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 764.976500000000000000
          Top = 32.846475000000000000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 105.600000000000000000
          Top = 1.732219999999984000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMVEN"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 9.600000000000000000
          Top = 1.732219999999984000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENDEDOR:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 1.000000000000000000
          Top = 32.846475000000000000
          Width = 90.481880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 260.787401574803100000
          Top = 32.846475000000000000
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOTE')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildMsgExp: TfrxChild
        FillType = ftBrush
        Height = 18.897635350000000000
        Top = 302.362400000000000000
        Width = 888.189550000000000000
        AllowSplit = True
        Child = frxItensEntj.ChildTitulo
        PrintChildIfInvisible = True
        Stretched = True
        object Memo9: TfrxMemoView
          Left = 10.000000000000000000
          Top = 1.000000000000000000
          Width = 873.071430000000000000
          Height = 15.118105350000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS EXP.: [frxDBItensCli."GER_MSGEXP"]')
        end
      end
      object childAssinatura: TfrxChild
        FillType = ftBrush
        Height = 68.031540000000010000
        Top = 525.354670000000100000
        Width = 888.189550000000000000
        object mmoMsgRod: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118119999999980000
          Width = 605.253680000000000000
          Height = 45.354330710000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'FAVOR CONFERIR  OS PRODUTOS ENTREGUES.'
            'NAO ACEITAREMOS RECLAMACOES POSTERIORES.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 622.374675000000000000
          Top = 42.118119999999970000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA')
        end
      end
    end
  end
  object frxItensEntEmbSepM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42170.639179351850000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '      '
      ''
      
        'procedure frxDBItensCliGER_FONEOnAfterData(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  frxDBItensCliGER_FONE.Text := fFormataFoneInterna(frxDBItensCl' +
        'iGER_FONE.Text);                                                ' +
        '                                                                ' +
        '  '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  mmoQtdCai.visible := <frxDBItensCli."ITE_MLTVEN"> > 0;    '
      'end;'
      ''
      'begin'
      '    '
      'end.')
    OnUserFunction = frxItensCliMUserFunction
    Left = 32
    Top = 128
    Datasets = <
      item
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckAnalitico: TfrxDMPPage
      PaperWidth = 335.279783465139800000
      PaperHeight = 143.933240376448900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 1248.000000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        AllowSplit = True
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
        RowCount = 0
        Stretched = True
        object frxDBItensCliDET_ITEM: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_ITEM"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_DESCRI: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              '[IIF(<frxDBItensCli."DET_NUMLOT"> = '#39#39', <frxDBItensCli."DET_DESC' +
              'RI">, '
            
              '           <frxDBItensCli."DET_NUMLOT"> + '#39' / '#39' + <frxDBItensCli' +
              '."DET_DESCRI">)]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_UNIDAD: TfrxDMPMemoView
          Left = 988.800000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDAD'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNIDAD"]')
          TruncOutboundText = False
        end
        object frxDBItensCliMAR_DESMAR: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'MAR_DESMAR'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."MAR_DESMAR"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_QTDITE: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_QTDITE"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_NUMDOC: TfrxDMPMemoView
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NUMDOC"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_ESPDOC: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          DataField = 'GER_ESPDOC'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_ESPDOC"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_CODEMP: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'GER_CODEMP'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_CODEMP"]')
          TruncOutboundText = False
        end
        object mmoQtdCai: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxDBItensCli."ITE_MLTVEN"> > 0, <frxDBItensCli."DET_QTDIT' +
              'E">/<frxDBItensCli."ITE_MLTVEN">, 0 )]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 612.000000000000000000
        Width = 1248.000000000000000000
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 796.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 384.000000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 326.400000000000000000
          Top = 51.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 115.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object mmObs: TfrxDMPMemoView
          Align = baCenter
          Left = 326.400000000000000000
          Top = 68.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[OBSERVACAO]')
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 136.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Child = frxItensEntEmbSepM.ChildMsgExp
        Condition = 'frxDBItensCli."DOCQUEBRA"'
        KeepChild = True
        KeepTogether = True
        StartNewPage = True
        Stretched = True
        object frxDBItensCliDET_NOMCLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_NOMCLI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NOMCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_CEPCLI: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CEP: [frxDBItensCli."GER_CEPCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_FONE: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 34.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'frxDBItensCliGER_FONEOnAfterData'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."GER_FONE"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_NOMCID: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 68.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CIDADE: [frxDBItensCli."GER_NOMCID"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_ENDCLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO: [frxDBItensCli."GER_ENDCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_BAICLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BAIRRO..: [frxDBItensCli."GER_BAICLI"]')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FANTASIA: [frxDBItensCli."DET_FANSOB"]')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TELEFONE:')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 391.000000000000000000
        Width = 1248.000000000000000000
        Child = frxItensEntEmbSepM.childAssinatura
        object DMPMemo17: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS')
          TruncOutboundText = False
        end
        object rllTempTot: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_QTDITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object ChildMsgExp: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Child = frxItensEntEmbSepM.childTitulo
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            'MENSAGEM: [frxDBItensCli."GER_MENSAG"]'
            'MENS EXP: [frxDBItensCli."GER_MSGEXP"]')
          TruncOutboundText = False
        end
      end
      object childTitulo: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 272.000000000000000000
        Width = 1248.000000000000000000
        PrintChildIfInvisible = True
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 34.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOTE / DESCRICAO / REFERENCIA')
          TruncOutboundText = False
        end
        object mmoTitQtdIte: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MARCA')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 34.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR:')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CAIXAS')
          TruncOutboundText = False
        end
      end
      object childAssinatura: TfrxChild
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 459.000000000000000000
        Width = 1248.000000000000000000
        object mmoMsgRod: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 1238.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'ASSUMO TOTAL RESPONSABILIDADE PELAS MERCADORIAS CORRESPONDENTES ' +
              'AS NFs RELACIONADAS NESTE '
            
              'ROMANEIO DE ENTREGA, COMO AINDA DECLARO CERTAS AS QUANTIDADES CA' +
              'RREGADAS EM MEU VEICULO.')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 556.799999999999900000
          Top = 51.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASS. CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASS.CONFERENTE')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'R.G. CLIENTE')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxItensEntEmbSepJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44964.642970138890000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '      '
      ''
      
        'procedure frxDBItensCliGER_FONEOnAfterData(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  frxDBItensCliGER_FONE.Text := fFormataFoneInterna(frxDBItensCl' +
        'iGER_FONE.Text);                                                ' +
        '                                                                ' +
        '  '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  mmoQtdCai.visible := <frxDBItensCli."ITE_MLTVEN"> > 0;    '
      'end;'
      ''
      'begin'
      '    '
      'end.')
    OnUserFunction = frxItensCliMUserFunction
    Left = 144
    Top = 128
    Datasets = <
      item
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckAnalitico: TfrxReportPage
      PaperWidth = 255.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897637800000000000
        ParentFont = False
        Top = 408.189240000000000000
        Width = 888.189550000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 888.189550000000000000
          Height = 18.897637800000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object frxDBItensCliDET_ITEM: TfrxMemoView
          Left = 168.188976380000000000
          Top = 0.948818899999992100
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          DataField = 'DET_ITEM'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_ITEM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_DESCRI: TfrxMemoView
          Left = 351.496062992126000000
          Top = 0.948818899999992100
          Width = 198.047244094488200000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'DET_DESCRI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_DESCRI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_UNIDAD: TfrxMemoView
          Left = 704.503897950000000000
          Top = 0.948818897637807000
          Width = 25.020470000000000000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDAD'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNIDAD"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliMAR_DESMAR: TfrxMemoView
          Left = 553.927520000000000000
          Top = 0.948818897637807000
          Width = 144.302350000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'MAR_DESMAR'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_QTDITE: TfrxMemoView
          Left = 734.286580000000000000
          Top = 0.948818897637807000
          Width = 82.922820000000000000
          Height = 17.000000000000000000
          DataField = 'DET_QTDITE'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_QTDITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliGER_NUMDOC: TfrxMemoView
          Left = 1.435930000000000000
          Top = 0.948818899999992100
          Width = 165.921259840000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxDBItensCli."GER_NUMDOC"] [frxDBItensCli."GER_ESPDOC"] [frxDB' +
              'ItensCli."GER_CODEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo14: TfrxMemoView
          Left = 260.787401574803100000
          Top = 0.948818899999992100
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NUMLOT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoQtdCai: TfrxMemoView
          Left = 820.158010000000000000
          Top = 0.948818897637807000
          Width = 67.804700000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxDBItensCli."ITE_MLTVEN"> > 0, <frxDBItensCli."DET_QTDIT' +
              'E">/<frxDBItensCli."ITE_MLTVEN">, 0 )]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 623.622450000000000000
        Width = 888.189550000000000000
        object rllTotalImpresso: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 87.685039370000000000
        Top = 18.897650000000000000
        Width = 888.189550000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 136.894775000000000000
          Top = 17.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 199.294775000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 768.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 816.000000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 691.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 141.694775000000000000
          Top = 51.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object mmObs: TfrxMemoView
          Align = baCenter
          Left = 141.694775000000000000
          Top = 70.590600000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[OBSERVACAO]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 94.409400000000000000
        Top = 166.299320000000000000
        Width = 888.189550000000000000
        AllowSplit = True
        Child = frxItensEntEmbSepJ.ChildMsgExp
        Condition = 'frxDBItensCli."DOCQUEBRA"'
        KeepChild = True
        KeepTogether = True
        StartNewPage = True
        object Memo10: TfrxMemoView
          Left = 9.559060000000000000
          Top = 37.795300000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FANTASIA: [frxDBItensCli."DET_FANSOB"]')
        end
        object frxDBItensCliDET_NOMCLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_NOMCLI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NOMCLI"]')
        end
        object frxDBItensCliGER_CEPCLI: TfrxMemoView
          Left = 589.984230000000000000
          Top = 17.000000000000000000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CEP: [frxDBItensCli."GER_CEPCLI"]')
        end
        object frxDBItensCliGER_FONE: TfrxMemoView
          Left = 703.747990000000000000
          Top = 17.000000000000000000
          Width = 181.492950000000000000
          Height = 17.000000000000000000
          OnAfterData = 'frxDBItensCliGER_FONEOnAfterData'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."GER_FONE"]')
        end
        object frxDBItensCliGER_NOMCID: TfrxMemoView
          Left = 508.800000000000000000
          Top = 73.677179999999990000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CIDADE: [frxDBItensCli."GER_NOMCID"]')
          ParentFont = False
        end
        object frxDBItensCliGER_ENDCLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 56.677179999999990000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO: [frxDBItensCli."GER_ENDCLI"]')
        end
        object frxDBItensCliGER_BAICLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 73.677179999999990000
          Width = 448.025170000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BAIRRO..: [frxDBItensCli."GER_BAICLI"]')
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 8.500000000000000000
          Width = 888.189550000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 39.629870000000000000
        Top = 449.764070000000000000
        Width = 888.189550000000000000
        Child = frxItensEntEmbSepJ.childAssinatura
        object Memo17: TfrxMemoView
          Left = 436.988930000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS')
          ParentFont = False
        end
        object rllTempTot: TfrxMemoView
          Left = 720.168460000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_QTDITE">,rlbDetalhes)]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 883.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildTitulo: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 56.692950000000000000
        ParentFont = False
        Top = 328.819110000000000000
        Width = 888.189550000000000000
        object Shape1: TfrxShapeView
          Left = 0.220470000000000000
          Top = 30.236240000000010000
          Width = 888.189550000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 168.188976377952700000
          Top = 34.015769999999970000
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 351.496062992126000000
          Top = 34.015769999999970000
          Width = 198.047244094488200000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRICAO / REFERENCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 734.286580000000000000
          Top = 34.015769999999970000
          Width = 82.922820000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 553.927520000000000000
          Top = 34.015769999999970000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 704.504020000000000000
          Top = 34.015769999999970000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 105.600000000000000000
          Top = 5.732219999999984000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMVEN"]')
        end
        object Memo12: TfrxMemoView
          Left = 9.600000000000000000
          Top = 5.732219999999984000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR:')
        end
        object Memo7: TfrxMemoView
          Left = 1.000000000000000000
          Top = 34.015769999999970000
          Width = 165.921259840000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 260.787401574803100000
          Top = 34.015769999999970000
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOTE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 820.158010000000000000
          Top = 34.015769999999970000
          Width = 67.804700000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'CAIXAS')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildMsgExp: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 283.464750000000000000
        Width = 888.189550000000000000
        AllowSplit = True
        Child = frxItensEntEmbSepJ.ChildTitulo
        Stretched = True
        object Memo9: TfrxMemoView
          Left = 9.820470000000000000
          Top = 3.747990000000016000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENSAGEM: [frxDBItensCli."GER_MENSAG"]'
            'MENS EXP.: [frxDBItensCli."GER_MSGEXP"]')
        end
      end
      object childAssinatura: TfrxChild
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 514.016080000000000000
        Width = 888.189550000000000000
        object mmoMsgRod: TfrxMemoView
          Left = 7.559060000000000000
          Width = 605.253680000000000000
          Height = 45.354330710000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'FAVOR CONFERIR  OS PRODUTOS ENTREGUES.'
            'NAO ACEITAREMOS RECLAMACOES POSTERIORES.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 626.154205000000000000
          Top = 28.000000000000120000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA')
        end
      end
    end
  end
  object frxRotaViagemM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40991.497008101800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      ''
      'procedure DMPMemo34OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxDBRotaViagem."VLRTOT"> = 0) Then'
      
        '    rllVlrTot.Text := '#39#39';                                       ' +
        '                '
      'end;'
      ''
      'begin'
      '  If Not rllTitPalet.Visible Then'
      '  Begin'
      
        '    rllTitCliente.Width := rllTitCliente.Width + rllTitPalet.Wid' +
        'th;'
      
        '    rllDetCliente.Width := rllDetCliente.Width + rllDetPalet.Wid' +
        'th;        '
      '  End;            '
      'end.')
    Left = 344
    Top = 210
    Datasets = <
      item
        DataSet = frxDBRotaViagem
        DataSetName = 'frxDBRotaViagem'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckAnalitico: TfrxDMPPage
      PaperWidth = 406.399737533502800000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 289.000000000000000000
        Width = 1516.800000000000000000
        DataSet = frxDBRotaViagem
        DataSetName = 'frxDBRotaViagem'
        RowCount = 0
        Stretched = True
        object frxDBItensCliDET_ITEM: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[Line#]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDBItensCliDET_DESCRI: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMCID'
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            '[frxDBRotaViagem."NOMCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDBItensCliDET_UNIDAD: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'VOLUME'
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRotaViagem."VOLUME"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDBItensCliMAR_DESMAR: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            '[frxDBRotaViagem."NUMDOC"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDBItensCliDET_QTDITE: TfrxDMPMemoView
          Left = 499.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRotaViagem."VLRCON"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 144.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            '[frxDBRotaViagem."FERIAD"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'ESTADO'
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            '[frxDBRotaViagem."ESTADO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllDetCliente: TfrxDMPMemoView
          Left = 259.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMCLI'
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            '[frxDBRotaViagem."NOMCLI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            '[frxDBRotaViagem."NUMFAT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'VENCTO'
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            '[frxDBRotaViagem."VENCTO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'PESBRU'
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRotaViagem."PESBRU"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRotaViagem."VLRPAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 1440.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOTESP'
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBRotaViagem."NOTESP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRotaViagem."QTDPAR"]X')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1478.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBRotaViagem."CODVEN"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllVlrTot: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo34OnBeforePrint'
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRotaViagem."VLRTOT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllDetPalet: TfrxDMPMemoView
          Left = 374.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            '[frxDBRotaViagem."PALET_"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 459.000000000000000000
        Width = 1516.800000000000000000
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1497.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 17.000000000000000000
        Width = 1516.800000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 34.000000000000000000
          Width = 1065.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 163.200000000000000000
          Top = 51.000000000000000000
          Width = 1190.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#77'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 115.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 748.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[MOTORI]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 85.000000000000000000
          Width = 748.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEICUL]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Top = 238.000000000000000000
        Width = 1516.800000000000000000
        Condition = 'frxDBRotaViagem."NOMCID"'
        KeepChild = True
        KeepTogether = True
        Stretched = True
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 1516.800000000000000000
        AllowSplit = True
        object DMPMemo22: TfrxDMPMemoView
          Left = 499.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRotaViagem."VLRCON">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRotaViagem."VOLUME">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 170.000000000000000000
        Width = 1516.800000000000000000
        ReprintOnNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'CIDADE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'FERIADO')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoTitNumDoc: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'NOTA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'UF')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'VOL')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTitCliente: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoTitNumFat: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'PEDIDO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'VENCIMENTOS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'PESO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'SEQ')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR PARC')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1440.000000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ESP')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1478.400000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'REP')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTitPalet: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'PALET')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 391.000000000000000000
        Width = 1516.800000000000000000
        object DMPMemo24: TfrxDMPMemoView
          Left = 1228.800000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRotaViagem."PESBRU">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRotaViagem."VLRCON">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 326.400000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'TOTAIS ->')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBRotaViagem."VLRPAR">*<frxDBRotaViagem."QTDPAR">,rlbDe' +
              'talhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 255.000000000000000000
        Width = 1516.800000000000000000
        Condition = 'frxDBRotaViagem."NOMCLI"'
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 323.000000000000000000
        Width = 1516.800000000000000000
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxDBRotaViagem: TfrxDBDataset
    UserName = 'frxDBRotaViagem'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NOMCID=NOMCID'
      'ESTADO=ESTADO'
      'NOMCLI=NOMCLI'
      'VLRCON=VLRCON'
      'VOLUME=VOLUME'
      'NUMFAT=NUMFAT'
      'NUMDOC=NUMDOC'
      'VENCTO=VENCTO'
      'PESBRU=PESBRU'
      'NOTESP=NOTESP'
      'CODVEN=CODVEN'
      'DTAENT=DTAENT'
      'QTDPAR=QTDPAR'
      'VLRPAR=VLRPAR'
      'VLRTOT=VLRTOT'
      'FERIAD=FERIAD'
      'PALET_=PALET_')
    DataSet = cdsRotaViagem
    BCDToCurrency = False
    Left = 424
    Top = 130
  end
  object cdsRotaViagem: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 424
    Top = 16
    object cdsRotaViagemNOMCID: TStringField
      FieldName = 'NOMCID'
      Size = 50
    end
    object cdsRotaViagemESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 2
    end
    object cdsRotaViagemNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 70
    end
    object cdsRotaViagemVLRCON: TFloatField
      FieldName = 'VLRCON'
    end
    object cdsRotaViagemVOLUME: TFloatField
      FieldName = 'VOLUME'
    end
    object cdsRotaViagemNUMFAT: TStringField
      FieldName = 'NUMFAT'
      Size = 30
    end
    object cdsRotaViagemNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 30
    end
    object cdsRotaViagemVENCTO: TStringField
      FieldName = 'VENCTO'
      Size = 255
    end
    object cdsRotaViagemPESBRU: TFloatField
      FieldName = 'PESBRU'
    end
    object cdsRotaViagemNOTESP: TStringField
      FieldName = 'NOTESP'
      Size = 1
    end
    object cdsRotaViagemCODVEN: TStringField
      FieldName = 'CODVEN'
      Size = 3
    end
    object cdsRotaViagemDTAENT: TDateField
      FieldName = 'DTAENT'
    end
    object cdsRotaViagemQTDPAR: TIntegerField
      FieldName = 'QTDPAR'
    end
    object cdsRotaViagemVLRPAR: TFloatField
      FieldName = 'VLRPAR'
    end
    object cdsRotaViagemVLRTOT: TFloatField
      FieldName = 'VLRTOT'
    end
    object cdsRotaViagemFERIAD: TStringField
      FieldName = 'FERIAD'
      Size = 10
    end
    object strngfldRotaViagemPALET_1: TStringField
      FieldName = 'PALET_'
      Size = 15
    end
  end
  object frxRotaViagemJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40991.510280844900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      ''
      'procedure Memo37OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxDBRotaViagem."VLRTOT"> = 0 Then'
      
        '    rllVlrTot.Text := '#39#39';                                       ' +
        '                                     '
      'end;'
      ''
      'begin'
      '           '
      'end.')
    Left = 432
    Top = 210
    Datasets = <
      item
        DataSet = frxDBRotaViagem
        DataSetName = 'frxDBRotaViagem'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckAnalitico: TfrxReportPage
      PaperWidth = 340.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 257.008040000000000000
        Width = 1209.449600000000000000
        DataSet = frxDBRotaViagem
        DataSetName = 'frxDBRotaViagem'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 1209.449600000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object frxDBItensCliDET_ITEM: TfrxMemoView
          Width = 30.236220470000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Line#]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_DESCRI: TfrxMemoView
          Left = 30.236220470000000000
          Width = 132.283452360000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataField = 'NOMCID'
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBRotaViagem."NOMCID"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_UNIDAD: TfrxMemoView
          Align = baRight
          Left = 642.898462838582100000
          Width = 30.236220470000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataField = 'VOLUME'
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBRotaViagem."VOLUME"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBItensCliMAR_DESMAR: TfrxMemoView
          Align = baRight
          Left = 673.134683308582300000
          Width = 117.165354330708700000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBRotaViagem."NUMDOC"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_QTDITE: TfrxMemoView
          Align = baRight
          Left = 491.717367798582200000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRotaViagem."VLRCON"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 162.858267720000000000
          Width = 58.582677170000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBRotaViagem."FERIAD"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 221.204724410000000000
          Width = 20.787401570000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataField = 'ESTADO'
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBRotaViagem."ESTADO"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Align = baWidth
          Left = 241.992125980000000000
          Width = 147.299537250000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataField = 'NOMCLI'
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBRotaViagem."NOMCLI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Align = baRight
          Left = 790.300037639291000000
          Width = 117.165354330708700000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBRotaViagem."NUMFAT"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Align = baRight
          Left = 907.465391969999700000
          Width = 98.267682360000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBRotaViagem."VENCTO"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Align = baRight
          Left = 1005.733074330000000000
          Width = 52.913383390000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataField = 'PESBRU'
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRotaViagem."PESBRU"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Align = baRight
          Left = 1058.646457720000000000
          Width = 15.118102910000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            ' [frxDBRotaViagem."QTDPAR"]X')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Align = baRight
          Left = 1141.418103940000000000
          Width = 30.236220470000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataField = 'NOTESP'
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBRotaViagem."NOTESP"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Align = baRight
          Left = 1073.764560630000000000
          Width = 67.653543310000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRotaViagem."VLRPAR"] ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Align = baRight
          Left = 1171.654324410000000000
          Width = 37.795275590000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBRotaViagem."CODVEN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllVlrTot: TfrxMemoView
          Align = baRight
          Left = 567.307918978582100000
          Width = 75.590543860000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'Memo37OnBeforePrint'
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRotaViagem."VLRTOT"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDetPalet: TfrxMemoView
          Left = 389.291663230000000000
          Width = 102.047236770000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxDBRotaViagem
          DataSetName = 'frxDBRotaViagem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBRotaViagem."PALET_"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 15.118110236220500000
        Top = 430.866420000000000000
        Width = 1209.449600000000000000
        object rllTotalImpresso: TfrxMemoView
          Align = baClient
          Width = 1209.449600000000000000
          Height = 15.118110236220500000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 94.488201180000000000
        Top = 18.897650000000000000
        Width = 1209.449600000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 206.324800000000000000
          Width = 796.800000000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 359.924799999999900000
          Top = 15.118110240000000000
          Width = 489.600000000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 1096.063773230000000000
          Width = 113.385826770000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Time: TfrxMemoView
          Align = baRight
          Left = 1133.859048820000000000
          Top = 15.118110240000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Date: TfrxMemoView
          Align = baRight
          Left = 1009.059048820000000000
          Top = 15.118110240000000000
          Width = 124.800000000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 292.875975000000000000
          Top = 30.236220470000000000
          Width = 623.697650000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Top = 60.472440940000000000
          Width = 585.902350000000000000
          Height = 30.236220470000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MOTORI]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Align = baRight
          Left = 623.547250000000000000
          Top = 60.472440940000000000
          Width = 585.902350000000000000
          Height = 30.236220470000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VEICUL]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Top = 211.653680000000000000
        Width = 1209.449600000000000000
        Condition = 'frxDBRotaViagem."NOMCID"'
        KeepChild = True
        KeepTogether = True
        Stretched = True
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 317.480520000000000000
        Width = 1209.449600000000000000
        AllowSplit = True
        object Memo32: TfrxMemoView
          Align = baClient
          Width = 1209.449600000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 491.338582677165400000
          Width = 71.811021180000000000
          Height = 15.118110240000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRotaViagem."VLRCON">,rlbDetalhes)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 642.520497878582300000
          Width = 30.236220470000000000
          Height = 15.118110240000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[SUM(<frxDBRotaViagem."VOLUME">,rlbDetalhes)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 173.858380000000000000
        Width = 1209.449600000000000000
        ReprintOnNewPage = True
        object Memo31: TfrxMemoView
          Align = baRight
          Left = -1171.654300000000000000
          Width = 1171.654300000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 30.236220470000000000
          Width = 132.283452360000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'CIDADE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 162.858267720000000000
          Width = 58.582677170000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'FERIADO')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoTitNumDoc: TfrxMemoView
          Align = baRight
          Left = 672.756718348582400000
          Width = 117.165354330708700000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'NOTA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 221.204724410000000000
          Width = 20.787401570000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'UF')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Align = baRight
          Left = 642.520497878582300000
          Width = 30.236220470000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VOL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Align = baWidth
          Left = 241.992125980000000000
          Width = 147.299537250000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Align = baRight
          Left = 491.339402837479900000
          Width = 75.590551181102360000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoTitNumFat: TfrxMemoView
          Align = baRight
          Left = 789.922072679291100000
          Width = 117.165354330708700000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'PEDIDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Align = baRight
          Left = 907.087427009999900000
          Width = 98.267682360000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'VENCIMENTOS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Align = baRight
          Left = 1005.355109370000000000
          Width = 52.913383390000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'PESO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Width = 30.236220470000000000
          Height = 15.118110236220500000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'SEQ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Align = baRight
          Left = 1058.268492760000000000
          Width = 83.149611180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR PARC')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Align = baRight
          Left = 1141.418103940000000000
          Width = 30.236220470000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ESP')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Align = baRight
          Left = 1171.654324410000000000
          Width = 37.795275590000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'REP')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Align = baRight
          Left = 566.929954018582300000
          Width = 75.590543860000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitPalet: TfrxMemoView
          Left = 389.291663230000000000
          Width = 102.047236770000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'PALET')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 355.275820000000000000
        Width = 1209.449600000000000000
        object Memo24: TfrxMemoView
          Left = 1005.355109370000000000
          Width = 52.913383390000000000
          Height = 15.118110240000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRotaViagem."PESBRU">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 491.338582677165400000
          Width = 71.811021180000000000
          Height = 15.118110240000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRotaViagem."VLRCON">,rlbDetalhes)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 351.496145980000000000
          Width = 136.062982360000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAIS ->')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 1058.268492760000000000
          Width = 83.149611180000000000
          Height = 15.118110240000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBRotaViagem."VLRPAR">*<frxDBRotaViagem."QTDPAR">,rlbDe' +
              'talhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Top = 234.330860000000000000
        Width = 1209.449600000000000000
        Condition = 'frxDBRotaViagem."NOMCLI"'
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 0.377952760000000000
        Top = 294.803340000000000000
        Width = 1209.449600000000000000
        object Memo35: TfrxMemoView
          Align = baWidth
          Width = 1209.449600000000000000
          Height = 0.377952755905512000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          ParentFont = False
        end
      end
    end
  end
  object frxReport1: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41947.418606979170000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;      '
      ''
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  if ( <frxDBItensCli."DET_NUMLOT"> <> '#39#39' ) then'
      '    frbLote.Visible := True'
      '  else'
      '    frbLote.Visible := False;    '
      'end;'
      ''
      
        'procedure frxDBItensCliGER_FONEOnAfterData(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  frxDBItensCliGER_FONE.Text := fFormataFoneInterna(frxDBItensCl' +
        'iGER_FONE.Text);  '
      'end;'
      ''
      'begin'
      '                                         '
      'end.')
    OnUserFunction = frxItensCliMUserFunction
    Left = 93
    Top = 16
    Datasets = <
      item
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckAnalitico: TfrxDMPPage
      PaperWidth = 335.279783465139800000
      PaperHeight = 143.933240376448900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 374.000000000000000000
        Width = 1248.000000000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        Child = frxReport1.frbLote
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
        RowCount = 0
        Stretched = True
        object frxDBItensCliDET_ITEM: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_ITEM'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItensCli."DET_ITEM"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDBItensCliDET_DESCRI: TfrxDMPMemoView
          Left = 288.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'DET_DESCRI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_DESCRI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_UNIDAD: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNIDAD"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDBItensCliMAR_DESMAR: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'MAR_DESMAR'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."MAR_DESMAR"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_QTDITE: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_QTDITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNITAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_TOTITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 799.000000000000000000
        Width = 1248.000000000000000000
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 796.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 384.000000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 19.200000000000000000
          Top = 51.000000000000000000
          Width = 1219.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 115.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object mmObs: TfrxDMPMemoView
          Align = baCenter
          Left = 19.200000000000000000
          Top = 68.000000000000000000
          Width = 1219.200000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[OBSERVACAO]')
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 136.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Child = frxReport1.ChildMsgExp
        Condition = 'frxDBItensCli."DOCQUEBRA"'
        KeepChild = True
        KeepTogether = True
        PrintChildIfInvisible = True
        StartNewPage = True
        Stretched = True
        object frxDBItensCliDET_NOMCLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_NOMCLI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NOMCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_CEPCLI: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CEP: [frxDBItensCli."GER_CEPCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_FONE: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 34.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'frxDBItensCliGER_FONEOnAfterData'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."GER_FONE"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_NOMCID: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 51.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CIDADE: [frxDBItensCli."GER_NOMCID"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_ENDCLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO: [frxDBItensCli."GER_ENDCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_BAICLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BAIRRO..: [frxDBItensCli."GER_BAICLI"]')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS1...: [frxDBItensCli."GER_MEN001"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS2...: [frxDBItensCli."GER_MEN002"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TELEFONE:')
          TruncOutboundText = False
        end
        object rllPalet: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 85.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PALET: [frxDBItensCli."GER_PALET_"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object frxDBItensCliGER_NUMDOC: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              '[frxDBItensCli."GER_NUMDOC"] [frxDBItensCli."GER_ESPDOC"] [frxDB' +
              'ItensCli."GER_CODEMP"]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 672.000000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              '[frxDBItensCli."GER_NUMFAT"] [frxDBItensCli."GER_TIPFAT"] [frxDB' +
              'ItensCli."GER_EMPFAT"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 442.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Child = frxReport1.childAssinatura
        object DMPMemo17: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.TOTAL:')
          TruncOutboundText = False
        end
        object rllTempTot: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_QTDITE">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine5: TfrxDMPLineView
          Left = 1128.000000000000000000
          Top = 8.500000000000000000
          Width = 115.200000000000000000
          Color = clBlack
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_TOTITE">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'FRETE:')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO:')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL ITEM:')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_TOTFRE">, rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_DESESP">, rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBItensCli."DET_TOTITE">,rlbDetalhes) + SUM(<frxDBItens' +
              'Cli."DET_TOTFRE">, rlbDetalhes) - SUM(<frxDBItensCli."DET_DESESP' +
              '">, rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          TruncOutboundText = False
        end
      end
      object ChildMsgExp: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 255.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Child = frxReport1.childTitulo
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            'MENS EXP: [frxDBItensCli."GER_MSGEXP"]')
          TruncOutboundText = False
        end
      end
      object childTitulo: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 289.000000000000000000
        Width = 1248.000000000000000000
        PrintChildIfInvisible = True
        object DMPMemo25: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR:')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CODIGO')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 34.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DESCRICAO / REFERENCIA / LOTE')
          TruncOutboundText = False
        end
        object mmoTitQtdIte: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MARCA')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 34.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR.UNIT')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR.TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object frbLote: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 408.000000000000000000
        Visible = False
        Width = 1248.000000000000000000
        object mmoLote: TfrxDMPMemoView
          Left = 288.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            'LOTE: [frxDBItensCli."DET_NUMLOT"]')
          TruncOutboundText = False
        end
      end
      object childAssinatura: TfrxChild
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 510.000000000000000000
        Width = 1248.000000000000000000
        object mmoMsgRod: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 1238.400000000000000000
          Height = 51.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'ASSUMO TOTAL RESPONSABILIDADE PELAS MERCADORIAS CORRESPONDENTES ' +
              'AS NFs RELACIONADAS NESTE '
            
              'ROMANEIO DE ENTREGA, COMO AINDA DECLARO CERTAS AS QUANTIDADES CA' +
              'RREGADAS EM MEU VEICULO.')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 556.799999999999900000
          Top = 51.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASS. CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASS.CONFERENTE')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'R.G. CLIENTE')
          TruncOutboundText = False
        end
      end
      object childMsgPer: TfrxChild
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 646.000000000000000000
        Width = 1248.000000000000000000
        object mmoMsgPer: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 1238.400000000000000000
          Height = 51.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '--------')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxDepCravinhos: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42257.599293634300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure DMPMemo23OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  DMPMemo23.Text := fFormataFoneInterna(DMPMemo23.Text);  '
      'end;'
      ''
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If GroupFooter1.Height > Engine.FreeSpace Then'
      '    Engine.NewPage;'
      '        '
      
        '  Engine.CurY := Engine.CurY + Engine.FreeSpace - GroupFooter1.H' +
        'eight - 100;    '
      'end;'
      ''
      'begin'
      '    '
      'end.')
    OnUserFunction = frxItensCliMUserFunction
    Left = 360
    Top = 16
    Datasets = <
      item
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckAnalitico: TfrxDMPPage
      PaperWidth = 345.439776903477400000
      PaperHeight = 161.924895423505000000
      PaperSize = 256
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 221.000000000000000000
        Width = 1305.600000000000000000
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
        RowCount = 0
        Stretched = True
        object frxDBItensCliDET_ITEM: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBItensCli."DET_CODITE"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_DESCRI: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_DESCRI"] - [frxDBItensCli."MAR_DESMAR"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_UNIDAD: TfrxDMPMemoView
          Left = 211.200000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDAD'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNIDAD"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_QTDITE: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBItensCli."DET_QTDITE"]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_ENTSAI"]')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1305.600000000000000000
        object DMPCommand2: TfrxDMPCommand
          Left = 19.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#80#18#27#80#15#27#80'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 124.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#36'
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 68.000000000000000000
        Width = 1305.600000000000000000
        Condition = 'frxDBItensCli."DOCQUEBRA"'
        KeepChild = True
        KeepTogether = True
        PrintChildIfInvisible = True
        StartNewPage = True
        object DMPMemo1: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 34.000000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_NOMCLI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NOMCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 51.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_ENDCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 68.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMCID"]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 68.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_CEPCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 51.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_BAICLI"]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 34.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_CODCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 102.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'DMPMemo23OnAfterData'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItensCli."GER_FONE"]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 85.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_RG_IES"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 85.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_CPFCGC"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_NUMDOC: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 34.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NUMDOC"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_ESPDOC: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 34.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          DataField = 'GER_ESPDOC'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_ESPDOC"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_CODEMP: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 34.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'GER_CODEMP'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_CODEMP"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 255.000000000000000000
        Width = 1305.600000000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object mmoMsgRod1: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 17.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              'ASSUMO TOTAL RESPONSABILIDADE PELAS MERCADORIAS RELACIONADAS NES' +
              'TE')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object mmoMsgRod2: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 34.000000000000000000
          Width = 547.200000000000100000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'ROMANEIO DE ENTREGA. OBRIGADO, DEPOSITO CRAVINHENSE!!')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 68.000000000000000000
          Width = 1123.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[Copy(<frxDBItensCli."GER_MSGPED">, 1, 118)]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxItensValoresCliJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41970.407851979200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;                      '
      ''
      
        'procedure frxDBItensCliGER_FONEOnAfterData(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  frxDBItensCliGER_FONE.Text := fFormataFoneInterna(frxDBItensCl' +
        'iGER_FONE.Text);                                                ' +
        '                                                                ' +
        '  '
      'end;'
      ''
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  if ( <frxDBItensCli."DET_NUMLOT"> <> '#39#39' ) then'
      '    frbLote.Visible := True            '
      '  else'
      '    frbLote.Visible := False;'
      
        '  rllMetragem.Text :=  fRetMetragemItem(<frxDBItensCli."DET_AUTI' +
        'NC">,'
      
        '                                        <frxDBItensCli."GER_ESPD' +
        'OC"> );'
      
        '  chdMedidas.Visible := rllMetragem.Text <> '#39#39';                 ' +
        '                                             '
      '        '
      'end;'
      ''
      'begin'
      '                                               '
      'end.')
    OnUserFunction = frxItensCliMUserFunction
    Left = 167
    Top = 72
    Datasets = <
      item
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckAnalitico: TfrxReportPage
      PaperWidth = 255.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 430.866420000000000000
        Width = 888.189550000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 888.189550000000000000
          Height = 18.897637800000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object frxDBItensCliDET_ITEM: TfrxMemoView
          Left = 9.600000000000000000
          Top = 0.948818899999992100
          Width = 60.472443390000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_ITEM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_DESCRI: TfrxMemoView
          Left = 72.107050000000000000
          Top = 0.948818899999992100
          Width = 442.204765910000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'DET_DESCRI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_DESCRI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_UNIDAD: TfrxMemoView
          Left = 624.133890000000000000
          Top = 0.948818899999992100
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDAD'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNIDAD"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliMAR_DESMAR: TfrxMemoView
          Left = 516.132220000000000000
          Top = 0.948818899999992100
          Width = 105.826766770000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'MAR_DESMAR'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_QTDITE: TfrxMemoView
          Left = 655.475510000000000000
          Top = 0.948818899999992100
          Width = 60.472423860000000000
          Height = 17.000000000000000000
          DataField = 'DET_QTDITE'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_QTDITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 718.110700000000000000
          Top = 1.133858270000019000
          Width = 79.370071420000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNITAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 800.260360000000000000
          Top = 1.133858270000019000
          Width = 86.929131420000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_TOTITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 771.024120000000000000
        Width = 888.189550000000000000
        object rllTotalImpresso: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 87.685039370000000000
        Top = 18.897650000000000000
        Width = 888.189550000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 136.894775000000000000
          Top = 17.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 199.294775000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 768.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 816.000000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 691.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 5.631695000000028000
          Top = 51.000000000000000000
          Width = 876.926160000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object mmObs: TfrxMemoView
          Align = baCenter
          Left = 5.631695000000036000
          Top = 69.811070000000000000
          Width = 876.926160000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[OBSERVACAO]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 124.724409450000000000
        Top = 166.299320000000000000
        Width = 888.189550000000000000
        AllowSplit = True
        Child = frxItensValoresCliJ.ChildMsgExp
        Condition = 'frxDBItensCli."DOCQUEBRA"'
        KeepChild = True
        KeepTogether = True
        PrintChildIfInvisible = True
        StartNewPage = True
        object frxDBItensCliDET_NOMCLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 420.661410000000000000
          Height = 17.000000000000000000
          DataField = 'DET_NOMCLI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NOMCLI"]')
        end
        object frxDBItensCliGER_CEPCLI: TfrxMemoView
          Left = 703.747990000000000000
          Top = 34.000000000000000000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CEP: [frxDBItensCli."GER_CEPCLI"]')
        end
        object frxDBItensCliGER_FONE: TfrxMemoView
          Left = 703.747990000000000000
          Top = 17.000000000000000000
          Width = 181.492950000000000000
          Height = 17.000000000000000000
          OnAfterData = 'frxDBItensCliGER_FONEOnAfterData'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."GER_FONE"]')
        end
        object frxDBItensCliGER_NOMCID: TfrxMemoView
          Left = 508.800000000000000000
          Top = 51.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CIDADE: [frxDBItensCli."GER_NOMCID"]')
        end
        object frxDBItensCliGER_ENDCLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 688.403030000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO: [frxDBItensCli."GER_ENDCLI"]')
        end
        object frxDBItensCliGER_BAICLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BAIRRO..: [frxDBItensCli."GER_BAICLI"]')
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 8.500000000000000000
          Width = 888.189550000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo9: TfrxMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 688.403030000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS1...: [frxDBItensCli."GER_MEN001"]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000090000
          Width = 688.403030000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS2...: [frxDBItensCli."GER_MEN002"]')
          WordWrap = False
        end
        object rllPalet: TfrxMemoView
          Left = 701.992580000000000000
          Top = 85.000000000000090000
          Width = 181.417366770000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PALET: [frxDBItensCli."GER_PALET_"]')
          WordWrap = False
        end
        object frxDBItensCliGER_NUMDOC: TfrxMemoView
          Left = 438.425480000000000000
          Top = 17.000000000000000000
          Width = 121.852010000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              '[frxDBItensCli."GER_NUMDOC"] [frxDBItensCli."GER_ESPDOC"] [frxDB' +
              'ItensCli."GER_CODEMP"]')
        end
        object Memo7: TfrxMemoView
          Left = 575.832160000000000000
          Top = 17.000000000000000000
          Width = 121.852010000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              '[frxDBItensCli."GER_NUMFAT"] [frxDBItensCli."GER_TIPFAT"] [frxDB' +
              'ItensCli."GER_EMPFAT"]')
        end
        object Memo20: TfrxMemoView
          Left = 9.600000000000000000
          Top = 103.047310000000200000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              'FORMA DE PAGTO...: [frxDBItensCli."GER_CODFPG"] - [frxDBItensCli' +
              '."FPG_DESCRI"] / COND. PAGTO.: [frxDBItensCli."CND_DESCRI"] - [f' +
              'rxDBItensCli."GER_CODCND"]'
            '')
          WordWrap = False
          Formats = <
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
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 56.692913390000000000
        Top = 570.709030000000000000
        Width = 888.189550000000000000
        Child = frxItensValoresCliJ.childAssinatura
        object Memo17: TfrxMemoView
          Left = 323.661410000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
        end
        object rllTempTot: TfrxMemoView
          Left = 595.003030000000000000
          Top = 17.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_QTDITE">,rlbDetalhes)]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 883.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo15: TfrxMemoView
          Left = 684.094930000000000000
          Top = 16.897650000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_UNITAR">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 777.583180000000000000
          Top = 16.897650000000000000
          Width = 109.606311420000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_TOTITE">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 323.661410000000000000
          Top = 37.795300000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOCUMENTO:')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 596.165737560000000000
          Top = 37.795300000000000000
          Width = 291.023753860000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."GER_TOTMER"]')
          ParentFont = False
        end
      end
      object ChildMsgExp: TfrxChild
        FillType = ftBrush
        Height = 18.897635350000000000
        Top = 313.700990000000000000
        Width = 888.189550000000000000
        AllowSplit = True
        Child = frxItensValoresCliJ.ChildTitulo
        PrintChildIfInvisible = True
        Stretched = True
        object Memo22: TfrxMemoView
          Left = 10.000000000000000000
          Width = 873.071430000000000000
          Height = 15.118105350000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS EXP.: [frxDBItensCli."GER_MSGEXP"]')
        end
      end
      object frbLote: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 472.441250000000000000
        Width = 888.189550000000000000
        PrintChildIfInvisible = True
        object mmoLote: TfrxMemoView
          Left = 124.724490000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOTE: [frxDBItensCli."DET_NUMLOT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object childAssinatura: TfrxChild
        FillType = ftBrush
        Height = 60.472480000000000000
        Top = 650.079160000000000000
        Width = 888.189550000000000000
        object mmoMsgRod: TfrxMemoView
          Left = 6.338590000000000000
          Top = 3.779530000000022000
          Width = 605.253680000000000000
          Height = 45.354330710000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'FAVOR CONFERIR  OS PRODUTOS ENTREGUES.'
            'NAO ACEITAREMOS RECLAMACOES POSTERIORES.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 624.933735000000000000
          Top = 32.779530000000030000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA')
        end
      end
      object chdMedidas: TfrxChild
        FillType = ftBrush
        Height = 33.236240000000000000
        Top = 514.016080000000000000
        Width = 888.189550000000000000
        object rllMetragem: TfrxMemoView
          Left = 15.118120000000000000
          Top = 3.000000000000114000
          Width = 869.291900000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object ChildTitulo: TfrxChild
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 355.275820000000000000
        Width = 888.189550000000000000
        PrintChildIfInvisible = True
        object Shape1: TfrxShapeView
          Left = 0.779530000000000000
          Top = 29.236240000000010000
          Width = 888.189550000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 10.159060000000000000
          Top = 31.952690000000020000
          Width = 56.692913385826800000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 72.666110000000000000
          Top = 31.952690000000020000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRICAO / REFERENCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 655.475510000000000000
          Top = 31.952690000000020000
          Width = 60.472423860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 516.691280000000000000
          Top = 31.952690000000020000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 624.692950000000000000
          Top = 31.952690000000020000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 105.600000000000000000
          Top = 0.732219999999983900
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMVEN"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 9.600000000000000000
          Top = 0.732219999999983900
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENDEDOR:')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 718.110700000000000000
          Top = 31.952690000000020000
          Width = 79.370071420000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL.UNIT')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 800.260360000000000000
          Top = 31.236240000000010000
          Width = 86.929131420000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL.TOT.ITEM')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxItensValoresCliM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42597.382756643520000000
    ReportOptions.LastChange = 42597.382756643520000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;           '
      ''
      
        'procedure frxDBItensCliGER_FONEOnAfterData(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  frxDBItensCliGER_FONE.Text := fFormataFoneInterna(frxDBItensCl' +
        'iGER_FONE.Text);                                                ' +
        '                                                                ' +
        '  '
      'end;'
      ''
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  if ( <frxDBItensCli."DET_NUMLOT"> <> '#39#39' ) then'
      '    frbLote.Visible := True'
      '  else'
      '    frbLote.Visible := False;'
      
        '  rllMetragem.Text :=  fRetMetragemItem(<frxDBItensCli."DET_AUTI' +
        'NC">,'
      
        '                                        <frxDBItensCli."GER_ESPD' +
        'OC"> );'
      '  chdMedidas.Visible := rllMetragem.Text <> '#39#39';        '
      'end;'
      ''
      'begin'
      '                                             '
      'end.')
    OnUserFunction = frxItensCliMUserFunction
    Left = 264
    Top = 128
    Datasets = <
      item
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckAnalitico: TfrxDMPPage
      PaperWidth = 335.279783465139800000
      PaperHeight = 247.385256897021600000
      PaperSize = 256
      FontStyle = []
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 391.000000000000000000
        Width = 1267.200000000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
        RowCount = 0
        Stretched = True
        object frxDBItensCliDET_ITEM: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_ITEM'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_ITEM"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_DESCRI: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_DESCRI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_UNIDAD: TfrxDMPMemoView
          Left = 912.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDAD'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNIDAD"]')
          TruncOutboundText = False
        end
        object frxDBItensCliMAR_DESMAR: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'MAR_DESMAR'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."MAR_DESMAR"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_QTDITE: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_QTDITE"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNITAR"]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_TOTITE"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 765.000000000000000000
        Width = 1267.200000000000000000
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1267.200000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 17.000000000000000000
          Width = 796.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 384.000000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 19.200000000000000000
          Top = 51.000000000000000000
          Width = 1219.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 115.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object mmObs: TfrxDMPMemoView
          Align = baCenter
          Left = 19.200000000000000000
          Top = 68.000000000000000000
          Width = 1219.200000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[OBSERVACAO]')
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 136.000000000000000000
        Width = 1267.200000000000000000
        AllowSplit = True
        Child = frxItensValoresCliM.ChildMsgExp
        Condition = 'frxDBItensCli."DOCQUEBRA"'
        KeepChild = True
        KeepTogether = True
        PrintChildIfInvisible = True
        StartNewPage = True
        Stretched = True
        object frxDBItensCliDET_NOMCLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_NOMCLI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NOMCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_CEPCLI: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CEP: [frxDBItensCli."GER_CEPCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_FONE: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 34.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'frxDBItensCliGER_FONEOnAfterData'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."GER_FONE"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_NOMCID: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 51.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CIDADE: [frxDBItensCli."GER_NOMCID"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_ENDCLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO: [frxDBItensCli."GER_ENDCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_BAICLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BAIRRO..: [frxDBItensCli."GER_BAICLI"]')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1257.600000000000000000
          Color = clBlack
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS1...: [frxDBItensCli."GER_MEN001"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS2...: [frxDBItensCli."GER_MEN002"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TELEFONE:')
          TruncOutboundText = False
        end
        object rllPalet: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 85.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PALET: [frxDBItensCli."GER_PALET_"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object frxDBItensCliGER_NUMDOC: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              '[frxDBItensCli."GER_NUMDOC"] [frxDBItensCli."GER_ESPDOC"] [frxDB' +
              'ItensCli."GER_CODEMP"]')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 681.600000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              '[frxDBItensCli."GER_NUMFAT"] [frxDBItensCli."GER_TIPFAT"] [frxDB' +
              'ItensCli."GER_EMPFAT"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              'FORMA DE PAGTO...: [frxDBItensCli."GER_CODFPG"] - [frxDBItensCli' +
              '."FPG_DESCRI"] / COND. PAGTO.: [frxDBItensCli."CND_DESCRI"] - [f' +
              'rxDBItensCli."GER_CODCND"]')
          WordWrap = False
          TruncOutboundText = False
          Formats = <
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
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 510.000000000000000000
        Width = 1267.200000000000000000
        AllowSplit = True
        Child = frxItensValoresCliM.childAssinatura
        object DMPMemo17: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          TruncOutboundText = False
        end
        object rllTempTot: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_QTDITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1257.600000000000000000
          Color = clBlack
        end
        object DMPLine5: TfrxDMPLineView
          Left = 859.199999999999900000
          Top = 8.500000000000000000
          Width = 384.000000000000000000
          Color = clBlack
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_UNITAR">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_TOTITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 34.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOCUMENTO:')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 34.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."GER_TOTMER"]')
          TruncOutboundText = False
        end
      end
      object childTitulo: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 306.000000000000000000
        Width = 1267.200000000000000000
        PrintChildIfInvisible = True
        object DMPMemo25: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR:')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1257.600000000000000000
          Color = clBlack
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 34.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DESCRICAO / REFERENCIA / LOTE')
          TruncOutboundText = False
        end
        object mmoTitQtdIte: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MARCA')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 34.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1257.600000000000000000
          Color = clBlack
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VL.UNIT')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VL.TOT.ITEM')
          TruncOutboundText = False
        end
      end
      object frbLote: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 425.000000000000000000
        Width = 1267.200000000000000000
        object DMPMemo7: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            'LOTE: [frxDBItensCli."DET_NUMLOT"]')
          TruncOutboundText = False
        end
      end
      object childAssinatura: TfrxChild
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 612.000000000000000000
        Width = 1267.200000000000000000
        object mmoMsgRod: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 1238.400000000000000000
          Height = 51.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'ASSUMO TOTAL RESPONSABILIDADE PELAS MERCADORIAS CORRESPONDENTES ' +
              'AS NFs RELACIONADAS NESTE '
            
              'ROMANEIO DE ENTREGA, COMO AINDA DECLARO CERTAS AS QUANTIDADES CA' +
              'RREGADAS EM MEU VEICULO.')
          TruncOutboundText = False
        end
      end
      object chdMedidas: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 459.000000000000000000
        Width = 1267.200000000000000000
        object rllMetragem: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1008.000000000000000000
          Height = 34.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          TruncOutboundText = False
        end
      end
      object ChildMsgExp: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.000000000000000000
        Width = 1267.200000000000000000
        AllowSplit = True
        Child = frxItensValoresCliM.childTitulo
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            'MENS EXP: [frxDBItensCli."GER_MSGEXP"]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxItensEntMenExpM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43125.691488344920000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '      '
      ''
      
        'procedure frxDBItensCliGER_FONEOnAfterData(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  frxDBItensCliGER_FONE.Text := fFormataFoneInterna(frxDBItensCl' +
        'iGER_FONE.Text);                                                ' +
        '                                                                ' +
        '  '
      'end;'
      ''
      'begin'
      '    '
      'end.')
    OnUserFunction = frxItensCliMUserFunction
    Left = 264
    Top = 189
    Datasets = <
      item
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckAnalitico: TfrxDMPPage
      PaperWidth = 335.279783465139800000
      PaperHeight = 143.933240376448900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
        RowCount = 0
        Stretched = True
        object frxDBItensCliDET_ITEM: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_ITEM"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_DESCRI: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            
              '[IIF(<frxDBItensCli."DET_NUMLOT"> = '#39#39', <frxDBItensCli."DET_DESC' +
              'RI">, '
            
              '           <frxDBItensCli."DET_NUMLOT"> + '#39' / '#39' + <frxDBItensCli' +
              '."DET_DESCRI">)]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_UNIDAD: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDAD'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNIDAD"]')
          TruncOutboundText = False
        end
        object frxDBItensCliMAR_DESMAR: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'MAR_DESMAR'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."MAR_DESMAR"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_QTDITE: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_QTDITE"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_NUMDOC: TfrxDMPMemoView
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NUMDOC"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_ESPDOC: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          DataField = 'GER_ESPDOC'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_ESPDOC"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_CODEMP: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'GER_CODEMP'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."GER_CODEMP"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 612.000000000000000000
        Width = 1248.000000000000000000
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 796.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 384.000000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 326.400000000000000000
          Top = 51.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 115.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object mmObs: TfrxDMPMemoView
          Align = baCenter
          Left = 326.400000000000000000
          Top = 68.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[OBSERVACAO]')
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 136.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Condition = 'frxDBItensCli."DOCQUEBRA"'
        KeepChild = True
        KeepTogether = True
        PrintChildIfInvisible = True
        StartNewPage = True
        Stretched = True
        object frxDBItensCliDET_NOMCLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_NOMCLI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NOMCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_FONE: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 34.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'frxDBItensCliGER_FONEOnAfterData'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItensCli."GER_FONE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDBItensCliGER_NOMCID: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 68.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CIDADE: [frxDBItensCli."GER_NOMCID"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_ENDCLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO: [frxDBItensCli."GER_ENDCLI"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_BAICLI: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BAIRRO..: [frxDBItensCli."GER_BAICLI"]')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FANTASIA: [frxDBItensCli."DET_FANSOB"]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TELEFONE:')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            'MENSAGEM: [frxDBItensCli."GER_MENSAG"]')
          TruncOutboundText = False
        end
        object frxDBItensCliGER_CEPCLI: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CEP: [frxDBItensCli."GER_CEPCLI"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 425.000000000000000000
        Width = 1248.000000000000000000
        object DMPMemo17: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS')
          TruncOutboundText = False
        end
        object rllTempTot: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_QTDITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object childTitulo: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 255.000000000000000000
        Width = 1248.000000000000000000
        PrintChildIfInvisible = True
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 34.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOTE / DESCRICAO / REFERENCIA')
          TruncOutboundText = False
        end
        object mmoTitQtdIte: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MARCA')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 34.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR:')
          TruncOutboundText = False
        end
      end
      object childAssinatura: TfrxChild
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 459.000000000000000000
        Width = 1248.000000000000000000
        object mmoMsgRod: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 1238.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'ASSUMO TOTAL RESPONSABILIDADE PELAS MERCADORIAS CORRESPONDENTES ' +
              'AS NFs RELACIONADAS NESTE '
            
              'ROMANEIO DE ENTREGA, COMO AINDA DECLARO CERTAS AS QUANTIDADES CA' +
              'RREGADAS EM MEU VEICULO.')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 556.799999999999900000
          Top = 51.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASS. CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASS.CONFERENTE')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'R.G. CLIENTE')
          TruncOutboundText = False
        end
      end
      object grhNUMDOC: TfrxGroupHeader
        FillType = ftBrush
        Top = 340.000000000000000000
        Width = 1248.000000000000000000
        Condition = 'frxDBItensCli."GER_NUMDOC"'
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 391.000000000000000000
        Width = 1248.000000000000000000
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 921.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'MENS EXP: [frxDBItensCli."GER_MSGEXP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR:')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxItensEntMenExpJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40856.595015729170000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '      '
      ''
      
        'procedure frxDBItensCliGER_FONEOnAfterData(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  frxDBItensCliGER_FONE.Text := fFormataFoneInterna(frxDBItensCl' +
        'iGER_FONE.Text);                                                ' +
        '                                                                ' +
        '  '
      'end;'
      ''
      'begin'
      '    '
      'end.')
    OnUserFunction = frxItensCliMUserFunction
    Left = 192
    Top = 205
    Datasets = <
      item
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckAnalitico: TfrxReportPage
      PaperWidth = 255.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897637800000000000
        ParentFont = False
        Top = 400.630180000000000000
        Width = 888.189550000000000000
        DataSet = frxDBItensCli
        DataSetName = 'frxDBItensCli'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 888.189550000000000000
          Height = 18.897637800000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object frxDBItensCliDET_ITEM: TfrxMemoView
          Left = 164.409448818897700000
          Top = 0.948818899999992100
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          DataField = 'DET_ITEM'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_ITEM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_DESCRI: TfrxMemoView
          Left = 351.496062992126000000
          Top = 0.948818899999992100
          Width = 258.519685039370100000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'DET_DESCRI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_DESCRI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_UNIDAD: TfrxMemoView
          Left = 764.976377950000000000
          Top = 0.948818899999992100
          Width = 25.020470000000000000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDAD'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_UNIDAD"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliMAR_DESMAR: TfrxMemoView
          Left = 614.400000000000000000
          Top = 0.948818899999992100
          Width = 144.302350000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataField = 'MAR_DESMAR'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliDET_QTDITE: TfrxMemoView
          Left = 794.759060000000000000
          Top = 0.948818899999992100
          Width = 90.481880000000000000
          Height = 17.000000000000000000
          DataField = 'DET_QTDITE'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."DET_QTDITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBItensCliGER_NUMDOC: TfrxMemoView
          Left = 1.435930000000000000
          Top = 0.948818899999992100
          Width = 148.308720000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxDBItensCli."GER_NUMDOC"] [frxDBItensCli."GER_ESPDOC"] [frxDB' +
              'ItensCli."GER_CODEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo14: TfrxMemoView
          Left = 260.787401574803100000
          Top = 0.948818899999992100
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NUMLOT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 680.315400000000000000
        Width = 888.189550000000000000
        object rllTotalImpresso: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 87.685039370000000000
        Top = 18.897650000000000000
        Width = 888.189550000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 136.894775000000000000
          Top = 17.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 199.294775000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 768.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 816.000000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 691.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 141.694775000000000000
          Top = 51.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object mmObs: TfrxMemoView
          Align = baCenter
          Left = 141.694775000000000000
          Top = 69.811070000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[OBSERVACAO]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 111.496062990000000000
        Top = 166.299320000000000000
        Width = 888.189550000000000000
        AllowSplit = True
        Condition = 'frxDBItensCli."DOCQUEBRA"'
        KeepChild = True
        KeepTogether = True
        PrintChildIfInvisible = True
        StartNewPage = True
        Stretched = True
        object frxDBItensCliDET_NOMCLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_NOMCLI'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          Memo.UTF8W = (
            '[frxDBItensCli."DET_NOMCLI"]')
        end
        object frxDBItensCliGER_CEPCLI: TfrxMemoView
          Left = 589.984230000000000000
          Top = 17.000000000000000000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CEP: [frxDBItensCli."GER_CEPCLI"]')
        end
        object frxDBItensCliGER_FONE: TfrxMemoView
          Left = 703.747990000000000000
          Top = 17.000000000000000000
          Width = 181.492950000000000000
          Height = 17.000000000000000000
          OnAfterData = 'frxDBItensCliGER_FONEOnAfterData'
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItensCli."GER_FONE"]')
        end
        object frxDBItensCliGER_NOMCID: TfrxMemoView
          Left = 508.800000000000000000
          Top = 73.677179999999990000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CIDADE: [frxDBItensCli."GER_NOMCID"]')
        end
        object frxDBItensCliGER_ENDCLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 56.677179999999990000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO: [frxDBItensCli."GER_ENDCLI"]')
        end
        object frxDBItensCliGER_BAICLI: TfrxMemoView
          Left = 9.600000000000000000
          Top = 73.677179999999990000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BAIRRO..: [frxDBItensCli."GER_BAICLI"]')
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 8.500000000000000000
          Width = 888.189550000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo10: TfrxMemoView
          Left = 9.559060000000000000
          Top = 37.795300000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FANTASIA: [frxDBItensCli."DET_FANSOB"]')
        end
        object Memo15: TfrxMemoView
          Left = 11.338590000000000000
          Top = 92.708719999999950000
          Width = 873.071430000000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENSAGEM: [frxDBItensCli."GER_MENSAG"]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 39.629870000000000000
        Top = 487.559370000000000000
        Width = 888.189550000000000000
        Child = frxItensEntMenExpJ.childAssinatura
        object Memo17: TfrxMemoView
          Left = 508.800000000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS')
          ParentFont = False
        end
        object rllTempTot: TfrxMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBItensCli."DET_QTDITE">,rlbDetalhes)]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 883.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildTitulo: TfrxChild
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 302.362400000000000000
        Width = 888.189550000000000000
        PrintChildIfInvisible = True
        object Shape1: TfrxShapeView
          Left = 0.220470000000000000
          Top = 30.236240000000010000
          Width = 888.189550000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 164.409448818897700000
          Top = 32.846475000000000000
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 351.496062992126000000
          Top = 32.846475000000000000
          Width = 258.519685039370100000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRICAO / REFERENCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 794.759060000000000000
          Top = 32.846475000000000000
          Width = 90.481880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 614.400000000000000000
          Top = 32.846475000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 764.976500000000000000
          Top = 32.846475000000000000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 105.600000000000000000
          Top = 1.732219999999984000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMVEN"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 9.600000000000000000
          Top = 1.732219999999984000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENDEDOR:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 1.000000000000000000
          Top = 32.846475000000000000
          Width = 90.481880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 260.787401574803100000
          Top = 32.846475000000000000
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOTE')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object childAssinatura: TfrxChild
        FillType = ftBrush
        Height = 68.031540000000010000
        Top = 551.811380000000000000
        Width = 888.189550000000000000
        object mmoMsgRod: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118119999999980000
          Width = 605.253680000000000000
          Height = 45.354330710000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'FAVOR CONFERIR  OS PRODUTOS ENTREGUES.'
            'NAO ACEITAREMOS RECLAMACOES POSTERIORES.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 622.374675000000000000
          Top = 42.118119999999970000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA')
        end
      end
      object grhNUMDOC: TfrxGroupHeader
        FillType = ftBrush
        Height = 0.677180000000000000
        Top = 377.953000000000000000
        Width = 888.189550000000000000
        Condition = 'frxDBItensCli."GER_NUMDOC"'
      end
      object grfNUMDOC: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 442.205010000000000000
        Width = 888.189550000000000000
        object Line1: TfrxLineView
          Left = 5.000000000000000000
          Top = 20.117810000000020000
          Width = 883.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo9: TfrxMemoView
          Left = 5.000000000000000000
          Top = 1.117810000000020000
          Width = 570.071430000000000000
          Height = 15.118105350000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS EXP.: [frxDBItensCli."GER_MSGEXP"]')
        end
        object Memo16: TfrxMemoView
          Left = 677.000000000000000000
          Top = 2.133858270000019000
          Width = 204.976377950000000000
          Height = 17.000000000000000000
          DataSet = frxDBItensCli
          DataSetName = 'frxDBItensCli'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItensCli."GER_NOMVEN"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 582.000000000000000000
          Top = 1.133858267716562000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENDEDOR:')
          ParentFont = False
        end
      end
    end
  end
  object frxRotaRomaneioJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45383.701656967600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '    blnExibeFrete : Boolean;'
      ''
      'procedure mmoNomeRelatorioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '    if (<PREVIA> = '#39'S'#39') and (Pos('#39'PREVIA DE ROMANEIO'#39', mmoNomeRe' +
        'latorio.Text) <= 0) then'
      
        '        mmoNomeRelatorio.Text := '#39'ROTA DE ROMANEIO - PREVIA DE R' +
        'OMANEIO'#39';'
      ''
      'end;'
      ''
      'procedure mmoPRMDescriOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    if <frxRelatorio."DET_NUMLOT"> <> '#39#39' then'
      
        '        mmoPRMDescri.Text := mmoPRMDescri.Text + '#39'LOTE: '#39' + <frx' +
        'Relatorio."DET_NUMLOT">;'
      'end;'
      ''
      'procedure mmoDRMCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '    if (not blnExibeFrete) and (<frxGenDoc."GER_FRETE_"> <> 0) t' +
        'hen'
      '        blnExibeFrete := True;'
      'end;'
      ''
      
        'procedure mmoDRMConidcaoPagamentoOnBeforePrint(Sender: TfrxCompo' +
        'nent);'
      'begin'
      
        '    mmoDRMConidcaoPagamento.Text := fFormataCondPag(<frxGenDoc."' +
        'GER_CONPAG">) + '#39'  -  '#39' + <frxGenDoc."CND_DESCRI">;'
      'end;'
      ''
      'procedure mmoFPFFreteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    if not blnExibeFrete then'
      '    begin'
      '        mmoFPFFrete.Visible := False;'
      '        mmoFPFValFrete.Visible := False;'
      '        mmoFPFPFrete.Visible := False;'
      '        mmoFPFPerFrete.Visible := False;'
      ''
      '        FooterFormasPagamento.Height := 26.45;'
      '        mmoFPFLinha.Top := 22.67;'
      '    end;'
      'end;'
      ''
      'procedure mmoCCMMetragemOnBeforePrint(Sender: TfrxComponent);'
      'var'
      '    strMetragem : String;'
      'begin'
      '    strMetragem := '#39#39';'
      '    If <VENMAD> = '#39'S'#39' Then'
      
        '        strMetragem := fRetMetragemItem(<frxCarCar."DET_AUTINC">' +
        ',<frxCarCar."GER_ESPDOC">);'
      ''
      '  If strMetragem = '#39#39' Then'
      '  Begin'
      '      MasterDataCarregamentoCarga.Height := 16;'
      '      mmoCCMMetragem.Visible := False;'
      '  End'
      '  Else'
      '  Begin'
      '      MasterDataCarregamentoCarga.Height := 30;'
      '      mmoCCMMetragem.Text := strMetragem;'
      '      mmoCCMMetragem.Visible := True;'
      '  End;'
      'end;'
      ''
      ''
      ''
      'begin'
      '    blnExibeFrete := False;'
      ''
      '    HeaderProdutosRota.Visible := False;'
      '    MasterDataProdutos.Visible := False;'
      '    FooterProdutosRota.Visible := False;'
      ''
      '    HeaderEmbalagem.Visible := False;'
      '    MasterDataEmabalgem.Visible := False;'
      ''
      '    MasterDataDocumentosRota.Height := 109.60629921;'
      ''
      '    mmoDRMAssinatura.Left := 3.77953;'
      '    mmoDRMDocumento.Left := 340.1577;'
      '    mmoDRMDataHora.Left := 597.16574;'
      ''
      '    mmoDRMAssinatura.Top := 94.48825;'
      '    mmoDRMDocumento.Top := 94.48825;'
      '    mmoDRMDataHora.Top := 94.48825;'
      ''
      '    mmoDRMAssinatura.Width := 291.02381;'
      '    mmoDRMDocumento.Width := 211.65368;'
      '    mmoDRMDataHora.Width := 143.62214;'
      ''
      '    HeaderDocumentosRota.Visible := False;'
      '    MasterDataDocumentosRota.Visible := False;'
      '    FooterDocumentosRota.Visible := False;'
      ''
      '    HeaderTotalEspecie.Visible := False;'
      '    MasterDataTotalEspecie.Visible := False;'
      ''
      '    HeaderFormasPagamento.Visible := False;'
      '    MasterDataFormasPagamento.Visible := False;'
      '    FooterFormasPagamento.Visible := False;'
      ''
      '    HeaderCarregamentoCarga.Visible := False;'
      '    GroupHeaderCarregamentoCarga.Visible := False;'
      '    MasterDataCarregamentoCarga.Visible := False;'
      ''
      '    HeaderInfoIntens.Visible := False;'
      '    MasterDataInfoItens.Visible := False;'
      ''
      
        '    qckPagina.Visible := False;                                 ' +
        '                                                           '
      '    qckItemCliente.Visible := False;'
      ''
      '    mmoPRHMarca.Visible := False;'
      '    mmoPRHQuantidade.Visible := False;'
      '    mmoPRHVolume.Visible := False;'
      '    mmoPRHPesoBruto.Visible := False;'
      '    mmoPRHSaldos.Visible := False;'
      '    mmoPRMMarca.Visible := False;'
      '    mmoPRMQuantidade.Visible := False;'
      '    mmoPRMVolume.Visible := False;'
      '    mmoPRMPesoBruto.Visible := False;'
      '    mmoPRFPesoBruto.Visible := False;'
      '    mmoPRMSaldos.Visible := False;'
      '    mmoPRFQuantidade.Visible := False;'
      '    mmoPRFVolume.Visible := False;'
      '    mmoEHQuantidade.Visible := False;'
      '    mmoEHVolume.Visible := False;'
      '    mmoDRHPalet.Visible := False;'
      '    mmoDRMPalet.Visible := False;'
      '    mmoICHQuantidade.Visible := False;'
      '    mmoICHVolume.Visible := False;'
      '    mmoICMQuantidade.Visible := False;'
      '    mmoICMVolume.Visible := False;'
      '    mmoICFQuantidade.Visible := False;'
      '    mmoICFVolume.Visible := False;'
      '    mmoSUKMInicialFinal.Visible := False;'
      '    mmoFSICQuantidade.Visible := False;'
      '    mmoFSICVolume.Visible := False;'
      ''
      '    if <BLN_PRODUTOS> = '#39'S'#39' then'
      '    begin'
      '        qckPagina.Visible := True;'
      '        HeaderProdutosRota.Visible := True;'
      '        MasterDataProdutos.Visible := True;'
      '        FooterProdutosRota.Visible := True;'
      '    end;'
      ''
      '    if <BLN_EMBALAGENS> = '#39'S'#39' then'
      '    begin'
      '        qckPagina.Visible := True;'
      '        HeaderEmbalagem.Visible := True;'
      '        MasterDataEmabalgem.Visible := True;'
      '    end;'
      ''
      '    if <BLN_DOCUMENTOS> = '#39'S'#39' then'
      '    begin'
      '        qckPagina.Visible := True;'
      '        HeaderDocumentosRota.Visible := True;'
      '        MasterDataDocumentosRota.Visible := True;'
      '        FooterDocumentosRota.Visible := True;'
      '    end;'
      ''
      '    if <BLN_TOTESPDOC> = '#39'S'#39' then'
      '    begin'
      '        qckPagina.Visible := True;'
      '        HeaderTotalEspecie.Visible := True;'
      '        MasterDataTotalEspecie.Visible := True;'
      '    end;'
      ''
      '    if <BLN_FORMAS> = '#39'S'#39' then'
      '    begin'
      '        qckPagina.Visible := True;'
      '        HeaderFormasPagamento.Visible := True;'
      '        MasterDataFormasPagamento.Visible := True;'
      '        FooterFormasPagamento.Visible := True;'
      '    end;'
      ''
      '    if <BLN_INFITE> = '#39'S'#39' then'
      '    begin'
      '        qckPagina.Visible := True;'
      '        HeaderInfoIntens.Visible := True;'
      '        MasterDataInfoItens.Visible := True;'
      '    end;'
      ''
      '    if <BLN_CARCAR> = '#39'S'#39' then'
      '    begin'
      '        qckPagina.Visible := True;'
      '        HeaderCarregamentoCarga.Visible := True;'
      '        GroupHeaderCarregamentoCarga.Visible := True;'
      '        MasterDataCarregamentoCarga.Visible := True;'
      '    end;'
      ''
      '    if <BLN_ITEMCL> = '#39'S'#39' then'
      '        qckItemCliente.Visible := True;'
      ''
      '    if <BLN_LOCASS> = '#39'N'#39' then'
      '    begin'
      '        mmoDRMAssinatura.Visible := False;'
      '        mmoDRMDocumento.Visible := False;'
      '        mmoDRMDataHora.Visible := False;'
      ''
      '        mmoDRMAssinatura.Left := 0;'
      '        mmoDRMDocumento.Left := 0;'
      '        mmoDRMDataHora.Left := 0;'
      ''
      '        mmoDRMAssinatura.Top := 0;'
      '        mmoDRMDocumento.Top := 0;'
      '        mmoDRMDataHora.Top := 0;'
      ''
      '        mmoDRMAssinatura.Width := 0;'
      '        mmoDRMDocumento.Width := 0;'
      '        mmoDRMDataHora.Width := 0;'
      ''
      '        MasterDataDocumentosRota.Height := 75.60;'
      ''
      '        mmoSUConferente.Visible := False;'
      '        mmoSUDataHora1.Visible := False;'
      '        mmoSUMotorista.Visible := False;'
      '        mmoSURGMotorista.Visible := False;'
      '        mmoSUDataHora2.Visible := False;'
      '        mmoSURodapeFinal.Visible := False;'
      ''
      '        mmoSUKMInicialFinal.Top := 45.35;'
      ''
      '        mmoSUICConferente.Visible := False;'
      '        mmoSUICDataHora1.Visible := False;'
      '        mmoSUICMotorista.Visible := False;'
      '        mmoSUICRGMotorista.Visible := False;'
      '        mmoSUICDataHora2.Visible := False;'
      '        mmoSUICRodapeFinal.Visible := False;'
      ''
      '        GroupFooterItensCliente.Height := 18.89'
      '    end;'
      ''
      '    if <BLN_IMP_KM> = '#39'S'#39' then'
      '       mmoSUKMInicialFinal.Visible := True;'
      ''
      '    if <BLN_MOSMAR> = '#39'S'#39' then'
      '    begin'
      '        mmoPRHMarca.Visible := True;'
      '        mmoPRMMarca.Visible := True;'
      '    end'
      '    else'
      '    begin'
      '        mmoPRHPesoBruto.Visible := True;'
      '        mmoPRMPesoBruto.Visible := True;'
      '        mmoPRFPesoBruto.Visible := True;'
      ''
      '        if <SALROM> = '#39'S'#39' then'
      '        begin'
      '            mmoPRHSaldos.Visible := True;'
      '            mmoPRMSaldos.Visible := True;'
      '        end;'
      '    end;'
      ''
      '    if <IMP_PRODUTOS> = '#39'Q'#39' then'
      '    begin'
      '        mmoPRHQuantidade.Visible := True;'
      '        mmoPRMQuantidade.Visible := True;'
      '        mmoPRFQuantidade.Visible := True;'
      '    end'
      '    else if <IMP_PRODUTOS> = '#39'V'#39' then'
      '    begin'
      '        mmoPRHVolume.Visible := True;'
      '        mmoPRMVolume.Visible := True;'
      '        mmoPRFVolume.Visible := True;'
      '    end;'
      ''
      '    if <IMP_EMBALAGENS> = '#39'Q'#39' then'
      '        mmoEHQuantidade.Visible := True'
      '    else if <IMP_EMBALAGENS> = '#39'V'#39' then'
      '        mmoEHVolume.Visible := True;'
      ''
      '    if <IMP_ITEMCL> = '#39'Q'#39' then'
      '    begin'
      '        mmoICHQuantidade.Visible := True;'
      '        mmoICMQuantidade.Visible := True;'
      '        mmoICFQuantidade.Visible := True;'
      '        mmoFSICQuantidade.Visible := True;'
      '    end'
      '    else if <IMP_ITEMCL> = '#39'V'#39' then'
      '    begin'
      '        mmoICHVolume.Visible := True;'
      '        mmoICMVolume.Visible := True;'
      '        mmoICFVolume.Visible := True;'
      '        mmoFSICVolume.Visible := True;'
      '    end;'
      ''
      '    if <PALROM> = '#39'S'#39' then'
      '    begin'
      '        mmoDRHPalet.Visible := True;'
      '        mmoDRMPalet.Visible := True;'
      '    end;'
      ''
      '    if <LOFIRO> = '#39'N'#39' then'
      '    begin'
      '        mmoPRHLocFis.Visible := False;'
      '        mmoPRMLocFis.Visible := False;'
      ''
      '        mmoPRHDescri.Left := mmoPRHLocFis.Left;'
      
        '        mmoPRHDescri.Width := mmoPRHDescri.Width + mmoPRHLocFis.' +
        'Width;'
      '        mmoPRMDescri.Left := mmoPRMLocFis.Left;'
      
        '        mmoPRMDescri.Width := mmoPRMDescri.Width + mmoPRHLocFis.' +
        'Width;'
      ''
      '    end;'
      ''
      '    if <OPCROM> <> '#39'1'#39' then'
      '    begin'
      '        mmoDRHDocFat.Visible := False;'
      '        mmoDRMDocFat.Visible := False;'
      ''
      
        '        mmoDRHEmpresa.Left := mmoDRHEmpresa.Left - mmoDRMDocFat.' +
        'Width;'
      
        '        mmoDRMEmpresa.Left := mmoDRMEmpresa.Left - mmoDRMDocFat.' +
        'Width;'
      ''
      
        '        mmoDRHVendedor.Left := mmoDRHVendedor.Left - mmoDRMDocFa' +
        't.Width;'
      
        '        mmoDRMVendedor.Left := mmoDRMVendedor.Left - mmoDRMDocFa' +
        't.Width;'
      ''
      
        '        mmoDRHCliente.Left := mmoDRHCliente.Left - mmoDRMDocFat.' +
        'Width;'
      
        '        mmoDRMCliente.Left := mmoDRMCliente.Left - mmoDRMDocFat.' +
        'Width;'
      
        '        mmoDRHCliente.Width := mmoDRHCliente.Width + mmoDRMDocFa' +
        't.Width;'
      
        '        mmoDRMCliente.Width := mmoDRMCliente.Width + mmoDRMDocFa' +
        't.Width;'
      '    end;'
      'end.')
    OnUserFunction = frxReportJUserFunction
    Left = 169
    Top = 310
    Datasets = <
      item
        DataSet = frxCarCar
        DataSetName = 'frxCarCar'
      end
      item
        DataSet = frxGenDoc
        DataSetName = 'frxGenDoc'
      end
      item
        DataSet = frxGenEmb
        DataSetName = 'frxGenEmb'
      end
      item
        DataSet = frxGenIte
        DataSetName = 'frxGenIte'
      end
      item
        DataSet = frxGenPag
        DataSetName = 'frxGenPag'
      end
      item
        DataSet = frxGenPg1
        DataSetName = 'frxGenPg1'
      end
      item
        DataSet = frxOutEnt
        DataSetName = 'frxOutEnt'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxTotDoc
        DataSetName = 'frxTotDoc'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 6.000000000000000000
      BottomMargin = 6.000000000000000000
      ColumnWidth = 2.500000000000000000
      LargeDesignHeight = True
      object CabecalhoSintetico: TfrxPageHeader
        FillType = ftBrush
        Height = 140.838590000000000000
        Top = 18.897650000000000000
        Width = 748.346940000000000000
        Stretched = True
        object mmoNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 128.428665000000000000
          Top = 5.779542200000000000
          Width = 491.489610000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object mmoNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 137.764070000000000000
          Top = 20.897650000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'mmoNomeRelatorioOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'ROTA DE ROMANEIO')
          ParentFont = False
        end
        object mmoPagina: TfrxMemoView
          Left = 627.401320940000000000
          Top = 5.779530000000000000
          Width = 115.200000000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA [Page]')
          ParentFont = False
        end
        object mmoEmitido: TfrxMemoView
          Left = 551.811380000000000000
          Top = 24.677180000000000000
          Width = 190.790600000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date] [Time]')
          ParentFont = False
        end
        object mmoOperadorSolicitante: TfrxMemoView
          Align = baCenter
          Left = 137.764070000000000000
          Top = 37.795300000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[OPERADOR_SOLICITANTE]')
          ParentFont = False
        end
        object mmoNumeroRomaneio: TfrxMemoView
          Align = baCenter
          Left = 137.764070000000000000
          Top = 52.913420000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ROMANEIO_NUMERO_ROTA]')
          ParentFont = False
        end
        object mmoTransportadora: TfrxMemoView
          Left = 3.779530000000000000
          Top = 71.811070000000000000
          Width = 721.890230000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[TRANSPORTADORA]')
          ParentFont = False
        end
        object mmoMotorista: TfrxMemoView
          Left = 3.779530000000000000
          Top = 90.708720000000000000
          Width = 721.890230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[MOTORISTA]')
          ParentFont = False
        end
        object mmoAjudante1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 105.606370000000000000
          Width = 362.834880000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[AJUDANTE_01]')
          ParentFont = False
        end
        object mmoAjudante2: TfrxMemoView
          Left = 370.393940000000000000
          Top = 105.606370000000000000
          Width = 362.834880000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[AJUDANTE_02]')
          ParentFont = False
        end
        object mmoAjudante3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 120.724490000000000000
          Width = 362.834880000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[AJUDANTE_03]')
          ParentFont = False
        end
        object mmoAjudante4: TfrxMemoView
          Left = 370.393940000000000000
          Top = 120.724490000000000000
          Width = 362.834880000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[AJUDANTE_04]')
          ParentFont = False
        end
      end
      object HeaderProdutosRota: TfrxHeader
        FillType = ftBrush
        Height = 30.236230240000000000
        Top = 219.212740000000000000
        Width = 748.346940000000000000
        ReprintOnNewPage = True
        object shpHProdutosRota: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 30.236230240000000000
          Fill.BackColor = clSilver
        end
        object mmoPRHReusmo: TfrxMemoView
          Left = 3.779530000000000000
          Width = 737.008350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO: PRODUTOS DA ROTA')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Top = 15.118120000000000000
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoPRHCodigo: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000000000
          Width = 71.811070000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRHLocFis: TfrxMemoView
          Left = 79.370130000000000000
          Top = 15.118120000000000000
          Width = 75.590600000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOCAL. F'#205'SICA')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRHDescri: TfrxMemoView
          Left = 158.740260000000000000
          Top = 15.118120000000000000
          Width = 332.598640000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRICAO / REFERENCIA')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRHQuantidade: TfrxMemoView
          Left = 684.094930000000000000
          Top = 15.118120000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRHMarca: TfrxMemoView
          Left = 529.134200000000000000
          Top = 15.118120000000000000
          Width = 151.181200000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRHUnidade: TfrxMemoView
          Left = 495.118430000000000000
          Top = 15.118120000000000000
          Width = 30.236240000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRHVolume: TfrxMemoView
          Left = 684.094930000000000000
          Top = 15.118120000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VOLUME')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRHPesoBruto: TfrxMemoView
          Left = 619.842920000000000000
          Top = 15.118120000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PESO BRT.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRHSaldos: TfrxMemoView
          Left = 555.590910000000000000
          Top = 15.118120000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SALDOS')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object MasterDataProdutos: TfrxMasterData
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 272.126160000000000000
        Width = 748.346940000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebraProdutosRota: TfrxMemoView
          Align = baClient
          Width = 748.346940000000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clMoneyGreen
          ParentFont = False
        end
        object mmoPRMCodigo: TfrxMemoView
          Left = 3.779530000000000000
          Width = 71.811070000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DET_ITEM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRMLocFis: TfrxMemoView
          Left = 79.370130000000000000
          Width = 75.590600000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DET_LOCFIS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRMDescri: TfrxMemoView
          Left = 158.740260000000000000
          Width = 332.598640000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'mmoPRMDescriOnBeforePrint'
          StretchMode = smMaxHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DET_DESCRI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoPRMUnidade: TfrxMemoView
          Left = 495.118430000000000000
          Width = 30.236240000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DET_UNIDAD"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRMMarca: TfrxMemoView
          Left = 529.134200000000000000
          Width = 151.181200000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRMQuantidade: TfrxMemoView
          Left = 684.094930000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[frxRelatorio."DET_QTDITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRMVolume: TfrxMemoView
          Left = 684.094930000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[frxRelatorio."DET_VOLUME"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRMPesoBruto: TfrxMemoView
          Left = 619.842920000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[frxRelatorio."DET_TOTPES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPRMSaldos: TfrxMemoView
          Left = 555.590910000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[frxRelatorio."ITE_SALDOS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object HeaderEmbalagem: TfrxHeader
        FillType = ftBrush
        Height = 30.236230240000000000
        Top = 347.716760000000000000
        Width = 748.346940000000000000
        ReprintOnNewPage = True
        object shpHEmbalagem: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 30.236230240000000000
          Fill.BackColor = clSilver
        end
        object mmoEHResumo: TfrxMemoView
          Left = 3.779530000000000000
          Width = 737.008350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO: EMBALAGENS')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line2: TfrxLineView
          Top = 15.118120000000000000
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoEHEmbalagem: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000000000
          Width = 71.811070000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMBALAGEM')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoEHQuantidade: TfrxMemoView
          Left = 83.149660000000000000
          Top = 15.118120000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoEHVolume: TfrxMemoView
          Left = 83.149660000000000000
          Top = 15.118120000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VOLUME')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object MasterDataEmabalgem: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 400.630180000000000000
        Width = 748.346940000000000000
        DataSet = frxGenEmb
        DataSetName = 'frxGenEmb'
        RowCount = 0
        object mmoZebraEmbalagem: TfrxMemoView
          Align = baClient
          Width = 748.346940000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clMoneyGreen
          ParentFont = False
        end
        object mmoEMEmbalagem: TfrxMemoView
          Left = 3.779530000000000000
          Width = 71.811070000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenEmb."DET_UNIDAD"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoEMQuantidade: TfrxMemoView
          Left = 83.149660000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[frxgENeMB."DET_QTDUNI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object FooterProdutosRota: TfrxFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 309.921460000000000000
        Width = 748.346940000000000000
        object mmoPRFQuantidade: TfrxMemoView
          Left = 680.315400000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[SUM(<frxRelatorio."DET_QTDITE">,MasterDataProdutos)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoPRFTotais: TfrxMemoView
          Left = 415.748300000000000000
          Width = 200.315090000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
        end
        object mmoPRFVolume: TfrxMemoView
          Left = 684.094930000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[SUM(<frxRelatorio."DET_VOLUME">,MasterDataProdutos)]')
          ParentFont = False
          WordWrap = False
        end
        object Line3: TfrxLineView
          Left = 0.220470000000000000
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoPRFPesoBruto: TfrxMemoView
          Left = 619.842920000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[SUM(<frxRelatorio."DET_TOTPES">,MasterDataProdutos)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object HeaderDocumentosRota: TfrxHeader
        FillType = ftBrush
        Height = 90.708710240000000000
        Top = 438.425480000000000000
        Width = 748.346940000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 90.708710240000000000
          Fill.BackColor = clSilver
        end
        object mmoDRHResumo: TfrxMemoView
          Left = 3.779530000000000000
          Width = 737.008350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO: DOCUMENTOS DA ROTA')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Top = 15.118120000000000000
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoDRHNumdoc: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'No. DOC.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHEmpresa: TfrxMemoView
          Left = 177.637910000000000000
          Top = 15.118120000000000000
          Width = 34.015770000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMP.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHVendedor: TfrxMemoView
          Left = 215.433210000000000000
          Top = 15.118120000000000000
          Width = 109.606370000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENDEDOR')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHCliente: TfrxMemoView
          Left = 328.819110000000000000
          Top = 15.118120000000000000
          Width = 158.740260000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHTotalDoc: TfrxMemoView
          Left = 684.094930000000000000
          Top = 15.118120000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOC.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHValorMercadoria: TfrxMemoView
          Left = 619.842920000000000000
          Top = 15.118120000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. MERC.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHPesoBruto: TfrxMemoView
          Left = 555.590910000000000000
          Top = 15.118120000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PESO BRT.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHVolume: TfrxMemoView
          Left = 491.338900000000000000
          Top = 15.118120000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VOLUME')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHFormaPagamento: TfrxMemoView
          Left = 3.779530000000000000
          Top = 30.236240000000000000
          Width = 170.078850000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORMA PAGAMENTO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHCondicaoPagamento: TfrxMemoView
          Left = 177.637910000000000000
          Top = 30.236240000000000000
          Width = 423.307360000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONDI'#199#195'O DE PAGAMENTO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHEndereco: TfrxMemoView
          Left = 3.779530000000000000
          Top = 45.354360000000000000
          Width = 597.165740000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ENDERE'#199'O')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHBairro: TfrxMemoView
          Left = 3.779530000000000000
          Top = 60.472480000000000000
          Width = 170.078850000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'BAIRRO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHCEP: TfrxMemoView
          Left = 177.637910000000000000
          Top = 60.472480000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHCidade: TfrxMemoView
          Left = 264.567100000000000000
          Top = 60.472480000000000000
          Width = 128.504020000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CIDADE-UF')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHObsFilial: TfrxMemoView
          Left = 396.850650000000000000
          Top = 60.472480000000000000
          Width = 128.504020000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OBS. FILIAL')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHMensagem: TfrxMemoView
          Left = 3.779530000000000000
          Top = 75.590600000000000000
          Width = 612.283860000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MENSAGENS DO DOCUMENTO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHPalet: TfrxMemoView
          Left = 619.842920000000000000
          Top = 75.590600000000000000
          Width = 124.724490000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PALET')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRHDocFat: TfrxMemoView
          Left = 90.708720000000000000
          Top = 15.118120000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOC. FAT.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object MasterDataDocumentosRota: TfrxMasterData
        FillType = ftBrush
        Height = 109.606299210000000000
        Top = 551.811380000000000000
        Width = 748.346940000000000000
        DataSet = frxGenDoc
        DataSetName = 'frxGenDoc'
        RowCount = 0
        Stretched = True
        object mmoZebraDocumentosRota: TfrxMemoView
          Align = baClient
          Width = 748.346940000000000000
          Height = 109.606299210000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clMoneyGreen
          ParentFont = False
          WordWrap = False
        end
        object mmoDRMCodigo: TfrxMemoView
          Left = 3.779530000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'mmoDRMCodigoOnBeforePrint'
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenDoc."GER_DOCESP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMEmpresa: TfrxMemoView
          Left = 177.637910000000000000
          Width = 34.015770000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenDoc."GER_CODEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMVendedor: TfrxMemoView
          Left = 215.433210000000000000
          Width = 109.606370000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenDoc."GER_NOMVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMCliente: TfrxMemoView
          Left = 328.819110000000000000
          Width = 158.740260000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenDoc."GER_NOMCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMVolume: TfrxMemoView
          Left = 491.338900000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[frxGenDoc."GER_QTDVOL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMPesoBruto: TfrxMemoView
          Left = 555.590910000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[frxGenDoc."GER_TOTPES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMValorMercadoria: TfrxMemoView
          Left = 619.842920000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[frxGenDoc."GER_TOTMER"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMTotalDoc: TfrxMemoView
          Left = 684.094930000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[frxGenDoc."GER_VLRCON"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMFormaPagamento: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000000000
          Width = 170.078850000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenDoc."GER_DESFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMConidcaoPagamento: TfrxMemoView
          Left = 177.637910000000000000
          Top = 15.118120000000000000
          Width = 438.425480000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'mmoDRMConidcaoPagamentoOnBeforePrint'
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenDoc."GER_DESFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMKMInicial: TfrxMemoView
          Left = 619.842920000000000000
          Top = 22.677180000000000000
          Width = 124.724490000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'KM INICIAL: __________________')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMEndereco: TfrxMemoView
          Left = 3.779530000000000000
          Top = 30.236240000000000000
          Width = 612.283860000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenDoc."GER_ENDREF"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMBairro: TfrxMemoView
          Left = 3.779530000000000000
          Top = 45.354360000000000000
          Width = 170.078850000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenDoc."GER_BAICLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMCEP: TfrxMemoView
          Left = 177.637910000000000000
          Top = 45.354360000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenDoc."GER_CEPCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMCidade: TfrxMemoView
          Left = 264.567100000000000000
          Top = 45.354360000000000000
          Width = 128.504020000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenDoc."GER_NOMCID"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMObsFil: TfrxMemoView
          Left = 396.850650000000000000
          Top = 45.354360000000000000
          Width = 219.212740000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenDoc."OBSFIL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMKMFinal: TfrxMemoView
          Left = 619.842920000000000000
          Top = 45.354360000000000000
          Width = 124.724490000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'KM FINAL..: __________________')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMMensagem: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 3.779530000000000000
          Top = 60.472480000000000000
          Width = 612.283860000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenDoc."GER_MEN001"] [frxGenDoc."GER_MEN002"]')
          ParentFont = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object mmoDRMPalet: TfrxMemoView
          Left = 619.842920000000000000
          Top = 60.472480000000000000
          Width = 170.078850000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenDoc."GER_PALET_"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMAssinatura: TfrxMemoView
          Left = 3.779530000000000000
          Top = 94.488250000000000000
          Width = 291.023810000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA DO CLIENTE')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMDocumento: TfrxMemoView
          Left = 340.157700000000000000
          Top = 94.488250000000000000
          Width = 211.653680000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DOCUMENTO DO CLIENTE')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMDataHora: TfrxMemoView
          Left = 597.165740000000000000
          Top = 94.488250000000000000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDRMDocFat: TfrxMemoView
          Left = 90.708720000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '____________-__')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object FooterDocumentosRota: TfrxFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 684.094930000000000000
        Width = 748.346940000000000000
        object mmoDRFTotal: TfrxMemoView
          Left = 287.244280000000000000
          Width = 200.315090000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
        end
        object mmoDRFTotalDoc: TfrxMemoView
          Left = 684.094930000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[SUM(<frxGenDoc."GER_VLRCON">,MasterDataDocumentosRota)]')
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Left = 0.220470000000000000
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoDRFTotalMercadorias: TfrxMemoView
          Left = 619.842920000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[SUM(<frxGenDoc."GER_TOTMER">,MasterDataDocumentosRota)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoDRFTotalPeso: TfrxMemoView
          Left = 555.590910000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[SUM(<frxGenDoc."GER_TOTPES">,MasterDataDocumentosRota)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoDRFQtdVol: TfrxMemoView
          Left = 491.338900000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[SUM(<frxGenDoc."GER_QTDVOL">,MasterDataDocumentosRota)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object HeaderTotalEspecie: TfrxHeader
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 721.890230000000000000
        Width = 748.346940000000000000
        ReprintOnNewPage = True
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object mmoEDHResumo: TfrxMemoView
          Left = 3.779530000000000000
          Width = 737.008350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'TOTAL POR ESPECIE')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterDataTotalEspecie: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 759.685530000000000000
        Width = 748.346940000000000000
        DataSet = frxTotDoc
        DataSetName = 'frxTotDoc'
        RowCount = 0
        object mmoZebraTotalEspecie: TfrxMemoView
          Align = baClient
          Width = 748.346940000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clMoneyGreen
          ParentFont = False
        end
        object mmoEDMEspecie: TfrxMemoView
          Left = 3.779530000000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTotDoc."GER_ESPDOC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoEDMValor: TfrxMemoView
          Left = 75.590600000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[frxTotDoc."GER_VLRCON"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object HeaderFormasPagamento: TfrxHeader
        FillType = ftBrush
        Height = 30.236230240000000000
        Top = 797.480830000000000000
        Width = 748.346940000000000000
        ReprintOnNewPage = True
        object Shape3: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 30.236230240000000000
          Fill.BackColor = clSilver
        end
        object mmoFPHResumo: TfrxMemoView
          Left = 3.779530000000000000
          Width = 737.008350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO: FORMAS DE PAGAMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line6: TfrxLineView
          Top = 15.118120000000000000
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoFPHFormaPagamento: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000000000
          Width = 211.653680000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORMA PAGAMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoFPHTotal: TfrxMemoView
          Left = 219.212740000000000000
          Top = 15.118120000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterDataFormasPagamento: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 850.394250000000000000
        Width = 748.346940000000000000
        DataSet = frxGenPag
        DataSetName = 'frxGenPag'
        RowCount = 0
        object memoZebraFormaPagamento: TfrxMemoView
          Align = baClient
          Width = 748.346940000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clMoneyGreen
          ParentFont = False
        end
        object mmoFPMFormaPagamento: TfrxMemoView
          Left = 3.779530000000000000
          Width = 211.653680000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenPag."GER_DESFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoFPMTotal: TfrxMemoView
          Left = 219.212740000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[frxgENpAG."GER_TOTFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object FooterFormasPagamento: TfrxFooter
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 888.189550000000000000
        Width = 748.346940000000000000
        object mmoFPFTotais: TfrxMemoView
          Left = 136.063080000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
        end
        object mmoFPFTotal: TfrxMemoView
          Left = 219.212740000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[SUM(<frxGenPag."GER_TOTFPG">,MasterDataFormasPagamento)]')
          ParentFont = False
          WordWrap = False
        end
        object Line7: TfrxLineView
          Left = 0.220470000000000000
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoFPFLinha: TfrxLineView
          Top = 30.236240000000000000
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoFPFFrete: TfrxMemoView
          Left = 136.063080000000000000
          Top = 15.118120000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'mmoFPFFreteOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'FRETE:')
          ParentFont = False
          WordWrap = False
        end
        object mmoFPFPFrete: TfrxMemoView
          Left = 306.141930000000000000
          Top = 15.118120000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '% FRETE')
          ParentFont = False
          WordWrap = False
        end
        object mmoFPFValFrete: TfrxMemoView
          Left = 219.212740000000000000
          Top = 15.118120000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[(<frxGenDoc."GER_FRETE_">)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoFPFPerFrete: TfrxMemoView
          Left = 389.291590000000000000
          Top = 15.118120000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxGenDoc."GER_PERFRE">)]%')
          ParentFont = False
          WordWrap = False
        end
      end
      object HeaderInfoIntens: TfrxHeader
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 944.882500000000000000
        Width = 748.346940000000000000
        ReprintOnNewPage = True
        object Shape4: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object mmoIIHResumo: TfrxMemoView
          Left = 3.779530000000000000
          Width = 737.008350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'INFORMACOES DOS ITENS')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterDataInfoItens: TfrxMasterData
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 982.677800000000000000
        Width = 748.346940000000000000
        DataSet = frxGenIte
        DataSetName = 'frxGenIte'
        RowCount = 0
        Stretched = True
        object memoZebraInfoItens: TfrxMemoView
          Align = baClient
          Width = 748.346940000000000000
          Height = 30.236240000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clMoneyGreen
          ParentFont = False
        end
        object mmoIIMItem: TfrxMemoView
          Left = 3.779530000000000000
          Width = 740.787880000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenIte."ITEM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoIIMInfo: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000000000
          Width = 740.787880000000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenIte."DET_INFITE"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object HeaderCarregamentoCarga: TfrxHeader
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 1035.591220000000000000
        Width = 748.346940000000000000
        KeepChild = True
        ReprintOnNewPage = True
        object Shape5: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object mmoCCHResumo: TfrxMemoView
          Left = 3.779530000000000000
          Width = 737.008350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'CARREGAMENTO DE CARGA')
          ParentFont = False
        end
      end
      object MasterDataCarregamentoCarga: TfrxMasterData
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 1126.299940000000000000
        Width = 748.346940000000000000
        DataSet = frxCarCar
        DataSetName = 'frxCarCar'
        KeepTogether = True
        RowCount = 0
        object Memo12: TfrxMemoView
          Align = baClient
          Width = 748.346940000000000000
          Height = 30.236240000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clMoneyGreen
          ParentFont = False
        end
        object mmoCCMProduto: TfrxMemoView
          Left = 3.779530000000000000
          Width = 377.953000000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCarCar."DET_DESCRI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoCCMMarca: TfrxMemoView
          Left = 400.630180000000000000
          Width = 158.740260000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCarCar."MAR_DESMAR"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoCCMQTDE: TfrxMemoView
          Left = 563.149970000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[frxCarCar."DET_QTDITE"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoCCMMetragem: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000000000
          Width = 377.953000000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'mmoCCMMetragemOnBeforePrint'
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'METRAGEM')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeaderCarregamentoCarga: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 1073.386520000000000000
        Width = 748.346940000000000000
        Condition = 
          '<frxCarCar."GER_NUMDOC"> + <frxCarCar."GER_ESPDOC"> + <frxCarCar' +
          '."GER_CODEMP">'
        KeepTogether = True
        ReprintOnNewPage = True
        object Shape6: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 30.236240000000000000
          Fill.BackColor = clSilver
        end
        object mmoCCGCodigo: TfrxMemoView
          Left = 3.779530000000000000
          Width = 71.811070000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoCCGCliente: TfrxMemoView
          Left = 79.370130000000000000
          Width = 302.362400000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCarCar."DET_NOMCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoCCGDocumento: TfrxMemoView
          Left = 400.630180000000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoCCGNumdoc: TfrxMemoView
          Left = 472.441250000000000000
          Width = 154.960730000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxCarCar."GER_NUMDOC"] [frxCarCar."GER_ESPDOC"] [frxCarCar."GE' +
              'R_CODEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoCCGData: TfrxMemoView
          Left = 631.181510000000000000
          Width = 45.354360000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoCCGDtaEnt: TfrxMemoView
          Left = 680.315400000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCarCar."GER_DTAENT"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoCCGProduto: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000000000
          Width = 377.953000000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PRODUTO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoCCGMarca: TfrxMemoView
          Left = 400.630180000000000000
          Top = 15.118120000000000000
          Width = 158.740260000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoCCGObsFil: TfrxMemoView
          Left = 631.181510000000000000
          Top = 15.118120000000000000
          Width = 109.606370000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCarCar."OBSFIL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoCCGQTDE: TfrxMemoView
          Left = 563.149970000000000000
          Top = 15.118120000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object HeaderOutrasEntregas: TfrxHeader
        FillType = ftBrush
        Height = 30.236230240000000000
        Top = 1179.213360000000000000
        Width = 748.346940000000000000
        ReprintOnNewPage = True
        object Shape7: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 30.236230240000000000
          Fill.BackColor = clSilver
        end
        object mmoOEHResumo: TfrxMemoView
          Left = 3.779530000000000000
          Width = 737.008350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'OUTRAS ENTREGAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line8: TfrxLineView
          Top = 15.118120000000000000
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoOEHDescricao: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000000000
          Width = 737.008350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterDataOutrasEntregas: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 1232.126780000000000000
        Width = 748.346940000000000000
        DataSet = frxOutEnt
        DataSetName = 'frxOutEnt'
        RowCount = 0
        object mmoOEMDescri: TfrxMemoView
          Left = 3.779530000000000000
          Width = 737.008350000000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxOutEnt."OUT_DESCRI"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportSummary: TfrxReportSummary
        FillType = ftBrush
        Height = 219.212740000000000000
        Top = 1307.717380000000000000
        Width = 748.346940000000000000
        Stretched = True
        object mmoSURodape: TfrxMemoView
          Left = 7.559060000000000000
          Top = 7.559060000000000000
          Width = 737.008350000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[MSGRO1]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Line9: TfrxLineView
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoSURodape2: TfrxMemoView
          Left = 7.559060000000000000
          Top = 22.677180000000000000
          Width = 737.008350000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[MSGRO2]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object mmoSUConferente: TfrxMemoView
          Left = 7.559060000000000000
          Top = 95.031540000000000000
          Width = 313.700990000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA DO CONFERENTE')
          ParentFont = False
        end
        object mmoSUDataHora1: TfrxMemoView
          Left = 359.055350000000000000
          Top = 95.031540000000000000
          Width = 204.094620000000000000
          Height = 11.338590000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          ParentFont = False
        end
        object mmoSUMotorista: TfrxMemoView
          Left = 7.559060000000000000
          Top = 151.724490000000000000
          Width = 313.700990000000000000
          Height = 11.338590000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA DO MOTORISTA')
          ParentFont = False
        end
        object mmoSURGMotorista: TfrxMemoView
          Left = 359.055350000000000000
          Top = 151.724490000000000000
          Width = 188.976500000000000000
          Height = 11.338590000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'R.G. DO MOTORISTA')
          ParentFont = False
        end
        object mmoSUDataHora2: TfrxMemoView
          Left = 570.709030000000000000
          Top = 151.724490000000000000
          Width = 170.078850000000000000
          Height = 11.338590000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          ParentFont = False
        end
        object mmoSURodapeFinal: TfrxMemoView
          Left = 7.559060000000000000
          Top = 173.858267716535000000
          Width = 737.008350000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[RODROM]')
          ParentFont = False
        end
        object mmoSUKMInicialFinal: TfrxMemoView
          Left = 7.559060000000000000
          Top = 196.535433070866000000
          Width = 737.008350000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'KM INICIAL ______________________ / KM FINAL ___________________' +
              '___.')
          ParentFont = False
        end
      end
      object PageFooter: TfrxPageFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 1549.607300000000000000
        Width = 748.346940000000000000
        object mmoPFRodape: TfrxMemoView
          Left = 7.559060000000000000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'frmFatRotaRomaneio')
          ParentFont = False
        end
        object Line10: TfrxLineView
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
      end
    end
    object qckItemCliente: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 6.000000000000000000
      BottomMargin = 6.000000000000000000
      object PageHeaderItemCliente: TfrxPageHeader
        FillType = ftBrush
        Height = 61.468460000000000000
        Top = 18.897650000000000000
        Width = 748.346940000000000000
        object mmoICNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 128.428665000000000000
          Top = 5.779542200000000000
          Width = 491.489610000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object mmoICNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 137.764070000000000000
          Top = 20.897650000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'mmoNomeRelatorioOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITENS POR CLIENTE')
          ParentFont = False
        end
        object mmoICPagina: TfrxMemoView
          Left = 627.401320940000000000
          Top = 5.779530000000000000
          Width = 115.200000000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA [Page]')
          ParentFont = False
        end
        object mmoICEmitido: TfrxMemoView
          Left = 551.811380000000000000
          Top = 24.677180000000000000
          Width = 190.790600000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date] [Time]')
          ParentFont = False
        end
        object mmoICNumeroRomaneio: TfrxMemoView
          Align = baCenter
          Left = 137.764070000000000000
          Top = 37.795300000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[ROMANEIO_NUMERO_ROTA]')
          ParentFont = False
        end
      end
      object GroupHeaderItensCliente: TfrxGroupHeader
        FillType = ftBrush
        Height = 68.031530240000000000
        Top = 139.842610000000000000
        Width = 748.346940000000000000
        Condition = '<frxGenPg1."DET_CODCLI"> + <frxGenPg1."GER_ENDCLI">'
        object Shape8: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 68.031530240000000000
          Fill.BackColor = clSilver
        end
        object mmoICHNomeCliente: TfrxMemoView
          Width = 453.543600000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenPg1."DET_NOMCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICHCEP: TfrxMemoView
          Left = 457.323130000000000000
          Width = 30.236240000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICHCepCli: TfrxMemoView
          Left = 491.338900000000000000
          Width = 124.724490000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenPg1."GER_CEPCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICHFone: TfrxMemoView
          Top = 15.118120000000000000
          Width = 453.543600000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenPg1."GER_FONES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICHEndCli: TfrxMemoView
          Top = 30.236240000000000000
          Width = 268.346630000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenPg1."GER_ENDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICHBairro: TfrxMemoView
          Left = 317.480520000000000000
          Top = 30.236240000000000000
          Width = 143.622140000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenPg1."GER_BAICLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICHBaiCli: TfrxMemoView
          Left = 272.126160000000000000
          Top = 30.236240000000000000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'BAIRRO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICHCidade: TfrxMemoView
          Left = 476.220780000000000000
          Top = 30.236240000000000000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CIDADE:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICHNomCid: TfrxMemoView
          Left = 521.575140000000000000
          Top = 30.236240000000000000
          Width = 170.078850000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenPg1."GER_NOMCID"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line11: TfrxLineView
          Top = 45.354360000000000000
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoICHCodigo: TfrxMemoView
          Top = 49.133890000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICHDescriRef: TfrxMemoView
          Left = 109.606370000000000000
          Top = 49.133890000000000000
          Width = 355.275820000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRICAO/REFERENCIA')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICHUnidade: TfrxMemoView
          Left = 468.661720000000000000
          Top = 49.133890000000000000
          Width = 26.456710000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICHMarca: TfrxMemoView
          Left = 498.897960000000000000
          Top = 49.133890000000000000
          Width = 162.519790000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICHQuantidade: TfrxMemoView
          Left = 665.197280000000000000
          Top = 49.133890000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICHVolume: TfrxMemoView
          Left = 665.197280000000000000
          Top = 49.133890000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VOLUME')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object MasterDataItensCliente: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 230.551330000000000000
        Width = 748.346940000000000000
        DataSet = frxGenPg1
        DataSetName = 'frxGenPg1'
        RowCount = 0
        object mmoZebraItensCliente: TfrxMemoView
          Align = baClient
          Width = 748.346940000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clMoneyGreen
          ParentFont = False
        end
        object mmoICMCodigo: TfrxMemoView
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenPg1."DET_ITEM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICMDescriRef: TfrxMemoView
          Left = 109.606370000000000000
          Width = 355.275820000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenPg1."DET_DESCRI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICMUnidade: TfrxMemoView
          Left = 468.661720000000000000
          Width = 26.456710000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenPg1."DET_UNIDAD"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICMMarca: TfrxMemoView
          Left = 498.897960000000000000
          Width = 162.519790000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGenPg1."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICMQuantidade: TfrxMemoView
          Left = 665.197280000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[frxGenPg1."DET_QTDITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICMVolume: TfrxMemoView
          Left = 665.197280000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[frxGenPg1."DET_VOLUME"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 529.134200000000000000
        Width = 748.346940000000000000
        object Memo1: TfrxMemoView
          Left = 7.559060000000000000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'frmFatRotaRomaneio')
          ParentFont = False
        end
        object Line12: TfrxLineView
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object GroupFooterItensCliente: TfrxGroupFooter
        FillType = ftBrush
        Height = 154.960627480000000000
        Top = 268.346630000000000000
        Width = 748.346940000000000000
        object Line13: TfrxLineView
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoICFTotais: TfrxMemoView
          Left = 498.897960000000000000
          Width = 162.519790000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICFQuantidade: TfrxMemoView
          Left = 665.197280000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[SUM(<frxGenPg1."DET_QTDITE">,MasterDataItensCliente)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoICFVolume: TfrxMemoView
          Left = 665.197280000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[SUM(<frxGenPg1."DET_VOLUME">,MasterDataItensCliente)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoSUICConferente: TfrxMemoView
          Left = 7.559060000000000000
          Top = 37.795300000000000000
          Width = 313.700990000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA DO CONFERENTE')
          ParentFont = False
        end
        object mmoSUICDataHora1: TfrxMemoView
          Left = 359.055350000000000000
          Top = 37.795300000000000000
          Width = 204.094620000000000000
          Height = 11.338590000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          ParentFont = False
        end
        object mmoSUICMotorista: TfrxMemoView
          Left = 7.559060000000000000
          Top = 94.488250000000000000
          Width = 313.700990000000000000
          Height = 11.338590000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA DO CLIENTE')
          ParentFont = False
        end
        object mmoSUICRGMotorista: TfrxMemoView
          Left = 359.055350000000000000
          Top = 94.488250000000000000
          Width = 188.976500000000000000
          Height = 11.338590000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'R.G. DO CLIENTE')
          ParentFont = False
        end
        object mmoSUICDataHora2: TfrxMemoView
          Left = 570.709030000000000000
          Top = 94.488250000000000000
          Width = 170.078850000000000000
          Height = 11.338590000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          ParentFont = False
        end
        object mmoSUICRodapeFinal: TfrxMemoView
          Left = 7.559060000000000000
          Top = 132.283550000000000000
          Width = 733.228820000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[RODROM]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 483.779840000000000000
        Width = 748.346940000000000000
        object Line14: TfrxLineView
          Width = 748.346940000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoFSICTotais: TfrxMemoView
          Left = 498.897960000000000000
          Top = 3.779530000000000000
          Width = 162.519790000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoFSICQuantidade: TfrxMemoView
          Left = 665.197280000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[SUM(<frxGenPg1."DET_QTDITE">,MasterDataItensCliente)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoFSICVolume: TfrxMemoView
          Left = 665.197280000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
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
            '[SUM(<frxGenPg1."DET_VOLUME">,MasterDataItensCliente)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxTotDoc: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxTotDoc'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 72
    Top = 360
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    Left = 24
    Top = 360
  end
  object frxGenEmb: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxGenEmb'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 120
    Top = 360
  end
  object frxGenDoc: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxGenDoc'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 168
    Top = 360
  end
  object frxGenPag: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxGenPag'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 216
    Top = 360
  end
  object frxGenIte: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxGenIte'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 264
    Top = 360
  end
  object frxGenPg1: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxGenPg1'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 312
    Top = 360
  end
  object frxCarCar: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxCarCar'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 360
    Top = 360
  end
  object frxOutEnt: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxOutEnt'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 408
    Top = 360
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 32
    Top = 304
  end
  object frxRotaRomaneioM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45383.706717638900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '    blnExibeFrete : Boolean;'
      ''
      'procedure mmoNomeRelatorioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '    if (<PREVIA> = '#39'S'#39') and (Pos('#39'PREVIA DE ROMANEIO'#39', mmoNomeRe' +
        'latorio.Text) <= 0) then'
      
        '        mmoNomeRelatorio.Text := '#39'ROTA DE ROMANEIO - PREVIA DE R' +
        'OMANEIO'#39';'
      ''
      'end;'
      ''
      'procedure mmoPRMDescriOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    if <frxRelatorio."DET_NUMLOT"> <> '#39#39' then'
      
        '        mmoPRMDescri.Text := mmoPRMDescri.Text + '#39'LOTE: '#39' + <frx' +
        'Relatorio."DET_NUMLOT">;'
      'end;'
      ''
      'procedure mmoDRMCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '    if (not blnExibeFrete) and (<frxGenDoc."GER_FRETE_"> <> 0) t' +
        'hen'
      '        blnExibeFrete := True;'
      'end;'
      ''
      
        'procedure mmoDRMConidcaoPagamentoOnBeforePrint(Sender: TfrxCompo' +
        'nent);'
      'begin'
      
        '    mmoDRMConidcaoPagamento.Text := fFormataCondPag(<frxGenDoc."' +
        'GER_CONPAG">) + '#39'  -  '#39' + <frxGenDoc."CND_DESCRI">;'
      'end;'
      ''
      'procedure mmoFPFFreteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    if not blnExibeFrete then'
      '    begin'
      '        mmoFPFFrete.Visible := False;'
      '        mmoFPFValFrete.Visible := False;'
      '        mmoFPFPFrete.Visible := False;'
      '        mmoFPFPerFrete.Visible := False;'
      '    end;'
      'end;'
      ''
      'procedure mmoCCMMetragemOnBeforePrint(Sender: TfrxComponent);'
      'var'
      '    strMetragem : String;'
      'begin'
      '    strMetragem := '#39#39';'
      '    If <VENMAD> = '#39'S'#39' Then'
      
        '        strMetragem := fRetMetragemItem(<frxCarCar."DET_AUTINC">' +
        ',<frxCarCar."GER_ESPDOC">);'
      ''
      '  mmoCCMMetragem.Text := strMetragem;'
      'end;'
      ''
      'procedure mmoPRHFilialOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    if <frxRelatorio."GER_CODFIL"> = '#39#39' then'
      '        mmoPRHFilial.Text := '#39'DEMAIS PRODUTOS DA ROTA'#39
      '    else'
      
        '        mmoPRHFilial.Text :=  '#39'PRODUTOS PARA RETIRAR NA FILIAL '#39 +
        ' +  <frxRelatorio."GER_CODFIL">;'
      'end;'
      ''
      'procedure mmoDRMDocFatOnBeforePrint(Sender: TfrxComponent);'
      'var'
      '    strTexto : String;'
      'begin'
      '    strTexto := '#39#39';'
      ''
      '    if <USPRRO> = '#39'S'#39' then'
      '    begin'
      '        if <frxGenDoc."GER_DOCFAT"> <> '#39#39' then'
      '            strTexto := <frxGenDoc."GER_DOCFAT">'
      '        else if <frxGenDoc."FGO_DOCFAT"> <> '#39#39' then'
      '            strTexto := <frxGenDoc."FGO_DOCFAT"> ;'
      '    end;'
      ''
      '    mmoDRMDocFat.Text := strTexto;'
      'end;'
      ''
      'procedure mmoCCGNumdocOnBeforePrint(Sender: TfrxComponent);'
      'var'
      '    strTexto : String;'
      'begin'
      
        '    strTexto := <frxCarCar."GER_NUMDOC"> + '#39' '#39' + <frxCarCar."GER' +
        '_ESPDOC"> + '#39' '#39' + <frxCarCar."GER_CODEMP">;'
      ''
      
        '    if (<OPCROM> = '#39'1'#39') and (<USPRRO> = '#39'S'#39') and (<frxCarCar."GE' +
        'R_NUMFAT"> <> '#39#39') then'
      '    begin'
      
        '        strTexto := strTexto + '#39' - '#39' + <frxCarCar."GER_NUMFAT"> ' +
        '+ '#39' '#39' + <frxCarCar."GER_TIPFAT"> + '#39' '#39' + <frxCarCar."GER_EMPFAT"' +
        '>;'
      '    end;'
      ''
      '    mmoCCGNumdoc.Text := strTexto;'
      'end;'
      ''
      'begin'
      '    blnExibeFrete := False;'
      ''
      '    HeaderProdutosRota.Visible := False;'
      '    MasterDataProdutos.Visible := False;'
      '    FooterProdutosRota.Visible := False;'
      ''
      '    HeaderEmbalagem.Visible := False;'
      '    MasterDataEmabalgem.Visible := False;'
      ''
      '    HeaderDocumentosRota.Visible := False;'
      '    MasterDataDocumentosRota.Visible := False;'
      '    FooterDocumentosRota.Visible := False;'
      ''
      '    HeaderTotalEspecie.Visible := False;'
      '    MasterDataTotalEspecie.Visible := False;'
      ''
      '    HeaderFormasPagamento.Visible := False;'
      '    MasterDataFormasPagamento.Visible := False;'
      '    FooterFormasPagamento.Visible := False;'
      ''
      '    HeaderCarregamentoCarga.Visible := False;'
      '    GroupHeaderCarregamentoCarga.Visible := False;'
      '    MasterDataCarregamentoCarga.Visible := False;'
      ''
      '    HeaderInfoIntens.Visible := False;'
      '    MasterDataInfoItens.Visible := False;'
      ''
      
        '    qckPagina.Visible := False;                                 ' +
        '                                                                ' +
        '   '
      '    qckItemCliente.Visible := False;'
      ''
      '    mmoPRHMarca.Visible := False;'
      '    mmoPRHQuantidade.Visible := False;'
      '    mmoPRHVolume.Visible := False;'
      '    mmoPRHPesoBruto.Visible := False;'
      '    mmoPRHSaldos.Visible := False;'
      '    mmoPRMMarca.Visible := False;'
      '    mmoPRMQuantidade.Visible := False;'
      '    mmoPRMVolume.Visible := False;'
      '    mmoPRMPesoBruto.Visible := False;'
      '    mmoPRFPesoBruto.Visible := False;'
      '    mmoPRMSaldos.Visible := False;'
      '    mmoPRFQuantidade.Visible := False;'
      '    mmoPRFVolume.Visible := False;'
      '    mmoEHQuantidade.Visible := False;'
      '    mmoEHVolume.Visible := False;'
      '    mmoDRHPalet.Visible := False;'
      '    mmoDRMPalet.Visible := False;'
      '    mmoICHQuantidade.Visible := False;'
      '    mmoICHVolume.Visible := False;'
      '    mmoICMQuantidade.Visible := False;'
      '    mmoICMVolume.Visible := False;'
      '    mmoICFQuantidade.Visible := False;'
      '    mmoICFVolume.Visible := False;'
      '    mmoSUKMInicialFinal.Visible := False;'
      '    mmoFSICQuantidade.Visible := False;'
      '    mmoFSICVolume.Visible := False;'
      ''
      '    if <RETFIL> = '#39'N'#39' then'
      '    begin'
      '        mmoPRHFilial.Visible := False;'
      '        DMPMemo4.Visible := False;'
      ''
      '        mmoPRHCodigo.Top := mmoPRHFilial.Top;'
      '        mmoPRHLocFis.Top := mmoPRHFilial.Top;'
      '        mmoPRHDescri.Top := mmoPRHFilial.Top;'
      '        mmoPRHQuantidade.Top := mmoPRHFilial.Top;'
      '        mmoPRHMarca.Top := mmoPRHFilial.Top;'
      '        mmoPRHUnidade.Top := mmoPRHFilial.Top;'
      '        mmoPRHVolume.Top := mmoPRHFilial.Top;'
      '        mmoPRHPesoBruto.Top := mmoPRHFilial.Top;'
      '        mmoPRHSaldos.Top := mmoPRHFilial.Top;'
      ''
      '        HeaderProdutosRota.Height := 85;'
      '    end;'
      ''
      '    if <BLN_PRODUTOS> = '#39'S'#39' then'
      '    begin'
      
        '        qckPagina.Visible := True;                              ' +
        '                                                                ' +
        '      '
      '        HeaderProdutosRota.Visible := True;'
      '        MasterDataProdutos.Visible := True;'
      '        FooterProdutosRota.Visible := True;'
      '    end;'
      ''
      '    if <BLN_EMBALAGENS> = '#39'S'#39' then'
      '    begin'
      '        qckPagina.Visible := True;'
      '        HeaderEmbalagem.Visible := True;'
      '        MasterDataEmabalgem.Visible := True;'
      '    end;'
      ''
      '    if <BLN_DOCUMENTOS> = '#39'S'#39' then'
      '    begin'
      '        qckPagina.Visible := True;'
      '        HeaderDocumentosRota.Visible := True;'
      '        MasterDataDocumentosRota.Visible := True;'
      '        FooterDocumentosRota.Visible := True;'
      '    end;'
      ''
      '    if <BLN_TOTESPDOC> = '#39'S'#39' then'
      '    begin'
      '        qckPagina.Visible := True;'
      '        HeaderTotalEspecie.Visible := True;'
      '        MasterDataTotalEspecie.Visible := True;'
      '    end;'
      ''
      '    if <BLN_FORMAS> = '#39'S'#39' then'
      '    begin'
      '        qckPagina.Visible := True;'
      '        HeaderFormasPagamento.Visible := True;'
      '        MasterDataFormasPagamento.Visible := True;'
      '        FooterFormasPagamento.Visible := True;'
      '    end;'
      ''
      '    if <BLN_INFITE> = '#39'S'#39' then'
      '    begin'
      '        qckPagina.Visible := True;'
      '        HeaderInfoIntens.Visible := True;'
      '        MasterDataInfoItens.Visible := True;'
      '    end;'
      ''
      '    if <BLN_CARCAR> = '#39'S'#39' then'
      '    begin'
      '        qckPagina.Visible := True;'
      '        HeaderCarregamentoCarga.Visible := True;'
      '        GroupHeaderCarregamentoCarga.Visible := True;'
      '        MasterDataCarregamentoCarga.Visible := True;'
      '    end;'
      ''
      '    if <BLN_ITEMCL> = '#39'S'#39' then'
      '        qckItemCliente.Visible := True;'
      ''
      '    if <BLN_LOCASS> = '#39'N'#39' then'
      '    begin'
      '        mmoDRMAssinatura.Visible := False;'
      '        mmoDRMDocumento.Visible := False;'
      '        mmoDRMDataHora.Visible := False;'
      '        mmoDRMAssinaturaLinha.Visible := False;'
      '        mmoDRMDocumentoLinha.Visible := False;'
      '        mmoDRMDataHoraLinha.Visible := False;'
      '        linDocumentoRotaFinal.Top := 102;'
      ''
      '        mmoDRMAssinatura.Top := 17;'
      '        mmoDRMDocumento.Top := 17;'
      '        mmoDRMDataHora.Top := 17;'
      '        mmoDRMAssinaturaLinha.Top := 17;'
      '        mmoDRMDocumentoLinha.Top := 17;'
      '        mmoDRMDataHoraLinha.Top := 17;'
      ''
      '        mmoSUConferente.Visible := False;'
      '        mmoSUDataHora1.Visible := False;'
      '        mmoSUMotorista.Visible := False;'
      '        mmoSURGMotorista.Visible := False;'
      '        mmoSUDataHora2.Visible := False;'
      '        mmoSURodapeFinal.Visible := False;'
      ''
      '        mmoSUConferenteLinha.Visible := False;'
      '        mmoSUDataHora1Linha.Visible := False;'
      '        mmoSUMotoristaLinha.Visible := False;'
      '        mmoSURGMotoristaLinha.Visible := False;'
      '        mmoSUDataHora2Linha.Visible := False;'
      ''
      '        mmoSUKMInicialFinal.Top := 68;'
      ''
      '        mmoSUICConferente.Visible := False;'
      '        mmoSUICDataHora1.Visible := False;'
      '        mmoSUICMotorista.Visible := False;'
      '        mmoSUICRGMotorista.Visible := False;'
      '        mmoSUICDataHora2.Visible := False;'
      '        mmoSUICRodapeFinal.Visible := False;'
      '        mmoSUICConferenteLinha.Visible := False;'
      '        mmoSUICDataHora1Linha.Visible := False;'
      '        mmoSUICMotoristaLinha.Visible := False;'
      '        mmoSUICRGMotoristaLinha.Visible := False;'
      '        mmoSUICDataHora2Linha.Visible := False;'
      ''
      '        GroupFooterItensCliente.Height := 34;'
      '    end;'
      ''
      '    if <BLN_IMP_KM> = '#39'S'#39' then'
      '       mmoSUKMInicialFinal.Visible := True;'
      ''
      '    if <BLN_MOSMAR> = '#39'S'#39' then'
      '    begin'
      '        mmoPRHMarca.Visible := True;'
      '        mmoPRMMarca.Visible := True;'
      '    end'
      '    else'
      '    begin'
      '        mmoPRHPesoBruto.Visible := True;'
      '        mmoPRMPesoBruto.Visible := True;'
      '        mmoPRFPesoBruto.VisiBle := True;'
      ''
      '        if <SALROM> = '#39'S'#39' then'
      '        begin'
      '            mmoPRHSaldos.Visible := True;'
      '            mmoPRMSaldos.Visible := True;'
      '        end;'
      '    end;'
      ''
      '    if <IMP_PRODUTOS> = '#39'Q'#39' then'
      '    begin'
      '        mmoPRHQuantidade.Visible := True;'
      '        mmoPRMQuantidade.Visible := True;'
      '        mmoPRFQuantidade.Visible := True;'
      '    end'
      '    else if <IMP_PRODUTOS> = '#39'V'#39' then'
      '    begin'
      '        mmoPRHVolume.Visible := True;'
      '        mmoPRMVolume.Visible := True;'
      '        mmoPRFVolume.Visible := True;'
      '    end;'
      ''
      '    if <IMP_EMBALAGENS> = '#39'Q'#39' then'
      '        mmoEHQuantidade.Visible := True'
      '    else if <IMP_EMBALAGENS> = '#39'V'#39' then'
      '        mmoEHVolume.Visible := True;'
      ''
      '    if <IMP_ITEMCL> = '#39'Q'#39' then'
      '    begin'
      '        mmoICHQuantidade.Visible := True;'
      '        mmoICMQuantidade.Visible := True;'
      '        mmoICFQuantidade.Visible := True;'
      '        mmoFSICQuantidade.Visible := True;'
      '    end'
      '    else if <IMP_ITEMCL> = '#39'V'#39' then'
      '    begin'
      '        mmoICHVolume.Visible := True;'
      '        mmoICMVolume.Visible := True;'
      '        mmoICFVolume.Visible := True;'
      '        mmoFSICVolume.Visible := True;'
      '    end;'
      ''
      '    if <PALROM> = '#39'S'#39' then'
      '    begin'
      '        mmoDRHPalet.Visible := True;'
      '        mmoDRMPalet.Visible := True;'
      '    end;'
      ''
      '    if <LOFIRO> = '#39'N'#39' then'
      '    begin'
      '        mmoPRHLocFis.Visible := False;'
      '        mmoPRMLocFis.Visible := False;'
      ''
      '        mmoPRHDescri.Left := mmoPRHLocFis.Left;'
      
        '        mmoPRHDescri.Width := mmoPRHDescri.Width + mmoPRHLocFis.' +
        'Width;'
      '        mmoPRMDescri.Left := mmoPRMLocFis.Left;'
      
        '        mmoPRMDescri.Width := mmoPRMDescri.Width + mmoPRHLocFis.' +
        'Width;'
      ''
      '    end;'
      ''
      '    if <OPCROM> <> '#39'1'#39' then'
      '    begin'
      '        mmoDRHDocFat.Visible := False;'
      '        mmoDRMDocFat.Visible := False;'
      ''
      '        mmoDRHCliente.Left := mmoDRHDocFat.Left;'
      '        mmoDRMCliente.Left := mmoDRMDocFat.Left;'
      
        '        mmoDRHCliente.Width := mmoDRHCliente.Width + mmoDRHDocFa' +
        't.Width;'
      
        '        mmoDRMCliente.Width := mmoDRMCliente.Width + mmoDRMDocFa' +
        't.Width;'
      '    end;'
      'end.')
    OnUserFunction = frxReportJUserFunction
    Left = 265
    Top = 310
    Datasets = <
      item
        DataSet = frxCarCar
        DataSetName = 'frxCarCar'
      end
      item
        DataSet = frxGenDoc
        DataSetName = 'frxGenDoc'
      end
      item
        DataSet = frxGenEmb
        DataSetName = 'frxGenEmb'
      end
      item
        DataSet = frxGenIte
        DataSetName = 'frxGenIte'
      end
      item
        DataSet = frxGenPag
        DataSetName = 'frxGenPag'
      end
      item
        DataSet = frxGenPg1
        DataSetName = 'frxGenPg1'
      end
      item
        DataSet = frxOutEnt
        DataSetName = 'frxOutEnt'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxTotDoc
        DataSetName = 'frxTotDoc'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 256.539834318023700000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      RightMargin = 17.779988517090700000
      ColumnWidth = 2.539998359584390000
      EndlessHeight = True
      LargeDesignHeight = True
      FontStyle = []
      object CabecalhoSintetico: TfrxPageHeader
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 17.000000000000000000
        Width = 902.400000000000200000
        object ComandoPG1MudaImp: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#18#27#77'
        end
        object mmoNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 211.200000000000000000
          Top = 17.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 220.800000000000000000
          Top = 34.000000000000000000
          Width = 470.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoNomeRelatorioOnBeforePrint'
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'ROTA DE ROMANEIO')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoPagina: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA [Page]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoEmitido: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 34.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date] [Time]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoOperadorSolicitante: TfrxDMPMemoView
          Align = baCenter
          Left = 172.800000000000000000
          Top = 51.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[OPERADOR_SOLICITANTE]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoNumeroRomaneio: TfrxDMPMemoView
          Align = baCenter
          Left = 172.800000000000000000
          Top = 68.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[ROMANEIO_NUMERO_ROTA]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoTransportadora: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[TRANSPORTADORA]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoMotorista: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[MOTORISTA]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoAjudante1: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[AJUDANTE_01]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoAjudante2: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 119.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AJUDANTE_02]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoAjudante3: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[AJUDANTE_03]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoAjudante4: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 136.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AJUDANTE_04]')
          ParentFont = False
          TruncOutboundText = True
        end
      end
      object HeaderProdutosRota: TfrxHeader
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 204.000000000000000000
        Width = 902.400000000000200000
        ReprintOnNewPage = True
        object mmoPRHVolume: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 85.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VOLUME')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRHReusmo: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO: PRODUTOS DA ROTA')
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRHCodigo: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRHLocFis: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 85.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'LOCAL. FISICA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRHDescri: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 85.000000000000000000
          Width = 422.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DESCRICAO / REFERENCIA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRHQuantidade: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 85.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRHMarca: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 85.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRHUnidade: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 85.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRHPesoBruto: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 85.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'PESO BRT')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRHSaldos: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 85.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'SALDOS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRHFilial: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoPRHFilialOnBeforePrint'
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'PRODUTOS PARA RETIRAR NA FILIAL  999')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo1: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo2: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo3: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object MasterDataProdutos: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 340.000000000000000000
        Width = 902.400000000000200000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebraProdutosRota: TfrxDMPMemoView
          Align = baClient
          Width = 902.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoPRMCodigo: TfrxDMPMemoView
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."DET_ITEM"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRMLocFis: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."DET_LOCFIS"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRMDescri: TfrxDMPMemoView
          Left = 163.200000000000000000
          Width = 422.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoPRMDescriOnBeforePrint'
          StretchMode = smMaxHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."DET_DESCRI"]')
          ParentFont = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRMUnidade: TfrxDMPMemoView
          Left = 595.200000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."DET_UNIDAD"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRMMarca: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRMQuantidade: TfrxDMPMemoView
          Left = 816.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRMVolume: TfrxDMPMemoView
          Left = 816.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_VOLUME"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRMPesoBruto: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_TOTPES"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRMSaldos: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SALDOS"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object HeaderEmbalagem: TfrxHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 425.000000000000000000
        Width = 902.400000000000200000
        ReprintOnNewPage = True
        StartNewPage = True
        object mmoEHResumo: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO: EMBALAGENS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoEHEmbalagem: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'EMBALAGEM')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoEHQuantidade: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoEHVolume: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VOLUME')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo6: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo7: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo8: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object MasterDataEmabalgem: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 527.000000000000000000
        Width = 902.400000000000200000
        DataSet = frxGenEmb
        DataSetName = 'frxGenEmb'
        RowCount = 0
        object mmoEMEmbalagem: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxGenEmb."DET_UNIDAD"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoEMQuantidade: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxgENeMB."DET_QTDUNI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object FooterProdutosRota: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 374.000000000000000000
        Width = 902.400000000000200000
        object mmoPRFQuantidade: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DET_QTDITE">,MasterDataProdutos)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoPRFTotais: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoPRFVolume: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DET_VOLUME">,MasterDataProdutos)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object DMPMemo5: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoPRFPesoBruto: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DET_TOTPES">,MasterDataProdutos)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
      end
      object HeaderDocumentosRota: TfrxHeader
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 561.000000000000000000
        Width = 902.400000000000200000
        ReprintOnNewPage = True
        StartNewPage = True
        object mmoDRHResumo: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO: DOCUMENTOS DA ROTA')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoDRHNumdoc: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'No. DOC.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHEmpresa: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 51.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'EMP.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHVendedor: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 51.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'VENDEDOR')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHCliente: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 68.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHTotalDoc: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOC')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHValorMercadoria: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR MERC')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHPesoBruto: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'PESO BRT')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHVolume: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 51.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VOLUME')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHFormaPagamento: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FORMA PAGAMENTO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHCondicaoPagamento: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 85.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CONDICAO DE PAGAMENTO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHEndereco: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'ENDERE'#199'O')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHBairro: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BAIRRO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHCEP: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 119.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CEP')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHCidade: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 119.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CIDADE-UF')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHObsFilial: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 119.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'OBS. FILIAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHMensagem: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 883.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'MENSAGENS DO DOCUMENTO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHPalet: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 119.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'PALET')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoDRHDocFat: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DOC. FAT.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo9: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo10: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo11: TfrxDMPMemoView
          Top = 153.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object MasterDataDocumentosRota: TfrxMasterData
        FillType = ftBrush
        Height = 204.000000000000000000
        Top = 748.000000000000000000
        Width = 902.400000000000200000
        DataSet = frxGenDoc
        DataSetName = 'frxGenDoc'
        RowCount = 0
        Stretched = True
        object mmoDRMCodigo: TfrxDMPMemoView
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoDRMCodigoOnBeforePrint'
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '[frxGenDoc."GER_DOCESP"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMEmpresa: TfrxDMPMemoView
          Left = 163.200000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '[frxGenDoc."GER_CODEMP"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMVendedor: TfrxDMPMemoView
          Left = 211.200000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '[frxGenDoc."GER_NOMVEN"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMCliente: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '[frxGenDoc."GER_NOMCLI"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMVolume: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxGenDoc."GER_QTDVOL"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMPesoBruto: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxGenDoc."GER_TOTPES"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMValorMercadoria: TfrxDMPMemoView
          Left = 691.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxGenDoc."GER_TOTMER"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMTotalDoc: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxGenDoc."GER_VLRCON"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMFormaPagamento: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '[frxGenDoc."GER_DESFPG"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMConidcaoPagamento: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 34.000000000000000000
          Width = 508.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoDRMConidcaoPagamentoOnBeforePrint'
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '[frxGenDoc."GER_DESFPG"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMKMInicial: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 34.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            'KM INICIAL: __________________')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMEndereco: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '[frxGenDoc."GER_ENDREF"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMBairro: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '[frxGenDoc."GER_BAICLI"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMCEP: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 68.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '[frxGenDoc."GER_CEPCLI"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMCidade: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 68.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '[frxGenDoc."GER_NOMCID"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMObsFil: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 68.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '[frxGenDoc."OBSFIL"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMKMFinal: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 51.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            'KM FINAL..: __________________')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMMensagem: TfrxDMPMemoView
          ShiftMode = smWhenOverlapped
          Top = 85.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '[frxGenDoc."GER_MEN001"] [frxGenDoc."GER_MEN002"]')
          TruncOutboundText = True
        end
        object mmoDRMPalet: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 68.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '[frxGenDoc."GER_PALET_"]')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMAssinatura: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 170.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA DO CLIENTE')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMDocumento: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 170.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DOCUMENTO DO CLIENTE')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMDataHora: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 170.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMDocFat: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoDRMDocFatOnBeforePrint'
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '____________-__')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMAssinaturaLinha: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '-------------------------------------')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMDocumentoLinha: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 153.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '----------------------')
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRMDataHoraLinha: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 153.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '---------------')
          WordWrap = False
          TruncOutboundText = True
        end
        object linDocumentoRotaFinal: TfrxDMPMemoView
          Top = 187.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
        end
      end
      object FooterDocumentosRota: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 969.000000000000000000
        Width = 902.400000000000200000
        object mmoDRFTotal: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRFTotalDoc: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxGenDoc."GER_VLRCON">,MasterDataDocumentosRota)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRFTotalMercadorias: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxGenDoc."GER_TOTMER">,MasterDataDocumentosRota)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRFTotalPeso: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxGenDoc."GER_TOTPES">,MasterDataDocumentosRota)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoDRFQtdVol: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxGenDoc."GER_QTDVOL">,MasterDataDocumentosRota)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object DMPMemo16: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object HeaderTotalEspecie: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 1020.000000000000000000
        Width = 902.400000000000200000
        ReprintOnNewPage = True
        StartNewPage = True
        object mmoEDHResumo: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'TOTAL POR ESPECIE')
          ParentFont = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo17: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo18: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object MasterDataTotalEspecie: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 1088.000000000000000000
        Width = 902.400000000000200000
        DataSet = frxTotDoc
        DataSetName = 'frxTotDoc'
        RowCount = 0
        object mmoZebraTotalEspecie: TfrxDMPMemoView
          Align = baClient
          Width = 902.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoEDMEspecie: TfrxDMPMemoView
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxTotDoc."GER_ESPDOC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoEDMValor: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotDoc."GER_VLRCON"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object HeaderFormasPagamento: TfrxHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 1122.000000000000000000
        Width = 902.400000000000200000
        ReprintOnNewPage = True
        StartNewPage = True
        object mmoFPHResumo: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO: FORMAS DE PAGAMENTO')
          ParentFont = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoFPHFormaPagamento: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FORMA PAGAMENTO')
          ParentFont = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoFPHTotal: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo12: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo13: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo14: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object MasterDataFormasPagamento: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 1224.000000000000000000
        Width = 902.400000000000200000
        DataSet = frxGenPag
        DataSetName = 'frxGenPag'
        RowCount = 0
        object mmoFPMFormaPagamento: TfrxDMPMemoView
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxGenPag."GER_DESFPG"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoFPMTotal: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxgENpAG."GER_TOTFPG"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object FooterFormasPagamento: TfrxFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 1258.000000000000000000
        Width = 902.400000000000200000
        object mmoFPFTotais: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoFPFTotal: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxGenPag."GER_TOTFPG">,MasterDataFormasPagamento)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoFPFFrete: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoFPFFreteOnBeforePrint'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'FRETE:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoFPFPFrete: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '% FRETE')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoFPFValFrete: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxGenDoc."GER_FRETE_">)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object mmoFPFPerFrete: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxGenDoc."GER_PERFRE">)]%')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object DMPMemo15: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo19: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object HeaderInfoIntens: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1343.000000000000000000
        Width = 902.400000000000200000
        ReprintOnNewPage = True
        StartNewPage = True
        object mmoIIHResumo: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'INFORMACOES DOS ITENS')
          ParentFont = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo20: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object MasterDataInfoItens: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1394.000000000000000000
        Width = 902.400000000000200000
        DataSet = frxGenIte
        DataSetName = 'frxGenIte'
        RowCount = 0
        Stretched = True
        object memoZebraInfoItens: TfrxDMPMemoView
          Align = baClient
          Width = 902.400000000000000000
          Height = 34.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoIIMItem: TfrxDMPMemoView
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxGenIte."ITEM"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoIIMInfo: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxGenIte."DET_INFITE"]')
          ParentFont = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object HeaderCarregamentoCarga: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1445.000000000000000000
        Width = 902.400000000000200000
        KeepChild = True
        ReprintOnNewPage = True
        StartNewPage = True
        object mmoCCHResumo: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'CARREGAMENTO DE CARGA')
          ParentFont = False
          TruncOutboundText = True
        end
        object DMPMemo21: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object MasterDataCarregamentoCarga: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1581.000000000000000000
        Width = 902.400000000000200000
        DataSet = frxCarCar
        DataSetName = 'frxCarCar'
        KeepTogether = True
        RowCount = 0
        object mmoCCMProduto: TfrxDMPMemoView
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxCarCar."DET_DESCRI"]')
          ParentFont = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoCCMMarca: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          Memo.UTF8W = (
            '[frxCarCar."MAR_DESMAR"]')
          TruncOutboundText = True
        end
        object mmoCCMQTDE: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCarCar."DET_QTDITE"]')
          TruncOutboundText = True
        end
        object mmoCCMMetragem: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoCCMMetragemOnBeforePrint'
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            'METRAGEM')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
      end
      object GroupHeaderCarregamentoCarga: TfrxGroupHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 1496.000000000000000000
        Width = 902.400000000000200000
        Condition = 
          '<frxCarCar."GER_NUMDOC"> + <frxCarCar."GER_ESPDOC"> + <frxCarCar' +
          '."GER_CODEMP">'
        KeepTogether = True
        ReprintOnNewPage = True
        object mmoCCGCodigo: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoCCGCliente: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 17.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxCarCar."DET_NOMCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoCCGDocumento: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoCCGNumdoc: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoCCGNumdocOnBeforePrint'
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            
              '[frxCarCar."GER_NUMDOC"] [frxCarCar."GER_ESPDOC"] [frxCarCar."GE' +
              'R_CODEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoCCGData: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoCCGDtaEnt: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxCarCar."GER_DTAENT"]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoCCGProduto: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            'PRODUTO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoCCGMarca: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 34.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoCCGObsFil: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxCarCar."OBSFIL"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoCCGQTDE: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo23: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo22: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object HeaderOutrasEntregas: TfrxHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 1632.000000000000000000
        Width = 902.400000000000200000
        ReprintOnNewPage = True
        StartNewPage = True
        object mmoOEHResumo: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'OUTRAS ENTREGAS')
          ParentFont = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoOEHDescricao: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo24: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo25: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo26: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object MasterDataOutrasEntregas: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 1734.000000000000000000
        Width = 902.400000000000200000
        DataSet = frxOutEnt
        DataSetName = 'frxOutEnt'
        RowCount = 0
        object mmoOEMDescri: TfrxDMPMemoView
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxOutEnt."OUT_DESCRI"]')
          ParentFont = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object ReportSummary: TfrxReportSummary
        FillType = ftBrush
        Height = 306.000000000000000000
        Top = 1785.000000000000000000
        Width = 902.400000000000200000
        Stretched = True
        object mmoSURodape: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 883.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[MSGRO1]')
          ParentFont = False
          TruncOutboundText = True
          Formats = <
            item
            end
            item
            end>
        end
        object mmoSURodape2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 883.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[MSGRO2]')
          ParentFont = False
          TruncOutboundText = True
          Formats = <
            item
            end
            item
            end>
        end
        object mmoSUConferente: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA DO CONFERENTE')
          TruncOutboundText = True
        end
        object mmoSUDataHora1: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 136.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          TruncOutboundText = True
        end
        object mmoSUMotorista: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 204.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA DO MOTORISTA')
          TruncOutboundText = True
        end
        object mmoSURGMotorista: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 204.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            'R.G. DO MOTORISTA')
          TruncOutboundText = True
        end
        object mmoSUDataHora2: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 204.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          TruncOutboundText = True
        end
        object mmoSURodapeFinal: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 221.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          FontStyle = []
          Memo.UTF8W = (
            '[RODROM]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoSUKMInicialFinal: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 255.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          FontStyle = []
          Memo.UTF8W = (
            
              'KM INICIAL ______________________ / KM FINAL ___________________' +
              '___.')
          ParentFont = False
          TruncOutboundText = True
        end
        object DMPMemo27: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoSUConferenteLinha: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            '--------------------------------------')
          TruncOutboundText = True
        end
        object mmoSUDataHora1Linha: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 119.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            '------------------------')
          TruncOutboundText = True
        end
        object mmoSUMotoristaLinha: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            '--------------------------------------')
          TruncOutboundText = True
        end
        object mmoSURGMotoristaLinha: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 187.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            '------------------------')
          TruncOutboundText = True
        end
        object mmoSUDataHora2Linha: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 187.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            '------------------')
          TruncOutboundText = True
        end
        object DMPMemo30: TfrxDMPMemoView
          Top = 289.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object PageFooter: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 2108.000000000000000000
        Width = 902.400000000000200000
        object mmoPFRodape: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'frmFatRotaRomaneio')
          ParentFont = False
          TruncOutboundText = True
        end
        object DMPMemo33: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
    end
    object qckItemCliente: TfrxDMPPage
      PaperWidth = 256.539834318023700000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      RightMargin = 17.779988517090700000
      EndlessHeight = True
      PrintIfEmpty = False
      FontStyle = []
      object PageHeaderItemCliente: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 902.400000000000000000
        object mmoICNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 211.200000000000000000
          Top = 17.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoICNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 201.600000000000000000
          Top = 34.000000000000000000
          Width = 508.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoNomeRelatorioOnBeforePrint'
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'ITENS POR CLIENTE')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoICPagina: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA [Page]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoICEmitido: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 34.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date] [Time]')
          ParentFont = False
          TruncOutboundText = True
        end
        object mmoICNumeroRomaneio: TfrxDMPMemoView
          Align = baCenter
          Left = 192.000000000000000000
          Top = 51.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[ROMANEIO_NUMERO_ROTA]')
          ParentFont = False
          TruncOutboundText = True
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#18#27#77'
        end
      end
      object GroupHeaderItensCliente: TfrxGroupHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 136.000000000000000000
        Width = 902.400000000000000000
        Condition = '<frxGenPg1."DET_CODCLI"> + <frxGenPg1."GER_ENDCLI">'
        object mmoICHNomeCliente: TfrxDMPMemoView
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxGenPg1."DET_NOMCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICHCEP: TfrxDMPMemoView
          Left = 710.400000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            'CEP:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICHCepCli: TfrxDMPMemoView
          Left = 768.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxGenPg1."GER_CEPCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICHFone: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxGenPg1."GER_FONES"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICHEndCli: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxGenPg1."GER_ENDCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICHBairro: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 34.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxGenPg1."GER_BAICLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICHBaiCli: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            'BAIRRO:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICHCidade: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            'CIDADE:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICHNomCid: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 34.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxGenPg1."GER_NOMCID"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICHCodigo: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICHDescriRef: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 68.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            'DESCRICAO/REFERENCIA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICHUnidade: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 68.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICHMarca: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 68.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICHQuantidade: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICHVolume: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VOLUME')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo34: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object MasterDataItensCliente: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.000000000000000000
        Width = 902.400000000000000000
        DataSet = frxGenPg1
        DataSetName = 'frxGenPg1'
        RowCount = 0
        object mmoICMCodigo: TfrxDMPMemoView
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxGenPg1."DET_ITEM"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICMDescriRef: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxGenPg1."DET_DESCRI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICMUnidade: TfrxDMPMemoView
          Left = 556.800000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxGenPg1."DET_UNIDAD"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICMMarca: TfrxDMPMemoView
          Left = 595.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          Memo.UTF8W = (
            '[frxGenPg1."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICMQuantidade: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxGenPg1."DET_QTDITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICMVolume: TfrxDMPMemoView
          Left = 816.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxGenPg1."DET_VOLUME"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 578.000000000000000000
        Width = 902.400000000000000000
        object Memo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'frmFatRotaRomaneio')
          ParentFont = False
          TruncOutboundText = True
        end
        object DMPMemo29: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
      object GroupFooterItensCliente: TfrxGroupFooter
        FillType = ftBrush
        Height = 221.000000000000000000
        Top = 272.000000000000000000
        Width = 902.400000000000000000
        object mmoICFTotais: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICFQuantidade: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxGenPg1."DET_QTDITE">,MasterDataItensCliente)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoICFVolume: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxGenPg1."DET_VOLUME">,MasterDataItensCliente)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoSUICConferente: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA DO CONFERENTE')
          TruncOutboundText = True
        end
        object mmoSUICDataHora1: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 68.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          TruncOutboundText = True
        end
        object mmoSUICMotorista: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERIDO: ASSINATURA DO CLIENTE')
          TruncOutboundText = True
        end
        object mmoSUICRGMotorista: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 153.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            'R.G. DO CLIENTE')
          TruncOutboundText = True
        end
        object mmoSUICDataHora2: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 153.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA')
          TruncOutboundText = True
        end
        object mmoSUICRodapeFinal: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 883.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          FontStyle = []
          Memo.UTF8W = (
            '[RODROM]')
          ParentFont = False
          TruncOutboundText = True
        end
        object DMPMemo35: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoSUICConferenteLinha: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            '--------------------------------------')
          TruncOutboundText = True
        end
        object mmoSUICDataHora1Linha: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 51.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            '---------------------')
          TruncOutboundText = True
        end
        object mmoSUICMotoristaLinha: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            '--------------------------------------')
          TruncOutboundText = True
        end
        object mmoSUICRGMotoristaLinha: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 136.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            '--------------------')
          TruncOutboundText = True
        end
        object mmoSUICDataHora2Linha: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 136.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          HAlign = haCenter
          Memo.UTF8W = (
            '------------------')
          TruncOutboundText = True
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 527.000000000000000000
        Width = 902.400000000000000000
        object mmoFSICTotais: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoFSICQuantidade: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxGenPg1."DET_QTDITE">,MasterDataItensCliente)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object mmoFSICVolume: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxGenPg1
          DataSetName = 'frxGenPg1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxGenPg1."DET_VOLUME">,MasterDataItensCliente)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
          VAlign = vaCenter
        end
        object DMPMemo28: TfrxDMPMemoView
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------------------------')
          TruncOutboundText = True
          VAlign = vaCenter
        end
      end
    end
  end
end
