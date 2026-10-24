object frmModuloRelFatVendasMarkupAnaTin: TfrmModuloRelFatVendasMarkupAnaTin
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 144
  Width = 166
  object frxPaginaAnaTin: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39784.555444155100000000
    ReportOptions.LastChange = 40151.555195312510000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var      '
      '  vr_total_ven, vr_custo_ven: double;'
      '  vr_total_Lin, vr_custo_Lin: double;'
      
        '  vr_total_fin, vr_custo_fin: double;                           ' +
        '                                                      '
      ''
      'procedure rllDescricaoOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If fOpcaoAnalitico = '#39'T'#39' Then'
      
        '       rllDescricao.Text := fRetornaNomeTinta(<frxRelatorio."IDE' +
        'PRO">);  '
      'end;'
      ''
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      
        '    vr_total_ven := vr_total_ven + rllVrTotal.value;            ' +
        '                                                     '
      '    vr_custo_ven := vr_custo_ven + rllVrMedCusDe.value;'
      ''
      
        '    vr_total_Lin := vr_total_Lin + rllVrTotal.value;            ' +
        '                                                     '
      '    vr_custo_Lin := vr_custo_Lin + rllVrMedCusDe.value;'
      '  End;'
      'end;'
      ''
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      
        '    vr_total_ven := fStrToFloat(Formatfloat('#39'0.00'#39', vr_total_ven' +
        '));'
      
        '    vr_custo_ven := fStrToFloat(Formatfloat('#39'0.00'#39', vr_custo_ven' +
        '));      '
      '    If (vr_total_ven <> 0) and (vr_custo_ven <> 0) Then'
      '    Begin'
      '      If <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '        rllVrMargemF1.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_tot' +
        'al_ven  / vr_custo_ven ) *100 )-100)'
      '      Else'
      
        '        rllVrMargemF1.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr_cu' +
        'sto_ven / vr_total_ven ) )*100);'
      '    End'
      '    Else'
      '    Begin'
      '      rllVrMargemF1.text := '#39'0,00'#39';'
      '    End;                      '
      ''
      '    vr_total_fin := vr_total_fin + vr_total_ven;'
      '    vr_custo_fin := vr_custo_fin + vr_custo_ven;'
      ''
      '    vr_total_ven := 0;'
      '    vr_custo_ven := 0;'
      '  end;                  '
      'end;'
      ''
      'procedure ReportSummary1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      '    If (vr_total_fin <> 0) and (vr_custo_fin <> 0) Then'
      '    Begin'
      '      If <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '       rllVrMargemSu.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_tota' +
        'l_fin  / vr_custo_fin ) *100 )-100)  '
      '      Else'
      
        '       rllVrMargemSu.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr_cus' +
        'to_fin / vr_total_fin ) )*100);'
      '    End'
      '    Else'
      '    Begin'
      '      rllVrMargemSu.text := '#39'0,00'#39';'
      '    End;'
      '  End;  '
      'end;'
      ''
      'procedure grhWcpOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  grhWcp.Visible := <frxRelatorio."CODLIN"> <> 0;               ' +
        '         '
      'end;'
      ''
      'procedure mmoCodLinOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  mmoCodLin.Text := fGetDescriLinhaWandaPro;  '
      'end;'
      ''
      'procedure GroupFooter2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  GroupFooter2.Visible := <frxRelatorio."CODLIN"> <> 0;'
      '    '
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      
        '    vr_total_Lin := fStrToFloat(Formatfloat('#39'0.00'#39', vr_total_Lin' +
        '));'
      
        '    vr_custo_Lin := fStrToFloat(Formatfloat('#39'0.00'#39', vr_custo_Lin' +
        '));      '
      '    If (vr_total_Lin <> 0) and (vr_custo_Lin <> 0) Then'
      '    Begin'
      '      If <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '        rllVrMargemLinha.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_' +
        'total_Lin  / vr_custo_Lin ) *100 )-100)'
      '      Else'
      
        '        rllVrMargemLinha.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr' +
        '_custo_Lin / vr_total_Lin ) )*100);'
      '    End'
      '    Else'
      '    Begin'
      '      rllVrMargemLinha.text := '#39'0,00'#39';'
      '    End;                      '
      ''
      '    vr_total_Lin := 0;'
      '    vr_custo_Lin := 0;'
      '  end;                  '
      'end;'
      ''
      'procedure rlbCabecalhoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<Page#> > 1) then'
      '  begin'
      
        '    rlbCabecalho.Visible := False;                              ' +
        '                                             '
      
        '    rllCabecalho.Visible := True;                               ' +
        '                                            '
      '  end;            '
      'end;'
      ''
      'begin'
      '  vr_total_ven := 0;               '
      '  vr_custo_ven := 0;'
      '    '
      '  vr_total_Lin := 0; '
      '  vr_custo_Lin := 0;'
      '    '
      '  vr_total_fin := 0; '
      '  vr_custo_fin := 0;'
      'end.')
    Left = 68
    Top = 19
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Pagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      FontStyle = []
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 629.000000000000000000
        Width = 1507.200000000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllVrEstoque: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          TruncOutboundText = False
        end
        object rllLitrag: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."TOTLIT"> + <frxRelatorio."TOTKIL">]')
          TruncOutboundText = False
        end
        object rllQtde: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          TruncOutboundText = False
        end
        object rllVrTotal: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          TruncOutboundText = False
        end
        object rllVrMedCusDe: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTCUS"]')
          TruncOutboundText = False
        end
        object rllVrMargemDe: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."MARGEM"]')
          TruncOutboundText = False
        end
        object rllVrResultDe: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."TOTITE"> - <frxRelatorio."TOTCUS">]')
          TruncOutboundText = False
        end
        object rllLinhaGroup: TfrxDMPMemoView
          Left = 86.400000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 28.800000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CODVEN'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '-')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 935.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
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
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 493.000000000000000000
        Width = 1507.200000000000000000
        ReprintOnNewPage = True
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR')
          TruncOutboundText = False
        end
        object rllVrEstoq: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.ESTOQ')
          TruncOutboundText = False
        end
        object rllTitLit: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LITROS/KILOS')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          TruncOutboundText = False
        end
        object rllVrMedCus: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[VALOR]')
          TruncOutboundText = False
        end
        object rllVrMargem: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%MARGEM')
          TruncOutboundText = False
        end
        object rllVrResult: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'RESULT.')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 340.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbCabecalhoOnBeforePrint'
        Child = frxPaginaAnaTin.rllCabecalho
        PrintChildIfInvisible = True
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 1305.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1411.200000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 1392.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object rllLinhaGrupoCab: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[LINHA/GRUPO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllProdutoCab: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[PRODUTO]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVendedorCab: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
          TruncOutboundText = False
        end
        object rllFornecedorCab: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
        object rllMarcaCab: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[MARCA]')
          TruncOutboundText = False
        end
        object rllClienteCab: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 170.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
          TruncOutboundText = False
        end
        object rllEmpresaCab: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllClassCab: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 323.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLASS]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllReferenteCab: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 119.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[REFERENTE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#77'
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 170.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TINTA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 221.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[REPRES]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 136.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[UNIDADE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 187.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllAtividade: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ATIVIDADE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllDeptoCab: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 153.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPART]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CIDADE]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 204.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[BAIRRO]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 204.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[REDLOJ]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 221.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPITE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 238.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DESCRICAO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 255.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[REFPRO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllRegiaoCab: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 238.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[REGIAO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 255.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[SUBREG]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 272.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENCLI]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 272.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CUSTO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 289.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CTGCLI]')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 289.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[PRDGRU]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 306.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[SITTRI]')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 306.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TABPRC]')
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 561.000000000000000000
        Width = 1507.200000000000000000
        Condition = 'frxRelatorio."IDEPRO"'
        object rllCodigo: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'IDEPRO'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."IDEPRO"]')
          TruncOutboundText = False
        end
        object rllDescricao: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllDescricaoOnAfterData'
          DataField = 'DESITE'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 585.600000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllDescricaoOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNIDADE: [frxRelatorio."UNIDAD"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 748.000000000000000000
        Width = 1507.200000000000000000
        OnAfterPrint = 'GroupFooter1OnAfterPrint'
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object DMPMemo1: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO GRUPO:')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SALDOS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rllToLit1: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rllVrTotalF1: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baLeft
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object rllVrMedCusF1: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rllVrMargemF1: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllResult1: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes) - SUM(<frxRelatorio."T' +
              'OTCUS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object lblDescLit2: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM LITROS:')
          TruncOutboundText = False
        end
        object rllSumLit2: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object lblDescKil2: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM KILOS:')
          TruncOutboundText = False
        end
        object rllSumKil2: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 850.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        object DMPMemo20: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SALDOS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rllToLit2: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rllVrTotalSu: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rllVrMedCusSu: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rllVrMargemSu: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllResultSu: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes) - SUM(<frxRelatorio."T' +
              'OTCUS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object lblDescLit3: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LITROS:')
          TruncOutboundText = False
        end
        object rllSumLit3: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object lblDescKil3: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL KILOS:')
          TruncOutboundText = False
        end
        object rllSumKil3: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object grhWcp: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 595.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'grhWcpOnBeforePrint'
        Condition = 'frxRelatorio."CODLIN"'
        object mmoCodLin: TfrxDMPMemoView
          Left = 28.800000000000000000
          Width = 547.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoCodLinOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODLIN"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 663.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'GroupFooter2OnBeforePrint'
        object DMPMemo4: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DA LINHA:')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SALDOS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baLeft
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object rllVrMedCusLinha: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rllVrMargemLinha: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes) - SUM(<frxRelatorio."T' +
              'OTCUS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object lblDescLit1: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM LITROS:')
          TruncOutboundText = False
        end
        object rllSumLit1: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object lblDescKil1: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM KILOS:')
          TruncOutboundText = False
        end
        object rllSumKil1: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object rllCabecalho: TfrxChild
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 374.000000000000000000
        Visible = False
        Width = 1507.200000000000000000
        object DMPMemo15: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 1305.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1411.200000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 1392.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxPaginaAnaTinJ: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39784.555444155100000000
    ReportOptions.LastChange = 40276.751619282400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var      '
      '  vr_total_ven, vr_custo_ven: double;'
      
        '  vr_total_fin, vr_custo_fin: double;                           ' +
        '                                                      '
      '  vr_total_Lin, vr_custo_Lin: double;'
      '  '
      'procedure rllDescricaoOnAfterData(Sender: TfrxComponent);'
      'begin'
      
        '  rllDescricao.Text := fRetornaNomeTinta(<frxRelatorio."IDEPRO">' +
        ');  '
      'end;'
      ''
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  GroupFooter2.Visible := <frxRelatorio."CODLIN"> <> 0;'
      '    '
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      
        '    vr_total_ven := vr_total_ven + rllVrTotal.value;            ' +
        '                                                     '
      '    vr_custo_ven := vr_custo_ven + rllVrMedCusDe.value;'
      ''
      
        '    vr_total_Lin := vr_total_Lin + rllVrTotal.value;            ' +
        '                                                     '
      '    vr_custo_Lin := vr_custo_Lin + rllVrMedCusDe.value;'
      '  End;'
      'end;'
      ''
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      
        '    vr_total_ven := fStrToFloat(Formatfloat('#39'0.00'#39', vr_total_ven' +
        '));'
      
        '    vr_custo_ven := fStrToFloat(Formatfloat('#39'0.00'#39', vr_custo_ven' +
        '));      '
      '    If (vr_total_ven <> 0) and (vr_custo_ven <> 0) Then'
      '    Begin'
      '      If <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '        rllVrMargemF1.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_tot' +
        'al_ven  / vr_custo_ven ) *100 )-100)'
      '      Else'
      
        '        rllVrMargemF1.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr_cu' +
        'sto_ven / vr_total_ven ) )*100);'
      '    End'
      '    Else'
      '    Begin'
      '      rllVrMargemF1.text := '#39'0,00'#39';'
      '    End;                      '
      ''
      '    vr_total_fin := vr_total_fin + vr_total_ven;'
      '    vr_custo_fin := vr_custo_fin + vr_custo_ven;'
      ''
      '    vr_total_ven := 0;'
      '    vr_custo_ven := 0;'
      '  end;                  '
      'end;'
      ''
      'procedure ReportSummary1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '    '
      'end;'
      ''
      'procedure ReportSummary1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      '    If (vr_total_fin <> 0) and (vr_custo_fin <> 0) Then'
      '    Begin'
      '      If <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '       rllVrMargemSu.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_tota' +
        'l_fin  / vr_custo_fin ) *100 )-100)  '
      '      Else'
      
        '       rllVrMargemSu.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr_cus' +
        'to_fin / vr_total_fin ) )*100);'
      '    End'
      '    Else'
      '    Begin'
      '      rllVrMargemSu.text := '#39'0,00'#39';'
      '    End;'
      '  End;  '
      'end;'
      ''
      'procedure mmoCodLinOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  mmoCodLin.Text := fGetDescriLinhaWandaPro;  '
      'end;'
      ''
      'procedure GroupFooter2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      
        '    vr_total_Lin := fStrToFloat(Formatfloat('#39'0.00'#39', vr_total_Lin' +
        '));'
      
        '    vr_custo_Lin := fStrToFloat(Formatfloat('#39'0.00'#39', vr_custo_Lin' +
        '));      '
      '    If (vr_total_Lin <> 0) and (vr_custo_Lin <> 0) Then'
      '    Begin'
      '      If <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '        rllVrMargemLinha.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_' +
        'total_Lin  / vr_custo_Lin ) *100 )-100)'
      '      Else'
      
        '        rllVrMargemLinha.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr' +
        '_custo_Lin / vr_total_Lin ) )*100);'
      '    End'
      '    Else'
      '    Begin'
      '      rllVrMargemLinha.text := '#39'0,00'#39';'
      '    End;                      '
      ''
      '    vr_total_Lin := 0;'
      '    vr_custo_Lin := 0;'
      '  end;                  '
      'end;'
      ''
      'procedure grhWcpOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  grhWcp.Visible := <frxRelatorio."CODLIN"> <> 0;  '
      'end;'
      ''
      'procedure rlbCabecalhoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<Page#> > 1) then'
      '  begin'
      
        '    rlbCabecalho.Visible := False;                              ' +
        '                                             '
      
        '    rllCabecalho.Visible := True;                               ' +
        '                                            '
      '  end;            '
      'end;'
      ''
      'begin'
      '  vr_total_ven := 0;               '
      '  vr_custo_ven := 0;'
      ''
      '  vr_total_Lin := 0;               '
      '  vr_custo_Lin := 0;'
      '      '
      '  vr_total_fin := 0; '
      '  vr_custo_fin := 0;'
      'end.')
    Left = 68
    Top = 75
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Pagina: TfrxReportPage
      PaperWidth = 337.819781820000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 668.976810000000000000
        Width = 1201.209399982145000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllVrEstoque: TfrxMemoView
          Left = 501.752690000000000000
          Width = 107.640940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
        end
        object rllLitrag: TfrxMemoView
          Left = 609.214100000000000000
          Width = 122.154360000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."TOTLIT"> + <frxRelatorio."TOTKIL">]')
        end
        object rllQtde: TfrxMemoView
          Left = 732.834570000000000000
          Width = 82.318120000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
        end
        object rllVrTotal: TfrxMemoView
          Left = 819.855040000000000000
          Width = 103.861410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
        end
        object rllVrMedCusDe: TfrxMemoView
          Left = 929.536920000000000000
          Width = 98.040940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTCUS"]')
        end
        object rllVrMargemDe: TfrxMemoView
          Left = 1120.327520000000000000
          Width = 74.759060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."MARGEM"]')
        end
        object rllVrResultDe: TfrxMemoView
          Left = 1031.811690000000000000
          Width = 82.318119999999990000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."TOTITE"> - <frxRelatorio."TOTCUS">]')
        end
        object rllLinhaGroup: TfrxMemoView
          Left = 97.691280000000000000
          Width = 393.751020000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMVEN"]')
        end
        object Memo27: TfrxMemoView
          Left = 45.127520000000000000
          Width = 32.881880000000000000
          Height = 17.000000000000000000
          DataField = 'CODVEN'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
        end
        object Memo28: TfrxMemoView
          Left = 82.270810000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '-')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 30.220470000000000000
        Top = 1024.252630000000000000
        Width = 1201.209399982145000000
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 9.440939999999955000
          Width = 761.877180000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 750.840940000000000000
          Top = 9.440939999999955000
          Width = 444.245640000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 32.102350000000000000
        Top = 525.354670000000000000
        Width = 1201.209399982145000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 7.559060000000000000
          Top = 3.779530000000022000
          Width = 1190.551950000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo11: TfrxMemoView
          Left = 44.976377950000000000
          Top = 5.661409999999933000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR')
        end
        object rllVrEstoq: TfrxMemoView
          Left = 501.752690000000000000
          Top = 5.661410000000046000
          Width = 107.640940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.ESTOQ')
        end
        object Memo17: TfrxMemoView
          Left = 732.834570000000000000
          Top = 5.661410000000046000
          Width = 82.318120000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
        end
        object Memo18: TfrxMemoView
          Left = 819.855040000000000000
          Top = 5.661409999999933000
          Width = 103.861410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
        end
        object rllVrMedCus: TfrxMemoView
          Left = 926.536920000000000000
          Top = 5.661410000000046000
          Width = 101.820470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VALOR]')
          ParentFont = False
        end
        object rllVrMargem: TfrxMemoView
          Left = 1120.327520000000000000
          Top = 5.661409999999933000
          Width = 74.759060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%MARGEM')
        end
        object rllVrResult: TfrxMemoView
          Left = 1031.811690000000000000
          Top = 5.559059999999932000
          Width = 82.318119999999990000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'RESULT.')
        end
        object rllTitLit: TfrxMemoView
          Left = 610.773160000000000000
          Top = 5.661410000000000000
          Width = 122.154360000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LITROS/KILOS')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 363.055142520000000000
        Top = 18.897650000000000000
        Width = 1201.209399982145000000
        OnBeforePrint = 'rlbCabecalhoOnBeforePrint'
        Child = frxPaginaAnaTinJ.rllCabecalho
        PrintChildIfInvisible = True
        object rllNomeEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 1056.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllPagina: TfrxMemoView
          Left = 1018.507050000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 1104.907050000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 1097.045640000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object rllLinhaGrupoCab: TfrxMemoView
          Left = 9.448818900000000000
          Top = 75.590551180000000000
          Width = 566.929133860000000000
          Height = 18.897637795275590000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINHA/GRUPO]')
          ParentFont = False
        end
        object rllProdutoCab: TfrxMemoView
          Left = 9.448818900000000000
          Top = 94.488188976377960000
          Width = 566.929133860000000000
          Height = 18.897637795275590000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PRODUTO]')
          ParentFont = False
          WordWrap = False
        end
        object rllVendedorCab: TfrxMemoView
          Left = 9.448818900000000000
          Top = 113.385826771653500000
          Width = 566.929133860000000000
          Height = 18.897637795275590000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VENDEDOR]')
          ParentFont = False
        end
        object rllFornecedorCab: TfrxMemoView
          Left = 9.448818900000000000
          Top = 132.283464566929100000
          Width = 566.929133860000000000
          Height = 18.897637795275590000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
        end
        object rllMarcaCab: TfrxMemoView
          Left = 9.448818900000000000
          Top = 151.181102362204700000
          Width = 566.929133860000000000
          Height = 18.897637795275590000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
        end
        object rllClienteCab: TfrxMemoView
          Left = 9.448818900000000000
          Top = 170.078740157480300000
          Width = 566.929133860000000000
          Height = 18.897637795275590000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
        end
        object rllEmpresaCab: TfrxMemoView
          Left = 625.512208900000000000
          Top = 94.488188980000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object rllClassCab: TfrxMemoView
          Left = 8.559060000000000000
          Top = 340.377974720000000000
          Width = 1182.992523860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLASS]')
          ParentFont = False
        end
        object rllReferenteCab: TfrxMemoView
          Left = 625.512208900000000000
          Top = 113.385826770000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[REFERENTE]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 625.512208900000000000
          Top = 170.078740160000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TINTA]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 9.448818900000000000
          Top = 226.771653540000000000
          Width = 566.929133860000000000
          Height = 18.897637795275590000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[REPRES]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 625.512208900000000000
          Top = 132.283464570000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[UNIDADE]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 625.512208900000000000
          Top = 188.976377950000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPEMP]')
          ParentFont = False
        end
        object rllAtividade: TfrxMemoView
          Left = 625.512208900000000000
          Top = 75.590551180000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ATIVIDADE]')
          ParentFont = False
        end
        object rllDeptoCab: TfrxMemoView
          Left = 625.512208900000000000
          Top = 151.181102360000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPART]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 9.448818900000000000
          Top = 188.976377952755900000
          Width = 566.929133860000000000
          Height = 18.897637795275590000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 9.448818900000000000
          Top = 207.874015750000000000
          Width = 566.929133860000000000
          Height = 18.897637795275590000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BAIRRO]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 625.512208900000000000
          Top = 207.874015750000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[REDLOJ]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 625.512208900000000000
          Top = 226.771653540000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPITE]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 625.512208900000000000
          Top = 245.669291340000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DESCRICAO]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 625.512208900000000000
          Top = 264.566929130000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[REFPRO]')
          ParentFont = False
        end
        object rllRegiaoCab: TfrxMemoView
          Left = 9.448818900000000000
          Top = 245.669291338582700000
          Width = 566.929133860000000000
          Height = 18.897637795275590000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[REGIAO]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 9.448818900000000000
          Top = 264.566929130000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SUBREG]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 9.448818900000000000
          Top = 283.464566930000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VENCLI]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 625.512208900000000000
          Top = 283.464566930000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CUSTO]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 8.559060000000000000
          Top = 302.362400000000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CTGCLI]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 625.622450000000000000
          Top = 302.362400000000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[PRDGRU]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 8.559060000000000000
          Top = 321.260050000000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SITTRI]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 625.333333330000000000
          Top = 321.260050000000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TABPRC]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 20.779530000000000000
        Top = 582.047620000000000000
        Width = 1201.209399982145000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxRelatorio."IDEPRO"'
        object Memo4: TfrxMemoView
          Left = 510.236550000000000000
          Width = 263.433210000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNIDADE: [frxRelatorio."UNIDAD"]')
        end
        object rllCodigo: TfrxMemoView
          Left = 9.600000000000000000
          Width = 50.343290000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."IDEPRO"]')
        end
        object rllDescricao: TfrxMemoView
          Left = 61.779530000000000000
          Width = 441.373160000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllDescricaoOnAfterData'
          DataField = 'DESITE'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 75.574830000000000000
        Top = 805.039890000000000000
        Width = 1201.209399982145000000
        OnAfterPrint = 'GroupFooter1OnAfterPrint'
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object Memo1: TfrxMemoView
          Left = 336.295980000000000000
          Top = 5.000000000000000000
          Width = 155.338590000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO GRUPO:')
        end
        object Memo7: TfrxMemoView
          Left = 501.752690000000000000
          Top = 5.000000000000000000
          Width = 107.640940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SALDOS">,rlbDetalhes)]')
        end
        object rllToLit1: TfrxMemoView
          Left = 609.214100000000000000
          Top = 5.000000000000000000
          Width = 122.154360000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object Memo9: TfrxMemoView
          Left = 732.834570000000000000
          Top = 5.000000000000000000
          Width = 82.318120000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
        end
        object rllVrTotalF1: TfrxMemoView
          Left = 819.855040000000000000
          Top = 5.000000000000000000
          Width = 103.861410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
        end
        object Line3: TfrxLineView
          Align = baLeft
          Top = 0.720469999999977500
          Width = 1198.866110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllVrMedCusF1: TfrxMemoView
          Left = 929.536920000000000000
          Top = 5.000000000000000000
          Width = 98.040940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
        end
        object rllVrMargemF1: TfrxMemoView
          Left = 1120.327520000000000000
          Top = 5.000000000000000000
          Width = 74.759060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object rllResult1: TfrxMemoView
          Left = 1031.929810000000000000
          Top = 5.000000000000000000
          Width = 82.318119999999990000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes) - SUM(<frxRelatorio."T' +
              'OTCUS">,rlbDetalhes)]')
        end
        object lblDescLit2: TfrxMemoView
          Left = 336.937230000000000000
          Top = 25.456710000000040000
          Width = 155.338590000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM LITROS:')
        end
        object rllSumLit2: TfrxMemoView
          Left = 609.855350000000000000
          Top = 25.456710000000040000
          Width = 122.154360000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
        end
        object lblDescKil2: TfrxMemoView
          Left = 336.937230000000000000
          Top = 46.133889999999950000
          Width = 155.338590000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM KILOS:')
        end
        object rllSumKil2: TfrxMemoView
          Left = 609.855350000000000000
          Top = 46.133889999999950000
          Width = 122.154360000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
        end
        object Line5: TfrxLineView
          Align = baCenter
          Left = 4.951174991072300000
          Top = 68.252010000000040000
          Width = 1191.307050000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 60.456710000000000000
        Top = 941.102970000000000000
        Width = 1201.209399982145000000
        OnAfterPrint = 'ReportSummary1OnAfterPrint'
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        object Memo20: TfrxMemoView
          Left = 343.547990000000000000
          Top = 4.000000000000000000
          Width = 152.692950000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
        end
        object Memo21: TfrxMemoView
          Left = 501.752690000000000000
          Top = 4.000000000000000000
          Width = 107.640940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SALDOS">,rlbDetalhes)]')
        end
        object rllToLit2: TfrxMemoView
          Left = 615.214100000000000000
          Top = 4.000000000000000000
          Width = 107.036240000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object Memo23: TfrxMemoView
          Left = 727.834570000000000000
          Top = 4.000000000000000000
          Width = 82.318120000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
        end
        object rllVrTotalSu: TfrxMemoView
          Left = 819.855040000000000000
          Top = 4.000000000000000000
          Width = 103.861410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
        end
        object rllVrMedCusSu: TfrxMemoView
          Left = 929.536920000000000000
          Top = 4.000000000000000000
          Width = 98.040940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
        end
        object rllVrMargemSu: TfrxMemoView
          Left = 1120.327520000000000000
          Top = 4.000000000000000000
          Width = 74.759060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object rllResultSu: TfrxMemoView
          Left = 1031.929810000000000000
          Top = 4.000000000000000000
          Width = 82.318119999999990000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes) - SUM(<frxRelatorio."T' +
              'OTCUS">,rlbDetalhes)]')
        end
        object Line2: TfrxLineView
          Align = baLeft
          Top = 1.779529999999909000
          Width = 1198.866110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object lblDescLit3: TfrxMemoView
          Left = 343.409710000000000000
          Top = 23.456710000000040000
          Width = 152.692950000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LITROS:')
        end
        object rllSumLit3: TfrxMemoView
          Left = 616.075820000000000000
          Top = 23.456710000000040000
          Width = 107.036240000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
        end
        object lblDescKil3: TfrxMemoView
          Left = 343.409710000000000000
          Top = 43.354360000000040000
          Width = 152.692950000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL KILOS:')
        end
        object rllSumKil3: TfrxMemoView
          Left = 615.075820000000000000
          Top = 43.354360000000040000
          Width = 107.036240000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 71.811070000000000000
        Top = 710.551640000000000000
        Width = 1201.209399982145000000
        OnBeforePrint = 'GroupFooter2OnBeforePrint'
        object Memo5: TfrxMemoView
          Left = 335.937230000000000000
          Top = 4.000000000000000000
          Width = 155.338590000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DA LINHA:')
        end
        object Memo8: TfrxMemoView
          Left = 501.393940000000000000
          Top = 4.000000000000000000
          Width = 107.640940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SALDOS">,rlbDetalhes)]')
        end
        object Memo14: TfrxMemoView
          Left = 608.855350000000000000
          Top = 4.000000000000000000
          Width = 122.154360000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object Memo16: TfrxMemoView
          Left = 732.475820000000000000
          Top = 4.000000000000000000
          Width = 82.318120000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
        end
        object Memo19: TfrxMemoView
          Left = 819.496290000000000000
          Width = 103.861410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
        end
        object rllVrMedCusLinha: TfrxMemoView
          Left = 929.178170000000000000
          Top = 4.000000000000000000
          Width = 98.040940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
        end
        object rllVrMargemLinha: TfrxMemoView
          Left = 1119.968770000000000000
          Top = 4.000000000000000000
          Width = 74.759060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object Memo25: TfrxMemoView
          Left = 1031.571060000000000000
          Top = 4.000000000000000000
          Width = 82.318119999999990000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes) - SUM(<frxRelatorio."T' +
              'OTCUS">,rlbDetalhes)]')
        end
        object Line1: TfrxLineView
          Align = baLeft
          Width = 1198.866110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object lblDescLit1: TfrxMemoView
          Left = 335.937230000000000000
          Top = 22.677180000000020000
          Width = 155.338590000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM LITROS:')
        end
        object rllSumLit1: TfrxMemoView
          Left = 609.855350000000000000
          Top = 22.677180000000020000
          Width = 122.154360000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
        end
        object lblDescKil1: TfrxMemoView
          Left = 335.937230000000000000
          Top = 41.574830000000020000
          Width = 155.338590000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM KILOS:')
        end
        object rllSumKil1: TfrxMemoView
          Left = 609.855350000000000000
          Top = 41.574830000000020000
          Width = 122.154360000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
        end
        object Line4: TfrxLineView
          Align = baCenter
          Left = 4.951174991072300000
          Top = 62.692950000000000000
          Width = 1191.307050000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object grhWcp: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 627.401980000000000000
        Width = 1201.209399982145000000
        OnBeforePrint = 'grhWcpOnBeforePrint'
        Condition = 'frxRelatorio."CODLIN"'
        object mmoCodLin: TfrxMemoView
          Left = 26.456710000000000000
          Top = 0.779530000000022500
          Width = 416.428200000000000000
          Height = 16.629921260000000000
          OnBeforePrint = 'mmoCodLinOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODLIN"]')
        end
      end
      object rllCabecalho: TfrxChild
        FillType = ftBrush
        Height = 60.472438500000000000
        Top = 404.409710000000000000
        Visible = False
        Width = 1201.209399982145000000
        object Memo15: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000022000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 7.559060000000000000
          Top = 20.779530000000020000
          Width = 1056.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object Memo26: TfrxMemoView
          Left = 1016.466110000000000000
          Top = 20.779530000000020000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Memo29: TfrxMemoView
          Left = 1102.866110000000000000
          Top = 37.779530000000030000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Memo30: TfrxMemoView
          Left = 7.559060000000000000
          Top = 37.779530000000030000
          Width = 1097.045640000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
      end
    end
  end
end
