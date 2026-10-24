object frmQckCtpCompPgtoMod: TfrmQckCtpCompPgtoMod
  Left = 0
  Top = 0
  ClientHeight = 386
  ClientWidth = 240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object frxDataCtp: TfrxDBDataset
    UserName = 'frxDataCtp'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 176
    Top = 8
  end
  object frxCtpCompPg_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41150.427356944400000000
    ReportOptions.LastChange = 44935.441662638890000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  blnDesmemb: Boolean;'
      ''
      'procedure memValorDesmembOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  memValorDesmemb.Text := FormatFloat('#39'#,##0.00'#39', <frxCtpDet."CT' +
        'P_FATCAL"> * <frxDataCtp."DUPLIC">);'
      'end;'
      ''
      'procedure chdSemDesmembOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  chdSemDesmemb.Visible := Not blnDesmemb;'
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  blnDesmemb := false;'
      'end;'
      ''
      'procedure MasterData2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  blnDesmemb := true;'
      'end;'
      ''
      'procedure DMPMemo49OnBeforePrint(Sender: TfrxComponent);'
      'var'
      
        '  strCodPlanoContas: String;                                    ' +
        '                                  '
      'begin'
      '  strCodPlanoContas := <frxCtpDet."CTP_CODCTA">;'
      '  Insert('#39'.'#39', strCodPlanoContas, 5);'
      '  Insert('#39'.'#39', strCodPlanoContas, 3);'
      
        '  DMPMemo49.Text := strCodPlanoContas + '#39' - '#39' + fRemoveAcentos(<' +
        'frxCtpDet."CTA_DESCTA">);'
      'end;'
      ''
      'procedure DMPMemo39OnBeforePrint(Sender: TfrxComponent);'
      'var'
      
        '  strCodPlanoContas: String;                                    ' +
        '                                  '
      'begin'
      '  strCodPlanoContas := <frxDataCtp."CENCUS">;'
      
        '  strCodPlanoContas := fRemoveAcentos(strCodPlanoContas);       ' +
        '                                           '
      '  Insert('#39'.'#39', strCodPlanoContas, 5);'
      '  Insert('#39'.'#39', strCodPlanoContas, 3);'
      
        '  DMPMemo39.Text := strCodPlanoContas;                          ' +
        '      '
      'end;'
      ''
      'procedure DMPMemo34OnBeforePrint(Sender: TfrxComponent);'
      'var'
      
        '  strCodPlanoContas: String;                                    ' +
        '                                  '
      'begin'
      '  strCodPlanoContas := <frxDataCtp."CENCUS">;'
      
        '  strCodPlanoContas := fRemoveAcentos(strCodPlanoContas);       ' +
        '                                           '
      '  Insert('#39'.'#39', strCodPlanoContas, 5);'
      '  Insert('#39'.'#39', strCodPlanoContas, 3);'
      
        '  DMPMemo34.Text := strCodPlanoContas;                          ' +
        '      '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxCtpCompPg_MUserFunction
    Left = 96
    Top = 8
    Datasets = <
      item
        DataSet = frxCtpDet
        DataSetName = 'frxCtpDet'
      end
      item
        DataSet = frxDataCtp
        DataSetName = 'frxDataCtp'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 148.431154138213000000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 306.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        Child = frxCtpCompPg_M.chdDesmembramento
        DataSet = frxDataCtp
        DataSetName = 'frxDataCtp'
        KeepChild = True
        PrintChildIfInvisible = True
        RowCount = 0
        object DMPMemo1: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 1507.200000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]     [frxDataCtp."REIMPR"]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'EMPRESA.........:')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'FORNECEDOR......:')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'PORTADOR........:')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'TIPO DE DESPESA.:')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Top = 170.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DATA EMISSAO....:')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'NR. DOCUMENTO...:')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Top = 153.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'NOTA FISCAL NR..:')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Top = 187.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DT. VENCIMENTO..:')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Top = 204.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DATA PAGAMENTO..:')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 68.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'VALOR TITULO.......:')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 85.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'JUROS DIGITADOS....:')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 119.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DESCONTOS DIGIT....:')
          TruncOutboundText = False
        end
        object rllValorTotal: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 187.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'VALOR TOTAL........:')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 204.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DESCONTOS..........:')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 221.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DESPESAS...........:')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 238.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'TITULO PAGO........:')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 255.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'VEIO BOLETO........:')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 204.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '__/__/____')
          TruncOutboundText = False
        end
        object rllVendor: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 136.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'VENDOR.............:')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Top = 238.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'VEIO NOTA FISCAL:')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 34.000000000000000000
          Width = 1324.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[fRemoveAcentos(<frxDataCtp."NOMEMP">)]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 68.000000000000000000
          Width = 940.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[fRemoveAcentos(<frxDataCtp."NOMFOR">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 85.000000000000000000
          Width = 940.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[fRemoveAcentos(<frxDataCtp."NOMPOR">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 102.000000000000000000
          Width = 940.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo34OnBeforePrint'
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 170.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataCtp."DTACAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 136.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataCtp."CHAVE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 153.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataCtp."NUMDUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 187.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataCtp."DTAVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 68.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."DUPLIC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 85.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."JURSUJ"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 119.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."DESSUJ"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbVendor: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 136.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."VENDOR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbVeioNf: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 238.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[fRemoveAcentos(<frxDataCtp."VEIONF">)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbVeioBo: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 255.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[fRemoveAcentos(<frxDataCtp."VEIOBO">)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbValorTotal: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 187.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxDataCtp."DUPLIC"> - <frxDataCtp."DESSUJ"> + <frxDataCtp."O' +
              'UTENT"> + <frxDataCtp."JURSUJ"> + <frxDataCtp."VENDOR">)]')
          TruncOutboundText = False
        end
        object cmdComando: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#32#15#27#77'
        end
        object DMPMemo65: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CTA DE RESULTADO:')
          TruncOutboundText = False
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 119.000000000000000000
          Width = 940.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[fRemoveAcentos(<frxDataCtp."DESCRE">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotalDoc: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 170.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'VR. TOTAL DOC......:')
          TruncOutboundText = False
        end
        object rlbTotalDoc: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 170.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."VALTOT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Top = 221.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DT. DOCUMENTO...:')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 221.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxDataCtp."DTADOC"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 153.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'VR OUTRAS ENTIDADES:')
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 153.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."OUTENT"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object lblDadosDepositoM: TfrxDMPMemoView
          Top = 255.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DADOS DEPOSITO..:')
          TruncOutboundText = False
        end
        object MemDadosDepositoM: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 255.000000000000000000
          Width = 412.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataCtp."CONTADEPOSITO"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo62: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 272.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DEPOSITO ..........:')
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 272.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[fRemoveAcentos(<frxDataCtp."DEPOSITO">)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo68: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 289.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CHEQUE ............:')
          TruncOutboundText = False
        end
        object DMPMemo69: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 289.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[fRemoveAcentos(<frxDataCtp."CHEQUE">)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo70: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 102.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'MULTAS DIGITADAS...:')
          TruncOutboundText = False
        end
        object DMPMemo71: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 102.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."MULSUJ"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object chdDesmembramento: TfrxChild
        FillType = ftBrush
        Top = 340.000000000000000000
        Width = 1507.200000000000000000
        Child = frxCtpCompPg_M.chdSemDesmemb
        KeepChild = True
        PrintChildIfInvisible = True
        object sbrDesmembramento: TfrxSubreport
          Width = 96.000000000000000000
          Page = frxCtpCompPg_M.Page1
        end
      end
      object chdSemDesmemb: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'chdSemDesmembOnBeforePrint'
        Child = frxCtpCompPg_M.chdRodape
        KeepChild = True
        PrintChildIfInvisible = True
        object DMPMemo19: TfrxDMPMemoView
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'NUMERO CHEQUE...:')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'BCO. CHEQUE:')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'BCO. COMP:')
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 172.800000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '______________________________________')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '______________________________________')
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '______________________________________')
          TruncOutboundText = False
        end
      end
      object chdRodape: TfrxChild
        FillType = ftBrush
        Height = 221.000000000000000000
        Top = 391.000000000000000000
        Width = 1507.200000000000000000
        KeepChild = True
        PrintChildIfInvisible = True
        object DMPMemo22: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'HISTORICO......:')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'OBSERVACOES....:')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 187.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERENTE')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 710.400000000000000000
          Top = 187.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'FINANCEIRO')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 187.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DIRETORIA')
          TruncOutboundText = False
        end
        object rdbHist01: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 17.000000000000000000
          Width = 1344.000000000000000000
          Height = 51.000000000000000000
          Memo.UTF8W = (
            '[fRemoveAcentos(<frxDataCtp."HIST01">)]')
          TruncOutboundText = False
        end
        object rdbHist02: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 68.000000000000000000
          Width = 1344.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[fRemoveAcentos(<frxDataCtp."HIST02">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 102.000000000000000000
          Width = 1324.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '________________________________________________________________' +
              '________________________________________________________________' +
              '____________')
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '________________________________________________________________' +
              '________________________________________________________________' +
              '___________________________')
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '________________________________________________________________' +
              '________________________________________________________________' +
              '___________________________')
          TruncOutboundText = False
        end
        object DMPMemo58: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 170.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '______________________________________')
          TruncOutboundText = False
        end
        object DMPMemo59: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 170.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '______________________________________')
          TruncOutboundText = False
        end
        object DMPMemo60: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 170.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '______________________________________')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Top = 204.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64'
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'PLANO DE CONTAS:')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo39OnBeforePrint'
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 585.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'EVENTO..........:')
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[fRemoveAcentos(<frxDataCtp."NOMEVE">)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 148.431154138213000000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      FontStyle = []
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 51.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'MasterData2OnBeforePrint'
        Columns = 2
        ColumnWidth = 758.400000000000000000
        ColumnGap = 76.800000000000000000
        DataSet = frxCtpDet
        DataSetName = 'frxCtpDet'
        Filter = 
          '(<frxCtpDet."CTP_CODFOR"> = <frxDataCtp."CODFOR">) AND (<frxCtpD' +
          'et."CTP_NUMDUP"> = <frxDataCtp."NUMDUP">) AND (<frxCtpDet."CTP_P' +
          'ARCEL"> = <frxDataCtp."PARCEL">) AND (<frxCtpDet."CTP_EMPORI"> =' +
          ' <frxDataCtp."CODEMP">) AND (<frxCtpDet."CTP_SERIE_"> = <frxData' +
          'Ctp."SERIE_">)'
        RowCount = 0
        object DMPMemo49: TfrxDMPMemoView
          Left = 86.400000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo49OnBeforePrint'
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object DMPMemo51: TfrxDMPMemoView
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxCtpDet."CTP_CODEMP"]')
          TruncOutboundText = False
        end
        object memValorDesmemb: TfrxDMPMemoView
          Left = 528.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'memValorDesmembOnBeforePrint'
          HAlign = haRight
          TruncOutboundText = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo44: TfrxDMPMemoView
          Left = 86.400000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'PLANO DE CONTAS')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'EMPRESA')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 528.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPMemo61: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'PLANO DE CONTAS')
          TruncOutboundText = False
        end
        object DMPMemo63: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'EMPRESA')
          TruncOutboundText = False
        end
        object DMPMemo64: TfrxDMPMemoView
          Left = 1363.200000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxCtpCompPg_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41150.427356944400000000
    ReportOptions.LastChange = 44935.442562731480000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      
        '  blnDesmemb: Boolean;                                          ' +
        '  '
      '  '
      'procedure memValorDesmembOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  memValorDesmemb.Text := FormatFloat('#39'#,##0.00'#39', <frxCtpDet."CT' +
        'P_FATCAL"> * <frxDataCtp."DUPLIC">);'
      'end;'
      ''
      'procedure chdSemDesmembOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdSemDesmemb.Visible := Not blnDesmemb;                      ' +
        '                      '
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  blnDesmemb := false;'
      ''
      
        '  if (Engine.CurY > 0) and (Engine.CurY < (Engine.PageHeight / 2' +
        ')) then'
      '    Engine.CurY := (Engine.PageHeight / 2);'
      ''
      'end;'
      ''
      'procedure MasterData2OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  blnDesmemb := true;'
      'end;'
      ''
      'procedure Memo34OnBeforePrint(Sender: TfrxComponent);'
      'var'
      
        '  strCodPlanoContas: String;                                    ' +
        '                                  '
      'begin'
      '  strCodPlanoContas := <frxDataCtp."CENCUS">;'
      '  Insert('#39'.'#39', strCodPlanoContas, 5);'
      '  Insert('#39'.'#39', strCodPlanoContas, 3);'
      
        '  Memo34.Text := strCodPlanoContas;                             ' +
        '   '
      'end;'
      ''
      'procedure Memo39OnBeforePrint(Sender: TfrxComponent);'
      'var'
      
        '  strCodPlanoContas: String;                                    ' +
        '                                  '
      'begin'
      '  strCodPlanoContas := <frxDataCtp."CENCUS">;'
      '  Insert('#39'.'#39', strCodPlanoContas, 5);'
      '  Insert('#39'.'#39', strCodPlanoContas, 3);'
      
        '  Memo39.Text := strCodPlanoContas;                             ' +
        '   '
      'end;'
      ''
      'procedure Memo57OnBeforePrint(Sender: TfrxComponent);'
      'var'
      
        '  strCodPlanoContas: String;                                    ' +
        '                                  '
      'begin'
      '  strCodPlanoContas := <frxCtpDet."CTP_CODCTA">;'
      '  Insert('#39'.'#39', strCodPlanoContas, 5);'
      '  Insert('#39'.'#39', strCodPlanoContas, 3);'
      
        '  Memo57.Text := strCodPlanoContas + '#39' - '#39' + <frxCtpDet."CTA_DES' +
        'CTA">;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxCtpCompPg_JUserFunction
    Left = 96
    Top = 64
    Datasets = <
      item
        DataSet = frxCtpDet
        DataSetName = 'frxCtpDet'
      end
      item
        DataSet = frxDataCtp
        DataSetName = 'frxDataCtp'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 278.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      VGuides.Strings = (
        '26,45671')
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 300.472448270000000000
        Top = 18.897650000000000000
        Width = 975.118740000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        Child = frxCtpCompPg_J.chdDesmembramento
        DataSet = frxDataCtp
        DataSetName = 'frxDataCtp'
        KeepChild = True
        RowCount = 0
        object Memo1: TfrxMemoView
          Align = baWidth
          Top = 13.338582680000000000
          Width = 975.118740000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]     [frxDataCtp."REIMPR"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 2.040940000000000000
          Top = 30.724409450000000000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'EMPRESA.........:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 2.040940000000000000
          Top = 54.897650000000000000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'FORNECEDOR......:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 2.040940000000000000
          Top = 72.528447779999990000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'PORTADOR........:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 2.040940000000000000
          Top = 90.159245560000000000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'TIPO DE DESPESA.:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 2.040940000000000000
          Top = 160.682436670000000000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DATA EMISS'#195'O....:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 2.040940000000000000
          Top = 125.420841110000000000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'NR. DOCUMENTO...:')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 2.040940000000000000
          Top = 143.051638890000000000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'NOTA FISCAL NR..:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 2.040940000000000000
          Top = 178.313234440000000000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DT. VENCIMENTO..:')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 2.040940000000000000
          Top = 194.944032220000000000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DATA PAGAMENTO..:')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 706.987570000000000000
          Top = 54.897650000000000000
          Width = 163.275590550000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'VALOR T'#205'TULO.......:')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 706.987570000000000000
          Top = 72.528447779999990000
          Width = 163.275590550000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'JUROS DIGITADOS....:')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 706.987570000000000000
          Top = 105.159245560000000000
          Width = 163.275590550000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DESCONTOS DIGIT....:')
          ParentFont = False
        end
        object rllValorTotal: TfrxMemoView
          Left = 706.987570000000000000
          Top = 175.682436670000000000
          Width = 163.275590550000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'VALOR TOTAL........:')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 706.987570000000000000
          Top = 193.313234440000000000
          Width = 163.275590550000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DESCONTOS..........:')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 706.987570000000000000
          Top = 209.944032220000000000
          Width = 163.275590550000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DESPESAS...........:')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 706.987570000000000000
          Top = 226.669450000000000000
          Width = 163.275590550000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'T'#205'TULO PAGO........:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 706.987570000000000000
          Top = 244.574830000000000000
          Width = 163.275590550000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'VEIO BOLETO........:')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 143.240940000000000000
          Top = 194.944032220000000000
          Width = 103.559060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '__/__/____')
          ParentFont = False
        end
        object rllVendor: TfrxMemoView
          Left = 706.987570000000000000
          Top = 122.790043330000000000
          Width = 163.275590550000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'VENDOR.............:')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 2.040940000000000000
          Top = 229.574830000000000000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'VEIO NOTA FISCAL:')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 143.240940000000000000
          Top = 30.724409450000000000
          Width = 829.757700000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."NOMEMP"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 143.240940000000000000
          Top = 54.913385830000000000
          Width = 558.689920000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."NOMFOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 143.240940000000000000
          Top = 72.528447779999990000
          Width = 558.689920000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."NOMPOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 143.240940000000000000
          Top = 90.159245560000000000
          Width = 558.689920000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'Memo34OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."DESCUS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 143.240940000000000000
          Top = 160.682436670000000000
          Width = 199.634570000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 143.240940000000000000
          Top = 125.420841110000000000
          Width = 237.429870000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."CHAVE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 143.240940000000000000
          Top = 143.051638890000000000
          Width = 237.429870000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 143.240940000000000000
          Top = 178.313234440000000000
          Width = 199.634570000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 871.187570000000000000
          Top = 54.897650000000000000
          Width = 102.047241650000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."DUPLIC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 871.187570000000000000
          Top = 72.528447779999990000
          Width = 102.047241650000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."JURSUJ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 871.187570000000000000
          Top = 105.159245560000000000
          Width = 102.047241650000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."DESSUJ"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbVendor: TfrxMemoView
          Left = 871.187570000000000000
          Top = 122.790043330000000000
          Width = 102.047241650000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."VENDOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 143.240940000000000000
          Top = 229.574830000000000000
          Width = 103.559060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."VEIONF"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 871.187570000000000000
          Top = 244.574830000000000000
          Width = 102.047241650000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."VEIOBO"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbValorTotal: TfrxMemoView
          Left = 871.187570000000000000
          Top = 175.682436670000000000
          Width = 102.047241650000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxDataCtp."DUPLIC"> - <frxDataCtp."DESSUJ"> + <frxDataCtp."O' +
              'UTENT"> + <frxDataCtp."JURSUJ"> + <frxDataCtp."VENDOR">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo60: TfrxMemoView
          Left = 2.040940000000000000
          Top = 107.790043330000000000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'CTA DE RESULTADO:')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 143.240940000000000000
          Top = 107.790043330000000000
          Width = 558.689920000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."DESCRE"]')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalDoc: TfrxMemoView
          Left = 706.987570000000000000
          Top = 158.051638890000000000
          Width = 163.275590550000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'VR TOTAL DOC.......:')
          ParentFont = False
        end
        object rlbTotalDoc: TfrxMemoView
          Left = 871.187570000000000000
          Top = 158.051638890000000000
          Width = 102.047241650000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."VALTOT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 2.779530000000000000
          Top = 211.669450000000000000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DT. DOCUMENTO...:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 142.622140000000000000
          Top = 211.669450000000000000
          Width = 199.634570000000000000
          Height = 17.000000000000000000
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."DTADOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Left = 706.987570000000000000
          Top = 140.420841110000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'VR OUTRAS ENTIDADES:')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 871.187570000000000000
          Top = 140.420841110000000000
          Width = 102.047241650000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."OUTENT"]')
          ParentFont = False
          WordWrap = False
        end
        object lblDadosDeposito: TfrxMemoView
          Left = 2.000000000000000000
          Top = 266.464750000000000000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DADOS DEP'#211'SITO..:')
          ParentFont = False
        end
        object MemDadosDeposito: TfrxMemoView
          Left = 143.200000000000000000
          Top = 266.464750000000000000
          Width = 558.614173228346000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."CONTADEPOSITO"]')
          ParentFont = False
          WordWrap = False
        end
        object lblInformaDeposito: TfrxMemoView
          Left = 1.779530000000000000
          Top = 248.047602910000000000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DEP'#211'SITO .......:')
          ParentFont = False
        end
        object MemInformaDeposito: TfrxMemoView
          Left = 143.511906220000000000
          Top = 248.047602910000000000
          Width = 198.047310000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."DEPOSITO"]')
          ParentFont = False
          WordWrap = False
        end
        object lblInformaCheque: TfrxMemoView
          Left = 706.716537870000000000
          Top = 261.905690000000000000
          Width = 163.275605200000000000
          Height = 20.569556110000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'CHEQUE ............:')
          ParentFont = False
        end
        object MemInformaCheque: TfrxMemoView
          Left = 871.078752360000000000
          Top = 261.905690000000000000
          Width = 100.511069080000000000
          Height = 20.569556110000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."CHEQUE"]')
          ParentFont = False
          WordWrap = False
        end
        object lblGuia: TfrxMemoView
          Left = 706.772110000000000000
          Top = 283.346630000000000000
          Width = 163.275605200000000000
          Height = 20.569556110000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'GUIA...............:')
          ParentFont = False
        end
        object memDadosGuia: TfrxMemoView
          Left = 871.134324490000000000
          Top = 283.346630000000000000
          Width = 100.511069080000000000
          Height = 20.569556110000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."GUIDES"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo58: TfrxMemoView
          Left = 706.772110000000000000
          Top = 87.929190000000000000
          Width = 163.275590550000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'MULTAS DIGITADAS...:')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 870.972110000000000000
          Top = 88.929190000000000000
          Width = 102.047241650000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."MULSUJ"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object chdRodape: TfrxChild
        FillType = ftBrush
        Height = 200.314977720000000000
        Top = 408.189240000000000000
        Width = 975.118740000000000000
        KeepChild = True
        object Memo22: TfrxMemoView
          Left = 8.318120000000000000
          Top = 20.220469999999980000
          Width = 130.620470000000000000
          Height = 20.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'HIST'#211'RICO......:')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 6.538590000000000000
          Top = 109.015748030000000000
          Width = 130.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES....:')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Left = 140.738590000000000000
          Top = 126.401574800000000000
          Width = 826.356030000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line5: TfrxLineView
          Left = 11.338590000000000000
          Top = 141.519685040000000000
          Width = 956.976500000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line7: TfrxLineView
          Left = 11.338590000000000000
          Top = 169.866141730000000000
          Width = 211.502350000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line8: TfrxLineView
          Left = 380.142610000000000000
          Top = 169.866141730000000000
          Width = 211.653543310000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line9: TfrxLineView
          Left = 748.946630000000000000
          Top = 169.866141730000000000
          Width = 211.502350000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo24: TfrxMemoView
          Left = 74.759060000000000000
          Top = 177.047244090000000000
          Width = 84.661410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERENTE')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 443.638676660000000000
          Top = 177.047244090000000000
          Width = 84.661410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'FINANCEIRO')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 816.146630000000000000
          Top = 177.047244090000000000
          Width = 77.102350000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DIRETORIA')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 145.040940000000000000
          Top = 20.220470000000000000
          Width = 820.837910000000000000
          Height = 58.582694250000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."HIST01"]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 145.261410000000000000
          Top = 85.582677170000000000
          Width = 820.837910000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."HIST02"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 7.779530000000000000
          Width = 132.963760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'PLANO DE CONTAS:')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 145.979530000000000000
          Width = 331.918120000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'Memo39OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          WordWrap = False
        end
        object Memo43: TfrxMemoView
          Left = 495.118430000000000000
          Width = 140.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'CENTRO DE CUSTOS:')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 637.318430000000000000
          Width = 331.918120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."NOMEVE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object chdSemDesmemb: TfrxChild
        FillType = ftBrush
        Height = 19.771800000000000000
        Top = 366.614410000000000000
        Width = 975.118740000000000000
        OnBeforePrint = 'chdSemDesmembOnBeforePrint'
        Child = frxCtpCompPg_J.chdRodape
        KeepChild = True
        PrintChildIfInvisible = True
        object Memo19: TfrxMemoView
          Left = 6.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#218'MERO CHEQUE..:')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 142.979530000000000000
          Top = 17.000000000000000000
          Width = 198.652010000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Left = 454.549660000000000000
          Top = 17.000000000000000000
          Width = 209.990600000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Left = 762.037910000000000000
          Top = 17.000000000000000000
          Width = 209.990600000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo20: TfrxMemoView
          Left = 349.770130000000000000
          Width = 100.081880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'BCO. CHEQUE:')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 672.458380000000000000
          Width = 84.661410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'BCO. COMP:')
          ParentFont = False
        end
      end
      object chdDesmembramento: TfrxChild
        FillType = ftBrush
        Top = 343.937230000000000000
        Width = 975.118740000000000000
        Child = frxCtpCompPg_J.chdSemDesmemb
        KeepChild = True
        PrintChildIfInvisible = True
        object sbrDesmembramento: TfrxSubreport
          Width = 94.488250000000000000
          Page = frxCtpCompPg_J.Page1
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 278.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 60.472480000000000000
        Width = 975.118740000000000000
        OnAfterPrint = 'MasterData2OnAfterPrint'
        Columns = 2
        ColumnWidth = 487.559055118110000000
        ColumnGap = 27.590551181102400000
        DataSet = frxCtpDet
        DataSetName = 'frxCtpDet'
        Filter = 
          '(<frxCtpDet."CTP_CODFOR"> = <frxDataCtp."CODFOR">) AND (<frxCtpD' +
          'et."CTP_NUMDUP"> = <frxDataCtp."NUMDUP">) AND (<frxCtpDet."CTP_P' +
          'ARCEL"> = <frxDataCtp."PARCEL">) AND (<frxCtpDet."CTP_EMPORI"> =' +
          ' <frxDataCtp."CODEMP">) AND (<frxCtpDet."CTP_SERIE_"> = <frxData' +
          'Ctp."SERIE_">)'
        RowCount = 0
        object Memo57: TfrxMemoView
          Left = 43.354360000000000000
          Top = 0.779530000000001200
          Width = 306.141812830000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'Memo57OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo59: TfrxMemoView
          Top = 0.779530000000001200
          Width = 42.179530000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCtpDet."CTP_CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object memValorDesmemb: TfrxMemoView
          Left = 350.417130000000000000
          Top = 0.779530000000001200
          Width = 105.826774090000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'memValorDesmembOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 18.897650000000000000
        Width = 975.118740000000000000
        object Memo49: TfrxMemoView
          Left = 42.574830000000000000
          Width = 306.141812830000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'PLANO DE CONTAS')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Width = 42.179530000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'EMP.')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 350.417130000000000000
          Width = 104.692950000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 556.913730000000000000
          Width = 306.141812830000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'PLANO DE CONTAS')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 514.559370000000000000
          Width = 42.179530000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'EMP.')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 864.976500000000000000
          Width = 104.692950000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
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
    SaveToFile = False
    UseIniSettings = False
    Left = 17
    Top = 9
  end
  object frxMod3Vias: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41150.427356944400000000
    ReportOptions.LastChange = 41961.405431921310000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Shape1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxDataCtp."DTADOC"> = 30/12/1899 Then'
      '  Begin'
      '    Memo1.Visible := False;'
      
        '    Memo3.Visible := False;                                     ' +
        '                   '
      '  End              '
      'end;'
      ''
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxMod3ViasUserFunction
    Left = 96
    Top = 120
    Datasets = <
      item
        DataSet = frxDataCtp
        DataSetName = 'frxDataCtp'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 3.000000000000000000
      RightMargin = 3.000000000000000000
      TopMargin = 3.000000000000000000
      BottomMargin = 3.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 345.826769210000000000
        Top = 75.590600000000000000
        Width = 771.024120000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxDataCtp
        DataSetName = 'frxDataCtp'
        RowCount = 0
        object Shape1: TfrxShapeView
          Left = 6.559060000000000000
          Top = 53.811070000000000000
          Width = 496.251968500000000000
          Height = 274.015750470000000000
          OnBeforePrint = 'Shape1OnBeforePrint'
        end
        object rllReimpressao: TfrxMemoView
          Left = 7.000000000000000000
          Width = 631.181510000000000000
          Height = 20.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ficha Autoriza'#231#227'o de Pagamento    [frxDataCtp."REIMPR"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 571.385860940000000000
          Top = 20.779529999999990000
          Width = 189.656710000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nr. Lanc.: [frxDataCtp."NUMDUP"]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 571.385860940000000000
          Top = 37.440940000000000000
          Width = 188.976431650000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '     Data: [frxDataCtp."DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo43: TfrxMemoView
          Left = 7.000000000000000000
          Top = 21.456710000000000000
          Width = 555.590910000000000000
          Height = 20.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fornecedor: [frxDataCtp."NOMFOR"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 199.140260000000000000
          Top = 309.826759450000000000
          Width = 96.000000000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Autoriza'#231#227'o')
          ParentFont = False
        end
        object Line7: TfrxLineView
          Left = 74.267780000000000000
          Top = 307.259818110000000000
          Width = 347.565430000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo25: TfrxMemoView
          Left = 596.630266660000000000
          Top = 309.826759450000000000
          Width = 84.661410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Pagamento')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 16.118120000000000000
          Top = 330.307086610000000000
          Width = 752.125984250000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - -')
          ParentFont = False
        end
        object Picture1: TfrxPictureView
          Left = 3.000000000000000000
          Top = 330.307086610000000000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001000
            00001008060000001FF3FF61000000017352474200AECE1CE90000000467414D
            410000B18F0BFC61050000028D4944415478DA63642000A2527345636363EA39
            39B9C51D4C7542D1E519F169661696616D6DACDB949C9AE4F1ECD99B35FA8A12
            A41920AB65E4B27EFDBADDB20AF20C478E9CE80876B6AC24C9004B179FD2454B
            9775313233336CDFB5372237CA6F254906D87B054D5EB46459CEAB57AF7E1D3A
            794EBD383EE00149067806472D99367B5EF4FDBB775E9F387F455C5A9097955F
            4498EBC19317A6721262EEDCDC9C326003E41D26723128A879F1F2B3090948F2
            7EFCFCFDDF998B8D16776352B3B73677F57A9D3A79E2C1D71FBF3748890A3B8B
            8A8A28F3F109710A8B7031EEDAB9EF102317AF92A0A47BF31C2639B1A03FCFEF
            7CE011951150D2D17824FFEFC105E5FFF76CE5D474050578791994945518B8F9
            38189880167EFBF683E1D08143772F5CBEE2C7C8256694AA9FBF64D6D30B2B53
            1FAD6E5CCBCA26916A56B9A6D3424F88C1EAF71986B75F7F33B0B0737F7EFBE5
            DB8BB76FDF7F7CF4F0FEA337AF5E9D7DF9E6FDFC8B47763F67E41235AC332E5C
            D2F8EDD7E3C467278F2CFFF7E163AE8A6F5CF7F7A7A78FEAA9CAEA69E919F0EE
            DFBB3FE7F0E2F68D5F1EDFFBC4F0FFE72794406466E6B69674AA5C25641B24F5
            8F91FD0FD39F4FFF3EDD39B48A45405C435054C14490878381414068D9AE14B9
            686C01CDC8C8C4C0C4C4CCEBC6236BE6C7CACBF3FDCBDB271B78154C5CC5ADE2
            F36ECFCC28621712F355896B0A60FFF553EE78BBE363A2A2513AB0EB368F9CE5
            CD9B136D7DD8B805DD1413176E67FFC7EA7A699AE73E8206303330088B39571D
            15758E10E013648C787A729F270B9F66D99707CFE49F6F4A7844D00016362626
            561ED57219CFFA66697D3DE64F1FBF30BCB97EB7FFD1BAE822AC61804D909989
            819B895DC4938D5F49978555E81ABF66C8DA47BB52FE60530B00CDE6EE925306
            3F5E0000000049454E44AE426082}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo5: TfrxMemoView
          Left = 15.118110240000000000
          Top = 55.252010000000010000
          Width = 144.302350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Empresa:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 15.118110240000000000
          Top = 72.118120000000000000
          Width = 144.302350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Portador:')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 15.118110240000000000
          Top = 89.118120000000000000
          Width = 144.302350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Tipo de Despesas:')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 15.118110240000000000
          Top = 106.000000000000000000
          Width = 144.302350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Nr. Documento:')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 15.118110240000000000
          Top = 122.881880000000000000
          Width = 144.302350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Dt. Vencimento:')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 15.118110240000000000
          Top = 139.881880000000000000
          Width = 144.302350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Data Pagamento:')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 161.007874020000000000
          Top = 139.881880000000000000
          Width = 96.000000000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '__/__/____')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 15.118110240000000000
          Top = 171.881880000000000000
          Width = 144.302350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Plano de Contas:')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 161.007874020000000000
          Top = 55.252010000000000000
          Width = 334.639270000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."NOMEMP"]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 161.007874020000000000
          Top = 72.118120000000000000
          Width = 334.488179210000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."NOMPOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 161.007874020000000000
          Top = 89.118120000000000000
          Width = 334.488179210000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."DESCUS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo79: TfrxMemoView
          Left = 161.007874020000000000
          Top = 106.000000000000000000
          Width = 334.488179210000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."CHAVE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo81: TfrxMemoView
          Left = 161.007874020000000000
          Top = 122.881880000000000000
          Width = 334.488179210000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo82: TfrxMemoView
          Left = 161.007874020000000000
          Top = 171.881880000000000000
          Width = 334.488179210000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."CENCUS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 15.118120000000000000
          Top = 205.653680000000000000
          Width = 70.147990000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'm.Chq.:')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 83.149574570000000000
          Top = 220.256030000000000000
          Width = 107.716535430000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Left = 267.685134570000000000
          Top = 220.035560000000000000
          Width = 66.141705430000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Left = 418.204924570000000000
          Top = 220.035560000000000000
          Width = 77.480295430000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo34: TfrxMemoView
          Left = 196.825170000000000000
          Top = 205.433210000000000000
          Width = 69.845640000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Bco.Chq.:')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 340.655040000000000000
          Top = 205.433210000000000000
          Width = 77.102350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bco.Comp.:')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 15.118120000000000000
          Top = 221.960730000000000000
          Width = 92.825170000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Hist'#243'rico:')
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          Left = 110.840940000000000000
          Top = 221.858380000000000000
          Width = 382.412430000000000000
          Height = 45.354350240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."HIST01"]')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 110.604700000000000000
          Top = 267.047310000000000000
          Width = 382.412430000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."HIST02"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 505.457020000000000000
          Top = 55.252010000000010000
          Width = 140.522820000000000000
          Height = 17.007874015748030000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor T'#237'tulo:')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 505.457020000000000000
          Top = 72.118120000000000000
          Width = 140.522820000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Juros Digitados:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 505.457020000000000000
          Top = 103.118120000000000000
          Width = 140.522820000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Desc. Digitados:')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 505.457020000000000000
          Top = 154.881880000000000000
          Width = 140.522820000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Total:')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 505.457020000000000000
          Top = 171.881880000000000000
          Width = 140.522820000000000000
          Height = 17.007874015748030000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Veio Boleto:')
          ParentFont = False
        end
        object rllVendor: TfrxMemoView
          Left = 505.457020000000000000
          Top = 120.000000000000000000
          Width = 140.522820000000000000
          Height = 17.007874015748030000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vendor:')
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          Left = 650.436550000000000000
          Top = 55.252010000000010000
          Width = 113.385831650000000000
          Height = 17.007874015748030000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."DUPLIC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo84: TfrxMemoView
          Left = 650.436550000000000000
          Top = 72.118120000000000000
          Width = 113.385831650000000000
          Height = 17.007874020000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."JURSUJ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo85: TfrxMemoView
          Left = 650.436550000000000000
          Top = 103.118120000000000000
          Width = 113.385831650000000000
          Height = 17.007874020000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."DESSUJ"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbVendor: TfrxMemoView
          Left = 650.436550000000000000
          Top = 120.000000000000000000
          Width = 113.461410000000000000
          Height = 17.007874015748030000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."VENDOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo87: TfrxMemoView
          Left = 650.436550000000000000
          Top = 171.881880000000000000
          Width = 103.559060000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."VEIOBO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo90: TfrxMemoView
          Left = 650.512060000000000000
          Top = 154.881880000000000000
          Width = 113.385900000000000000
          Height = 17.007874015748030000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxDataCtp."DUPLIC"> - <frxDataCtp."DESSUJ"> + <frxDataCtp."O' +
              'UTENT"> + <frxDataCtp."JURSUJ"> + <frxDataCtp."VENDOR">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 520.575140000000000000
          Top = 243.559060000000000000
          Width = 104.163760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Observa'#231#227'o:')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Left = 620.775140000000000000
          Top = 255.153680000000000000
          Width = 139.842522130000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line5: TfrxLineView
          Left = 523.375140000000000000
          Top = 275.153680000000000000
          Width = 236.220472440000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line6: TfrxLineView
          Left = 523.375140000000000000
          Top = 296.153680000000000000
          Width = 236.220472440000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo48: TfrxMemoView
          Left = 642.519685040000000000
          Top = 0.677180000000007000
          Width = 121.700787400000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Via: [frxDataCtp."NUMVIA"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 15.118120000000000000
          Top = 156.299320000000000000
          Width = 144.302350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Dt. Documento:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 160.740260000000000000
          Top = 156.299320000000000000
          Width = 334.488179210000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."DTADOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 505.457020000000000000
          Top = 137.504020000000000000
          Width = 140.522820000000000000
          Height = 17.007874015748030000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. Out. Entidades:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 650.436550000000000000
          Top = 137.504020000000000000
          Width = 113.461410000000000000
          Height = 17.007874015748030000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."OUTENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 505.457020000000000000
          Top = 188.858380000000000000
          Width = 140.522820000000000000
          Height = 17.007874015748030000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Veio Nota Fiscal:')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 650.436550000000000000
          Top = 188.858380000000000000
          Width = 111.118120000000000000
          Height = 17.007874015748030000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."VEIONF"]')
          ParentFont = False
          WordWrap = False
        end
        object lblDadosDeposito3Vias: TfrxMemoView
          Left = 15.118120000000000000
          Top = 186.976500000000000000
          Width = 144.302350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Dados Deposito:')
          ParentFont = False
        end
        object MemDadosDeposito3Vias: TfrxMemoView
          Left = 161.007883780000000000
          Top = 186.976500000000000000
          Width = 334.488179210000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."CONTADEPOSITO"]')
          ParentFont = False
          WordWrap = False
        end
        object lblInfoDeposito3Vias: TfrxMemoView
          Left = 520.575140000000000000
          Top = 204.976500000000000000
          Width = 125.404700000000000000
          Height = 17.007874020000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Dep'#243'sito  :')
          ParentFont = False
        end
        object lblMemInfodeposito3Vias: TfrxMemoView
          Left = 650.436550000000000000
          Top = 204.976500000000000000
          Width = 114.897650000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."DEPOSITO"]')
          ParentFont = False
          WordWrap = False
        end
        object lblInfoCheque3Vias: TfrxMemoView
          Left = 520.575140000000000000
          Top = 222.874150000000000000
          Width = 125.404700000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cheque  :')
          ParentFont = False
        end
        object lblMemInfoCheque3Vias: TfrxMemoView
          Left = 650.436550000000000000
          Top = 222.874150000000000000
          Width = 114.897650000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."CHEQUE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 506.457020000000000000
          Top = 88.708720000000000000
          Width = 140.522820000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Multas Digitadas:')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 651.436550000000000000
          Top = 88.708720000000000000
          Width = 113.385831650000000000
          Height = 17.007874020000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."MULSUJ"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 18.897650000000000000
        Width = 771.024120000000000000
        ReprintOnNewPage = True
        object Memo31: TfrxMemoView
          Left = 644.181510000000000000
          Top = 15.874015748031500000
          Width = 120.944881890000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina: [Page]')
          ParentFont = False
        end
      end
    end
  end
  object frxCtpDet: TfrxDBDataset
    UserName = 'frxCtpDet'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 176
    Top = 64
  end
  object frxCtpChq: TfrxDBDataset
    UserName = 'frxCtpChq'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 170
    Top = 125
  end
  object frxCtpCompPgSelecionadas_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41150.427356944400000000
    ReportOptions.LastChange = 44936.618316030090000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '(*var'
      '  blnDesmemb: Boolean;'
      ''
      'procedure memValorDesmembOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  memValorDesmemb.Text := FormatFloat('#39'#,##0.00'#39', <frxCtpDet."CT' +
        'P_FATCAL"> * <frxDataCtp."DUPLIC">);'
      'end;'
      ''
      'procedure chdSemDesmembOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  chdSemDesmemb.Visible := Not blnDesmemb;'
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  blnDesmemb := false;'
      ''
      
        '  if (Engine.CurY > 0) and (Engine.CurY < (Engine.PageHeight / 2' +
        ')) then'
      '    Engine.CurY := (Engine.PageHeight / 2);'
      ''
      'end;'
      ''
      'procedure MasterData2OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  blnDesmemb := true;'
      'end;'
      ''
      'procedure Memo34OnBeforePrint(Sender: TfrxComponent);'
      'var'
      '  strCodPlanoContas: String;'
      'begin'
      '  strCodPlanoContas := <frxDataCtp."CENCUS">;'
      '  Insert('#39'.'#39', strCodPlanoContas, 5);'
      '  Insert('#39'.'#39', strCodPlanoContas, 3);'
      '  Memo34.Text := strCodPlanoContas;'
      'end;'
      ''
      'procedure Memo39OnBeforePrint(Sender: TfrxComponent);'
      'var'
      '  strCodPlanoContas: String;'
      'begin'
      '  strCodPlanoContas := <frxDataCtp."CENCUS">;'
      '  Insert('#39'.'#39', strCodPlanoContas, 5);'
      '  Insert('#39'.'#39', strCodPlanoContas, 3);'
      '  Memo39.Text := strCodPlanoContas;'
      'end;'
      ''
      'procedure Memo57OnBeforePrint(Sender: TfrxComponent);'
      'var'
      '  strCodPlanoContas: String;'
      'begin'
      '  strCodPlanoContas := <frxCtpDet."CTP_CODCTA">;'
      '  Insert('#39'.'#39', strCodPlanoContas, 5);'
      '  Insert('#39'.'#39', strCodPlanoContas, 3);'
      
        '  Memo57.Text := strCodPlanoContas + '#39' - '#39' + <frxCtpDet."CTA_DES' +
        'CTA">;'
      'end;'
      '*)    '
      'begin'
      ''
      'end.')
    OnUserFunction = frxCtpCompPgSelecionadas_JUserFunction
    Left = 96
    Top = 176
    Datasets = <
      item
        DataSet = frxCtpDet
        DataSetName = 'frxCtpDet'
      end
      item
        DataSet = frxDataCtp
        DataSetName = 'frxDataCtp'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 278.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight, ftBottom]
        Frame.BottomLine.Color = clSilver
        Height = 11.944032220000000000
        Top = 151.181200000000000000
        Width = 975.118740000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxDataCtp
        DataSetName = 'frxDataCtp'
        KeepChild = True
        RowCount = 0
        object Memo32: TfrxMemoView
          Left = 132.283454800000000000
          Width = 226.091280000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."CODFOR"] - [frxDataCtp."NOMFOR"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo38: TfrxMemoView
          Left = 585.826805830000000000
          Top = 0.013948609999999920
          Width = 91.464566930000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Width = 133.039387170000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."CHAVE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 495.118430000000000000
          Width = 91.464566930000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 359.055350000000000000
          Width = 131.603030000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataCtp."CODPOR"] - [frxDataCtp."NOMPOR"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbValorTotal: TfrxMemoView
          Left = 888.188983700000000000
          Top = 0.394557780000013800
          Width = 87.685034490000010000
          Height = 13.220470000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxDataCtp."DUPLIC"> - <frxDataCtp."DESSUJ"> + <frxDataCtp."O' +
              'UTENT"> + <frxDataCtp."JURSUJ"> + <frxDataCtp."VENDOR">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 823.937073780000000000
          Top = 0.123376669999999000
          Width = 65.007856930000000000
          Height = 13.220470000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."DESSUJ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 763.464654800000000000
          Top = 0.287878890000001800
          Width = 57.448796930000000000
          Height = 13.220470000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."JURSUJ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 676.535870000000000000
          Width = 87.685034490000010000
          Height = 13.220470000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataCtp."DUPLIC"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Height = 70.929190000000000000
        Top = 18.897650000000000000
        Width = 975.118740000000000000
        Stretched = True
        object Shape1: TfrxShapeView
          Top = 55.574829999999990000
          Width = 975.118740000000000000
          Height = 15.118120000000000000
        end
        object Memo1: TfrxMemoView
          Top = 26.456710000000000000
          Width = 975.118740000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Top = 56.574829999999990000
          Width = 132.963760000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 132.283550000000000000
          Top = 56.574829999999990000
          Width = 140.522820000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORNECEDOR')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 585.827150000000000000
          Top = 56.574829999999990000
          Width = 91.388930000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DT.VENCIMENTO')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 763.465060000000000000
          Top = 56.574829999999990000
          Width = 57.448750550000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 820.158010000000000000
          Top = 56.574829999999990000
          Width = 65.007810550000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTOS')
          ParentFont = False
        end
        object rllValorTotal: TfrxMemoView
          Left = 888.189550000000000000
          Top = 56.574829999999990000
          Width = 87.684990550000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR LIQUIDO')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 495.118430000000000000
          Top = 56.692949999999990000
          Width = 91.388930000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DT.CADASTRO')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 359.055350000000000000
          Top = 56.692949999999990000
          Width = 132.963760000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PORTADOR')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 676.535870000000000000
          Top = 56.692949999999990000
          Width = 87.684990550000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR BRUTO')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Height = 34.015770000000000000
        Top = 185.196970000000000000
        Width = 975.118740000000000000
        object Memo4: TfrxMemoView
          Left = 721.890230000000000000
          Top = 1.000000000000000000
          Width = 114.141700550000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR TOTAL')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 857.953310000000000000
          Top = 1.000000000000000000
          Width = 114.141744490000000000
          Height = 13.220470000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDataCtp."DUPLIC">,MasterData1) - SUM(<frxDataCtp."DESSU' +
              'J">,MasterData1) + SUM(<frxDataCtp."OUTENT">,MasterData1) + SUM(' +
              '<frxDataCtp."JURSUJ">,MasterData1) + SUM(<frxDataCtp."VENDOR">,M' +
              'asterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
  end
end
