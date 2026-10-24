inherited frmRelFiscResumoApIcms: TfrmRelFiscResumoApIcms
  Left = 493
  Top = 270
  Width = 302
  Height = 412
  Caption = 'Relat'#243'rio do Resumo de Apura'#231#227'o de ICMS'
  OnClose = FormClose
  ExplicitWidth = 302
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 341
    Width = 296
    ExplicitTop = 341
    ExplicitWidth = 296
    inherited FlwBotoes: TFlowPanel
      Width = 215
      ExplicitWidth = 215
    end
    inherited btnSair: TBitBtnLocked
      Left = 217
      ExplicitLeft = 217
    end
  end
  inherited pnlDados: TPanel
    Width = 296
    Height = 341
    ExplicitWidth = 296
    ExplicitHeight = 341
    object lblEmpresa: TLabel [0]
      Left = 8
      Top = 105
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [1]
      Left = 193
      Top = 19
      Width = 59
      Height = 14
      Caption = 'Num. P'#225'gina'
    end
    inherited gpbDestino: TGroupBox
      Left = 8
      Top = 143
      TabOrder = 5
      ExplicitLeft = 8
      ExplicitTop = 143
    end
    object gbpData: TGroupBox
      Left = 8
      Top = 6
      Width = 161
      Height = 60
      Caption = 'Per'#237'odo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label12: TLabel
        Left = 7
        Top = 16
        Width = 51
        Height = 14
        Caption = 'Data Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 85
        Top = 18
        Width = 47
        Height = 14
        Caption = 'Data Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 85
        Top = 30
        Width = 67
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 7
        Top = 30
        Width = 68
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
    object rdgFiltroDatas: TRadioGroup
      Left = 8
      Top = 66
      Width = 279
      Height = 39
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Data de Entrada'
        'Data de Documento')
      TabOrder = 2
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 8
      Top = 119
      Width = 37
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 3
      OnExit = edtCodEmpresaExit
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 49
      Top = 119
      Width = 238
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnOutros: TBitBtnLocked
      Left = 192
      Top = 154
      Width = 75
      Height = 25
      Hint = 'Outros cr'#233'ditos/d'#233'bitos'
      Caption = '&Outros'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      TabStop = False
      OnClick = btnOutrosClick
    end
    object ckbRegistrado_Ecf: TCheckBox
      Left = 8
      Top = 189
      Width = 275
      Height = 16
      Caption = 'Sair Valores no Lan'#231'amento 5929/6929'
      TabOrder = 7
    end
    object chkDetalhamentoDebCred: TCheckBox
      Left = 8
      Top = 223
      Width = 275
      Height = 16
      Caption = 'Imprimir Detalhamento de d'#233'bito e cr'#233'dito'
      TabOrder = 9
    end
    object chkInc933: TCheckBox
      Left = 8
      Top = 239
      Width = 174
      Height = 17
      Caption = 'Incluir notas de Servi'#231'o (X933)'
      TabOrder = 10
    end
    object ckbEnviaValores1603_2603: TCheckBox
      Left = 8
      Top = 206
      Width = 275
      Height = 16
      Caption = 'Sair Valores no Lan'#231'amento 1603/2603'
      TabOrder = 8
    end
    object chkIncluirCreditoCat158: TCheckBox
      Left = 8
      Top = 274
      Width = 244
      Height = 26
      Caption = 
        'Incluir o total de "Cr'#233'ditos de ICMS sobre vendas interestaduais' +
        ' - CAT 158"'
      TabOrder = 12
      WordWrap = True
    end
    object chkIncluirCreDebDifal: TCheckBox
      Left = 8
      Top = 256
      Width = 217
      Height = 17
      Caption = 'Incluir "Cr'#233'dito e D'#233'bito sobre DIFAL"'
      TabOrder = 11
    end
    object edtNumPagina: TEditFocus
      Left = 193
      Top = 34
      Width = 61
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      NumbersOnly = True
      TabOrder = 1
      OnExit = edtNumPaginaExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkIncluirFcpIcms: TCheckBox
      Left = 8
      Top = 302
      Width = 225
      Height = 17
      Caption = 'Incluir  FCP Cr'#233'dito/D'#233'bito ICMS e FCP ST'
      TabOrder = 13
      OnClick = chkIncluirFcpIcmsClick
    end
    object chkDeduzirFcpIcms: TCheckBox
      Left = 8
      Top = 318
      Width = 286
      Height = 17
      Caption = 'Deduzir FCP ICMS na Apura'#231#227'o de Saldos'
      TabOrder = 14
    end
  end
  inherited pnlStatus: TPanel
    Top = 367
    Width = 296
    ExplicitTop = 367
    ExplicitWidth = 296
    inherited pnlNomeForm: TPanel
      Left = 136
      Width = 160
      ExplicitLeft = 136
      ExplicitWidth = 160
    end
    inherited pnlInfo: TPanel
      Width = 136
      ExplicitWidth = 136
      inherited shpMultSel: TShape
        Left = 118
        Visible = True
        ExplicitLeft = 118
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 33
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 280
    Top = 1
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 216
    Top = 97
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 280
    Top = 129
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 248
    Top = 129
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 280
    Top = 65
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 216
    Top = 65
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 216
    Top = 33
  end
  inherited frxGen: TfrxUserDataSet
    Left = 248
    Top = 33
  end
  inherited frxDesigner: TfrxDesigner
    Left = 216
    Top = 129
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 248
    Top = 65
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 97
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43193.465241643520000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var      '
      '  arrCampos: Array Of String;'
      ''
      '  strImpCreD,'
      '  strImpCreC: String;'
      ''
      '  strCfopEnt: String;'
      '  strCfopSai: String;'
      ''
      '  blnImpLinEnt: boolean;'
      '  blnImpLinSai: boolean;'
      ''
      
        'procedure pImprimeCampos(Sender: TfrxDMPMemoView; blnImpValor, b' +
        'lnLinhaSep: Boolean);'
      'begin'
      '  sender.Text := '#39#39';    '
      ''
      '  If blnImpValor Then    '
      
        '    sender.Text := '#39'[frxRelatorio."'#39' + arrCampos[sender.tag] + '#39 +
        '"]'#39';                           '
      '      '
      '  sender.top := 0;'
      '  '
      '  If blnImpLinEnt Or blnImpLinSai Then'
      '    TfrxDMPMemoView(sender).top := 10;      '
      ''
      
        '  If blnLinhaSep Then                                           ' +
        '    '
      '    sender.frame.typ := ftTop + ftRight + ftLeft'
      '  Else'
      '    sender.frame.typ := ftRight + ftLeft;'
      'end;          '
      '    '
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rlbTitulo.Visible := <Page#> = 1 ;                            ' +
        '                                    '
      'end;'
      ''
      'procedure mmoClaFisDOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  pImprimeCampos(TfrxDMPMemoView(sender), (<frxRelatorio."CLAFSC' +
        '"> < '#39'5000'#39'), blnImpLinEnt);                                    ' +
        '                                                      '
      'end;'
      ''
      'procedure mmoClaFscCOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  pImprimeCampos(TfrxDMPMemoView(sender), (<frxRelatorio."CLAFSC' +
        '"> >= '#39'5000'#39'), blnImpLinSai);        '
      'end;'
      ''
      'procedure mmoTot001OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxDMPMemoView(sender).Text := strImpCreC;                   ' +
        '       '
      'end;'
      ''
      'procedure mmoTot005OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxDMPMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fStrTo' +
        'Float(strImpCreC) + <DEBITO> + <EST_CRE> + <DEBITO_DIFAL> + <flt' +
        'AntIcm>);  '
      'end;'
      ''
      'procedure mmoTot006OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  TfrxDMPMemoView(sender).Text := strImpCreD;  '
      'end;'
      ''
      'procedure mmoTot010OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxDMPMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fStrTo' +
        'Float(strImpCreD) + <CREDITO> + <CREDITO_DIFAL> + <CREDITO_CAT15' +
        '8> + <EST_DEB>);  '
      'end;'
      ''
      'procedure mmoTot012OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxDMPMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fStrTo' +
        'Float(strImpCreD) + <CREDITO> + <CREDITO_DIFAL> + <CREDITO_CAT15' +
        '8> + <EST_DEB> + <ICMANT>);  '
      'end;'
      ''
      'procedure mmoTot013OnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      
        '    fltValor: Double;                                           ' +
        '              '
      'begin'
      
        '  fltValor :=  fStrToFloat(strImpCreC) + <DEBITO> +  <EST_CRE> +' +
        ' <DEBITO_DIFAL> + <fltAntIcm> - (fStrToFloat(strImpCreD) + <CRED' +
        'ITO> + <CREDITO_DIFAL> + <CREDITO_CAT158> + <EST_DEB> + <ICMANT>' +
        ');      '
      '  '
      '  If fltValor < 0 Then'
      '    fltValor := 0;                              '
      '  '
      
        '  TfrxDMPMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fltVal' +
        'or);'
      'end;'
      ''
      'procedure mmoTot015OnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      
        '    fltValor: Double;                                           ' +
        '              '
      'begin'
      
        '  fltValor := fStrToFloat(strImpCreC) + <DEBITO> + <EST_CRE> + <' +
        'DEBITO_DIFAL> + <fltAntIcm> - (fStrToFloat(strImpCreD) + <CREDIT' +
        'O> + <CREDITO_DIFAL> + <CREDITO_CAT158> + <EST_DEB> + <ICMANT> +' +
        ' <fltDeducoes>);      '
      '  '
      '  If fltValor < 0 Then'
      '    fltValor := 0;                              '
      '  '
      
        '  TfrxDMPMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fltVal' +
        'or);  '
      'end;'
      ''
      'procedure mmoImpCreDOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  strImpCreD := mmoImpCreD.Text;                      '
      'end;'
      ''
      'procedure mmoImpCreCOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  strImpCreC := mmoImpCreC.Text;                      '
      'end;'
      ''
      'procedure mmo0016OnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      
        '    fltValor: Double;                                           ' +
        '              '
      'begin'
      
        '  fltValor := fStrToFloat(strImpCreC) + <DEBITO> + <EST_CRE> + <' +
        'DEBITO_DIFAL> + <fltAntIcm> - (fStrToFloat(strImpCreD) + <CREDIT' +
        'O> + <CREDITO_DIFAL> + <CREDITO_CAT158> + <EST_DEB> + <ICMANT>);' +
        '  '
      '  '
      '  If fltValor > 0 Then'
      '    fltValor := 0'
      '  Else'
      '    fltValor := - fltValor;           '
      '  '
      
        '  TfrxDMPMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fltVal' +
        'or);  '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbDetalhes.Height := 10;    '
      '  blnImpLinEnt := False;'
      '  blnImpLinSai := False;      '
      '    '
      '  If <frxRelatorio."CLAFSC"> < '#39'5000'#39' Then'
      '  Begin'
      
        '    blnImpLinEnt := (strCfopEnt <> '#39#39') And (Copy(<frxRelatorio."' +
        'CLAFSC">, 1, 1) <> Copy(strCfopEnt,1,1));'
      '    strCfopEnt := <frxRelatorio."CLAFSC">;'
      '  End            '
      '  Else'
      '  Begin'
      
        '    blnImpLinSai := (strCfopSai <> '#39#39') And (Copy(<frxRelatorio."' +
        'CLAFSC">, 1, 1) <> Copy(strCfopSai,1,1));'
      '    strCfopSai := <frxRelatorio."CLAFSC">;'
      '  End;'
      ''
      '  If blnImpLinSai Or blnImpLinEnt Then'
      '    rlbDetalhes.Height := 30;  '
      'end;'
      ''
      'procedure mmoDeducoesOnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      '    fltValor: Double;    '
      'begin'
      '  fltValor := <fltDeducoes>;                 '
      '  '
      
        '  TfrxDMPMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fltVal' +
        'or);    '
      'end;'
      ''
      'begin'
      '  strCfopEnt := '#39#39';'
      '  strCfopSai := '#39#39';'
      '  blnImpLinEnt := False;'
      '  blnImpLinSai := False;'
      ''
      '  setLength(arrCampos, 8);'
      ''
      '  arrCampos[0] := '#39'CLAFSC'#39';'
      '  arrCampos[1] := '#39'VLRCON'#39';  '
      '  arrCampos[2] := '#39'BASICM'#39';  '
      '  arrCampos[3] := '#39'VLRICM'#39';  '
      '  arrCampos[4] := '#39'RETIDO'#39';  '
      '  arrCampos[5] := '#39'OUTRAS'#39';  '
      '  arrCampos[6] := '#39'ISENTA'#39';'
      '  arrCampos[7] := '#39'VLRIPI'#39';      '
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 216
    Top = 65535
    Datasets = <
      item
        DataSet = frxDbOutIcmCredito
        DataSetName = 'frxDbOutIcmCredito'
      end
      item
        DataSet = frxDbOutIcmDebito
        DataSetName = 'frxDbOutIcmDebito'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
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
      PaperWidth = 584.199622704410300000
      PaperHeight = 287.866480752897800000
      PaperSize = 256
      ColumnWidth = 2.539998359584390000
      OnAfterPrint = 'qckPaginaOnAfterPrint'
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 2208.000000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmoClaFisD: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFisDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CLAFSC"]')
          TruncOutboundText = False
        end
        object mmoVlrConD: TfrxDMPMemoView
          Tag = 1
          Left = 153.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFisDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRCON"]')
          TruncOutboundText = False
        end
        object mmoBasIcmD: TfrxDMPMemoView
          Tag = 2
          Left = 307.200000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFisDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."BASICM"]')
          TruncOutboundText = False
        end
        object mmoVlrImcD: TfrxDMPMemoView
          Tag = 3
          Left = 470.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFisDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRICM"]')
          TruncOutboundText = False
        end
        object mmoRetidoD: TfrxDMPMemoView
          Tag = 4
          Left = 604.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFisDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RETIDO"]')
          TruncOutboundText = False
        end
        object mmoOutrasD: TfrxDMPMemoView
          Tag = 5
          Left = 729.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFisDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTRAS"]')
          TruncOutboundText = False
        end
        object mmoVlrIpiD: TfrxDMPMemoView
          Tag = 7
          Left = 969.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFisDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRIPI"]')
          TruncOutboundText = False
        end
        object mmoClaFscC: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFscCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CLAFSC"]')
          TruncOutboundText = False
        end
        object mmoVlrConC: TfrxDMPMemoView
          Tag = 1
          Left = 1248.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFscCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRCON"]')
          TruncOutboundText = False
        end
        object mmoBasIcmC: TfrxDMPMemoView
          Tag = 2
          Left = 1401.600000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFscCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."BASICM"]')
          TruncOutboundText = False
        end
        object mmoVlrIcmC: TfrxDMPMemoView
          Tag = 3
          Left = 1564.800000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFscCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRICM"]')
          TruncOutboundText = False
        end
        object mmoRetidoC: TfrxDMPMemoView
          Tag = 4
          Left = 1708.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFscCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RETIDO"]')
          TruncOutboundText = False
        end
        object mmoOutrasC: TfrxDMPMemoView
          Tag = 5
          Left = 1833.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFscCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTRAS"]')
          TruncOutboundText = False
        end
        object mmoVlrIPIC: TfrxDMPMemoView
          Tag = 7
          Left = 2064.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFscCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRIPI"]')
          TruncOutboundText = False
        end
        object mmoIsentaD: TfrxDMPMemoView
          Tag = 6
          Left = 854.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFisDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ISENTA"]')
          TruncOutboundText = False
        end
        object mmoIsentaC: TfrxDMPMemoView
          Tag = 6
          Left = 1948.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFscCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ISENTA"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 986.000000000000000000
        Width = 2208.000000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 2198.400000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 153.000000000000000000
        Width = 2208.000000000000000000
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        ReprintOnNewPage = True
        object DMPMemo4: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CODIGO'
            'FISCAL')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 153.600000000000000000
          Top = 51.000000000000000000
          Width = 134.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALORES'
            'CONTABEIS')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 34.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'I . C . M . S .')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 68.000000000000000000
          Width = 153.600000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'OP.C/ CREDITO'
            'BASE DE CALCULO')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'IMPOSTO'
            'CREDITADO')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR'
            'RETIDO')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 85.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'OUTRAS')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR'
            'I.P.I.')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 51.000000000000000000
          Width = 134.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CODIGO'
            'FISCAL')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1248.000000000000000000
          Top = 51.000000000000000000
          Width = 134.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALORES'
            'CONTABEIS')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 68.000000000000000000
          Width = 153.600000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'OP.C/ CREDITO'
            'BASE DE CALCULO')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 1564.800000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'IMPOSTO'
            'DEBITADO')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1708.800000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR'
            'RETIDO')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1833.600000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'OUTRAS')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 2064.000000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR'
            'I.P.I.')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 34.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'I . C . M . S .')
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 110.500000000000000000
          Width = 2188.800000000000000000
          Color = clBlack
        end
        object DMPLine6: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 2188.800000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 2188.800000000000000000
          Color = clBlack
        end
        object DMPLine52: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Height = 102.000000000000000000
          Color = clBlack
        end
        object DMPLine53: TfrxDMPLineView
          Left = 148.800000000000000000
          Top = 25.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine54: TfrxDMPLineView
          Left = 302.400000000000000000
          Top = 25.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine55: TfrxDMPLineView
          Left = 465.600000000000000000
          Top = 59.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine56: TfrxDMPLineView
          Left = 302.400000000000000000
          Top = 59.500000000000000000
          Width = 787.200000000000000000
          Color = clBlack
        end
        object DMPLine57: TfrxDMPLineView
          Left = 1089.600000000000000000
          Top = 25.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine58: TfrxDMPLineView
          Left = 849.600000000000000000
          Top = 59.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine59: TfrxDMPLineView
          Left = 724.800000000000000000
          Top = 59.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine60: TfrxDMPLineView
          Left = 600.000000000000000000
          Top = 59.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine61: TfrxDMPLineView
          Left = 1243.200000000000000000
          Top = 25.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine62: TfrxDMPLineView
          Left = 1396.800000000000000000
          Top = 25.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine63: TfrxDMPLineView
          Left = 1560.000000000000000000
          Top = 59.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine64: TfrxDMPLineView
          Left = 1396.800000000000000000
          Top = 59.500000000000000000
          Width = 796.800000000000000000
          Color = clBlack
        end
        object DMPLine65: TfrxDMPLineView
          Left = 1704.000000000000000000
          Top = 59.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine66: TfrxDMPLineView
          Left = 1828.800000000000000000
          Top = 59.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine67: TfrxDMPLineView
          Left = 1944.000000000000000000
          Top = 59.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine68: TfrxDMPLineView
          Left = 2193.600000000000000000
          Top = 25.500000000000000000
          Height = 102.000000000000000000
          Color = clBlack
        end
        object DMPMemo98: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1075.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'ENTRADAS')
          TruncOutboundText = False
        end
        object DMPMemo99: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Width = 1094.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'SAIDAS')
          TruncOutboundText = False
        end
        object DMPLine16: TfrxDMPLineView
          Left = 964.800000000000000000
          Top = 59.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPMemo85: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'ISENTAS')
          TruncOutboundText = False
        end
        object DMPLine71: TfrxDMPLineView
          Left = 2059.200000000000000000
          Top = 59.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPMemo86: TfrxDMPMemoView
          Left = 1948.800000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'ISENTAS')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 2208.000000000000000000
        object rllPagina: TfrxDMPMemoView
          Left = 1968.000000000000000000
          Top = 34.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [fRetAtuPagFisc('#39'FOLAPU'#39')]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 2112.000000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1968.000000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CGC]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 2188.800000000000000000
          Color = clBlack
        end
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 2188.800000000000000000
          Color = clBlack
        end
        object DMPLine51: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
        end
        object DMPLine69: TfrxDMPLineView
          Left = 2193.600000000000000000
          Top = 25.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 340.000000000000000000
        Width = 2208.000000000000000000
        Child = frxReportM.ChildDebito
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NO ESTADO')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORA DO ESTADO')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAIS')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."VLRCON' +
              '">,0), rlbDetalhes)]')
          TruncOutboundText = False
        end
        object mmoBasCal: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 68.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."BASICM' +
              '">,0), rlbDetalhes)]')
          TruncOutboundText = False
        end
        object mmoImpCreD: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'mmoImpCreDOnAfterPrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."VLRICM' +
              '">,0), rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."RETIDO' +
              '">,0), rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."OUTRAS' +
              '">,0), rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."VLRIPI' +
              '">,0), rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NO ESTADO')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORA DO ESTADO')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAIS')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> >= '#39'5000'#39', <frxRelatorio."VLRCO' +
              'N">,0), rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 1411.200000000000000000
          Top = 68.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> >= '#39'5000'#39', <frxRelatorio."BASIC' +
              'M">,0), rlbDetalhes)]')
          TruncOutboundText = False
        end
        object mmoImpCreC: TfrxDMPMemoView
          Left = 1564.800000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'mmoImpCreCOnAfterPrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> >= '#39'5000'#39', <frxRelatorio."VLRIC' +
              'M">,0), rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 1708.800000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> >= '#39'5000'#39', <frxRelatorio."RETID' +
              'O">,0), rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 1833.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> >= '#39'5000'#39', <frxRelatorio."OUTRA' +
              'S">,0), rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 2064.000000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> >= '#39'5000'#39', <frxRelatorio."VLRIP' +
              'I">,0), rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo59: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_D_VLRCON]')
          TruncOutboundText = False
        end
        object DMPMemo60: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_D_BASICM]')
          TruncOutboundText = False
        end
        object DMPMemo61: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_D_VLRICM]')
          TruncOutboundText = False
        end
        object DMPMemo62: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_D_RETIDO]')
          TruncOutboundText = False
        end
        object DMPMemo63: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_D_OUTRAS]')
          TruncOutboundText = False
        end
        object DMPMemo64: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_D_VLRIPI]')
          TruncOutboundText = False
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_D_VLRCON]')
          TruncOutboundText = False
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_D_BASICM]')
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_D_VLRICM]')
          TruncOutboundText = False
        end
        object DMPMemo68: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_D_RETIDO]')
          TruncOutboundText = False
        end
        object DMPMemo69: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_D_OUTRAS]')
          TruncOutboundText = False
        end
        object DMPMemo70: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_D_VLRIPI]')
          TruncOutboundText = False
        end
        object DMPMemo71: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_C_VLRCON]')
          TruncOutboundText = False
        end
        object DMPMemo72: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_C_BASICM]')
          TruncOutboundText = False
        end
        object DMPMemo73: TfrxDMPMemoView
          Left = 1564.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_C_VLRICM]')
          TruncOutboundText = False
        end
        object DMPMemo74: TfrxDMPMemoView
          Left = 1708.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_C_RETIDO]')
          TruncOutboundText = False
        end
        object DMPMemo75: TfrxDMPMemoView
          Left = 1833.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_C_OUTRAS]')
          TruncOutboundText = False
        end
        object DMPMemo76: TfrxDMPMemoView
          Left = 2064.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_C_VLRIPI]')
          TruncOutboundText = False
        end
        object DMPMemo77: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_VLRCON]')
          TruncOutboundText = False
        end
        object DMPMemo78: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_BASICM]')
          TruncOutboundText = False
        end
        object DMPMemo79: TfrxDMPMemoView
          Left = 1564.800000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_VLRICM]')
          TruncOutboundText = False
        end
        object DMPMemo80: TfrxDMPMemoView
          Left = 1708.800000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_RETIDO]')
          TruncOutboundText = False
        end
        object DMPMemo81: TfrxDMPMemoView
          Left = 1833.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_OUTRAS]')
          TruncOutboundText = False
        end
        object DMPMemo82: TfrxDMPMemoView
          Left = 2064.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_VLRIPI]')
          TruncOutboundText = False
        end
        object DMPLine7: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 2188.800000000000000000
          Color = clBlack
        end
        object DMPLine8: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 2188.800000000000000000
          Color = clBlack
        end
        object DMPLine36: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine37: TfrxDMPLineView
          Left = 148.800000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine38: TfrxDMPLineView
          Left = 302.400000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine39: TfrxDMPLineView
          Left = 465.600000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine40: TfrxDMPLineView
          Left = 600.000000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine41: TfrxDMPLineView
          Left = 724.800000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine42: TfrxDMPLineView
          Left = 964.800000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine43: TfrxDMPLineView
          Left = 1089.600000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine44: TfrxDMPLineView
          Left = 1243.200000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine45: TfrxDMPLineView
          Left = 1396.800000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine46: TfrxDMPLineView
          Left = 1560.000000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine47: TfrxDMPLineView
          Left = 1704.000000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine48: TfrxDMPLineView
          Left = 1828.800000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine49: TfrxDMPLineView
          Left = 2059.200000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine50: TfrxDMPLineView
          Left = 2193.600000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine70: TfrxDMPLineView
          Left = 849.600000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine72: TfrxDMPLineView
          Left = 1944.000000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPMemo87: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."ISENTA' +
              '">,0), rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo89: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_D_ISENTA]')
          TruncOutboundText = False
        end
        object DMPMemo90: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_D_ISENTA]')
          TruncOutboundText = False
        end
        object DMPMemo91: TfrxDMPMemoView
          Left = 1948.800000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> >= '#39'5000'#39', <frxRelatorio."ISENT' +
              'A">,0), rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo92: TfrxDMPMemoView
          Left = 1948.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_C_ISENTA]')
          TruncOutboundText = False
        end
        object DMPMemo93: TfrxDMPMemoView
          Left = 1948.800000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_ISENTA]')
          TruncOutboundText = False
        end
      end
      object ChildDebito: TfrxChild
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 459.000000000000000000
        Width = 2208.000000000000000000
        Child = frxReportM.ChildCredito
        object DMPMemo38: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1104.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'D E B I T O   D O   I M P O S T O')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 17.000000000000000000
          Width = 1008.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'A P U R A C A O   D E   S A L D O S')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '001 - POR SAIDAS COM DEBITO DO IMPOSTO')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '002 - OUTROS DEBITOS - AJUSTES')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '004 - ESTORNOS DE CREDITOS')
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '006 - TOTAL')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 51.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '013 - SALDO DEVEDOR (DEBITO - CREDITO)')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 68.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '014 - DEDUCOES')
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 102.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '015 - IMPOSTO A RECOLHER')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 119.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '016 - SALDO CREDOR (CREDITO - DEBITO) - TRANSP.P/ O MES SEGUINTE')
          TruncOutboundText = False
        end
        object mmoTot001: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTot001OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object mmoTot005: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 153.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTot005OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object mmoTot013: TfrxDMPMemoView
          Left = 2016.000000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTot013OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object mmoTot015: TfrxDMPMemoView
          Left = 2016.000000000000000000
          Top = 102.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTot015OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object DMPLine9: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1123.200000000000000000
          Color = clBlack
        end
        object DMPLine10: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1123.200000000000000000
          Color = clBlack
        end
        object DMPLine14: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 178.500000000000000000
          Width = 1123.200000000000000000
          Color = clBlack
        end
        object DMPLine17: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Height = 170.000000000000000000
          Color = clBlack
        end
        object DMPLine18: TfrxDMPLineView
          Left = 1128.000000000000000000
          Top = 8.500000000000000000
          Height = 170.000000000000000000
          Color = clBlack
        end
        object DMPLine19: TfrxDMPLineView
          Left = 1166.400000000000000000
          Top = 8.500000000000000000
          Height = 170.000000000000000000
          Color = clBlack
        end
        object DMPLine20: TfrxDMPLineView
          Left = 2193.600000000000000000
          Top = 8.500000000000000000
          Height = 170.000000000000000000
          Color = clBlack
        end
        object DMPLine21: TfrxDMPLineView
          Left = 1166.400000000000000000
          Top = 8.500000000000000000
          Width = 1027.200000000000000000
          Color = clBlack
        end
        object DMPLine22: TfrxDMPLineView
          Left = 1166.400000000000000000
          Top = 42.500000000000000000
          Width = 1027.200000000000000000
          Color = clBlack
        end
        object DMPLine23: TfrxDMPLineView
          Left = 1166.400000000000000000
          Top = 178.500000000000000000
          Width = 1027.200000000000000000
          Color = clBlack
        end
        object DMPLine32: TfrxDMPLineView
          Left = 2011.200000000000000000
          Top = 42.500000000000000000
          Height = 136.000000000000000000
          Color = clBlack
        end
        object DMPLine34: TfrxDMPLineView
          Left = 936.000000000000000000
          Top = 42.500000000000000000
          Height = 136.000000000000000000
          Color = clBlack
        end
        object mmo0016: TfrxDMPMemoView
          Left = 2016.000000000000000000
          Top = 119.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo0016OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllDebito: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 68.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[DEBITO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo83: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '005 - ANTECIPACAO DE ICMS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo84: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 119.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[fltAntIcm]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo109: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 102.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[EST_CRE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo110: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '003 - OUTROS DEBITOS - DIFAL')
          TruncOutboundText = False
        end
        object DMPMemo111: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 85.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[DEBITO_DIFAL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoDeducoes: TfrxDMPMemoView
          Left = 2016.000000000000000000
          Top = 68.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoDeducoesOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
      end
      object ChildCredito: TfrxChild
        FillType = ftBrush
        Height = 289.000000000000000000
        Top = 663.000000000000000000
        Width = 2208.000000000000000000
        object DMPMemo48: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1104.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'C R E D I T O   D O   I M P O S T O')
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 17.000000000000000000
          Width = 1008.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'OBSERVACOES')
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '007 - POR ENTRADAS COM CREDITO DO IMPOSTO')
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '008 - OUTROS CREDITOS - AJUSTES')
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '011 - ESTORNOS DE DEBITOS')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '012 - SUBTOTAL')
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '013 - SALDO CREDOR - PERIODO ANTERIOR')
          TruncOutboundText = False
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '014 - TOTAL')
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 153.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDAS')
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 170.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MAO DE OBRA')
          TruncOutboundText = False
        end
        object DMPMemo58: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 187.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FATURAMENTO')
          TruncOutboundText = False
        end
        object mmoTot006: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTot006OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object mmoTot010: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 136.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTot010OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object mmoTot011: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 153.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[ICMANT]')
          TruncOutboundText = False
        end
        object mmoTot012: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 187.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTot012OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object DMPMemo88: TfrxDMPMemoView
          Left = 2016.000000000000000000
          Top = 170.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 2016.000000000000000000
          Top = 153.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_VLRCOV + D_C_VLRCOV]')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 2016.000000000000000000
          Top = 187.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_VLRCOV + D_C_VLRCOV]')
          TruncOutboundText = False
        end
        object DMPLine11: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1123.200000000000000000
          Color = clBlack
        end
        object DMPLine12: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1123.200000000000000000
          Color = clBlack
        end
        object DMPLine13: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 212.500000000000000000
          Width = 1123.200000000000000000
          Color = clBlack
        end
        object DMPLine15: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 229.500000000000000000
          Width = 1123.200000000000000000
          Color = clBlack
        end
        object DMPLine24: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Height = 221.000000000000000000
          Color = clBlack
        end
        object DMPLine25: TfrxDMPLineView
          Left = 1128.000000000000000000
          Top = 8.500000000000000000
          Height = 221.000000000000000000
          Color = clBlack
        end
        object DMPLine26: TfrxDMPLineView
          Left = 1166.400000000000000000
          Top = 8.500000000000000000
          Height = 221.000000000000000000
          Color = clBlack
        end
        object DMPLine27: TfrxDMPLineView
          Left = 2193.600000000000000000
          Top = 8.500000000000000000
          Height = 221.000000000000000000
          Color = clBlack
        end
        object DMPLine28: TfrxDMPLineView
          Left = 1166.400000000000000000
          Top = 8.500000000000000000
          Width = 1027.200000000000000000
          Color = clBlack
        end
        object DMPLine29: TfrxDMPLineView
          Left = 1166.400000000000000000
          Top = 229.500000000000000000
          Width = 1027.200000000000000000
          Color = clBlack
        end
        object DMPLine30: TfrxDMPLineView
          Left = 1166.400000000000000000
          Top = 212.500000000000000000
          Width = 1027.200000000000000000
          Color = clBlack
        end
        object DMPLine31: TfrxDMPLineView
          Left = 2011.200000000000000000
          Top = 42.500000000000000000
          Height = 170.000000000000000000
          Color = clBlack
        end
        object DMPLine33: TfrxDMPLineView
          Left = 1166.400000000000000000
          Top = 42.500000000000000000
          Width = 1027.200000000000000000
          Color = clBlack
        end
        object DMPLine35: TfrxDMPLineView
          Left = 936.000000000000000000
          Top = 42.500000000000000000
          Height = 170.000000000000000000
          Color = clBlack
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 68.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[CREDITO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo108: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 119.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[EST_DEB]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo112: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '009 - OUTROS CREDITOS - DIFAL')
          TruncOutboundText = False
        end
        object DMPMemo113: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 85.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[CREDITO_DIFAL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo114: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '010 - OUTROS CREDITOS - CAT 158')
          TruncOutboundText = False
        end
        object DMPMemo115: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 102.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[CREDITO_CAT158]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
    object qckDetalhamentoCreditoDebito: TfrxDMPPage
      PaperWidth = 297.179808071374000000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 1104.000000000000000000
        object DMPMemo94: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 34.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [fRetAtuPagFisc('#39'FOLAPU'#39')]')
          TruncOutboundText = False
        end
        object DMPMemo95: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object DMPMemo96: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo97: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object DMPMemo100: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CGC]')
          TruncOutboundText = False
        end
        object DMPMemo101: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPLine73: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1094.400000000000000000
          Color = clBlack
        end
        object DMPLine74: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 1094.400000000000000000
          Color = clBlack
        end
        object DMPLine75: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
        end
        object DMPLine76: TfrxDMPLineView
          Left = 1099.200000000000000000
          Top = 25.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 153.000000000000000000
        Width = 1104.000000000000000000
        object DMPMemo102: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 17.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DETALHAMENTO DE DEBITOS E CREDITOS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo103: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 51.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '002 - OUTROS DEBITOS')
          TruncOutboundText = False
        end
        object DMPMemo104: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[DEBITO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine77: TfrxDMPLineView
          Left = 100.800000000000000000
          Top = 8.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine78: TfrxDMPLineView
          Left = 100.800000000000000000
          Top = 42.500000000000000000
          Width = 902.400000000000000000
          Color = clBlack
        end
        object DMPLine79: TfrxDMPLineView
          Left = 1003.200000000000000000
          Top = 8.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine80: TfrxDMPLineView
          Left = 792.000000000000000000
          Top = 25.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine84: TfrxDMPLineView
          Left = 100.800000000000000000
          Top = 76.500000000000000000
          Width = 902.400000000000000000
          Color = clBlack
        end
        object DMPLine81: TfrxDMPLineView
          Left = 100.800000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine82: TfrxDMPLineView
          Left = 100.800000000000000000
          Top = 8.500000000000000000
          Width = 902.400000000000000000
          Color = clBlack
        end
        object DMPLine83: TfrxDMPLineView
          Left = 1003.200000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine85: TfrxDMPLineView
          Left = 100.800000000000000000
          Top = 59.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine86: TfrxDMPLineView
          Left = 792.000000000000000000
          Top = 59.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine87: TfrxDMPLineView
          Left = 1003.200000000000000000
          Top = 59.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.000000000000000000
        Width = 1104.000000000000000000
        DataSet = frxDbOutIcmDebito
        DataSetName = 'frxDbOutIcmDebito'
        RowCount = 0
        Stretched = True
        object frxDbOutIcmDebitoObserv: TfrxDMPMemoView
          Left = 172.800000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataField = 'Observ'
          DataSet = frxDbOutIcmDebito
          DataSetName = 'frxDbOutIcmDebito'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDbOutIcmDebito."Observ"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDbOutIcmDebitoValor: TfrxDMPMemoView
          Left = 816.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'Valor'
          DataSet = frxDbOutIcmDebito
          DataSetName = 'frxDbOutIcmDebito'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDbOutIcmDebito."Valor"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine89: TfrxDMPLineView
          Left = 1003.200000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine90: TfrxDMPLineView
          Left = 792.000000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine88: TfrxDMPLineView
          Left = 100.800000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 323.000000000000000000
        Width = 1104.000000000000000000
        Child = frxReportM.Child1
        Stretched = True
        object DMPMemo105: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 17.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '007 - OUTROS CREDITOS')
          TruncOutboundText = False
        end
        object DMPMemo106: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[CREDITO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine91: TfrxDMPLineView
          Left = 100.800000000000000000
          Top = 42.500000000000000000
          Width = 902.400000000000000000
          Color = clBlack
        end
        object DMPLine95: TfrxDMPLineView
          Left = 100.800000000000000000
          Top = 8.500000000000000000
          Width = 902.400000000000000000
          Color = clBlack
        end
        object Subreport1: TfrxSubreport
          Left = 96.000000000000000000
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxReportM.Page1
        end
        object DMPLine92: TfrxDMPLineView
          Left = 100.800000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine98: TfrxDMPLineView
          Left = 1003.200000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine93: TfrxDMPLineView
          Left = 792.000000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 425.000000000000000000
        Width = 1104.000000000000000000
        object DMPLine99: TfrxDMPLineView
          Left = 100.800000000000000000
          Top = 8.500000000000000000
          Width = 902.400000000000000000
          Color = clBlack
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 459.000000000000000000
        Width = 1104.000000000000000000
        object DMPMemo107: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object DMPLine100: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1094.400000000000000000
          Color = clBlack
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 297.179808071374000000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1104.000000000000000000
        DataSet = frxDbOutIcmCredito
        DataSetName = 'frxDbOutIcmCredito'
        RowCount = 0
        Stretched = True
        object frxDbOutIcmCreditoObserv: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'Observ'
          DataSet = frxDbOutIcmCredito
          DataSetName = 'frxDbOutIcmCredito'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDbOutIcmCredito."Observ"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDbOutIcmCreditoValor: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'Valor'
          DataSet = frxDbOutIcmCredito
          DataSetName = 'frxDbOutIcmCredito'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDbOutIcmCredito."Valor"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine94: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine96: TfrxDMPLineView
          Left = 696.000000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine97: TfrxDMPLineView
          Left = 907.200000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44167.457858692130000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  strImpCreD,'
      '  strImpCreC: String;'
      ''
      '  strCfopEnt: String;'
      '  strCfopSai: String;'
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rlbTitulo.Visible := <Page#> = 1 ;                            ' +
        '                                    '
      'end;'
      ''
      'procedure mmoClaFisDOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> < '#39'500' +
        '0'#39';                                                             ' +
        '                 '
      'end;'
      ''
      'procedure mmoVlrConDOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> < '#39'500' +
        '0'#39';          '
      'end;'
      ''
      'procedure mmoBasIcmDOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> < '#39'500' +
        '0'#39';    '
      'end;'
      ''
      'procedure mmoVlrImcDOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> < '#39'500' +
        '0'#39';    '
      'end;'
      ''
      'procedure mmoRetidoDOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> < '#39'500' +
        '0'#39';    '
      'end;'
      ''
      'procedure mmoOutrasDOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> < '#39'500' +
        '0'#39';    '
      'end;'
      ''
      'procedure mmoVlrIpiDOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> < '#39'500' +
        '0'#39';  '
      'end;'
      ''
      'procedure mmoClaFscCOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible :=<frxRelatorio."CLAFSC"> >= '#39'500' +
        '0'#39';  '
      'end;'
      ''
      'procedure mmoVlrConCOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> >= '#39'50' +
        '00'#39';  '
      'end;'
      ''
      'procedure mmoBasIcmCOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> >= '#39'50' +
        '00'#39';  '
      'end;'
      ''
      'procedure mmoVlrIcmCOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> >= '#39'50' +
        '00'#39';  '
      'end;'
      ''
      'procedure mmoRetidoCOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> >= '#39'50' +
        '00'#39';  '
      'end;'
      ''
      'procedure mmoOutrasCOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> >= '#39'50' +
        '00'#39';  '
      'end;'
      ''
      'procedure mmoVlrIPICOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> >= '#39'50' +
        '00'#39';  '
      'end;'
      ''
      'procedure mmoTot001OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Text := strImpCreC;                      ' +
        '    '
      'end;'
      ''
      'procedure mmoTot005OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fStrToFlo' +
        'at(strImpCreC) + <DEBITO> + <DEBITO_DIFAL>  '
      ' + <fltAntIcm> + <EST_CRE>);  '
      'end;'
      ''
      'procedure mmoTot006OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  TfrxMemoView(sender).Text := strImpCreD;  '
      'end;'
      ''
      'procedure mmoTot010OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fStrToFlo' +
        'at(strImpCreD) + <CREDITO> + <CREDITO_DIFAL> + <CREDITO_CAT158> ' +
        '+ <EST_DEB>);  '
      'end;'
      ''
      'procedure mmoTot012OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxDMPMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fStrTo' +
        'Float(strImpCreD) + <CREDITO> + <CREDITO_DIFAL> + <CREDITO_CAT15' +
        '8>             '
      
        '                                                                ' +
        '                  + <ICMANT> + <EST_DEB>);'
      'end;'
      ''
      'procedure mmoTot013OnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      
        '    fltValor: Double;                                           ' +
        '              '
      'begin'
      
        '  fltValor := (fStrToFloat(strImpCreC) + <DEBITO> + <DEBITO_DIFA' +
        'L> + <fltAntIcm> + <EST_CRE>) -'
      
        '              (fStrToFloat(strImpCreD) +'#9'<CREDITO> + <CREDITO_DI' +
        'FAL> + <CREDITO_CAT158> + <ICMANT> + <EST_DEB>);  '
      '  '
      '  If fltValor < 0 Then'
      '    fltValor := 0;                              '
      '  '
      
        '  TfrxDMPMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fltVal' +
        'or);'
      'end;'
      ''
      'procedure mmoTot015OnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      '    fltValor: Double;'
      '    fltValorFcp: Double;'
      'begin'
      '  fltValorFcp := (<DEBITO_FCP> - <CREDITO_FCP>);  '
      '    '
      '  If fltValorFcp < 0 Then'
      '    fltValorFcp := 0;'
      '      '
      
        '  fltValor := fStrToFloat(strImpCreC) + <DEBITO> + <DEBITO_DIFAL' +
        '>  + <fltAntIcm> + <EST_CRE>'
      
        '             - (fltValorFcp + fStrToFloat(strImpCreD) + <CREDITO' +
        '> + <CREDITO_DIFAL> + <CREDITO_CAT158> + <ICMANT> + <EST_DEB> + ' +
        '<fltDeducoes>);'
      '  '
      '  If fltValor < 0 Then'
      '    fltValor := 0;                              '
      '  '
      
        '  TfrxDMPMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fltVal' +
        'or);  '
      'end;'
      ''
      'procedure mmoImpCreDOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  strImpCreD := mmoImpCreD.Text;                      '
      'end;'
      ''
      'procedure mmoImpCreCOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  strImpCreC := mmoImpCreC.Text;                      '
      'end;'
      ''
      'procedure mmo16OnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      
        '    fltValor: Double;                                           ' +
        '              '
      'begin'
      
        '  fltValor := fStrToFloat(strImpCreC) + <DEBITO> + <DEBITO_DIFAL' +
        '> + <EST_CRE> + <fltAntIcm> - (fStrToFloat(strImpCreD) + <CREDIT' +
        'O> + <CREDITO_DIFAL> + <CREDITO_CAT158> + <EST_DEB> + <ICMANT>);' +
        '     '
      '  '
      '  If fltValor > 0 Then'
      '    fltValor := 0                              '
      '  Else'
      '    fltValor := - fltValor;           '
      '    '
      
        '  TfrxDMPMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fltVal' +
        'or);  '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  lineEntradas.visible := False;'
      '  lineSaidas.visible := False;                                '
      '    '
      '  If <frxRelatorio."CLAFSC"> < '#39'5000'#39' Then'
      '  Begin'
      
        '    lineEntradas.visible := (strCfopEnt <> '#39#39') And (Copy(<frxRel' +
        'atorio."CLAFSC">, 1, 1) <> Copy(strCfopEnt,1,1));'
      '    strCfopEnt := <frxRelatorio."CLAFSC">;'
      '  End            '
      '  Else'
      '  Begin'
      
        '    lineSaidas.visible := (strCfopSai <> '#39#39') And (Copy(<frxRelat' +
        'orio."CLAFSC">, 1, 1) <> Copy(strCfopSai,1,1));'
      '    strCfopSai := <frxRelatorio."CLAFSC">;'
      '  End;  '
      'end;'
      ''
      'procedure mmoIsentaDOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> < '#39'500' +
        '0'#39';  '
      'end;'
      ''
      'procedure mmoIsentaCOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(sender).Visible := <frxRelatorio."CLAFSC"> >= '#39'50' +
        '00'#39';  '
      'end;'
      ''
      'procedure mmoTotFCPOnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      
        '    fltValor: Double;                                           ' +
        '              '
      'begin'
      '  fltValor := (<DEBITO_FCP> - <CREDITO_FCP>);'
      '  '
      '  If fltValor < 0 Then'
      '    fltValor := 0;                              '
      '  '
      
        '  TfrxDMPMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fltVal' +
        'or);'
      'end;'
      ''
      'procedure mmoDeducoesOnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      '    fltValor: Double;    '
      'begin      '
      '  fltValor := <fltDeducoes>;                              '
      '  '
      
        '  TfrxDMPMemoView(sender).Text := FormatFloat('#39'#,##0.00'#39', fltVal' +
        'or);          '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportJUserFunction
    Left = 248
    Top = 65535
    Datasets = <
      item
        DataSet = frxDbOutIcmCredito
        DataSetName = 'frxDbOutIcmCredito'
      end
      item
        DataSet = frxDbOutIcmDebito
        DataSetName = 'frxDbOutIcmDebito'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
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
      Orientation = poLandscape
      PaperWidth = 604.200000000000000000
      PaperHeight = 285.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.539998359584390000
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 336.378170000000000000
        Width = 2208.001426000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmoClaFisD: TfrxMemoView
          Left = 9.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFisDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CLAFSC"]')
        end
        object mmoVlrConD: TfrxMemoView
          Left = 163.200000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoVlrConDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRCON"]')
        end
        object mmoBasIcmD: TfrxMemoView
          Left = 307.800000000000000000
          Width = 146.040940000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoBasIcmDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."BASICM"]')
        end
        object mmoVlrImcD: TfrxMemoView
          Left = 461.600000000000000000
          Width = 123.061410000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoVlrImcDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRICM"]')
        end
        object mmoRetidoD: TfrxMemoView
          Left = 595.200000000000000000
          Width = 123.061410000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoRetidoDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RETIDO"]')
        end
        object mmoOutrasD: TfrxMemoView
          Left = 726.800000000000000000
          Width = 119.281880000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoOutrasDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTRAS"]')
        end
        object mmoVlrIpiD: TfrxMemoView
          Left = 969.400000000000000000
          Width = 115.502350000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoVlrIpiDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRIPI"]')
        end
        object mmoClaFscC: TfrxMemoView
          Left = 1104.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoClaFscCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CLAFSC"]')
        end
        object mmoVlrConC: TfrxMemoView
          Left = 1257.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoVlrConCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRCON"]')
        end
        object mmoBasIcmC: TfrxMemoView
          Left = 1405.200000000000000000
          Width = 157.379530000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoBasIcmCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."BASICM"]')
        end
        object mmoVlrIcmC: TfrxMemoView
          Left = 1578.000000000000000000
          Width = 130.620470000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoVlrIcmCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRICM"]')
        end
        object mmoRetidoC: TfrxMemoView
          Left = 1713.600000000000000000
          Width = 115.502350000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoRetidoCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RETIDO"]')
        end
        object mmoOutrasC: TfrxMemoView
          Left = 1835.200000000000000000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoOutrasCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTRAS"]')
        end
        object mmoVlrIPIC: TfrxMemoView
          Left = 2064.800000000000000000
          Width = 123.061410000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoVlrIPICOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRIPI"]')
        end
        object Line70: TfrxLineView
          Left = 148.913385830000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line72: TfrxLineView
          Left = 4.913385830000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line73: TfrxLineView
          Left = 302.362400000000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line74: TfrxLineView
          Left = 457.086614170000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line75: TfrxLineView
          Left = 589.913385830000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line76: TfrxLineView
          Left = 722.362710000000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line77: TfrxLineView
          Left = 966.188976380000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line78: TfrxLineView
          Left = 1089.637795280000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line79: TfrxLineView
          Left = 1243.086614170000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line80: TfrxLineView
          Left = 1396.913385830000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line81: TfrxLineView
          Left = 1574.637795280000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line82: TfrxLineView
          Left = 1711.086614170000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line83: TfrxLineView
          Left = 1832.913385830000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line84: TfrxLineView
          Left = 2060.362204720000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line85: TfrxLineView
          Left = 2193.637795280000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object lineEntradas: TfrxLineView
          Left = 3.779530000000000000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object lineSaidas: TfrxLineView
          Left = 1090.370784170000000000
          Width = 1103.622760000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line16: TfrxLineView
          Left = 848.142286380000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line103: TfrxLineView
          Left = 1945.662650000000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoIsentaD: TfrxMemoView
          Left = 851.614720000000000000
          Width = 111.722820000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoIsentaDOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ISENTA"]')
        end
        object mmoIsentaC: TfrxMemoView
          Left = 1950.237480000000000000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoIsentaCOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ISENTA"]')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1016.693570000000000000
        Width = 2208.001426000000000000
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 16.999999999999880000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 8.499999999999886000
          Width = 2208.001426000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 130.338590000000000000
        Top = 181.417440000000000000
        Width = 2208.001426000000000000
        ReprintOnNewPage = True
        object Memo4: TfrxMemoView
          Left = 9.600000000000000000
          Top = 45.000000000000000000
          Width = 115.200000000000000000
          Height = 34.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#211'DIGO'
            'FISCAL')
        end
        object Memo5: TfrxMemoView
          Left = 163.200000000000000000
          Top = 45.000000000000000000
          Width = 134.400000000000000000
          Height = 34.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'VALORES'
            'CONT'#193'BEIS')
        end
        object Memo6: TfrxMemoView
          Left = 316.800000000000000000
          Top = 28.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'I . C . M . S .')
        end
        object Memo7: TfrxMemoView
          Left = 306.800000000000000000
          Top = 62.000000000000000000
          Width = 146.040940000000000000
          Height = 34.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'OP.C/ CR'#201'DITO'
            'BASE DE C'#193'LCULO')
        end
        object Memo8: TfrxMemoView
          Left = 461.600000000000000000
          Top = 62.000000000000000000
          Width = 123.061410000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'IMPOSTO'
            'CREDITADO')
        end
        object Memo9: TfrxMemoView
          Left = 595.200000000000000000
          Top = 62.000000000000000000
          Width = 123.061410000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR'
            'RETIDO')
        end
        object Memo10: TfrxMemoView
          Left = 726.800000000000000000
          Top = 79.000000000000050000
          Width = 119.281880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'OUTRAS')
        end
        object Memo11: TfrxMemoView
          Left = 969.400000000000000000
          Top = 62.000000000000000000
          Width = 115.502350000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR'
            'I.P.I.')
        end
        object Memo12: TfrxMemoView
          Left = 1104.000000000000000000
          Top = 45.000000000000000000
          Width = 134.400000000000000000
          Height = 34.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#211'DIGO'
            'FISCAL')
        end
        object Memo13: TfrxMemoView
          Left = 1257.600000000000000000
          Top = 45.000000000000000000
          Width = 134.400000000000000000
          Height = 34.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'VALORES'
            'CONT'#193'BEIS')
        end
        object Memo15: TfrxMemoView
          Left = 1405.200000000000000000
          Top = 62.000000000000000000
          Width = 157.379530000000000000
          Height = 34.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'OP.C/ CR'#201'DITO'
            'BASE DE C'#193'LCULO')
        end
        object Memo16: TfrxMemoView
          Left = 1578.000000000000000000
          Top = 62.000000000000000000
          Width = 130.620470000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'IMPOSTO'
            'DEBITADO')
        end
        object Memo17: TfrxMemoView
          Left = 1713.600000000000000000
          Top = 62.000000000000000000
          Width = 115.502350000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR'
            'RETIDO')
        end
        object Memo18: TfrxMemoView
          Left = 1835.200000000000000000
          Top = 79.000000000000050000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'OUTRAS')
        end
        object Memo19: TfrxMemoView
          Left = 2064.800000000000000000
          Top = 62.000000000000000000
          Width = 123.061410000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR'
            'I.P.I.')
        end
        object Memo14: TfrxMemoView
          Left = 1411.200000000000000000
          Top = 28.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'I . C . M . S .')
        end
        object Line5: TfrxLineView
          Left = 4.800000000000000000
          Top = 106.500000000000000000
          Width = 2188.800000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line6: TfrxLineView
          Left = 4.800000000000000000
          Top = 121.500000000000000000
          Width = 2188.800000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Left = 4.800000000000000000
          Top = 19.500000000000000000
          Width = 2188.800000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line52: TfrxLineView
          Left = 4.913385830000000000
          Top = 19.500000000000000000
          Height = 86.551181100000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line53: TfrxLineView
          Left = 148.800000000000000000
          Top = 19.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line54: TfrxLineView
          Left = 302.400000000000000000
          Top = 19.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line55: TfrxLineView
          Left = 457.200000000000000000
          Top = 53.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line56: TfrxLineView
          Left = 302.400000000000000000
          Top = 53.500000000000000000
          Width = 787.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line57: TfrxLineView
          Left = 1089.600000000000000000
          Top = 19.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line58: TfrxLineView
          Left = 966.000000000000000000
          Top = 53.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line59: TfrxLineView
          Left = 722.400000000000000000
          Top = 53.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line60: TfrxLineView
          Left = 589.800000000000000000
          Top = 53.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line61: TfrxLineView
          Left = 1243.200000000000000000
          Top = 19.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line62: TfrxLineView
          Left = 1396.800000000000000000
          Top = 19.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line63: TfrxLineView
          Left = 1574.600000000000000000
          Top = 53.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line64: TfrxLineView
          Left = 1396.800000000000000000
          Top = 53.500000000000000000
          Width = 796.800000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line65: TfrxLineView
          Left = 1711.200000000000000000
          Top = 53.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line66: TfrxLineView
          Left = 1832.800000000000000000
          Top = 53.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line67: TfrxLineView
          Left = 2060.400000000000000000
          Top = 53.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line68: TfrxLineView
          Left = 2193.600000000000000000
          Top = 19.500000000000000000
          Height = 86.551181100000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line86: TfrxLineView
          Left = 4.913385830000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line87: TfrxLineView
          Left = 148.913385830000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line88: TfrxLineView
          Left = 302.362400000000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line89: TfrxLineView
          Left = 457.086614170000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line90: TfrxLineView
          Left = 589.913385830000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line91: TfrxLineView
          Left = 722.362710000000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line92: TfrxLineView
          Left = 966.188976380000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line93: TfrxLineView
          Left = 1089.637795280000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line94: TfrxLineView
          Left = 1243.086614170000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line95: TfrxLineView
          Left = 1396.913385830000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line96: TfrxLineView
          Left = 1574.637795280000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line97: TfrxLineView
          Left = 1711.086614170000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line98: TfrxLineView
          Left = 1832.913385830000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line99: TfrxLineView
          Left = 2060.362204720000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line100: TfrxLineView
          Left = 2193.637795280000000000
          Top = 121.362204720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo84: TfrxMemoView
          Left = 4.913385830000000000
          Top = 1.440940000000012000
          Width = 1084.724409450000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'ENTRADAS')
        end
        object Memo85: TfrxMemoView
          Left = 1089.637795280000000000
          Top = 1.440940000000012000
          Width = 1103.622047240000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'SA'#205'DAS')
        end
        object Line71: TfrxLineView
          Left = 847.953310000000000000
          Top = 53.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line101: TfrxLineView
          Left = 848.142286380000000000
          Top = 122.555154720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo90: TfrxMemoView
          Left = 851.953310000000000000
          Top = 79.370130000000080000
          Width = 111.722820000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'ISENTAS')
        end
        object Line104: TfrxLineView
          Left = 1945.700445280000000000
          Top = 53.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line105: TfrxLineView
          Left = 1945.662650000000000000
          Top = 120.775624720000000000
          Height = 8.314960630000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo91: TfrxMemoView
          Left = 1948.442180000000000000
          Top = 79.370130000000080000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'ISENTAS')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 18.897650000000000000
        Width = 2208.001426000000000000
        object rllPagina: TfrxMemoView
          Left = 1965.732220000000000000
          Top = 34.000000000000000000
          Width = 213.467780000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA: [fRetAtuPagFisc('#39'FOLAPU'#39')]')
        end
        object Time: TfrxMemoView
          Left = 2112.000000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 1968.000000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Left = 7.559055118110240000
          Top = 34.000000000000000000
          Width = 669.429870000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
        end
        object Memo2: TfrxMemoView
          Left = 92.749660000000000000
          Top = 51.000000000000000000
          Width = 669.429870000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CGC]')
        end
        object Memo3: TfrxMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object Line2: TfrxLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 2188.800000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 2188.800000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line51: TfrxLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line69: TfrxLineView
          Left = 2193.600000000000000000
          Top = 25.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo83: TfrxMemoView
          Left = 7.559060000000000000
          Top = 51.023622050000000000
          Width = 79.823190000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CGC:')
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 377.953000000000000000
        Width = 2208.001426000000000000
        Child = frxReportJ.ChildDebito
        object Memo20: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NO ESTADO')
        end
        object Memo21: TfrxMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORA DO ESTADO')
        end
        object Memo22: TfrxMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAIS')
        end
        object Memo23: TfrxMemoView
          Left = 163.200000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."VLRCON' +
              '">,0), rlbDetalhes)]')
        end
        object mmoBasCal: TfrxMemoView
          Left = 307.800000000000000000
          Top = 68.000000000000000000
          Width = 146.040940000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."BASICM' +
              '">,0), rlbDetalhes)]')
        end
        object mmoImpCreD: TfrxMemoView
          Left = 461.600000000000000000
          Top = 68.000000000000000000
          Width = 123.061410000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'mmoImpCreDOnAfterPrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."VLRICM' +
              '">,0), rlbDetalhes)]')
        end
        object Memo26: TfrxMemoView
          Left = 595.200000000000000000
          Top = 68.000000000000000000
          Width = 123.061410000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."RETIDO' +
              '">,0), rlbDetalhes)]')
        end
        object Memo27: TfrxMemoView
          Left = 726.800000000000000000
          Top = 68.000000000000000000
          Width = 119.281880000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."OUTRAS' +
              '">,0), rlbDetalhes)]')
        end
        object Memo28: TfrxMemoView
          Left = 969.400000000000000000
          Top = 68.000000000000000000
          Width = 115.502350000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."VLRIPI' +
              '">,0), rlbDetalhes)]')
        end
        object Memo29: TfrxMemoView
          Left = 1104.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NO ESTADO')
        end
        object Memo30: TfrxMemoView
          Left = 1104.000000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORA DO ESTADO')
        end
        object Memo31: TfrxMemoView
          Left = 1104.000000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAIS')
        end
        object Memo32: TfrxMemoView
          Left = 1257.600000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> >= '#39'5000'#39', <frxRelatorio."VLRCO' +
              'N">,0), rlbDetalhes)]')
        end
        object Memo33: TfrxMemoView
          Left = 1405.200000000000000000
          Top = 68.000000000000000000
          Width = 157.379530000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> >= '#39'5000'#39', <frxRelatorio."BASIC' +
              'M">,0), rlbDetalhes)]')
        end
        object mmoImpCreC: TfrxMemoView
          Left = 1578.000000000000000000
          Top = 68.000000000000000000
          Width = 130.620470000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'mmoImpCreCOnAfterPrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> >= '#39'5000'#39', <frxRelatorio."VLRIC' +
              'M">,0), rlbDetalhes)]')
        end
        object Memo35: TfrxMemoView
          Left = 1713.600000000000000000
          Top = 68.000000000000000000
          Width = 115.502350000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> >= '#39'5000'#39', <frxRelatorio."RETID' +
              'O">,0), rlbDetalhes)]')
        end
        object Memo36: TfrxMemoView
          Left = 1835.200000000000000000
          Top = 68.000000000000000000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> >= '#39'5000'#39', <frxRelatorio."OUTRA' +
              'S">,0), rlbDetalhes)]')
        end
        object Memo37: TfrxMemoView
          Left = 2064.800000000000000000
          Top = 68.000000000000000000
          Width = 123.061410000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> >= '#39'5000'#39', <frxRelatorio."VLRIP' +
              'I">,0), rlbDetalhes)]')
        end
        object Memo59: TfrxMemoView
          Left = 163.200000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_D_VLRCON]')
        end
        object Memo60: TfrxMemoView
          Left = 307.800000000000000000
          Top = 17.000000000000000000
          Width = 146.040940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_D_BASICM]')
        end
        object Memo61: TfrxMemoView
          Left = 461.600000000000000000
          Top = 17.000000000000000000
          Width = 123.061410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_D_VLRICM]')
        end
        object Memo62: TfrxMemoView
          Left = 595.200000000000000000
          Top = 17.000000000000000000
          Width = 123.061410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_D_RETIDO]')
        end
        object Memo63: TfrxMemoView
          Left = 726.800000000000000000
          Top = 17.000000000000000000
          Width = 119.281880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_D_OUTRAS]')
        end
        object Memo64: TfrxMemoView
          Left = 969.400000000000000000
          Top = 17.000000000000000000
          Width = 115.502350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_D_VLRIPI]')
        end
        object Memo65: TfrxMemoView
          Left = 163.200000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_D_VLRCON]')
        end
        object Memo66: TfrxMemoView
          Left = 307.800000000000000000
          Top = 34.000000000000000000
          Width = 146.040940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_D_BASICM]')
        end
        object Memo67: TfrxMemoView
          Left = 461.600000000000000000
          Top = 34.000000000000000000
          Width = 123.061410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_D_VLRICM]')
        end
        object Memo68: TfrxMemoView
          Left = 595.200000000000000000
          Top = 34.000000000000000000
          Width = 123.061410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_D_RETIDO]')
        end
        object Memo69: TfrxMemoView
          Left = 726.800000000000000000
          Top = 34.000000000000000000
          Width = 119.281880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_D_OUTRAS]')
        end
        object Memo70: TfrxMemoView
          Left = 969.400000000000000000
          Top = 34.000000000000000000
          Width = 115.502350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_D_VLRIPI]')
        end
        object Memo71: TfrxMemoView
          Left = 1257.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_C_VLRCON]')
        end
        object Memo72: TfrxMemoView
          Left = 1405.200000000000000000
          Top = 17.000000000000000000
          Width = 157.379530000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_C_BASICM]')
        end
        object Memo73: TfrxMemoView
          Left = 1578.000000000000000000
          Top = 17.000000000000000000
          Width = 130.620470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_C_VLRICM]')
        end
        object Memo74: TfrxMemoView
          Left = 1713.600000000000000000
          Top = 17.000000000000000000
          Width = 115.502350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_C_RETIDO]')
        end
        object Memo75: TfrxMemoView
          Left = 1835.200000000000000000
          Top = 17.000000000000000000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_C_OUTRAS]')
        end
        object Memo76: TfrxMemoView
          Left = 2064.800000000000000000
          Top = 17.000000000000000000
          Width = 123.061410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_C_VLRIPI]')
        end
        object Memo77: TfrxMemoView
          Left = 1257.600000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_VLRCON]')
        end
        object Memo78: TfrxMemoView
          Left = 1405.200000000000000000
          Top = 34.000000000000000000
          Width = 157.379530000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_BASICM]')
        end
        object Memo79: TfrxMemoView
          Left = 1578.000000000000000000
          Top = 34.000000000000000000
          Width = 130.620470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_VLRICM]')
        end
        object Memo80: TfrxMemoView
          Left = 1713.600000000000000000
          Top = 34.000000000000000000
          Width = 115.502350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_RETIDO]')
        end
        object Memo81: TfrxMemoView
          Left = 1835.200000000000000000
          Top = 34.000000000000000000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_OUTRAS]')
        end
        object Memo82: TfrxMemoView
          Left = 2064.800000000000000000
          Top = 34.000000000000000000
          Width = 123.061410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_VLRIPI]')
        end
        object Line7: TfrxLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 2188.800000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line8: TfrxLineView
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 2188.800000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line36: TfrxLineView
          Left = 4.800000000000000000
          Height = 94.488188980000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line37: TfrxLineView
          Left = 148.800000000000000000
          Height = 94.488188976378000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line38: TfrxLineView
          Left = 302.400000000000000000
          Height = 94.488188976378000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line39: TfrxLineView
          Left = 457.200000000000000000
          Height = 94.488188980000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line40: TfrxLineView
          Left = 589.800000000000000000
          Height = 94.488188980000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line41: TfrxLineView
          Left = 722.400000000000000000
          Height = 94.488188980000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line42: TfrxLineView
          Left = 966.000000000000000000
          Height = 94.488188980000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line43: TfrxLineView
          Left = 1089.600000000000000000
          Height = 94.488188976378000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line44: TfrxLineView
          Left = 1243.200000000000000000
          Height = 94.488188976378000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line45: TfrxLineView
          Left = 1396.800000000000000000
          Height = 94.488188976378000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line46: TfrxLineView
          Left = 1574.600000000000000000
          Height = 94.488188980000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line47: TfrxLineView
          Left = 1711.200000000000000000
          Height = 94.488188980000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line48: TfrxLineView
          Left = 1832.800000000000000000
          Height = 94.488188980000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line49: TfrxLineView
          Left = 2060.400000000000000000
          Height = 94.488188980000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line50: TfrxLineView
          Left = 2193.600000000000000000
          Height = 94.488188976378000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line102: TfrxLineView
          Left = 847.953310000000000000
          Height = 94.488188980000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line106: TfrxLineView
          Left = 1945.700445280000000000
          Height = 94.488188980000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo92: TfrxMemoView
          Left = 851.394250000000000000
          Top = 68.000000000000000000
          Width = 111.722820000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."ISENTA' +
              '">,0), rlbDetalhes)]')
        end
        object Memo93: TfrxMemoView
          Left = 851.394250000000000000
          Top = 17.000000000000000000
          Width = 111.722820000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_D_ISENTA]')
        end
        object Memo94: TfrxMemoView
          Left = 851.394250000000000000
          Top = 34.000000000000000000
          Width = 111.722820000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_D_ISENTA]')
        end
        object Memo95: TfrxMemoView
          Left = 1949.237480000000000000
          Top = 68.000000000000000000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> >= '#39'5000'#39', <frxRelatorio."ISENT' +
              'A">,0), rlbDetalhes)]')
        end
        object Memo96: TfrxMemoView
          Left = 1949.237480000000000000
          Top = 17.000000000000000000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[D_C_ISENTA]')
        end
        object Memo97: TfrxMemoView
          Left = 1949.237480000000000000
          Top = 34.000000000000000000
          Width = 107.943290000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_ISENTA]')
        end
        object mmoVlrFcpDeb: TfrxMemoView
          Left = 457.323130000000000000
          Top = 49.133890000000010000
          Width = 130.620470000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."CLAFSC"> < '#39'5000'#39', <frxRelatorio."VLRFCP' +
              '">,0), rlbDetalhes)]')
        end
      end
      object ChildDebito: TfrxChild
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 502.677490000000000000
        Width = 2208.001426000000000000
        Child = frxReportJ.ChildCredito
        object Memo38: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000060000
          Width = 1104.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'D E B I T O   D O   I M P O S T O')
        end
        object Memo39: TfrxMemoView
          Left = 1180.800000000000000000
          Top = 17.000000000000060000
          Width = 1008.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'A P U R A C A O   D E   S A L D O S')
        end
        object Memo40: TfrxMemoView
          Left = 9.600000000000000000
          Top = 50.692913390000120000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '001 - POR SA'#205'DAS COM D'#201'BITO DO IMPOSTO')
        end
        object Memo41: TfrxMemoView
          Left = 9.600000000000000000
          Top = 70.724409450000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '002 - OUTROS D'#201'BITOS - AJUSTES')
        end
        object Memo42: TfrxMemoView
          Left = 9.600000000000000000
          Top = 110.787401570000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '004 - ESTORNOS DE CR'#201'DITOS')
        end
        object Memo43: TfrxMemoView
          Left = 9.600000000000000000
          Top = 151.000000000000100000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '006 - TOTAL')
        end
        object Memo44: TfrxMemoView
          Left = 1180.800000000000000000
          Top = 51.000000000000060000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '015 - SALDO DEVEDOR (D'#201'BITO - CR'#201'DITO)')
        end
        object Memo45: TfrxMemoView
          Left = 1180.800000000000000000
          Top = 68.000000000000050000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '016 - DEDU'#199#213'ES')
        end
        object Memo46: TfrxMemoView
          Left = 1180.800000000000000000
          Top = 102.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '017 - IMPOSTO A RECOLHER')
        end
        object Memo47: TfrxMemoView
          Left = 1180.800000000000000000
          Top = 119.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '018 - SALDO CREDOR (CR'#201'DITO - D'#201'BITO) - TRANSP.P/ O M'#202'S SEGUINTE')
        end
        object mmoTot001: TfrxMemoView
          Left = 940.800000000000000000
          Top = 50.645669291338720000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTot001OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoTot005: TfrxMemoView
          Left = 940.800000000000000000
          Top = 151.181102360000100000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTot005OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoTot013: TfrxMemoView
          Left = 2016.000000000000000000
          Top = 51.000000000000060000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTot013OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoTot015: TfrxMemoView
          Left = 2016.000000000000000000
          Top = 102.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTot015OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object Line9: TfrxLineView
          Left = 4.800000000000000000
          Top = 8.500000000000056000
          Width = 1123.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line10: TfrxLineView
          Left = 4.800000000000000000
          Top = 42.500000000000060000
          Width = 1123.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line14: TfrxLineView
          Left = 4.800000000000000000
          Top = 178.500000000000100000
          Width = 1123.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line17: TfrxLineView
          Left = 4.800000000000000000
          Top = 8.500000000000056000
          Height = 170.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line18: TfrxLineView
          Left = 1128.000000000000000000
          Top = 8.500000000000056000
          Height = 170.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line19: TfrxLineView
          Left = 1166.400000000000000000
          Top = 8.500000000000056000
          Height = 170.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line20: TfrxLineView
          Left = 2193.600000000000000000
          Top = 8.500000000000056000
          Height = 170.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line21: TfrxLineView
          Left = 1166.400000000000000000
          Top = 8.500000000000056000
          Width = 1027.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line22: TfrxLineView
          Left = 1166.400000000000000000
          Top = 42.500000000000060000
          Width = 1027.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line23: TfrxLineView
          Left = 1166.400000000000000000
          Top = 178.500000000000100000
          Width = 1027.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line32: TfrxLineView
          Left = 2011.200000000000000000
          Top = 42.500000000000060000
          Height = 136.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line34: TfrxLineView
          Left = 936.000000000000000000
          Top = 42.500000000000060000
          Height = 136.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmo16: TfrxMemoView
          Left = 2016.269020000000000000
          Top = 119.055118110000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmo16OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object rllDebito: TfrxMemoView
          Left = 940.800000000000000000
          Top = 70.677165354330840000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DEBITO]')
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          Left = 9.448818900000000000
          Top = 130.944960000000100000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '005 - ANTECIPA'#199#195'O DE ICMS')
        end
        object Memo89: TfrxMemoView
          Left = 941.102970000000000000
          Top = 130.771653543307200000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[fltAntIcm]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 940.724409450000000000
          Top = 110.740157479999900000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[EST_CRE]')
          ParentFont = False
        end
        object Memo113: TfrxMemoView
          Left = 9.448818900000000000
          Top = 90.755905510000100000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '003 - OUTROS D'#201'BITOS - DIFAL')
        end
        object Memo114: TfrxMemoView
          Left = 941.102970000000000000
          Top = 90.708661417322960000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DEBITO_DIFAL]')
          ParentFont = False
        end
        object Memo119: TfrxMemoView
          Left = 1190.992890000000000000
          Top = 83.149660000000100000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '      Adicional relativo ao FECP')
        end
        object mmoTotFCP: TfrxMemoView
          Left = 2016.000000000000000000
          Top = 83.149606300000010000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTotFCPOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoDeducoes: TfrxMemoView
          Left = 2016.000000000000000000
          Top = 68.031496060000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoDeducoesOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
      end
      object ChildCredito: TfrxChild
        FillType = ftBrush
        Height = 239.913420000000000000
        Top = 714.331170000000000000
        Width = 2208.001426000000000000
        object Memo48: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1104.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'C R E D I T O   D O   I M P O S T O')
        end
        object Memo49: TfrxMemoView
          Left = 1180.800000000000000000
          Top = 17.000000000000000000
          Width = 1008.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'OBSERVACOES')
        end
        object Memo50: TfrxMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '007 - POR ENTRADAS COM CR'#201'DITO DO IMPOSTO')
        end
        object Memo51: TfrxMemoView
          Left = 9.600000000000000000
          Top = 71.055118109999960000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '008 - OUTROS CR'#201'DITOS - AJUSTES')
        end
        object Memo52: TfrxMemoView
          Left = 9.448818900000000000
          Top = 131.149606300000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '011 - ESTORNOS DE D'#201'BITOS')
        end
        object Memo53: TfrxMemoView
          Left = 9.448818900000000000
          Top = 151.181102360000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '012 - SUBTOTAL')
        end
        object Memo54: TfrxMemoView
          Left = 9.448818900000000000
          Top = 171.212598430000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '013 - SALDO CREDOR - PER'#205'ODO ANTERIOR')
        end
        object Memo55: TfrxMemoView
          Left = 9.448818900000000000
          Top = 191.244094490000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '014 - TOTAL')
        end
        object Memo56: TfrxMemoView
          Left = 1180.800000000000000000
          Top = 151.181102362204700000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDAS')
        end
        object Memo57: TfrxMemoView
          Left = 1180.800000000000000000
          Top = 171.212598425196900000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'M'#195'O DE OBRA')
        end
        object Memo58: TfrxMemoView
          Left = 1180.800000000000000000
          Top = 191.244094488189000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FATURAMENTO')
        end
        object mmoTot006: TfrxMemoView
          Left = 940.800000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTot006OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoTot010: TfrxMemoView
          Left = 940.800000000000000000
          Top = 151.181102360000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTot010OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoTot011: TfrxMemoView
          Left = 940.800000000000000000
          Top = 171.212598430000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[ICMANT]')
        end
        object mmoTot012: TfrxMemoView
          Left = 940.800000000000000000
          Top = 191.244094490000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTot012OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object Memo88: TfrxMemoView
          Left = 2016.000000000000000000
          Top = 171.212598425196900000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
        end
        object Memo24: TfrxMemoView
          Left = 2016.000000000000000000
          Top = 151.181102362204700000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_VLRCOV + D_C_VLRCOV]')
        end
        object Memo25: TfrxMemoView
          Left = 2016.000000000000000000
          Top = 191.244094488189000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[F_C_VLRCOV + D_C_VLRCOV]')
        end
        object Line11: TfrxLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1123.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line12: TfrxLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1123.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line13: TfrxLineView
          Left = 4.800000000000000000
          Top = 211.500000000000000000
          Width = 1123.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line15: TfrxLineView
          Left = 4.800000000000000000
          Top = 227.500000000000000000
          Width = 1123.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line24: TfrxLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Height = 219.133890000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line25: TfrxLineView
          Left = 1128.000000000000000000
          Top = 8.500000000000000000
          Height = 219.212598430000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line26: TfrxLineView
          Left = 1166.400000000000000000
          Top = 8.500000000000000000
          Height = 219.212598430000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line27: TfrxLineView
          Left = 2193.600000000000000000
          Top = 8.500000000000000000
          Height = 219.212598425196900000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line28: TfrxLineView
          Left = 1166.400000000000000000
          Top = 8.500000000000000000
          Width = 1027.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line29: TfrxLineView
          Left = 1166.400000000000000000
          Top = 227.527559055118100000
          Width = 1027.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line30: TfrxLineView
          Left = 1166.400000000000000000
          Top = 211.653543307086600000
          Width = 1027.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line31: TfrxLineView
          Left = 2011.200000000000000000
          Top = 42.500000000000000000
          Height = 169.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line33: TfrxLineView
          Left = 1166.400000000000000000
          Top = 42.500000000000000000
          Width = 1027.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line35: TfrxLineView
          Left = 936.000000000000000000
          Top = 42.500000000000000000
          Height = 169.322834650000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo86: TfrxMemoView
          Left = 940.800000000000000000
          Top = 71.055118109999960000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CREDITO]')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          Left = 940.724409450000000000
          Top = 131.149606300000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[EST_DEB]')
          ParentFont = False
        end
        object Memo115: TfrxMemoView
          Left = 9.448818900000000000
          Top = 91.086614169999960000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '009 - OUTROS CR'#201'DITOS - DIFAL')
        end
        object Memo116: TfrxMemoView
          Left = 9.448818900000000000
          Top = 111.118110240000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '010 - OUTROS CR'#201'DITOS - CAT 158')
        end
        object Memo117: TfrxMemoView
          Left = 941.102970000000000000
          Top = 91.086614173228330000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CREDITO_DIFAL]')
          ParentFont = False
        end
        object Memo118: TfrxMemoView
          Left = 941.102362200000000000
          Top = 111.118110240000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CREDITO_CAT158]')
          ParentFont = False
        end
      end
    end
    object qckPaginaDetalhamentoCreditoDebito: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 325.000000000000000000
      PaperHeight = 285.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 18.897650000000000000
        Width = 1152.756650000000000000
        object Memo98: TfrxMemoView
          Left = 930.141000000000000000
          Top = 34.000000000000000000
          Width = 213.467780000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA: [fRetAtuPagFisc('#39'FOLAPU'#39')]')
        end
        object Memo99: TfrxMemoView
          Left = 1076.408780000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Memo100: TfrxMemoView
          Left = 932.408780000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo101: TfrxMemoView
          Left = 92.749660000000000000
          Top = 34.000000000000000000
          Width = 669.429870000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
        end
        object Memo102: TfrxMemoView
          Left = 92.749660000000000000
          Top = 51.000000000000000000
          Width = 669.429870000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CGC]')
        end
        object Memo103: TfrxMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object Line107: TfrxLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1141.870190000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line108: TfrxLineView
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 1141.795275590550000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line109: TfrxLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line110: TfrxLineView
          Left = 2193.600000000000000000
          Top = 25.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo104: TfrxMemoView
          Left = 7.559060000000000000
          Top = 34.015770000000010000
          Width = 79.823190000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMPRESA:')
        end
        object Memo105: TfrxMemoView
          Left = 7.559060000000000000
          Top = 51.023622050000000000
          Width = 79.823190000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CGC:')
        end
        object Line112: TfrxLineView
          Left = 1146.977120000000000000
          Top = 26.456710000000000000
          Height = 68.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 41.677180000000000000
        Top = 181.417440000000000000
        Width = 1152.756650000000000000
        object Memo106: TfrxMemoView
          Left = 99.267777560000000000
          Top = 19.377950309999990000
          Width = 569.499320000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '001 - OUTROS D'#201'BITOS')
          ParentFont = False
        end
        object Memo107: TfrxMemoView
          Left = 831.496600000000000000
          Top = 19.377950309999990000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DEBITO]')
          ParentFont = False
        end
        object Line118: TfrxLineView
          Left = 75.590600000000000000
          Top = 16.999997560000000000
          Width = 936.188976380000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line114: TfrxLineView
          Left = 812.598950000000000000
          Top = 17.007874020000000000
          Height = 24.566929133858300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line115: TfrxLineView
          Left = 1011.779527560000000000
          Height = 41.574803150000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line121: TfrxLineView
          Left = 75.590600000000000000
          Top = 37.519682600000010000
          Width = 936.188976380000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line117: TfrxLineView
          Left = 75.590600000000000000
          Height = 41.574830000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo111: TfrxMemoView
          Left = 330.708661420000000000
          Width = 283.464750000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DETALHAMENTO DE D'#201'BITOS E CR'#201'DITOS')
          ParentFont = False
        end
        object Line130: TfrxLineView
          Left = 75.590551181102400000
          Width = 936.188976380000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 245.669450000000000000
        Width = 1152.756650000000000000
        DataSet = frxDbOutIcmDebito
        DataSetName = 'frxDbOutIcmDebito'
        RowCount = 0
        object frxDbOutIcmDebitoObserv: TfrxMemoView
          Left = 139.842610000000000000
          Width = 665.197280000000000000
          Height = 18.897650000000000000
          DataField = 'Observ'
          DataSet = frxDbOutIcmDebito
          DataSetName = 'frxDbOutIcmDebito'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDbOutIcmDebito."Observ"]')
          ParentFont = False
        end
        object frxDbOutIcmDebitoValor: TfrxMemoView
          Left = 831.496600000000000000
          Width = 172.724409450000000000
          Height = 18.897650000000000000
          DataField = 'Valor'
          DataSet = frxDbOutIcmDebito
          DataSetName = 'frxDbOutIcmDebito'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDbOutIcmDebito."Valor"]')
          ParentFont = False
        end
        object Line111: TfrxLineView
          Left = 75.590600000000000000
          Height = 18.897640240000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line116: TfrxLineView
          Left = 812.598950000000000000
          Height = 18.897640240000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line113: TfrxLineView
          Left = 1011.779527559060000000
          Height = 18.897640240000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 321.260050000000000000
        Width = 1152.756650000000000000
        Child = frxReportJ.Child1
        Stretched = True
        object Memo108: TfrxMemoView
          Left = 99.401574800000000000
          Top = 4.157480309999983000
          Width = 588.396970000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '002 - OUTROS CR'#201'DITOS')
          ParentFont = False
        end
        object Memo109: TfrxMemoView
          Left = 831.496062990000000000
          Top = 4.157480314960651000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CREDITO]')
          ParentFont = False
        end
        object SubReportCredito: TfrxSubreport
          Left = 75.590551180000000000
          Top = 25.677180000000020000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReportJ.Page1
        end
        object Line123: TfrxLineView
          Left = 75.590600000000000000
          Top = 3.779527560000020000
          Width = 936.188976380000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line127: TfrxLineView
          Left = 75.590600000000000000
          Top = 22.456709999999990000
          Width = 936.188976380000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line120: TfrxLineView
          Left = 1011.779527559060000000
          Height = 45.354360000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line122: TfrxLineView
          Left = 812.598950000000000000
          Height = 45.354360000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line119: TfrxLineView
          Left = 75.590551180000000000
          Height = 45.354360000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 11.338590000000000000
        Top = 389.291590000000000000
        Width = 1152.756650000000000000
        object Line128: TfrxLineView
          Left = 75.590551180000000000
          Top = 3.779527559055112000
          Width = 936.188976380000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 423.307360000000000000
        Width = 1152.756650000000000000
        object Memo110: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object Line129: TfrxLineView
          Align = baWidth
          Top = 8.500000000000000000
          Width = 1152.756650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 604.200000000000000000
      PaperHeight = 285.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 15.118105350000000000
        Top = 18.897650000000000000
        Width = 2208.001426000000000000
        DataSet = frxDbOutIcmCredito
        DataSetName = 'frxDbOutIcmCredito'
        RowCount = 0
        object frxDbOutIcmCreditoObserv: TfrxMemoView
          Left = 64.251968500000000000
          Width = 665.196850390000000000
          Height = 18.897650000000000000
          DataField = 'Observ'
          DataSet = frxDbOutIcmCredito
          DataSetName = 'frxDbOutIcmCredito'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDbOutIcmCredito."Observ"]')
          ParentFont = False
        end
        object frxDbOutIcmCreditoValor: TfrxMemoView
          Left = 755.905511810000000000
          Width = 172.724409450000000000
          Height = 18.897650000000000000
          DataField = 'Valor'
          DataSet = frxDbOutIcmCredito
          DataSetName = 'frxDbOutIcmCredito'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDbOutIcmCredito."Valor"]')
          ParentFont = False
        end
        object Line124: TfrxLineView
          Height = 18.897637795275600000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line125: TfrxLineView
          Left = 737.007874020000000000
          Height = 18.897637795275600000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line126: TfrxLineView
          Left = 936.188976380000000000
          Height = 18.897637795275600000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
    end
  end
  object frxDbOutIcmCredito: TfrxDBDataset
    UserName = 'frxDbOutIcmCredito'
    CloseDataSource = False
    DataSet = cdsOutIcmDebito
    BCDToCurrency = False
    Left = 365
    Top = 8
  end
  object frxDbOutIcmDebito: TfrxDBDataset
    UserName = 'frxDbOutIcmDebito'
    CloseDataSource = False
    DataSet = cdsOutIcmCredito
    BCDToCurrency = False
    Left = 405
    Top = 7
  end
  object cdsOutIcmCredito: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 408
    Top = 56
    object cdsOutIcmCreditoObserv: TStringField
      FieldName = 'Observ'
      Size = 50
    end
    object cdsOutIcmCreditoValor: TFloatField
      FieldName = 'Valor'
    end
  end
  object cdsOutIcmDebito: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 56
    object cdsOutIcmDebitoObserv: TStringField
      FieldName = 'Observ'
      Size = 50
    end
    object cdsOutIcmDebitoValor: TFloatField
      FieldName = 'Valor'
    end
  end
end
