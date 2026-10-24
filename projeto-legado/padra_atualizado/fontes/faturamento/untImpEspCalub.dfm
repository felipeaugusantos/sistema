object frmImpEspCalub: TfrmImpEspCalub
  OldCreateOrder = False
  Height = 267
  Width = 353
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 55
    Top = 24
  end
  object frxCalub: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42394.387655497690000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure DMPMemo23OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  DMPMemo23.Text := fFormataFone(DMPMemo23.Text);'
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
      'procedure DMPMemo20OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  DMPMemo20.Text := fFormataCEP(DMPMemo20.Text);  '
      'end;'
      ''
      'procedure DMPMemo17OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  DMPMemo17.Text := fFormataCpfCgc(DMPMemo17.Text);  '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbDetalhes.StartNewPage := <Line> mod 17 = 0;   '
      'end;'
      ''
      'begin'
      '    '
      'end.')
    OnUserFunction = frxCalubUserFunction
    Left = 47
    Top = 80
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
    object qckAnalitico: TfrxDMPPage
      PaperWidth = 345.439776903477400000
      PaperHeight = 175.418636708797100000
      PaperSize = 256
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 323.000000000000000000
        Width = 1305.600000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object frxDBItensCliDET_ITEM: TfrxDMPMemoView
          Left = 19.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          TruncOutboundText = False
        end
        object frxRelatorioDesIte: TfrxDMPMemoView
          Left = 163.200000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          TruncOutboundText = False
        end
        object frxDBItensCliDET_QTDITE: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 892.800000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ENTSAI"]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
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
          Command = '#27#67#39'
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 238.000000000000000000
        Top = 68.000000000000000000
        Width = 1305.600000000000000000
        Condition = 'frxRelatorio."DOCQUEBRA"'
        KeepChild = True
        KeepTogether = True
        ReprintOnNewPage = True
        PrintChildIfInvisible = True
        StartNewPage = True
        object DMPMemo11: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 787.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."FANSOB"]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 170.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'DMPMemo23OnAfterData'
          Memo.UTF8W = (
            '[frxRelatorio."FONE01"]')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 51.000000000000000000
          Width = 787.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 85.000000000000000000
          Width = 1152.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 102.000000000000000000
          Width = 787.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ENDERE"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 119.000000000000000000
          Width = 787.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."BAIRRO"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 136.000000000000000000
          Width = 787.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."NOMCID"]')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 153.000000000000000000
          Width = 787.200000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'DMPMemo17OnAfterData'
          Memo.UTF8W = (
            '[frxRelatorio."C_G_C_"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 170.000000000000000000
          Width = 787.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."DESCND"]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 187.000000000000000000
          Width = 1152.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ENDENT"]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 51.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 68.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]-[frxRelatorio."ESPDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 102.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ENDNUM"]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 119.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'DMPMemo20OnAfterData'
          Memo.UTF8W = (
            '[frxRelatorio."C_E_P_"]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 136.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ESTADO"]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 153.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."NUMR_G"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 357.000000000000000000
        Width = 1305.600000000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object DMPMemo8: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 34.000000000000000000
          Width = 969.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."MEN001"]. [frxRelatorio."MEN002"]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 34.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE">, rlbDetalhes) - SUM(<frxRelatorio."' +
              'DESESP">, rlbDetalhes) + SUM(<frxRelatorio."TOTFRE">, rlbDetalhe' +
              's)]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">, rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO:')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">, rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'FRETE:')
          TruncOutboundText = False
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
    Left = 143
    Top = 24
  end
end
