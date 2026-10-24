object frmRelCadAutAba: TfrmRelCadAutAba
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 174
  Width = 258
  object frxReportJato: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 40988.370044664350000000
    ReportOptions.LastChange = 40988.663526828700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Memo12OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '                  '
      'end;'
      ''
      'procedure Memo13OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '                                                 '
      'end;'
      ''
      'procedure Memo20OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  Memo41.Text := '#39' - '#39' + fRetornaDescricaoVeic(<frxDBAutAba."ABA' +
        '_PLAVEI">);  '
      'end;'
      ''
      'procedure Memo21OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  Memo42.Text := '#39' - '#39' + fRetNomFornecedor(<frxDBAutAba."ABA_COD' +
        'FOR">);                                          '
      'end;'
      ''
      'procedure Memo22OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  Memo43.Text := '#39' - '#39' + fRetNomeMotorista(<frxDBAutAba."ABA_COD' +
        'MOT">);                                              '
      'end;'
      ''
      'procedure Memo4OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  Memo4.Text := '#39' - '#39' + fRetNomeEmpresaSelec(<frxDBAutAba."ABA_C' +
        'ODEMP">);                                                       ' +
        ' '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportJatoUserFunction
    Left = 48
    Top = 24
    Datasets = <
      item
        DataSet = frxDBAutAba
        DataSetName = 'frxDBAutAba'
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
      DataSet = frxDBAutAba
      DataSetName = 'frxDBAutAba'
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 188.976500000000000000
          Top = 1.779530000000001000
          Width = 340.157700000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'AUTORIZA'#199#195'O DE ABASTECIMENTO')
          ParentFont = False
        end
        object SysMemo1: TfrxSysMemoView
          Align = baCenter
          Left = 222.992270000000000000
          Top = 31.236240000000000000
          Width = 272.126160000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Memo.UTF8W = (
            'Emitido em: [DATE] [TIME]')
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Top = 525.354670000000100000
        Width = 718.110700000000000000
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 370.393708110000000000
        Top = 94.488250000000000000
        Width = 718.110700000000000000
        object Memo23: TfrxMemoView
          Left = 16.456976060000000000
          Top = 60.795300000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'SEQU'#202'NCIA:')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 16.456976060000000000
          Top = 87.811070000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORNECEDOR:')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 15.118386060000000000
          Top = 33.559059999999990000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA EMISS'#195'O:')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 16.456976060000000000
          Top = 115.944960000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VE'#205'CULO:')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 16.456976060000000000
          Top = 143.842610000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COMBUST'#205'VEL:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 16.456976060000000000
          Top = 172.637910000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MOTORISTA:')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 16.456976060000000000
          Top = 202.433210000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VOL. / QTD LTS:')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 15.118120000000000000
          Top = 232.669450000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VLR ABASTECIMENTO:')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Align = baCenter
          Left = 202.204855000000000000
          Top = 310.803340000000000000
          Width = 313.700990000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '__________________________________________')
        end
        object Memo32: TfrxMemoView
          Left = 182.551190860000000000
          Top = 60.795300000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'ABA_SEQABA'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_SEQABA"]')
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 182.551190860000000000
          Top = 87.811070000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo12OnBeforePrint'
          DataField = 'ABA_CODFOR'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_CODFOR"]')
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 182.551190860000000000
          Top = 115.944960000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          OnAfterPrint = 'Memo13OnAfterPrint'
          DataField = 'ABA_PLAVEI'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_PLAVEI"]')
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 182.551190860000000000
          Top = 143.842610000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          DataField = 'ABA_COMBUS'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_COMBUS"]')
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 182.551190860000000000
          Top = 232.669450000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'ABA_VLRABA'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_VLRABA"]')
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 182.551190860000000000
          Top = 202.433210000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'ABA_QTDLTS'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_QTDLTS"]')
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 182.551190860000000000
          Top = 172.637910000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          DataField = 'ABA_CODMOT'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_CODMOT"]')
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 182.551190860000000000
          Top = 33.559059999999990000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'ABA_DTAEMI'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_DTAEMI"]')
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Align = baCenter
          Left = 287.244280000000000000
          Top = 331.598640000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Autorizo Abastecimento')
        end
        object Memo41: TfrxMemoView
          Left = 259.126426060000000000
          Top = 115.944960000000000000
          Width = 442.205010000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo20OnBeforePrint'
        end
        object Memo42: TfrxMemoView
          Left = 252.874254960000000000
          Top = 87.811070000000000000
          Width = 449.764070000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo21OnBeforePrint'
        end
        object Memo43: TfrxMemoView
          Left = 242.669716060000000000
          Top = 172.637910000000000000
          Width = 461.102660000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo22OnBeforePrint'
        end
        object Memo2: TfrxMemoView
          Left = 15.118120000000000000
          Top = 4.000000000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMPRESA:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 181.212334800000000000
          Top = 4.000000000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo12OnBeforePrint'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_CODEMP"]')
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 251.535398900000000000
          Top = 4.000000000000000000
          Width = 449.764070000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo4OnBeforePrint'
        end
        object Memo5: TfrxMemoView
          Left = 15.118120000000000000
          Top = 261.787570000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'KM ATUAL DO VE'#205'CULO:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 182.551190860000000000
          Top = 261.787570000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_KM_VEI"]')
          WordWrap = False
        end
      end
    end
  end
  object frxDBAutAba: TfrxDBDataset
    UserName = 'frxDBAutAba'
    CloseDataSource = False
    DataSource = frmCadAutAba.dtsAutAba_
    BCDToCurrency = False
    Left = 160
    Top = 24
  end
  object frxReportMatricial: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40988.466111284720000000
    ReportOptions.LastChange = 40988.485933159730000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure DMPMemo21OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  dmpFornecedor.Text := '#39' - '#39' + fRetNomFornecedor(<frxDBAutAba."' +
        'ABA_CODFOR">);                                                  ' +
        '          '
      'end;'
      ''
      'procedure dmpVeiculoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  dmpVeiculo.Text := '#39' - '#39' + fRetornaDescricaoVeic(<frxDBAutAba.' +
        '"ABA_PLAVEI">);                        '
      'end;'
      ''
      'procedure dmpMotoristaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  dmpMotorista.Text := '#39' - '#39' + fRetNomeMotorista(<frxDBAutAba."A' +
        'BA_CODMOT">);                        '
      'end;'
      ''
      'procedure DMPMemo23OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  DMPMemo23.Text := '#39' - '#39' + fRetNomeEmpresaSelec(<frxDBAutAba."A' +
        'BA_CODEMP">);                                                   ' +
        '         '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMatricialUserFunction
    Left = 96
    Top = 88
    Datasets = <
      item
        DataSet = frxDBAutAba
        DataSetName = 'frxDBAutAba'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 210.819863845504600000
      PaperHeight = 143.933240376448900000
      PaperSize = 256
      FontStyle = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 796.800000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 259.200000000000000000
          Top = 34.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'AUTORIZACAO DE ABASTECIMENTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Align = baCenter
          Left = 278.400000000000000000
          Top = 51.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Emitido em: [DATE] [TIME]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 24.000000000000000000
          Top = 76.500000000000000000
          Width = 748.800000000000000000
          Color = clBlack
        end
        object DMPCommand3: TfrxDMPCommand
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#67#33#27#80'
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 391.000000000000000000
        Top = 136.000000000000000000
        Width = 796.800000000000000000
        object DMPMemo3: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 34.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'SEQUENCIA..........:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 51.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'FORNECEDOR.........:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'EMISSAO............:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 68.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'VEICULO............:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 85.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'COMBUSTIVEL........:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 102.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'MOTORISTA..........:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 119.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'VOL. / QTD LTS.....:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 136.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'VLR ABASTECIMENTO..:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Align = baCenter
          Left = 172.800000000000000000
          Top = 272.000000000000000000
          Width = 460.800000000000000000
          Height = 51.000000000000000000
          Memo.UTF8W = (
            '________________________________________________')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo12: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
          Top = 323.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Autorizo Abastecimento')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataField = 'ABA_DTAEMI'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_DTAEMI"]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataField = 'ABA_SEQABA'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_SEQABA"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'ABA_CODFOR'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_CODFOR"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'ABA_PLAVEI'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_PLAVEI"]')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 85.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataField = 'ABA_COMBUS'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_COMBUS"]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 102.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'ABA_CODMOT'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_CODMOT"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 119.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataField = 'ABA_QTDLTS'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_QTDLTS"]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 136.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataField = 'ABA_VLRABA'
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_VLRABA"]')
          TruncOutboundText = False
        end
        object dmpFornecedor: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 51.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo21OnBeforePrint'
          TruncOutboundText = False
        end
        object dmpVeiculo: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 68.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'dmpVeiculoOnBeforePrint'
          TruncOutboundText = False
        end
        object dmpMotorista: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 102.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'dmpMotoristaOnBeforePrint'
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 19.200000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'EMPRESA............:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_CODEMP"]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo23OnBeforePrint'
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 153.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'KM ATUAL DO VEICULO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 153.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBAutAba
          DataSetName = 'frxDBAutAba'
          Memo.UTF8W = (
            '[frxDBAutAba."ABA_KM_VEI"]')
          TruncOutboundText = False
        end
      end
    end
  end
end
