object frmFatGorEmail: TfrmFatGorEmail
  Left = 0
  Top = 0
  ClientHeight = 162
  ClientWidth = 521
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
  object frxExportaPDF_R: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Compressed = True
    ReportOptions.CreateDate = 39598.687072094900000000
    ReportOptions.LastChange = 44069.450245000000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  fltUnitar   : Double;'
      '  fltTotIte   : Double;'
      '  fltTotProd  : Double;'
      '  fltTotPedOrc: Double;'
      '    '
      'procedure RelatorioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  {FORMATO O TAMANHO E CARREGO A IMAGEM}'
      '  If (<frxParametros."MODELO"> = '#39'2'#39') Then'
      '  Begin                      '
      '    Picture1.Width  := 731;'
      '    Picture1.Height := 189;'
      ''
      '    Line1.Top := 197;'
      ''
      '    RTTitulo.Height := 204;                                '
      '  End                '
      '  Else '
      '  Begin'
      '    Picture1.Width  := 239;'
      '    Picture1.Height := 106;'
      ''
      '    Line1.Top := 197;'
      ''
      '    RTTitulo.Height := 121;        '
      '  End;                  '
      '    '
      '  If (<frxParametros."IMAGEM"> <> '#39#39') Then'
      '    Picture1.LoadFromFile(<frxParametros."IMAGEM">);'
      ''
      
        '  {TOCO O NOME DO LABEL CONFORME ESPECIE DO DOCUMENTO}          ' +
        '                                                '
      '  If (<frxCabecalho."ESPDOC"> = '#39'PD'#39') Then'
      '  Begin              '
      '    lblTotalGeral.Text  := '#39'Total do Pedido : '#39';'
      '    lblData.Text        := '#39'Data do Pedido : '#39';  '
      '    lblValidade.Text    := '#39'Data de Previs'#227'o : '#39';'
      
        '    menValPre.DataField := '#39'PREVIS'#39';                            ' +
        '                                                  '
      '  End              '
      '  Else'
      '  Begin              '
      '    lblTotalGeral.Text := '#39'Total do Or'#231'amento : '#39';'
      '    lblData.Text       := '#39'Data do Or'#231'amento : '#39';  '
      '    lblValidade.Text   := '#39'Validade do Or'#231'amento : '#39';'
      '    menValPre.DataField := '#39'VALID'#39';        '
      '  End;              '
      '  '
      '  If (<frxTotais."TOTAL_DESC"> > 0) Then'
      '  Begin              '
      '    CTotalDescontos.Visible := True;'
      '  End            '
      '  Else        '
      '    CTotalDescontos.Visible := False;'
      ''
      '  If (<frxTotais."TOTAL_RET">) <= 0 Then'
      '  Begin'
      '    CTotalRet.Height := 0;'
      '    lblTotalRet.Visible  := False;'
      '    dbeTotal_Ret.visible := false;'
      '  End;        '
      ''
      '  If (<frxTotais."COM_IPI"> = '#39'N'#39') Then'
      '  Begin'
      '    CTotaIPI.Height      := 0;'
      '    lblTotalIPI.Visible  := False;'
      '    dbeTOTAL_IPI.Visible := False;'
      '    lblIPI.Visible       := False;'
      '    dbeIPI.Visible       := False;'
      '    LineIPI.Visible      := False;'
      '  End'
      '  Else'
      '  Begin'
      '    dbeTOTAL_IPI.Left    := 633;'
      '    dbeTOTAL_PROD.Left   := 633;'
      '    dbeTOTAL_RET.Left    := 633;        '
      '    dbeTOTAL_DESACE.Left := 633;        '
      '    dbeTOTAL_DESC.Left   := 633;'
      '    dbeTOTAL_Frete.Left  := 633;          '
      '    dbeTOTAL_PEDORC.Left := 633;'
      '    dbeTOTAL_VOLUME.Left := 633;          '
      '    dbeTOTAL_PESO.Left   := 633;          '
      '  End;  '
      '    '
      '  If (<frxTotais."TOTAL_FRETE"> > 0) Then'
      '  Begin'
      '    CTotalFrete.Visible := True;'
      '  End'
      '  Else'
      '  Begin'
      '    CTotalFrete.Height  := 0;      '
      '    CTotalFrete.Visible := False;'
      '  End;                  '
      ''
      '  If (<frxTotais."TOTAL_PEDORC"> > 0) Then'
      '  Begin'
      '    CTotalGeral.Visible := True;'
      '  End            '
      '  Else        '
      '    CTotalGeral.Visible := False;'
      'end;'
      ''
      'procedure MDItensOnBeforePrint(Sender: TfrxComponent);'
      'begin          '
      '  fltUnitar    := <frxItens."UNITAR">;'
      '  fltTotIte    := <frxItens."TOTITE">;'
      '  fltTotProd   := <frxTotais."TOTAL_PROD">;'
      '  fltTotPedOrc := <frxTotais."TOTAL_PEDORC">;'
      '  '
      
        '  rllMetragem.Text  := fDadosMetragem(<frxItens."APAREL">, <frxI' +
        'tens."BENEFI">, <frxItens."QTDPEC">, <frxItens."COMPEC">, <frxIt' +
        'ens."LARPEC">, <frxItens."ESPPEC">);'
      '  CMetragem.visible := rllMetragem.Text <> '#39#39';  '
      'end;'
      ''
      'procedure dbFoneEmpresaOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(dbFoneEmpresa.Text) <> '#39#39') Then'
      
        '    dbFoneEmpresa.Text := fFormataFoneInterna(dbFoneEmpresa.Text' +
        ');  '
      'end;'
      ''
      'procedure dbFaxEmpresaOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(dbFaxEmpresa.Text) <> '#39#39') Then'
      
        '    dbFaxEmpresa.Text := fFormataFoneInterna(dbFaxEmpresa.Text);' +
        '  '
      'end;'
      ''
      'procedure dbTelefoneClienteOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(dbTelefoneCliente.Text) <> '#39#39') Then'
      
        '    dbTelefoneCliente.Text := fFormataFoneInterna(dbTelefoneClie' +
        'nte.Text);  '
      'end;'
      ''
      'procedure dbeTotIteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If fDescontoCliente Then                                      ' +
        '              '
      
        '    dbeTotIte.Text := FormatFloat('#39'#,##0.00'#39', fltTotIte / ((100 ' +
        '- fGetDesCli)/100))'
      '  Else'
      '    dbeTotIte.Text := FormatFloat('#39'#,##0.00'#39', fltTotIte);  '
      'end;'
      ''
      'procedure dbePrecoUniOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If fDescontoCliente Then                                      ' +
        '              '
      
        '    dbePrecoUni.Text := FormatFloat('#39'#,##0.0000'#39', fltUnitar / ((' +
        '100 - fGetDesCli)/100))'
      '  Else'
      '    dbePrecoUni.Text := FormatFloat('#39'#,##0.0000'#39', fltUnitar);  '
      'end;'
      ''
      'procedure dbeTotIteVolOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If fDescontoCliente Then                                      ' +
        '              '
      
        '    dbeTotIteVol.Text := FormatFloat('#39'#,##0.00'#39', fltTotIte / ((1' +
        '00 - fGetDesCli)/100))'
      '  Else'
      '    dbeTotIteVol.Text := FormatFloat('#39'#,##0.00'#39', fltTotIte);  '
      'end;'
      ''
      'procedure dbePrecoUniVolOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If fDescontoCliente Then                                      ' +
        '              '
      
        '    dbePrecoUniVol.Text := FormatFloat('#39'#,##0.0000'#39', fltUnitar /' +
        ' ((100 - fGetDesCli)/100))'
      '  Else'
      
        '    dbePrecoUniVol.Text := FormatFloat('#39'#,##0.0000'#39', fltUnitar);' +
        '  '
      'end;'
      ''
      'procedure dbeTOTAL_PRODOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If fDescontoCliente Then                                      ' +
        '              '
      
        '    dbeTOTAL_PROD.Text := FormatFloat('#39'#,##0.00'#39', fltTotProd / (' +
        '(100 - fGetDesCli)/100))'
      '  Else'
      '    dbeTOTAL_PROD.Text := FormatFloat('#39'#,##0.00'#39', fltTotProd);  '
      'end;'
      ''
      'procedure dbeTOTAL_PEDORCOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If fDescontoCliente Then                                      ' +
        '              '
      
        '    dbeTOTAL_PEDORC.Text := FormatFloat('#39'#,##0.00'#39', fltTotPedOrc' +
        ' - fltTotProd + ( fltTotProd / (1 - fGetDesCli/100) ) )  '
      '  Else'
      
        '    dbeTOTAL_PEDORC.Text := FormatFloat('#39'#,##0.00'#39', fltTotPedOrc' +
        ');  '
      'end;'
      ''
      'Begin            '
      '  fltUnitar    := 0;'
      '  fltTotIte    := 0;'
      '  fltTotProd   := 0;'
      '  fltTotPedOrc := 0;'
      '    '
      '          '
      'end.')
    OnUserFunction = frxExportaPDF_RUserFunction
    Left = 312
    Top = 128
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxComplementares
        DataSetName = 'frxComplementares'
      end
      item
        DataSet = frxDuplicatas
        DataSetName = 'frxDuplicatas'
      end
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end
      item
        DataSet = frxParametros
        DataSetName = 'frxParametros'
      end
      item
        DataSet = frxServicos
        DataSetName = 'frxServicos'
      end
      item
        DataSet = frxTitulo
        DataSetName = 'frxTitulo'
      end
      item
        DataSet = frxTotais
        DataSetName = 'frxTotais'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Relatorio: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      OnBeforePrint = 'RelatorioOnBeforePrint'
      object RTTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 128.503937010000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object mmFoneEmpresa: TfrxMemoView
          Left = 272.716760000000000000
          Top = 73.456705120000000000
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
        end
        object mmFaxEmpresa: TfrxMemoView
          Left = 442.795610000000000000
          Top = 73.456705120000000000
          Width = 30.236240000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fax : ')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 118.047310000000000000
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object dbEmrpesa: TfrxMemoView
          Left = 272.126160000000000000
          Top = 3.338590000000000000
          Width = 480.000310000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxTitulo."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object dbEnderecoEmpresa: TfrxMemoView
          Left = 272.126160000000000000
          Top = 38.354372200000000000
          Width = 480.000310000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_ENDERE"]')
          ParentFont = False
          WordWrap = False
        end
        object dbFoneEmpresa: TfrxMemoView
          Left = 305.921460000000000000
          Top = 73.456705120000000000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          OnAfterData = 'dbFoneEmpresaOnAfterData'
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_FONE01"]')
          ParentFont = False
          WordWrap = False
        end
        object dbCEPEmpresa: TfrxMemoView
          Left = 273.275820000000000000
          Top = 89.826810700000000000
          Width = 480.000310000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_EMAIL_"]')
          ParentFont = False
          WordWrap = False
        end
        object dbFaxEmpresa: TfrxMemoView
          Left = 476.000310000000000000
          Top = 73.456705120000000000
          Width = 132.283550000000000000
          Height = 15.118110240000000000
          OnAfterData = 'dbFaxEmpresaOnAfterData'
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_F_A_X_"]')
          ParentFont = False
          WordWrap = False
        end
        object dbBairroEmpresa: TfrxMemoView
          Left = 272.275820000000000000
          Top = 55.472460470000000000
          Width = 480.000310000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_NOMCID"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 272.126160000000000000
          Top = 20.677180000000000000
          Width = 480.000310000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'C.N.P.J.: [FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxTitulo."' +
              'EMP_C_G_C_">)]')
          ParentFont = False
          WordWrap = False
        end
        object Picture1: TfrxPictureView
          Left = 15.118120000000000000
          Top = 2.118120000000001000
          Width = 234.330860000000000000
          Height = 105.826840000000000000
          Center = True
          KeepAspectRatio = False
          HightQuality = True
          Transparent = False
          TransparentColor = clWhite
        end
      end
      object HCabecalho: TfrxHeader
        FillType = ftBrush
        Height = 207.874150000000000000
        Top = 207.874150000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.CTituloItens
        object frxParametrosDOCUMENTO: TfrxMemoView
          Align = baCenter
          Left = 230.551330000000000000
          Top = 31.015770000000010000
          Width = 294.803340000000000000
          Height = 18.897650000000000000
          DataField = 'DOCUMENTO'
          DataSet = frxParametros
          DataSetName = 'frxParametros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxParametros."DOCUMENTO"]')
          ParentFont = False
        end
        object mmNomeCliente: TfrxMemoView
          Left = 11.338590000000000000
          Top = 92.354359999999990000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Raz'#227'o:  ')
          ParentFont = False
        end
        object dbNomeCliente: TfrxMemoView
          Left = 82.370130000000000000
          Top = 91.574830000000030000
          Width = 480.000310000000000000
          Height = 15.118120000000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object mmEnderecoCliente: TfrxMemoView
          Left = 11.338590000000000000
          Top = 124.351691390000000000
          Width = 64.252010000000000000
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
        end
        object dbEnderecoCliente: TfrxMemoView
          Left = 82.370130000000000000
          Top = 123.997423330000000000
          Width = 374.173470000000000000
          Height = 15.118110240000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."ENDERE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmFoneCliente: TfrxMemoView
          Left = 11.338590000000000000
          Top = 172.347688470000000000
          Width = 64.252010000000000000
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
        end
        object dbBairroCliente: TfrxMemoView
          Left = 525.456683150000000000
          Top = 123.677171860000000000
          Width = 226.771800000000000000
          Height = 15.118110240000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."BAIRRO"]')
          ParentFont = False
          WordWrap = False
        end
        object dbTelefoneCliente: TfrxMemoView
          Left = 82.370130000000000000
          Top = 172.631313330000000000
          Width = 233.071120000000000000
          Height = 15.118120000000000000
          OnAfterData = 'dbTelefoneClienteOnAfterData'
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."FONE01"]')
          ParentFont = False
        end
        object mmCNPJCliente: TfrxMemoView
          Left = 11.338590000000000000
          Top = 156.349022780000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[IIF(<frxCabecalho."CGCCPF"> = 1, '#39'CNPJ:'#39', '#39'CPF:'#39')]')
          ParentFont = False
        end
        object dbCNPJCliente: TfrxMemoView
          Left = 82.370130000000000000
          Top = 156.420016670000000000
          Width = 234.330860000000000000
          Height = 15.118110240000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxCabecalho."C_G_C_">) > 0,'
            '    IIF(<frxCabecalho."CGCCPF"> = '#39'1'#39','
            
              '    FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxCabecalho."C_G_' +
              'C_">),'
            '    FormatMaskText('#39'999.999.999-99;0'#39',<frxCabecalho."C_G_C_">)),'
            #39#39')]')
          ParentFont = False
        end
        object mmIECliente: TfrxMemoView
          Left = 461.425187090000000000
          Top = 156.089179450000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[IIF(<frxCabecalho."CGCCPF"> = 1, '#39'IE:'#39', '#39'RG:'#39')]  ')
          ParentFont = False
        end
        object dbIECliente: TfrxMemoView
          Left = 525.456683150000000000
          Top = 155.779513730000000000
          Width = 226.771800000000000000
          Height = 15.118110240000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."I_E_S_"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 11.338590000000000000
          Top = 188.346354170000000000
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
        end
        object rllTitVen: TfrxMemoView
          Left = 461.425187090000000000
          Top = 172.217766810000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 461.425187090000000000
          Top = 123.832004720000000000
          Width = 60.472440940000000000
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
        end
        object Memo19: TfrxMemoView
          Left = 11.338590000000000000
          Top = 140.350357080000000000
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
        end
        object Memo20: TfrxMemoView
          Left = 461.425187090000000000
          Top = 139.960592080000000000
          Width = 60.472440940000000000
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
        end
        object Memo21: TfrxMemoView
          Left = 461.425187090000000000
          Top = 188.346354170000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'E-Mail:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 82.370130000000000000
          Top = 140.208720000000000000
          Width = 374.173470000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."NOMCID"] / [frxCabecalho."ESTADO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 525.456683150000000000
          Top = 139.728342800000000000
          Width = 162.519790000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxCabecalho."C_E_P_">) > 0 ,'
            ' FormatMaskText('#39'00000-000;0'#39',<frxCabecalho."C_E_P_">),'#39#39')]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 525.338900000000000000
          Top = 171.830684660000000000
          Width = 226.771800000000000000
          Height = 15.118110240000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."NOMOPE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 525.338900000000000000
          Top = 187.881855590000000000
          Width = 226.771800000000000000
          Height = 15.118110240000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."EMAIL_"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 82.370130000000000000
          Top = 188.842610000000000000
          Width = 234.330860000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataCondPag(<frxCabecalho."CONPAG">)]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Align = baCenter
          Left = 257.008040000000000000
          Top = 4.000000000000000000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DEPARTAMENTO DE VENDAS')
          ParentFont = False
        end
        object frxParametrosSTATUS: TfrxMemoView
          Align = baCenter
          Left = 98.267780000000000000
          Top = 55.472480000000020000
          Width = 559.370440000000000000
          Height = 18.897650000000000000
          DataField = 'STATUS'
          DataSet = frxParametros
          DataSetName = 'frxParametros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxParametros."STATUS"]')
          ParentFont = False
        end
        object lblTitFan: TfrxMemoView
          Left = 11.338590000000000000
          Top = 108.353025690000000000
          Width = 64.252010000000000000
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
        end
        object lblNomFan: TfrxMemoView
          Left = 82.370130000000000000
          Top = 107.626000930000000000
          Width = 480.000310000000000000
          Height = 15.118120000000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."FANSOB"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbUrgente: TfrxMemoView
          Left = 674.535870000000000000
          Top = 4.000000000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataSet = frxParametros
          DataSetName = 'frxParametros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'URGENTE')
          ParentFont = False
        end
      end
      object MDItens: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 589.606680000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'MDItensOnBeforePrint'
        Child = frxExportaPDF_R.CMetragem
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object mmoDescri: TfrxMemoView
          Left = 130.472480000000000000
          Top = 1.440939999999955000
          Width = 213.543355910000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESCRI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 26.078740160000000000
          Top = 1.440939999999955000
          Width = 39.685036930000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDesMar: TfrxMemoView
          Left = 342.724409450000000000
          Top = 1.440939999999955000
          Width = 68.031540000000010000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 436.425480000000000000
          Top = 1.440939999999955000
          Width = 26.456710000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxItens."SIGUNI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbeQtd: TfrxMemoView
          Left = 461.606299210000000000
          Top = 1.440939999999955000
          Width = 41.574803150000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbePrecoUni: TfrxMemoView
          Left = 593.952736380000000000
          Top = 1.440939999999955000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'dbePrecoUniOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."UNITAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbeTotIte: TfrxMemoView
          Left = 651.063390000000000000
          Top = 1.440939999999955000
          Width = 64.251963620000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'dbeTotIteOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."TOTITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbeIPI: TfrxMemoView
          Left = 715.433520000000000000
          Top = 1.440939999999955000
          Width = 41.574798270000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."VALIPI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object MemoC55: TfrxMemoView
          Left = 410.574798260000000000
          Top = 1.440939999999955000
          Width = 24.566929130000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[fRetClaIpi(<frxItens."CLAIPI">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmDescontoDetalhe: TfrxMemoView
          Left = 554.031849999999900000
          Top = 1.440939999999955000
          Width = 39.685039370000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."DESCON"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 2.000000000000000000
          Top = 1.440939999999955000
          Width = 20.787401570000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Line#]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbePrecoDig: TfrxMemoView
          Left = 504.692913390000000000
          Top = 1.440939999999955000
          Width = 49.133858270000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."UNIDIG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 67.031540000000010000
          Top = 1.511811019999982000
          Width = 62.362216930000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODFAB"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object PFRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 1303.937850000000000000
        Width = 755.906000000000000000
        object Memo39: TfrxMemoView
          Left = 570.897960000000000000
          Top = 2.000000000000000000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          ParentFont = False
        end
        object Line15: TfrxLineView
          Top = 1.779530000000022000
          Width = 755.905511811024000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object CTotalDescontos: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 801.260360000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.CTotaIPI
        PrintChildIfInvisible = True
        object lblTotalDescontos: TfrxMemoView
          Left = 421.496290000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118110236220500000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total do(s) Desconto(s) : ')
          ParentFont = False
        end
        object dbeTOTAL_DESC: TfrxMemoView
          Left = 589.811380000000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118110236220500000
          DataSet = frxTotais
          DataSetName = 'frxTotais'
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
            '[frxTotais."TOTAL_DESC"]')
          ParentFont = False
        end
      end
      object CTotaIPI: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 842.835190000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.CTotalFrete
        PrintChildIfInvisible = True
        object lblTotalIPI: TfrxMemoView
          Left = 421.496290000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118110236220500000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total do IPI : ')
          ParentFont = False
        end
        object dbeTOTAL_IPI: TfrxMemoView
          Left = 589.811380000000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118110236220500000
          DataSet = frxTotais
          DataSetName = 'frxTotais'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotais."TOTAL_IPI"]')
          ParentFont = False
        end
      end
      object CTotalGeral: TfrxChild
        FillType = ftBrush
        Height = 18.897637795275600000
        Top = 1009.134510000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.CTotalVolumes
        PrintChildIfInvisible = True
        object lblTotalGeral: TfrxMemoView
          Left = 421.496290000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118110236220500000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total  : ')
          ParentFont = False
        end
        object dbeTOTAL_PEDORC: TfrxMemoView
          Left = 589.811380000000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118110236220500000
          OnBeforePrint = 'dbeTOTAL_PEDORCOnBeforePrint'
          DataSet = frxTotais
          DataSetName = 'frxTotais'
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
            '[frxTotais."TOTAL_PEDORC"]')
          ParentFont = False
        end
      end
      object CTituloItens: TfrxChild
        FillType = ftBrush
        Height = 54.047244090000000000
        Top = 438.425480000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.CTituloItensVolume
        PrintChildIfInvisible = True
        object mmoTitCodIte: TfrxMemoView
          Left = 24.078740160000000000
          Top = 31.000000000000000000
          Width = 43.464554720000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoTitDesIte: TfrxMemoView
          Left = 130.472480000000000000
          Top = 31.000000000000000000
          Width = 209.763825910000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoMarca: TfrxMemoView
          Left = 342.724409450000000000
          Top = 31.000000000000000000
          Width = 68.031540000000010000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 436.425480000000000000
          Top = 31.000000000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Un')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblQtd: TfrxMemoView
          Left = 461.425480000000000000
          Top = 31.000000000000000000
          Width = 41.574805590000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quant.')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblPrecoUni: TfrxMemoView
          Left = 595.952736380000000000
          Top = 31.000000000000000000
          Width = 54.803154490000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Unt. Liq.')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblTotIte: TfrxMemoView
          Left = 652.063390000000000000
          Top = 31.000000000000000000
          Width = 64.251963620000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Pre'#231'o Total')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblIPI: TfrxMemoView
          Left = 719.433520000000000000
          Top = 31.000000000000000000
          Width = 34.015738270000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vr. IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          Left = -18.000000000000000000
          Top = 26.000000000000000000
          Width = 793.700787400000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Top = 49.456709999999990000
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line8: TfrxLineView
          Left = 128.472480000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linMarca: TfrxLineView
          Left = 342.582870000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line11: TfrxLineView
          Left = 435.984540000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line12: TfrxLineView
          Left = 459.661720000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line13: TfrxLineView
          Left = 503.779840000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line14: TfrxLineView
          Left = 594.709030000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object LineIPI: TfrxLineView
          Left = 715.961040000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo6: TfrxMemoView
          Top = 2.677180000000021000
          Width = 755.905433700000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Fill.BackColor = clSilver
          HAlign = haCenter
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baCenter
          Left = 291.023810000000000000
          Top = 6.000000000000000000
          Width = 173.858380000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'MATERIAIS SOLICITADOS')
          ParentFont = False
        end
        object MemoC53: TfrxMemoView
          Left = 410.574798260000000000
          Top = 31.000000000000000000
          Width = 24.566929130000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Leg')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line2: TfrxLineView
          Left = 410.661720000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object ln1: TfrxLineView
          Left = 553.575140000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmDescontoTituloItem: TfrxMemoView
          Left = 554.031849999999900000
          Top = 31.000000000000000000
          Width = 39.685039370000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%Desc')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 2.000000000000000000
          Top = 31.000000000000000000
          Width = 18.897640240000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'N'#186)
          ParentFont = False
          VAlign = vaCenter
        end
        object Line23: TfrxLineView
          Left = 24.118120000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line31: TfrxLineView
          Left = 651.622450000000000000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object lblPrecoDig: TfrxMemoView
          Left = 504.795610000000000000
          Top = 31.000000000000000000
          Width = 48.755905510000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Unt. Bru.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 69.992160160000000000
          Top = 30.677180000000020000
          Width = 54.803144720000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'd.Fab')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line33: TfrxLineView
          Left = 68.031540000000000000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object FTotalProdutos: TfrxFooter
        FillType = ftBrush
        Height = 18.897637795275600000
        Top = 714.331170000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.CServicos
        PrintChildIfInvisible = True
        object dbeTOTAL_PROD: TfrxMemoView
          Left = 589.811380000000000000
          Top = 2.000000000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'dbeTOTAL_PRODOnBeforePrint'
          DataSet = frxTotais
          DataSetName = 'frxTotais'
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
            '[frxTotais."TOTAL_PROD"]')
          ParentFont = False
        end
        object lblTotalProdutos: TfrxMemoView
          Left = 421.496290000000000000
          Top = 1.779530000000022000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total do(s) Produto(s) : ')
          ParentFont = False
        end
        object Line9: TfrxLineView
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1217.008660000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.CMsgPed
        PrintChildIfInvisible = True
        object Subreport1: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxExportaPDF_R.Page1
        end
      end
      object CServicos: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 755.906000000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.CTotalDescontos
        PrintChildIfInvisible = True
        object Subreport2: TfrxSubreport
          Top = 3.779530000000022000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxExportaPDF_R.Page2
        end
        object Line19: TfrxLineView
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object CTotalFrete: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 884.410020000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.CTotalRet
        PrintChildIfInvisible = True
        object lblTotalFrete: TfrxMemoView
          Left = 420.937230000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118110236220500000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total do Frete : ')
          ParentFont = False
        end
        object dbeTOTAL_Frete: TfrxMemoView
          Left = 589.811380000000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118110236220500000
          DataSet = frxTotais
          DataSetName = 'frxTotais'
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
            '[frxTotais."TOTAL_FRETE"]')
          ParentFont = False
        end
      end
      object CTotalRet: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 925.984850000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.CDespesasAces
        PrintChildIfInvisible = True
        object lblTotalRet: TfrxMemoView
          Left = 420.937230000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118110236220500000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Sub. Tributaria :')
          ParentFont = False
        end
        object dbeTOTAL_RET: TfrxMemoView
          Left = 589.811380000000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118110236220500000
          DataSet = frxTotais
          DataSetName = 'frxTotais'
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
            '[frxTotais."TOTAL_RET"]')
          ParentFont = False
        end
      end
      object CTituloItensVolume: TfrxChild
        FillType = ftBrush
        Height = 54.047244090000000000
        Top = 514.016080000000000000
        Width = 755.906000000000000000
        PrintChildIfInvisible = True
        object mmoTitCodIteVol: TfrxMemoView
          Left = 24.078740160000000000
          Top = 29.464562050000040000
          Width = 43.464566929999990000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoTitDesIteVol: TfrxMemoView
          Left = 130.472480000000000000
          Top = 29.464562050000040000
          Width = 179.527605430000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoMarcaVol: TfrxMemoView
          Left = 316.267699450000000000
          Top = 29.464562050000040000
          Width = 68.031540000000010000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 386.480520000000000000
          Top = 29.464562050000040000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Un.')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblQtdVol: TfrxMemoView
          Left = 461.291338580000000000
          Top = 29.464562050000040000
          Width = 41.574803150000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quant.')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblPrecoUniVol: TfrxMemoView
          Left = 596.952736380000000000
          Top = 29.464562050000040000
          Width = 52.913383390000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Unt. Liq.')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblTotIteVol: TfrxMemoView
          Left = 652.063390000000000000
          Top = 29.464562050000040000
          Width = 64.251963620000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Pre'#231'o Total')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblIPIVol: TfrxMemoView
          Left = 718.433520000000000000
          Top = 29.464562050000040000
          Width = 34.015738270000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vr. IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line20: TfrxLineView
          Top = 48.456710000000040000
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line21: TfrxLineView
          Left = 128.472480000000000000
          Top = 25.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linMarcaVol: TfrxLineView
          Left = 315.685220000000000000
          Top = 25.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line24: TfrxLineView
          Left = 383.866420000000000000
          Top = 25.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line25: TfrxLineView
          Left = 453.669291338583000000
          Top = 25.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line26: TfrxLineView
          Left = 503.779840000000000000
          Top = 25.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line27: TfrxLineView
          Left = 594.709030000000000000
          Top = 25.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line28: TfrxLineView
          Left = 715.961040000000000000
          Top = 25.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo52: TfrxMemoView
          Top = 2.677180000000021000
          Width = 755.906000000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Fill.BackColor = clSilver
          HAlign = haCenter
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Align = baCenter
          Left = 291.023810000000000000
          Top = 6.000000000000000000
          Width = 173.858380000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'MATERIAIS SOLICITADOS')
          ParentFont = False
        end
        object Line29: TfrxLineView
          Left = 410.661720000000000000
          Top = 25.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo54: TfrxMemoView
          Left = 411.834880000000000000
          Top = 29.464562050000040000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Volume')
          ParentFont = False
          VAlign = vaCenter
        end
        object ln2: TfrxLineView
          Left = 553.575140000000000000
          Top = 25.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmDescontoTituloVolume: TfrxMemoView
          Left = 554.031849999999900000
          Top = 29.464562050000040000
          Width = 39.685039370000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%Desc')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 2.000000000000000000
          Top = 29.464562050000040000
          Width = 18.897640240000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'N'#186)
          ParentFont = False
          VAlign = vaCenter
        end
        object Line30: TfrxLineView
          Left = 24.118120000000000000
          Top = 25.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line32: TfrxLineView
          Left = 651.622450000000000000
          Top = 25.456710000000040000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object lblPrecoDigVol: TfrxMemoView
          Left = 504.692913390000000000
          Top = 29.236239999999960000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Unt. Bru.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 69.992160160000000000
          Top = 28.677180000000020000
          Width = 54.803144720000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'd.Fab')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line34: TfrxLineView
          Left = 68.031540000000000000
          Top = 25.456710000000040000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object MDItensVolume: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 631.181510000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'MDItensOnBeforePrint'
        Child = frxExportaPDF_R.CMetragem
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object mmoDescriVol: TfrxMemoView
          Left = 130.472480000000000000
          Top = 1.440939999999955000
          Width = 183.307135430000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESCRI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Left = 26.078740160000000000
          Top = 1.440939999999955000
          Width = 39.685036930000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoDesMarVol: TfrxMemoView
          Left = 316.267699450000000000
          Top = 1.440939999999955000
          Width = 68.031540000000010000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 386.480520000000000000
          Top = 1.440939999999955000
          Width = 22.677180000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxItens."SIGUNI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbeQtdVol: TfrxMemoView
          Left = 461.291338580000000000
          Top = 1.440939999999955000
          Width = 41.574803150000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbePrecoUniVol: TfrxMemoView
          Left = 593.826771650000000000
          Top = 1.440939999999955000
          Width = 56.692918270000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'dbePrecoUniVolOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."UNITAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbeTotIteVol: TfrxMemoView
          Left = 651.063390000000000000
          Top = 1.440939999999955000
          Width = 64.251963620000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'dbeTotIteVolOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."TOTITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbeIPIVol: TfrxMemoView
          Left = 715.433520000000000000
          Top = 1.440939999999955000
          Width = 41.574798270000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."VALIPI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo63: TfrxMemoView
          Left = 412.834880000000000000
          Top = 1.440939999999955000
          Width = 45.354360000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."VOLITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmDescontoDetalheVolume: TfrxMemoView
          Left = 554.031849999999900000
          Top = 1.440939999999955000
          Width = 39.685039370000000000
          Height = 15.118110240000000000
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
            '[frxItens."DESCON"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 2.000000000000000000
          Top = 1.440939999999955000
          Width = 20.787401570000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Line#]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbePrecoDigVol: TfrxMemoView
          Left = 504.692913390000000000
          Top = 1.440939999999955000
          Width = 49.133858270000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."UNIDIG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 67.031540000000010000
          Top = 1.511811019999982000
          Width = 62.362216930000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODFAB"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object CTotalVolumes: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 1050.709340000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.CPeso
        PrintChildIfInvisible = True
        object Memo64: TfrxMemoView
          Left = 420.937230000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118110236220500000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Volume : ')
          ParentFont = False
        end
        object dbeTOTAL_VOLUME: TfrxMemoView
          Left = 589.811380000000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118110236220500000
          DataSet = frxTotais
          DataSetName = 'frxTotais'
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
            '[SUM(<frxItens."VOLITE">,MDItensVolume)]')
          ParentFont = False
        end
      end
      object CPorDes: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1133.859000000000000000
        Width = 755.906000000000000000
        PrintChildIfInvisible = True
        object Memo61: TfrxMemoView
          Left = 7.559060000000000000
          Width = 721.890230000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Desconto concedido j'#225' distribuido nos itens de [FormatFloat('#39'#,#' +
              '#0.00'#39',<frxCabecalho."PORDES">)]%')
          ParentFont = False
        end
      end
      object CPeso: TfrxChild
        FillType = ftBrush
        Height = 18.897637795275600000
        Top = 1092.284170000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.CPorDes
        PrintChildIfInvisible = True
        object Memo49: TfrxMemoView
          Left = 420.937230000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118110236220500000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Peso : ')
          ParentFont = False
        end
        object dbeTOTAL_PESO: TfrxMemoView
          Left = 589.811380000000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118110236220500000
          DataSet = frxTotais
          DataSetName = 'frxTotais'
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
            '[frxTotais."PESBRU"]')
          ParentFont = False
        end
      end
      object CMetragem: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 672.756340000000000000
        Width = 755.906000000000000000
        object rllMetragem: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 748.346940000000000000
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
      object CDespesasAces: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 967.559680000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.CTotalGeral
        PrintChildIfInvisible = True
        object Memo26: TfrxMemoView
          Left = 420.937230000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118110236220500000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Despesas Acess'#243'rias :')
          ParentFont = False
        end
        object dbeTOTAL_DESACE: TfrxMemoView
          Left = 589.811380000000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118110236220500000
          DataSet = frxTotais
          DataSetName = 'frxTotais'
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
            '[frxTotais."TOTAL_DESACE"]')
          ParentFont = False
        end
      end
      object CMsgPed: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 1262.363020000000000000
        Width = 755.906000000000000000
        Stretched = True
        object Memo55: TfrxMemoView
          Left = 1.897650000000000000
          Top = 0.377952759999971000
          Width = 748.346940000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MSGPED]')
          ParentFont = False
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
        Height = 41.574830000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo36: TfrxMemoView
          Left = 328.803340000000000000
          Top = 24.897650000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 452.527830000000000000
          Top = 24.897650000000000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
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
        end
        object Memo40: TfrxMemoView
          Left = 215.740260000000000000
          Top = 25.677180000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parcela')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Align = baCenter
          Left = 291.023810000000000000
          Top = 4.779530000000000000
          Width = 173.858380000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Prazos para Pagamento')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Top = 1.779530000000000000
          Width = 755.905511810000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 83.149660000000000000
        Width = 755.906000000000000000
        DataSet = frxDuplicatas
        DataSetName = 'frxDuplicatas'
        RowCount = 0
        object Memo31: TfrxMemoView
          Left = 450.527830000000000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
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
        end
        object Memo30: TfrxMemoView
          Left = 326.803340000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDuplicatas."VENCIMENTO"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 213.740260000000000000
          Width = 94.488250000000000000
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
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 87.456710000000000000
        Top = 120.944960000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.Child1
        Stretched = True
        object Memo43: TfrxMemoView
          Left = 3.779530000000000000
          Top = 64.779530000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Mensagem : ')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Top = 0.779529999999994000
          Width = 755.905511810000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo72: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559060000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Transportadora:')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 99.826840000000000000
          Top = 7.559060000000000000
          Width = 608.504330000000000000
          Height = 15.118120000000000000
          DataField = 'TRANSP'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxCabecalho."TRANSP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo74: TfrxMemoView
          Left = 99.826840000000000000
          Top = 26.338590000000000000
          Width = 608.504330000000000000
          Height = 15.118120000000000000
          DataField = 'ENDTRA'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."ENDTRA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo75: TfrxMemoView
          Left = 99.826840000000000000
          Top = 45.118120000000000000
          Width = 608.504330000000000000
          Height = 15.118120000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxCabecalho."BAITRA"] - CEP: [frxCabecalho."CEPTRA"] - [frxCab' +
              'ecalho."CIDTRA"]/[frxCabecalho."ESTTRA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo51: TfrxMemoView
          Left = 99.826840000000000000
          Top = 64.779530000000000000
          Width = 608.504330000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxComplementares."MSGORC"]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 230.551330000000000000
        Width = 755.906000000000000000
        Child = frxExportaPDF_R.Child3
        Stretched = True
        object MemoC56: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779529999999990000
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
        end
        object MemoC57: TfrxMemoView
          Left = 71.811030940000000000
          Top = 3.779529999999990000
          Width = 638.740342990000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frmQckHTMLDocumentos.frxServicos
          DataSetName = 'frxServicos'
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
        Height = 79.370130000000000000
        Top = 275.905690000000000000
        Width = 755.906000000000000000
        object lblData: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000020000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data : ')
          ParentFont = False
        end
        object lblValidade: TfrxMemoView
          Left = 3.779530000000000000
          Top = 23.477180000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Validade do Or'#231'amento:')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 155.826840000000000000
          Top = 3.779530000000020000
          Width = 506.457020000000000000
          Height = 15.118120000000000000
          DataField = 'DATA'
          DataSet = frxComplementares
          DataSetName = 'frxComplementares'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxComplementares."DATA"]')
          ParentFont = False
        end
        object menValPre: TfrxMemoView
          Left = 155.826840000000000000
          Top = 23.477180000000000000
          Width = 506.457020000000000000
          Height = 15.118120000000000000
          DataField = 'VALID'
          DataSet = frxComplementares
          DataSetName = 'frxComplementares'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxComplementares."VALID"]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 3.779530000000000000
          Top = 43.174830000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Frete por Conta do:')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 155.826840000000000000
          Top = 43.174830000000000000
          Width = 506.457020000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DataSet = frxComplementares
          DataSetName = 'frxComplementares'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxComplementares."FRETE"]')
          ParentFont = False
        end
        object rllTitRep: TfrxMemoView
          Left = 3.779530000000000000
          Top = 61.237910000000000000
          Width = 147.401670000000000000
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
          Left = 155.826840000000000000
          Top = 61.237910000000000000
          Width = 506.456792990000000000
          Height = 15.118110240000000000
          DataField = 'REPRES'
          DataSet = frxComplementares
          DataSetName = 'frxComplementares'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxComplementares."REPRES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 151.181200000000000000
        Width = 755.906000000000000000
        object Memo14: TfrxMemoView
          Left = 661.811380000000000000
          Top = 4.000000000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'TOTSER'
          DataSet = frxServicos
          DataSetName = 'frxServicos'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxServicos."TOTSER"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 534.661720000000000000
          Top = 3.779529999999990000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total do(s) Serv'#231'o(s) : ')
          ParentFont = False
        end
        object Line18: TfrxLineView
          Top = 21.897650000000000000
          Width = 755.905511811024000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line7: TfrxLineView
          Top = 1.000000000000000000
          Width = 755.905511811024000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 109.606370000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'MasterData2OnBeforePrint'
        DataSet = frxServicos
        DataSetName = 'frxServicos'
        RowCount = 0
        object Memo9: TfrxMemoView
          Left = 62.472480000000000000
          Top = 1.440940000000000000
          Width = 585.827150000000000000
          Height = 15.118110240000000000
          DataField = 'DESSER'
          DataSet = frxServicos
          DataSetName = 'frxServicos'
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
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.000000000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DataField = 'CODSER'
          DataSet = frxServicos
          DataSetName = 'frxServicos'
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
        end
        object Memo32: TfrxMemoView
          Left = 661.811380000000000000
          Top = 1.440940000000000000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DataField = 'VALSER'
          DataSet = frxServicos
          DataSetName = 'frxServicos'
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
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 60.472480000000000000
        Width = 755.906000000000000000
        object Memo34: TfrxMemoView
          Left = 3.779530000000000000
          Top = 5.999999999999990000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 62.472480000000000000
          Top = 5.999999999999990000
          Width = 585.827150000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 661.811380000000000000
          Top = 5.999999999999990000
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
            'Pre'#231'o Total')
          ParentFont = False
        end
        object Line10: TfrxLineView
          Top = 1.000000000000000000
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line16: TfrxLineView
          Top = 24.456710000000000000
          Width = 755.905511811024000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line17: TfrxLineView
          Left = 58.472480000000000000
          Top = 1.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line22: TfrxLineView
          Left = 654.724800000000000000
          Top = 1.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo33: TfrxMemoView
          Width = 755.905543540000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Align = baCenter
          Left = 292.913575000000000000
          Top = 0.779530000000001000
          Width = 170.078850000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'SERVI'#199'OS')
          ParentFont = False
        end
      end
    end
  end
  object frxParametros: TfrxUserDataSet
    UserName = 'frxParametros'
    Fields.Strings = (
      'IMAGEM'
      'DOCUMENTO'
      'PRECO'
      'STATUS'
      'MODELO')
    OnGetValue = frxParametrosGetValue
    Left = 408
    Top = 72
  end
  object frxTitulo: TfrxDBDataset
    UserName = 'frxTitulo'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 80
    Top = 16
  end
  object frxCabecalho: TfrxDBDataset
    UserName = 'frxCabecalho'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 320
    Top = 16
  end
  object frxItens: TfrxDBDataset
    UserName = 'frxItens'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 32
    Top = 16
  end
  object frxTotais: TfrxDBDataset
    UserName = 'frxTotais'
    CloseDataSource = False
    FieldAliases.Strings = (
      'TOTAL_PROD=TOTAL_PROD'
      'TOTAL_DESC=TOTAL_DESC'
      'TOTAL_IPI=TOTAL_IPI'
      'TOTAL_PEDORC=TOTAL_PEDORC'
      'COM_IPI=COM_IPI'
      'TOTAL_FRETE=TOTAL_FRETE'
      'TOTAL_RET=TOTAL_RET'
      'PESBRU=PESBRU'
      'TOTAL_DESACE=TOTAL_DESACE')
    DataSet = cdsTotais
    BCDToCurrency = False
    Left = 128
    Top = 16
  end
  object frxDuplicatas: TfrxDBDataset
    UserName = 'frxDuplicatas'
    CloseDataSource = False
    DataSet = cdsDuplicatas
    BCDToCurrency = False
    Left = 248
    Top = 16
  end
  object cdsDuplicatas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 72
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
  object cdsTotais: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 72
    object cdsTotaisTOTAL_PROD: TFloatField
      FieldName = 'TOTAL_PROD'
    end
    object cdsTotaisTOTAL_DESC: TFloatField
      FieldName = 'TOTAL_DESC'
    end
    object cdsTotaisTOTAL_IPI: TFloatField
      FieldName = 'TOTAL_IPI'
    end
    object cdsTotaisTOTAL_PEDORC: TFloatField
      FieldName = 'TOTAL_PEDORC'
    end
    object cdsTotaisCOM_IPI: TStringField
      FieldName = 'COM_IPI'
      Size = 1
    end
    object cdsTotaisTOTAL_FRETE: TFloatField
      FieldName = 'TOTAL_FRETE'
    end
    object cdsTotaisTOTAL_RET: TFloatField
      FieldName = 'TOTAL_RET'
    end
    object cdsTotaisPESBRU: TFloatField
      FieldName = 'PESBRU'
    end
    object cdsTotaisTOTAL_DESACE: TFloatField
      FieldName = 'TOTAL_DESACE'
    end
  end
  object frxComplementares: TfrxDBDataset
    UserName = 'frxComplementares'
    CloseDataSource = False
    DataSet = cdsComplementares
    BCDToCurrency = False
    Left = 408
    Top = 16
  end
  object cdsComplementares: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 72
    object cdsComplementaresMENS01: TStringField
      FieldName = 'MENS01'
      Size = 255
    end
    object cdsComplementaresMENS02: TStringField
      FieldName = 'MENS02'
      Size = 255
    end
    object cdsComplementaresDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsComplementaresPREVIS: TDateField
      FieldName = 'PREVIS'
    end
    object cdsComplementaresVALID: TDateField
      FieldName = 'VALID'
    end
    object cdsComplementaresFRETE: TStringField
      FieldName = 'FRETE'
      Size = 150
    end
    object cdsComplementaresMSGORC: TStringField
      FieldName = 'MSGORC'
      Size = 200
    end
    object cdsComplementaresREPRES: TStringField
      FieldName = 'REPRES'
      Size = 35
    end
  end
  object frxExportaPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
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
    Left = 32
    Top = 128
  end
  object frxExportaXLS: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 112
    Top = 128
  end
  object cdsServicos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 72
    object cdsServicosCODSER: TStringField
      FieldName = 'CODSER'
      Size = 5
    end
    object cdsServicosDESSER: TStringField
      FieldName = 'DESSER'
      Size = 95
    end
    object cdsServicosVALSER: TFloatField
      FieldName = 'VALSER'
    end
    object cdsServicosTOTSER: TFloatField
      FieldName = 'TOTSER'
    end
    object cdsServicosPERISS: TFloatField
      FieldName = 'PERISS'
    end
    object cdsServicosVALISS: TFloatField
      FieldName = 'VALISS'
    end
  end
  object frxServicos: TfrxDBDataset
    UserName = 'frxServicos'
    CloseDataSource = False
    DataSet = cdsServicos
    BCDToCurrency = False
    Left = 184
    Top = 16
  end
  object frxExportaODS: TfrxODSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    CreationTime = 0.000000000000000000
    DataOnly = False
    PictureType = gpPNG
    Background = True
    Creator = 'FastReport'
    SingleSheet = False
    Language = 'en'
    SuppressPageHeadersFooters = False
    Left = 192
    Top = 128
  end
  object frxExportaPDF_P: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Compressed = True
    ReportOptions.CreateDate = 39598.687072094900000000
    ReportOptions.LastChange = 41222.693395000000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  fltUnitar   : Double;'
      '  fltTotIte   : Double;'
      '  fltTotProd  : Double;'
      '  fltTotPedOrc: Double;'
      '    '
      'procedure RelatorioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  {CARREGO A IMAGEM}             '
      '  If (<frxParametros."IMAGEM"> <> '#39#39') Then'
      '    Picture1.LoadFromFile(<frxParametros."IMAGEM">);'
      ''
      
        '  {TOCO O NOME DO LABEL CONFORME ESPECIE DO DOCUMENTO}          ' +
        '                                                '
      '  If (<frxCabecalho."ESPDOC"> = '#39'PD'#39') Then'
      '  Begin              '
      '    lblTotalGeral.Text  := '#39'Total do Pedido : '#39';'
      '    lblData.Text        := '#39'Data do Pedido : '#39';  '
      '    lblValidade.Text    := '#39'Data de Previs'#227'o : '#39';'
      
        '    menValPre.DataField := '#39'PREVIS'#39';                            ' +
        '                                                  '
      '  End              '
      '  Else'
      '  Begin              '
      '    lblTotalGeral.Text := '#39'Total do Or'#231'amento : '#39';'
      '    lblData.Text       := '#39'Data do Or'#231'amento : '#39';  '
      '    lblValidade.Text   := '#39'Validade do Or'#231'amento : '#39';'
      '    menValPre.DataField := '#39'VALID'#39';        '
      '  End;              '
      '  '
      '  If (<frxTotais."TOTAL_DESC"> > 0) Then'
      '  Begin              '
      '    CTotalDescontos.Visible := True;'
      '  End            '
      '  Else        '
      '    CTotalDescontos.Visible := False;'
      ''
      '  If (<frxTotais."TOTAL_RET">) <= 0 Then'
      '  Begin'
      '    CTotalRet.Height := 0;'
      '    lblTotalRet.Visible  := False;'
      '    dbeTotal_Ret.visible := false;'
      '  End;        '
      ''
      '  If (<frxTotais."COM_IPI"> = '#39'N'#39') Then'
      '  Begin'
      '    CTotaIPI.Height      := 0;'
      '    lblTotalIPI.Visible  := False;'
      '    dbeTOTAL_IPI.Visible := False;'
      '    lblIPI.Visible       := False;'
      '    dbeIPI.Visible       := False;'
      '    LineIPI.Visible      := False;'
      '    lblPIPI.Visible      := False;'
      '    dbePIPI.Visible      := False;'
      '    LinePIPI.Visible     := False;'
      '  End'
      '  Else'
      '  Begin'
      '    dbeTOTAL_IPI.Left    := 900;'
      '    dbeTOTAL_PROD.Left   := 900;'
      '    dbeTOTAL_RET.Left    := 900;        '
      '    dbeTOTAL_DESACE.Left := 900;        '
      '    dbeTOTAL_DESC.Left   := 900;'
      '    dbeTOTAL_Frete.Left  := 900;          '
      '    dbeTOTAL_PEDORC.Left := 900;'
      '    dbeTOTAL_VOLUME.Left := 900;          '
      '    dbeTOTAL_PESO.Left   := 900;          '
      '  End;  '
      '    '
      '  If (<frxTotais."TOTAL_FRETE"> > 0) Then'
      '  Begin'
      '    CTotalFrete.Visible := True;'
      '  End'
      '  Else'
      '  Begin'
      '    CTotalFrete.Height  := 0;      '
      '    CTotalFrete.Visible := False;'
      '  End;                  '
      ''
      '  If (<frxTotais."TOTAL_PEDORC"> > 0) Then'
      '  Begin'
      '    CTotalGeral.Visible := True;'
      '  End            '
      '  Else        '
      '    CTotalGeral.Visible := False;     '
      'end;'
      ''
      'procedure MDItensOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltUnitar    := <frxItens."UNITAR">;'
      '  fltTotIte    := <frxItens."TOTITE">;'
      '  fltTotProd   := <frxTotais."TOTAL_PROD">;'
      '  fltTotPedOrc := <frxTotais."TOTAL_PEDORC">;'
      '  '
      
        '  rllMetragem.Text  := fDadosMetragem(<frxItens."APAREL">, <frxI' +
        'tens."BENEFI">, <frxItens."QTDPEC">, <frxItens."COMPEC">, <frxIt' +
        'ens."LARPEC">, <frxItens."ESPPEC">);'
      '  CMetragem.visible := rllMetragem.Text <> '#39#39';  '
      'end;'
      ''
      'procedure dbFoneEmpresaOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(dbFoneEmpresa.Text) <> '#39#39') Then'
      
        '    dbFoneEmpresa.Text := fFormataFoneInterna(dbFoneEmpresa.Text' +
        ');  '
      'end;'
      ''
      'procedure dbFaxEmpresaOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(dbFaxEmpresa.Text) <> '#39#39') Then'
      
        '    dbFaxEmpresa.Text := fFormataFoneInterna(dbFaxEmpresa.Text);' +
        '  '
      'end;'
      ''
      'procedure dbTelefoneClienteOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(dbTelefoneCliente.Text) <> '#39#39') Then'
      
        '    dbTelefoneCliente.Text := fFormataFoneInterna(dbTelefoneClie' +
        'nte.Text);  '
      'end;'
      ''
      'procedure dbeTotIteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If fDescontoCliente Then                                      ' +
        '              '
      
        '    dbeTotIte.Text := FormatFloat('#39'#,##0.00'#39', fltTotIte / ((100 ' +
        '- fGetDesCli)/100))'
      '  Else'
      '    dbeTotIte.Text := FormatFloat('#39'#,##0.00'#39', fltTotIte);  '
      'end;'
      ''
      'procedure dbePrecoUniOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If fDescontoCliente Then                                      ' +
        '              '
      
        '    dbePrecoUni.Text := FormatFloat('#39'#,##0.0000'#39', fltUnitar / ((' +
        '100 - fGetDesCli)/100))'
      '  Else'
      '    dbePrecoUni.Text := FormatFloat('#39'#,##0.0000'#39', fltUnitar);  '
      'end;'
      ''
      'procedure dbeTotIteVolOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If fDescontoCliente Then                                      ' +
        '              '
      
        '    dbeTotIteVol.Text := FormatFloat('#39'#,##0.00'#39', fltTotIte / ((1' +
        '00 - fGetDesCli)/100))'
      '  Else'
      '    dbeTotIteVol.Text := FormatFloat('#39'#,##0.00'#39', fltTotIte);  '
      'end;'
      ''
      'procedure dbePrecoUniVolOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If fDescontoCliente Then                                      ' +
        '              '
      
        '    dbePrecoUniVol.Text := FormatFloat('#39'#,##0.0000'#39', fltUnitar /' +
        ' ((100 - fGetDesCli)/100))'
      '  Else'
      
        '    dbePrecoUniVol.Text := FormatFloat('#39'#,##0.0000'#39', fltUnitar);' +
        '  '
      'end;'
      ''
      'procedure dbeTOTAL_PRODOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If fDescontoCliente Then                                      ' +
        '              '
      
        '    dbeTOTAL_PROD.Text := FormatFloat('#39'#,##0.00'#39', fltTotProd / (' +
        '(100 - fGetDesCli)/100))'
      '  Else'
      '    dbeTOTAL_PROD.Text := FormatFloat('#39'#,##0.00'#39', fltTotProd);  '
      'end;'
      ''
      'procedure dbeTOTAL_PEDORCOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If fDescontoCliente Then                                      ' +
        '              '
      
        '    dbeTOTAL_PEDORC.Text := FormatFloat('#39'#,##0.00'#39', fltTotPedOrc' +
        ' - fltTotProd + ( fltTotProd / (1 - fGetDesCli/100) ) )  '
      '  Else'
      
        '    dbeTOTAL_PEDORC.Text := FormatFloat('#39'#,##0.00'#39', fltTotPedOrc' +
        ');  '
      'end;    '
      ''
      'Begin            '
      '  fltUnitar    := 0;'
      '  fltTotIte    := 0;'
      '  fltTotProd   := 0;'
      '  fltTotPedOrc := 0;    '
      '          '
      'end.')
    OnUserFunction = frxExportaPDF_RUserFunction
    Left = 408
    Top = 128
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxComplementares
        DataSetName = 'frxComplementares'
      end
      item
        DataSet = frxDuplicatas
        DataSetName = 'frxDuplicatas'
      end
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end
      item
        DataSet = frxParametros
        DataSetName = 'frxParametros'
      end
      item
        DataSet = frxServicos
        DataSetName = 'frxServicos'
      end
      item
        DataSet = frxTitulo
        DataSetName = 'frxTitulo'
      end
      item
        DataSet = frxTotais
        DataSetName = 'frxTotais'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Relatorio: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      OnBeforePrint = 'RelatorioOnBeforePrint'
      object RTTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 128.504020000000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object mmFoneEmpresa: TfrxMemoView
          Left = 271.716760000000000000
          Top = 74.559055120000000000
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
        end
        object mmFaxEmpresa: TfrxMemoView
          Left = 440.795610000000000000
          Top = 74.559055120000000000
          Width = 30.236240000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fax : ')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 111.267780000000000000
          Width = 1084.724409448819000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object dbEmrpesa: TfrxMemoView
          Left = 272.126160000000000000
          Top = 3.338590000000000000
          Width = 517.795610000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxTitulo."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object dbEnderecoEmpresa: TfrxMemoView
          Left = 272.126160000000000000
          Top = 38.173228350000000000
          Width = 517.795610000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_ENDERE"]')
          ParentFont = False
          WordWrap = False
        end
        object dbFoneEmpresa: TfrxMemoView
          Left = 304.921460000000000000
          Top = 74.559055120000000000
          Width = 132.283550000000000000
          Height = 15.118110240000000000
          OnAfterData = 'dbFoneEmpresaOnAfterData'
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_FONE01"]')
          ParentFont = False
          WordWrap = False
        end
        object dbCEPEmpresa: TfrxMemoView
          Left = 272.039580000000000000
          Top = 93.000026850000000000
          Width = 298.582870000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_EMAIL_"]')
          ParentFont = False
          WordWrap = False
        end
        object dbFaxEmpresa: TfrxMemoView
          Left = 474.000310000000000000
          Top = 74.425196850000000000
          Width = 132.283550000000000000
          Height = 15.118110240000000000
          OnAfterData = 'dbFaxEmpresaOnAfterData'
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_F_A_X_"]')
          ParentFont = False
          WordWrap = False
        end
        object dbBairroEmpresa: TfrxMemoView
          Left = 272.260050000000000000
          Top = 55.850408349999990000
          Width = 514.016080000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_NOMCID"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 272.126160000000000000
          Top = 20.677180000000000000
          Width = 517.795610000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'C.N.P.J.: [FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxTitulo."' +
              'EMP_C_G_C_">)]')
          ParentFont = False
          WordWrap = False
        end
        object Picture1: TfrxPictureView
          Left = 15.118120000000000000
          Top = 2.118120000000001000
          Width = 226.771800000000000000
          Height = 90.708720000000000000
          Center = True
          KeepAspectRatio = False
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
      object HCabecalho: TfrxHeader
        FillType = ftBrush
        Height = 170.078850000000000000
        Top = 207.874150000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.CTituloItens
        object frxParametrosDOCUMENTO: TfrxMemoView
          Align = baCenter
          Left = 394.960885000000000000
          Top = 28.015770000000000000
          Width = 294.803340000000000000
          Height = 18.897650000000000000
          DataField = 'DOCUMENTO'
          DataSet = frxParametros
          DataSetName = 'frxParametros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxParametros."DOCUMENTO"]')
          ParentFont = False
        end
        object mmNomeCliente: TfrxMemoView
          Left = 11.338590000000000000
          Top = 92.220472439999970000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Raz'#227'o:  ')
          ParentFont = False
        end
        object dbNomeCliente: TfrxMemoView
          Left = 80.370130000000000000
          Top = 92.220472439999970000
          Width = 313.700990000000000000
          Height = 15.118120000000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object mmEnderecoCliente: TfrxMemoView
          Left = 11.338590000000000000
          Top = 109.984251968503900000
          Width = 64.252010000000000000
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
        end
        object dbEnderecoCliente: TfrxMemoView
          Left = 80.370130000000000000
          Top = 109.984251970000000000
          Width = 313.700990000000000000
          Height = 15.118110240000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."ENDERE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmFoneCliente: TfrxMemoView
          Left = 11.338590000000000000
          Top = 145.889763779527600000
          Width = 64.252010000000000000
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
        end
        object dbBairroCliente: TfrxMemoView
          Left = 463.000000000000000000
          Top = 109.984251970000000000
          Width = 287.244280000000000000
          Height = 15.118110240000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."BAIRRO"]')
          ParentFont = False
          WordWrap = False
        end
        object dbTelefoneCliente: TfrxMemoView
          Left = 80.370130000000000000
          Top = 145.889763780000000000
          Width = 313.700990000000000000
          Height = 15.118120000000000000
          OnAfterData = 'dbTelefoneClienteOnAfterData'
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."FONE01"]')
          ParentFont = False
        end
        object mmCNPJCliente: TfrxMemoView
          Left = 399.086597090000000000
          Top = 127.748031500000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[IIF(<frxCabecalho."CGCCPF"> = 1, '#39'CNPJ:'#39', '#39'CPF:'#39')]')
          ParentFont = False
        end
        object dbCNPJCliente: TfrxMemoView
          Left = 463.000000000000000000
          Top = 127.748031500000000000
          Width = 287.244280000000000000
          Height = 15.118110240000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxCabecalho."C_G_C_">) > 0,'
            '    IIF(<frxCabecalho."CGCCPF"> = '#39'1'#39','
            
              '    FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxCabecalho."C_G_' +
              'C_">),'
            '    FormatMaskText('#39'999.999.999-99;0'#39',<frxCabecalho."C_G_C_">)),'
            #39#39')]')
          ParentFont = False
        end
        object mmIECliente: TfrxMemoView
          Left = 753.598483780000000000
          Top = 127.748031500000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[IIF(<frxCabecalho."CGCCPF"> = 1, '#39'IE:'#39', '#39'RG:'#39')]')
          ParentFont = False
        end
        object dbIECliente: TfrxMemoView
          Left = 826.755951890000000000
          Top = 127.748031500000000000
          Width = 245.669450000000000000
          Height = 15.118110240000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."I_E_S_"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 753.598483780000000000
          Top = 145.889763780000000000
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
        end
        object rllTitVen: TfrxMemoView
          Left = 399.086597090000000000
          Top = 145.889763780000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 399.086597090000000000
          Top = 109.984251970000000000
          Width = 60.472440940000000000
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
        end
        object Memo19: TfrxMemoView
          Left = 753.598483780000000000
          Top = 109.984251970000000000
          Width = 68.031540000000000000
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
        end
        object Memo20: TfrxMemoView
          Left = 11.676887090000000000
          Top = 127.748031500000000000
          Width = 64.251970940000010000
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
        end
        object Memo21: TfrxMemoView
          Left = 753.598483780000000000
          Top = 92.220472439999970000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'E-Mail:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 826.755951890000000000
          Top = 109.984251970000000000
          Width = 245.669279130000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."NOMCID"] / [frxCabecalho."ESTADO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 81.267443150000000000
          Top = 127.748031500000000000
          Width = 313.700990000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxCabecalho."C_E_P_">) > 0 ,'
            ' FormatMaskText('#39'00000-000;0'#39',<frxCabecalho."C_E_P_">),'#39#39')]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 463.000000000000000000
          Top = 145.889763780000000000
          Width = 287.244280000000000000
          Height = 15.118110240000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."NOMOPE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 826.755951890000000000
          Top = 92.220472439999970000
          Width = 245.669279130000000000
          Height = 15.118110240000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."EMAIL_"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 826.755951890000000000
          Top = 145.889763780000000000
          Width = 245.669450000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataCondPag(<frxCabecalho."CONPAG">)]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Align = baCenter
          Left = 421.417595000000100000
          Top = 4.000000000000000000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DEPARTAMENTO DE VENDAS')
          ParentFont = False
        end
        object frxParametrosSTATUS: TfrxMemoView
          Align = baCenter
          Left = 262.677335000000000000
          Top = 48.472480000000020000
          Width = 559.370440000000000000
          Height = 18.897650000000000000
          DataField = 'STATUS'
          DataSet = frxParametros
          DataSetName = 'frxParametros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxParametros."STATUS"]')
          ParentFont = False
        end
        object lblTitFan: TfrxMemoView
          Left = 398.748300000000000000
          Top = 92.220472439999970000
          Width = 60.472440940000000000
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
        end
        object lblNomFan: TfrxMemoView
          Left = 463.000000000000000000
          Top = 92.220472439999970000
          Width = 287.244280000000000000
          Height = 15.118120000000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."FANSOB"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbUrgente: TfrxMemoView
          Left = 1000.614161020000000000
          Top = 4.000000000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataSet = frxParametros
          DataSetName = 'frxParametros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'URGENTE')
          ParentFont = False
        end
      end
      object MDItens: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 551.811380000000000000
        Width = 1084.725110000000000000
        OnBeforePrint = 'MDItensOnBeforePrint'
        Child = frxExportaPDF_P.CMetragem
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object mmoDescri: TfrxMemoView
          Left = 132.472480000000000000
          Top = 1.440939999999955000
          Width = 207.874150000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESCRI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 28.000000000000000000
          Top = 1.000000000000000000
          Width = 39.685039370000000000
          Height = 15.118110240000000000
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
          VAlign = vaCenter
        end
        object mmoDesMar: TfrxMemoView
          Left = 346.322834650000000000
          Top = 1.440939999999955000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
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
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 543.842920000000100000
          Top = 1.440939999999955000
          Width = 30.236240000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."SIGUNI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbeQtd: TfrxMemoView
          Left = 579.401574803149600000
          Top = 1.440939999999955000
          Width = 41.574803149606300000
          Height = 15.118110240000000000
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
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbePrecoUni: TfrxMemoView
          Left = 758.937540000000000000
          Top = 1.440939999999955000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'dbePrecoUniOnBeforePrint'
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
            '[frxItens."UNITAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbeTotIte: TfrxMemoView
          Left = 849.528140000000000000
          Top = 1.440939999999955000
          Width = 71.811070000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'dbeTotIteOnBeforePrint'
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
            '[frxItens."TOTITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbeIPI: TfrxMemoView
          Left = 984.527573700000000000
          Top = 1.511811019999982000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
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
            '[frxItens."VALIPI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object MemoC55: TfrxMemoView
          Left = 473.472790000000000000
          Top = 1.511811019999982000
          Width = 60.472465350000000000
          Height = 15.118110240000000000
          DataSet = frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CLAIPI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbePIPI: TfrxMemoView
          Left = 1039.842605120000000000
          Top = 1.511811019999982000
          Width = 41.574798270000000000
          Height = 15.118110240000000000
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
            '[frxItens."ALQIPI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo49: TfrxMemoView
          Left = 929.456634330000000000
          Top = 1.511811019999982000
          Width = 49.133858270000000000
          Height = 15.118110240000000000
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
            '[frxItens."ALQICM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo67: TfrxMemoView
          Left = 438.677490000000000000
          Top = 1.511811019999982000
          Width = 26.456695350000000000
          Height = 15.118110240000000000
          DataSet = frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODFIS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmDescontoDetalhe: TfrxMemoView
          Left = 716.142240000000000000
          Top = 2.000000000000000000
          Width = 37.795300000000000000
          Height = 15.118110240000000000
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
            '[frxItens."DESCON"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 3.000000000000000000
          Top = 1.000000000000000000
          Width = 22.677170240000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Line#]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbePrecoDig: TfrxMemoView
          Left = 626.551640000000000000
          Top = 1.000000000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
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
            '[frxItens."UNIDIG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 72.590600000000000000
          Top = 1.133858270000019000
          Width = 58.582689370000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODFAB"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object PFRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 1266.142550000000000000
        Width = 1084.725110000000000000
        object Memo39: TfrxMemoView
          Left = 915.559680000000000000
          Top = 2.000000000000000000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          ParentFont = False
        end
        object Line15: TfrxLineView
          Top = 1.779530000000022000
          Width = 1084.724397240000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object CTotalDescontos: TfrxChild
        FillType = ftBrush
        Height = 18.897637795275590000
        Top = 763.465060000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.CTotaIPI
        PrintChildIfInvisible = True
        object lblTotalDescontos: TfrxMemoView
          Left = 690.669760000000000000
          Top = 1.000000000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total do(s) Desconto(s) : ')
          ParentFont = False
        end
        object dbeTOTAL_DESC: TfrxMemoView
          Left = 857.645564330000000000
          Top = 1.000000000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          DataSet = frxTotais
          DataSetName = 'frxTotais'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotais."TOTAL_DESC"]')
          ParentFont = False
        end
      end
      object CTotaIPI: TfrxChild
        FillType = ftBrush
        Height = 18.897637795275590000
        Top = 805.039890000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.CTotalFrete
        PrintChildIfInvisible = True
        object lblTotalIPI: TfrxMemoView
          Left = 690.669760000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total do IPI : ')
          ParentFont = False
        end
        object dbeTOTAL_IPI: TfrxMemoView
          Left = 857.645564330000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          DataSet = frxTotais
          DataSetName = 'frxTotais'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotais."TOTAL_IPI"]')
          ParentFont = False
        end
      end
      object CTotalGeral: TfrxChild
        FillType = ftBrush
        Height = 18.897637795275590000
        Top = 971.339210000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.CTotalVolumes
        PrintChildIfInvisible = True
        object lblTotalGeral: TfrxMemoView
          Left = 690.669760000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total  : ')
          ParentFont = False
        end
        object dbeTOTAL_PEDORC: TfrxMemoView
          Left = 857.645564330000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'dbeTOTAL_PEDORCOnBeforePrint'
          DataSet = frxTotais
          DataSetName = 'frxTotais'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotais."TOTAL_PEDORC"]')
          ParentFont = False
        end
      end
      object CTituloItens: TfrxChild
        FillType = ftBrush
        Height = 54.047244090000000000
        Top = 400.630180000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.CTituloItensVolume
        PrintChildIfInvisible = True
        object mmoTitCodIte: TfrxMemoView
          Left = 28.000000000000000000
          Top = 31.000000000000000000
          Width = 39.685022280000000000
          Height = 15.118120000000000000
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
        object mmoTitDesIte: TfrxMemoView
          Left = 133.472480000000000000
          Top = 31.000000000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoMarca: TfrxMemoView
          Left = 347.173470000000000000
          Top = 31.000000000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 544.842920000000100000
          Top = 31.000000000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Un.')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblQtd: TfrxMemoView
          Left = 579.535870000000000000
          Top = 31.000000000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
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
          VAlign = vaCenter
        end
        object lblPrecoUni: TfrxMemoView
          Left = 755.937540000000000000
          Top = 31.000000000000000000
          Width = 86.929189999999990000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Unit.Liq.')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblTotIte: TfrxMemoView
          Left = 849.528140000000000000
          Top = 31.000000000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Total')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblIPI: TfrxMemoView
          Left = 984.370750000000000000
          Top = 31.000000000000000000
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
            'Vr. IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          Top = 26.000000000000000000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Left = -1.000000000000000000
          Top = 49.456709999999990000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line8: TfrxLineView
          Left = 131.472480000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linMarca: TfrxLineView
          Left = 343.393940000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line11: TfrxLineView
          Left = 539.842920000000100000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line12: TfrxLineView
          Left = 578.858690000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line13: TfrxLineView
          Left = 623.669760000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line14: TfrxLineView
          Left = 845.087200000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object LineIPI: TfrxLineView
          Left = 981.370088500000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo6: TfrxMemoView
          Top = 2.677180000000021000
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Fill.BackColor = clSilver
          HAlign = haCenter
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baCenter
          Left = 455.433365000000100000
          Top = 6.000000000000000000
          Width = 173.858380000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'MATERIAIS SOLICITADOS')
          ParentFont = False
        end
        object MemoC53: TfrxMemoView
          Left = 474.472790000000000000
          Top = 31.000000000000000000
          Width = 60.472465350000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Classif.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line2: TfrxLineView
          Left = 470.709030000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object LinePIPI: TfrxLineView
          Left = 1036.063700000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line30: TfrxLineView
          Left = 436.897960000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line31: TfrxLineView
          Left = 925.165400710000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object lblPIPI: TfrxMemoView
          Left = 1039.842605120000000000
          Top = 31.000000000000000000
          Width = 41.574798270000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo62: TfrxMemoView
          Left = 929.456666060000000000
          Top = 31.000000000000000000
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
            '% ICMS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo65: TfrxMemoView
          Left = 439.677490000000000000
          Top = 31.000000000000000000
          Width = 26.456695350000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C.F.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object ln1: TfrxLineView
          Left = 713.362710000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmDescontoTituloItem: TfrxMemoView
          Left = 715.142240000000000000
          Top = 31.000000000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '%Desc')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 3.000000000000000000
          Top = 31.000000000000000000
          Width = 22.677170240000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'N'#186)
          ParentFont = False
          VAlign = vaCenter
        end
        object Line23: TfrxLineView
          Left = 26.118120000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line36: TfrxLineView
          Left = 755.378480000000000000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object lblPrecoDig: TfrxMemoView
          Left = 622.551640000000000000
          Top = 30.236240000000010000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Unit.Bru.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line38: TfrxLineView
          Left = 71.811070000000000000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo11: TfrxMemoView
          Left = 73.811070000000000000
          Top = 30.992125980000030000
          Width = 54.803142280000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'd.Fab')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object FTotalProdutos: TfrxFooter
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 676.535870000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.CServicos
        PrintChildIfInvisible = True
        object dbeTOTAL_PROD: TfrxMemoView
          Left = 857.645564330000000000
          Top = 2.889763779999953000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'dbeTOTAL_PRODOnBeforePrint'
          DataSet = frxTotais
          DataSetName = 'frxTotais'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotais."TOTAL_PROD"]')
          ParentFont = False
        end
        object lblTotalProdutos: TfrxMemoView
          Left = 690.669760000000000000
          Top = 2.889763779999953000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total do(s) Produto(s) : ')
          ParentFont = False
        end
        object Line9: TfrxLineView
          Width = 1084.724397240000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1179.213360000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.CMsgPed
        PrintChildIfInvisible = True
        object Subreport1: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxExportaPDF_P.Page1
        end
      end
      object CServicos: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 718.110700000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.CTotalDescontos
        PrintChildIfInvisible = True
        object Subreport2: TfrxSubreport
          Top = 3.779530000000022000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxExportaPDF_P.Page2
        end
        object Line19: TfrxLineView
          Width = 1103.622047240000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object CTotalFrete: TfrxChild
        FillType = ftBrush
        Height = 18.897637795275590000
        Top = 846.614720000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.CTotalRet
        PrintChildIfInvisible = True
        object lblTotalFrete: TfrxMemoView
          Left = 690.669760000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total do Frete : ')
          ParentFont = False
        end
        object dbeTOTAL_Frete: TfrxMemoView
          Left = 857.645564330000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          DataSet = frxTotais
          DataSetName = 'frxTotais'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotais."TOTAL_FRETE"]')
          ParentFont = False
        end
      end
      object CTotalRet: TfrxChild
        FillType = ftBrush
        Height = 18.897637795275590000
        Top = 888.189550000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.CDespesasAces
        PrintChildIfInvisible = True
        object lblTotalRet: TfrxMemoView
          Left = 690.669760000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Sub. Tributaria :')
          ParentFont = False
        end
        object dbeTOTAL_RET: TfrxMemoView
          Left = 857.645564330000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          DataSet = frxTotais
          DataSetName = 'frxTotais'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotais."TOTAL_RET"]')
          ParentFont = False
        end
      end
      object CTituloItensVolume: TfrxChild
        FillType = ftBrush
        Height = 54.047244090000000000
        Top = 476.220780000000000000
        Width = 1084.725110000000000000
        PrintChildIfInvisible = True
        object mmoTitCodIteVol: TfrxMemoView
          Left = 28.000000000000000000
          Top = 31.000000000000000000
          Width = 39.685039370000000000
          Height = 15.118120000000000000
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
        object mmoTitDesIteVol: TfrxMemoView
          Left = 133.472480000000000000
          Top = 31.000000000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoMarcaVol: TfrxMemoView
          Left = 347.173470000000000000
          Top = 31.000000000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 497.149970000000000000
          Top = 31.000000000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Un.')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblQtdVol: TfrxMemoView
          Left = 579.401574800000000000
          Top = 31.000000000000000000
          Width = 41.574803150000000000
          Height = 15.118120000000000000
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
          VAlign = vaCenter
        end
        object lblPrecoUniVol: TfrxMemoView
          Left = 756.937540000000000000
          Top = 31.000000000000000000
          Width = 86.929189999999990000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Unit.Liq.')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblTotIteVol: TfrxMemoView
          Left = 849.528140000000000000
          Top = 31.000000000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Total')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblIPIVol: TfrxMemoView
          Left = 984.527605430000000000
          Top = 31.000000000000000000
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
            'Vr. IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line20: TfrxLineView
          Top = 49.456710000000040000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line21: TfrxLineView
          Left = 131.472480000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linMarcaVol: TfrxLineView
          Left = 343.393940000000000000
          Top = 25.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line24: TfrxLineView
          Left = 492.590531650000000000
          Top = 26.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line25: TfrxLineView
          Left = 578.858690000000000000
          Top = 26.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line26: TfrxLineView
          Left = 623.669760000000000000
          Top = 26.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line27: TfrxLineView
          Left = 845.087200000000000000
          Top = 26.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line28: TfrxLineView
          Left = 925.236860000000000000
          Top = 26.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo52: TfrxMemoView
          Top = 2.677180000000021000
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Fill.BackColor = clSilver
          HAlign = haCenter
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Align = baCenter
          Left = 455.433365000000100000
          Top = 6.000000000000000000
          Width = 173.858380000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'MATERIAIS SOLICITADOS')
          ParentFont = False
        end
        object Line29: TfrxLineView
          Left = 526.386210000000000000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo54: TfrxMemoView
          Left = 530.165740000000000000
          Top = 31.000000000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Volume')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line32: TfrxLineView
          Left = 981.370750000000000000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line33: TfrxLineView
          Left = 455.795610000000000000
          Top = 25.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line34: TfrxLineView
          Left = 1036.063700000000000000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo57: TfrxMemoView
          Left = 1039.842605120000000000
          Top = 31.000000000000000000
          Width = 41.574798270000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo60: TfrxMemoView
          Left = 929.456666060000000000
          Top = 31.000000000000000000
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
            '% ICMS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo66: TfrxMemoView
          Left = 461.354670000000000000
          Top = 31.000000000000000000
          Width = 26.456695350000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C.F.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object ln2: TfrxLineView
          Left = 713.362710000000000000
          Top = 25.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmDescontoTituloVolume: TfrxMemoView
          Left = 716.142240000000000000
          Top = 31.000000000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '%Desc')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 3.000000000000000000
          Top = 31.000000000000000000
          Width = 22.677170240000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'N'#186)
          ParentFont = False
          VAlign = vaCenter
        end
        object Line35: TfrxLineView
          Left = 26.118120000000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line37: TfrxLineView
          Left = 756.748610000000000000
          Top = 25.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object lblPrecoDigVol: TfrxMemoView
          Left = 623.551640000000000000
          Top = 30.992125980000030000
          Width = 90.708719999999990000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Unit.Bru.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line39: TfrxLineView
          Left = 71.811070000000000000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo24: TfrxMemoView
          Left = 75.590600000000000000
          Top = 30.992125980000030000
          Width = 54.803142280000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'd.Fab')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object MDItensVolume: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 593.386210000000000000
        Width = 1084.725110000000000000
        OnBeforePrint = 'MDItensOnBeforePrint'
        Child = frxExportaPDF_P.CMetragem
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object mmoDescriVol: TfrxMemoView
          Left = 133.472480000000000000
          Top = 1.440939999999955000
          Width = 207.874150000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESCRI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Left = 28.000000000000000000
          Top = 1.440939999999955000
          Width = 39.685039370000000000
          Height = 15.118110240000000000
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
          VAlign = vaCenter
        end
        object mmoDesMarVol: TfrxMemoView
          Left = 347.173470000000000000
          Top = 1.440939999999955000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
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
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 497.149970000000000000
          Top = 1.440939999999955000
          Width = 26.456710000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."SIGUNI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbeQtdVol: TfrxMemoView
          Left = 579.401574803149600000
          Top = 1.440939999999955000
          Width = 41.574803149606300000
          Height = 15.118110240000000000
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
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbePrecoUniVol: TfrxMemoView
          Left = 758.937540000000000000
          Top = 1.440939999999955000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'dbePrecoUniVolOnBeforePrint'
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
            '[frxItens."UNITAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbeTotIteVol: TfrxMemoView
          Left = 849.528140000000000000
          Top = 1.440939999999955000
          Width = 71.811070000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'dbeTotIteVolOnBeforePrint'
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
            '[frxItens."TOTITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbeIPIVol: TfrxMemoView
          Left = 984.527573700000000000
          Top = 1.440939999999955000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
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
            '[frxItens."VALIPI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo63: TfrxMemoView
          Left = 530.165740000000000000
          Top = 1.440939999999955000
          Width = 45.354360000000000000
          Height = 15.118110240000000000
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
            '[frxItens."VOLITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbePIPIVol: TfrxMemoView
          Left = 1039.842605120000000000
          Top = 1.440939999999955000
          Width = 41.574798270000000000
          Height = 15.118110240000000000
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
            '[frxItens."ALQIPI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Left = 929.456666060000000000
          Top = 1.440939999999955000
          Width = 49.133858270000000000
          Height = 15.118110240000000000
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
            '[frxItens."ALQICM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo68: TfrxMemoView
          Left = 461.354670000000000000
          Top = 1.440939999999955000
          Width = 26.456695350000000000
          Height = 15.118110240000000000
          DataSet = frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODFIS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmDescontoDetalheVolume: TfrxMemoView
          Left = 716.142240000000000000
          Top = 1.440939999999955000
          Width = 37.795300000000000000
          Height = 15.118110240000000000
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
            '[frxItens."DESCON"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 3.000000000000000000
          Top = 1.440939999999955000
          Width = 22.677170240000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Line#]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object dbePrecoDigVol: TfrxMemoView
          Left = 626.551640000000000000
          Top = 1.779530000000022000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
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
            '[frxItens."UNIDIG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 73.590600000000000000
          Top = 1.511811019999982000
          Width = 58.582689370000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODFAB"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object CTotalVolumes: TfrxChild
        FillType = ftBrush
        Height = 18.897637795275590000
        Top = 1012.914040000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.CPeso
        PrintChildIfInvisible = True
        object Memo64: TfrxMemoView
          Left = 690.669760000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Volume : ')
          ParentFont = False
        end
        object dbeTOTAL_VOLUME: TfrxMemoView
          Left = 857.645564330000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          DataSet = frxTotais
          DataSetName = 'frxTotais'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."VOLITE">,MDItensVolume)]')
          ParentFont = False
        end
      end
      object CPorDes: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1096.063700000000000000
        Width = 1084.725110000000000000
        PrintChildIfInvisible = True
        object Memo61: TfrxMemoView
          Left = 7.559060000000000000
          Width = 646.299630000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Desconto concedido j'#225' distribuido nos itens de [FormatFloat('#39'#,#' +
              '#0.00'#39',<frxCabecalho."PORDES">)]%')
          ParentFont = False
        end
      end
      object CPeso: TfrxChild
        FillType = ftBrush
        Height = 18.897637795275590000
        Top = 1054.488870000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.CPorDes
        PrintChildIfInvisible = True
        object Memo71: TfrxMemoView
          Left = 690.669760000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Peso : ')
          ParentFont = False
        end
        object dbeTOTAL_PESO: TfrxMemoView
          Left = 857.645564330000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          DataSet = frxTotais
          DataSetName = 'frxTotais'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotais."PESBRU"]')
          ParentFont = False
        end
      end
      object CMetragem: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 634.961040000000000000
        Width = 1084.725110000000000000
        object rllMetragem: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 1099.843230000000000000
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
      object CDespesasAces: TfrxChild
        FillType = ftBrush
        Height = 18.897637795275590000
        Top = 929.764380000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.CTotalGeral
        PrintChildIfInvisible = True
        object Memo26: TfrxMemoView
          Left = 690.669760000000000000
          Top = 1.133858267716505000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Despesas Acess'#243'rias :')
          ParentFont = False
        end
        object dbeTOTAL_DESACE: TfrxMemoView
          Left = 857.645564330000000000
          Top = 1.133858267716505000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          DataSet = frxTotais
          DataSetName = 'frxTotais'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotais."TOTAL_DESACE"]')
          ParentFont = False
        end
      end
      object CMsgPed: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 1224.567720000000000000
        Width = 1084.725110000000000000
        object Memo69: TfrxMemoView
          Left = 2.456710000000000000
          Top = 1.779530000000022000
          Width = 1092.284170000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MSGPED]')
          ParentFont = False
        end
      end
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object Memo36: TfrxMemoView
          Left = 498.779840000000000000
          Top = 24.897650000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 632.504330000000000000
          Top = 24.897650000000000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
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
        end
        object Memo40: TfrxMemoView
          Left = 371.716760000000000000
          Top = 25.677180000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parcela')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Align = baCenter
          Left = 455.433365000000000000
          Top = 4.779530000000000000
          Width = 173.858380000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Prazos para Pagamento')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Top = 1.779530000000000000
          Width = 1084.724409450000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 83.149660000000000000
        Width = 1084.725110000000000000
        DataSet = frxDuplicatas
        DataSetName = 'frxDuplicatas'
        RowCount = 0
        object Memo31: TfrxMemoView
          Left = 631.504330000000000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
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
        end
        object Memo30: TfrxMemoView
          Left = 497.779840000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDuplicatas."VENCIMENTO"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 370.716760000000000000
          Width = 94.488250000000000000
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
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 85.074830000000000000
        Top = 120.944960000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.Child1
        Stretched = True
        object Memo43: TfrxMemoView
          Left = 3.779530000000000000
          Top = 62.397650000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Mensagem : ')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Top = 0.779530000000000000
          Width = 1084.724409448819000000
          Color = clBlack
          Diagonal = True
        end
        object Memo74: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559060000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Transportadora:')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 100.826840000000000000
          Top = 7.559060000000000000
          Width = 763.465060000000000000
          Height = 15.118120000000000000
          DataField = 'TRANSP'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxCabecalho."TRANSP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo76: TfrxMemoView
          Left = 100.826840000000000000
          Top = 25.838590000000000000
          Width = 763.465060000000000000
          Height = 15.118120000000000000
          DataField = 'ENDTRA'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."ENDTRA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo77: TfrxMemoView
          Left = 100.826840000000000000
          Top = 44.118120000000000000
          Width = 763.465060000000000000
          Height = 15.118120000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxCabecalho."BAITRA"] - CEP: [frxCabecalho."CEPTRA"] - [frxCab' +
              'ecalho."CIDTRA"]/[frxCabecalho."ESTTRA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo51: TfrxMemoView
          Left = 100.826840000000000000
          Top = 62.397650000000000000
          Width = 763.465060000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxComplementares."MSGORC"]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 230.551330000000000000
        Width = 1084.725110000000000000
        Child = frxExportaPDF_P.Child3
        Stretched = True
        object MemoC56: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779534880000000000
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
        end
        object MemoC57: TfrxMemoView
          Left = 71.811030940000000000
          Top = 3.779530000000000000
          Width = 1028.031932990000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DataSet = frxDuplicatas
          DataSetName = 'frxDuplicatas'
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
        Height = 83.149660000000000000
        Top = 275.905690000000000000
        Width = 1084.725110000000000000
        object lblData: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data : ')
          ParentFont = False
        end
        object lblValidade: TfrxMemoView
          Left = 3.779530000000000000
          Top = 23.622057620000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Validade do Or'#231'amento:')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 155.826840000000000000
          Top = 3.779530000000000000
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          DataField = 'DATA'
          DataSet = frxComplementares
          DataSetName = 'frxComplementares'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxComplementares."DATA"]')
          ParentFont = False
        end
        object menValPre: TfrxMemoView
          Left = 155.826840000000000000
          Top = 23.622062500000000000
          Width = 718.110700000000000000
          Height = 15.118110240000000000
          DataField = 'VALID'
          DataSet = frxComplementares
          DataSetName = 'frxComplementares'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxComplementares."VALID"]')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 3.779530000000000000
          Top = 43.464590120000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Frete por Conta do:')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 155.826840000000000000
          Top = 43.464595000000000000
          Width = 718.110700000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxComplementares
          DataSetName = 'frxComplementares'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxComplementares."FRETE"]')
          ParentFont = False
        end
        object rllTitRep: TfrxMemoView
          Left = 3.779530000000000000
          Top = 62.748145000000000000
          Width = 147.401670000000000000
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
          Left = 155.826840000000000000
          Top = 62.748145000000000000
          Width = 718.110472990000000000
          Height = 15.118110240000000000
          DataField = 'REPRES'
          DataSet = frxComplementares
          DataSetName = 'frxComplementares'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxComplementares."REPRES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
    object Page2: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 144.000000000000000000
        Width = 1084.725110000000000000
        object Memo14: TfrxMemoView
          Left = 968.166050000000000000
          Top = 5.000000000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataField = 'TOTSER'
          DataSet = frxServicos
          DataSetName = 'frxServicos'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxServicos."TOTSER"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 844.189550000000000000
          Top = 4.779530000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total do(s) Serv'#231'o(s) : ')
          ParentFont = False
        end
        object Line18: TfrxLineView
          Top = 21.897650000000000000
          Width = 1084.724409450000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line7: TfrxLineView
          Top = 1.000000000000000000
          Width = 1084.724409450000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 104.000000000000000000
        Width = 1084.725110000000000000
        DataSet = frxServicos
        DataSetName = 'frxServicos'
        RowCount = 0
        object Memo9: TfrxMemoView
          Left = 60.472480000000000000
          Top = 1.440940000000000000
          Width = 891.969080000000000000
          Height = 15.118110240000000000
          DataField = 'DESSER'
          DataSet = frxServicos
          DataSetName = 'frxServicos'
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
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.000000000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DataField = 'CODSER'
          DataSet = frxServicos
          DataSetName = 'frxServicos'
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
        end
        object Memo32: TfrxMemoView
          Left = 968.166050000000000000
          Top = 1.440940000000000000
          Width = 113.385900000000000000
          Height = 15.118110240000000000
          DataField = 'VALSER'
          DataSet = frxServicos
          DataSetName = 'frxServicos'
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
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 56.000000000000000000
        Width = 1084.725110000000000000
        object Memo34: TfrxMemoView
          Left = 3.779530000000000000
          Top = 5.999999999999992000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 62.472480000000000000
          Top = 6.000000000000000000
          Width = 891.969080000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 968.166050000000000000
          Top = 6.000000000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Total')
          ParentFont = False
        end
        object Line10: TfrxLineView
          Top = 1.000000000000000000
          Width = 1084.724409450000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line16: TfrxLineView
          Top = 24.456710000000000000
          Width = 1084.724409450000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line17: TfrxLineView
          Left = 58.472480000000000000
          Top = 1.779530000000022000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line22: TfrxLineView
          Left = 963.150280000000000000
          Top = 1.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 16.000000000000000000
        Width = 1084.725110000000000000
        object Memo33: TfrxMemoView
          Width = 1084.724409450000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Align = baCenter
          Left = 457.323130000000000000
          Top = 0.779530000000000000
          Width = 170.078850000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'SERVI'#199'OS')
          ParentFont = False
        end
      end
    end
  end
end
