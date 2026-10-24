object frmModuloRelFatVendasMarkup: TfrmModuloRelFatVendasMarkup
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 141
  Width = 168
  object frxPagina: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43227.348780682870000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  vr_total_gru, vr_custo_gru : double;'
      '  vr_total_lin, vr_custo_lin : double;'
      '  vr_total_fin, vr_custo_fin : double;      '
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      '      '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure GroupFooter2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      
        '    vr_total_gru := fStrToFloat(Formatfloat('#39'0.00'#39', vr_total_gru' +
        '));'
      
        '    vr_custo_gru := fStrToFloat(Formatfloat('#39'0.00'#39', vr_custo_gru' +
        '));      '
      '    If (vr_total_gru <> 0) and (vr_custo_gru <> 0) Then'
      '    Begin'
      '      if <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '        rllVrMargemF2.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_tot' +
        'al_gru  / vr_custo_gru ) *100 )-100)'
      '      Else'
      
        '        rllVrMargemF2.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr_cu' +
        'sto_gru / vr_total_gru ) )*100);'
      '    End  '
      '    Else'
      '    Begin          '
      '      rllVrMargemF2.text := '#39'0,00'#39';'
      
        '    End;                                                        ' +
        '                       '
      ''
      '    vr_total_lin := vr_total_lin + vr_total_gru;'
      '    vr_custo_lin := vr_custo_lin + vr_custo_gru;'
      ''
      '    vr_total_gru := 0;'
      '    vr_custo_gru := 0;'
      '  End;                  '
      'end;'
      ''
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin    '
      
        '    vr_total_gru := vr_total_gru + rllVrTotal.value;            ' +
        '                                                  '
      '    vr_custo_gru := vr_custo_gru + rllVrMedCusDe.value;'
      '  End;                  '
      'end;'
      ''
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      
        '    vr_total_lin := fStrToFloat(Formatfloat('#39'0.00'#39', vr_total_lin' +
        '));'
      
        '    vr_custo_lin := fStrToFloat(Formatfloat('#39'0.00'#39', vr_custo_lin' +
        '));      '
      '    If (vr_total_lin <> 0) and (vr_custo_lin <> 0) Then'
      '    Begin'
      '      if <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '        rllVrMargemF1.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_tot' +
        'al_lin  / vr_custo_lin ) *100 )-100)  '
      '      Else'
      
        '        rllVrMargemF1.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr_cu' +
        'sto_lin / vr_total_lin ) )*100);'
      '    End'
      '    Else'
      '    Begin'
      '      rllVrMargemF1.text := '#39'0,00'#39';'
      '    End;  '
      ''
      '    vr_total_fin := vr_total_fin + vr_total_lin;'
      '    vr_custo_fin := vr_custo_fin + vr_custo_lin;'
      '       '
      '    vr_total_lin := 0;'
      '    vr_custo_lin := 0;'
      '  End;                  '
      'end;'
      ''
      'procedure ReportSummary1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      
        '    vr_total_fin := fStrToFloat(Formatfloat('#39'0.00'#39', vr_total_fin' +
        '));'
      
        '    vr_custo_fin := fStrToFloat(Formatfloat('#39'0.00'#39', vr_custo_fin' +
        '));      '
      '    If (vr_total_fin <> 0) and (vr_custo_fin <> 0) Then'
      '    Begin'
      '      if <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '       rllVrMargemSu.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_tota' +
        'l_fin  / vr_custo_fin ) *100 )-100)  '
      '      Else'
      
        '       rllVrMargemSu.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr_cus' +
        'to_fin / vr_total_fin ) )*100);'
      '    End'
      '    Else'
      '    Begin'
      '      rllVrMargemSu.Text := '#39'0,00'#39';'
      '    End;                                '
      '  End;                         '
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
      '  vr_total_gru := 0;'
      '  vr_custo_gru := 0;'
      '  vr_total_lin := 0;'
      '  vr_custo_lin := 0;'
      '  vr_total_fin := 0;'
      '  vr_custo_fin := 0;  '
      'end.')
    Left = 69
    Top = 16
    Datasets = <
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
    object qckPagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = []
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 663.000000000000000000
        Width = 1507.200000000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllCodigo: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'CODITE'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDescricao: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'DESITE'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          TruncOutboundText = False
        end
        object rllReferencia: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'REFERE'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllFornecedor: TfrxDMPMemoView
          Left = 556.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataField = 'CODFOR'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODFOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrEstoque: TfrxDMPMemoView
          Left = 672.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLitrag: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."TOTLIT"> + <frxRelatorio."TOTKIL">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllQtde: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrTotal: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrMedCusDe: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTCUS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrMargemDe: TfrxDMPMemoView
          Left = 1440.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."MARGEM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrResultDe: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."TOTITE"> - <frxRelatorio."TOTCUS">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 969.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
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
        Top = 510.000000000000000000
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
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
          TruncOutboundText = False
        end
        object Memo12: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFERENCIA')
          TruncOutboundText = False
        end
        object Memo14: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORNEC')
          TruncOutboundText = False
        end
        object rllVrEstoq: TfrxDMPMemoView
          Left = 672.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.ESTOQ')
          TruncOutboundText = False
        end
        object rllTitLit: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LTS/KGS')
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
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[VALOR]')
          TruncOutboundText = False
        end
        object rllVrMargem: TfrxDMPMemoView
          Left = 1440.000000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MARGEM')
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
        object DMPMemo4: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UN.')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 357.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbCabecalhoOnBeforePrint'
        Child = frxPagina.rllCabecalho
        PrintChildIfInvisible = True
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
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
          Top = 340.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[CLASS]')
          ParentFont = False
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
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 221.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REPRES]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 153.000000000000000000
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
        object DMPMemo24: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 170.000000000000000000
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
        object rlbDeptoCab: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 136.000000000000000000
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
        object DMPMemo12: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CIDADE]')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 204.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[BAIRRO]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 187.000000000000000000
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
          Top = 204.000000000000000000
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
        object DMPMemo34: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 221.000000000000000000
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
        object DMPMemo35: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 238.000000000000000000
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
          Memo.UTF8W = (
            '[REGIAO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 255.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SUBREG]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 255.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[VENCLI]')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 272.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CUSTO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 272.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[CTGCLI]')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 289.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[PRDGRU]')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 289.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[GERENT]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 306.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[SUBGER]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 323.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[SITTRI]')
          WordWrap = False
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
        Top = 578.000000000000000000
        Width = 1507.200000000000000000
        Condition = 'frxRelatorio."LINHA"'
        object rllLinhaGroup: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 672.000000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMLIN'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMLIN"]')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Linha:')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'LINHA'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."LINHA"]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '-')
          TruncOutboundText = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 612.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'GroupHeader2OnBeforePrint'
        Condition = 'frxRelatorio."GRUPO"'
        object rllGrupoGroup: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'GRUPO'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."GRUPO"]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Grupo:')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 172.800000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '-')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataField = 'DESGRU'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESGRU"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 782.000000000000000000
        Width = 1507.200000000000000000
        OnAfterPrint = 'GroupFooter1OnAfterPrint'
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object DMPMemo1: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DA LINHA:')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 643.200000000000000000
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
          Left = 777.600000000000000000
          Width = 134.400000000000000000
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
          Width = 134.400000000000000000
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
          Left = 1440.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllResult1: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
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
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM LITROS:')
          TruncOutboundText = False
        end
        object rllSumLit2: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM KILOS:')
          TruncOutboundText = False
        end
        object rllSumKil2: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
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
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 697.000000000000000000
        Width = 1507.200000000000000000
        OnAfterPrint = 'GroupFooter2OnAfterPrint'
        OnBeforePrint = 'GroupFooter2OnBeforePrint'
        object DMPMemo2: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO GRUPO:')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 643.200000000000000000
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
          Left = 777.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
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
        object rllVrTotalF2: TfrxDMPMemoView
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
        object rllVrMedCusF2: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rllVrMargemF2: TfrxDMPMemoView
          Left = 1440.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllResult2: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
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
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM LITROS:')
          TruncOutboundText = False
        end
        object lblDescKil1: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 34.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM KILOS:')
          TruncOutboundText = False
        end
        object rllSumLit1: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rllSumKil1: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
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
        Top = 884.000000000000000000
        Width = 1507.200000000000000000
        OnAfterPrint = 'ReportSummary1OnAfterPrint'
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        object DMPMemo20: TfrxDMPMemoView
          Left = 480.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SALDOS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rllToLit3: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 134.400000000000000000
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
          Width = 134.400000000000000000
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
          Left = 1440.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllResultSu: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
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
          Left = 480.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LITROS:')
          TruncOutboundText = False
        end
        object rllSumLit3: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 480.000000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL KILOS:')
          TruncOutboundText = False
        end
        object rllSumKil3: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
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
        Top = 391.000000000000000000
        Visible = False
        Width = 1507.200000000000000000
        object DMPMemo15: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 1305.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
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
        object DMPMemo31: TfrxDMPMemoView
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
        object DMPMemo32: TfrxDMPMemoView
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
  object frxPaginaJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40151.477606145800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var                               '
      '  vr_total_gru, vr_custo_gru : double;'
      '  vr_total_lin, vr_custo_lin : double;'
      '  vr_total_fin, vr_custo_fin : double;      '
      '    '
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      
        '    vr_total_gru := vr_total_gru + rllVrTotal.value;            ' +
        '                                                     '
      '    vr_custo_gru := vr_custo_gru + rllVrMedCusDe.value;'
      '  End;                      '
      'end;'
      ''
      'procedure GroupFooter2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      
        '    vr_total_gru := fStrToFloat(Formatfloat('#39'0.00'#39', vr_total_gru' +
        '));'
      
        '    vr_custo_gru := fStrToFloat(Formatfloat('#39'0.00'#39', vr_custo_gru' +
        '));      '
      '    If (vr_total_gru <> 0) and (vr_custo_gru <> 0) Then'
      '    Begin'
      '      if <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '        rllVrMargemF2.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_tot' +
        'al_gru  / vr_custo_gru ) *100 )-100)'
      '      Else'
      
        '        rllVrMargemF2.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr_cu' +
        'sto_gru / vr_total_gru ) )*100);'
      '    End'
      '    Else'
      '    Begin          '
      '      rllVrMargemF2.text := '#39'0,00'#39';'
      '    End;                      '
      ''
      '    vr_total_lin := vr_total_lin + vr_total_gru;'
      '    vr_custo_lin := vr_custo_lin + vr_custo_gru;'
      ''
      '    vr_total_gru := 0;'
      '    vr_custo_gru := 0;'
      '  End;                    '
      'end;'
      '  '
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      
        '    vr_total_lin := fStrToFloat(Formatfloat('#39'0.00'#39', vr_total_lin' +
        '));'
      
        '    vr_custo_lin := fStrToFloat(Formatfloat('#39'0.00'#39', vr_custo_lin' +
        '));      '
      '    If (vr_total_lin <> 0) and (vr_custo_lin <> 0) Then'
      '    Begin'
      '      if <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '        rllVrMargemF1.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_tot' +
        'al_lin  / vr_custo_lin ) *100 )-100)'
      '      Else'
      
        '        rllVrMargemF1.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr_cu' +
        'sto_lin / vr_total_lin ) )*100);'
      '    End'
      '    Else'
      '    Begin'
      '      rllVrMargemF1.text := '#39'0,00'#39';'
      '    End;                      '
      ''
      '    vr_total_fin := vr_total_fin + vr_total_lin;'
      '    vr_custo_fin := vr_custo_fin + vr_custo_lin;'
      ''
      '    vr_total_lin := 0;'
      '    vr_custo_lin := 0;  '
      '  End;                       '
      'end;'
      ''
      'procedure ReportSummary1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      
        '    vr_total_fin := fStrToFloat(Formatfloat('#39'0.00'#39', vr_total_fin' +
        '));'
      
        '    vr_custo_fin := fStrToFloat(Formatfloat('#39'0.00'#39', vr_custo_fin' +
        '));      '
      '    If (vr_total_fin <> 0) and (vr_custo_fin <> 0) Then'
      '    Begin'
      '      if <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
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
      '    '
      'end;'
      '  '
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
      '  vr_total_gru := 0;'
      '  vr_custo_gru := 0;'
      '  vr_total_lin := 0;'
      '  vr_custo_lin := 0;'
      '  vr_total_fin := 0;'
      '  vr_custo_fin := 0;  '
      'end.          ')
    Left = 68
    Top = 73
    Datasets = <
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
    object qckPagina: TfrxReportPage
      PaperWidth = 337.800000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnAfterPrint = 'qckPaginaOnAfterPrint'
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 691.653990000000000000
        Width = 1201.134634000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllCodigo: TfrxMemoView
          Left = 6.803149610000000000
          Width = 63.496065430000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rllDescricao: TfrxMemoView
          Left = 76.759060000000000000
          Width = 260.031488740000000000
          Height = 17.007874020000000000
          StretchMode = smMaxHeight
          DataField = 'DESITE'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          ParentFont = False
        end
        object rllReferencia: TfrxMemoView
          Left = 343.559055120000000000
          Width = 104.314960630000000000
          Height = 17.007874020000000000
          DataField = 'REFERE'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          ParentFont = False
          WordWrap = False
        end
        object rllFornecedor: TfrxMemoView
          Left = 454.338536300000000000
          Width = 73.020470000000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODFOR"]')
          ParentFont = False
          WordWrap = False
        end
        object rllVrEstoque: TfrxMemoView
          Left = 571.488188980000000000
          Width = 97.511808580000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          ParentFont = False
          WordWrap = False
        end
        object rllLitrag: TfrxMemoView
          Left = 673.716535430000000000
          Width = 76.724421650000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."TOTLIT"> + <frxRelatorio."TOTKIL">]')
          ParentFont = False
          WordWrap = False
        end
        object rllQtde: TfrxMemoView
          Left = 752.834645670000000000
          Width = 80.125994020000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rllVrTotal: TfrxMemoView
          Left = 834.834599290000000000
          Width = 108.850393700000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rllVrMedCusDe: TfrxMemoView
          Left = 948.787401570000000000
          Width = 97.511808580000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTCUS"]')
          ParentFont = False
          WordWrap = False
        end
        object rllVrMargemDe: TfrxMemoView
          Left = 1133.984251970000000000
          Width = 61.228336690000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."MARGEM"]')
          ParentFont = False
          WordWrap = False
        end
        object rllVrResultDe: TfrxMemoView
          Left = 1050.614173230000000000
          Width = 79.370078740000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."TOTITE"> - <frxRelatorio."TOTCUS">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 532.913730000000000000
          Width = 35.225170000000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 26.440940000000000000
        Top = 1031.811690000000000000
        Width = 1201.134634000000000000
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 5.000000000000000000
          Width = 754.318120000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 744.400000000000000000
          Top = 5.000000000000000000
          Width = 451.804700000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 32.102350000000000000
        Top = 548.031850000000000000
        Width = 1201.134634000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 3.779530000000000000
          Top = 3.338589999999954000
          Width = 1194.331480000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo10: TfrxMemoView
          Left = 6.803149610000000000
          Top = 6.669291340000000000
          Width = 63.496065430000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'COD')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 77.497650000000000000
          Top = 6.669291340000000000
          Width = 84.661410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 343.559055120000000000
          Top = 6.669291339999972000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFERENCIA')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 454.338536300000000000
          Top = 6.669291339999972000
          Width = 73.020470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORNEC')
          ParentFont = False
        end
        object rllVrEstoq: TfrxMemoView
          Left = 571.488188980000000000
          Top = 6.669291339999972000
          Width = 97.511808580000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.ESTOQ')
          ParentFont = False
        end
        object rllTitLit: TfrxMemoView
          Left = 673.716535430000000000
          Top = 6.669291339999972000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'LTS/KGS')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 752.834645670000000000
          Top = 6.669291339999972000
          Width = 80.125994020000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 834.834599290000000000
          Top = 6.669291339999972000
          Width = 108.850393700000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          ParentFont = False
        end
        object rllVrMedCus: TfrxMemoView
          Left = 946.787401570000000000
          Top = 6.669291339999972000
          Width = 105.070868580000000000
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
          Left = 1136.984251970000000000
          Top = 6.669291339999972000
          Width = 61.228336690000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '%MARG.')
          ParentFont = False
        end
        object rllVrResult: TfrxMemoView
          Left = 1054.614173230000000000
          Top = 6.559060000000045000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'RESULT.')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 532.913730000000000000
          Top = 6.803149609999991000
          Width = 35.225170000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN.')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 376.230973570000000000
        Top = 18.897650000000000000
        Width = 1201.134634000000000000
        OnBeforePrint = 'rlbCabecalhoOnBeforePrint'
        Child = frxPaginaJ.rllCabecalho
        PrintChildIfInvisible = True
        object rllNomeEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 5.000000000000000000
          Width = 1185.486580000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
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
          Top = 23.000000000000000000
          Width = 1014.425170000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 1022.286580000000000000
          Top = 23.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 1108.686580000000000000
          Top = 42.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 9.600000000000000000
          Top = 42.000000000000000000
          Width = 1100.825170000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object rllLinhaGrupoCab: TfrxMemoView
          Left = 9.448818900000000000
          Top = 66.590551180000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
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
          Top = 85.488188980000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
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
          Top = 104.385826770000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
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
          Top = 123.283464570000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
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
          Top = 142.181102360000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
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
          Top = 161.078740160000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
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
          Left = 627.291738900000000000
          Top = 85.488188980000000000
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
          Left = 9.338590000000000000
          Top = 352.220472440000000000
          Width = 1185.595800530000000000
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
          Left = 627.291738900000000000
          Top = 104.385826770000000000
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
        object Memo6: TfrxMemoView
          Left = 9.448818900000000000
          Top = 217.771653540000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
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
        object Memo22: TfrxMemoView
          Left = 627.291738900000000000
          Top = 142.181102360000000000
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
        object Memo24: TfrxMemoView
          Left = 627.291738900000000000
          Top = 161.078740160000000000
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
          Left = 627.291738900000000000
          Top = 66.590551180000000000
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
        object rlbDeptoCab: TfrxMemoView
          Left = 627.291738900000000000
          Top = 123.283464570000000000
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
        object Memo13: TfrxMemoView
          Left = 9.448818900000000000
          Top = 179.976377950000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
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
        object Memo16: TfrxMemoView
          Left = 9.448818900000000000
          Top = 198.874015750000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
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
        object Memo19: TfrxMemoView
          Left = 627.291738900000000000
          Top = 179.976377950000000000
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
          Left = 627.291738900000000000
          Top = 198.874015750000000000
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
        object rllDescricaoCab: TfrxMemoView
          Left = 627.291738900000000000
          Top = 217.771653540000000000
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
        object rllReferenciaCab: TfrxMemoView
          Left = 627.291738900000000000
          Top = 236.669291340000000000
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
          Left = 9.338590000000000000
          Top = 236.669291340000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
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
        object Memo36: TfrxMemoView
          Left = 9.338590000000000000
          Top = 255.566929130000000000
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
          Left = 627.291738900000000000
          Top = 255.566929130000000000
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
            '[VENCLI]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 9.338590000000000000
          Top = 274.464566930000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CUSTO]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 627.291738900000000000
          Top = 274.464566930000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CTGCLI]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 627.291738900000000000
          Top = 313.322834650000000000
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
        object Memo41: TfrxMemoView
          Left = 9.338590000000000000
          Top = 293.803340000000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GERENT]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 627.291738900000000000
          Top = 293.803340000000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUBGER]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 9.338590000000000000
          Top = 313.322834650000000000
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
        object Memo44: TfrxMemoView
          Left = 9.338590000000000000
          Top = 333.102350000000000000
          Width = 566.929133860000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TABPRC]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 20.779530000000000000
        Top = 604.724800000000000000
        Width = 1201.134634000000000000
        Condition = 'frxRelatorio."LINHA"'
        object rllLinhaGroup: TfrxMemoView
          Left = 122.600000000000000000
          Width = 1057.512060000000000000
          Height = 17.000000000000000000
          DataField = 'NOMLIN'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMLIN"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 7.448818900000000000
          Width = 38.702350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Linha:')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 51.800000000000000000
          Width = 55.559060000000000000
          Height = 17.000000000000000000
          DataField = 'LINHA'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."LINHA"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 109.400000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '-')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.881880000000000000
        Top = 650.079160000000000000
        Width = 1201.134634000000000000
        OnBeforePrint = 'GroupHeader2OnBeforePrint'
        Condition = 'frxRelatorio."GRUPO"'
        object rllGrupoGroup: TfrxMemoView
          Left = 95.200000000000000000
          Width = 51.779530000000000000
          Height = 17.000000000000000000
          DataField = 'GRUPO'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."GRUPO"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 48.000000000000000000
          Width = 42.481880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Grupo:')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 150.800000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '-')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 166.000000000000000000
          Width = 977.915090000000000000
          Height = 17.000000000000000000
          DataField = 'DESGRU'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESGRU"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 68.015770000000000000
        Top = 823.937540000000000000
        Width = 1201.134634000000000000
        OnAfterPrint = 'GroupFooter1OnAfterPrint'
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object Memo1: TfrxMemoView
          Left = 415.291292200000000000
          Width = 132.661410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DA LINHA:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 571.488188980000000000
          Width = 97.511808580000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SALDOS">,rlbDetalhes)]')
          ParentFont = False
        end
        object rllToLit2: TfrxMemoView
          Left = 673.716535430000000000
          Width = 76.724421650000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 752.834645670000000000
          Width = 80.125994020000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
          ParentFont = False
        end
        object rllVrTotalF1: TfrxMemoView
          Left = 834.984205590000000000
          Width = 108.850393700000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baCenter
          Left = 3.024027000000000000
          Top = 57.500000000000000000
          Width = 1195.086580000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllVrMedCusF1: TfrxMemoView
          Left = 948.787401570000000000
          Width = 97.511808580000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
          ParentFont = False
        end
        object rllVrMargemF1: TfrxMemoView
          Left = 1133.984251970000000000
          Width = 61.228336690000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllResult1: TfrxMemoView
          Left = 1050.614173230000000000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes) - SUM(<frxRelatorio."T' +
              'OTCUS">,rlbDetalhes)]')
          ParentFont = False
        end
        object lblDescLit2: TfrxMemoView
          Left = 415.850650000000000000
          Top = 18.897650000000000000
          Width = 132.661410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM LITROS:')
          ParentFont = False
        end
        object rllSumLit2: TfrxMemoView
          Left = 674.275893230000000000
          Top = 18.897650000000000000
          Width = 76.724421650000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          ParentFont = False
        end
        object lblDescKil2: TfrxMemoView
          Left = 415.850650000000000000
          Top = 37.795300000000000000
          Width = 132.661410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM KILOS:')
          ParentFont = False
        end
        object rllSumKil2: TfrxMemoView
          Left = 674.275893230000000000
          Top = 37.795300000000000000
          Width = 76.724421650000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
          ParentFont = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 68.015770000000000000
        Top = 733.228820000000000000
        Width = 1201.134634000000000000
        OnAfterPrint = 'GroupFooter2OnAfterPrint'
        OnBeforePrint = 'GroupFooter2OnBeforePrint'
        object Memo2: TfrxMemoView
          Left = 415.291292200000000000
          Width = 132.661410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO GRUPO:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 571.488188980000000000
          Width = 97.511808580000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SALDOS">,rlbDetalhes)]')
          ParentFont = False
        end
        object rllToLit1: TfrxMemoView
          Left = 673.716535430000000000
          Width = 76.724421650000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 752.834645670000000000
          Width = 80.125994020000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
          ParentFont = False
        end
        object rllVrTotalF2: TfrxMemoView
          Left = 834.984205590000000000
          Width = 108.850393700000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
          ParentFont = False
        end
        object rllVrMedCusF2: TfrxMemoView
          Left = 948.787401570000000000
          Width = 97.511808580000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
          ParentFont = False
        end
        object rllVrMargemF2: TfrxMemoView
          Left = 1133.984251970000000000
          Width = 61.228336690000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllResult2: TfrxMemoView
          Left = 1050.614173230000000000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes) - SUM(<frxRelatorio."T' +
              'OTCUS">,rlbDetalhes)]')
          ParentFont = False
        end
        object lblDescLit1: TfrxMemoView
          Left = 415.850650000000000000
          Top = 19.118119999999980000
          Width = 132.661410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM LITROS:')
          ParentFont = False
        end
        object rllSumLit1: TfrxMemoView
          Left = 674.275893230000000000
          Top = 19.118119999999980000
          Width = 76.724421650000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          ParentFont = False
        end
        object lblDescKil1: TfrxMemoView
          Left = 415.850650000000000000
          Top = 38.574830000000020000
          Width = 132.661410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL EM KILOS:')
          ParentFont = False
        end
        object rllSumKil1: TfrxMemoView
          Left = 674.275893230000000000
          Top = 38.574830000000020000
          Width = 76.724421650000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Align = baCenter
          Left = -2.645268000000000000
          Top = 58.574830000000030000
          Width = 1206.425170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 56.677180000000000000
        Top = 952.441560000000000000
        Width = 1201.134634000000000000
        OnAfterPrint = 'ReportSummary1OnAfterPrint'
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        object Memo20: TfrxMemoView
          Left = 439.677192200000000000
          Width = 111.118120000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 571.488188980000000000
          Width = 97.511808580000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SALDOS">,rlbDetalhes)]')
          ParentFont = False
        end
        object rllToLit3: TfrxMemoView
          Left = 673.716535430000000000
          Width = 76.724421650000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 752.834645670000000000
          Width = 80.125994020000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
          ParentFont = False
        end
        object rllVrTotalSu: TfrxMemoView
          Left = 834.984205590000000000
          Width = 108.850393700000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
          ParentFont = False
        end
        object rllVrMedCusSu: TfrxMemoView
          Left = 948.787401570000000000
          Width = 97.511808580000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
          ParentFont = False
        end
        object rllVrMargemSu: TfrxMemoView
          Left = 1133.984251970000000000
          Width = 61.228336690000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllResultSu: TfrxMemoView
          Left = 1050.614173230000000000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes) - SUM(<frxRelatorio."T' +
              'OTCUS">,rlbDetalhes)]')
          ParentFont = False
        end
        object lblDescLit3: TfrxMemoView
          Left = 439.236550000000000000
          Top = 18.897650000000000000
          Width = 111.118120000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LITROS:')
          ParentFont = False
        end
        object rllSumLit3: TfrxMemoView
          Left = 674.275893230000000000
          Top = 18.897650000000000000
          Width = 76.724421650000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          ParentFont = False
        end
        object lblDescKil3: TfrxMemoView
          Left = 439.236550000000000000
          Top = 37.795300000000000000
          Width = 111.118120000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL KILOS:')
          ParentFont = False
        end
        object rllSumKil3: TfrxMemoView
          Left = 674.275893230000000000
          Top = 37.795300000000000000
          Width = 76.724421650000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
          ParentFont = False
        end
      end
      object rllCabecalho: TfrxChild
        FillType = ftBrush
        Height = 66.141732280000000000
        Top = 419.527830000000000000
        Visible = False
        Width = 1201.134634000000000000
        object Memo15: TfrxMemoView
          Left = 9.600000000000000000
          Top = 3.779530000000022000
          Width = 1185.486580000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
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
        object Memo31: TfrxMemoView
          Left = 9.600000000000000000
          Top = 21.779530000000020000
          Width = 1014.425170000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 1020.641250000000000000
          Top = 21.779530000000020000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 1107.041250000000000000
          Top = 40.779530000000030000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 9.600000000000000000
          Top = 40.779530000000030000
          Width = 1100.825170000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
      end
    end
  end
end
